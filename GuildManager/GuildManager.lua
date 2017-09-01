GuildManager = LibStub("AceAddon-3.0"):NewAddon("GuildManager", "AceConsole-3.0", "AceEvent-3.0", "AceComm-3.0", "AceTimer-3.0", "AceSerializer-3.0", "AceHook-3.0");
GuildManager:RegisterChatCommand("GuildManager", ChatCmd)
GuildManager:RegisterChatCommand("gm", ChatCmd)
local GUI = LibStub("AceGUI-3.0")

--Setup functions--
function GuildManager:GetGuildName()
	local guildName, guildRankName, guildRankIndex = GetGuildInfo("player")
	return guildName
end

function GuildManager:OnInitialize()
    -- Called when the addon is loaded
    GuildRoster()
    GuildNameTest=GuildManager:GetGuildName()
    GuildManager.db = LibStub("AceDB-3.0"):New("GuildManagerDB", {}, "Default")
    GuildManager.db:RegisterDefaults({
        profile = {
            lasttime = {},
            guild = "",
            active = true,
            cityspam = false,
            zonespam = false,
            outpvpspam = false,
            between = 15,
            message = "",
            citychannel = 2,
            zonechannel = 1,
            whisperinvite = false,
            whisperonly = false,
            atuomatewho = false,
            sendginvite = false,
            targetclass = false,
            whispmessage = "",
            minlevel = 20,
            maxlevel = 110,
            DKsearch = false,
            DHsearch = false,
            Druidsearch = false,
            Huntersearch = false,
            Magesearch = false,
            Monksearch = false,
            Paladinsearch = false,
            Priestsearch = false,
            Roguesearch = false,
            Shamansearch = false,
            Warlocksearch = false,
            Warriorsearch = false,
            membercap = 1000,
            welcomeannounce = 1,
            welcomewhisp = "",
            declinewhisp = "",
            removeinactive = false,
            removelevels = false,
            automateprune = false,
            daysinactive = 365,
            levelthreshold = 1,
            pruneannounce = 1,
            exemptalt = false,
            exemptranks = false,
            removefromdnil = false,
            exemptrank1 = false,
            exemptrank2 = false,
            exemptrank3 = false,
            exemptrank4 = false,
            exemptrank5 = false,
            exemptrank6 = false,
            exemptrank7 = false,
            exemptrank8 = false,
            exemptrank9 = false,
            automatepromote = false,
            demotemode = false,
            promoteannounce = 1,
            promotelevel = false,
            rank1promotesearch = false,
            rank2promotesearch = false,
            rank3promotesearch = false,
            rank4promotesearch = false,
            rank5promotesearch = false,
            rank6promotesearch = false,
            rank7promotesearch = false,
            rank8promotesearch = false,
            rank9promotesearch = false,
            rank1promote = false,
            rank2promote = false,
            rank3promote = false,
            rank4promote = false,
            rank5promote = false,
            rank6promote = false,
            rank7promote = false,
            rank8promote = false,
            rank1level = 111,
            rank2level = 111,
            rank3level = 111,
            rank4level = 111,
            rank5level = 111,
            rank6level = 111,
            rank7level = 111,
            rank8level = 111,
            announcement1 = "",
            announcementtimer1 = 60,
            announcementto1 = 1,
            announcementborder1 = 1,
            announcement2 = "",
            announcementtimer2 = 60,
            announcementto2 = 1,
            announcementborder2 = 1,
            announcement3 = "",
            announcementtimer3 = 60,
            announcementto3 = 1,
            announcementborder3 = 1,
            announcement4 = "",
            announcementtimer4 = 60,
            announcementto4 = 1,
            announcementborder4 = 1,
            announcement5 = "",
            announcementtimer5 = 60,
            announcementto5 = 1,
            announcementborder5 = 1,
            nextannouncemessage = "",
            nextannouncetime = 0,
            nextannouncechannel = 1,
            nextannounceborder = 1,
            lastannounced = 0,
            announcenext = 0,
            lastanntime = 0,
            GMPruneExemptt = {},
            GMDemoteExemptt = {},
            GMBlackt = {},
            GMDNIt = {},
            GMIQt = {},
            CurrentGuildLeader = "",
        },
    })
    if not GuildManager.version then GuildManager.version = tonumber(GetAddOnMetadata("GuildManager", "X-Build")) end
    GuildManager.optionsframe = LibStub("AceConfigDialog-3.0"):AddToBlizOptions("GuildManager", "Guild Manager")
    LibStub("AceConfig-3.0"):RegisterOptionsTable("GuildManager", guildManagerOptions)
    if (GuildManager.db.profile.version ~= GuildManager.version) then
        GuildManager.db.profile.lasttime = {}
        GuildManager.db.profile.version = GuildManager.version
    end
    active = GuildManager.db.profile.active
