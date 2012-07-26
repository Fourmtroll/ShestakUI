local T, C, L = unpack(select(2, ...))
if C.map.enable ~= true or IsAddOnLoaded("Aurora") then return end

----------------------------------------------------------------------------------------
--	WorldMap style(m_Map by Monolit)
----------------------------------------------------------------------------------------
WORLDMAP_WINDOWED_SIZE = C.map.scale
local mapscale = WORLDMAP_WINDOWED_SIZE

local mapbg = CreateFrame("Frame", nil, WorldMapDetailFrame)
mapbg:SetTemplate("Default")

-- Create move button for map
local movebutton = CreateFrame("Frame", nil, WorldMapFrameSizeUpButton)
movebutton:Height(32)
movebutton:Width(32)
movebutton:Point("TOP", WorldMapFrameSizeUpButton, "BOTTOM", -1, 4)
movebutton:SetBackdrop({bgFile = "Interface\\AddOns\\ShestakUI\\Media\\Textures\\Cross.tga"})
movebutton:EnableMouse(true)

movebutton:SetScript("OnMouseDown", function()
	if InCombatLockdown() then return end
	WorldMapScreenAnchor:ClearAllPoints()
	WorldMapFrame:ClearAllPoints()
	WorldMapFrame:StartMoving()
	WorldMapBlobFrame:Hide()
end)

movebutton:SetScript("OnMouseUp", function()
	if InCombatLockdown() then return end
	WorldMapFrame:StopMovingOrSizing()
	WorldMapScreenAnchor:StartMoving()
	WorldMapScreenAnchor:StopMovingOrSizing()
	WorldMapBlobFrame:Show()
	WorldMapFrame:Hide()
	WorldMapFrame:Show()
end)

local SmallerMap = GetCVarBool("miniWorldMap")
if SmallerMap == nil then
	SetCVar("miniWorldMap", 1)
end

-- Styling World Map
local SmallerMapSkin = function()
	mapbg:SetScale(1 / mapscale)
	mapbg:Point("TOPLEFT", WorldMapDetailFrame, -2, 2)
	mapbg:Point("BOTTOMRIGHT", WorldMapDetailFrame, 2, -2)
	mapbg:SetFrameStrata("MEDIUM")
	mapbg:SetFrameLevel(20)

	WorldMapButton:SetAllPoints(WorldMapDetailFrame)
	WorldMapFrame:SetFrameStrata("MEDIUM")
	WorldMapFrame:SetClampedToScreen(true)
	WorldMapFrame:SetClampRectInsets(12, 227, -31, -134)
	WorldMapFrame:ClearAllPoints()
	WorldMapFrame:SetPoint(unpack(C.position.map))

	WorldMapDetailFrame:SetFrameStrata("MEDIUM")

	WorldMapTitleButton:Show()
	WorldMapTitleButton:SetFrameStrata("MEDIUM")
	WorldMapTooltip:SetFrameStrata("TOOLTIP")

	WorldMapFrameMiniBorderLeft:Hide()
	WorldMapFrameMiniBorderRight:Hide()

	WorldMapFrameSizeUpButton:ClearAllPoints()
	WorldMapFrameSizeUpButton:Point("TOPRIGHT", WorldMapButton, "TOPRIGHT", 3, -18)
	WorldMapFrameSizeUpButton:SetFrameStrata("HIGH")
	WorldMapFrameSizeUpButton:SetFrameLevel(18)

	WorldMapFrameCloseButton:ClearAllPoints()
	WorldMapFrameCloseButton:Point("TOPRIGHT", WorldMapButton, "TOPRIGHT", 3, 3)
	WorldMapFrameCloseButton:SetFrameStrata("HIGH")

	WorldMapFrameSizeDownButton:Point("TOPRIGHT", WorldMapFrameMiniBorderRight, "TOPRIGHT", -66, 7)

	WorldMapFrameTitle:ClearAllPoints()
	WorldMapFrameTitle:SetParent(WorldMapDetailFrame)
	WorldMapFrameTitle:Point("TOP", WorldMapDetailFrame, 0, -3)
	WorldMapFrameTitle:SetFont(C.media.normal_font, 17)

	WorldMapQuestShowObjectivesText:SetFont(C.media.normal_font, 13)
	WorldMapQuestShowObjectivesText:ClearAllPoints()
	WorldMapQuestShowObjectivesText:Point("BOTTOMRIGHT", WorldMapButton, "BOTTOMRIGHT", 0, 4)

	WorldMapQuestShowObjectives:ClearAllPoints()
	WorldMapQuestShowObjectives:Point("RIGHT", WorldMapQuestShowObjectivesText, "LEFT", 0, 0)
	WorldMapQuestShowObjectives:SetFrameStrata("HIGH")

	WorldMapTrackQuest:ClearAllPoints()
	WorldMapTrackQuest:Point("BOTTOMLEFT", WorldMapButton, "BOTTOMLEFT", 0, 0)
	WorldMapTrackQuest:SetFrameStrata("HIGH")

	WorldMapTrackQuestText:SetFont(C.media.normal_font, 13)

	WorldMapShowDigSites:ClearAllPoints()
	WorldMapShowDigSites:Point("BOTTOM", WorldMapQuestShowObjectives, "TOP", 0, 0)
	WorldMapShowDigSites:SetFrameStrata("HIGH")

	WorldMapShowDigSitesText:SetFont(C.media.normal_font, 13)
	WorldMapShowDigSitesText:ClearAllPoints()
	WorldMapShowDigSitesText:Point("LEFT", WorldMapShowDigSites, "RIGHT", 0, 0)

	WorldMapFrameAreaLabel:SetFont(C.media.normal_font, 40)
	WorldMapFrameAreaLabel:SetShadowOffset(2, -2)
	WorldMapFrameAreaLabel:SetTextColor(0.9, 0.83, 0.64)

	WorldMapFrameAreaDescription:SetFont(C.media.normal_font, 40)
	WorldMapFrameAreaDescription:SetShadowOffset(2, -2)

	WorldMapLevelDropDown:SetAlpha(0)
	WorldMapLevelDropDown:SetScale(0.00001)

	WorldMapShowDropDown:SetScale(0.85)
	WorldMapShowDropDown:ClearAllPoints()
	WorldMapShowDropDown:Point("TOPRIGHT", WorldMapButton, "TOPRIGHT", -15, -3)
	WorldMapShowDropDown:SetFrameStrata("HIGH")

	-- Fix tooltip not hidding after leaving quest # tracker icon
	hooksecurefunc("WorldMapQuestPOI_OnLeave", function() WorldMapTooltip:Hide() end)
