-- Author      : Robert
-- Create Date : 9/1/2017 3:47:54 PM

--*RECRUITMENT*--
local f = CreateFrame("frame")
f:RegisterEvent("CHAT_MSG_WHISPER")
f:SetScript("OnEvent", function(self,event,arg1,arg2)
    if string.match(arg2, "-") then
    else
        arg2 = strjoin("-",arg2,GetRealmName());
    end
    if IsGuildLeader()==true or IsGuildLeader()~=true then
        if GetNumGuildMembers()<=999 and GuildManager.db.profile.membercap>GetNumGuildMembers() and arg1:lower():match("lf guild") and GuildManager.db.profile.whisperinvite==true then
            if tContains(GuildManager.db.profile.GMBlackt, arg2)~=1 then
                if tContains(GuildManager.db.profile.GMIQt, arg2)~=1 then
                    table.insert(GuildManager.db.profile.GMIQt, arg2)
                    GMIQt=GuildManager.db.profile.GMIQt
                    pairsByKeysIQ(GMIQt)
                end
                SendChatMessage("Added to Invite Queue. If you do not get an invite shortly it may be because you are already in a guild, on a trial account or you are incorrectly flagged as being in a guild. If you think it is the last reason, log out and back in then try again!","WHISPER",nil,arg2)
            else
                SendChatMessage("Invitation Denied! You are currently banned from this guild!","WHISPER",nil,arg2)
            end
        elseif (GetNumGuildMembers()>=1000 or GuildManager.db.profile.membercap<=GetNumGuildMembers()) and arg1:lower():match("lf guild") and GuildManager.db.profile.whisperinvite==true then
            SendChatMessage("Invitation Denied! The guild is currently full!","WHISPER",nil,arg2)
        end
    end
end)

--Zone Recruitment Functions--
function GuildManager:CHAT_MSG_CHANNEL_NOTICE(what, a, b, c, d, e, f, number, channel)
    GuildManager:ScheduleTimer("CheckZone", 5)
end

function GuildManager:CheckZone()
    if GetNumGuildMembers()<=999 and GuildManager.db.profile.membercap>GetNumGuildMembers() then
        local inInstance, instanceType = IsInInstance()
        if inInstance==nil then
            if (GuildManager:IsCity())==true then
                GMzone="City"
            elseif (GuildManager:IsCity())~=true then
                GMzone=(GetZoneText())
            end
        end
        if GMzone=="City" and GuildManager.db.profile.cityspam==true then
            GuildManager:CheckTime(GMzone)
        end
        if GMzone~="City" and GuildManager.db.profile.zonespam==true then
            if GetZonePVPInfo()~="combat" then
                GuildManager:CheckTime(GMzone)
            end
            if GetZonePVPInfo()=="Combat" and GuildManager.db.profile.outpvpspam==true then
                GuildManager:CheckTime(GMzone)
            end
        end
    end
end

function GuildManager:IsCity()
    if (GetZoneText())=="Stormwind City" then
        return true
    elseif (GetZoneText())=="Darnassus" then
        return true
    elseif (GetZoneText())=="City of Ironforge" then
        return true
    elseif (GetZoneText())=="The Exodar" then
        return true
    elseif (GetZoneText())=="Shrine of Seven Stars" then
        return true
    elseif (GetZoneText())=="Stormshield" then
        return true
    elseif (GetZoneText())=="Lunarfall" then
        return true
    elseif (GetZoneText())=="Orgrimmar" then
        return true
    elseif (GetZoneText())=="Thunder Bluff" then
        return true
    elseif (GetZoneText())=="Undercity" then
        return true
    elseif (GetZoneText())=="Silvermoon City" then
        return true
    elseif (GetZoneText())=="Shrine of Two Moons" then
        return true
    elseif (GetZoneText())=="Warspear" then
        return true
    elseif (GetZoneText())=="Frostwall" then
        return true
    elseif (GetZoneText())=="Dalaran" then
        return true
    elseif (GetZoneText())=="Shattrath City" then
        return true
    else
        return false
    end
end

function GuildManager:CheckTime(GMzone)
    if GMzone==nil then
        if (GuildManager:IsCity())==true then
            GMzone="City"
        elseif (GuildManager:IsCity())~=true then
            GMzone=(GetZoneText())
        end
    end
    if GuildManager.db.profile.lasttime[GMzone]==nil then
        GuildManager.db.profile.lasttime[GMzone]=0
    end
    timediffspam=(GuildManager:GetTime())-GuildManager.db.profile.lasttime[GMzone]
    if timediffspam>=GuildManager.db.profile.between then
        GuildManager:SpamZone(GMzone)
    end
end

function GuildManager:SpamZone(GMzone)
    if GMzone=="City" then
        number=GuildManager.db.profile.citychannel
    else
        number=GuildManager.db.profile.zonechannel
    end
    SendChatMessage(GuildManager.db.profile.message,"CHANNEL",nil,number)
    GuildManager.db.profile.lasttime[GMzone]=GuildManager:GetTime()
end

--Character Recruitment Functions--
function GuildManager:RunWhoSearch()
    if IsGuildLeader()==true or IsGuildLeader()~=true then
        if GuildManager.db.profile.targetclass==true and GuildManager.db.profile.DKsearch==false and GuildManager.db.profile.DHsearch==false and GuildManager.db.profile.Druidsearch==false and GuildManager.db.profile.Huntersearch==false and GuildManager.db.profile.Magesearch==false and GuildManager.db.profile.Paladinsearch==false and GuildManager.db.profile.Priestsearch==false and GuildManager.db.profile.Roguesearch==false and GuildManager.db.profile.Shamansearch==false and GuildManager.db.profile.Warlocksearch==false and GuildManager.db.profile.Warriorsearch==false then
            GuildManager:Print('ERROR! You must select a specific class if you opt to target specific classes!')
        else
            if WhoCycle==1 then
                GuildManager:Print('Character Recruitment Cycle Already In Progress')
            else
                WhoHalt=0
                WhoCycle=0
                LevelChecking=0
                ClassChecking=0
                RaceClassChecking=0
                ToonLevelCheck=0
                ToonClassCheck=0
                ToonRaceClassCheck=0
                GuildManager:LevelRangeSearch()
            end
        end
    else
        GuildManager:Print('Character Recruitment Cycle did NOT start! Only Guild Leaders can use this function!')
    end
end

