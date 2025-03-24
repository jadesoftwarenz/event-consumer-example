namespace KafkaConsumerService.Processors
{
    public abstract class SinkConfiguration
    {
        public Dictionary<string, ClassInfo>? ClassInfo { get; set; }
    }

    public class ClassInfo
    {
        public string? ProcessorClass { get; set; }
    }
}
