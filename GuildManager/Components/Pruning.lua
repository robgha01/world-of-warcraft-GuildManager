-- Author      : Robert
-- Create Date : 9/1/2017 3:50:17 PM

--*PRUNING*--
function GuildManager:GKRun()
    if IsGuildLeader()==true or IsGuildLeader()~=true then
        GuildRoster()
        GuildManager:GKLevelCalc()
        GuildManager:GKInactivityCalc()
        GuildManager:GKAltExemptTable()
        GuildManager:GKRankExemptTable()
        GuildManager:GKKickTable()
    else
        GuildManager:Print('Member Prune Cycle did NOT start! Only Guild Leaders can use this function!')
    end
end

--Level and Inactivity Calc--
function GuildManager:GKLevelCalc()
    GKlvl=GuildManager.db.profile.levelthreshold
    GuildManager:GKByLevelTable()
end

function GuildManager:GKInactivityCalc()
    if GuildManager.db.profile.daysinactive<=365 and GuildManager.db.profile.daysinactive>=360 then
        GKy=1
        GKm=0
        GKd=0
        GuildManager:GKParseTime()
        GuildManager:GKByInactivityTable()
    elseif GuildManager.db.profile.daysinactive<360 and GuildManager.db.profile.daysinactive>=330 then
        GKy=0
        GKm=11
        GKd=GuildManager.db.profile.daysinactive-(30*11)
        GuildManager:GKParseTime()
        GuildManager:GKByInactivityTable()
    elseif GuildManager.db.profile.daysinactive<330 and GuildManager.db.profile.daysinactive>=300 then
        GKy=0
        GKm=10
        GKd=GuildManager.db.profile.daysinactive-(30*10)
        GuildManager:GKParseTime()
        GuildManager:GKByInactivityTable()
    elseif GuildManager.db.profile.daysinactive<300 and GuildManager.db.profile.daysinactive>=270 then
        GKy=0
        GKm=9
        GKd=GuildManager.db.profile.daysinactive-(30*9)
        GuildManager:GKParseTime()
        GuildManager:GKByInactivityTable()
    elseif GuildManager.db.profile.daysinactive<270 and GuildManager.db.profile.daysinactive>=240 then
        GKy=0
        GKm=8
        GKd=GuildManager.db.profile.daysinactive-(30*8)
        GuildManager:GKParseTime()
        GuildManager:GKByInactivityTable()
    elseif GuildManager.db.profile.daysinactive<240 and GuildManager.db.profile.daysinactive>=210 then
        GKy=0
        GKm=7
        GKd=GuildManager.db.profile.daysinactive-(30*7)
        GuildManager:GKParseTime()
        GuildManager:GKByInactivityTable()
    elseif GuildManager.db.profile.daysinactive<210 and GuildManager.db.profile.daysinactive>=180 then
        GKy=0
        GKm=6
        GKd=GuildManager.db.profile.daysinactive-(30*6)
        GuildManager:GKParseTime()
        GuildManager:GKByInactivityTable()
    elseif GuildManager.db.profile.daysinactive<180 and GuildManager.db.profile.daysinactive>=150 then
        GKy=0
        GKm=5
        GKd=GuildManager.db.profile.daysinactive-(30*5)
        GuildManager:GKParseTime()
        GuildManager:GKByInactivityTable()
    elseif GuildManager.db.profile.daysinactive<150 and GuildManager.db.profile.daysinactive>=120 then
        GKy=0
        GKm=4
        GKd=GuildManager.db.profile.daysinactive-(30*4)
        GuildManager:GKParseTime()
        GuildManager:GKByInactivityTable()
    elseif GuildManager.db.profile.daysinactive<120 and GuildManager.db.profile.daysinactive>=90 then
        GKy=0
        GKm=3
        GKd=GuildManager.db.profile.daysinactive-(30*3)
        GuildManager:GKParseTime()
        GuildManager:GKByInactivityTable()
    elseif GuildManager.db.profile.daysinactive<90 and GuildManager.db.profile.daysinactive>=60 then
        GKy=0
        GKm=2
        GKd=GuildManager.db.profile.daysinactive-(30*2)
        GuildManager:GKParseTime()
        GuildManager:GKByInactivityTable()
    elseif GuildManager.db.profile.daysinactive<60 and GuildManager.db.profile.daysinactive>=30 then
        GKy=0
        GKm=1
        GKd=GuildManager.db.profile.daysinactive-30
        GuildManager:GKParseTime()
        GuildManager:GKByInactivityTable()
    elseif GuildManager.db.profile.daysinactive<30 and GuildManager.db.profile.daysinactive>=1 then
        GKy=0
        GKm=0
        GKd=GuildManager.db.profile.daysinactive
        GuildManager:GKParseTime()
        GuildManager:GKByInactivityTable()
    else
    end
