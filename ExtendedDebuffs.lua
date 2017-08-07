local _, NAMESPACE = ...

local options = NAMESPACE.options
local ICON_SIZE = options.iconSize

local pciscript = CreateFrame("Frame")
pciscript:RegisterEvent("PLAYER_ENTERING_WORLD")

local function eventHandler(self, event)
	LoadAddOn("Blizzard_CompactRaidFrames")
	CRFSort_Group = function(t1, t2)
		if UnitIsUnit(t1, "player") then
			return false
		elseif UnitIsUnit(t2, "player") then
			return true
		else
			return t1 < t2
		end
		DEFAULT_CHAT_GLOBAL:AddMessage("ExtendedDebuffs successfully Loaded!", 0.0, 1.0, 0.0, nil, true)
	end
	CompactRaidFrameContainer.flowSortFunc = CRFSort_Group
end

pciscript:SetScript("OnEvent", eventHandler)

function sp(f, i)
	local tr = "TOPRIGHT"
	local br = "BOTTOMRIGHT"
	local tf = f.debuffFrames
	local df = tf[i]
	df:SetSize(ICON_SIZE, ICON_SIZE)
	df:ClearAllPoints()
	if i > 6 then
		df:SetPoint(br, tf[i - 3], tr, 0, 0)
	else
		df:SetPoint(tr, tf[1], tr, - (ICON_SIZE * (i - 3)), 0)
	end
end

function cf(f, i)
	bf = CreateFrame("Button", f:GetName().."Debuff"..i, f, "CompactDebuffTemplate")
	bf.baseSize = ICON_SIZE
	bf:SetSize(ICON_SIZE, ICON_SIZE)
end

function mv(f)
	for i = 4, 12 do
		sp(f, i)
	end
end

function mv3(f)
	CompactUnitFrame_SetMaxDebuffs(f, 12)
	if not f.debuffFrames[4] then
		for i = 4, 12 do
			cf(f, i)
		end
	end
	mv(f)
end

hooksecurefunc("CompactUnitFrame_UpdateDebuffs", function(f)
	if f:GetName():match("^Compact") then
		mv3(f)
	end
end)

NAMESPACE.options = nil
