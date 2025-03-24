namespace KafkaConsumerService.Models
{
    public enum SinkNames
    {
        SqlServer,
        Snowflake,
        Console
    }

    public enum ConsumerNames
    {
        Kafka,
        EventHubs
    }
}