end

function GuildManager:OnEnable()
    -- Called when the addon is enabled
    GuildRoster()
    if GuildManager:GetGuildName()~=nil then
        GuildManager.db:SetProfile(strjoin("","<",GuildManager:GetGuildName(),">"," of ",GetRealmName()))
    else
        GuildManager.db:SetProfile("Default")
    end
    if GuildManager:GetGuildName() == nil then
        GuildManager:ScheduleTimer("OnEnable", .1)
        return
    end
    GuildManager:TurnSelfOn()
end

function GuildManager:TurnSelfOn()
    GuildManager:RegisterEvent("CHAT_MSG_CHANNEL_NOTICE")
    if IsGuildLeader()==false then
        GMDoesNotQualifyNotice = false
        GMFailedNotice = false
        GuildManager:ScheduleRepeatingTimer("ReplaceGM", 1)
        GuildManager:Print("Guild Manager detects that you are not the Guild Master. Guild Manager will check to see if you qualify to be the Guild Master every second. If so that power will be transferred to you.")
    else
        GuildManager:ScheduleRepeatingTimer("MasterTimer", 30)
        GuildManager:Print("Loaded and Fully Operational! Type /guildmanager to manage your options. NOTE: You will need to create a macro or modify your macros by adding '/run GuildManager:InviteAction()' to each one. This is the ONLY way to get Toon Recruitment to work. See documentation on Curse or in the GuildManager addon folder for additional details.")
    end
    GuildManager:Cleantables()
end

function GuildManager:ReplaceGM()
    if GuildMasterAbsent()~=false or CanReplaceGuildMaster()~=false then
        if CanReplaceGuildMaster()==false then
            ReplaceGuildMaster()
            if IsGuildLeader()==false then
                if GMDoesNotQualifyNotice==false then
                    GuildManager:Print("ATTENTION! The Guild Master is declared absent but you cannot take control of the guild. Guild Manager will notify you once it can take control.")
                    GMDoesNotQualifyNotice = true
                end
            else
                GuildManager:CancelAllTimers()
                GuildManager:Print("ATTENTION! Guild Manager has transferred control of the guild to you.")
                GuildManager:ScheduleRepeatingTimer("MasterTimer", 30)
            end
        else
            ReplaceGuildMaster()
            if IsGuildLeader()==false then
                if GMFailedNotice==false then
                    GuildManager:Print("ATTENTION! The Guild Master is declared absent and Guild Manager attempted to take control but failed. Guild Manager will notify you once it can take control.")
                    GMFailedNotice = true
                end
            else
                GuildManager:CancelAllTimers()
                GuildManager:Print("ATTENTION! Guild Manager has transferred control of the guild to you.")
                GuildManager:ScheduleRepeatingTimer("MasterTimer", 30)
            end
        end
    end
    ReplaceGuildMaster()
    if IsGuildLeader()~=false then
        GuildManager:CancelAllTimers()
        GuildManager:Print("ATTENTION! Guild Manager has transferred control of the guild to you.")
        GuildManager:ScheduleRepeatingTimer("MasterTimer", 30)
    end
end

function GuildManager:OnDisable()
		-- Called when the addon is disabled
end

--Automation Functions--
function GuildManager:GetTime()
	local hours,minutes = GetGameTime()
	local _, m, d, y = CalendarGetDate()
	return ((d + math.floor( ( 153*m - 457 ) / 5 ) + 365*y + math.floor( y / 4 ) - math.floor( y / 100 ) + math.floor( y / 400 ) + 1721118.5) * 1440) +(hours*60)+(minutes)