function GuildManager:LevelRangeSearch()
    if GetNumGuildMembers()<=999 and GuildManager.db.profile.membercap>GetNumGuildMembers() then
        if WhoCycle==0 then
            GuildManager:Print('Starting Character Recruitment Cycle')
            if GuildManager.db.profile.minlevel+4>=GuildManager.db.profile.maxlevel and GuildManager.db.profile.minlevel<GuildManager.db.profile.maxlevel then
                ToonMinLevel=GuildManager.db.profile.minlevel
                ToonMaxLevel=GuildManager.db.profile.maxlevel
                ToonLevel=strjoin('',ToonMinLevel,'-',ToonMaxLevel)
                WhoCycle=1
                GuildManager:SendWhoLevel()
            elseif GuildManager.db.profile.minlevel+4<GuildManager.db.profile.maxlevel then
                ToonMinLevel=GuildManager.db.profile.maxlevel-4
                ToonMaxLevel=GuildManager.db.profile.maxlevel
                ToonLevel=strjoin('',ToonMinLevel,'-',ToonMaxLevel)
                WhoCycle=1
                GuildManager:SendWhoLevel()
            elseif GuildManager.db.profile.minlevel==GuildManager.db.profile.maxlevel then
                ToonMinLevel=GuildManager.db.profile.minlevel
                ToonMaxLevel=GuildManager.db.profile.maxlevel
                ToonLevel=GuildManager.db.profile.minlevel
                GuildManager:SendWhoLevel()
                WhoCycle=1
            end

        elseif WhoCycle==1 then

            if ToonMaxLevel-4<=GuildManager.db.profile.minlevel and ToonMaxLevel>GuildManager.db.profile.minlevel then
                ToonMinLevel=GuildManager.db.profile.minlevel
                ToonLevel=strjoin('',ToonMinLevel,'-',ToonMaxLevel)
                GuildManager:SendWhoLevel()
            elseif ToonMaxLevel-4>GuildManager.db.profile.minlevel then
                ToonMinLevel=ToonMaxLevel-4
                ToonLevel=strjoin('',ToonMinLevel,'-',ToonMaxLevel)
                GuildManager:SendWhoLevel()
            elseif ToonMaxLevel==GuildManager.db.profile.minlevel then
                ToonLevel=GuildManager.db.profile.minlevel
                ToonMinLevel=GuildManager.db.profile.minlevel
                GuildManager:SendWhoLevel()
            elseif ToonMaxLevel<GuildManager.db.profile.minlevel then
                WhoCycle=0
            end
        end
    else
        GuildManager:Print('Character Recruitment Will Not Run. Guild Population is at maximum.')
        LevelChecking=0
        ClassChecking=0
        RaceClassChecking=0
        ToonLevelCheck=0
        ToonClassCheck=0
        ToonRaceClassCheck=0
        WhoCycle=0
    end
end

function GuildManager:LevelSearch()
    LevelChecking=1
    if ToonLevelCheck==0 then
        ToonLevelCheck=1
        GuildManager:LevelSearch()
    elseif ToonLevelCheck==1 and ToonMaxLevel>=GuildManager.db.profile.minlevel then
        ToonLevel=ToonMaxLevel
        GuildManager:SendWhoLevel()
    elseif ToonLevelCheck==2 and ToonMaxLevel-1>=GuildManager.db.profile.minlevel then
        ToonLevel=ToonMaxLevel-1
        GuildManager:SendWhoLevel()
    elseif ToonLevelCheck==3 and ToonMaxLevel-2>=GuildManager.db.profile.minlevel then
        ToonLevel=ToonMaxLevel-2
        GuildManager:SendWhoLevel()
    elseif ToonLevelCheck==4 and ToonMaxLevel-3>=GuildManager.db.profile.minlevel then
        ToonLevel=ToonMaxLevel-3
        GuildManager:SendWhoLevel()
    elseif ToonLevelCheck==5 and ToonMaxLevel-4>=GuildManager.db.profile.minlevel then
        ToonLevel=ToonMaxLevel-4
        GuildManager:SendWhoLevel()
    elseif ToonLevelCheck==6 or ToonLevel<=GuildManager.db.profile.minlevel then
        LevelChecking=0
        ToonMaxLevel=ToonMinLevel-1
        GuildManager:LevelRangeSearch()
    end
end

--Class Controls--
function GuildManager:ClassControl()
    ClassChecking=1
    if ToonClassCheck==0 then
        ToonClassCheck=1
        GuildManager:ClassControl()
    elseif ToonClassCheck==1 then
        if GuildManager.db.profile.DKsearch==true or GuildManager.db.profile.targetclass==false then
            ToonClass = 'c-\"Death Knight\" '
            ToonClassName = 'Death Knights'
            GuildManager:SendWhoClass()
        else
            ToonClassCheck=2
            GuildManager:ClassControl()
        end
    elseif ToonClassCheck==2 then
        if GuildManager.db.profile.DHsearch==true or GuildManager.db.profile.targetclass==false then
            ToonClass = 'c-\"Demon Hunter\" '
            ToonClassName = 'Demon Hunter'
            GuildManager:SendWhoClass()
        else
            ToonClassCheck=3
            GuildManager:ClassControl()
        end
    elseif ToonClassCheck==3 then
        if GuildManager.db.profile.Druidsearch==true or GuildManager.db.profile.targetclass==false then
            ToonClass = 'c-\"Druid\" '
            ToonClassName = 'Druids'
            GuildManager:SendWhoClass()
        else
            ToonClassCheck=4
            GuildManager:ClassControl()
        end
    elseif ToonClassCheck==4 then
        if GuildManager.db.profile.Huntersearch==true or GuildManager.db.profile.targetclass==false then
            ToonClass = 'c-\"Hunter\" '
            ToonClassName = 'Hunters'
            GuildManager:SendWhoClass()
        else
            ToonClassCheck=5
            GuildManager:ClassControl()
        end
    elseif ToonClassCheck==5 then
        if GuildManager.db.profile.Magesearch==true or GuildManager.db.profile.targetclass==false then
            ToonClass = 'c-\"Mage\" '
            ToonClassName = 'Mages'
            GuildManager:SendWhoClass()
        else
            ToonClassCheck=6
            GuildManager:ClassControl()
        end
    elseif ToonClassCheck==6 then
        if GuildManager.db.profile.Monksearch==true or GuildManager.db.profile.targetclass==false then
            ToonClass = 'c-\"Monk\" '
            ToonClassName = 'Monk'
            GuildManager:SendWhoClass()
        else
            ToonClassCheck=7
            GuildManager:ClassControl()
        end
    elseif ToonClassCheck==7 then
        if GuildManager.db.profile.Paladinsearch==true or GuildManager.db.profile.targetclass==false then
            ToonClass = 'c-\"Paladin\" '
            ToonClassName = 'Paladins'
            GuildManager:SendWhoClass()
        else
            ToonClassCheck=8
            GuildManager:ClassControl()
        end
    elseif ToonClassCheck==8 then
        if GuildManager.db.profile.Priestsearch==true or GuildManager.db.profile.targetclass==false then
            ToonClass = 'c-\"Priest\" '
            ToonClassName = 'Priests'
            GuildManager:SendWhoClass()
        else
            ToonClassCheck=9
            GuildManager:ClassControl()
        end
    elseif ToonClassCheck==9 then
        if GuildManager.db.profile.Roguesearch==true or GuildManager.db.profile.targetclass==false then
            ToonClass = 'c-\"Rogue\" '
            ToonClassName = 'Rogues'
            GuildManager:SendWhoClass()
        else
            ToonClassCheck=10
            GuildManager:ClassControl()
        end
    elseif ToonClassCheck==10 then
        if GuildManager.db.profile.Shamansearch==true or GuildManager.db.profile.targetclass==false then
            ToonClass = 'c-\"Shaman\" '
            ToonClassName = 'Shaman'
            GuildManager:SendWhoClass()
        else
            ToonClassCheck=11
            GuildManager:ClassControl()
        end
    elseif ToonClassCheck==11 then
        if GuildManager.db.profile.Warlocksearch==true or GuildManager.db.profile.targetclass==false then
            ToonClass = 'c-\"Warlock\" '
            ToonClassName = 'Warlocks'
            GuildManager:SendWhoClass()
        else
            ToonClassCheck=12
            GuildManager:ClassControl()
        end
    elseif ToonClassCheck==12 then
        if GuildManager.db.profile.Warriorsearch==true or GuildManager.db.profile.targetclass==false then
            ToonClass = 'c-\"Warrior\" '
            ToonClassName = 'Warriors'
            GuildManager:SendWhoClass()
        else
            ToonClassCheck=13
            GuildManager:ClassControl()
        end
    elseif ToonClassCheck==13 then
        ClassChecking=0
        ToonLevelCheck=ToonLevelCheck+1
        GuildManager:LevelSearch()
    end
