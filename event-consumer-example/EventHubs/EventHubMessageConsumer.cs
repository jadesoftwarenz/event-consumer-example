using Azure.Messaging.EventHubs;
using Azure.Messaging.EventHubs.Processor;

namespace KafkaConsumerService.EventHubs
{
    public class EventHubMessageConsumer(
        EventProcessorClient _client,
        IMessageProcessor _processor,
        ILogger<EventHubMessageConsumer> _logger) : BackgroundService
    {
        protected override async Task ExecuteAsync(CancellationToken stoppingToken)
        {
            _client.ProcessEventAsync += ProcessEventHandler;
            _client.ProcessErrorAsync += ProcessErrorHandler;

            // start the processor and then wait for a signal to stop
            await _client.StartProcessingAsync(stoppingToken);
            stoppingToken.WaitHandle.WaitOne();
        }

        public override async Task StopAsync(CancellationToken cancellationToken)
        {
            // stop the client and clean up any resources
            await _client.StopProcessingAsync(cancellationToken);
            await base.StopAsync(cancellationToken);
        }

        private async Task ProcessEventHandler(ProcessEventArgs e)
        {
            if (e.CancellationToken.IsCancellationRequested)
                return;

            try
            {
                // process the incoming message
                _processor.ProcessMessage(e.Data.EventBody.ToString());

                // update the chekcpoint to mark this message as processed - doing this
                // every message isn't super performant but is acceptable in this context
                await e.UpdateCheckpointAsync(e.CancellationToken);
            }
            catch (Exception ex)
            {
                // don't allow a failure to blow out the whole process
                _logger.LogError(ex, "Failed to process message. Message ID: {id}", e.Data.MessageId);
            }

            return;
        }

        private Task ProcessErrorHandler(ProcessErrorEventArgs e)
        {
            // log the error but don't rethrow to avoid killing the process
            _logger.LogError(e.Exception, "Unhandled exception in Event Hub framework for partition {id}",
                e.PartitionId ?? "n/a");
            return Task.CompletedTask;
        }
    }
}
