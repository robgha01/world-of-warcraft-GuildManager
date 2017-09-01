-- Author      : Robert
-- Create Date : 9/1/2017 12:32:44 PM

--Table Sorter--
function pairsByKeysDNI(GMDNIt)
	local GMDNItsort = {}
		for k,v in pairs(GMDNIt) do table.insert(GMDNItsort, v) end
		table.sort(GMDNItsort)
		local i = 0      -- iterator variable
		local iter = function ()   -- iterator function
			i = i + 1
			if GMDNItsort[i] == nil then return nil
			else return GMDNItsort[i], t[GMDNItsort[i]]
			end
		end
		GuildManager.db.profile.GMDNIt=GMDNItsort
end

--Table Interface--
function GuildManager:DNIUI()
    local DNIframe = GUI:Create("Frame")
    DNIframe:SetTitle("Do Not Invite List Control")
    DNIframe:SetCallback("OnClose", function(widget) GUI:Release(widget) end)
    DNIframe:SetWidth(350)
    DNIframe:SetHeight(200)
    DNIframe:SetLayout("Flow")

    local addDNIbutton = GUI:Create("Button")
    addDNIbutton:SetText("Add Name")
    addDNIbutton:SetWidth(150)
    addDNIbutton:SetCallback("OnClick", function()
        if GMDNIAddName~=nil then
            if string.match(GMDNIAddName, "-") then
            else
                GMDNIAddName = strjoin("-",GMDNIAddName,GetRealmName());
            end
            if tContains(GuildManager.db.profile.GMDNIt, GMDNIAddName)~=1 then
                table.insert(GuildManager.db.profile.GMDNIt, GMDNIAddName)
                GMDNIt=GuildManager.db.profile.GMDNIt
                pairsByKeysDNI(GMDNIt)
                GuildManager:Print(strjoin(" ",GMDNIAddName,"has been added to the Do Not Invite List."))
            else
                GuildManager:Print(strjoin(" ",GMDNIAddName,"is on the Do Not Invite List. The list will update when the interface closes."))
            end
        else
            GuildManager:Print("ERROR! You must type a name!")
        end
    end)
    DNIframe:AddChild(addDNIbutton)

    local addDNI = GUI:Create("EditBox")
    addDNI:SetLabel("Insert Name:")
    addDNI:SetWidth(150)
    addDNI:SetCallback("OnEnterPressed", function(GMDNItext)
        for k,v in pairs(GMDNItext) do
            if (k=="lasttext") then
                GMDNIAddName=v
            end
        end
    end)
    DNIframe:AddChild(addDNI)

    local purgeDNIbutton = GUI:Create("Button")
    purgeDNIbutton:SetText("Purge List")
    purgeDNIbutton:SetWidth(150)
    purgeDNIbutton:SetCallback("OnClick", function()
        if GuildManager.db.profile.GMDNIt~={} then
            GuildManager.db.profile.GMDNIt = {}
            GuildManager:Print("The Do Not Invite List has been purged")
        else
            GuildManager:Print("The Do Not Invite List is empty. It will update when the interface closes.")
        end
    end)
    DNIframe:AddChild(purgeDNIbutton)
end