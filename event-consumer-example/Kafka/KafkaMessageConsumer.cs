
using Confluent.Kafka;
using System.Globalization;

namespace KafkaConsumerService.Kafka
{
    /// <summary>
    /// Class <c>MessageConsumer</c> is the Hosted Service that consumes the Kafka topice and sends the data retrieved to wherever
    /// It requires dependent services <c>Confluent.Kafka.IConsumer</c>, <c>ISender</c>, and <c>ILogger</c> 
    /// </summary>
    /// <remarks>
    /// Constructor for <c>MessageConsumer</c>
    /// </remarks>
    /// <param name="_logger">ILogger (NLog in production)</param> 
    /// <param name="_consumer">IConsumer comes from Confluent.Kafka Assembly</param> 
    /// <param name="_sender">ISender is local class </param> 
    public class KafkaMessageConsumer(ILogger<KafkaMessageConsumer> _logger, IConsumer<string, string> _consumer, IMessageProcessor _sender) : BackgroundService
    {

        /// <summary>
        /// Method <c>ExecuteAsync</c> represents an asynchronous task that blocks waiting for an event to be ready. 
        /// When one arrives, this task retrieves the data from the consumer dependency and passes it to the sender class which
        /// sends it to the destination service
        /// </summary>
        /// <param name="stoppingToken">This parameter represents that the task is ending</param> 
        /// <returns>Nothing real</returns>
        protected override async Task ExecuteAsync(CancellationToken stoppingToken)
        {
            await Task.Yield();

            _logger.LogInformation("");

            while (!stoppingToken.IsCancellationRequested)
            {
                ConsumeResult<string, string>? consumeResult;
                try
                {
                    consumeResult = _consumer.Consume(stoppingToken);
                }
                catch (Exception ex)
                {
                    Console.WriteLine(ex);
                    _logger.LogError("Exception Consuming Kafka: {}", ex.Message);
                    break;
                }

                _logger.LogInformation("MessageConsumer: Offset {} Partition {} Production Time (UTC) {}",
                    consumeResult.Offset.ToString(),
                    consumeResult.Partition.Value,
                    consumeResult.Message.Timestamp.UtcDateTime.ToString(CultureInfo.InvariantCulture));

                var payload = ExtractPayload(consumeResult.Message.Value);

                _sender.ProcessMessage(payload);
            }
        }
        /// <summary>
        /// ExtractPayload removes any metadata at the beginning of the string.
        /// Note this assumes the payload is JSON
        /// </summary>
        /// <param name="raw">String retrieved from Kafka</param>
        /// <returns>String which is ready to be processed </returns>
        static string ExtractPayload(string raw)
        {
            // Any prefix to the string (e.g. Windows BOM codes for UTF-8)
            int index = raw.IndexOf('{');
            return index != -1 ? raw[index..] : raw;
        }

        public override void Dispose()
        {
            _consumer.Dispose();
            base.Dispose();
        }
    }

}
