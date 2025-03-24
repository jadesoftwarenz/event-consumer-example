using KafkaConsumerService.Models;
using Microsoft.Data.SqlClient;

namespace KafkaConsumerService.Processors.Sql
{
    public class SqlCustomerEventProcessor(
        SqlServerContext _context,
        ILogger<SqlCustomerEventProcessor> _logger) : BaseEventProcessor(_logger)
    {
        public override void ProcessEvent(string jsonPayload)
        {
            var payload = Deserialize<Payload<CustomerObject>>(jsonPayload);
            var customerObj = payload?.Object;
            if (customerObj == null) return;

            switch (payload!.EventType)
            {
                case EventTypes.ObjectCreated:
                    InsertCustomerObject(customerObj, true);
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

        private void InsertCustomerObject(CustomerObject customerObj, bool handleDupKey)
        {
            const string query = @"INSERT INTO [BankModelSchema].[Customer]
                (InstanceId, Active, Address1, Address2, City, DateOfBirth, DistrictId, Email, FirstName,
                Gender, Id, LastName, MiddleName, PhoneNumber, Ssn, State, ZipCode, MyBank, MyDistrict) 
                VALUES (@InstanceId, @Active, @Address1, @Address2, @City, @DateOfBirth, @DistrictId, @Email, @FirstName,
                @Gender, @Id, @LastName, @MiddleName, @PhoneNumber, @Ssn, @State, @ZipCode, @MyBank, @MyDistrict)";

            using var command = new SqlCommand(query);
            AddCustomerParameters(command, customerObj);

            var instanceId = customerObj.InstanceId;

            _context.ExecuteQuery(instanceId, command, "InsertCustomerObject",
                handleDupKey ? new Action(() => UpdateCustomerObject(customerObj, false)) : null);
        }

        private void UpdateCustomerObject(CustomerObject customerObj, bool handleNoRowAffected)
        {
            const string query = @"UPDATE [BankModelSchema].[Customer]
                SET InstanceId = @InstanceId, Active = @Active, Address1 = @Address1, Address2 = @Address2, City = @City,
                DateOfBirth = @DateOfBirth, DistrictId = @DistrictId, Email = @Email, FirstName = @FirstName,
                Gender = @Gender, Id = @Id, LastName = @LastName, MiddleName = @MiddleName, PhoneNumber = @PhoneNumber, Ssn = @Ssn,
                State = @State, ZipCode = @ZipCode, MyBank = @MyBank, MyDistrict = @MyDistrict 
                WHERE InstanceId = @InstanceId";

            using var command = new SqlCommand(query);
            AddCustomerParameters(command, customerObj);

            var instanceId = customerObj.InstanceId;

            _context.ExecuteQuery(instanceId, command, "UpdateCustomerObject", null,
                handleNoRowAffected ? new Action(() => InsertCustomerObject(customerObj, false)) : null);
        }

        private void DeleteCustomerObject(CustomerObject customerObj)
        {
            var query = @"DELETE FROM [BankModelSchema].[Customer] WHERE InstanceId = @InstanceId";

            using var command = new SqlCommand(query);
            command.Parameters.AddWithValue("@InstanceId", customerObj.InstanceId);

            var instanceId = customerObj.InstanceId;

            _context.ExecuteQuery(instanceId, command, "DeleteCustomerObject", null,
                () => _logger.LogWarning("Operation DeleteCustomerObject: No record found or deleted, InstanceId: " + instanceId));
        }

        private static void AddCustomerParameters(SqlCommand command, CustomerObject customerObj)
        {
            command.Parameters.AddWithValue("@InstanceId", customerObj.InstanceId);
            command.Parameters.AddWithValue("@Active", customerObj.Active);
            command.Parameters.AddWithValue("@Address1", customerObj.Address1 ?? "No Address");
            command.Parameters.AddWithValue("@Address2", customerObj.Address2 ?? "");
            command.Parameters.AddWithValue("@City", customerObj.City);
            command.Parameters.AddWithValue("@DateOfBirth", customerObj.DateOfBirth);
            command.Parameters.AddWithValue("@DistrictId", customerObj.DistrictId);
            command.Parameters.AddWithValue("@Email", customerObj.Email);
            command.Parameters.AddWithValue("@FirstName", customerObj.FirstName);
            command.Parameters.AddWithValue("@Gender", customerObj.Gender);
            command.Parameters.AddWithValue("@Id", customerObj.Id);
            command.Parameters.AddWithValue("@LastName", customerObj.LastName);
            command.Parameters.AddWithValue("@MiddleName", customerObj.MiddleName);
            command.Parameters.AddWithValue("@PhoneNumber", customerObj.PhoneNumber);
            command.Parameters.AddWithValue("@Ssn", customerObj.Ssn);
            command.Parameters.AddWithValue("@State", customerObj.State);
            command.Parameters.AddWithValue("@ZipCode", customerObj.ZipCode);
            command.Parameters.AddWithValue("@MyBank", customerObj.MyBank?.InstanceId);
            command.Parameters.AddWithValue("@MyDistrict", customerObj.MyDistrict?.InstanceId);
        }
    }
}
