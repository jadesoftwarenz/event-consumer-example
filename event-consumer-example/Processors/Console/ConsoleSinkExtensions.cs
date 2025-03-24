namespace KafkaConsumerService.Processors.Console
{
    public static class ConsoleSinkExtensions
    {
        public static IServiceCollection AddConsoleSink(this IServiceCollection services)
        {
            var processor = "KafkaConsumerService.Processors.Console.ConsoleEventProcessor, event-consumer-example";
            var config = new ConsoleSinkConfiguration()
            {
                ClassInfo = new Dictionary<string, ClassInfo>
                {
                    {"BankModelSchema.Account", new ClassInfo{ProcessorClass = processor} },
                    {"BankModelSchema.Customer", new ClassInfo{ProcessorClass = processor} },
                    {"BankModelSchema.District", new ClassInfo{ProcessorClass = processor} },
                    {"BankModelSchema.Transaction", new ClassInfo{ProcessorClass = processor} }
                }
            };

            services.AddSingleton<SinkConfiguration>(config);
            services.AddSingleton<ConsoleEventProcessor>();

            return services;
        }
    }
}
