namespace KafkaConsumerService.Processors.Snowflake
{
    public class SnowflakeSinkConfiguration : SinkConfiguration
    {
        public string? ConnectionString { get; set; }
    }
}
