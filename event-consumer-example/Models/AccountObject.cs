using System.Text.Json.Serialization;

namespace KafkaConsumerService.Models
{
    public class AccountObject : BaseObject
    {
        public AccountObject() { }

        [JsonPropertyName("active")]
        public bool Active { get; set; }

        [JsonPropertyName("date")]
        public DateTime Date { get; set; }

        [JsonPropertyName("district_id")]
        public int DistrictId { get; set; }

        [JsonPropertyName("frequency")]
        public string? Frequency { get; set; }

        [JsonPropertyName("id")]
        public string? Id { get; set; }

        [JsonPropertyName("myBank")]
        public BaseObject? MyBank { get; set; }

        [JsonPropertyName("myDistrict")]
        public BaseObject? MyDistrict { get; set; }
    }
}
