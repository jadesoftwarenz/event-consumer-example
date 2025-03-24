using KafkaConsumerService.Models;
using System.Text.Json;

namespace KafkaConsumerService
{
    public class JadeMessageProcessor(
        ILogger<JadeMessageProcessor> _logger,
        EventProcessorFactory _factory) : IMessageProcessor
    {
        private readonly JsonSerializerOptions _options = new()
        {
            PropertyNamingPolicy = JsonNamingPolicy.CamelCase,
            PropertyNameCaseInsensitive = true
        };

        public void ProcessMessage(string json)
        {
            _logger.LogInformation("SendMessage: Sending");
            var evnt = JsonSerializer.Deserialize<BaseEvent>(json, _options);
            if (evnt == null || evnt.ObjectType == "JadeSoftware.ObjectStorage.TransactionCommitted")
            {
                _logger.LogInformation("SendMessage: No Packet to process");
                return;
            }

            try
            {
                if (evnt.ObjectType == null)
                {
                    throw new Exception("Event received with no ObjectType specified. Unable to process.");
                }

                // find the right processor
                var processor = _factory.GetProcessor(evnt.ObjectType);
                processor.ProcessEvent(json);

            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "SendMessage: Failed");
            }
        }
    }
}
