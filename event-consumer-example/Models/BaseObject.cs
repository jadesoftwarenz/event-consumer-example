using System.Text.Json.Serialization;

namespace KafkaConsumerService.Models
{
    public class BaseObject
    {
        public BaseObject() { }

        [JsonPropertyName("Jade.oid")]
        public string? Oid { get; set; }

        [JsonPropertyName("Jade.instanceId")]
        public int InstanceId { get; set; }

        [JsonPropertyName("Jade.edition")]
        public int Edition { get; set; }
    }
}
