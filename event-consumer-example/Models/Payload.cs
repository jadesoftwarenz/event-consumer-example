using System.Text.Json.Serialization;

namespace KafkaConsumerService.Models
{
    public class Payload<T> : BaseEvent
    {
        public Payload() { }

        [JsonPropertyName("object")]
        public T? Object { get; set; }
    }
}
