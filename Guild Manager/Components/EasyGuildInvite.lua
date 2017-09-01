-- Author      : Robert
-- Create Date : 9/1/2017 12:02:51 PM

local EasyGInv = CreateFrame("Frame","EasyGInvFrame")
EasyGInv:SetScript("OnEvent", function() hooksecurefunc("UnitPopup_ShowMenu", EasyGInvCheck) end)
EasyGInv:RegisterEvent("PLAYER_LOGIN")

local PopupUnits = {"PARTY", "PLAYER", "RAID_PLAYER", "RAID", "FRIEND", "TEAM", "CHAT_ROSTER", "TARGET", "FOCUS", "GUILD", "GUILD_OFFLINE"}

local GInvButtonInfo = {
    text = "Invite To Guild",
    value = "EZ_GINV",
    func = function()
        if string.match(UIDROPDOWNMENU_OPEN_MENU.name, "-") then
            playerrealmname = UIDROPDOWNMENU_OPEN_MENU.name;
        else
            playerrealmname = strjoin("-",UIDROPDOWNMENU_OPEN_MENU.name,GetRealmName());
        end
        if tContains(GuildManager.db.profile.GMDNIt, playerrealmname)~=1 then
            table.insert(GuildManager.db.profile.GMDNIt, playerrealmname)
            GMDNIt=GuildManager.db.profile.GMDNIt
            pairsByKeysDNI(GMDNIt)
        end
        GuildInvite(playerrealmname)
        GuildManager:Print(strjoin(" ",playerrealmname,"was invited and added to the Do Not Invite List!"))
    end,
    notCheckable = 1,
}

local DNILaddButtonInfo = {
    text = "Add to DNIL",
    value = "EZ_DNIL",
    func = function()
        if string.match(UIDROPDOWNMENU_OPEN_MENU.name, "-") then
            playerrealmname = UIDROPDOWNMENU_OPEN_MENU.name;
        else
            playerrealmname = strjoin("-",UIDROPDOWNMENU_OPEN_MENU.name,GetRealmName());
        end
        table.insert(GuildManager.db.profile.GMDNIt, playerrealmname)
        GMDNIt=GuildManager.db.profile.GMDNIt
        pairsByKeysDNI(GMDNIt)
        GuildManager:Print(strjoin(" ",playerrealmname,"was added to the Do Not Invite List!"))
    end,
    notCheckable = 1,
}

local DNILremoveButtonInfo = {
    text = "Remove from DNIL",
    value = "EZ_DNILREM",
    func = function()
        if string.match(UIDROPDOWNMENU_OPEN_MENU.name, "-") then
            playerrealmname = UIDROPDOWNMENU_OPEN_MENU.name;
        else
            playerrealmname = strjoin("-",UIDROPDOWNMENU_OPEN_MENU.name,GetRealmName());
        end
        GuildManager:tremovebyval(GuildManager.db.profile.GMDNIt, playerrealmname)
        GuildManager:Print(strjoin(" ",playerrealmname,"was removed from the Do Not Invite List!"))
    end,
    notCheckable = 1,
}

local BlackaddButtonInfo = {
    text = "Add to Black List",
    value = "EZ_BLACK",
    func = function()
        if string.match(UIDROPDOWNMENU_OPEN_MENU.name, "-") then
            playerrealmname = UIDROPDOWNMENU_OPEN_MENU.name;
        else
            playerrealmname = strjoin("-",UIDROPDOWNMENU_OPEN_MENU.name,GetRealmName());
        end
        table.insert(GuildManager.db.profile.GMBlackt, playerrealmname)
        GMBlackt=GuildManager.db.profile.GMBlackt
        pairsByKeysBlack(GMBlackt)
        GuildManager:Print(strjoin(" ",playerrealmname,"was added to the Black List!"))
        if GuildManager.db.profile.pruneannounce==3 then
            SendChatMessage(strjoin(" ",playerrealmname,"has been banned from the guild. They will be autokicked if found on the roster."),"guild", nil,"GUILD")
        end
        if GuildManager.db.profile.pruneannounce==2 then
            SendChatMessage(strjoin(" ",playerrealmname,"has been banned from the guild. They will be autokicked if found on the roster."),"officer", nil,"OFFICER")
        end
    end,
    notCheckable = 1,
}