end

--Race/Class Controls--
function GuildManager:RaceClassControl()
    RaceClassChecking=1
    if ToonRaceClassCheck==0 then
        ToonRaceClassCheck=ToonRaceClassCheck+1
        GuildManager:RaceClassControl()
    elseif ToonRaceClassCheck>=1 then
        if ToonClassCheck==1 then
            GuildManager:DKRaceSearch()
        elseif ToonClassCheck==2 then
            GuildManager:DHRaceSearch()
        elseif ToonClassCheck==3 then
            GuildManager:DruidRaceSearch()
        elseif ToonClassCheck==4 then
            GuildManager:HunterRaceSearch()
        elseif ToonClassCheck==5 then
            GuildManager:MageRaceSearch()
        elseif ToonClassCheck==6 then
            GuildManager:MonkRaceSearch()
        elseif ToonClassCheck==7 then
            GuildManager:PaladinRaceSearch()
        elseif ToonClassCheck==8 then
            GuildManager:PriestRaceSearch()
        elseif ToonClassCheck==9 then
            GuildManager:RogueRaceSearch()
        elseif ToonClassCheck==10 then
            GuildManager:ShamanRaceSearch()
        elseif ToonClassCheck==11 then
            GuildManager:WarlockRaceSearch()
        elseif ToonClassCheck==12 then
            GuildManager:WarriorRaceSearch()
        end
    end
end

function GuildManager:DKRaceSearch()
    if UnitFactionGroup("player")=="Alliance" then
        if ToonRaceClassCheck==1 then
            ToonRace = 'r-\"Draenei\" '
            ToonRaceName = 'Draenei'
            GuildManager:SendWhoRaceClass()
        elseif ToonRaceClassCheck==2 then
            ToonRace = 'r-\"Dwarf\" '
            ToonRaceName = 'Dwarf'
            GuildManager:SendWhoRaceClass()
        elseif ToonRaceClassCheck==3 then
            ToonRace = 'r-\"Gnome\" '
            ToonRaceName = 'Gnome'
            GuildManager:SendWhoRaceClass()
        elseif ToonRaceClassCheck==4 then
            ToonRace = 'r-\"Human\" '
            ToonRaceName = 'Human'
            GuildManager:SendWhoRaceClass()
        elseif ToonRaceClassCheck==5 then
            ToonRace = 'r-\"Night elf\" '
            ToonRaceName = 'Night elf'
            GuildManager:SendWhoRaceClass()
        elseif ToonRaceClassCheck==6 then
            ToonRace = 'r-\"Worgen\" '
            ToonRaceName = 'Worgen'
            GuildManager:SendWhoRaceClass()
        elseif ToonRaceClassCheck==7 then
            RaceClassChecking=0
            ToonClassCheck=ToonClassCheck+1
            GuildManager:ClassControl()
        end
    elseif UnitFactionGroup("player")=="Horde" then
        if ToonRaceClassCheck==1 then
            ToonRace = 'r-\"Blood elf\" '
            ToonRaceName = 'Blood Elf'
            GuildManager:SendWhoRaceClass()
        elseif ToonRaceClassCheck==2 then
            ToonRace = 'r-\"Goblin\" '
            ToonRaceName = 'Goblin'
            GuildManager:SendWhoRaceClass()
        elseif ToonRaceClassCheck==3 then
            ToonRace = 'r-\"Orc\" '
            ToonRaceName = 'Orc'
            GuildManager:SendWhoRaceClass()
        elseif ToonRaceClassCheck==4 then
            ToonRace = 'r-\"Tauren\" '
            ToonRaceName = 'Tauren'
            GuildManager:SendWhoRaceClass()
        elseif ToonRaceClassCheck==5 then
            ToonRace = 'r-\"Troll\" '
            ToonRaceName = 'Troll'
            GuildManager:SendWhoRaceClass()
        elseif ToonRaceClassCheck==6 then
            ToonRace = 'r-\"Undead\" '
            ToonRaceName = 'Undead'
            GuildManager:SendWhoRaceClass()
        elseif ToonRaceClassCheck==7 then
            RaceClassChecking=0
            ToonClassCheck=ToonClassCheck+1
            GuildManager:ClassControl()
        end
    end
end

function GuildManager:DHRaceSearch()
    if UnitFactionGroup("player")=="Alliance" then
        if ToonRaceClassCheck==1 then
            ToonRace = 'r-\"Night elf\" '
            ToonRaceName = 'Night elf'
            GuildManager:SendWhoRaceClass()
        elseif ToonRaceClassCheck==2 then
            RaceClassChecking=0
            ToonClassCheck=ToonClassCheck+1
            GuildManager:ClassControl()
        end
    elseif UnitFactionGroup("player")=="Horde" then
        if ToonRaceClassCheck==1 then
            ToonRace = 'r-\"Blood elf\" '
            ToonRaceName = 'Blood Elf'
            GuildManager:SendWhoRaceClass()
        elseif ToonRaceClassCheck==2 then
            RaceClassChecking=0
            ToonClassCheck=ToonClassCheck+1
            GuildManager:ClassControl()
        end
    end
end

function GuildManager:DruidRaceSearch()
    if UnitFactionGroup("player")=="Alliance" then
        if ToonRaceClassCheck==1 then
            ToonRace = 'r-\"Night elf\" '
            ToonRaceName = 'Night elf'
            GuildManager:SendWhoRaceClass()
        elseif ToonRaceClassCheck==2 then
            ToonRace = 'r-\"Worgen\" '
            ToonRaceName = 'Worgen'
            GuildManager:SendWhoRaceClass()
        elseif ToonRaceClassCheck==3 then
            RaceClassChecking=0
            ToonClassCheck=ToonClassCheck+1
            GuildManager:ClassControl()
        end
    elseif UnitFactionGroup("player")=="Horde" then
        if ToonRaceClassCheck==1 then
            ToonRace = 'r-\"Tauren\" '
            ToonRaceName = 'Tauren'
            GuildManager:SendWhoRaceClass()
        elseif ToonRaceClassCheck==2 then
            ToonRace = 'r-\"Troll\" '
            ToonRaceName = 'Troll'
            GuildManager:SendWhoRaceClass()
        elseif ToonRaceClassCheck==3 then
            RaceClassChecking=0
            ToonClassCheck=ToonClassCheck+1
            GuildManager:ClassControl()
        end
    end
end

