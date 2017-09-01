-- Author      : Robert
-- Create Date : 9/1/2017 3:52:22 PM

--*ANNOUNCEMENTS*--
function GuildManager:RunAnnouncemnts()
    if AnnouncementsActivated~=1 and ValidMessages~=1 then--Announcements
        GuildManager:AnnouncementsActivate()
    else
        GuildManager:NextAnnouncementValid()
    end
end
--Load & Reload Functions--
function GuildManager:AnnouncementsActivate()
    GuildManager:AnnouncementsFindValid()
    if (GuildManager.db.profile.lastannounced==0 or GuildManager.db.profile.announcenext==0) and ValidMessages==1 then
        GuildManager:DetermineNextAnnouncement()
        GuildManager:AnnouncementsActivate()
    elseif (GuildManager.db.profile.lastannounced==0 or GuildManager.db.profile.announcenext==0) and ValidMessages==0 then
        AnnouncementsActivated=0
    else
    end
    if GuildManager.db.profile.lastannounced~=0 and GuildManager.db.profile.announcenext~=0 and ValidMessages==1 then
        AnnouncementsActivated=1
        GuildManager:NextAnnouncementValid()
    else
        AnnouncementsActivated=0
    end
end

function GuildManager:NextAnnouncementValid()
    if GuildManager.db.profile.announcenext==1 then
        if GuildManager.db.profile.announcement1~="" and (GuildManager.db.profile.announcementto1==2 or GuildManager.db.profile.announcementto1==3) then
            GuildManager.db.profile.nextannouncemessage=GuildManager.db.profile.announcement1
            GuildManager.db.profile.nextannouncetime=GuildManager.db.profile.announcementtimer1
            GuildManager.db.profile.nextannouncechannel=GuildManager.db.profile.announcementto1
            GuildManager.db.profile.nextannounceborder=GuildManager.db.profile.announcementborder1
            GuildManager:CheckTimeAnnouncement()
        else
            GuildManager:AnnouncementsFindValid()
            if ValidMessages==1 then
                GuildManager:DetermineNextAnnouncement()
            else
                AnnouncementsActivated=0
            end
        end
    end
    if GuildManager.db.profile.announcenext==2 then
        if GuildManager.db.profile.announcement2~="" and (GuildManager.db.profile.announcementto2==2 or GuildManager.db.profile.announcementto2==3) then
            GuildManager.db.profile.nextannouncemessage=GuildManager.db.profile.announcement2
            GuildManager.db.profile.nextannouncetime=GuildManager.db.profile.announcementtimer2
            GuildManager.db.profile.nextannouncechannel=GuildManager.db.profile.announcementto2
            GuildManager.db.profile.nextannounceborder=GuildManager.db.profile.announcementborder2
            GuildManager:CheckTimeAnnouncement()
        else
            GuildManager:AnnouncementsFindValid()
            if ValidMessages==1 then
                GuildManager:DetermineNextAnnouncement()
            else
                AnnouncementsActivated=0
            end
        end
    end
    if GuildManager.db.profile.announcenext==3 then
        if GuildManager.db.profile.announcement3~="" and (GuildManager.db.profile.announcementto3==2 or GuildManager.db.profile.announcementto3==3) then
            GuildManager.db.profile.nextannouncemessage=GuildManager.db.profile.announcement3
            GuildManager.db.profile.nextannouncetime=GuildManager.db.profile.announcementtimer3
            GuildManager.db.profile.nextannouncechannel=GuildManager.db.profile.announcementto3
            GuildManager.db.profile.nextannounceborder=GuildManager.db.profile.announcementborder3
            GuildManager:CheckTimeAnnouncement()
        else
            GuildManager:AnnouncementsFindValid()
            if ValidMessages==1 then
                GuildManager:DetermineNextAnnouncement()
            else
                AnnouncementsActivated=0
            end
        end
    end
    if GuildManager.db.profile.announcenext==4 then
        if GuildManager.db.profile.announcement4~="" and (GuildManager.db.profile.announcementto4==2 or GuildManager.db.profile.announcementto4==3) then
            GuildManager.db.profile.nextannouncemessage=GuildManager.db.profile.announcement4
            GuildManager.db.profile.nextannouncetime=GuildManager.db.profile.announcementtimer4
            GuildManager.db.profile.nextannouncechannel=GuildManager.db.profile.announcementto4
            GuildManager.db.profile.nextannounceborder=GuildManager.db.profile.announcementborder4
            GuildManager:CheckTimeAnnouncement()
        else
            GuildManager:AnnouncementsFindValid()
            if ValidMessages==1 then
                GuildManager:DetermineNextAnnouncement()
            else
                AnnouncementsActivated=0
            end
        end
    end
    if GuildManager.db.profile.announcenext==5 then
        if GuildManager.db.profile.announcement5~="" and (GuildManager.db.profile.announcementto5==2 or GuildManager.db.profile.announcementto5==3) then
            GuildManager.db.profile.nextannouncemessage=GuildManager.db.profile.announcement5
            GuildManager.db.profile.nextannouncetime=GuildManager.db.profile.announcementtimer5
            GuildManager.db.profile.nextannouncechannel=GuildManager.db.profile.announcementto5
            GuildManager.db.profile.nextannounceborder=GuildManager.db.profile.announcementborder5
            GuildManager:CheckTimeAnnouncement()
        else
            GuildManager:AnnouncementsFindValid()
            if ValidMessages==1 then
                GuildManager:DetermineNextAnnouncement()
            else
                AnnouncementsActivated=0
            end
        end
    end
