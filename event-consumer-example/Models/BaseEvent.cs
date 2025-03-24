using System.Text.Json.Serialization;

namespace KafkaConsumerService.Models
{
    public class BaseEvent
    {
        [JsonPropertyName("eventId")]
        public string? EventId { get; set; }

        [JsonPropertyName("schemaId")]
        public string? SchemaId { get; set; }

        [JsonPropertyName("eventType")]
        public string? EventType { get; set; }

        [JsonPropertyName("eventTime")]
        public DateTime EventTime { get; set; }

        [JsonPropertyName("contentType")]
        public string? ContentType { get; set; }

        [JsonPropertyName("TransactionId")]
        public int TransactionId { get; set; }

        [JsonPropertyName("objectType")]
        public string? ObjectType { get; set; }
    }
}
