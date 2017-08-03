function sp(f, i)
    tr = "TOPRIGHT";
    f2 = f.debuffFrames;
    s = f2[1]:GetWidth();
    f3 = f2[i];f3:SetSize(s, s);
    f3:ClearAllPoints();

	if i > 6 then
		f3:SetPoint("BOTTOMRIGHT", f2[i-3], tr, 0, 0)
	else
		f3:SetPoint(tr, f2[1], tr, -(s*(i-3)), 0)
    end
end

function CBF(f, i)
    bf = CreateFrame("Button",
        f:GetName().."Debuff"..i,
        f,
        "CompactDebuffTemplate"
    );

    bf.baseSize = 22;
    bf:SetSize(f.buffFrames[1]:GetSize())
end

function mv(f)
    for i=4,12 do sp(f,i) end
end

function mv3(f)
    CompactUnitFrame_SetMaxDebuffs(f, 12);
    
	if not f.debuffFrames[4] then
		for i = 4, 12 do
			CBF(f,i)
        end
    end

    mv(f)
end

hooksecurefunc("CompactUnitFrame_UpdateDebuffs", function(f)
    if f:GetName():match("^Compact") then mv3(f) end
end)
