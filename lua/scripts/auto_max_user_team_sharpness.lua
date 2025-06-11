require 'imports/career_mode/enums'
require 'imports/career_mode/helpers'


function max_sharpness_on_event(events_manager, event_id, event)
    if (
        event_id == ENUM_CM_EVENT_MSG_ABOUT_TO_ENTER_PREMATCH or    -- Before match
        event_id == ENUM_CM_EVENT_MSG_POST_LOAD_PREPARE             -- After save load
    ) then
        user_team_set_sharpness(99)
    end
end


AddEventHandler("post__CareerModeEvent", max_sharpness_on_event)