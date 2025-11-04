--- @meta _

--- @class TalentViewer_PlayerTalentFrame: Frame, ButtonFrameTemplate
--- @field DropdownButton TalentViewer_DropdownButton
TalentViewer_PlayerTalentFrame = {}

--- @class TalentViewer_DropdownButton: DropdownButton, WowStyle1DropdownTemplate

--- @class TalentViewer_PlayerTalentFrameTalents: Frame
--- @field [string] TalentViewer_PlayerTalentRowTemplate
TalentViewer_PlayerTalentFrameTalents = {}

--- @class TalentViewer_PlayerTalentRowTemplate: Frame
--- @field level FontString
--- @field talent1 TalentViewer_PlayerTalentButtonTemplate
--- @field talent2 TalentViewer_PlayerTalentButtonTemplate
--- @field talent3 TalentViewer_PlayerTalentButtonTemplate

--- @class TalentViewer_PlayerTalentButtonTemplate: Button
--- @field tier number
--- @field column number
--- @field name FontString
--- @field icon Texture