end

function GuildManager:GKParseTime()
    if GKm>0 and GKd==0 then
        GKm1=GKm
        GKd1=GKd
        GKm2=GKm
        GKd2=GKd
    elseif GKm>0 and GKd>0 then
        GKm1=GKm
        GKd1=GKd
        GKm2=GKm+1
        GKd2=0
    elseif GKm==0 and GKd>0 then
        GKm1=GKm
        GKd1=GKd
        GKm2=GKm+1
        GKd2=0
    elseif GKy==1 and GKm==0 and GKd==0 then
        GKm1=99
        GKd1=99
        GKm2=99
        GKd2=99
    else
    end
end

--Kick Table Generators--
function GuildManager:GKByLevelTable()
    GKlvlt = {}
    for i=1,GetNumGuildMembers(true) do local name,_,_,level = GetGuildRosterInfo(i);
        if GuildManager.db.profile.removelevels==true and level<=GKlvl then
            tinsert(GKlvlt, i);
        end
    end
end

function GuildManager:GKByInactivityTable()
    GKInactivet = {}
    for i=1,GetNumGuildMembers() do local y,m,d=GetGuildRosterLastOnline(i)
        if y then
            if GuildManager.db.profile.removeinactive==true and ((y>=0 and m==GKm1 and d>=GKd1) or (y>=0 and m>=GKm2 and d>=GKd2) or (y>=1 and m>=0 and d>=0)) then
                tinsert(GKInactivet, i)
            end
        end
    end
end

--Exemption Table Generators--
function GuildManager:GKAltExemptTable()
    GKAltt = {}
    for i=1,GetNumGuildMembers(true) do local name,_,_,_,_,_,note,officer = GetGuildRosterInfo(i);
        if GuildManager.db.profile.exemptalt==true and (string.find(note, "Alt")~=nil or string.find(note, "AlT")~=nil or string.find(note, "ALt")~=nil or string.find(note, "ALT")~=nil or string.find(note, "aLt")~=nil or string.find(note, "aLT")~=nil or string.find(note, "alt")~=nil or string.find(note, "alT")~=nil or string.find(officer, "Alt")~=nil or string.find(officer, "AlT")~=nil or string.find(officer, "ALt")~=nil or string.find(officer, "ALT")~=nil or string.find(officer, "aLt")~=nil or string.find(officer, "aLT")~=nil or string.find(officer, "alt")~=nil or string.find(officer, "alT")~=nil) then
            tinsert(GKAltt, i);
        end
    end
end

function GuildManager:GKRankExemptTable()
    GKRankt = {}
    for i=1,GetNumGuildMembers(true) do local name,rank,rankindex = GetGuildRosterInfo(i);
        if GuildManager.db.profile.exemptranks==true and (rankindex==0 or (GuildManager.db.profile.exemptrank1==true and rankindex==1) or (GuildManager.db.profile.exemptrank2==true and rankindex==2) or (GuildManager.db.profile.exemptrank3==true and rankindex==3) or (GuildManager.db.profile.exemptrank4==true and rankindex==4) or (GuildManager.db.profile.exemptrank5==true and rankindex==5) or (GuildManager.db.profile.exemptrank6==true and rankindex==6) or (GuildManager.db.profile.exemptrank7==true and rankindex==7) or (GuildManager.db.profile.exemptrank8==true and rankindex==8) or (GuildManager.db.profile.exemptrank9==true and rankindex==9)) then
            tinsert(GKRankt, i);
        end
    end
end


