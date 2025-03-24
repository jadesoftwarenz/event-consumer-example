#  event-consumer-example
This program is a .NET-based Kafka consumer service designed to process messages from message brokers and write them to various data sinks. 
It uses a configurable architecture to support different combinations of message consumers (Kafka or Azure Event Hubs) and data sinks (SQL Server DB, and Snowflake DB or Console). The program incorporates dependency injection, logging, and long-running service management.
- Dynamic Consumer Selection: Configures the service to use either Kafka or Azure Event Hubs for message consumption based on the ConsumerType specified in app settings.
- Dynamic Sink Selection: Configures the target output destination, such as SQL Server, Snowflake, or Console, based on the SinkType specified in app settings.



#  Setting Up JADE, JadeEventProducer Application and Running the event-consumer-example application
The Consumer application operates locally on your PC to consume events sent from a local JADE System to a Kafka or EventHubs instance.  The Consumer application will sink events, to either SQL, Snowflake or a local Console window.


## 1.	Clone the Consumer GIT Repo
Clone the event-consumer-example repository containing the Consumer application, and build the application.
https://github.com/jadesoftwarenz/event-consumer-example


## 2.	Configure the Consumer Application
	
Open the appsettings.json file and:
- Choose the ConsumerType and SinkType that you wish to use
- ConsumerType options are Kafka or EventHubs
- SinkType options are SQL or Snowflake or Console

Provide the necessary connection details for your chosen ConsumerType and SinkType.  Examples are provided.


## 3.	Configure the Kafka or EventHubs Broker 
Create a Topic (Kafka) or Table (EventHubs) called **JadeAllEvents** - we suggest using 4 partitions and 1 day expiration time for the events

**Kafka**
Kafka can be installed locally on Windows, using WSL2 Linux, and then run alongside the JADE system, the JadeEventProducer and this Consumer application. A guide can be found here:  https://www.confluent.io/blog/set-up-and-run-kafka-on-windows-linux-wsl-2/

Alternatively, Kafka can be run in the cloud through various providers.
Confluent offers free trial accounts for 30-days, and is a quick way to setup a Kafka instance.  For more information, see  https://www.confluent.io/

**EventHubs**
Azure Eventhubs - https://azure.microsoft.com/en-us/products/event-hubs
You will also need to configure an Azure Blob Storage account, to store the EventHub 'checkpoint' to which this Consumer app has read up to.  Note - you can delete this Blob instance to start Consuming at the beginning of event stream again.


## 4.  Configure the SinkType
**Snowflake DB**
Snowflake offers free 30 day trials and is a quick way to setup a database.  For more information, see https://www.snowflake.com/
Run .\schemas\DBSchema-Snowflake.sql to initialise the database
Take note of ACCOUNT=account-identifier; USER=username; PASSWORD=password settings for the ConnectionString in appsettings.json.  Note that account-identifier, requires the '-' separator in between the two identifying name parameters.

**SQL Server** 
This can a be local or Azure cloud SQL instance.  Set connection string as appropriate
Run .\schemas\DBSchema-SqlServerDataSender.sql to initialise the database

**Console **
No setup required, events will be logged to the application's Console.

## 5.  Configure JADE to JadeEventProducer, to produce Events to chosen Broker
**JADE needs to be at least version 22.0.04**

- Load \schemas\Jade\BankModelSchema.scm and \schemas\Jade\BankModelSchema.ddx
- Provide the correct location to the script BankModelSchema::JadeScript::loadData for the \schemas\Jade\DataFiles directory
- Add INI settings as per \schemas\Jade\JadeChangeCapture.ini
- Run BankModelSchema::JadeScript::generateDesc()   -  a JADE restart maybe required if [PersistentDb].UseJournalDescriptions=false
- Restart JADE, if required     

**Acquire the JadeEventProducer.exe application**
- Configure the provided JadeEventProducer.json configuration file (see the EventHubs and Kafka examples) for the chosen Broker type and to point to \schemas\Jade\JadeTopics.json (C:\\JadeEventStreamingDemo\\Configuration\\JadeTopics.json)

**Run JadeEventProducer.exe JadeEventProducer.json *YourChosenProducerName*** - Note: you can run multiple copies.  Give each copy a unique name.

For more information see:
https://secure.jadeworld.com/developer-centre/Jade2022/OnlineDocumentation/#resources/eventstreaming


## 6. Checks before starting the Consumer application
**Before starting the Consumer program:**
- Ensure that your Kafka or EventHubs event broker is configured and running 
- Confirm that the JadeEventProducer is running
- Ensure that the Consumer appsettings.json is configured correctly

## 7.	Run the Consumer application
Run the event-consumer-example.exe from CMD, Explorer or Powershell
Now the Consumer app is running, run JadeScript BankModelSchema::JadeScript::loadData, to start sending data through the Event Stream.

- As data is created by JADE and transactions committed, you will see the JadeChangeCapture application create output .dat files to the ChangeCapture directory. 
- These capture files will then be moved to the 'processed' directory by the JadeEventProducer.exe as Events are 'produced' (or sent) to the Kafka or EventHub instance.  
- These Events will then be 'consumed' by the Consumer application and 'sinked' to the choose Database or written to the Console.


