using KafkaConsumerService.Models;
using Snowflake.Data.Client;
using System.Data;

namespace KafkaConsumerService.Processors.Snowflake
{
    public class SnowflakeCustomerEventProcessor(
        SnowflakeContext _context,
        ILogger<SnowflakeCustomerEventProcessor> _logger) : BaseEventProcessor(_logger)
    {
        public override void ProcessEvent(string jsonPayload)
        {
            var payload = Deserialize<Payload<CustomerObject>>(jsonPayload);
            var customerObj = payload?.Object;
            if (customerObj == null) return;

            switch (payload!.EventType)
            {
                case EventTypes.ObjectCreated:
                    InsertCustomerObject(customerObj);
                    break;
                case EventTypes.ObjectUpdated:
                    UpdateCustomerObject(customerObj, true);
                    break;
                case EventTypes.ObjectDeleted:
                    DeleteCustomerObject(customerObj);
                    break;
                default:
                    _logger.LogWarning("Unsupported Customer EventType: {EventType}", payload!.EventType);
                    break;
            }
        }

        private void InsertCustomerObject(CustomerObject customerObj)
        {
            var query = @"INSERT INTO BankModelSchema.Customer(
                            InstanceId, Active, Address1, Address2, City, DateOfBirth, DistrictId, Email, FirstName,
                            Gender, Id, LastName, MiddleName, PhoneNumber, Ssn, State, ZipCode, MyBank, MyDistrict
                        ) VALUES (
                            ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?
                        )";

            using var command = new SnowflakeDbCommand();
            command.CommandText = query;

            _context.AddParameter(command, "1", customerObj.InstanceId, DbType.Int64);
            _context.AddParameter(command, "2", customerObj.Active, DbType.Boolean);
            _context.AddParameter(command, "3", customerObj.Address1, DbType.String);            
            _context.AddParameter(command, "4", customerObj.Address2 ?? (object)DBNull.Value, DbType.String);
            _context.AddParameter(command, "5", customerObj.City, DbType.String);
            _context.AddParameter(command, "6", customerObj.DateOfBirth, DbType.DateTime);
            _context.AddParameter(command, "7", customerObj.DistrictId, DbType.Int64);
            _context.AddParameter(command, "8", customerObj.Email, DbType.String);
            _context.AddParameter(command, "9", customerObj.FirstName, DbType.String);
            _context.AddParameter(command, "10", customerObj.Gender ?? (object)DBNull.Value, DbType.String);
            _context.AddParameter(command, "11", customerObj.Id, DbType.String);
            _context.AddParameter(command, "12", customerObj.LastName, DbType.String);
            _context.AddParameter(command, "13", customerObj.MiddleName ?? (object)DBNull.Value, DbType.String);
            _context.AddParameter(command, "14", customerObj.PhoneNumber ?? (object)DBNull.Value, DbType.String);
            _context.AddParameter(command, "15", customerObj.Ssn ?? (object)DBNull.Value, DbType.String);
            _context.AddParameter(command, "16", customerObj.State, DbType.String);
            _context.AddParameter(command, "17", customerObj.ZipCode, DbType.String);
            _context.AddParameter(command, "18", customerObj.MyBank?.InstanceId, DbType.Int64);
            _context.AddParameter(command, "19", customerObj.MyDistrict?.InstanceId, DbType.Int64);

            var instanceId = customerObj.InstanceId;

            _context.ExecuteQuery(instanceId, command, "InsertCustomerObject");
        }

        private void UpdateCustomerObject(CustomerObject customerObj, bool handleNoRowAffected)
        {
            var query = @"UPDATE BankModelSchema.Customer
                        SET Active = ?, Address1 = ?, Address2 = ?, City = ?, DateOfBirth = ?, DistrictId = ?, Email = ?,
                            FirstName = ?, Gender = ?, Id = ?, LastName = ?, MiddleName = ?, PhoneNumber = ?,
                            Ssn = ?, State = ?, ZipCode = ?, MyBank = ?, MyDistrict = ? 
                        WHERE InstanceId = ?";

            using var command = new SnowflakeDbCommand();
            command.CommandText = query;

            _context.AddParameter(command, "1", customerObj.Active, DbType.Boolean);
            _context.AddParameter(command, "2", customerObj.Address1, DbType.String);
            _context.AddParameter(command, "3", customerObj.Address2 ?? (object)DBNull.Value, DbType.String);
            _context.AddParameter(command, "4", customerObj.City, DbType.String);
            _context.AddParameter(command, "5", customerObj.DateOfBirth, DbType.DateTime);
            _context.AddParameter(command, "6", customerObj.DistrictId, DbType.Int64);
            _context.AddParameter(command, "7", customerObj.Email, DbType.String);
            _context.AddParameter(command, "8", customerObj.FirstName, DbType.String);
            _context.AddParameter(command, "9", customerObj.Gender ?? (object)DBNull.Value, DbType.String);
            _context.AddParameter(command, "10", customerObj.Id, DbType.String);
            _context.AddParameter(command, "11", customerObj.LastName, DbType.String);
            _context.AddParameter(command, "12", customerObj.MiddleName ?? (object)DBNull.Value, DbType.String);
            _context.AddParameter(command, "13", customerObj.PhoneNumber ?? (object)DBNull.Value, DbType.String);
            _context.AddParameter(command, "14", customerObj.Ssn ?? (object)DBNull.Value, DbType.String);
            _context.AddParameter(command, "15", customerObj.State, DbType.String);
            _context.AddParameter(command, "16", customerObj.ZipCode, DbType.String);
            _context.AddParameter(command, "17", customerObj.MyBank?.InstanceId, DbType.Int64);
            _context.AddParameter(command, "18", customerObj.MyDistrict?.InstanceId, DbType.Int64);
            _context.AddParameter(command, "19", customerObj.InstanceId, DbType.Int64);

            var instanceId = customerObj.InstanceId;

            _context.ExecuteQuery(instanceId, command, "UpdateCustomerObject",
                handleNoRowAffected ? new Action(() => InsertCustomerObject(customerObj)) : null);
        }

        private void DeleteCustomerObject(CustomerObject customerObj)
        {
            var query = @"DELETE FROM BankModelSchema.Customer WHERE InstanceId = ?";

            using var command = new SnowflakeDbCommand();
            command.CommandText = query;

            _context.AddParameter(command, "1", customerObj.InstanceId, DbType.Int64);

            var instanceId = customerObj.InstanceId;

            _context.ExecuteQuery(instanceId, command, "DeleteCustomerObject",
                () => _logger.LogWarning("Operation DeleteCustomerObject: No record found or deleted, InstanceId: {InstanceId}", instanceId));
        }
    }
}
