using Azure.Messaging.EventHubs;
using Azure.Messaging.EventHubs.Consumer;
using Azure.Storage.Blobs;

namespace KafkaConsumerService.EventHubs
{
    public static class EventHubsExtensions
    {
        public static IServiceCollection AddEventHubsConsumer(this IServiceCollection services, HostBuilderContext context)
        {
            // extract config details here
            var config = context.Configuration.GetSection("EventHubConfig").Get<EventHubConfiguration>() ??
                throw new Exception("No configuration available for Event Hub consumer");

            // register any classes required by the Event Hub consumer here
            // e.g the Event Hub Client
            services.AddSingleton((services) =>
            {
                return new EventProcessorClient(
                    new BlobContainerClient(config.StorageConnectionString, config.StorageContainer),
                    config.ConsumerGroup ?? EventHubConsumerClient.DefaultConsumerGroupName,
                    config.ConnectionString, config.HubName);
            });

            services.AddHostedService<EventHubMessageConsumer>();

            return services;
        }
    }
}
