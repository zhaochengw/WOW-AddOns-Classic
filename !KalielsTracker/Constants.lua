--- Kaliel's Tracker
--- Copyright (c) 2012-2023, Marouan Sabbagh <mar.sabbagh@gmail.com>
--- All Rights Reserved.
---
--- This file is part of addon Kaliel's Tracker.

local _, KT = ...

-- Constants
KT.BLIZZARD_MODULES = {
    "QUEST_TRACKER_MODULE",
    "ACHIEVEMENT_TRACKER_MODULE"
}

KT.ALL_BLIZZARD_MODULES = {
    -- Don't change the order!
    "QUEST_TRACKER_MODULE",
    "ACHIEVEMENT_TRACKER_MODULE"
}

KT.OBJECTIVE_TRACKER_DOUBLE_LINE_HEIGHT = 0
KT.QUEST_DASH = "- "
KT_QUEST_DASH = KT.QUEST_DASH

KT.PLAYER_FACTION_COLORS = {
    Horde = "ff0000",
    Alliance = "007fff"
}

KT.QUALITY_COLORS = {
    Poor = "9d9d9d",
    Common = "ffffff",
    Uncommon = "1eff00",
    Rare = "0070dd",
    Epic = "a335ee",
    Legendary = "ff8000",
    Artifact = "e6cc80"
}

-- Blizzard Constants
OBJECTIVE_TRACKER_COLOR["Header"] = { r = 1, g = 0.5, b = 0 }				        -- orange
OBJECTIVE_TRACKER_COLOR["Complete"] = { r = 0.1, g = 0.8, b = 0.1 }				    -- green
OBJECTIVE_TRACKER_COLOR["CompleteHighlight"] = { r = 0, g = 1, b = 0 }			    -- green
OBJECTIVE_TRACKER_COLOR["ObjectiveComplete"] = { r = 0.1, g = 0.6, b = 0.1 }		-- green dark
OBJECTIVE_TRACKER_COLOR["ObjectiveCompleteHighlight"] = { r = 0, g = 0.75, b = 0 }	-- green dark
OBJECTIVE_TRACKER_COLOR["TimeLeft2"] = { r = 0, g = 0.5, b = 1 }				    -- blue
OBJECTIVE_TRACKER_COLOR["TimeLeft2Highlight"] = { r = 0.3, g = 0.7, b = 1 }		    -- blue
OBJECTIVE_TRACKER_COLOR["Label"] = { r = 0.5, g = 0.5, b = 0.5 }				    -- gray
OBJECTIVE_TRACKER_COLOR["LabelHighlight"] = { r = 0.6, g = 0.6, b = 0.6 }	        -- gray
OBJECTIVE_TRACKER_COLOR["Zone"] = { r = 0.1, g = 0.65, b = 1 }					    -- blue
OBJECTIVE_TRACKER_COLOR["ZoneHighlight"] = { r = 0.3, g = 0.8, b = 1 }			    -- blue
OBJECTIVE_TRACKER_COLOR["Header"].reverse = OBJECTIVE_TRACKER_COLOR["HeaderHighlight"]
OBJECTIVE_TRACKER_COLOR["HeaderHighlight"].reverse = OBJECTIVE_TRACKER_COLOR["Header"]
OBJECTIVE_TRACKER_COLOR["Complete"].reverse = OBJECTIVE_TRACKER_COLOR["CompleteHighlight"]
OBJECTIVE_TRACKER_COLOR["CompleteHighlight"].reverse = OBJECTIVE_TRACKER_COLOR["Complete"]
OBJECTIVE_TRACKER_COLOR["ObjectiveComplete"].reverse = OBJECTIVE_TRACKER_COLOR["ObjectiveCompleteHighlight"]
OBJECTIVE_TRACKER_COLOR["ObjectiveCompleteHighlight"].reverse = OBJECTIVE_TRACKER_COLOR["ObjectiveComplete"]
OBJECTIVE_TRACKER_COLOR["TimeLeft2"].reverse = OBJECTIVE_TRACKER_COLOR["TimeLeft2Highlight"]
OBJECTIVE_TRACKER_COLOR["TimeLeft2Highlight"].reverse = OBJECTIVE_TRACKER_COLOR["TimeLeft2"]
OBJECTIVE_TRACKER_COLOR["Label"].reverse = OBJECTIVE_TRACKER_COLOR["LabelHighlight"]
OBJECTIVE_TRACKER_COLOR["LabelHighlight"].reverse = OBJECTIVE_TRACKER_COLOR["Label"]
OBJECTIVE_TRACKER_COLOR["Zone"].reverse = OBJECTIVE_TRACKER_COLOR["ZoneHighlight"]
OBJECTIVE_TRACKER_COLOR["ZoneHighlight"].reverse = OBJECTIVE_TRACKER_COLOR["Zone"]