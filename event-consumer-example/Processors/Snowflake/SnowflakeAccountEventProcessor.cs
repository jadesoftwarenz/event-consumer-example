using KafkaConsumerService.Models;
using Snowflake.Data.Client;
using System.Data;

namespace KafkaConsumerService.Processors.Snowflake
{
    public class SnowflakeAccountEventProcessor(
        SnowflakeContext _context,
        ILogger<SnowflakeAccountEventProcessor> _logger) : BaseEventProcessor(_logger)
    {
        public override void ProcessEvent(string jsonPayload)
        {
            var payload = Deserialize<Payload<AccountObject>>(jsonPayload);
            var accountObj = payload?.Object;
            if (accountObj == null) return;

            switch (payload!.EventType)
            {
                case EventTypes.ObjectCreated:
                    InsertAccountObject(accountObj);
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

        private void InsertAccountObject(AccountObject accountObj)
        {
            var query = @"INSERT INTO BankModelSchema.Account(
                            InstanceId, Active, Date, DistrictId, Frequency, Id, MyBank, MyDistrict
                        ) VALUES (
                            ?, ?, ?, ?, ?, ?, ?, ?
                        )";

            using var command = new SnowflakeDbCommand();
            command.CommandText = query;

            _context.AddParameter(command, "1", accountObj.InstanceId, DbType.Int64);
            _context.AddParameter(command, "2", accountObj.Active, DbType.Boolean);
            _context.AddParameter(command, "3", accountObj.Date, DbType.DateTime);
            _context.AddParameter(command, "4", accountObj.DistrictId, DbType.Int64);
            _context.AddParameter(command, "5", accountObj.Frequency, DbType.String);
            _context.AddParameter(command, "6", accountObj.Id, DbType.String);
            _context.AddParameter(command, "7", accountObj.MyBank?.InstanceId, DbType.Int64);
            _context.AddParameter(command, "8", accountObj.MyDistrict?.InstanceId, DbType.Int64);

            var instanceId = accountObj.InstanceId;

            _context.ExecuteQuery(instanceId, command, "InsertAccountObject");
        }

        private void UpdateAccountObject(AccountObject accountObj, bool handleNoRowAffected)
        {
            var query = @"UPDATE BankModelSchema.Account
                SET Active = ?, Date = ?, DistrictId = ?, Frequency = ?, Id = ?, MyBank = ?, MyDistrict = ? 
                WHERE InstanceId = ?";

            using var command = new SnowflakeDbCommand();
            command.CommandText = query;

            _context.AddParameter(command, "1", accountObj.Active, DbType.Boolean);
            _context.AddParameter(command, "2", accountObj.Date, DbType.DateTime);
            _context.AddParameter(command, "3", accountObj.DistrictId, DbType.Int64);
            _context.AddParameter(command, "4", accountObj.Frequency, DbType.String);
            _context.AddParameter(command, "5", accountObj.Id, DbType.String);
            _context.AddParameter(command, "6", accountObj.MyBank?.InstanceId, DbType.Int64);
            _context.AddParameter(command, "7", accountObj.MyDistrict?.InstanceId, DbType.Int64);
            _context.AddParameter(command, "8", accountObj.InstanceId, DbType.Int64);

            var instanceId = accountObj.InstanceId;

            _context.ExecuteQuery(instanceId, command, "UpdateAccountObject",
                handleNoRowAffected ? new Action(() => InsertAccountObject(accountObj)) : null);
        }

        private void DeleteAccountObject(AccountObject accountObj)
        {
            var query = @"DELETE FROM BankModelSchema.Account WHERE InstanceId = ?";

            using var command = new SnowflakeDbCommand();
            command.CommandText = query;

            _context.AddParameter(command, "1", accountObj.InstanceId, DbType.Int64);

            var instanceId = accountObj.InstanceId;

            _context.ExecuteQuery(instanceId, command, "DeleteAccountObject",
                () => _logger.LogWarning("Operation DeleteAccountObject: No record found or deleted, InstanceId: {InstanceId}", instanceId));
        }
    }
}
