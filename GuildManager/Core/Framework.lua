-- Author      : Robert
-- Create Date : 9/1/2017 12:23:32 PM

local function SetLayout(this)
  dewdrop:Close()
  if not t1 then
    t1 = this:CreateFontString(nil, "ARTWORK")
    t1:SetFontObject(GameFontNormalLarge)
    t1:SetJustifyH("LEFT") 
    t1:SetJustifyV("TOP")
    t1:SetPoint("TOPLEFT", 16, -16)
    t1:SetText(this.name)
	
    local t2 = this:CreateFontString(nil, "ARTWORK")
    t2:SetFontObject(GameFontHighlightSmall)
    t2:SetJustifyH("LEFT") 
    t2:SetJustifyV("TOP")
    t2:SetHeight(43)
    t2:SetPoint("TOPLEFT", t1, "BOTTOMLEFT", 0, -8)
    t2:SetPoint("RIGHT", this, "RIGHT", -32, 0)
    t2:SetNonSpaceWrap(true)
    local function GetInfo(field)
      return GetAddOnMetadata(this.addon, field) or "N/A"
    end
    t2:SetFormattedText("Notes: %s\nAuthor: %s\nVersion: %s\nRevision: %s", GetInfo("Notes"), GetInfo("Author"), GetInfo("Version"), GetInfo("X-Build"))

    local b = CreateFrame("Button", nil, this, "UIPanelButtonTemplate")
    b:SetWidth(120)
    b:SetHeight(20)
    b:SetText("Options Menu")
    b:SetScript("OnClick", GuildManager.DewOptions)
    b:SetPoint("TOPLEFT", t2, "BOTTOMLEFT", -2, -8)
  end
end

function GuildManager:DewOptions()
	dewdrop:Open('dummy', 'children', function() dewdrop:FeedAceOptionsTable(guildManagerOptions) end, 'cursorX', true, 'cursorY', true)
end

local function CreateUIOptionsFrame(addon) 
  local panel = CreateFrame("Frame")
  panel.name = GetAddOnMetadata(addon, "Title") or addon
  panel.addon = addon
  panel:SetScript("OnShow", SetLayout)
  InterfaceOptions_AddCategory(panel)
end

function GuildManager:ToggleActive(state)
	active = state
end

function GuildManager:tremovebyval(tab, val)
   for k,v in pairs(tab) do
     if(v==val) then
       table.remove(tab, k)
       return true
     end
   end
   return false
end

function GuildManager:Cleantables()
	GuildManager:Print("Cleaning guild manager tables...")
    uncleanGMIQt = GuildManager.db.profile.GMIQt
    cleanGMIQt = {}
    table.foreach(uncleanGMIQt,function(k,v)
        if string.match(v,"-") then
            table.insert(cleanGMIQt,v)
        else
            newv = strjoin("-",v,GetRealmName())
            table.insert(cleanGMIQt,newv)
        end
    end)
    GuildManager.db.profile.GMIQt = cleanGMIQt

    uncleanGMDNIt = GuildManager.db.profile.GMDNIt
    cleanGMDNIt = {}
    table.foreach(uncleanGMDNIt,function(k,v)
        if string.match(v,"-") then
            table.insert(cleanGMDNIt,v)
        else
            newv = strjoin("-",v,GetRealmName())
            table.insert(cleanGMDNIt,newv)
        end
    end)
    GuildManager.db.profile.GMDNIt = cleanGMDNIt

    uncleanGMBlackt = GuildManager.db.profile.GMBlackt
    cleanGMBlackt = {}
    table.foreach(uncleanGMBlackt,function(k,v)
        if string.match(v,"-") then
            table.insert(cleanGMBlackt,v)
        else
            newv = strjoin("-",v,GetRealmName())
            table.insert(cleanGMBlackt,newv)
        end
    end)
    GuildManager.db.profile.GMBlackt = cleanGMBlackt

    uncleanGMPruneExemptt = GuildManager.db.profile.GMPruneExemptt
    cleanGMPruneExemptt = {}
    table.foreach(uncleanGMPruneExemptt,function(k,v)
        if string.match(v,"-") then
            table.insert(cleanGMPruneExemptt,v)
        else
            newv = strjoin("-",v,GetRealmName())
            table.insert(cleanGMPruneExemptt,newv)
        end
    end)
    GuildManager.db.profile.GMPruneExemptt = cleanGMPruneExemptt

    uncleanGMDemoteExemptt = GuildManager.db.profile.GMDemoteExemptt
    cleanGMDemoteExemptt = {}
    table.foreach(uncleanGMDemoteExemptt,function(k,v)
        if string.match(v,"-") then
            table.insert(cleanGMDemoteExemptt,v)
        else
            newv = strjoin("-",v,GetRealmName())
            table.insert(cleanGMDemoteExemptt,newv)
        end
    end)
    GuildManager.db.profile.GMDemoteExemptt = cleanGMDemoteExemptt
end
