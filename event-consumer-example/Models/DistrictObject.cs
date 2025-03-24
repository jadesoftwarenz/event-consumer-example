using System.Text.Json.Serialization;

namespace KafkaConsumerService.Models
{
    public class DistrictObject : BaseObject
    {
        public DistrictObject() { }

        [JsonPropertyName("city")]
        public string? City { get; set; }

        [JsonPropertyName("division")]
        public string? Division { get; set; }

        [JsonPropertyName("id")]
        public int? Id { get; set; }

        [JsonPropertyName("region")]
        public string? Region { get; set; }

        [JsonPropertyName("stateAbbrev")]
        public string? StateAbbrev { get; set; }

        [JsonPropertyName("stateName")]
        public string? StateName { get; set; }

        [JsonPropertyName("myBank")]
        public BaseObject? MyBank { get; set; }
    }
}