local BlackremoveButtonInfo = {
    text = "Remove from Black List",
    value = "EZ_BLACKREM",
    func = function()
        if string.match(UIDROPDOWNMENU_OPEN_MENU.name, "-") then
            playerrealmname = UIDROPDOWNMENU_OPEN_MENU.name;
        else
            playerrealmname = strjoin("-",UIDROPDOWNMENU_OPEN_MENU.name,GetRealmName());
        end
        GuildManager:tremovebyval(GuildManager.db.profile.GMBlackt, playerrealmname)
        GuildManager:Print(strjoin(" ",playerrealmname,"was removed from the Black List!"))
        if GuildManager.db.profile.pruneannounce==3 then
            SendChatMessage(strjoin(" ",playerrealmname,"is no longer banned from the guild."),"guild", nil,"GUILD")
        end
        if GuildManager.db.profile.pruneannounce==2 then
            SendChatMessage(strjoin(" ",playerrealmname,"is no longer banned from the guild."),"officer", nil,"OFFICER")
        end
    end,
    notCheckable = 1,
}

local KickButtonInfo = {
    text = "Kick from Guild",
    value = "EZ_KICK",
    func = function()
        if string.match(UIDROPDOWNMENU_OPEN_MENU.name, "-") then
            playerrealmname = UIDROPDOWNMENU_OPEN_MENU.name;
        else
            playerrealmname = strjoin("-",UIDROPDOWNMENU_OPEN_MENU.name,GetRealmName());
        end
        GuildUninvite(playerrealmname)
        if tContains(GuildManager.db.profile.GMDNIt, playerrealmname)==1 and GuildManager.db.profile.removefromdnil==true then
            GuildManager:tremovebyval(GuildManager.db.profile.GMDNIt, playerrealmname)
            GuildManager:Print(strjoin(" ",playerrealmname,"was removed from the Do Not Invite List"))
        end
    end,
    notCheckable = 1,
}

local BanButtonInfo = {
    text = "Ban from Guild",
    value = "EZ_BAN",
    func = function()
        if string.match(UIDROPDOWNMENU_OPEN_MENU.name, "-") then
            playerrealmname = UIDROPDOWNMENU_OPEN_MENU.name;
        else
            playerrealmname = strjoin("-",UIDROPDOWNMENU_OPEN_MENU.name,GetRealmName());
        end
        GuildUninvite(playerrealmname)
        table.insert(GuildManager.db.profile.GMBlackt, playerrealmname)
        GMBlackt=GuildManager.db.profile.GMBlackt
        pairsByKeysBlack(GMBlackt)
        GuildManager:Print(strjoin(" ",playerrealmname,"was added to the Black List!"))
        if GuildManager.db.profile.pruneannounce==3 then
            SendChatMessage(strjoin(" ",playerrealmname,"has been banned from the guild. They will be autokicked if found on the roster."),"guild", nil,"GUILD")
        end
        if GuildManager.db.profile.pruneannounce==2 then
            SendChatMessage(strjoin(" ",playerrealmname,"has been banned from the guild. They will be autokicked if found on the roster."),"officer", nil,"OFFICER")
        end
    end,
    notCheckable = 1,
}

local PruneaddButtonInfo = {
    text = "Exempt from Pruning",
    value = "EZ_PRUNE",
    func = function()
        if string.match(UIDROPDOWNMENU_OPEN_MENU.name, "-") then
            playerrealmname = UIDROPDOWNMENU_OPEN_MENU.name;
        else
            playerrealmname = strjoin("-",UIDROPDOWNMENU_OPEN_MENU.name,GetRealmName());
        end
        table.insert(GuildManager.db.profile.GMPruneExemptt, playerrealmname)
        GMPruneExemptt=GuildManager.db.profile.GMPruneExemptt
        pairsByKeysPruneExempt(GMPruneExemptt)
        GuildManager:Print(strjoin(" ",playerrealmname,"is no longer subject to Auto-Kicks. (Unless Blacklisted)"))
    end,
    notCheckable = 1,
}

local PruneremoveButtonInfo = {
    text = "Unexempt from Pruning",
    value = "EZ_PRUNEREM",
    func = function()
        if string.match(UIDROPDOWNMENU_OPEN_MENU.name, "-") then
            playerrealmname = UIDROPDOWNMENU_OPEN_MENU.name;
        else
            playerrealmname = strjoin("-",UIDROPDOWNMENU_OPEN_MENU.name,GetRealmName());
        end
        GuildManager:tremovebyval(GuildManager.db.profile.GMPruneExemptt, playerrealmname)
        GuildManager:Print(strjoin(" ",playerrealmname,"is subject to Auto-Kicks."))
    end,
    notCheckable = 1,
}

local DemoteaddButtonInfo = {
    text = "Exempt from Demotion",
    value = "EZ_DEMOTE",
    func = function()
        if string.match(UIDROPDOWNMENU_OPEN_MENU.name, "-") then
            playerrealmname = UIDROPDOWNMENU_OPEN_MENU.name;
        else
            playerrealmname = strjoin("-",UIDROPDOWNMENU_OPEN_MENU.name,GetRealmName());
        end
        table.insert(GuildManager.db.profile.GMDemoteExemptt, playerrealmname)
        GMDemoteExemptt=GuildManager.db.profile.GMDemoteExemptt
        pairsByKeysDemoteExempt(GMDemoteExemptt)
        GuildManager:Print(strjoin(" ",playerrealmname,"is no longer subject to Auto-Demotions."))
    end,
    notCheckable = 1,
}