function GuildManager:HunterRaceSearch()
    if UnitFactionGroup("player")=="Alliance" then
        if ToonRaceClassCheck==1 then
            ToonRace = 'r-\"Draenei\" '
            ToonRaceName = 'Draenei'
            GuildManager:SendWhoRaceClass()
        elseif ToonRaceClassCheck==2 then
            ToonRace = 'r-\"Dwarf\" '
            ToonRaceName = 'Dwarf'
            GuildManager:SendWhoRaceClass()
        elseif ToonRaceClassCheck==3 then
            ToonRace = 'r-\"Human\" '
            ToonRaceName = 'Human'
            GuildManager:SendWhoRaceClass()
        elseif ToonRaceClassCheck==4 then
            ToonRace = 'r-\"Night elf\" '
            ToonRaceName = 'Night elf'
            GuildManager:SendWhoRaceClass()
        elseif ToonRaceClassCheck==5 then
            ToonRace = 'r-\"Pandaren\" '
            ToonRaceName = 'Pandaren'
            GuildManager:SendWhoRaceClass()
        elseif ToonRaceClassCheck==6 then
            ToonRace = 'r-\"Worgen\" '
            ToonRaceName = 'Worgen'
            GuildManager:SendWhoRaceClass()
        elseif ToonRaceClassCheck==7 then
            RaceClassChecking=0
            ToonClassCheck=ToonClassCheck+1
            GuildManager:ClassControl()
        end
    elseif UnitFactionGroup("player")=="Horde" then
        if ToonRaceClassCheck==1 then
            ToonRace = 'r-\"Blood elf\" '
            ToonRaceName = 'Blood Elf'
            GuildManager:SendWhoRaceClass()
        elseif ToonRaceClassCheck==2 then
            ToonRace = 'r-\"Goblin\" '
            ToonRaceName = 'Goblin'
            GuildManager:SendWhoRaceClass()
        elseif ToonRaceClassCheck==3 then
            ToonRace = 'r-\"Orc\" '
            ToonRaceName = 'Orc'
            GuildManager:SendWhoRaceClass()
        elseif ToonRaceClassCheck==4 then
            ToonRace = 'r-\"Pandaren\" '
            ToonRaceName = 'Pandaren'
            GuildManager:SendWhoRaceClass()
        elseif ToonRaceClassCheck==5 then
            ToonRace = 'r-\"Tauren\" '
            ToonRaceName = 'Tauren'
            GuildManager:SendWhoRaceClass()
        elseif ToonRaceClassCheck==6 then
            ToonRace = 'r-\"Troll\" '
            ToonRaceName = 'Troll'
            GuildManager:SendWhoRaceClass()
        elseif ToonRaceClassCheck==7 then
            ToonRace = 'r-\"Undead\" '
            ToonRaceName = 'Undead'
            GuildManager:SendWhoRaceClass()
        elseif ToonRaceClassCheck==8 then
            RaceClassChecking=0
            ToonClassCheck=ToonClassCheck+1
            GuildManager:ClassControl()
        end
    end
end

function GuildManager:MageRaceSearch()
    if UnitFactionGroup("player")=="Alliance" then
        if ToonRaceClassCheck==1 then
            ToonRace = 'r-\"Draenei\" '
            ToonRaceName = 'Draenei'
            GuildManager:SendWhoRaceClass()
        elseif ToonRaceClassCheck==2 then
            ToonRace = 'r-\"Gnome\" '
            ToonRaceName = 'Gnome'
            GuildManager:SendWhoRaceClass()
        elseif ToonRaceClassCheck==3 then
            ToonRace = 'r-\"Human\" '
            ToonRaceName = 'Human'
            GuildManager:SendWhoRaceClass()
        elseif ToonRaceClassCheck==4 then
            ToonRace = 'r-\"Night elf\" '
            ToonRaceName = 'Night elf'
            GuildManager:SendWhoRaceClass()
        elseif ToonRaceClassCheck==5 then
            ToonRace = 'r-\"Pandaren\" '
            ToonRaceName = 'Pandaren'
            GuildManager:SendWhoRaceClass()
        elseif ToonRaceClassCheck==6 then
            RaceClassChecking=0
            ToonClassCheck=ToonClassCheck+1
            GuildManager:ClassControl()
        end
    elseif UnitFactionGroup("player")=="Horde" then
        if ToonRaceClassCheck==1 then
            ToonRace = 'r-\"Blood elf\" '
            ToonRaceName = 'Blood Elf'
            GuildManager:SendWhoRaceClass()
        elseif ToonRaceClassCheck==2 then
            ToonRace = 'r-\"Pandaren\" '
            ToonRaceName = 'Pandaren'
            GuildManager:SendWhoRaceClass()
        elseif ToonRaceClassCheck==3 then
            ToonRace = 'r-\"Troll\" '
            ToonRaceName = 'Troll'
            GuildManager:SendWhoRaceClass()
        elseif ToonRaceClassCheck==4 then
            ToonRace = 'r-\"Undead\" '
            ToonRaceName = 'Undead'
            GuildManager:SendWhoRaceClass()
        elseif ToonRaceClassCheck==5 then
            RaceClassChecking=0
            ToonClassCheck=ToonClassCheck+1
            GuildManager:ClassControl()
        end
    end
end

function GuildManager:MonkRaceSearch()
    if UnitFactionGroup("player")=="Alliance" then
        if ToonRaceClassCheck==1 then
            ToonRace = 'r-\"Draenei\" '
            ToonRaceName = 'Draenei'
            GuildManager:SendWhoRaceClass()
        elseif ToonRaceClassCheck==2 then
            ToonRace = 'r-\"Dwarf\" '
            ToonRaceName = 'Dwarf'
            GuildManager:SendWhoRaceClass()
        elseif ToonRaceClassCheck==3 then
            ToonRace = 'r-\"Gnome\" '
            ToonRaceName = 'Gnome'
            GuildManager:SendWhoRaceClass()
        elseif ToonRaceClassCheck==4 then
            ToonRace = 'r-\"Human\" '
            ToonRaceName = 'Human'
            GuildManager:SendWhoRaceClass()
        elseif ToonRaceClassCheck==5 then
            ToonRace = 'r-\"Night elf\" '
            ToonRaceName = 'Night elf'
            GuildManager:SendWhoRaceClass()
        elseif ToonRaceClassCheck==6 then
            ToonRace = 'r-\"Pandaren\" '
            ToonRaceName = 'Pandaren'
            GuildManager:SendWhoRaceClass()
        elseif ToonRaceClassCheck==7 then
            RaceClassChecking=0
            ToonClassCheck=ToonClassCheck+1
            GuildManager:ClassControl()
        end
    elseif UnitFactionGroup("player")=="Horde" then
        if ToonRaceClassCheck==1 then
            ToonRace = 'r-\"Blood elf\" '
            ToonRaceName = 'Blood Elf'
            GuildManager:SendWhoRaceClass()
        elseif ToonRaceClassCheck==2 then
            ToonRace = 'r-\"Orc\" '
            ToonRaceName = 'Orc'
            GuildManager:SendWhoRaceClass()
        elseif ToonRaceClassCheck==3 then
            ToonRace = 'r-\"Pandaren\" '
            ToonRaceName = 'Pandaren'
            GuildManager:SendWhoRaceClass()
        elseif ToonRaceClassCheck==4 then
            ToonRace = 'r-\"Tauren\" '
            ToonRaceName = 'Tauren'
            GuildManager:SendWhoRaceClass()
        elseif ToonRaceClassCheck==5 then
            ToonRace = 'r-\"Troll\" '
            ToonRaceName = 'Troll'
            GuildManager:SendWhoRaceClass()
        elseif ToonRaceClassCheck==6 then
            ToonRace = 'r-\"Undead\" '
            ToonRaceName = 'Undead'
            GuildManager:SendWhoRaceClass()
        elseif ToonRaceClassCheck==7 then
            RaceClassChecking=0
            ToonClassCheck=ToonClassCheck+1
            GuildManager:ClassControl()
        end
    end
