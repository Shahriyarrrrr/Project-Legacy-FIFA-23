MEMORY = require 'imports/memory'
LOGGER = require 'imports/logger'

local CORE = {}

function CORE:new(o)
    o = o or {}
    setmetatable(o, self)

    -- lua metatable
    self.__index = self
    self.__name = "CORE"

    -- config.json
    self.config = {}

    self:Init()

    return o;
end

function CORE:Init()
    LOGGER:LogInfo("Init LIVE EDITOR LUA API V2")
end

function CORE:Load()
    LOGGER:LogInfo("Load LIVE EDITOR LUA API V2")
end

return CORE;