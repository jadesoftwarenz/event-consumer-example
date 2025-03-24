using System.Text.Json;

namespace KafkaConsumerService.Processors
{
    public abstract class BaseEventProcessor(ILogger _logger)
    {
        private readonly JsonSerializerOptions _options = new()
        {
            PropertyNamingPolicy = JsonNamingPolicy.CamelCase,
            PropertyNameCaseInsensitive = true
        };

        public abstract void ProcessEvent(string jsonPayload);

        protected T? Deserialize<T>(string jsonPayload)
        {
            try
            {
                return JsonSerializer.Deserialize<T>(jsonPayload, _options);
            }
            catch (JsonException ex)
            {
                _logger.LogError(ex, "Failed to deserialize JSON payload");
                return default;
            }
        }
    }
}
