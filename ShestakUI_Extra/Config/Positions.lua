﻿local T, C, L, _ = unpack(ShestakUI)

----------------------------------------------------------------------------------------
--	Position options
--	BACKUP THIS FILE BEFORE UPDATING!
----------------------------------------------------------------------------------------
C["extra_position"] = {
	["switch_spec"] = {"TOPLEFT", UIParent, "TOPLEFT", 519, -26},			-- Talent spec panel
	["mark_bar"] = {"CENTER", UIParent, "CENTER", 100, 50},					-- Mark bar
	["extra_bar"] = {"BOTTOM", ActionBarAnchor, "TOP", 0, 3},				-- Extra bar
	["archaeology"] = {"BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -21, 157},	-- Archaeology frame
	["bg_announce"] = {"CENTER", UIParent, "CENTER", 0, 0},					-- BG announce panel
	["tank_announce"] = {"BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -21, 157},	-- Tank announce panel
}

-- edit by Oz of shestak. org --