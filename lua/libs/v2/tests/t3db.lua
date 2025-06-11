local DB = require 'imports/t3db/db'

if database == nil then
    database = DB:new()
    database:Load()
end

assert(database.tables_count == 201, string.format("database.tables_count %d != 201", database.tables_count))

local table = database:GetTable("teams")

assert(table.name == "teams", string.format("table.name %s != teams", table.name))
assert(table.shortname == "lyxL", string.format("table.shortname %s != lyxL", table.shortname))

local current_record = table:GetFirstRecord()

local count = 0
while current_record > 0 do
    local teamid = table:GetRecordFieldValue(current_record, "teamid")
    local teamname = table:GetRecordFieldValue(current_record, "teamname")
    Log(string.format("%s %d", teamname, teamid))

    local old = table:GetRecordFieldValue(current_record, "attackrating")

    table:SetRecordFieldValue(current_record, "attackrating", 99)
    local new = table:GetRecordFieldValue(current_record, "attackrating")
    Log(string.format("%d %d", old, new))

    count = count + 1
    current_record = table:GetNextValidRecord()
end

table = database:GetTable("formations")
current_record = table:GetFirstRecord()

while current_record > 0 do
    local teamid = table:GetRecordFieldValue(current_record, "teamid")
    local formationid = table:GetRecordFieldValue(current_record, "formationid")
    local offset1x = table:GetRecordFieldValue(current_record, "offset1x")
    local attackers = table:GetRecordFieldValue(current_record, "attackers")
    local midfielders = table:GetRecordFieldValue(current_record, "midfielders")
    local defenders = table:GetRecordFieldValue(current_record, "defenders")

    Log(string.format(
        "%d %d offset1x %0.3f attackers %0.3f midfielders %0.3f defenders %0.3f", 
        teamid, formationid, offset1x, attackers, midfielders, defenders
    ))

    table:SetRecordFieldValue(current_record, "offset1x", 1.0)
    local newoffset1x = table:GetRecordFieldValue(current_record, "offset1x")
    Log(string.format(
        "%d %d newoffset1x %0.3f attackers %0.3f midfielders %0.3f defenders %0.3f", 
        teamid, formationid, newoffset1x, attackers, midfielders, defenders
    ))

    current_record = table:GetNextValidRecord()
end
assert(count == table.written_records, string.format("teams count %d != %d", count, table.written_records))
