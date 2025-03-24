namespace KafkaConsumerService.EventHubs
{
    public class EventHubConfiguration
    {
        public string? ConnectionString { get; set; }

        public string? HubName { get; set; }

        public string? StorageConnectionString { get; set; }

        public string? StorageContainer { get; set; }

        public string? ConsumerGroup { get; set; }
    }
}
