using KafkaConsumerService.Models;
using Snowflake.Data.Client;
using System.Data;

namespace KafkaConsumerService.Processors.Snowflake
{
    public class SnowflakeTransactionEventProcessor(
        SnowflakeContext _context,
        ILogger<SnowflakeTransactionEventProcessor> _logger) : BaseEventProcessor(_logger)
    {
        public override void ProcessEvent(string jsonPayload)
        {
            var payload = Deserialize<Payload<TransactionObject>>(jsonPayload);
            var transactionObj = payload?.Object;
            if (transactionObj == null) return;

            switch (payload!.EventType)
            {
                case EventTypes.ObjectCreated:
                    InsertTransactionObject(transactionObj);
                    break;
                case EventTypes.ObjectUpdated:
                    UpdateTransactionObject(transactionObj, true);
                    break;
                case EventTypes.ObjectDeleted:
                    DeleteTransactionObject(transactionObj);
                    break;
                default:
                    _logger.LogWarning("Unsupported Transaction EventType: {EventType}", payload!.EventType);
                    break;
            }
        }

        private void InsertTransactionObject(TransactionObject transactionObj)
        {
            var query = @"INSERT INTO BankModelSchema.Transaction (
                            InstanceId, AccountId, Amount, Id, KSymbol, Operation, OtherAccount, OtherBank, Timestamp, Type, MyAccount, MyBank
                        ) VALUES (
                            ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?
                        )";

            using var command = new SnowflakeDbCommand();
            command.CommandText = query;

            _context.AddParameter(command, "1", transactionObj.InstanceId, DbType.Int64);
            _context.AddParameter(command, "2", transactionObj.AccountId, DbType.String);
            _context.AddParameter(command, "3", transactionObj.Amount, DbType.Double);
            _context.AddParameter(command, "4", transactionObj.Id, DbType.String);
            _context.AddParameter(command, "5", transactionObj.KSymbol ?? (object)DBNull.Value, DbType.String);
            _context.AddParameter(command, "6", transactionObj.Operation ?? (object)DBNull.Value, DbType.String);
            _context.AddParameter(command, "7", transactionObj.OtherAccount ?? (object)DBNull.Value, DbType.String);
            _context.AddParameter(command, "8", transactionObj.OtherBank ?? (object)DBNull.Value, DbType.String);
            _context.AddParameter(command, "9", transactionObj.Timestamp, DbType.DateTime);
            _context.AddParameter(command, "10", transactionObj.Type ?? (object)DBNull.Value, DbType.String);
            _context.AddParameter(command, "11", transactionObj.MyAccount?.InstanceId, DbType.Int64);
            _context.AddParameter(command, "12", transactionObj.MyBank?.InstanceId, DbType.Int64);

            var instanceId = transactionObj.InstanceId;

            _context.ExecuteQuery(instanceId, command, "InsertTransactionObject");
        }

        private void UpdateTransactionObject(TransactionObject transactionObj, bool handleNoRowAffected)
        {
            var query = @"UPDATE BankModelSchema.Transaction
                        SET AccountId = ?, Amount = ?, Id = ?, KSymbol = ?, Operation = ?, OtherAccount = ?,
                            OtherBank = ?, Timestamp = ?, Type = ?, MyAccount = ?, MyBank = ?
                        WHERE InstanceId = ?";

            using var command = new SnowflakeDbCommand();
            command.CommandText = query;

            _context.AddParameter(command, "1", transactionObj.AccountId, DbType.String);
            _context.AddParameter(command, "2", transactionObj.Amount, DbType.Double);
            _context.AddParameter(command, "3", transactionObj.Id, DbType.String);
            _context.AddParameter(command, "4", transactionObj.KSymbol ?? (object)DBNull.Value, DbType.String);
            _context.AddParameter(command, "5", transactionObj.Operation ?? (object)DBNull.Value, DbType.String);
            _context.AddParameter(command, "6", transactionObj.OtherAccount ?? (object)DBNull.Value, DbType.String);
            _context.AddParameter(command, "7", transactionObj.OtherBank ?? (object)DBNull.Value, DbType.String);
            _context.AddParameter(command, "8", transactionObj.Timestamp, DbType.DateTime);
            _context.AddParameter(command, "9", transactionObj.Type ?? (object)DBNull.Value, DbType.String);
            _context.AddParameter(command, "10", transactionObj.MyAccount?.InstanceId, DbType.Int64);
            _context.AddParameter(command, "11", transactionObj.MyBank?.InstanceId, DbType.Int64);
            _context.AddParameter(command, "12", transactionObj.InstanceId, DbType.Int64);

            var instanceId = transactionObj.InstanceId;

            _context.ExecuteQuery(instanceId, command, "UpdateTransactionObject",
                handleNoRowAffected ? new Action(() => InsertTransactionObject(transactionObj)) : null);
        }

        private void DeleteTransactionObject(TransactionObject transactionObj)
        {
            var query = @"DELETE FROM BankModelSchema.Transaction WHERE InstanceId = ?";

            using var command = new SnowflakeDbCommand();
            command.CommandText = query;

            _context.AddParameter(command, "1", transactionObj.InstanceId, DbType.Int64);

            var instanceId = transactionObj.InstanceId;

            _context.ExecuteQuery(instanceId, command, "DeleteTransactionObject",
                () => _logger.LogWarning("Operation DeleteTransactionObject: No record found or deleted, InstanceId: {InstanceId}", instanceId));
        }
    }
}
