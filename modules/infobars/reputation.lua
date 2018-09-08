-- ####################################################################################################################
-- ##### Setup and Locals #############################################################################################
-- ####################################################################################################################

local _, LUI = ...
local module = LUI:GetModule("Info Bars")
local L = LUI.L

local SHORT_REPUTATION_NAMES = {
	L["ExpBar_ShortName_Hatred"],		-- Ha
	L["ExpBar_ShortName_Hostile"],		-- Ho
	L["ExpBar_ShortName_Unfriendly"],	-- Un
	L["ExpBar_ShortName_Neutral"],		-- Ne
	L["ExpBar_ShortName_Friendly"],		-- Fr
	L["ExpBar_ShortName_Honored"],		-- Hon
	L["ExpBar_ShortName_Revered"],		-- Rev
	L["ExpBar_ShortName_Exalted"],		-- Ex
}

-- ####################################################################################################################
-- ##### ReputationDataMixin #############################################################################################
-- ####################################################################################################################
local ReputationDataMixin = module:CreateNewDataMixin("Reputation")

function ReputationDataMixin:ShouldBeVisible()
	return true
end

function ReputationDataMixin:GetParagonValues(factionID)
	-- Blizzard also stores Paragon in an interesting way.
	-- currentValue is the total amount of paragon a character accrued.
	-- Need to remove threshold value out of currentValue for every reward already received.

	local currentValue, rewardThreshold, _,  rewardPending = C_Reputation.GetFactionParagonInfo(factionID)
	currentValue = (currentValue - rewardThreshold) % rewardThreshold

	if rewardPending then
		-- If there's a reward pending, the bar should be full, adjust percent value to be above 100%
		-- Also lets register for quest turn in to know when the reward isn't pending anymore.
		--module:RegisterEvent("QUEST_LOG_UPDATE", "UpdateBarMode")
		self.repText = L["ExpBar_ShortName_Reward"]
		return 0, currentValue + rewardThreshold, rewardThreshold
	else
		--module:UnregisterEvent("QUEST_LOG_UPDATE")
		self.repText = L["ExpBar_ShortName_Paragon"]
		return 0, currentValue, rewardThreshold
	end
end

function ReputationDataMixin:GetValues()
	-- Blizzard store reputation in an interesting way.
	-- barMin represents the minimum bound for the current standing, barMax represents the maximum bound.
	-- For example, barMin for revered is 21000 (3000+6000+12000 from Neutral to Honored), barMax is 42000.
	-- To get a 0 / 21000 representation, we have to reduce all three values by barMin.
	-- Patch 7.2 changed barMin to be equal to barMax at Exalted, so we need to handle that too.

	local name, standing, barMin, barMax, barValue, factionID = GetWatchedFactionInfo()
	if not name then return end

	self.repText = SHORT_REPUTATION_NAMES[standing]

	if C_Reputation.IsFactionParagon(factionID) and barMin == barMax then
		return self:GetParagonValues(factionID)
	elseif barMin == barMax then
		return 0, 1, 1
	end
	
	-- Adjust display values
	barMax = barMax - barMin
	barValue = barValue - barMin
	return 0, barValue, barMax
end

function ReputationDataMixin:GetDataText()
	return self.repText
end