end

function GuildManager:PaladinRaceSearch()
    if UnitFactionGroup("player")=="Alliance" then
        if ToonRaceClassCheck==1 then
            ToonRace = 'r-\"Draenei\" '
            ToonRaceName = 'Draenei'
            GuildManager:SendWhoRaceClass()
        elseif ToonRaceClassCheck==2 then
            ToonRace = 'r-\"Dwarf\" '
            ToonRaceName = 'Dwarf'
            GuildManager:SendWhoRaceClass()
        elseif ToonRaceClassCheck==3 then
            ToonRace = 'r-\"Human\" '
            ToonRaceName = 'Human'
            GuildManager:SendWhoRaceClass()
        elseif ToonRaceClassCheck==4 then
            RaceClassChecking=0
            ToonClassCheck=ToonClassCheck+1
            GuildManager:ClassControl()
        end
    elseif UnitFactionGroup("player")=="Horde" then
        if ToonRaceClassCheck==1 then
            ToonRace = 'r-\"Blood elf\" '
            ToonRaceName = 'Blood Elf'
            GuildManager:SendWhoRaceClass()
        elseif ToonRaceClassCheck==2 then
            ToonRace = 'r-\"Tauren\" '
            ToonRaceName = 'Tauren'
            GuildManager:SendWhoRaceClass()
        elseif ToonRaceClassCheck==3 then
            RaceClassChecking=0
            ToonClassCheck=ToonClassCheck+1
            GuildManager:ClassControl()
        end
    end
end

function GuildManager:PriestRaceSearch()
    if UnitFactionGroup("player")=="Alliance" then
        if ToonRaceClassCheck==1 then
            ToonRace = 'r-\"Draenei\" '
            ToonRaceName = 'Draenei'
            GuildManager:SendWhoRaceClass()
        elseif ToonRaceClassCheck==2 then
            ToonRace = 'r-\"Dwarf\" '
            ToonRaceName = 'Dwarf'
            GuildManager:SendWhoRaceClass()
        elseif ToonRaceClassCheck==3 then
            ToonRace = 'r-\"Gnome\" '
            ToonRaceName = 'Gnome'
            GuildManager:SendWhoRaceClass()
        elseif ToonRaceClassCheck==4 then
            ToonRace = 'r-\"Human\" '
            ToonRaceName = 'Human'
            GuildManager:SendWhoRaceClass()
        elseif ToonRaceClassCheck==5 then
            ToonRace = 'r-\"Night elf\" '
            ToonRaceName = 'Night elf'
            GuildManager:SendWhoRaceClass()
        elseif ToonRaceClassCheck==6 then
            ToonRace = 'r-\"Pandaren\" '
            ToonRaceName = 'Pandaren'
            GuildManager:SendWhoRaceClass()
        elseif ToonRaceClassCheck==7 then
            ToonRace = 'r-\"Worgen\" '
            ToonRaceName = 'Worgen'
            GuildManager:SendWhoRaceClass()
        elseif ToonRaceClassCheck==8 then
            RaceClassChecking=0
            ToonClassCheck=ToonClassCheck+1
            GuildManager:ClassControl()
        end
    elseif UnitFactionGroup("player")=="Horde" then
        if ToonRaceClassCheck==1 then
            ToonRace = 'r-\"Blood elf\" '
            ToonRaceName = 'Blood Elf'
            GuildManager:SendWhoRaceClass()
        elseif ToonRaceClassCheck==2 then
            ToonRace = 'r-\"Goblin\" '
            ToonRaceName = 'Goblin'
            GuildManager:SendWhoRaceClass()
        elseif ToonRaceClassCheck==3 then
            ToonRace = 'r-\"Pandaren\" '
            ToonRaceName = 'Pandaren'
            GuildManager:SendWhoRaceClass()
        elseif ToonRaceClassCheck==4 then
            ToonRace = 'r-\"Tauren\" '
            ToonRaceName = 'Tauren'
            GuildManager:SendWhoRaceClass()
        elseif ToonRaceClassCheck==5 then
            ToonRace = 'r-\"Troll\" '
            ToonRaceName = 'Troll'
            GuildManager:SendWhoRaceClass()
        elseif ToonRaceClassCheck==6 then
            ToonRace = 'r-\"Undead\" '
            ToonRaceName = 'Undead'
            GuildManager:SendWhoRaceClass()
        elseif ToonRaceClassCheck==7 then
            RaceClassChecking=0
            ToonClassCheck=ToonClassCheck+1
            GuildManager:ClassControl()
        end
    end
end

function GuildManager:RogueRaceSearch()
    if UnitFactionGroup("player")=="Alliance" then
        if ToonRaceClassCheck==1 then
            ToonRace = 'r-\"Dwarf\" '
            ToonRaceName = 'Dwarf'
            GuildManager:SendWhoRaceClass()
        elseif ToonRaceClassCheck==2 then
            ToonRace = 'r-\"Gnome\" '
            ToonRaceName = 'Gnome'
            GuildManager:SendWhoRaceClass()
        elseif ToonRaceClassCheck==3 then
            ToonRace = 'r-\"Human\" '
            ToonRaceName = 'Human'
            GuildManager:SendWhoRaceClass()
        elseif ToonRaceClassCheck==4 then
            ToonRace = 'r-\"Night elf\" '
            ToonRaceName = 'Night elf'
            GuildManager:SendWhoRaceClass()
        elseif ToonRaceClassCheck==5 then
            ToonRace = 'r-\"Pandaren\" '
            ToonRaceName = 'Pandaren'
            GuildManager:SendWhoRaceClass()
        elseif ToonRaceClassCheck==6 then
            ToonRace = 'r-\"Worgen\" '
            ToonRaceName = 'Worgen'
            GuildManager:SendWhoRaceClass()
        elseif ToonRaceClassCheck==7 then
            RaceClassChecking=0
            ToonClassCheck=ToonClassCheck+1
            GuildManager:ClassControl()
        end
    elseif UnitFactionGroup("player")=="Horde" then
        if ToonRaceClassCheck==1 then
            ToonRace = 'r-\"Blood elf\" '
            ToonRaceName = 'Blood Elf'
            GuildManager:SendWhoRaceClass()
        elseif ToonRaceClassCheck==2 then
            ToonRace = 'r-\"Goblin\" '
            ToonRaceName = 'Goblin'
            GuildManager:SendWhoRaceClass()
        elseif ToonRaceClassCheck==3 then
            ToonRace = 'r-\"Orc\" '
            ToonRaceName = 'Orc'
            GuildManager:SendWhoRaceClass()
        elseif ToonRaceClassCheck==4 then
            ToonRace = 'r-\"Pandaren\" '
            ToonRaceName = 'Pandaren'
            GuildManager:SendWhoRaceClass()
        elseif ToonRaceClassCheck==5 then
            ToonRace = 'r-\"Troll\" '
            ToonRaceName = 'Troll'
            GuildManager:SendWhoRaceClass()
        elseif ToonRaceClassCheck==6 then
            ToonRace = 'r-\"Undead\" '
            ToonRaceName = 'Undead'
            GuildManager:SendWhoRaceClass()
        elseif ToonRaceClassCheck==7 then
            RaceClassChecking=0
            ToonClassCheck=ToonClassCheck+1
            GuildManager:ClassControl()
        end
    end