--Kick Functions--
function GuildManager:GKKickTable()
    GKKickt = {}
    blacklistkick=0
    inactivekick=0
    lowlevelkick=0
    lowinactivekick=0
    removeprunednil=0
    for i=1,GetNumGuildMembers(true) do local name,_,_,level = GetGuildRosterInfo(i);
        if tContains(GuildManager.db.profile.GMBlackt, name)==1 then
            tinsert(GKKickt, name)
            blacklistkick=blacklistkick+1
        end
        if tContains(GKAltt, i)~=1 and tContains(GKRankt, i)~=1 and tContains(GKKickt, name)~=1 and tContains(GuildManager.db.profile.GMPruneExemptt, name)~=1 then
            if tContains(GKInactivet, i)==1 and GuildManager.db.profile.removelevels==false then
                tinsert(GKKickt, name)
                inactivekick=inactivekick+1
            elseif tContains(GKlvlt, i)==1 and GuildManager.db.profile.removeinactive==false then
                tinsert(GKKickt, name)
                lowlevelkick=lowlevelkick+1
            elseif tContains(GKlvlt, i)==1 and tContains(GKInactivet, i)==1 then
                tinsert(GKKickt, name)
                lowinactivekick=lowinactivekick+1
            end
        end
    end
    for k,v in pairs(GKKickt) do
        if tContains(GuildManager.db.profile.GMDNIt, v)==1 and GuildManager.db.profile.removefromdnil==true then
            GuildManager:tremovebyval(GuildManager.db.profile.GMDNIt, v)
            GMDNIt=GuildManager.db.profile.GMDNIt
            pairsByKeysDNI(GMDNIt)
            removeprunednil=removeprunednil+1
        end
        GuildUninvite(v)
    end
    if GuildManager.db.profile.pruneannounce==3 then
        GuildManager:GKKickStatsGuildAnnounce()
    end
    if GuildManager.db.profile.pruneannounce==2 then
        GuildManager:GKKickStatsOfficerAnnounce()
    end
end

function GuildManager:GKKickStatsGuildAnnounce()
    if removeprunednil>0 then
        SendChatMessage(strjoin(" ",removeprunednil,"members were removed from the Do Not Invite List"),"guild", nil,"GUILD")
    end
    if blacklistkick>0 then
        SendChatMessage(strjoin(" ",blacklistkick,"members were removed from the guild because they were on the black list!"),"guild", nil,"GUILD")
    end
    if inactivekick>0 then
        SendChatMessage(strjoin(" ",inactivekick,"members were removed from the guild because they were offline for",GuildManager.db.profile.daysinactive,"or more consecutive days!"),"guild", nil,"GUILD")
    end
    if lowlevelkick>0 then
        SendChatMessage(strjoin(" ",lowlevelkick,"members were removed from the guild because they were at or below level",GuildManager.db.profile.levelthreshold,"!"),"guild", nil,"GUILD")
    end
    if lowinactivekick>0 then
        SendChatMessage(strjoin(" ",lowinactivekick,"members were removed from the guild because they were offline for",GuildManager.db.profile.daysinactive,"or more consecutive days AND they were at or below level",GuildManager.db.profile.levelthreshold,"!"),"guild", nil,"GUILD")
    end
end

function GuildManager:GKKickStatsOfficerAnnounce()
    if removeprunednil>0 then
        SendChatMessage(strjoin(" ",removeprunednil,"members were removed from the Do Not Invite List"),"officer", nil,"OFFICER")
    end
    if blacklistkick>0 then
        SendChatMessage(strjoin(" ",blacklistkick,"members were removed from the guild because they were on the black list!"),"officer", nil,"OFFICER")
    end
    if inactivekick>0 then
        SendChatMessage(strjoin(" ",inactivekick,"members were removed from the guild because they were offline for",GuildManager.db.profile.daysinactive,"or more consecutive days!"),"officer", nil,"OFFICER")
    end
    if lowlevelkick>0 then
        SendChatMessage(strjoin(" ",lowlevelkick,"members were removed from the guild because they were at or below level",GuildManager.db.profile.levelthreshold,"!"),"officer", nil,"OFFICER")
    end
    if lowinactivekick>0 then
        SendChatMessage(strjoin(" ",lowinactivekick,"members were removed from the guild because they were offline for",GuildManager.db.profile.daysinactive,"or more consecutive days AND they were at or below level",GuildManager.db.profile.levelthreshold,"!"),"officer", nil,"OFFICER")
    end
end