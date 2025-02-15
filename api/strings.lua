--- Strings API mostly contains LUI methods, but moved to their own file for clarity.
-- This api module deal mostly in storing huge string table and functions that convert a string (or to a string)
-- @classmod strings

-- @type LUI

-- ####################################################################################################################
-- ##### Setup and Locals #############################################################################################
-- ####################################################################################################################

local _, LUI = ...
local L = LUI.L

--constants
local LOCALIZED_CLASS_NAMES_FEMALE = LOCALIZED_CLASS_NAMES_FEMALE
local LOCALIZED_CLASS_NAMES_MALE = LOCALIZED_CLASS_NAMES_MALE

-- Default fonts used for specialized character sets. Currently here for documentation purposes.
-- TODO: Whenever a FontString may potentially get those characters, use an api call to detect those.
--           We could then detect those and replace the font with the correct font to keep support.
-- local UNIT_NAME_FONT_KOREAN = UNIT_NAME_FONT_KOREAN      -- Korean font
-- local UNIT_NAME_FONT_CHINESE = UNIT_NAME_FONT_CHINESE    -- Chinese/Japanese Font
-- local UNIT_NAME_FONT_CYRILLIC = UNIT_NAME_FONT_CYRILLIC  -- Russian Font

-- ####################################################################################################################
-- ##### StringUtils: EmmyLua #########################################################################################
-- ####################################################################################################################

---@alias FrameLayer string|"BACKGROUND"|"BORDER"|"ARTWORK"|"OVERLAY"|"HIGHLIGHT"
---@alias FrameStrata string|"BACKGROUND"|"LOW"|"MEDIUM"|"HIGH"|"DIALOG"|"FULLSCREEN"|"TOOLTIP"
---@alias DBScope string|"profile"|"global"|"char"|"realm"|"class"|"race"|"faction"|"factionrealm"
---@alias ClassToken string|"DEATHKNIGHT"|"DEMONHUNTER"|"DRUID"|"HUNTER"|"MAGE"|"MONK"|"PALADIN"|"PRIEST"|"ROGUE"|"SHAMAN"|"WARLOCK"|"WARRIOR"
---@alias UnitId string|"player"|"target"|"focus"|"mouseover"|"pet"|"vehicle"|"partyN"|"nameplateN"|"raidN"|"bossN"
---@alias Point string|"CENTER"|"TOP"|"BOTTOM"|"LEFT"|"RIGHT"|"TOPLEFT"|"TOPRIGHT"|"BOTTOMLEFT"|"BOTTOMRIGHT"

-- ####################################################################################################################
-- ##### StringUtils: Classes #########################################################################################
-- ####################################################################################################################

local localClassNames
--- Returns a locale-independant class token from a localized class name.
---@param className string @ Localized class name
---@return ClassToken
function LUI:GetTokenFromClassName(className)
	if not localClassNames then
		localClassNames = {}
		for class, localized in pairs(LOCALIZED_CLASS_NAMES_MALE) do
			localClassNames[localized] = class
		end
		for class, localized in pairs(LOCALIZED_CLASS_NAMES_FEMALE) do
			localClassNames[localized] = class
		end
	end
	return localClassNames[className]
end

-- ####################################################################################################################
-- ##### StringUtils: Constant Tables #################################################################################
-- ####################################################################################################################
-- Make sure Blizzard doesn't have equivalent Enum tables that we could use.

LUI.DB_TYPES = {
	"profile",
	"global",
	"char",
	"realm",
	"class",
	"race",
	"faction",
	"factionrealm",
}

LUI.REACTION_NAMES = {
	"Hated",      -- 1
	"Hostile",    -- 2
	"Unfriendly", -- 3
	"Neutral",    -- 4
	"Friendly",   -- 5
	"Honored",    -- 6
	"Revered",    -- 7
	"Exalted",    -- 8
}

LUI.GENDERS = {
	UNKNOWN,	-- 1
	MALE,		-- 2
	FEMALE,		-- 3
}

-- As found in the Colors module.
LUI.PowerTypes = {
	"MANA",
	"RAGE",
	"FOCUS",
	"ENERGY",
	"COMBO_POINTS",
	"RUNES",
	"RUNIC_POWER",
	"SOUL_SHARDS",
	"LUNAR_POWER",
	"HOLY_POWER",
	"MAELSTROM",
	"CHI",
	"INSANITY",
	"ARCANE_CHARGES",
	"FURY",
	"PAIN",
	"FUEL",
}

LUI.Opposites = {
	-- Sides
	TOP = "BOTTOM",
	BOTTOM = "TOP",
	LEFT = "RIGHT",
	RIGHT = "LEFT",
	-- Corners
	TOPLEFT = "BOTTOMRIGHT",
	TOPRIGHT = "BOTTOMLEFT",
	BOTTOMLEFT = "TOPRIGHT",
	BOTTOMRIGHT = "TOPLEFT",
}

-- ####################################################################################################################
-- ##### StringUtils: Localized Tables ################################################################################
-- ####################################################################################################################

LUI.FontFlags = {
	NONE = L["Flag_None"],
	OUTLINE = L["Flag_Outline"],
	THICKOUTLINE = L["Flag_ThickOutline"],
	MONOCHROME = L["Flag_Monochrome"],
}

LUI.Points = {
	CENTER = L["Point_Center"],
	TOP = L["Point_Top"],
	BOTTOM = L["Point_Bottom"],
	LEFT = L["Point_Left"],
	RIGHT = L["Point_Right"],
	TOPLEFT = L["Point_TopLeft"],
	TOPRIGHT = L["Point_TopRight"],
	BOTTOMLEFT = L["Point_BottomLeft"],
	BOTTOMRIGHT = L["Point_BottomRight"],
}

LUI.Corners = {
	TOPLEFT = L["Point_TopLeft"],
	TOPRIGHT = L["Point_TopRight"],
	BOTTOMLEFT = L["Point_BottomLeft"],
	BOTTOMRIGHT = L["Point_BottomRight"],
}
LUI.Sides = {
	TOP = L["Point_Top"],
	BOTTOM = L["Point_Bottom"],
	LEFT = L["Point_Left"],
	RIGHT = L["Point_Right"],
}
LUI.Directions = {
	UP = L["Point_Up"],
	DOWN = L["Point_Down"],
	LEFT = L["Point_Left"],
	RIGHT = L["Point_Right"],
}

LUI.ColorTypes = {
	Individual = L["Color_Individual"],
	Theme = L["Color_Theme"],
	Class = L["Color_Class"],
}
