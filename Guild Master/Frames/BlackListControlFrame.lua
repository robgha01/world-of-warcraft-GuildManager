-- Author      : Robert
-- Create Date : 9/1/2017 12:33:28 PM

--Table Sorter--
function pairsByKeysBlack(GMBlackt)
	local GMBlacktsort = {}
		for k,v in pairs(GMBlackt) do table.insert(GMBlacktsort, v) end
		table.sort(GMBlacktsort)
		local i = 0      -- iterator variable
		local iter = function ()   -- iterator function
			i = i + 1
			if GMBlacktsort[i] == nil then return nil
			else return GMBlacktsort[i], t[GMBlacktsort[i]]
			end
		end
		GuildManager.db.profile.GMBlackt=GMBlacktsort
end

--Table Interface--
function GuildManager:BlackUI()
    local Blackframe = GUI:Create("Frame")
    Blackframe:SetTitle("Black List Control")
    Blackframe:SetCallback("OnClose", function(widget) GUI:Release(widget) end)
    Blackframe:SetWidth(350)
    Blackframe:SetHeight(200)
    Blackframe:SetLayout("Flow")

    local addBlackbutton = GUI:Create("Button")
    addBlackbutton:SetText("Add Name")
    addBlackbutton:SetWidth(150)
    addBlackbutton:SetCallback("OnClick", function()
        if GMBlackAddName~=nil then
            if string.match(GMBlackAddName, "-") then
            else
                GMBlackAddName = strjoin("-",GMBlackAddName,GetRealmName());
            end
            if tContains(GuildManager.db.profile.GMBlackt, GMBlackAddName)~=1 then
                table.insert(GuildManager.db.profile.GMBlackt, GMBlackAddName)
                GMBlackt=GuildManager.db.profile.GMBlackt
                pairsByKeysBlack(GMBlackt)
                GuildManager:Print(strjoin(" ",GMBlackAddName,"has been added to the Black List."))
                if GuildManager.db.profile.pruneannounce==3 then
                    SendChatMessage(strjoin(" ",GMBlackAddName,"has been added to the Black List and Banned from the guild! They will be autokicked if invited back!"),"guild", nil,"GUILD")
                end
                if GuildManager.db.profile.pruneannounce==2 then
                    SendChatMessage(strjoin(" ",GMBlackAddName,"has been added to the Black List and Banned from the guild! They will be autokicked if invited back!"),"officer", nil,"OFFICER")
                end
            else
                GuildManager:Print(strjoin(" ",GMBlackAddName,"is on the Black List. The list will update when the interface closes."))
            end
        else
            GuildManager:Print("ERROR! You must type a name!")
        end
    end)
    Blackframe:AddChild(addBlackbutton)

    local addBlack = GUI:Create("EditBox")
    addBlack:SetLabel("Insert Name:")
    addBlack:SetWidth(150)
    addBlack:SetCallback("OnEnterPressed", function(GMBlacktext)
        for k,v in pairs(GMBlacktext) do
            if (k=="lasttext") then
                GMBlackAddName=v
            end
        end
    end)
    Blackframe:AddChild(addBlack)

    local removeBlackbutton = GUI:Create("Button")
    removeBlackbutton:SetText("Remove Name")
    removeBlackbutton:SetWidth(150)
    removeBlackbutton:SetCallback("OnClick", function()
        if GMBlackChoice~=nil then
            if tContains(GuildManager.db.profile.GMBlackt, GMBlackChoice)==1 then
                GuildManager:Print(strjoin(" ",GMBlackChoice,"was removed from the Black List"))
                if GuildManager.db.profile.pruneannounce==3 then
                    SendChatMessage(strjoin(" ",GMBlackChoice,"has been removed from the Black List and is no longer Banned from the guild!"),"guild", nil,"GUILD")
                end
                if GuildManager.db.profile.pruneannounce==2 then
                    SendChatMessage(strjoin(" ",GMBlackChoice,"has been removed from the Black List and is no longer Banned from the guild!"),"officer", nil,"OFFICER")
                end
                GuildManager:tremovebyval(GuildManager.db.profile.GMBlackt, GMBlackChoice)
            else
                GuildManager:Print(strjoin(" ",GMBlackChoice,"is not on the Black List. The list will update when the interface closes."))
            end
        else
            GuildManager:Print("ERROR! You must select a name!")
        end
    end)
    Blackframe:AddChild(removeBlackbutton)

    local BlackDropDown = GUI:Create("Dropdown")
    BlackDropDown:SetList(GuildManager.db.profile.GMBlackt)
    BlackDropDown:SetWidth(150)
    BlackDropDown:SetCallback("OnValueChanged", function(BlackChoice)
        for k,v in pairs(BlackChoice) do
            if (k=="value") then
                GMBlackChoiceindex=v
            end
        end
        for k,v in pairs(GuildManager.db.profile.GMBlackt) do
            if GMBlackChoiceindex==k then
                GMBlackChoice=v
            end
        end
    end)
    Blackframe:AddChild(BlackDropDown)

    local purgeBlackbutton = GUI:Create("Button")
    purgeBlackbutton:SetText("Purge List")
    purgeBlackbutton:SetWidth(150)
    purgeBlackbutton:SetCallback("OnClick", function()
        if GuildManager.db.profile.GMBlackt~={} then
            GuildManager.db.profile.GMBlackt = {}
            GuildManager:Print("The Black List has been purged")
        else
            GuildManager:Print("The Black List is empty. It will update when the interface closes.")
        end
    end)
    Blackframe:AddChild(purgeBlackbutton)
end