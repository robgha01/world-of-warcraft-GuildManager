-- Author      : Robert
-- Create Date : 9/1/2017 12:34:49 PM

local GUI = LibStub("AceGUI-3.0")

--Table Sorter--
function pairsByKeysDemoteExempt(GMDemoteExemptt)
	local GMDemoteExempttsort = {}
		for k,v in pairs(GMDemoteExemptt) do table.insert(GMDemoteExempttsort, v) end
		table.sort(GMDemoteExempttsort)
		local i = 0      -- iterator variable
		local iter = function ()   -- iterator function
			i = i + 1
			if GMDemoteExempttsort[i] == nil then return nil
			else return GMDemoteExempttsort[i], t[GMDemoteExempttsort[i]]
			end
		end
		GuildManager.db.profile.GMDemoteExemptt=GMDemoteExempttsort
end

--Table Interface--
function GuildManager:DemoteExemptUI()
    local DemoteExemptframe = GUI:Create("Frame")
    DemoteExemptframe:SetTitle("Demote Exemption List Control")
    DemoteExemptframe:SetCallback("OnClose", function(widget) GUI:Release(widget) end)
    DemoteExemptframe:SetWidth(350)
    DemoteExemptframe:SetHeight(200)
    DemoteExemptframe:SetLayout("Flow")

    local addDemoteExemptbutton = GUI:Create("Button")
    addDemoteExemptbutton:SetText("Add Name")
    addDemoteExemptbutton:SetWidth(150)
    addDemoteExemptbutton:SetCallback("OnClick", function()
        if GMDemoteExemptAddName~=nil then
            if string.match(GMDemoteExemptAddName, "-") then
            else
                GMDemoteExemptAddName = strjoin("-",GMDemoteExemptAddName,GetRealmName());
            end
            if tContains(GuildManager.db.profile.GMDemoteExemptt, GMDemoteExemptAddName)~=1 then
                table.insert(GuildManager.db.profile.GMDemoteExemptt, GMDemoteExemptAddName)
                GMDemoteExemptt=GuildManager.db.profile.GMDemoteExemptt
                pairsByKeysDemoteExempt(GMDemoteExemptt)
                GuildManager:Print(strjoin(" ",GMDemoteExemptAddName,"has been added to the Demote Exemption List."))
            else
                GuildManager:Print(strjoin(" ",GMDemoteExemptAddName,"is on the Demote Exemption List. The list will update when the interface closes."))
            end
        else
            GuildManager:Print("ERROR! You must type a name!")
        end
    end)
    DemoteExemptframe:AddChild(addDemoteExemptbutton)

    local addDemoteExempt = GUI:Create("EditBox")
    addDemoteExempt:SetLabel("Insert Name:")
    addDemoteExempt:SetWidth(150)
    addDemoteExempt:SetCallback("OnEnterPressed", function(GMDemoteExempttext)
        for k,v in pairs(GMDemoteExempttext) do
            if (k=="lasttext") then
                GMDemoteExemptAddName=v
            end
        end
    end)
    DemoteExemptframe:AddChild(addDemoteExempt)

    local removeDemoteExemptbutton = GUI:Create("Button")
    removeDemoteExemptbutton:SetText("Remove Name")
    removeDemoteExemptbutton:SetWidth(150)
    removeDemoteExemptbutton:SetCallback("OnClick", function()
        if GMDemoteExemptChoice~=nil then
            if tContains(GuildManager.db.profile.GMDemoteExemptt, GMDemoteExemptChoice)==1 then
                GuildManager:Print(strjoin(" ",GMDemoteExemptChoice,"was removed from the Demote Exemption List"))
                GuildManager:tremovebyval(GuildManager.db.profile.GMDemoteExemptt, GMDemoteExemptChoice)
            else
                GuildManager:Print(strjoin(" ",GMDemoteExemptChoice,"is not on the Demote Exemption List. The list will update when the interface closes."))
            end
        else
            GuildManager:Print("ERROR! You must select a name!")
        end
    end)
    DemoteExemptframe:AddChild(removeDemoteExemptbutton)

    local DemoteExemptDropDown = GUI:Create("Dropdown")
    DemoteExemptDropDown:SetList(GuildManager.db.profile.GMDemoteExemptt)
    DemoteExemptDropDown:SetWidth(150)
    DemoteExemptDropDown:SetCallback("OnValueChanged", function(DemoteExemptChoice)
        for k,v in pairs(DemoteExemptChoice) do
            if (k=="value") then
                GMDemoteExemptChoiceindex=v
            end
        end
        for k,v in pairs(GuildManager.db.profile.GMDemoteExemptt) do
            if GMDemoteExemptChoiceindex==k then
                GMDemoteExemptChoice=v
            end
        end
    end)
    DemoteExemptframe:AddChild(DemoteExemptDropDown)

    local purgeDemoteExemptbutton = GUI:Create("Button")
    purgeDemoteExemptbutton:SetText("Purge List")
    purgeDemoteExemptbutton:SetWidth(150)
    purgeDemoteExemptbutton:SetCallback("OnClick", function()
        if GuildManager.db.profile.GMDemoteExemptt~={} then
            GuildManager.db.profile.GMDemoteExemptt = {}
            GuildManager:Print("The Demote Exemption List has been purged")
        else
            GuildManager:Print("The Demote Exemption List is empty. It will update when the interface closes.")
        end
    end)
    DemoteExemptframe:AddChild(purgeDemoteExemptbutton)
end
