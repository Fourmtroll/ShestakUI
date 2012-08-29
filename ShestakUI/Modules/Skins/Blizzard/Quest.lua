local T, C, L = unpack(select(2, ...))
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	Quest skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	QuestFrame:StripTextures(true)
	QuestFrameInset:StripTextures(true)
	QuestFrameDetailPanel:StripTextures(true)
	QuestDetailScrollFrame:StripTextures(true)
	QuestDetailScrollChildFrame:StripTextures(true)
	QuestRewardScrollFrame:StripTextures(true)
	QuestRewardScrollChildFrame:StripTextures(true)
	QuestProgressScrollFrame:StripTextures(true)
	QuestFrameProgressPanel:StripTextures(true)
	QuestFrameRewardPanel:StripTextures(true)

	QuestFrame:CreateBackdrop("Transparent")
	QuestFrame.backdrop:Point("TOPLEFT", 0, 0)
	QuestFrame.backdrop:Point("BOTTOMRIGHT", 0, 0)

	QuestFrameAcceptButton:SkinButton(true)
	QuestFrameDeclineButton:SkinButton(true)
	QuestFrameCompleteButton:SkinButton(true)
	QuestFrameGoodbyeButton:SkinButton(true)
	QuestFrameCompleteQuestButton:SkinButton(true)

	T.SkinCloseButton(QuestFrameCloseButton, QuestFrame.backdrop)

	for i = 1, 6 do
		local button = _G["QuestProgressItem"..i]
		local texture = _G["QuestProgressItem"..i.."IconTexture"]

		button:StripTextures()
		button:StyleButton()
		button:SetTemplate("Overlay")
		button:Width(_G["QuestProgressItem"..i]:GetWidth() - 4)
		button:SetFrameLevel(button:GetFrameLevel() + 2)

		texture:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		texture:SetDrawLayer("OVERLAY")
		texture:Point("TOPLEFT", 2, -2)
		texture:Size(texture:GetWidth() - 2, texture:GetHeight() - 2)

		_G["QuestProgressItem"..i.."Count"]:SetDrawLayer("OVERLAY")
		_G["QuestProgressItem"..i.."Name"]:SetFont(C.media.normal_font, 12)
		_G["QuestProgressItem"..i.."Name"]:SetDrawLayer("OVERLAY")
	end

	hooksecurefunc("QuestFrameProgressItems_Update", function()
		QuestProgressTitleText:SetTextColor(1, 0.8, 0)
		QuestProgressTitleText:SetShadowColor(0, 0, 0)
		QuestProgressText:SetTextColor(1, 1, 1)
		QuestProgressRequiredItemsText:SetTextColor(1, 0.8, 0)
		QuestProgressRequiredItemsText:SetShadowColor(0, 0, 0)
		QuestProgressRequiredMoneyText:SetTextColor(1, 0.8, 0)
	end)

	QuestNPCModel:StripTextures()
	QuestNPCModel:CreateBackdrop("Transparent")
	QuestNPCModelTextFrame:StripTextures()
	QuestNPCModelTextFrame:CreateBackdrop("Overlay")
	QuestNPCModelTextFrame.backdrop:Point("TOPLEFT", QuestNPCModel.backdrop, "BOTTOMLEFT", 0, -1)

	QuestLogDetailFrame:StripTextures()
	QuestLogDetailFrame:CreateBackdrop("Transparent")
	QuestLogDetailFrame.backdrop:Point("TOPLEFT", 0, 0)
	QuestLogDetailFrame.backdrop:Point("BOTTOMRIGHT", 0, 0)
	QuestLogDetailScrollFrame:StripTextures()
	QuestLogDetailFrameInset:StripTextures()
	T.SkinCloseButton(QuestLogDetailFrameCloseButton, QuestLogDetailFrame.backdrop)

	hooksecurefunc("QuestFrame_ShowQuestPortrait", function(parentFrame, portrait, text, name, x, y)
		QuestNPCModel:ClearAllPoints()
		QuestNPCModel:SetPoint("TOPLEFT", parentFrame, "TOPRIGHT", x + 10, y + 40)
	end)

	QuestLogDetailFrame:HookScript("OnShow", function()
		QuestLogFrameAbandonButton:ClearAllPoints()
		QuestLogFrameAbandonButton:Point("BOTTOMLEFT", QuestLogDetailFrame.backdrop, "BOTTOMLEFT", 4, 4)
		QuestLogFramePushQuestButton:Point("LEFT", QuestLogFrameAbandonButton, "RIGHT", 3, 0)
		QuestLogFramePushQuestButton:Point("RIGHT", QuestLogFrameTrackButton, "LEFT", -3, 0)
		QuestLogFrameTrackButton:Point("BOTTOMRIGHT", QuestLogDetailFrame.backdrop, "BOTTOMRIGHT", -4, 4)
	end)
end

tinsert(T.SkinFuncs["ShestakUI"], LoadSkin)