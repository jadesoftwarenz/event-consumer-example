namespace KafkaConsumerService.Processors.Snowflake
{
    public static class SnowflakeSinkExtensions
    {
        public static IServiceCollection AddSnowflakeSink(this IServiceCollection services, HostBuilderContext context)
        {
            SnowflakeSinkConfiguration config = context.Configuration.GetSection("SnowflakeConfig").Get<SnowflakeSinkConfiguration>() ??
                new SnowflakeSinkConfiguration();

            services.AddSingleton(config);
            services.AddSingleton<SinkConfiguration>(config);

            services.AddTransient<SnowflakeAccountEventProcessor>();
            services.AddTransient<SnowflakeCustomerEventProcessor>();
            services.AddTransient<SnowflakeDistrictEventProcessor>();
            services.AddTransient<SnowflakeTransactionEventProcessor>();

            services.AddSingleton((services) =>
            {
                return new SnowflakeContext(
                    config,
                    services.GetService<ILogger<SnowflakeContext>>()!
                );
            });

            return services;
        }
    }
}