end

function GuildManager:AnnouncementsFindValid()
    if GuildManager.db.profile.announcement1~="" and (GuildManager.db.profile.announcementto1==2 or GuildManager.db.profile.announcementto1==3) then
        Announcement1Valid=1
    else
        Announcement1Valid=0
    end
    if GuildManager.db.profile.announcement2~="" and (GuildManager.db.profile.announcementto2==2 or GuildManager.db.profile.announcementto2==3) then
        Announcement2Valid=1
    else
        Announcement2Valid=0
    end
    if GuildManager.db.profile.announcement3~="" and (GuildManager.db.profile.announcementto3==2 or GuildManager.db.profile.announcementto3==3) then
        Announcement3Valid=1
    else
        Announcement3Valid=0
    end
    if GuildManager.db.profile.announcement4~="" and (GuildManager.db.profile.announcementto4==2 or GuildManager.db.profile.announcementto4==3) then
        Announcement4Valid=1
    else
        Announcement4Valid=0
    end
    if GuildManager.db.profile.announcement5~="" and (GuildManager.db.profile.announcementto5==2 or GuildManager.db.profile.announcementto5==3) then
        Announcement5Valid=1
    else
        Announcement5Valid=0
    end
    if Announcement1Valid==0 and Announcement2Valid==0 and Announcement3Valid==0 and Announcement4Valid==0 and Announcement5Valid==0 then
        ValidMessages=0
    else
        ValidMessages=1
    end
end

