require 'imports/career_mode/enums'

-- Script that will keep your VPRO player in player career mode at 99 OVR

-- You can change the ID if you want to apply that to other player
local VPRO_PLAYERID = 30999

-- DON'T CHANGE ANYTHING BELOW

local fields_to_edit = {
    -- GK
    "gkdiving",
    "gkhandling",
    "gkkicking",
    "gkpositioning",
    "gkreflexes",

    -- ATTACK
    "crossing",
    "finishing",
    "headingaccuracy",
    "shortpassing",
    "volleys",

    -- DEFENDING
    "defensiveawareness",
    "standingtackle",
    "slidingtackle",

    -- SKILL
    "dribbling",
    "curve",
    "freekickaccuracy",
    "longpassing",
    "ballcontrol",

    -- POWER
    "shotpower",
    "jumping",
    "stamina",
    "strength",
    "longshots",

    -- MOVEMENT
    "acceleration",
    "sprintspeed",
    "agility",
    "reactions",
    "balance",

    -- MENTALITY
    "aggression",
    "composure",
    "interceptions",
    "positioning",
    "vision",
    "penalties",

    "overallrating"
}

function get_vpro()
    local rows = GetDBTableRows("players")

    for i=1, #rows do
        local player = rows[i]
        local iplayerid = math.floor(player.playerid.value)

        if (iplayerid == VPRO_PLAYERID) then 
            return player 
        end
    end

    return nil
end

function set_99ovr() 
    local player = get_vpro()
    if player == nil then
        LE.LOGGER:LogError(string.format("Can't find player %d to apply 99ovr", VPRO_PLAYERID))
        return
    end

    for j=1, #fields_to_edit do
        local field = fields_to_edit[j]
        player[field].value = "99"
        EditDBTableField(player[field])

        if (has_dev_plan) then 
            PlayerSetValueInDevelopementPlan(iplayerid, field, 99)
        end
    end

    player.modifier.value = "0"
    EditDBTableField(player.modifier)

    player.potential.value = "99"
    EditDBTableField(player.potential)
    SaveVPRO()
end

function handle_vpro_reset(events_manager, event_id, event)
    -- Events that reset the vpro attributes
    if (
        event_id == ENUM_CM_EVENT_MSG_USER_MATCH_COMPLETED or
        event_id == ENUM_CM_EVENT_MSG_USER_MATCH_COMPLETED_IN_TOURNAMENT or
        event_id == ENUM_CM_EVENT_MSG_USER_INTERNATIONAL_MATCH_COMPLETED or
        event_id == ENUM_CM_EVENT_MSG_POST_LOAD_PREPARE
    ) then
        set_99ovr()
    end
end

AddEventHandler("post__CareerModeEvent", handle_vpro_reset)