end

function GuildManager:ShamanRaceSearch()
    if UnitFactionGroup("player")=="Alliance" then
        if ToonRaceClassCheck==1 then
            ToonRace = 'r-\"Draenei\" '
            ToonRaceName = 'Draenei'
            GuildManager:SendWhoRaceClass()
        elseif ToonRaceClassCheck==2 then
            ToonRace = 'r-\"Dwarf\" '
            ToonRaceName = 'Dwarf'
            GuildManager:SendWhoRaceClass()
        elseif ToonRaceClassCheck==3 then
            ToonRace = 'r-\"Pandaren\" '
            ToonRaceName = 'Pandaren'
            GuildManager:SendWhoRaceClass()
        elseif ToonRaceClassCheck==4 then
            RaceClassChecking=0
            ToonClassCheck=ToonClassCheck+1
            GuildManager:ClassControl()
        end
    elseif UnitFactionGroup("player")=="Horde" then
        if ToonRaceClassCheck==1 then
            ToonRace = 'r-\"Goblin\" '
            ToonRaceName = 'Goblin'
            GuildManager:SendWhoRaceClass()
        elseif ToonRaceClassCheck==2 then
            ToonRace = 'r-\"Orc\" '
            ToonRaceName = 'Orc'
            GuildManager:SendWhoRaceClass()
        elseif ToonRaceClassCheck==3 then
            ToonRace = 'r-\"Pandaren\" '
            ToonRaceName = 'Pandaren'
            GuildManager:SendWhoRaceClass()
        elseif ToonRaceClassCheck==4 then
            ToonRace = 'r-\"Tauren\" '
            ToonRaceName = 'Tauren'
            GuildManager:SendWhoRaceClass()
        elseif ToonRaceClassCheck==5 then
            ToonRace = 'r-\"Troll\" '
            ToonRaceName = 'Troll'
            GuildManager:SendWhoRaceClass()
        elseif ToonRaceClassCheck==6 then
            RaceClassChecking=0
            ToonClassCheck=ToonClassCheck+1
            GuildManager:ClassControl()
        end
    end
end

function GuildManager:WarlockRaceSearch()
    if UnitFactionGroup("player")=="Alliance" then
        if ToonRaceClassCheck==1 then
            ToonRace = 'r-\"Dwarf\" '
            ToonRaceName = 'Dwarf'
            GuildManager:SendWhoRaceClass()
        elseif ToonRaceClassCheck==2 then
            ToonRace = 'r-\"Gnome\" '
            ToonRaceName = 'Gnome'
            GuildManager:SendWhoRaceClass()
        elseif ToonRaceClassCheck==3 then
            ToonRace = 'r-\"Human\" '
            ToonRaceName = 'Human'
            GuildManager:SendWhoRaceClass()
        elseif ToonRaceClassCheck==4 then
            ToonRace = 'r-\"Night elf\" '
            ToonRaceName = 'Night elf'
            GuildManager:SendWhoRaceClass()
        elseif ToonRaceClassCheck==5 then
            RaceClassChecking=0
            ToonClassCheck=ToonClassCheck+1
            GuildManager:ClassControl()
        end
    elseif UnitFactionGroup("player")=="Horde" then
        if ToonRaceClassCheck==1 then
            ToonRace = 'r-\"Blood elf\" '
            ToonRaceName = 'Blood Elf'
            GuildManager:SendWhoRaceClass()
        elseif ToonRaceClassCheck==2 then
            ToonRace = 'r-\"Goblin\" '
            ToonRaceName = 'Goblin'
            GuildManager:SendWhoRaceClass()
        elseif ToonRaceClassCheck==3 then
            ToonRace = 'r-\"Orc\" '
            ToonRaceName = 'Orc'
            GuildManager:SendWhoRaceClass()
        elseif ToonRaceClassCheck==4 then
            ToonRace = 'r-\"Troll\" '
            ToonRaceName = 'Troll'
            GuildManager:SendWhoRaceClass()
        elseif ToonRaceClassCheck==5 then
            ToonRace = 'r-\"Undead\" '
            ToonRaceName = 'Undead'
            GuildManager:SendWhoRaceClass()
        elseif ToonRaceClassCheck==6 then
            RaceClassChecking=0
            ToonClassCheck=ToonClassCheck+1
            GuildManager:ClassControl()
        end
    end
end

function GuildManager:WarriorRaceSearch()
    if UnitFactionGroup("player")=="Alliance" then
        if ToonRaceClassCheck==1 then
            ToonRace = 'r-\"Draenei\" '
            ToonRaceName = 'Draenei'
            GuildManager:SendWhoRaceClass()
        elseif ToonRaceClassCheck==2 then
            ToonRace = 'r-\"Dwarf\" '
            ToonRaceName = 'Dwarf'
            GuildManager:SendWhoRaceClass()
        elseif ToonRaceClassCheck==3 then
            ToonRace = 'r-\"Gnome\" '
            ToonRaceName = 'Gnome'
            GuildManager:SendWhoRaceClass()
        elseif ToonRaceClassCheck==4 then
            ToonRace = 'r-\"Human\" '
            ToonRaceName = 'Human'
            GuildManager:SendWhoRaceClass()
        elseif ToonRaceClassCheck==5 then
            ToonRace = 'r-\"Night elf\" '
            ToonRaceName = 'Night elf'
            GuildManager:SendWhoRaceClass()
        elseif ToonRaceClassCheck==6 then
            ToonRace = 'r-\"Pandaren\" '
            ToonRaceName = 'Pandaren'
            GuildManager:SendWhoRaceClass()
        elseif ToonRaceClassCheck==7 then
            ToonRace = 'r-\"Worgen\" '
            ToonRaceName = 'Worgen'
            GuildManager:SendWhoRaceClass()
        elseif ToonRaceClassCheck==8 then
            RaceClassChecking=0
            ToonClassCheck=ToonClassCheck+1
            GuildManager:ClassControl()
        end
    elseif UnitFactionGroup("player")=="Horde" then
        if ToonRaceClassCheck==1 then
            ToonRace = 'r-\"Blood elf\" '
            ToonRaceName = 'Blood Elf'
            GuildManager:SendWhoRaceClass()
        elseif ToonRaceClassCheck==2 then
            ToonRace = 'r-\"Goblin\" '
            ToonRaceName = 'Goblin'
            GuildManager:SendWhoRaceClass()
        elseif ToonRaceClassCheck==3 then
            ToonRace = 'r-\"Orc\" '
            ToonRaceName = 'Orc'
            GuildManager:SendWhoRaceClass()
        elseif ToonRaceClassCheck==4 then
            ToonRace = 'r-\"Pandaren\" '
            ToonRaceName = 'Pandaren'
            GuildManager:SendWhoRaceClass()
        elseif ToonRaceClassCheck==5 then
            ToonRace = 'r-\"Tauren\" '
            ToonRaceName = 'Tauren'
            GuildManager:SendWhoRaceClass()
        elseif ToonRaceClassCheck==6 then
            ToonRace = 'r-\"Troll\" '
            ToonRaceName = 'Troll'
            GuildManager:SendWhoRaceClass()
        elseif ToonRaceClassCheck==7 then
            ToonRace = 'r-\"Undead\" '
            ToonRaceName = 'Undead'
            GuildManager:SendWhoRaceClass()
        elseif ToonRaceClassCheck==8 then
            RaceClassChecking=0
            ToonClassCheck=ToonClassCheck+1
            GuildManager:ClassControl()
        end
    end
