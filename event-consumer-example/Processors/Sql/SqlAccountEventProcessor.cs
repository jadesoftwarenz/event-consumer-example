using KafkaConsumerService.Models;
using Microsoft.Data.SqlClient;

namespace KafkaConsumerService.Processors.Sql
{
    public class SqlAccountEventProcessor(
        SqlServerContext _context,
        ILogger<SqlAccountEventProcessor> _logger) : BaseEventProcessor(_logger)
    {
        public override void ProcessEvent(string jsonPayload)
        {
            var payload = Deserialize<Payload<AccountObject>>(jsonPayload);
            var accountObj = payload?.Object;
            if (accountObj == null) return;

            switch (payload!.EventType)
            {
                case EventTypes.ObjectCreated:
                    InsertAccountObject(accountObj, true);
                    break;
                case EventTypes.ObjectUpdated:
                    UpdateAccountObject(accountObj, true);
                    break;
                case EventTypes.ObjectDeleted:
                    DeleteAccountObject(accountObj);
                    break;
                default:
                    _logger.LogWarning("Unsupported Account EventType: {EventType}", payload!.EventType);
                    break;
            }
        }

        private void InsertAccountObject(AccountObject accountObj, bool handleDupKey)
        {
            const string query = @"INSERT INTO [BankModelSchema].[Account]
                (InstanceId, Active, Date, DistrictId, Frequency, Id, MyBank, MyDistrict)
                VALUES (@InstanceId, @Active, @Date, @DistrictId, @Frequency, @Id, @MyBank, @MyDistrict)";

            using var command = new SqlCommand(query);
            AddAccountParameters(command, accountObj);

            var instanceId = accountObj.InstanceId;

            _context.ExecuteQuery(instanceId, command, "InsertAccountObject",
                handleDupKey ? new Action(() => UpdateAccountObject(accountObj, false)) : null);
        }

        private void UpdateAccountObject(AccountObject accountObj, bool handleNoRowAffected)
        {
            const string query = @"UPDATE [BankModelSchema].[Account]
                SET Active = @Active, Date = @Date, DistrictId = @DistrictId, Frequency = @Frequency, 
                Id = @Id, MyBank = @MyBank, MyDistrict = @MyDistrict 
                WHERE InstanceId = @InstanceId";

            using var command = new SqlCommand(query);
            AddAccountParameters(command, accountObj);

            var instanceId = accountObj.InstanceId;

            _context.ExecuteQuery(instanceId, command, "UpdateAccountObject", null,
                handleNoRowAffected ? new Action(() => InsertAccountObject(accountObj, false)) : null);
        }

        private void DeleteAccountObject(AccountObject accountObj)
        {
            const string query = @"DELETE FROM [BankModelSchema].[Account] WHERE InstanceId = @InstanceId";

            using var command = new SqlCommand(query);
            command.Parameters.AddWithValue("@InstanceId", accountObj.InstanceId);

            var instanceId = accountObj.InstanceId;

            _context.ExecuteQuery(instanceId, command, "DeleteAccountObject", null,
                () => _logger.LogWarning("Operation DeleteAccountObject: No record found or deleted, InstanceId: {id}", instanceId));
        }

        private static void AddAccountParameters(SqlCommand command, AccountObject accountObj)
        {
            command.Parameters.AddWithValue("@InstanceId", accountObj.InstanceId);
            command.Parameters.AddWithValue("@Active", accountObj.Active);
            command.Parameters.AddWithValue("@Date", accountObj.Date);
            command.Parameters.AddWithValue("@DistrictId", accountObj.DistrictId);
            command.Parameters.AddWithValue("@Frequency", accountObj.Frequency);
            command.Parameters.AddWithValue("@Id", accountObj.Id);
            command.Parameters.AddWithValue("@MyBank", accountObj.MyBank?.InstanceId);
            command.Parameters.AddWithValue("@MyDistrict", accountObj.MyDistrict?.InstanceId);
        }
    }
}
