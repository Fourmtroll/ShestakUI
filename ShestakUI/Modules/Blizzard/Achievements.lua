﻿local T, C, L = unpack(select(2, ...))
if T.MOPVersion then return end

----------------------------------------------------------------------------------------
--	Based on AchievementMover(modified by Tukz)
----------------------------------------------------------------------------------------
local AchievementAnchor = CreateFrame("Frame", "AchievementAnchor", UIParent)
AchievementAnchor:Width(DungeonCompletionAlertFrame1:GetWidth())
AchievementAnchor:Height(DungeonCompletionAlertFrame1:GetHeight())
AchievementAnchor:SetPoint(unpack(C.position.achievement))

local pos = "TOP"

function T.AchievementMove(self, event, ...)
	local previousFrame
	for i = 1, MAX_ACHIEVEMENT_ALERTS do
		local aFrame = _G["AchievementAlertFrame"..i]
		if aFrame then
			aFrame:ClearAllPoints()
			if pos == "TOP" then
				if previousFrame and previousFrame:IsShown() then
					aFrame:SetPoint("TOP", previousFrame, "BOTTOM", 0, 3)
				else
					aFrame:SetPoint("TOP", AchievementAnchor, "TOP")
				end
			else
				if previousFrame and previousFrame:IsShown() then
					aFrame:SetPoint("BOTTOM", previousFrame, "TOP", 0, -3)
				else
					aFrame:SetPoint("BOTTOM", AchievementAnchor, "BOTTOM")
				end
			end
			previousFrame = aFrame
		end
	end
end
hooksecurefunc("AlertFrame_SetAchievementAnchors", T.AchievementMove)

hooksecurefunc("AlertFrame_SetDungeonCompletionAnchors", function()
	for i = MAX_ACHIEVEMENT_ALERTS, 1, -1 do
		local aFrame = _G["AchievementAlertFrame"..i]
		local dFrame = _G["DungeonCompletionAlertFrame1"]

		dFrame:ClearAllPoints()
		if aFrame and aFrame:IsShown() then
			dFrame:ClearAllPoints()
			if pos == "TOP" then
				dFrame:SetPoint("TOP", aFrame, "BOTTOM", 0, 3)
			else
				dFrame:SetPoint("BOTTOM", aFrame, "TOP", 0, -3)
			end
			return
		else
			if pos == "TOP" then
				dFrame:SetPoint("TOP", AchievementAnchor, "TOP")
			else
				dFrame:SetPoint("BOTTOM", AchievementAnchor, "BOTTOM")
			end
		end
	end
end)

hooksecurefunc("AlertFrame_SetGuildChallengeAnchors", function()
	for i = MAX_ACHIEVEMENT_ALERTS, 1, -1 do
		local aFrame = _G["AchievementAlertFrame"..i]
		local dFrame = _G["DungeonCompletionAlertFrame1"]
		local cFrame = _G["GuildChallengeAlertFrame"]

		cFrame:ClearAllPoints()
		if dFrame and dFrame:IsShown() then
			if pos == "TOP" then
				cFrame:SetPoint("TOP", dFrame, "BOTTOM", 0, 3)
			else
				cFrame:SetPoint("BOTTOM", dFrame, "TOP", 0, -3)
			end
			return
		elseif aFrame and aFrame:IsShown() then
			if pos == "TOP" then
				cFrame:SetPoint("TOP", aFrame, "BOTTOM", 0, 3)
			else
				cFrame:SetPoint("BOTTOM", aFrame, "TOP", 0, -3)
			end
			return
		else
			if pos == "TOP" then
				cFrame:SetPoint("TOP", AchievementAnchor, "TOP")
			else
				cFrame:SetPoint("BOTTOM", AchievementAnchor, "BOTTOM")
			end
		end
	end
end)

hooksecurefunc("AlertFrame_SetChallengeModeAnchors", function()
	for i = MAX_ACHIEVEMENT_ALERTS, 1, -1 do
		local aFrame = _G["AchievementAlertFrame"..i]
		local dFrame = _G["DungeonCompletionAlertFrame1"]
		local cFrame = _G["GuildChallengeAlertFrame"]
		local cmFrame = _G["ChallengeModeAlertFrame1"]

		cmFrame:ClearAllPoints()
		if cFrame and cFrame:IsShown() then
			if pos == "TOP" then
				cmFrame:SetPoint("TOP", dFrame, "BOTTOM", 0, 3)
			else
				cmFrame:SetPoint("BOTTOM", dFrame, "TOP", 0, -3)
			end
			return
		elseif dFrame and dFrame:IsShown() then
			if pos == "TOP" then
				cmFrame:SetPoint("TOP", dFrame, "BOTTOM", 0, 3)
			else
				cmFrame:SetPoint("BOTTOM", dFrame, "TOP", 0, -3)
			end
			return
		elseif aFrame and aFrame:IsShown() then
			if pos == "TOP" then
				cmFrame:SetPoint("TOP", aFrame, "BOTTOM", 0, 3)
			else
				cmFrame:SetPoint("BOTTOM", aFrame, "TOP", 0, -3)
			end
			return
		else
			if pos == "TOP" then
				cmFrame:SetPoint("TOP", AchievementAnchor, "TOP")
			else
				cmFrame:SetPoint("BOTTOM", AchievementAnchor, "BOTTOM")
			end
		end
	end
end)

function T.PostAchievementMove(frame)
	local point = select(1, frame:GetPoint())

	if string.find(point, "TOP") or point == "CENTER" or point == "LEFT" or point == "RIGHT" then
		pos = "TOP"
	else
		pos = "BOTTOM"
	end

	T.AchievementMove()
end

local frame = CreateFrame("Frame")
frame:RegisterEvent("ACHIEVEMENT_EARNED")
frame:SetScript("OnEvent", function(self, event, ...) T.AchievementMove(self, event, ...) end)