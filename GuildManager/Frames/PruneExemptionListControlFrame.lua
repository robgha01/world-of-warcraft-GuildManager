-- Author      : Robert
-- Create Date : 9/1/2017 12:34:14 PM

local GUI = LibStub("AceGUI-3.0")

--Table Sorter--
function pairsByKeysPruneExempt(GMPruneExemptt)
	local GMPruneExempttsort = {}
		for k,v in pairs(GMPruneExemptt) do table.insert(GMPruneExempttsort, v) end
		table.sort(GMPruneExempttsort)
		local i = 0      -- iterator variable
		local iter = function ()   -- iterator function
			i = i + 1
			if GMPruneExempttsort[i] == nil then return nil
			else return GMPruneExempttsort[i], t[GMPruneExempttsort[i]]
			end
		end
		GuildManager.db.profile.GMPruneExemptt=GMPruneExempttsort
end

--Table Interface--
function GuildManager:PruneExemptUI()
    local PruneExemptframe = GUI:Create("Frame")
    PruneExemptframe:SetTitle("Prune Exemption List Control")
    PruneExemptframe:SetCallback("OnClose", function(widget) GUI:Release(widget) end)
    PruneExemptframe:SetWidth(350)
    PruneExemptframe:SetHeight(200)
    PruneExemptframe:SetLayout("Flow")

    local addPruneExemptbutton = GUI:Create("Button")
    addPruneExemptbutton:SetText("Add Name")
    addPruneExemptbutton:SetWidth(150)
    addPruneExemptbutton:SetCallback("OnClick", function()
        if GMPruneExemptAddName~=nil then
            if string.match(GMPruneExemptAddName, "-") then
            else
                GMPruneExemptAddName = strjoin("-",GMPruneExemptAddName,GetRealmName());
            end
            if tContains(GuildManager.db.profile.GMPruneExemptt, GMPruneExemptAddName)~=1 then
                table.insert(GuildManager.db.profile.GMPruneExemptt, GMPruneExemptAddName)
                GMPruneExemptt=GuildManager.db.profile.GMPruneExemptt
                pairsByKeysPruneExempt(GMPruneExemptt)
                GuildManager:Print(strjoin(" ",GMPruneExemptAddName,"has been added to the Prune Exemption List."))
            else
                GuildManager:Print(strjoin(" ",GMPruneExemptAddName,"is on the Prune Exemption List. The list will update when the interface closes."))
            end
        else
            GuildManager:Print("ERROR! You must type a name!")
        end
    end)
    PruneExemptframe:AddChild(addPruneExemptbutton)

    local addPruneExempt = GUI:Create("EditBox")
    addPruneExempt:SetLabel("Insert Name:")
    addPruneExempt:SetWidth(150)
    addPruneExempt:SetCallback("OnEnterPressed", function(GMPruneExempttext)
        for k,v in pairs(GMPruneExempttext) do
            if (k=="lasttext") then
                GMPruneExemptAddName=v
            end
        end
    end)
    PruneExemptframe:AddChild(addPruneExempt)

    local removePruneExemptbutton = GUI:Create("Button")
    removePruneExemptbutton:SetText("Remove Name")
    removePruneExemptbutton:SetWidth(150)
    removePruneExemptbutton:SetCallback("OnClick", function()
        if GMPruneExemptChoice~=nil then
            if tContains(GuildManager.db.profile.GMPruneExemptt, GMPruneExemptChoice)==1 then
                GuildManager:Print(strjoin(" ",GMPruneExemptChoice,"was removed from the Prune Exemption List"))
                GuildManager:tremovebyval(GuildManager.db.profile.GMPruneExemptt, GMPruneExemptChoice)
            else
                GuildManager:Print(strjoin(" ",GMPruneExemptChoice,"is not on the Prune Exemption List. The list will update when the interface closes."))
            end
        else
            GuildManager:Print("ERROR! You must select a name!")
        end
    end)
    PruneExemptframe:AddChild(removePruneExemptbutton)

    local PruneExemptDropDown = GUI:Create("Dropdown")
    PruneExemptDropDown:SetList(GuildManager.db.profile.GMPruneExemptt)
    PruneExemptDropDown:SetWidth(150)
    PruneExemptDropDown:SetCallback("OnValueChanged", function(PruneExemptChoice)
        for k,v in pairs(PruneExemptChoice) do
            if (k=="value") then
                GMPruneExemptChoiceindex=v
            end
        end
        for k,v in pairs(GuildManager.db.profile.GMPruneExemptt) do
            if GMPruneExemptChoiceindex==k then
                GMPruneExemptChoice=v
            end
        end
    end)
    PruneExemptframe:AddChild(PruneExemptDropDown)

    local purgePruneExemptbutton = GUI:Create("Button")
    purgePruneExemptbutton:SetText("Purge List")
    purgePruneExemptbutton:SetWidth(150)
    purgePruneExemptbutton:SetCallback("OnClick", function()
        if GuildManager.db.profile.GMPruneExemptt~={} then
            GuildManager.db.profile.GMPruneExemptt = {}
            GuildManager:Print("The Prune Exemption List has been purged")
        else
            GuildManager:Print("The Prune Exemption List is empty. It will update when the interface closes.")
        end
    end)
    PruneExemptframe:AddChild(purgePruneExemptbutton)
end