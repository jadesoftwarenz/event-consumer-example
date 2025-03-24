namespace KafkaConsumerService.Processors.Sql
{
    public class SqlServerSinkConfiguration : SinkConfiguration
    {
        public string? ConnectionString { get; set; }
    }
}