function GuildManager:DetermineNextAnnouncement()
    reachedendofcheck=0
    GuildManager:AnnouncementsFindValid()
    if GuildManager.db.profile.lastannounced==5 and Announcement1Valid==1 then
        GuildManager.db.profile.announcenext=1
        GuildManager.db.profile.nextannouncemessage=GuildManager.db.profile.announcement1
        GuildManager.db.profile.nextannouncetime=GuildManager.db.profile.announcementtimer1
        GuildManager.db.profile.nextannouncechannel=GuildManager.db.profile.announcementto1
        GuildManager.db.profile.nextannounceborder=GuildManager.db.profile.announcementborder1
    elseif GuildManager.db.profile.lastannounced==5 and Announcement1Valid==0 then
        GuildManager.db.profile.lastannounced=1
    end
    if GuildManager.db.profile.lastannounced==1 and Announcement2Valid==1 then
        GuildManager.db.profile.announcenext=2
        GuildManager.db.profile.nextannouncemessage=GuildManager.db.profile.announcement2
        GuildManager.db.profile.nextannouncetime=GuildManager.db.profile.announcementtimer2
        GuildManager.db.profile.nextannouncechannel=GuildManager.db.profile.announcementto2
        GuildManager.db.profile.nextannounceborder=GuildManager.db.profile.announcementborder2
    elseif GuildManager.db.profile.lastannounced==1 and Announcement2Valid==0 then
        GuildManager.db.profile.lastannounced=2
    end
    if GuildManager.db.profile.lastannounced==2 and Announcement3Valid==1 then
        GuildManager.db.profile.announcenext=3
        GuildManager.db.profile.nextannouncemessage=GuildManager.db.profile.announcement3
        GuildManager.db.profile.nextannouncetime=GuildManager.db.profile.announcementtimer3
        GuildManager.db.profile.nextannouncechannel=GuildManager.db.profile.announcementto3
        GuildManager.db.profile.nextannounceborder=GuildManager.db.profile.announcementborder3
    elseif GuildManager.db.profile.lastannounced==2 and Announcement3Valid==0 then
        GuildManager.db.profile.lastannounced=3
    end
    if GuildManager.db.profile.lastannounced==3 and Announcement4Valid==1 then
        GuildManager.db.profile.announcenext=4
        GuildManager.db.profile.nextannouncemessage=GuildManager.db.profile.announcement4
        GuildManager.db.profile.nextannouncetime=GuildManager.db.profile.announcementtimer4
        GuildManager.db.profile.nextannouncechannel=GuildManager.db.profile.announcementto4
        GuildManager.db.profile.nextannounceborder=GuildManager.db.profile.announcementborder4
    elseif GuildManager.db.profile.lastannounced==3 and Announcement4Valid==0 then
        GuildManager.db.profile.lastannounced=4
    end
    if GuildManager.db.profile.lastannounced==4 and Announcement5Valid==1 then
        GuildManager.db.profile.announcenext=5
        GuildManager.db.profile.nextannouncemessage=GuildManager.db.profile.announcement5
        GuildManager.db.profile.nextannouncetime=GuildManager.db.profile.announcementtimer5
        GuildManager.db.profile.nextannouncechannel=GuildManager.db.profile.announcementto5
        GuildManager.db.profile.nextannounceborder=GuildManager.db.profile.announcementborder5
    elseif GuildManager.db.profile.lastannounced==4 and Announcement5Valid==0 then
        GuildManager.db.profile.lastannounced=5
        reachedendofcheck=1
        if GuildManager.db.profile.lastannounced==5 and reachedendofcheck==1 and ValidMessages==1 then
            GuildManager:DetermineNextAnnouncement()
        end
    end
end

--Timer Functions--
function GuildManager:CheckTimeAnnouncement()
    if GuildManager.db.profile.lastanntime==nil then
        GuildManager.db.profile.lastanntime=0
    end
    lastanndiff=GuildManager:GetTime()-GuildManager.db.profile.lastanntime
    if lastanndiff>=GuildManager.db.profile.nextannouncetime then
        GuildManager:ExecuteAnnouncement()
    elseif lastanndiff<GuildManager.db.profile.nextannouncetime then
    end
end

