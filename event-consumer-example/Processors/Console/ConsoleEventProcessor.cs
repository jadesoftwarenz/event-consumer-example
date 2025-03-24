namespace KafkaConsumerService.Processors.Console
{
    /// <summary>
    /// Simple processor class that just writes the incoming message to the console
    /// </summary>
    /// <param name="_logger"></param>
    public class ConsoleEventProcessor(ILogger<ConsoleEventProcessor> _logger) : BaseEventProcessor(_logger)
    {
        public override void ProcessEvent(string jsonPayload)
        {
            System.Console.WriteLine(jsonPayload);
        }
    }
}
