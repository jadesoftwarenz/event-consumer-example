using System.Text.Json.Serialization;

namespace KafkaConsumerService.Models
{
    public class TransactionObject : BaseObject
    {
        public TransactionObject() { }

        [JsonPropertyName("account_id")]
        public string? AccountId { get; set; }

        [JsonPropertyName("amount")]
        public double Amount { get; set; }

        [JsonPropertyName("id")]
        public string? Id { get; set; }

        [JsonPropertyName("k_symbol")]
        public string? KSymbol { get; set; }

        [JsonPropertyName("operation")]
        public string? Operation { get; set; }

        [JsonPropertyName("otherAccount")]
        public string? OtherAccount { get; set; }

        [JsonPropertyName("otherBank")]
        public string? OtherBank { get; set; }

        [JsonPropertyName("timestamp")]
        public DateTime Timestamp { get; set; }

        [JsonPropertyName("type")]
        public string? Type { get; set; }

        [JsonPropertyName("myAccount")]
        public BaseObject? MyAccount { get; set; }

        [JsonPropertyName("myBank")]
        public BaseObject? MyBank { get; set; }
    }
}
