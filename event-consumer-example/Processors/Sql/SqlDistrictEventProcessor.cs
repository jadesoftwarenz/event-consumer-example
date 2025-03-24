using KafkaConsumerService.Models;
using Microsoft.Data.SqlClient;

namespace KafkaConsumerService.Processors.Sql
{
    public class SqlDistrictEventProcessor(
        SqlServerContext _context,
        ILogger<SqlDistrictEventProcessor> _logger) : BaseEventProcessor(_logger)
    {
        public override void ProcessEvent(string jsonPayload)
        {
            var payload = Deserialize<Payload<DistrictObject>>(jsonPayload);
            var districtObj = payload?.Object;
            if (districtObj == null) return;

            switch (payload!.EventType)
            {
                case EventTypes.ObjectCreated:
                    InsertDistrictObject(districtObj, true);
                    break;
                case EventTypes.ObjectUpdated:
                    UpdateDistrictObject(districtObj, true);
                    break;
                case EventTypes.ObjectDeleted:
                    DeleteDistrictObject(districtObj);
                    break;
                default:
                    _logger.LogWarning("Unsupported District EventType: {EventType}", payload!.EventType);
                    break;
            }
        }

        private void InsertDistrictObject(DistrictObject districtObj, bool handleDupKey)
        {
            const string query = @"INSERT INTO [BankModelSchema].[District]
                (InstanceId, City, Division, Id, Region, StateAbbrev, StateName, MyBank) 
                VALUES (@InstanceId, @City, @Division, @Id, @Region, @StateAbbrev, @StateName, @MyBank)";

            using var command = new SqlCommand(query);
            AddDistrictParameters(command, districtObj);

            var instanceId = districtObj.InstanceId;

            _context.ExecuteQuery(instanceId, command, "InsertDistrictObject",
                handleDupKey ? new Action(() => UpdateDistrictObject(districtObj, false)) : null);
        }

        private void UpdateDistrictObject(DistrictObject districtObj, bool handleNoRowAffected)
        {
            const string query = @"UPDATE [BankModelSchema].[District]
                SET InstanceId = @InstanceId, City = @City, Division = @Division, Id = @Id, Region = @Region,
                StateAbbrev = @StateAbbrev, StateName = @StateName, MyBank = @MyBank
                WHERE InstanceId = @InstanceId";

            using var command = new SqlCommand(query);
            AddDistrictParameters(command, districtObj);

            var instanceId = districtObj.InstanceId;

            _context.ExecuteQuery(instanceId, command, "UpdateDistrictObject", null,
                handleNoRowAffected ? new Action(() => InsertDistrictObject(districtObj, false)) : null);
        }

        private void DeleteDistrictObject(DistrictObject districtObj)
        {
            const string query = @"DELETE FROM [BankModelSchema].[District] WHERE InstanceId = @InstanceId";

            using var command = new SqlCommand(query);
            command.Parameters.AddWithValue("@InstanceId", districtObj.InstanceId);

            var instanceId = districtObj.InstanceId;

            _context.ExecuteQuery(instanceId, command, "DeleteDistrictObject", null,
                () => _logger.LogWarning("Operation DeleteDistrictObject: No record found or deleted, InstanceId: {id}", instanceId));
        }

        private static void AddDistrictParameters(SqlCommand command, DistrictObject districtObj)
        {
            command.Parameters.AddWithValue("@InstanceId", districtObj.InstanceId);
            command.Parameters.AddWithValue("@City", districtObj.City);
            command.Parameters.AddWithValue("@Division", districtObj.Division);
            command.Parameters.AddWithValue("@Id", districtObj.Id);
            command.Parameters.AddWithValue("@Region", districtObj.Region);
            command.Parameters.AddWithValue("@StateAbbrev", districtObj.StateAbbrev);
            command.Parameters.AddWithValue("@StateName", districtObj.StateName);
            command.Parameters.AddWithValue("@MyBank", districtObj.MyBank?.InstanceId);
        }
    }
}
