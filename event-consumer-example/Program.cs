using KafkaConsumerService.EventHubs;
using KafkaConsumerService.Kafka;
using KafkaConsumerService.Models;
using KafkaConsumerService.Processors.Console;
using KafkaConsumerService.Processors.Snowflake;
using KafkaConsumerService.Processors.Sql;
using NLog;
using NLog.Extensions.Logging;

namespace KafkaConsumerService
{
    static class Program
    {
        private static void Main(string[] args)
        {
            ConfigureNLog();

            // Set up a long running service
            Host.CreateDefaultBuilder(args)
                .ConfigureServices(
                    (context, services) =>
                    {
                        // Determine which consumer to use from configuration
                        ConfigureConsumer(context, services);

                        // Determine which sink to use from configuration
                        ConfigureSink(context, services);

                        // core classes unrelated to specific technologies
                        services.AddTransient<EventProcessorFactory>();
                        services.AddSingleton<IMessageProcessor, JadeMessageProcessor>();
                    })
                .ConfigureLogging(
                    (context, logBuilder) =>
                    {
                        logBuilder.ClearProviders()
                            .SetMinimumLevel(Microsoft.Extensions.Logging.LogLevel.Trace)
                            .AddNLog(LogManager.Configuration);
                    }
                )
                .Build()
                .Run();
        }

        /// <summary>
        /// Sets up NLog to read its configuration from the NLOG section of the appsettings.json file 
        /// Normally NLog reads from the nlog.config file.
        /// </summary>
        private static void ConfigureNLog()
        {
            var config = new ConfigurationBuilder()
                        .AddJsonFile("appsettings.json", optional: true, reloadOnChange: true)
                        .Build();
            LogManager.Configuration = new NLogLoggingConfiguration(config.GetSection("NLog"));
        }

        private static void ConfigureConsumer(HostBuilderContext context, IServiceCollection services)
        {
            var consumerTypeStr = context.Configuration["ConsumerType"];

            if (!Enum.TryParse<ConsumerNames>(consumerTypeStr, out var consumerType))
            {
                throw new Exception($"Invalid ConsumerType specified in configuration: {consumerTypeStr}");
            }

            switch (consumerType)
            {
                case ConsumerNames.Kafka:
                    services.AddKafkaConsumer(context);
                    break;
                case ConsumerNames.EventHubs:
                    services.AddEventHubsConsumer(context);
                    break;
                default:
                    throw new Exception($"Invalid ConsumerType specified in configuration: {consumerType}");
            }
        }

        private static void ConfigureSink(HostBuilderContext context, IServiceCollection services)
        {
            var sinkTypeStr = context.Configuration["SinkType"];

            if (!Enum.TryParse<SinkNames>(sinkTypeStr, out var sinkType))
            {
                throw new Exception($"Invalid SinkType specified in configuration: {sinkTypeStr}");
            }

            switch (sinkType)
            {
                case SinkNames.SqlServer:
                    services.AddSqlServerSink(context);
                    break;
                case SinkNames.Snowflake:
                    services.AddSnowflakeSink(context);
                    break;
                case SinkNames.Console:
                    services.AddConsoleSink();
                    break;
                default:
                    throw new Exception($"Invalid SinkType specified in configuration: {sinkType}");
            }
        }
    }
}
