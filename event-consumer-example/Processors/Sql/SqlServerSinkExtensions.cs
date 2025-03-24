namespace KafkaConsumerService.Processors.Sql
{
    public static class SqlServerSinkExtensions
    {
        public static IServiceCollection AddSqlServerSink(this IServiceCollection services, HostBuilderContext context)
        {
            SqlServerSinkConfiguration config = context.Configuration.GetSection("SqlConfig").Get<SqlServerSinkConfiguration>() ??
                new SqlServerSinkConfiguration();

            services.AddSingleton(config);
            services.AddSingleton<SinkConfiguration>(config);

            services.AddTransient<SqlAccountEventProcessor>();
            services.AddTransient<SqlCustomerEventProcessor>();
            services.AddTransient<SqlDistrictEventProcessor>();
            services.AddTransient<SqlTransactionEventProcessor>();

            services.AddSingleton((services) =>
            {
                return new SqlServerContext(
                    config,
                    services.GetService<ILogger<SqlServerContext>>()!
                );
            });

            return services;
        }
    }
}