end

--Types of Who Searches--
function GuildManager:SendWhoLevel()
    if WhoHalt==nil or WhoHalt==0 then
        if GetNumGuildMembers()<=999 and GuildManager.db.profile.membercap>GetNumGuildMembers() then
            SetWhoToUI(1)
            FriendsFrame:UnregisterEvent("WHO_LIST_UPDATE")
            WhoReturned=0
            if WhoFailed==0 then
                GuildManager:ScheduleTimer("WhoFailure", 10)
            elseif WhoFailed==1 then
                GuildManager:ScheduleTimer("WhoFailure2", 10)
            elseif WhoFailed==2 then
                GuildManager:ScheduleTimer("WhoFailure3", 10)
            end
            GuildManager:RegisterEvent("WHO_LIST_UPDATE", "GRAfterWho")
            SendWho(ToonLevel)
        else
            LevelChecking=0
            ClassChecking=0
            RaceClassChecking=0
            ToonLevelCheck=0
            ToonClassCheck=0
            ToonRaceClassCheck=0
            WhoCycle=0
        end
    else
        GuildManager:Print('Character Recruitment Cycle Halted.')
        LevelChecking=0
        ClassChecking=0
        RaceClassChecking=0
        ToonLevelCheck=0
        ToonClassCheck=0
        ToonRaceClassCheck=0
        WhoCycle=0
        WhoHalt=0
    end
end

function GuildManager:SendWhoClass()
    if WhoHalt==nil or WhoHalt==0 then
        if GetNumGuildMembers()<=999 and GuildManager.db.profile.membercap>GetNumGuildMembers() then
            SetWhoToUI(1)
            FriendsFrame:UnregisterEvent("WHO_LIST_UPDATE")
            WhoReturned=0
            if WhoFailed==0 then
                GuildManager:ScheduleTimer("WhoFailure", 10)
            elseif WhoFailed==1 then
                GuildManager:ScheduleTimer("WhoFailure2", 10)
            elseif WhoFailed==2 then
                GuildManager:ScheduleTimer("WhoFailure3", 10)
            end
            GuildManager:RegisterEvent("WHO_LIST_UPDATE", "GRAfterWho")
            SendWho(strjoin(" ",ToonLevel,ToonClass))
        else
            GuildManager:Print('Character Recruitment Cycle Complete. Guild Population is at Maximum')
            LevelChecking=0
            ClassChecking=0
            RaceClassChecking=0
            ToonLevelCheck=0
            ToonClassCheck=0
            ToonRaceClassCheck=0
            WhoCycle=0
        end
    else
        GuildManager:Print('Character Recruitment Cycle Halted.')
        LevelChecking=0
        ClassChecking=0
        RaceClassChecking=0
        ToonLevelCheck=0
        ToonClassCheck=0
        ToonRaceClassCheck=0
        WhoCycle=0
        WhoHalt=0
    end
end

function GuildManager:SendWhoRaceClass()
    if WhoHalt==nil or WhoHalt==0 then
        if GetNumGuildMembers()<=999 and GuildManager.db.profile.membercap>GetNumGuildMembers() then
            SetWhoToUI(1)
            FriendsFrame:UnregisterEvent("WHO_LIST_UPDATE")
            WhoReturned=0
            if WhoFailed==0 then
                GuildManager:ScheduleTimer("WhoFailure", 10)
            elseif WhoFailed==1 then
                GuildManager:ScheduleTimer("WhoFailure2", 10)
            elseif WhoFailed==2 then
                GuildManager:ScheduleTimer("WhoFailure3", 10)
            end
            GuildManager:RegisterEvent("WHO_LIST_UPDATE", "GRAfterWho")
            SendWho(strjoin(" ",ToonLevel,ToonClass,ToonRace))
        else
            GuildManager:Print('Character Recruitment Cycle Complete. Guild Population is at Maximum')
            LevelChecking=0
            ClassChecking=0
            RaceClassChecking=0
            ToonLevelCheck=0
            ToonClassCheck=0
            ToonRaceClassCheck=0
            WhoCycle=0
        end
    else
        GuildManager:Print('Character Recruitment Cycle Halted.')
        LevelChecking=0
        ClassChecking=0
        RaceClassChecking=0
        ToonLevelCheck=0
        ToonClassCheck=0
        ToonRaceClassCheck=0
        WhoCycle=0
        WhoHalt=0
    end
end

--WHO FAILURE--
function GuildManager:WhoFailure()
    if WhoReturned==0 then
        GuildManager:Print("ATTENTION: Server did NOT return search results. Sending Again (2nd Attempt)")
        WhoFailed=1
        if ClassChecking==0 and RaceClassChecking==0 then
            GuildManager:SendWhoLevel()
        elseif ClassChecking==1 and RaceClassChecking==0 then
            GuildManager:SendWhoClass()
        elseif ClassChecking==1 and RaceClassChecking==1 then
            GuildManager:SendWhoRaceClass()
        end
    end
end

function GuildManager:WhoFailure2()
    GuildManager:Print("ATTENTION: Server did NOT return search results. Sending Again (3rd Attempt)")
    if ClassChecking==0 and RaceClassChecking==0 then
        GuildManager:SendWhoLevel()
    elseif ClassChecking==1 and RaceClassChecking==0 then
        GuildManager:SendWhoClass()
    elseif ClassChecking==1 and RaceClassChecking==1 then
        GuildManager:SendWhoRaceClass()
    end
end

function GuildManager:WhoFailure3()
    if WhoReturned==0 then
        GuildManager:Print("ATTENTION: Server did NOT return search results. Permanent Failure! Ending Who Recruitment Cycle")
        GuildManager:UnregisterEvent("WHO_LIST_UPDATE")
        WhoFailed=3
        WhoCycle=0
    end
end