local DemoteremoveButtonInfo = {
    text = "Unexempt from Demotion",
    value = "EZ_DEMOTEREM",
    func = function()
        if string.match(UIDROPDOWNMENU_OPEN_MENU.name, "-") then
            playerrealmname = UIDROPDOWNMENU_OPEN_MENU.name;
        else
            playerrealmname = strjoin("-",UIDROPDOWNMENU_OPEN_MENU.name,GetRealmName());
        end
        GuildManager:tremovebyval(GuildManager.db.profile.GMDemoteExemptt, playerrealmname)
        GuildManager:Print(strjoin(" ",playerrealmname,"is subject to Auto-Demotions."))
    end,
    notCheckable = 1,
}

local CancelButtonInfo = {
	text = "Cancel",
	value = "EZ_CANCEL",
	notCheckable = 1
}

function EasyGInvCheck()
	if IsGuildLeader()==true or IsGuildLeader()~=true then		
		local PossibleButton = getglobal("DropDownList1Button"..(DropDownList1.numButtons)-1)
		if PossibleButton["value"] ~= "EZ_CANCEL" then	
			if (UIDROPDOWNMENU_MENU_LEVEL > 1) then return; end					
			local GoodUnit = false
			for i=1, #PopupUnits do
			if OPEN_DROPDOWNMENUS[1]["which"] == PopupUnits[i] then
				GoodUnit = true
				end
			end
														
			if UIDROPDOWNMENU_OPEN_MENU["unit"] == "target" and ((not UnitIsPlayer("target"))) then
				GoodUnit = false									
			end
			
			if GoodUnit then										
					CreateEasyGInvButton()		
			end
		end
	end
end

function CreateEasyGInvButton()
    local CancelButtonFrame = getglobal("DropDownList1Button"..DropDownList1.numButtons)
    CancelButtonFrame:Hide()
    DropDownList1.numButtons = DropDownList1.numButtons - 1
    if string.match(UIDROPDOWNMENU_OPEN_MENU.name, "-") then
        playerrealmname = UIDROPDOWNMENU_OPEN_MENU.name;
    else
        playerrealmname = strjoin("-",UIDROPDOWNMENU_OPEN_MENU.name,GetRealmName());
    end
    GMRoster = {}
    for i=1,GetNumGuildMembers(true) do local name,_,_,_,_,_,note,officer = GetGuildRosterInfo(i);
        if string.match(name, "-") then
        else
            name = strjoin("-",name,GetRealmName());
        end
        table.insert(GMRoster, name)
    end
    CurrentPlayerName = GetUnitName("player")
    if string.match(CurrentPlayerName, "-") then
    else
        CurrentPlayerName = strjoin("-",CurrentPlayerName,GetRealmName())
    end
    if tContains(GMRoster, playerrealmname)~=1 and CurrentPlayerName~=playerrealmname then
        if tContains(GuildManager.db.profile.GMBlackt, playerrealmname)~=1 then
            if tContains(GuildManager.db.profile.GMDNIt, playerrealmname)~=1 then
                UIDropDownMenu_AddButton(GInvButtonInfo)
            end
        end
        if tContains(GuildManager.db.profile.GMDNIt, playerrealmname)~=1 then
            UIDropDownMenu_AddButton(DNILaddButtonInfo)
        else
            UIDropDownMenu_AddButton(DNILremoveButtonInfo)
        end
        if tContains(GuildManager.db.profile.GMBlackt, playerrealmname)~=1 then
            UIDropDownMenu_AddButton(BlackaddButtonInfo)
        else
            UIDropDownMenu_AddButton(BlackremoveButtonInfo)
        end
    elseif CurrentPlayerName~=playerrealmname then
        UIDropDownMenu_AddButton(KickButtonInfo)
        UIDropDownMenu_AddButton(BanButtonInfo)
        if tContains(GuildManager.db.profile.GMPruneExemptt, playerrealmname)~=1 then
            UIDropDownMenu_AddButton(PruneaddButtonInfo)
        else
            UIDropDownMenu_AddButton(PruneremoveButtonInfo)
        end
        if tContains(GuildManager.db.profile.GMDemoteExemptt, playerrealmname)~=1 then
            UIDropDownMenu_AddButton(DemoteaddButtonInfo)
        else
            UIDropDownMenu_AddButton(DemoteremoveButtonInfo)
        end
    else
    end
    UIDropDownMenu_AddButton(CancelButtonInfo)
end