end
hooksecurefunc("WorldMap_ToggleSizeDown", function() SmallerMapSkin() end)

local BiggerMapSkin = function()
	WorldMapFrame:EnableKeyboard(nil)
	WorldMapFrame:EnableMouse(nil)

	UIPanelWindows["WorldMapFrame"].area = "center"
	WorldMapFrame:SetAttribute("UIPanelLayout-defined", nil)

	WorldMapFrame:ClearAllPoints()
	WorldMapFrame:SetPoint("CENTER")

	WorldMapLevelDropDown:SetAlpha(1)
	WorldMapLevelDropDown:SetScale(1)

	WorldMapFrameTitle:SetParent(WorldMapPositioningGuide)
	WorldMapFrameTitle:SetFont(C.media.normal_font, 13)
	WorldMapFrameTitle:ClearAllPoints()
	WorldMapFrameTitle:Point("TOP", WorldMapPositioningGuide, "TOP", 0, -5)

	WorldMapQuestShowObjectivesText:SetFont(C.media.normal_font, 12)
	WorldMapQuestShowObjectivesText:ClearAllPoints()
	WorldMapQuestShowObjectivesText:Point("BOTTOMRIGHT", WorldMapPositioningGuide, "BOTTOMRIGHT", -10, 10)

	WorldMapQuestShowObjectives:ClearAllPoints()
	WorldMapQuestShowObjectives:Point("RIGHT", WorldMapQuestShowObjectivesText, "LEFT", 0, 0)
	WorldMapQuestShowObjectives:SetFrameStrata("TOOLTIP")

	WorldMapShowDigSitesText:SetFont(C.media.normal_font, 12)
	WorldMapShowDigSitesText:ClearAllPoints()
	WorldMapShowDigSitesText:Point("RIGHT", WorldMapQuestShowObjectives, "LEFT", 0, 0)

	WorldMapShowDigSites:ClearAllPoints()
	WorldMapShowDigSites:Point("RIGHT", WorldMapShowDigSitesText, "LEFT", 0, 0)
	WorldMapShowDigSites:SetFrameStrata("TOOLTIP")

	WorldMapTrackQuest:ClearAllPoints()
	WorldMapTrackQuest:Point("BOTTOMLEFT", WorldMapPositioningGuide, "BOTTOMLEFT", 10, 3)
	WorldMapTrackQuest:SetFrameStrata("HIGH")

	WorldMapTrackQuestText:SetFont(C.media.normal_font, 12)

	WorldMapShowDropDown:SetScale(1)
	WorldMapShowDropDown:ClearAllPoints()
	WorldMapShowDropDown:Point("BOTTOMRIGHT", WorldMapPositioningGuide, "BOTTOMRIGHT", 10, -3)
	WorldMapShowDropDown:SetFrameStrata("HIGH")