end

function GuildManager:MasterTimer()
    if GuildManager.db.profile.automateprune==true then
        GuildManager:GKRun()--Pruning
    end
    if GuildManager.db.profile.automatepromote==true then
        GuildManager:ScheduleTimer("GMPromoteErrorChecking", 5)
    end
    GuildManager:ScheduleTimer("RunAnnouncemnts", 10)
    GuildManager:ScheduleTimer("CheckZone", 15)
    if GuildManager.db.profile.automatewho==true and (WhoCycle==0 or WhoCycle==nil) and GetNumGuildMembers()<=999 and GuildManager.db.profile.membercap>GetNumGuildMembers() then
        GuildManager:ScheduleTimer("RunWhoSearch", 20)
    end
end

--Registered Event Functions--
local GMframe = CreateFrame("FRAME", "GuildManager");
GMframe:RegisterEvent("CHAT_MSG_SYSTEM");
GMframe:RegisterEvent("ADDON_LOADED");

local function GMWelcome(self, event, ...)
    if event == "CHAT_MSG_SYSTEM" then
        local msg = ...;
        local PlayerName, PlayerRealm = UnitName("Player")
        if (msg and msg ~= nil) then
            if ((string.find(msg, "has joined the guild") ~= nil)) then
                starts, ends = string.find(msg," ")
                args1 = string.sub(msg, 0, starts-1)
                if (args1 ~= UnitName("player"))then
                    if GuildManager.db.profile.welcomeannounce==3 then
                        SendChatMessage(strjoin(" ","Please welcome our newest member",args1), "GUILD", nil, arg2);
                    end
                    if GuildManager.db.profile.welcomeannounce==2 then
                        SendChatMessage(strjoin(" ","Please welcome our newest member",args1), "OFFICER", nil, arg2);
                    end
                    SendChatMessage(GuildManager.db.profile.welcomewhisp,"WHISPER",nil,args1)
                end
            end
            if ((string.find(msg, strjoin("",PlayerName," has joined the guild"))==1)) then
                GuildManager.db:SetProfile(strjoin("","<",GuildManager:GetGuildName(),">"," of ",GetRealmName()))
                GuildManager:RegisterMyToons()
            end
            if ((string.find(msg, strjoin("",PlayerName," has left the guild"))==1)) or ((string.find(msg, strjoin("",PlayerName," has been kicked out of the guild by"))==1)) then
                GuildManager.db:SetProfile("Default")
            end
            if ((string.find(msg, '" not found.') ~= nil)) then
                starts, ends = string.find(msg," ")
                args1 = string.sub(msg, 2, -13)
                if (args1 ~= UnitName("player"))then
                    if tContains(GuildManager.db.profile.GMDNIt, args1)==1 then
                        GuildManager:tremovebyval(GuildManager.db.profile.GMDNIt, args1)
                        GuildManager:Print(strjoin(" ",args1,"could not be found and was removed from the Do Not Invite List!"))
                    end
                end
            end
            if ((string.find(msg, "declines your guild invitation.") ~= nil)) then
                starts, ends = string.find(msg," ")
                args1 = string.sub(msg, 0, -33)
                if (args1 ~= UnitName("player"))then
                    SendChatMessage(GuildManager.db.profile.declinewhisp,"WHISPER",nil,args1)
                end
            end
            if ((string.find(msg, "is declining all guild invitations") ~= nil)) then
                starts, ends = string.find(msg," ")
                args1 = string.sub(msg, 0, starts-1)
                if (args1 ~= UnitName("player"))then
                    SendChatMessage(GuildManager.db.profile.declinewhisp,"WHISPER",nil,args1)
                end
            end
            --You have invited xxxx to join your guild.
            --123456789012345678  123456789012345678901
            if ((string.find(msg, "You have invited") ~= nil)) and ((string.find(msg, "to join your guild.") ~= nil)) then
                args1 = string.sub(msg, 18, -21)
                if (args1 ~= UnitName("player"))then
                    SendChatMessage(GuildManager.db.profile.whispmessage,"WHISPER",nil,args1)
                end
            end
        end
    end
end
GMframe:SetScript("OnEvent", GMWelcome);