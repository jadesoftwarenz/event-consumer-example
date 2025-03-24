using Microsoft.Data.SqlClient;

namespace KafkaConsumerService.Processors.Sql
{
    public class SqlServerContext(SqlServerSinkConfiguration _config, ILogger<SqlServerContext> _logger)
    {
        public void ExecuteQuery(int instanceId, SqlCommand command, string operation,
            Action? onDupKeyError = null, Action? onNoRowAffected = null)
        {
            try
            {
                using var connection = new SqlConnection(_config.ConnectionString);
                command.Connection = connection;
                connection.Open();
                int rowCount = command.ExecuteNonQuery();

                _logger.LogInformation("SQL {Operation} succeeded", operation);

                if (rowCount > 0)
                {
                    _logger.LogInformation("Success! SQL Operation: {Operation}, InstanceId: {InstanceId}", operation, instanceId);
                }

                if (rowCount == 0)
                {
                    _logger.LogWarning("SQL {Operation} affected no rows", operation);
                    onNoRowAffected?.Invoke();
                }
            }
            catch (SqlException ex)
            {
                _logger.LogError(ex, "SQL {Operation} failed", operation);
                if (ex.Number == 2601 || ex.Number == 2627)
                {
                    _logger.LogWarning("SQL {Operation} resulted in a duplicate key error", operation);
                    onDupKeyError?.Invoke();
                }
            }
        }
    }
}
