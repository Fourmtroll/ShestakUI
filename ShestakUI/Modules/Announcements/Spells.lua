local T, C, L, _ = unpack(select(2, ...))
if C.announcements.spells ~= true then return end

----------------------------------------------------------------------------------------
--	Announce some spells
----------------------------------------------------------------------------------------
local frame = CreateFrame("Frame")
frame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
frame:SetScript("OnEvent", function(self, _, ...)
	local _, event, _, sourceGUID, sourceName, _, _, _, destName, _, _, spellID = ...
	local inInstance, instanceType = IsInInstance()
	local spells = T.AnnounceSpells
	if not (inInstance and (instanceType == "raid" or instanceType == "party")) then return end

	if event == "SPELL_CAST_SUCCESS" or event == "SPELL_RESURRECT" then
		if C.announcements.spells_from_all == true then
			if not (destName and sourceName) then return end

			for i, spells in pairs(spells) do
				if spellID == spells then
					if IsInRaid() then
						SendChatMessage(GetSpellLink(spellID)..": "..sourceName.." -> "..destName, "RAID")
					elseif IsInGroup() then
						SendChatMessage(GetSpellLink(spellID)..": "..sourceName.." -> "..destName, "PARTY")
					else
						SendChatMessage(GetSpellLink(spellID)..": "..sourceName.." -> "..destName, "SAY")
					end
				end
			end
		else
			if not (sourceGUID == UnitGUID("player") and destName) then return end

			for i, spells in pairs(spells) do
				if spellID == spells then
					if IsInRaid() then
						SendChatMessage(GetSpellLink(spellID).." -> "..destName, "RAID")
					elseif IsInGroup() then
						SendChatMessage(GetSpellLink(spellID).." -> "..destName, "PARTY")
					else
						SendChatMessage(GetSpellLink(spellID).." -> "..destName, "SAY")
					end
				end
			end
		end
	end
end)