--Who Invite Functions--
function GuildManager:GRAfterWho()
    WhoReturned=1
    if GRbutton==1 then
        FriendsFrame:Hide()
        GuildManager:UnregisterEvent("WHO_LIST_UPDATE")
    elseif GRbutton==2 then
        FriendsFrame:Show()
        FriendsFrameTab1:Click()
        GuildManager:UnregisterEvent("WHO_LIST_UPDATE")
    elseif GRbutton==3 then
        FriendsFrame:Show()
        FriendsFrameTab2:Click()
        GuildManager:UnregisterEvent("WHO_LIST_UPDATE")
    elseif GRbutton==4 then
        FriendsFrame:Show()
        FriendsFrameTab3:Click()
        GuildManager:UnregisterEvent("WHO_LIST_UPDATE")
    elseif GRbutton==5 then
        FriendsFrame:Show()
        FriendsFrameTab4:Click()
        GuildManager:UnregisterEvent("WHO_LIST_UPDATE")
    else
    end
    WhoFailed=0
    GuildManager:WhoResultsCheck()
end

function GuildManager:WhoResultsCheck()
    GuildRoster()
    if GetNumGuildMembers()<=999 and GuildManager.db.profile.membercap>GetNumGuildMembers() then
        local totalcount,numwhos = GetNumWhoResults()
        if totalcount<=49 and LevelChecking==0 and ClassChecking==0 and RaceClassChecking==0 then
            GuildManager:WhoInvite()
            ToonMaxLevel=ToonMinLevel-1
            GuildManager:ScheduleTimer("LevelRangeSearch", 10)
        elseif totalcount<=49 and LevelChecking==1 and ClassChecking==0 and RaceClassChecking==0 then
            GuildManager:WhoInvite()
            ToonLevelCheck=ToonLevelCheck+1
            GuildManager:ScheduleTimer("LevelSearch", 10)
        elseif totalcount<=49 and LevelChecking==1 and ClassChecking==1 and RaceClassChecking==0 then
            GuildManager:WhoInvite()
            ToonClassCheck=ToonClassCheck+1
            GuildManager:ScheduleTimer("ClassControl", 10)
        elseif totalcount<=49 and LevelChecking==1 and ClassChecking==1 and RaceClassChecking==1 then
            GuildManager:WhoInvite()
            ToonRaceClassCheck=ToonRaceClassCheck+1
            GuildManager:ScheduleTimer("RaceClassControl", 10)
        elseif totalcount==50 and LevelChecking==0 and ClassChecking==0 and RaceClassChecking==0 then
            GuildManager:WhoInvite()
            ToonLevelCheck=0
            GuildManager:ScheduleTimer("LevelSearch", 10)
        elseif totalcount==50 and LevelChecking==1 and ClassChecking==0 and RaceClassChecking==0 then
            GuildManager:WhoInvite()
            ToonClassCheck=0
            GuildManager:ScheduleTimer("ClassControl", 10)
        elseif totalcount>=50 and LevelChecking==1 and ClassChecking==1 and RaceClassChecking==0 then
            GuildManager:WhoInvite()
            ToonRaceClassCheck=0
            GuildManager:ScheduleTimer("RaceClassControl", 10)
        elseif totalcount>=50 and LevelChecking==1 and ClassChecking==1 and RaceClassChecking==1 then
            GuildManager:WhoInvite()
            ToonRaceClassCheck=ToonRaceClassCheck+1
            GuildManager:ScheduleTimer("RaceClassControl", 10)
        else
        end
    else
        GuildManager:Print('Character Recruitment Cycle Complete. Guild Population is at Maximum')
        LevelChecking=0
        ClassChecking=0
        RaceClassChecking=0
        ToonLevelCheck=0
        ToonClassCheck=0
        ToonRaceClassCheck=0
        WhoCycle=0
    end
end

function GuildManager:WhoInvite()
    if GetNumGuildMembers()<=999 and GuildManager.db.profile.membercap>GetNumGuildMembers() then
        freshinvite=0
        guildedinvite=0
        dnioverrided=0
        for i=1,GetNumWhoResults() do local whoname,whoguild,wholevel,whorace,whoclass,whozone,whoclassFileName = GetWhoInfo(i)
            if string.match(whoname, "-") then
            else
                whoname = strjoin("-",whoname,GetRealmName());
            end
            if GuildManager.db.profile.targetclass==false or (GuildManager.db.profile.targetclass==true and GuildManager.db.profile.DKsearch==true and whoclass=='Death Knight') or (GuildManager.db.profile.targetclass==true and GuildManager.db.profile.DHsearch==true and whoclass=='Demon Hunter') or (GuildManager.db.profile.targetclass==true and GuildManager.db.profile.Druidsearch==true and whoclass=='Druid') or (GuildManager.db.profile.targetclass==true and GuildManager.db.profile.Huntersearch==true and whoclass=='Hunter') or (GuildManager.db.profile.targetclass==true and GuildManager.db.profile.Magesearch==true and whoclass=='Mage') or (GuildManager.db.profile.targetclass==true and GuildManager.db.profile.Paladinsearch==true and whoclass=='Paladin') or (GuildManager.db.profile.targetclass==true and GuildManager.db.profile.Priestsearch==true and whoclass=='Priest') or (GuildManager.db.profile.targetclass==true and GuildManager.db.profile.Roguesearch==true and whoclass=='Rogue') or (GuildManager.db.profile.targetclass==true and GuildManager.db.profile.Shamansearch==true and whoclass=='Shaman') or (GuildManager.db.profile.targetclass==true and GuildManager.db.profile.Warlocksearch==true and whoclass=='Warlock') or (GuildManager.db.profile.targetclass==true and GuildManager.db.profile.Warriorsearch==true and whoclass=='Warrior') then
                if whoguild=="" then
                    if tContains(GMInstancet, whozone)~=1 then
                        if tContains(GuildManager.db.profile.GMDNIt, whoname)~=1 then
                            if tContains(GuildManager.db.profile.GMBlackt, whoname)~=1 then
                                if whoguild=="" then
                                    if tContains(GuildManager.db.profile.GMIQt, whoname)~=1 then
                                        GuildManager:Print(strjoin(" ",whoname,'is NOT in a Guild! They have been added to the Invite Queue!'))
                                        table.insert(GuildManager.db.profile.GMIQt, whoname)
                                        GMIQt=GuildManager.db.profile.GMIQt
                                        pairsByKeysIQ(GMIQt)
                                    end
                                end
                                if whoguild~="" then
                                    guildedinvite=guildedinvite+1
                                end
                                if tContains(GuildManager.db.profile.GMDNIt, whoname)==1 then
                                    dnioverrided=dnioverrided+1
                                end
                                freshinvite=freshinvite+1
                            end
                        end
                    end
                end
            end
        end
    else
        GuildManager:Print('Character Recruitment Cycle Complete. Guild Population is at Maximum')
        LevelChecking=0
        ClassChecking=0
        RaceClassChecking=0
        ToonLevelCheck=0
        ToonClassCheck=0
        ToonRaceClassCheck=0
        WhoCycle=0
    end
end

GMInstancet = {}

--Manual Invite Script--
function GuildManager:InviteAction()
    if #(GuildManager.db.profile.GMIQt)~=0 then
        for k,v in pairs(GuildManager.db.profile.GMIQt) do
            if 1==k then
                GMIQtop=v
            end
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
        if GuildManager.db.profile.whisperonly==false then
            GuildInvite(GMIQtop)
        else
            SendChatMessage(GuildManager.db.profile.whispmessage,"WHISPER",nil,GMIQtop)
        end
        GuildManager:tremovebyval(GuildManager.db.profile.GMIQt, GMIQtop)
    else
    end
end