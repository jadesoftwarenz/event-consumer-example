using KafkaConsumerService.Processors;

namespace KafkaConsumerService
{
    public class EventProcessorFactory(
        IServiceProvider _services,
        SinkConfiguration _configuration)
    {
        public BaseEventProcessor GetProcessor(string eventType)
        {
            string transformedType = eventType.Replace("::", ".");
            // look up the processor class for this event
            string? processor = (_configuration.ClassInfo![transformedType ?? string.Empty]?.ProcessorClass) ??
                throw new Exception("No processor found for object type: " + transformedType);

            Type t = Type.GetType(processor) ?? throw new Exception("Unable to find type with name " + processor);
            var result = _services.GetService(t) as BaseEventProcessor ??
                throw new Exception("No service registered for type " + processor);

            return result;
        }
    }
}
