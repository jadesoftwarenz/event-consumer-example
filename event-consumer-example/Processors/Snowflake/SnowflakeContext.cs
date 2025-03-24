using Snowflake.Data.Client;
using System.Data;

namespace KafkaConsumerService.Processors.Snowflake
{
    public class SnowflakeContext(SnowflakeSinkConfiguration _config, ILogger<SnowflakeContext> _logger)
    {
        public void ExecuteQuery(int instanceId, SnowflakeDbCommand command, string operation, Action? onNoRowAffected = null)
        {
            try
            {
                using var connection = new SnowflakeDbConnection(_config.ConnectionString);
                command.Connection = connection;
                connection.Open();
                int rowCount = command.ExecuteNonQuery();

                _logger.LogInformation("Snowflake {Operation} succeeded", operation);

                if (rowCount > 0)
                {
                    _logger.LogInformation("Success! Snowflake Operation: {Operation}, InstanceId: {InstanceId}", operation, instanceId);
                }

                if (rowCount == 0)
                {
                    _logger.LogWarning("Snowflake {Operation} affected no rows", operation);
                    onNoRowAffected?.Invoke();
                }
            }
            catch (SnowflakeDbException ex)
            {
                _logger.LogError(ex, "Snowflake {Operation} failed", operation);
            }
        }

        public void AddParameter(SnowflakeDbCommand command, string name, object? value, DbType dbType)
        {
            command.Parameters.Add(new SnowflakeDbParameter
            {
                ParameterName = name,
                Value = value,
                DbType = dbType
            });
        }
    }
}
