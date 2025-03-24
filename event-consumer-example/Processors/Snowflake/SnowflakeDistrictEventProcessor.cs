using KafkaConsumerService.Models;
using Snowflake.Data.Client;
using System.Data;

namespace KafkaConsumerService.Processors.Snowflake
{
    public class SnowflakeDistrictEventProcessor(
        SnowflakeContext _context,
        ILogger<SnowflakeDistrictEventProcessor> _logger) : BaseEventProcessor(_logger)
    {
        public override void ProcessEvent(string jsonPayload)
        {
            var payload = Deserialize<Payload<DistrictObject>>(jsonPayload);
            var districtObj = payload?.Object;
            if (districtObj == null) return;

            switch (payload!.EventType)
            {
                case EventTypes.ObjectCreated:
                    InsertDistrictObject(districtObj);
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

        private void InsertDistrictObject(DistrictObject districtObj)
        {
            var query = @"INSERT INTO BANKAPPLICATION.BANKMODELSCHEMA.DISTRICT (
                            INSTANCEID, CITY, DIVISION, ID, REGION, STATEABBREV, STATENAME, MYBANK
                        ) VALUES (
                            ?, ?, ?, ?, ?, ?, ?, ?
                        )";

            using var command = new SnowflakeDbCommand();
            command.CommandText = query;

            _context.AddParameter(command, "1", districtObj.InstanceId, DbType.Int64);
            _context.AddParameter(command, "2", districtObj.City, DbType.String);
            _context.AddParameter(command, "3", districtObj.Division, DbType.String);
            _context.AddParameter(command, "4", districtObj.Id, DbType.Int64);
            _context.AddParameter(command, "5", districtObj.Region, DbType.String);
            _context.AddParameter(command, "6", districtObj.StateAbbrev, DbType.String);
            _context.AddParameter(command, "7", districtObj.StateName, DbType.String);
            _context.AddParameter(command, "8", districtObj.MyBank?.InstanceId, DbType.Int64);

            var instanceId = districtObj.InstanceId;

            _context.ExecuteQuery(instanceId, command, "InsertDistrictObject");
        }

        private void UpdateDistrictObject(DistrictObject districtObj, bool handleNoRowAffected)
        {
            var query = @"UPDATE BankModelSchema.District
                        SET City = ?, Division = ?, Id = ?, Region = ?, StateAbbrev = ?, StateName = ?, MyBank = ?
                        WHERE InstanceId = ?";

            using var command = new SnowflakeDbCommand();
            command.CommandText = query;

            _context.AddParameter(command, "1", districtObj.City, DbType.String);
            _context.AddParameter(command, "2", districtObj.Division, DbType.String);
            _context.AddParameter(command, "3", districtObj.Id, DbType.Int64);
            _context.AddParameter(command, "4", districtObj.Region, DbType.String);
            _context.AddParameter(command, "5", districtObj.StateAbbrev, DbType.String);
            _context.AddParameter(command, "6", districtObj.StateName, DbType.String);
            _context.AddParameter(command, "7", districtObj.MyBank?.InstanceId, DbType.Int64);
            _context.AddParameter(command, "8", districtObj.InstanceId, DbType.Int64);

            var instanceId = districtObj.InstanceId;

            _context.ExecuteQuery(instanceId, command, "UpdateDistrictObject",
                handleNoRowAffected ? new Action(() => InsertDistrictObject(districtObj)) : null);
        }

        private void DeleteDistrictObject(DistrictObject districtObj)
        {
            var query = @"DELETE FROM BankModelSchema.District WHERE InstanceId = ?";

            using var command = new SnowflakeDbCommand();
            command.CommandText = query;

            _context.AddParameter(command, "1", districtObj.InstanceId, DbType.Int64);

            var instanceId = districtObj.InstanceId;

            _context.ExecuteQuery(instanceId, command, "DeleteDistrictObject",
                () => _logger.LogWarning("Operation DeleteDistrictObject: No record found or deleted, InstanceId: {InstanceId}", instanceId));
        }
    }
}
