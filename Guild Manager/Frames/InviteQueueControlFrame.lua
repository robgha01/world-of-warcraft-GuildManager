-- Author      : Robert
-- Create Date : 9/1/2017 12:31:44 PM

--Table Sorter--
function pairsByKeysIQ(GMIQt)
	local GMIQtsort = {}
		for k,v in pairs(GMIQt) do table.insert(GMIQtsort, v) end
		table.sort(GMIQtsort)
		local i = 0      -- iterator variable
		local iter = function ()   -- iterator function
			i = i + 1
			if GMIQtsort[i] == nil then return nil
			else return GMIQtsort[i], t[GMIQtsort[i]]
			end
		end
		GuildManager.db.profile.GMIQt=GMIQtsort
end

--Table Interface--
function GuildManager:IQUI()
    local IQframe = GUI:Create("Frame")
    IQframe:SetTitle("Invite Queue Control")
    IQframe:SetCallback("OnClose", function(widget) GUI:Release(widget) end)
    IQframe:SetWidth(350)
    IQframe:SetHeight(200)
    IQframe:SetLayout("Flow")

    local addIQbutton = GUI:Create("Button")
    addIQbutton:SetText("Add Name")
    addIQbutton:SetWidth(150)
    addIQbutton:SetCallback("OnClick", function()
        if GMIQAddName~=nil then
            if string.match(GMIQAddName, "-") then
            else
                GMIQAddName = strjoin("-",GMIQAddName,GetRealmName());
            end
            if tContains(GuildManager.db.profile.GMIQt, GMIQAddName)~=1 then
                table.insert(GuildManager.db.profile.GMIQt, GMIQAddName)
                GMIQt=GuildManager.db.profile.GMIQt
                pairsByKeysIQ(GMIQt)
                GuildManager:Print(strjoin(" ",GMIQAddName,"has been added to the Invite Queue"))
            else
                GuildManager:Print(strjoin(" ",GMIQAddName,"is on the Invite Queue. The list will update when the interface closes."))
            end
        else
            GuildManager:Print("ERROR! You must type a name!")
        end
    end)
    IQframe:AddChild(addIQbutton)

    local addIQ = GUI:Create("EditBox")
    addIQ:SetLabel("Insert Name:")
    addIQ:SetWidth(150)
    addIQ:SetCallback("OnEnterPressed", function(GMIQtext)
        for k,v in pairs(GMIQtext) do
            if (k=="lasttext") then
                GMIQAddName=v
            end
        end
    end)
    IQframe:AddChild(addIQ)

    local removeIQbutton = GUI:Create("Button")
    removeIQbutton:SetText("Remove Name")
    removeIQbutton:SetWidth(150)
    removeIQbutton:SetCallback("OnClick", function()
        if GMIQChoice~=nil then
            if tContains(GuildManager.db.profile.GMIQt, GMIQChoice)==1 then
                GuildManager:Print(strjoin(" ",GMIQChoice,"was removed from the Invite Queue"))
                GuildManager:tremovebyval(GuildManager.db.profile.GMIQt, GMIQChoice)
            else
                GuildManager:Print(strjoin(" ",GMIQChoice,"is not in the Invite Queue. The list will update when the interface closes."))
            end
        else
            GuildManager:Print("ERROR! You must select a name!")
        end
    end)
    IQframe:AddChild(removeIQbutton)

    local IQDropDown = GUI:Create("Dropdown")
    IQDropDown:SetList(GuildManager.db.profile.GMIQt)
    IQDropDown:SetWidth(150)
    IQDropDown:SetCallback("OnValueChanged", function(IQChoice)
        for k,v in pairs(IQChoice) do
            if (k=="value") then
                GMIQChoiceindex=v
            end
        end
        for k,v in pairs(GuildManager.db.profile.GMIQt) do
            if GMIQChoiceindex==k then
                GMIQChoice=v
            end
        end
    end)
    IQframe:AddChild(IQDropDown)

    local purgeIQbutton = GUI:Create("Button")
    purgeIQbutton:SetText("Purge List")
    purgeIQbutton:SetWidth(150)
    purgeIQbutton:SetCallback("OnClick", function()
        if GuildManager.db.profile.GMIQt~={} then
            GuildManager.db.profile.GMIQt = {}
            GuildManager:Print("The Invite Queue has been purged")
        else
            GuildManager:Print("The Invite Queue is empty. It will update when the interface closes.")
        end
    end)
    IQframe:AddChild(purgeIQbutton)

    local inviteIQbutton = GUI:Create("Button")
    inviteIQbutton:SetText("Invite!")
    inviteIQbutton:SetWidth(150)
    inviteIQbutton:SetCallback("OnClick", function()
        if #(GuildManager.db.profile.GMIQt)~=0 then
            for k,v in pairs(GuildManager.db.profile.GMIQt) do
                if 1==k then
                    GMIQtop=v
                    if string.match(GMIQtop, "-") then
                    else
                        GMIQtop = strjoin("-",GMIQtop,GetRealmName());
                    end
                    if tContains(GuildManager.db.profile.GMDNIt, GMIQtop)~=1 then
                        table.insert(GuildManager.db.profile.GMDNIt, GMIQtop)
                        GMDNIt=GuildManager.db.profile.GMDNIt
                        pairsByKeysDNI(GMDNIt)
                    end
                end
            end
            if GuildManager.db.profile.whisperonly==false then
                GuildInvite(GMIQtop)
            else
                SendChatMessage(GuildManager.db.profile.whispmessage,"WHISPER",nil,GMIQtop)
            end
            GuildManager:tremovebyval(GuildManager.db.profile.GMIQt, GMIQtop)
        else
            GuildManager:Print("The Invitation Queue is Empty!")
        end
    end)
    IQframe:AddChild(inviteIQbutton)
end