namespace KafkaConsumerService
{
    public interface IMessageProcessor
    {
        void ProcessMessage(string message);
    }
}
