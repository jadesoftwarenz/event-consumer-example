using KafkaConsumerService.Models;
using Microsoft.Data.SqlClient;

namespace KafkaConsumerService.Processors.Sql
{
    public class SqlTransactionEventProcessor(
        SqlServerContext _context,
        ILogger<SqlTransactionEventProcessor> _logger) : BaseEventProcessor(_logger)
    {
        public override void ProcessEvent(string jsonPayload)
        {
            var payload = Deserialize<Payload<TransactionObject>>(jsonPayload);
            var transactionObj = payload?.Object;
            if (transactionObj == null) return;

            switch (payload!.EventType)
            {
                case EventTypes.ObjectCreated:
                    InsertTransactionObject(transactionObj, true);
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

        private void InsertTransactionObject(TransactionObject transactionObj, bool handleDupKey)
        {
            const string query = @"INSERT INTO [BankModelSchema].[Transaction]
                (InstanceId, AccountId, Amount, Id, KSymbol, Operation, OtherAccount, OtherBank, Timestamp, Type, MyAccount, MyBank)
                VALUES (@InstanceId, @AccountId, @Amount, @Id, @KSymbol, @Operation, @OtherAccount,
                @OtherBank, @Timestamp, @Type, @MyAccount, @MyBank)";

            using var command = new SqlCommand(query);
            AddTransactionParameters(command, transactionObj);

            var instanceId = transactionObj.InstanceId;

            _context.ExecuteQuery(instanceId, command, "InsertTransactionObject",
                handleDupKey ? new Action(() => UpdateTransactionObject(transactionObj, false)) : null);
        }

        private void UpdateTransactionObject(TransactionObject transactionObj, bool handleNoRowAffected)
        {
            const string query = @"UPDATE [BankModelSchema].[Transaction]
                SET AccountId = @AccountId, Amount = @Amount, Id = @Id, KSymbol = @KSymbol, Operation = @Operation, OtherAccount = @OtherAccount,
                OtherBank = @OtherBank, Timestamp = @Timestamp, Type = @Type, MyAccount = @MyAccount, MyBank = @MyBank
                WHERE InstanceId = @InstanceId";

            using var command = new SqlCommand(query);
            AddTransactionParameters(command, transactionObj);

            var instanceId = transactionObj.InstanceId;

            _context.ExecuteQuery(instanceId, command, "UpdateTransactionObject", null,
                handleNoRowAffected ? new Action(() => InsertTransactionObject(transactionObj, false)) : null);
        }

        private void DeleteTransactionObject(TransactionObject transactionObj)
        {
            const string query = @"DELETE FROM [BankModelSchema].[Transaction] WHERE InstanceId = @InstanceId";

            using var command = new SqlCommand(query);
            command.Parameters.AddWithValue("@InstanceId", transactionObj.InstanceId);

            var instanceId = transactionObj.InstanceId;

            _context.ExecuteQuery(instanceId, command, "DeleteTransactionObject", null,
                () => _logger.LogWarning("Operation DeleteTransactionObject: No record found or deleted, InstanceId: {id}", instanceId));
        }

        private static void AddTransactionParameters(SqlCommand command, TransactionObject transactionObj)
        {
            command.Parameters.AddWithValue("@InstanceId", transactionObj.InstanceId);
            command.Parameters.AddWithValue("@AccountId", transactionObj.AccountId);
            command.Parameters.AddWithValue("@Amount", transactionObj.Amount);
            command.Parameters.AddWithValue("@Id", transactionObj.Id);
            command.Parameters.AddWithValue("@KSymbol", transactionObj.KSymbol);
            command.Parameters.AddWithValue("@Operation", transactionObj.Operation);
            command.Parameters.AddWithValue("@OtherAccount", transactionObj.OtherAccount);
            command.Parameters.AddWithValue("@OtherBank", transactionObj.OtherBank);
            command.Parameters.AddWithValue("@Timestamp", transactionObj.Timestamp);
            command.Parameters.AddWithValue("@Type", transactionObj.Type);
            command.Parameters.AddWithValue("@MyAccount", transactionObj.MyAccount?.InstanceId);
            command.Parameters.AddWithValue("@MyBank", transactionObj.MyBank?.InstanceId);
        }
    }
}