end
hooksecurefunc("WorldMap_ToggleSizeUp", function() BiggerMapSkin() end)

mapbg:SetScript("OnShow", function(self)
	local SmallerMap = GetCVarBool("miniWorldMap")
	if SmallerMap == nil then
		BiggerMapSkin()
	end
	self:SetScript("OnShow", function() end)
end)

local addon = CreateFrame("Frame")
addon:RegisterEvent("PLAYER_ENTERING_WORLD")
addon:RegisterEvent("PLAYER_REGEN_ENABLED")
addon:RegisterEvent("PLAYER_REGEN_DISABLED")
addon:SetScript("OnEvent", function(self, event)
	if event == "PLAYER_ENTERING_WORLD" then
		SetCVar("questPOI", 1)
		BlackoutWorld:Hide()
		BlackoutWorld.Show = function() end
		BlackoutWorld.Hide = function() end
		WorldMapBlobFrame.Show = function() end
		WorldMapBlobFrame.Hide = function() end
		WorldMapQuestPOI_OnLeave = function()
			WorldMapTooltip:Hide()
		end
		WorldMap_ToggleSizeDown()
		if FeedbackUIMapTip then 
			FeedbackUIMapTip:Hide()
			FeedbackUIMapTip.Show = function() end
		end
	elseif event == "PLAYER_REGEN_DISABLED" then
		WorldMapFrameSizeUpButton:Disable()
		WorldMap_ToggleSizeDown()
		WorldMapBlobFrame:DrawBlob(WORLDMAP_SETTINGS.selectedQuestId, false)
		WorldMapBlobFrame:DrawBlob(WORLDMAP_SETTINGS.selectedQuestId, true)
	elseif event == "PLAYER_REGEN_ENABLED" then
		WorldMapFrameSizeUpButton:Enable()
	end
end)

----------------------------------------------------------------------------------------
--	Creating coords
----------------------------------------------------------------------------------------
local coords = CreateFrame("Frame", "CoordsFrame", WorldMapFrame)
coords.PlayerText = WorldMapButton:CreateFontString(nil, "ARTWORK", "GameFontNormal")
coords.PlayerText:SetFont(C.media.normal_font, 17)
coords.PlayerText:SetJustifyH("LEFT")
coords.PlayerText:SetText(UnitName("player")..": 0,0")
if IsAddOnLoaded("_NPCScan.Overlay") then
	coords.PlayerText:Point("TOPLEFT", WorldMapButton, "TOPLEFT", 3, -50)
else
	coords.PlayerText:Point("TOPLEFT", WorldMapButton, "TOPLEFT", 3, -3)
end

coords.MouseText = WorldMapButton:CreateFontString(nil, "ARTWORK", "GameFontNormal")
coords.MouseText:SetFont(C.media.normal_font, 17)
coords.MouseText:SetJustifyH("LEFT")
coords.MouseText:Point("TOPLEFT", coords.PlayerText, "BOTTOMLEFT", 0, -3)
coords.MouseText:SetText(L_MAP_CURSOR..": 0,0")

local int = 0
coords:SetScript("OnUpdate", function(self, elapsed)
	int = int + 1

	if int >= 3 then
		local inInstance, _ = IsInInstance()
		local x,y = GetPlayerMapPosition("player")
		x = math.floor(100 * x)
		y = math.floor(100 * y)
		if x ~= 0 and y ~= 0 then
			self.PlayerText:SetText(UnitName("player")..": "..x..","..y)
		else
			self.PlayerText:SetText(UnitName("player")..": ".."|cffff0000"..L_MAP_BOUNDS.."|r")
		end

		local scale = WorldMapDetailFrame:GetEffectiveScale()
		local width = WorldMapDetailFrame:GetWidth()
		local height = WorldMapDetailFrame:GetHeight()
		local centerX, centerY = WorldMapDetailFrame:GetCenter()
		local x, y = GetCursorPosition()
		local adjustedX = (x / scale - (centerX - (width/2))) / width
		local adjustedY = (centerY + (height/2) - y / scale) / height

		if adjustedX >= 0 and adjustedY >= 0 and adjustedX <= 1 and adjustedY <= 1 then
			adjustedX = math.floor(100 * adjustedX)
			adjustedY = math.floor(100 * adjustedY)
			coords.MouseText:SetText(L_MAP_CURSOR..adjustedX..","..adjustedY)
		else
			coords.MouseText:SetText(L_MAP_CURSOR.."|cffff0000"..L_MAP_BOUNDS.."|r")
		end

		int = 0
	end
end)

-- edit by Oz of shestak. org --