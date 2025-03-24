using Confluent.Kafka;

namespace KafkaConsumerService.Kafka
{
    public static class KafkaExtensions
    {
        public static IServiceCollection AddKafkaConsumer(this IServiceCollection services, HostBuilderContext context)
        {
            services.AddSingleton(_ =>
            {
                var config = context.Configuration;

                var consumerConfig = config.GetSection("KafkaConfig").Get<ConsumerConfig>();
                var consumer = new ConsumerBuilder<string, string>(consumerConfig).Build();

                // Add Broker, had to be added to get non local '[::]:9092' defaults to work
                var boostrapServer = config.GetSection("KafkaConfig")["BootstrapServers"];
                consumer.AddBrokers(boostrapServer);  
                // Console.WriteLine("Kafka boostrap.servers is subscribing to broker = " + boostrapServer.ToString());

                // Subscribe to the topic 
                var topic = config.GetSection("KafkaConfig")["MyTopic"];
                consumer.Subscribe(topic);
                // Console.WriteLine("Kafka Consumer is subscribing to Topic = " + topic.ToString());                  

                return consumer;
            });

            //Add the MessageConsumer as a hosted service, injecting the logger, consumer and sender
            services.AddHostedService<KafkaMessageConsumer>();

            return services;
        }
    }
}