--Format Functions--
function GuildManager:PrintBorder()
    if GuildManager.db.profile.nextannouncechannel==2 then
        borderchannel="officer"
        bordertarget="OFFICER"
    elseif GuildManager.db.profile.nextannouncechannel==3 then
        borderchannel="guild"
        bordertarget="GUILD"
    end
    if GuildManager.db.profile.nextannouncechannel==2 or GuildManager.db.profile.nextannouncechannel==3 then
        if GuildManager.db.profile.nextannounceborder==2 then
            SendChatMessage("{Star}{Star}{Star}{Star}{Star}{Star}{Star}{Star}{Star}{Star}{Star}{Star}{Star}{Star}{Star}{Star}{Star}{Star}{Star}{Star}",borderchannel, nil,bordertarget)
        end
        if GuildManager.db.profile.nextannounceborder==3 then
            SendChatMessage("{Circle}{Circle}{Circle}{Circle}{Circle}{Circle}{Circle}{Circle}{Circle}{Circle}{Circle}{Circle}{Circle}{Circle}{Circle}{Circle}{Circle}{Circle}{Circle}{Circle}",borderchannel, nil,bordertarget)
        end
        if GuildManager.db.profile.nextannounceborder==4 then
            SendChatMessage("{Diamond}{Diamond}{Diamond}{Diamond}{Diamond}{Diamond}{Diamond}{Diamond}{Diamond}{Diamond}{Diamond}{Diamond}{Diamond}{Diamond}{Diamond}{Diamond}{Diamond}{Diamond}{Diamond}{Diamond}",borderchannel, nil,bordertarget)
        end
        if GuildManager.db.profile.nextannounceborder==5 then
            SendChatMessage("{Triangle}{Triangle}{Triangle}{Triangle}{Triangle}{Triangle}{Triangle}{Triangle}{Triangle}{Triangle}{Triangle}{Triangle}{Triangle}{Triangle}{Triangle}{Triangle}{Triangle}{Triangle}{Triangle}{Triangle}",borderchannel, nil,bordertarget)
        end
        if GuildManager.db.profile.nextannounceborder==6 then
            SendChatMessage("{Moon}{Moon}{Moon}{Moon}{Moon}{Moon}{Moon}{Moon}{Moon}{Moon}{Moon}{Moon}{Moon}{Moon}{Moon}{Moon}{Moon}{Moon}{Moon}{Moon}",borderchannel, nil,bordertarget)
        end
        if GuildManager.db.profile.nextannounceborder==7 then
            SendChatMessage("{Square}{Square}{Square}{Square}{Square}{Square}{Square}{Square}{Square}{Square}{Square}{Square}{Square}{Square}{Square}{Square}{Square}{Square}{Square}{Square}",borderchannel, nil,bordertarget)
        end
        if GuildManager.db.profile.nextannounceborder==8 then
            SendChatMessage("{X}{X}{X}{X}{X}{X}{X}{X}{X}{X}{X}{X}{X}{X}{X}{X}{X}{X}{X}{X}",borderchannel, nil,bordertarget)
        end
        if GuildManager.db.profile.nextannounceborder==9 then
            SendChatMessage("{Skull}{Skull}{Skull}{Skull}{Skull}{Skull}{Skull}{Skull}{Skull}{Skull}{Skull}{Skull}{Skull}{Skull}{Skull}{Skull}{Skull}{Skull}{Skull}{Skull}",borderchannel, nil,bordertarget)
        end
    end
end

function GuildManager:PrintAnnouncement()
    nextannvar=GuildManager.db.profile.nextannouncemessage
    if GuildManager.db.profile.nextannouncechannel==2 then
        annchannel="officer"
        anntarget="OFFICER"
    elseif GuildManager.db.profile.nextannouncechannel==3 then
        annchannel="guild"
        anntarget="GUILD"
    end
    local message, pattern, position;
    position = 1;
    for i = 1, #nextannvar, 255 do
        message = nextannvar:sub(position, position + 254);
        if #message < 255 then
            pattern = ".+";
        else
            pattern = "(.+)%s";
        end
        for capture in message:gmatch(pattern) do
            SendChatMessage(capture,annchannel, nil,anntarget)
            position = position + #capture + 1;
        end
    end
end

--Execution Functions--
function GuildManager:ExecuteAnnouncement()
    GuildManager:PrintBorder()
    GuildManager:PrintAnnouncement()
    GuildManager:PrintBorder()
    GuildManager:LoadNextAnnouncement()
end

function GuildManager:LoadNextAnnouncement()
    if announcementskip~=1 then
        GuildManager.db.profile.lastanntime=GuildManager:GetTime()
    end
    GuildManager.db.profile.lastannounced=GuildManager.db.profile.announcenext
    if GuildManager.db.profile.lastannounced==5 then
        nextinline=1
    else
        nextinline=GuildManager.db.profile.lastannounced+1
    end
    GuildManager.db.profile.announcenext=nextinline
    GuildManager:NextAnnouncementValid()
end
