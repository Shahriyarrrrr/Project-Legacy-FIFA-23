-- LOGGER TEST (kind of)
LE.LOGGER:LogDebug("TEST LogDebug")
LE.LOGGER:LogInfo("TEST LogInfo")
LE.LOGGER:LogWarn("TEST LogWarn")
LE.LOGGER:LogError("TEST LogError")
LE.LOGGER:LogFatal("TEST LogFatal")

-- MEMORY TEST
-- TODO: Read base addr from Process
local game_base_addr = 0x140000000
local result = 0;

-- Should be PE Header
result = LE.MEMORY:ReadBytes(game_base_addr, 2)
assert(result[1] == 0x4D, string.format("ReadBytes Test, 0x%X != 0x4D", result[1]))
assert(result[2] == 0x5A, string.format("ReadBytes Test, 0x%X != 0x5A", result[2]))

result = LE.MEMORY:ReadInt(game_base_addr)
assert(result == 9460301, string.format("ReadInt Test, %d != 9460301", result))

result = LE.MEMORY:ReadQword(game_base_addr)
assert(result == 12894362189, string.format("ReadQword Test, %d != 12894362189", result))

-- Crash Test
result = ReadQword(0x113920500)
assert(result == 0, string.format("ReadQword CrashTest1, %d != 0", result))

result = ReadQword(1245)
assert(result == 0, string.format("ReadQword CrashTest2, %d != 0", result))

result = ReadQword(0x115205001)
assert(result == 0, string.format("ReadQword CrashTest3, %d != 0", result))

result = ReadQword(0)
assert(result == 0, string.format("ReadQword CrashTest4, %d != 0", result))

result = ReadQword(-5)
assert(result == 0, string.format("ReadQword CrashTest5, %d != 0", result))
