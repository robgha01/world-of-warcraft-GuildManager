-- Author      : Robert
-- Create Date : 9/1/2017 12:55:44 PM

--Options Interface--
guildManagerOptions = {
	handler = GuildManager,
    type = 'group',
    childGroups = "tab",
	args = {}
}

guildManagerOptions.name = function(info)
	return "Guild Manager 7.1.0 By: Yottabyte"
end

guildManagerOptions.args.gmheader = {
	type = 'header',
	name = function(info)
		if GuildManager:GetGuildName()~=nil then 
			return strjoin("","Settings for ",GuildManager.db:GetCurrentProfile())
		else 
			return "Guild Manager is disabled as you are not currently in a guild"
		end
	end,
	order = 1
}

--* Recruitment *--
guildManagerOptions.args.recruitment = {
	type = 'group',
	name = "Recruitment",
	desc = "Guild Recruitment Settings",
	disabled = function(info)
		if CanGuildInvite()~=true then
		  return true
		else
		  return false
		end
	end,
	order = 2,
	args = {}
}

--* Recruitment ZoneRecruitment *--
guildManagerOptions.args.recruitment.args.zonerecruitment = {
	type = 'group',
    name = "Zone Recruitment",
    desc = "Zone Recruitment Settings",
	disabled = function(info)
		if CanGuildInvite()~=true then 
			return true
		else
			return false
		end
    end,
	order = 1,
	args = {}
}

guildManagerOptions.args.recruitment.args.zonerecruitment.args.cityspam = {
	type = 'toggle',
    name = "CitySpam Enabled?",
    desc = "Should I spam in cities?",
    disabled = function(info)
    if CanGuildInvite()~=true then
			return true
		else
			return false
		end
    end,
	get = function(info)
		return GuildManager.db.profile.cityspam
    end,
	set = function(info, newValue)
		GuildManager.db.profile.cityspam = newValue
    end,
    order = 1,
}

guildManagerOptions.args.recruitment.args.zonerecruitment.args.zonespam = {
	type = 'toggle',
    name = "ZoneSpam Enabled?",
    desc = "Should I spam in regular zones?",
    disabled = function(info)
		if CanGuildInvite()~=true then
			return true
		else
			return false
		end
    end,
    get = function(info)
		return GuildManager.db.profile.zonespam
    end,
    set = function(info, newValue)
		GuildManager.db.profile.zonespam = newValue
    end,
    order = 2
}

guildManagerOptions.args.recruitment.args.zonerecruitment.args.outpvpspam = {
	type = 'toggle',
    name = "Outdoor PVP Zones Enabled?",
    desc = "Should I spam in outdoor pvp zones?",
    disabled = function(info)
		if CanGuildInvite()~=true then
			return true
		else
			return false
		end
    end,
    get = function(info)
		return GuildManager.db.profile.outpvpspam
    end,
    set = function(info, newValue)
		GuildManager.db.profile.outpvpspam = newValue
    end,
    order = 3
}

guildManagerOptions.args.recruitment.args.zonerecruitment.args.interval = {
	type = 'range',
    name = "Interval",
    desc = "The amount of minutes between spammings in a particular location",
    disabled = function(info)
		if CanGuildInvite()~=true then
			return true
		else
			return false
		end
    end,
    min = 15,
    max = 120,
    step = 1,
    get = function(info)
		return GuildManager.db.profile.between
    end,
    set = function(info, newValue)
		GuildManager.db.profile.between = newValue
    end,
    order = 4
}

guildManagerOptions.args.recruitment.args.zonerecruitment.args.lastspam = {
	type = 'execute',
    name = "Last time spammed in zone",
    desc = "Spit out to chat the last time someone in this guild has spammed in this zone",
    func = 	function(info)
		local currentzone
		if (GuildManager:IsCity()) then
			currentzone = "City"
		else
			currentzone = GetZoneText()
		end
		GuildManager:Print(string.format("The last time spammed in this zone was %s minutes ago", tostring(tonumber(GuildManager:GetTime()) - (tonumber(GuildManager.db.profile.lasttime[currentzone]) or 0))))
    end,
    order = 5
}

guildManagerOptions.args.recruitment.args.zonerecruitment.args.manspam = {
	type = 'execute',
    name = "Manual Spam",
    desc = "Spams current zone",
    disabled = function(info)
		if IsGuildLeader()~=true then
			return true
		else
			return false
		end
    end,
    func = 	function(info)
		if (GuildManager:IsCity()) then
			GuildManager:SpamZone("City")
		else
			GuildManager:SpamZone(GetZoneText())
		end
    end,
    order = 6
}

guildManagerOptions.args.recruitment.args.zonerecruitment.args.msg = {
	type = 'input',
    multiline = true,
    width = "full",
    name = "General Chat Message",
    desc = "The message text that will be broadcast in General/Trade",
    usage = "<Your message here>",
    disabled = function(info)
		if CanGuildInvite()~=true then
			return true
		else
			return false
		end
    end,
    get = function(info)
		return GuildManager.db.profile.message
    end,
    set = function(info, newValue)
		GuildManager.db.profile.message = newValue
    end,
    order = 7
}

guildManagerOptions.args.recruitment.args.zonerecruitment.args.citychannel = {
	type = 'range',
    name = "City Channel Number",
    desc = "Lets you choose which channel number you would like to recruit on while in a city. NOTE: By default 1 will use General, 2 will use Trade but it varies depending on how you set up your chat channels.",
    min = 1,
    max = 10,
    step = 1,
    disabled = function(info)
		if CanGuildInvite()~=true then
			return true
		else
			return false
		end
    end,
    get = function(info)
		return GuildManager.db.profile.citychannel
    end,
    set = function(info, newValue)
		GuildManager.db.profile.citychannel = newValue
    end,
    order = 8
}

guildManagerOptions.args.recruitment.args.zonerecruitment.args.zonechannel = {
	type = 'range',
    name = "Zone Channel Number",
    desc = "Lets you choose which channel number you would like to recruit on while in a general zone. NOTE: By default 1 will use General, 3 will use Local Defense but it varies depending on how you set up your chat channels.",
    disabled = function(info)
		if CanGuildInvite()~=true then
			return true
		else
			return false
		end
    end,
    min = 1,
    max = 10,
    step = 1,
    get = function(info)
		return GuildManager.db.profile.zonechannel
    end,
    set = function(info, newValue)
		GuildManager.db.profile.zonechannel = newValue
    end,
    order = 9
}

--* Recruitment WhoRecruitment *--
guildManagerOptions.args.recruitment.args.whorecruitment = {
	type = 'group',
    childGroups = "tab",
    name = "Toon Recruitment",
    desc = "Character Recruitment Settings NOTE: You will need to create a macro or modify your macros by adding '/run GuildManager:InviteAction()' to each one. See documentation for details.",
    disabled = function(info)
		if CanGuildInvite()~=true then
			return true
		else
			return false
		end
    end,
    order = 2,
	args = {}
}

guildManagerOptions.args.recruitment.args.whorecruitment.args.runwho = {
	type = 'execute',
    name = "Run Who Search",
    desc = "Begins searching for players. Character Recruitment uses the UI. UI elements such as the Mail Box, The Map, Character Stats, Achievments, etc. will close during the course of a cycle. It is recomended that you run this cycle if you plan to be AFK or doing something that doesnt require the UI as much. Raiding, Questing, etc.",
    confirm = true,
    func = 	function(info)
		GuildManager:RunWhoSearch()
    end,
    order = 1,
    disabled = function(info)
		if GuildManager.db.profile.automatewho==true or IsGuildLeader()~=true then
			return true
		else
			return false
		end
    end
}

guildManagerOptions.args.recruitment.args.whorecruitment.args.automatewho = {
	type = 'toggle',
    name = "Automate",
    desc = "Search for players automatically & continuously.",
    disabled = function(info)
		if CanGuildInvite()~=true then
			return true
		else
			return false
		end
    end,
    get = function(info)
		return GuildManager.db.profile.automatewho
    end,
    set = function(info, newValue)
		GuildManager.db.profile.automatewho = newValue
    end,
    order = 2
}

guildManagerOptions.args.recruitment.args.whorecruitment.args.iqcontrols = {
	type = 'execute',
    name = "Launch IQ Controls?",
    desc = "The Invite Queue is a list of ",
    disabled = function(info)
		if CanGuildInvite()~=true then
			return true
		else
			return false
		end
    end,
    func = function(info)
		GuildManager:IQUI()
    end,
    order = 3
}

guildManagerOptions.args.recruitment.args.whorecruitment.args.targetclass = {
	type = 'toggle',
    name = "Target Specific Classes",
    desc = "Target specific classes when searching for players. Otherwise will target all classes.",
    disabled = function(info)
		if GuildManager.db.profile.automatewho==true or CanGuildInvite()~=true then
			return true
		else
			return false
		end
    end,
    get = function(info)
		return GuildManager.db.profile.targetclass
    end,
    set = function(info, newValue)
		GuildManager.db.profile.targetclass = newValue
    end,
    order = 4
}

guildManagerOptions.args.recruitment.args.whorecruitment.args.whispmsg = {
	type = 'input',
    multiline = true,
    width = "full",
    name = "Whisper Message",
    desc = "The message text that will be sent to targeted players",
    usage = "<Your message here>",
    disabled = function(info)
		if GuildManager.db.profile.automatewho==true or CanGuildInvite()~=true then
			return true
		else
			return false
		end
    end,
    get = function(info)
		return GuildManager.db.profile.whispmessage
    end,
    set = function(info, newValue)
		GuildManager.db.profile.whispmessage = newValue
    end,
    order = 5
}

guildManagerOptions.args.recruitment.args.whorecruitment.args.minlevel = {
	type = 'range',
    name = "Minimum Level",
    desc = "The minimum level of people you are looking for (used when scanning Who Search results)",
    min = 20,
    max = 110,
    step = 1,
    disabled = function(info)
		if GuildManager.db.profile.automatewho==true or CanGuildInvite()~=true then
			return true
		else
			return false
		end
    end,
    get = function(info)
		return GuildManager.db.profile.minlevel
    end,
    set = function(info, newValue)
		if newValue > GuildManager.db.profile.maxlevel then
			GuildManager:Print("Cannot set a minimum level higher than the maximum")
			return
    end
    GuildManager.db.profile.minlevel = newValue
    end,
    order = 6
}

guildManagerOptions.args.recruitment.args.whorecruitment.args.maxlevel = {
	type = 'range',
    name = "Maximum Level",
    desc = "The maximum level of people you are looking for (used when scanning Who Search Results)",
    min = 20,
    max = 110,
    step = 1,
    disabled = function(info)
		if GuildManager.db.profile.automatewho==true or CanGuildInvite()~=true then
			return true
		else
			return false
		end
    end,
    get = function(info)
		return GuildManager.db.profile.maxlevel
    end,
    set = function(info, newValue)
		if newValue < GuildManager.db.profile.minlevel then
		GuildManager:Print("Cannot set a maximum level lower than the minimum")
		return
    end
    GuildManager.db.profile.maxlevel = newValue
    end,
    order = 7
}

guildManagerOptions.args.recruitment.args.whorecruitment.args.classsettings = {
	type = 'group',
    name = "Class List",
    desc = "Select the classes you wish to target",
    disabled = function(info)
		if GuildManager.db.profile.automatewho==true or CanGuildInvite()~=true then
			return true
		else
			return false
		end
    end,
    order = 8,
    disabled = function(info)
		if GuildManager.db.profile.targetclass then return false end
		return true
    end,
	args = {}
}

	guildManagerOptions.args.recruitment.args.whorecruitment.args.classsettings.args.DKsearch = {
		type = 'toggle',
        name = "Death Knight",
        desc = "Recruit Death Knights?",
        disabled = function(info)
			if GuildManager.db.profile.automatewho==true or CanGuildInvite()~=true then
				return true
			else
				return false
			end
        end,
        get = function(info)
			return GuildManager.db.profile.DKsearch
        end,
        set = function(info, newValue)
			GuildManager.db.profile.DKsearch = newValue
        end,
        order = 1
	}
	
	guildManagerOptions.args.recruitment.args.whorecruitment.args.classsettings.args.DHsearch = {
		type = 'toggle',
        name = "Demon Hunter",
        desc = "Recruit Demon Hunters?",
        disabled = function(info)
			if GuildManager.db.profile.automatewho==true or CanGuildInvite()~=true then
				return true
			else
				return false
			end
        end,
        get = function(info)
			return GuildManager.db.profile.DHsearch
        end,
        set = function(info, newValue)
			GuildManager.db.profile.DHsearch = newValue
        end,
        order = 1
	}
	
	guildManagerOptions.args.recruitment.args.whorecruitment.args.classsettings.args.Druidsearch = {
		type = 'toggle',
        name = "Druid",
        desc = "Recruit Druids?",
        disabled = function(info)
			if GuildManager.db.profile.automatewho==true or CanGuildInvite()~=true then
				return true
			else
				return false
			end
        end,
        get = function(info)
			return GuildManager.db.profile.Druidsearch
        end,
        set = function(info, newValue)
			GuildManager.db.profile.Druidsearch = newValue
        end,
        order = 1
	}
	
	guildManagerOptions.args.recruitment.args.whorecruitment.args.classsettings.args.Huntersearch = {
		type = 'toggle',
        name = "Hunters",
        desc = "Recruit Hunters?",
        disabled = function(info)
			if GuildManager.db.profile.automatewho==true or CanGuildInvite()~=true then
				return true
			else
				return false
			end
        end,
        get = function(info)
			return GuildManager.db.profile.Huntersearch
        end,
        set = function(info, newValue)
			GuildManager.db.profile.Huntersearch = newValue
        end,
        order = 1
	}
	
	guildManagerOptions.args.recruitment.args.whorecruitment.args.classsettings.args.Magesearch = {
		type = 'toggle',
        name = "Mage",
        desc = "Recruit Mages?",
        disabled = function(info)
			if GuildManager.db.profile.automatewho==true or CanGuildInvite()~=true then
				return true
			else
				return false
			end
        end,
        get = function(info)
			return GuildManager.db.profile.Magesearch
        end,
        set = function(info, newValue)
			GuildManager.db.profile.Magesearch = newValue
        end,
        order = 1
	}
	
	guildManagerOptions.args.recruitment.args.whorecruitment.args.classsettings.args.Monksearch = {
		type = 'toggle',
        name = "Monk",
        desc = "Recruit Monks?",
        disabled = function(info)
			if GuildManager.db.profile.automatewho==true or CanGuildInvite()~=true then
				return true
			else
				return false
			end
        end,
        get = function(info)
			return GuildManager.db.profile.Monksearch
        end,
        set = function(info, newValue)
			GuildManager.db.profile.Monksearch = newValue
        end,
        order = 1
	}
	
	guildManagerOptions.args.recruitment.args.whorecruitment.args.classsettings.args.Paladinsearch = {
		type = 'toggle',
        name = "Paladin",
        desc = "Recruit Paladins?",
        disabled = function(info)
			if GuildManager.db.profile.automatewho==true or CanGuildInvite()~=true then
				return true
			else
				return false
			end
        end,
        get = function(info)
			return GuildManager.db.profile.Paladinsearch
        end,
        set = function(info, newValue)
			GuildManager.db.profile.Paladinsearch = newValue
        end,
        order = 1
	}
	
	guildManagerOptions.args.recruitment.args.whorecruitment.args.classsettings.args.Priestsearch = {
		type = 'toggle',
        name = "Priest",
        desc = "Recruit Priests?",
        disabled = function(info)
			if GuildManager.db.profile.automatewho==true or CanGuildInvite()~=true then
				return true
			else
				return false
			end
        end,
        get = function(info)
			return GuildManager.db.profile.Priestsearch
        end,
        set = function(info, newValue)
			GuildManager.db.profile.Priestsearch = newValue
        end,
        order = 1
	}
	
	guildManagerOptions.args.recruitment.args.whorecruitment.args.classsettings.args.Roguesearch = {
		type = 'toggle',
        name = "Rogue",
        desc = "Recruit Rogues?",
        disabled = function(info)
			if GuildManager.db.profile.automatewho==true or CanGuildInvite()~=true then
				return true
			else
				return false
			end
        end,
        get = function(info)
			return GuildManager.db.profile.Roguesearch
        end,
        set = function(info, newValue)
			GuildManager.db.profile.Roguesearch = newValue
        end,
        order = 1
	}
	
	guildManagerOptions.args.recruitment.args.whorecruitment.args.classsettings.args.Shamansearch = {
		type = 'toggle',
        name = "Shaman",
        desc = "Recruit Shamans?",
        disabled = function(info)
			if GuildManager.db.profile.automatewho==true or CanGuildInvite()~=true then
				return true
			else
				return false
			end
        end,
        get = function(info)
			return GuildManager.db.profile.Shamansearch
        end,
        set = function(info, newValue)
			GuildManager.db.profile.Shamansearch = newValue
        end,
        order = 1
	}
	
	guildManagerOptions.args.recruitment.args.whorecruitment.args.classsettings.args.Warlocksearch = {
		type = 'toggle',
        name = "Warlock",
        desc = "Recruit Warlocks?",
        disabled = function(info)
			if GuildManager.db.profile.automatewho==true or CanGuildInvite()~=true then
				return true
			else
				return false
			end
        end,
        get = function(info)
			return GuildManager.db.profile.Warlocksearch
        end,
        set = function(info, newValue)
			GuildManager.db.profile.Warlocksearch = newValue
        end,
        order = 1
	}
	
	guildManagerOptions.args.recruitment.args.whorecruitment.args.classsettings.args.Warriorsearch = {
		type = 'toggle',
        name = "Warrior",
        desc = "Recruit Warriors?",
        disabled = function(info)
			if GuildManager.db.profile.automatewho==true or CanGuildInvite()~=true then
				return true
			else
				return false
			end
        end,
        get = function(info)
			return GuildManager.db.profile.Warriorsearch
        end,
        set = function(info, newValue)
			GuildManager.db.profile.Warriorsearch = newValue
        end,
        order = 1
	}

--* Recruitment InviteControls *--
guildManagerOptions.args.recruitment.args.invitecontrols = {
	type = 'group',
    childGroups = "tab",
    name = "Invitation Control",
    desc = "Do Not Invite List (Antispam Measure) and Member Cap Settings.",
    order = 3,
	args = {}
}

guildManagerOptions.args.recruitment.args.invitecontrols.args.dnilcontrols = {
	type = 'execute',
    name = "Launch DNIL Controls?",
    desc = "WARNING: Over time the Do Not Invite List will get huge. If you MUST modify or purge the list be prepared for your UI to freeze for 30-60 seconds while the controls load.",
    confirm = true,
    func = 	function(info)
		GuildManager:DNIUI()
    end,
    order = 1
}

guildManagerOptions.args.recruitment.args.invitecontrols.args.membercap = {
	type = 'range',
    width = "normal",
    name = "Member Maximum",
    desc = "Will stop recruiting if the guild population is at or above a certain threshold. If undefined it will assume 1000.",
    disabled = function(info)
		if CanGuildInvite()~=true then
			return true
		else
			return false
		end
    end,
    min = 1,
    max = 1000,
    step = 1,
    get = function(info)
		return GuildManager.db.profile.membercap
    end,
    set = function(info, newValue)
		GuildManager.db.profile.membercap = newValue
    end,
    order = 2
}

guildManagerOptions.args.recruitment.args.invitecontrols.args.whohalt = {
	type = 'execute',
    name = "Stop!",
    desc = "Emergency button that halts a Character Recruitment Cycle",
    func = 	function(info)
		if WhoCycle==1 then
			GuildManager:Print('Halting Character Recruitment Cycle')
			WhoHalt=1
			if GuildManager.db.profile.automatewho==true then
				GuildManager.db.profile.automatewho=false
				GuildManager:Print('Disabling Character Recruitment Automation')
			end
			else
				GuildManager:Print('Character Recruitment Cycle is NOT currently running')
		end
    end,
    order = 3
}

guildManagerOptions.args.recruitment.args.invitecontrols.args.welcomeannounce = {
	type = "select",
    order = 4,
    name = "Announce New Members",
    desc = "Choose to announce when a member is added to the guild",
    disabled = function(info)
		if CanGuildInvite()~=true then
			return true
		else
			return false
		end
    end,
    values = {"None","Officer","Guild"},
    get = function(info)
		return GuildManager.db.profile.welcomeannounce
    end,
    set = function(info, newValue)
		GuildManager.db.profile.welcomeannounce = newValue
    end
}

guildManagerOptions.args.recruitment.args.invitecontrols.args.welcomewhisp = {
	type = 'input',
    multiline = true,
    width = "full",
    name = "Guild Welcome Whisper",
    desc = "The message text that will be sent to the new guild member. If you don't want to send a whisper, leave blank.",
    usage = "<Your message here>",
    disabled = function(info)
		if CanGuildInvite()~=true then
			return true
		else
			return false
		end
    end,
    get = function(info)
		return GuildManager.db.profile.welcomewhisp
    end,
    set = function(info, newValue)
		GuildManager.db.profile.welcomewhisp = newValue
    end,
    order = 5
}

guildManagerOptions.args.recruitment.args.invitecontrols.args.declinewhisp = {
	type = 'input',
    multiline = true,
    width = "full",
    name = "Guild Invite Decline Whisper",
    desc = "The message text that will be sent to someone who declines your guild invitation. If you don't want to send a whisper, leave blank.",
    usage = "<Your message here>",
    disabled = function(info)
		if CanGuildInvite()~=true then
			return true
		else
			return false
		end
    end,
    get = function(info)
		return GuildManager.db.profile.declinewhisp
    end,
    set = function(info, newValue)
		GuildManager.db.profile.declinewhisp = newValue
    end,
    order = 6
}

guildManagerOptions.args.recruitment.args.invitecontrols.args.whisperinvite = {
	type = 'toggle',
	name = "Invite on Whisper",
	desc = 'Will Invite players to your guild who say "LF Guild" in a whisper message. (whisper is not case-sensetive) WARNING: Cannot be used with Whisper Only! NOTE: Be sure to include this in your Zone Message, Recruitment Message, and/or AFK/DND message so that applicants know what to say! Will NOT invite players on the Black List!',
	disabled = function(info)
		if CanGuildInvite()~=true or GuildManager.db.profile.whisperonly then
			return true
		else
			return false
		end
	end,
	get = function(info)
		return GuildManager.db.profile.whisperinvite
	end,
	set = function(info, newValue)
		GuildManager.db.profile.whisperinvite = newValue
	end,
	order = 7,
}

guildManagerOptions.args.recruitment.args.invitecontrols.args.whisperonly = {
    type = 'toggle',
    name = "Whisper Only",
    desc = 'This will cause only a whisper to go out instead of a whisper and a guild invite. WARNING: Cannot be used with Invite on Whisper! NOTE: There is an issue where guilded members show up in the Who list as not guilded. Using this feature will result in guilded players getting your invite message.',
    disabled = function(info)
		if CanGuildInvite()~=true or GuildManager.db.profile.whisperinvite then
			return true
		else
			return false
		end
    end,
    get = function(info)
		return GuildManager.db.profile.whisperonly
    end,
    set = function(info, newValue)
		GuildManager.db.profile.whisperonly = newValue
    end,
    order = 8,
}

--* Pruning *--
guildManagerOptions.args.pruning = {
	type = 'group',
    childGroups = "tab",
    name = "Pruning",
    desc = "Guild Pruning Settings",
    order = 3,
	args = {}
}

--* Pruning Manually *--
guildManagerOptions.args.pruning.args.manprune = {
	type = 'execute',
    name = "Prune",
    desc = "Manually remove players from your guild",
    func = 	function(info)
		GuildManager:GKRun()
    end,
    order = 1,
    disabled = function(info)
		if GuildManager.db.profile.automateprune then return true end
		return false
    end
}

--* Pruning Inactivity *--
guildManagerOptions.args.pruning.args.removeinactive = {
	type = 'toggle',
    name = "Remove Inactive",
    desc = "Remove members based on inactivity",
    get = function(info)
		return GuildManager.db.profile.removeinactive
    end,
    set = function(info, newValue)
		GuildManager.db.profile.removeinactive = newValue
    end,
    order = 2
}

--* Pruning Low Levels *--
guildManagerOptions.args.pruning.args.removelevels = {
	type = 'toggle',
    name = "Remove Low Levels",
    desc = "Remove Low Level Members",
    get = function(info)
		return GuildManager.db.profile.removelevels
    end,
    set = function(info, newValue)
		GuildManager.db.profile.removelevels = newValue
    end,
    order = 3
}

--* Pruning Automate *--
guildManagerOptions.args.pruning.args.automateprune = {
	type = 'toggle',
    name = "Automate",
    desc = "Prune members automatically & continuously",
    get = function(info)
		return GuildManager.db.profile.automateprune
    end,
    set = function(info, newValue)
		GuildManager.db.profile.automateprune = newValue
    end,
    order = 4
}

--* Pruning Days Offline *--
guildManagerOptions.args.pruning.args.daysinactive = {
	type = 'range',
    width = "normal",
    name = "Days Offline",
    desc = "Inactivity Threshold",
    min = 1,
    max = 365,
    step = 1,
    disabled = function(info)
		if GuildManager.db.profile.removeinactive then return false end
		return true
    end,
    get = function(info)
		return GuildManager.db.profile.daysinactive
    end,
    set = function(info, newValue)
		GuildManager.db.profile.daysinactive = newValue
    end,
    order = 5
}

--* Pruning Low Level Threshhold *--
guildManagerOptions.args.pruning.args.levelthreshold = {
	type = 'range',
    width = "normal",
    name = "Low Level",
    desc = "Low Level Threshhold. Members at or below this level will be removed.",
    min = 1,
    max = 110,
    step = 1,
    disabled = function(info)
		if GuildManager.db.profile.removelevels then return false end
		return true
    end,
    get = function(info)
		return GuildManager.db.profile.levelthreshold
    end,
    set = function(info, newValue)
		GuildManager.db.profile.levelthreshold = newValue
    end,
    order = 6
}

--* Pruning Announce Prunes *--
guildManagerOptions.args.pruning.args.pruneannounce = {
	type = "select",
    order = 7,
    name = "Announce Prunes",
    desc = "Choose to announce why members were removed from the guild.",
    values = {"None","Officer","Guild"},
    get = function(info)
		return GuildManager.db.profile.pruneannounce
    end,
    set = function(info, newValue)
		GuildManager.db.profile.pruneannounce = newValue
    end
}

--* Pruning Launch Black List Controls? *--
guildManagerOptions.args.pruning.args.pruneannounce = {
	type = 'execute',
    name = "Launch Black List Controls?",
    desc = "WARNING: Over time the Black List can get huge. If you MUST modify or purge the list be prepared for your UI to freeze for 30-60 seconds while the controls load.",
    confirm = true,
    func = 	function(info)
		GuildManager:BlackUI()
    end,
    order = 8
}

--* Pruning Launch Prune Exempt Controls? *--
guildManagerOptions.args.pruning.args.pruneexemptcontrols = {
	type = 'execute',
    name = "Launch Prune Exempt Controls?",
    desc = "WARNING: Over time the Prune Exemption List can get huge. If you MUST modify or purge the list be prepared for your UI to freeze for 30-60 seconds while the controls load.",
    confirm = true,
    func = 	function(info)
		GuildManager:PruneExemptUI()
    end,
    order = 9
}

--* Pruning Alts Exempt *--
guildManagerOptions.args.pruning.args.exemptalt = {
	type = 'toggle',
    name = "Alts Exempt",
    desc = "Exempts Alts from pruning. MUST HAVE THE WORD 'ALT' in either their public or private note!",
    get = function(info)
		return GuildManager.db.profile.exemptalt
    end,
    set = function(info, newValue)
		GuildManager.db.profile.exemptalt = newValue
    end,
    order = 10
}

--* Pruning Exempt Ranks *--
guildManagerOptions.args.pruning.args.exemptranks = {
	type = 'toggle',
    name = "Exempt Ranks",
    desc = "Exempts selected Ranks from pruning",
    get = function(info)
		return GuildManager.db.profile.exemptranks
    end,
    set = function(info, newValue)
		GuildManager.db.profile.exemptranks = newValue
    end,
    order = 11
}

--* Pruning Remove from DNIL *--
guildManagerOptions.args.pruning.args.removefromdnil = {
	type = 'toggle',
    name = "Remove from DNIL",
    desc = "Removes a kicked player from the Do Not Invite List so that they may be reinvited in future should they meet your recruitment criteria.",
    get = function(info)
		return GuildManager.db.profile.removefromdnil
    end,
    set = function(info, newValue)
		GuildManager.db.profile.removefromdnil = newValue
    end,
    order = 11
}

--* Pruning Ranktable *--
guildManagerOptions.args.pruning.args.ranktable = {
	type = 'group',
    childGroups = "tab",
    name = "Rank Exemption List",
    desc = "List of ranks exempt from pruning.",
    order = 12,
    disabled = function(info)
		if GuildManager.db.profile.exemptranks then return false end
		return true
    end,
	args = {}
}
	
	guildManagerOptions.args.pruning.args.ranktable.args.exemptrank1 = {
		type = 'toggle',
		name = function(info)
				if GuildControlGetRankName(2)==nil then return "Rank 2" end
				return GuildControlGetRankName(2)
				end,
		desc = "Exempt this rank from pruning?",
		hidden = function(info)
				if GuildControlGetNumRanks()<=1 then 
				GuildManager.db.profile.exemptrank1=false
				return true end
				return false
				end,
		get = function(info)
					return GuildManager.db.profile.exemptrank1
				end,
		set = function(info, newValue)
					GuildManager.db.profile.exemptrank1 = newValue
				end,
		order = 1,
	}

	guildManagerOptions.args.pruning.args.ranktable.args.exemptrank2 = {
		type = 'toggle',
		name = function(info)
				if GuildControlGetRankName(3)==nil then return "Rank 3" end
				return GuildControlGetRankName(3)
				end,
		desc = "Exempt this rank from pruning?",
		hidden = function(info)
				if GuildControlGetNumRanks()<=2 then 
				GuildManager.db.profile.exemptrank2=false
				return true end
				return false
				end,
		get = function(info)
					return GuildManager.db.profile.exemptrank2
				end,
		set = function(info, newValue)
					GuildManager.db.profile.exemptrank2 = newValue
				end,
		order = 2
	}

	guildManagerOptions.args.pruning.args.ranktable.args.exemptrank3 = {
		type = 'toggle',
		name = function(info)
				if GuildControlGetRankName(4)==nil then return "Rank 4" end
				return GuildControlGetRankName(4)
				end,
		desc = "Exempt this rank from pruning?",
		hidden = function(info)
				if GuildControlGetNumRanks()<=3 then 
				GuildManager.db.profile.exemptrank3=false
				return true end
				return false
				end,
		get = function(info)
					return GuildManager.db.profile.exemptrank3
				end,
		set = function(info, newValue)
					GuildManager.db.profile.exemptrank3 = newValue
				end,
		order = 3,
	}

	guildManagerOptions.args.pruning.args.ranktable.args.exemptrank4 = {
		type = 'toggle',
		name = function(info)
				if GuildControlGetRankName(5)==nil then return "Rank 5" end
				return GuildControlGetRankName(5)
				end,
		desc = "Exempt this rank from pruning?",
		hidden = function(info)
				if GuildControlGetNumRanks()<=4 then 
				GuildManager.db.profile.exemptrank4=false
				return true end
				return false
				end,
		get = function(info)
					return GuildManager.db.profile.exemptrank4
				end,
		set = function(info, newValue)
					GuildManager.db.profile.exemptrank4 = newValue
				end,
		order = 4,
	}

	guildManagerOptions.args.pruning.args.ranktable.args.exemptrank5 = {
		type = 'toggle',
		name = function(info)
				if GuildControlGetRankName(6)==nil then return "Rank 6" end
				return GuildControlGetRankName(6)
				end,
		desc = "Exempt this rank from pruning?",
		hidden = function(info)
				if GuildControlGetNumRanks()<=5 then 
				GuildManager.db.profile.exemptrank5=false
				return true end
				return false
				end,
		get = function(info)
					return GuildManager.db.profile.exemptrank5
				end,
		set = function(info, newValue)
					GuildManager.db.profile.exemptrank5 = newValue
				end,
		order = 5,
	}

	guildManagerOptions.args.pruning.args.ranktable.args.exemptrank6 = {
		type = 'toggle',
		name = function(info)
				if GuildControlGetRankName(7)==nil then return "Rank 7" end
				return GuildControlGetRankName(7)
				end,
		desc = "Exempt this rank from pruning?",
		hidden = function(info)
				if GuildControlGetNumRanks()<=6 then 
				GuildManager.db.profile.exemptrank6=false
				return true end
				return false
				end,
		get = function(info)
					return GuildManager.db.profile.exemptrank6
				end,
		set = function(info, newValue)
					GuildManager.db.profile.exemptrank6 = newValue
				end,
		order = 6
	}

	guildManagerOptions.args.pruning.args.ranktable.args.exemptrank7 = {
		type = 'toggle',
		name = function(info)
				if GuildControlGetRankName(8)==nil then return "Rank 8" end
				return GuildControlGetRankName(8)
				end,
		desc = "Exempt this rank from pruning?",
		hidden = function(info)
				if GuildControlGetNumRanks()<=7 then 
				GuildManager.db.profile.exemptrank7=false
				return true end
				return false
				end,
		get = function(info)
					return GuildManager.db.profile.exemptrank7
				end,
		set = function(info, newValue)
					GuildManager.db.profile.exemptrank7 = newValue
				end,
		order = 7
	}

	guildManagerOptions.args.pruning.args.ranktable.args.exemptrank8 = {
		type = 'toggle',
		name = function(info)
				if GuildControlGetRankName(9)==nil then return "Rank 9" end
				return GuildControlGetRankName(9)
				end,
		desc = "Exempt this rank from pruning?",
		hidden = function(info)
				if GuildControlGetNumRanks()<=8 then 
				GuildManager.db.profile.exemptrank8=false
				return true end
				return false
				end,
		get = function(info)
					return GuildManager.db.profile.exemptrank8
				end,
		set = function(info, newValue)
					GuildManager.db.profile.exemptrank8 = newValue
				end,
		order = 8
	}

	guildManagerOptions.args.pruning.args.ranktable.args.exemptrank9 = {
		type = 'toggle',
		name = function(info)
				if GuildControlGetRankName(10)==nil then return "Rank 10" end
					return GuildControlGetRankName(10)
				end,
		desc = "Exempt this rank from pruning?",
		hidden = function(info)
				if GuildControlGetNumRanks()<=9 then 
				GuildManager.db.profile.exemptrank9=false
				return true end
				return false
				end,
		get = function(info)
					return GuildManager.db.profile.exemptrank9
				end,
		set = function(info, newValue)
					GuildManager.db.profile.exemptrank9 = newValue
				end,
		order = 9
	}
	
--* Promotion *--
guildManagerOptions.args.promotion = {
	type = 'group',
	name = "Promotion",
	desc = "Guild Promotion Settings",
	order = 4,
	args = {}
}

--* Promotion Run Promotions *--
guildManagerOptions.args.promotion.args.manpromote = {
	type = 'execute',
	name = "Run Promotions",
	desc = "Manually runs the promoter WARNING: Whenever you move, add, or delete ranks be sure to update your promote settings! Not doing so may have unintended side effects!",
	order = 1,
	confirm = true,
	func = 	function(info) 
		GuildManager:GMPromoteErrorChecking()
	end,
	disabled = function(info)
		if GuildManager.db.profile.automatepromote then return true end
		return false
	end
}

--* Promotion Automate *--
guildManagerOptions.args.promotion.args.automatepromote = {
	type = 'toggle',
	name = "Automate",
	confirm = true,
	desc = "Will automatically and continously promote members who meet the specificed standards. WARNING: Whenever you move, add, or delete ranks be sure to update your promote settings! Not doing so may have unintended side effects!",
	get = function(info)
		return GuildManager.db.profile.automatepromote
	end,
	set = function(info, newValue)
		GuildManager.db.profile.automatepromote = newValue
	end,
	order = 2
}

--* Promotion Demote Mode *--
guildManagerOptions.args.promotion.args.demotemode = {
	type = 'toggle',
	name = "Demote Mode",
	desc = "Demotes members who no longer qualify for the rank they hold based on the below settings.",
	get = function(info)
		return GuildManager.db.profile.demotemode
	end,
	set = function(info, newValue)
		GuildManager.db.profile.demotemode = newValue
	end,
	order = 3
}

--* Promotion Announce Promotions/Demotions *--
guildManagerOptions.args.promotion.args.promoteannounce = {
	type = "select",
	order = 4,
	name = "Announce Promotions/Demotions",
	desc = "Choose to announce why members were promoted or demoted. Will also state how one can become promoted.",
	values = {"None","Officer","Guild"},
	get = function(info)
		return GuildManager.db.profile.promoteannounce
	end,
	set = function(info, newValue)
		GuildManager.db.profile.promoteannounce = newValue
	end
}

--* Promotion Rank Promote Search *--
guildManagerOptions.args.promotion.args.rankpromotesearch = {
	type = 'group',
	name = "Promote From Ranks",
	desc = "Ranks that Guild Promoter will look at when finding qualified candidates",
	order = 6,
	args = {}
}

	guildManagerOptions.args.promotion.args.rankpromotesearch.args.rank1promotesearch = {
		type = 'toggle',
		name = function(info)
		if GuildControlGetRankName(2)==nil then return "Rank 2" end
		return GuildControlGetRankName(2)
		end,
		desc = "Toggles this rank as a rank that promoter will promote FROM.",
		hidden = function(info)
			if GuildControlGetNumRanks()<=1 then 
				GuildManager.db.profile.rank1promotesearch=false
				return true end
			return false
		end,
		get = function(info)
			return GuildManager.db.profile.rank1promotesearch
		end,
		set = function(info, newValue)
			GuildManager.db.profile.rank1promotesearch = newValue
		end,
		order = 1
	}
	
	guildManagerOptions.args.promotion.args.rankpromotesearch.args.rank2promotesearch = {
		type = 'toggle',
		name = function(info)
			if GuildControlGetRankName(3)==nil then return "Rank 3" end
			return GuildControlGetRankName(3)
		end,
		desc = "Toggles this rank as a rank that promoter will promote FROM.",
		hidden = function(info)
			if GuildControlGetNumRanks()<=2 then 
				GuildManager.db.profile.rank2promotesearch=false
				return true end
			return false
		end,
		get = function(info)
			return GuildManager.db.profile.rank2promotesearch
		end,
		set = function(info, newValue)
			GuildManager.db.profile.rank2promotesearch = newValue
		end,
		order = 2
	}
	
	guildManagerOptions.args.promotion.args.rankpromotesearch.args.rank3promotesearch = {
		type = 'toggle',
		name = function(info)
			if GuildControlGetRankName(4)==nil then return "Rank 4" end
			return GuildControlGetRankName(4)
		end,
		desc = "Toggles this rank as a rank that promoter will promote FROM.",
		hidden = function(info)
			if GuildControlGetNumRanks()<=3 then 
				GuildManager.db.profile.rank3promotesearch=false
				return true end
			return false
		end,
		get = function(info)
			return GuildManager.db.profile.rank3promotesearch
		end,
		set = function(info, newValue)
			GuildManager.db.profile.rank3promotesearch = newValue
		end,
		order = 3
	}
	
	guildManagerOptions.args.promotion.args.rankpromotesearch.args.rank4promotesearch = {
		type = 'toggle',
		name = function(info)
			if GuildControlGetRankName(5)==nil then return "Rank 5" end
			return GuildControlGetRankName(5)
		end,
		desc = "Toggles this rank as a rank that promoter will promote FROM.",
		hidden = function(info)
			if GuildControlGetNumRanks()<=4 then 
				GuildManager.db.profile.rank4promotesearch=false
				return true end
			return false
		end,
		get = function(info)
			return GuildManager.db.profile.rank4promotesearch
		end,
		set = function(info, newValue)
			GuildManager.db.profile.rank4promotesearch = newValue
		end,
		order = 4
	}
	
	guildManagerOptions.args.promotion.args.rankpromotesearch.args.rank5promotesearch = {
		type = 'toggle',
		name = function(info)
			if GuildControlGetRankName(6)==nil then return "Rank 6" end
			return GuildControlGetRankName(6)
		end,
		desc = "Toggles this rank as a rank that promoter will promote FROM.",
		hidden = function(info)
			if GuildControlGetNumRanks()<=5 then 
				GuildManager.db.profile.rank5promotesearch=false
				return true end
			return false
		end,
		get = function(info)
			return GuildManager.db.profile.rank5promotesearch
		end,
		set = function(info, newValue)
			GuildManager.db.profile.rank5promotesearch = newValue
		end,
		order = 5
	}
	
	guildManagerOptions.args.promotion.args.rankpromotesearch.args.rank6promotesearch = {
		type = 'toggle',
		name = function(info)
			if GuildControlGetRankName(7)==nil then return "Rank 7" end
			return GuildControlGetRankName(7)
		end,
		desc = "Toggles this rank as a rank that promoter will promote FROM.",
		hidden = function(info)
			if GuildControlGetNumRanks()<=6 then 
				GuildManager.db.profile.rank6promotesearch=false
				return true end
			return false
		end,
		get = function(info)
			return GuildManager.db.profile.rank6promotesearch
		end,
		set = function(info, newValue)
			GuildManager.db.profile.rank6promotesearch = newValue
		end,
		order = 6
	}
	
	guildManagerOptions.args.promotion.args.rankpromotesearch.args.rank7promotesearch = {
		type = 'toggle',
		name = function(info)
			if GuildControlGetRankName(8)==nil then return "Rank 8" end
			return GuildControlGetRankName(8)
		end,
		desc = "Toggles this rank as a rank that promoter will promote FROM.",
		hidden = function(info)
			if GuildControlGetNumRanks()<=7 then 
				GuildManager.db.profile.rank7promotesearch=false
				return true end
			return false
		end,
		get = function(info)
			return GuildManager.db.profile.rank7promotesearch
		end,
		set = function(info, newValue)
			GuildManager.db.profile.rank7promotesearch = newValue
		end,
		order = 7
	}
	
	guildManagerOptions.args.promotion.args.rankpromotesearch.args.rank8promotesearch = {
		type = 'toggle',
		name = function(info)
			if GuildControlGetRankName(9)==nil then return "Rank 9" end
			return GuildControlGetRankName(9)
		end,
		desc = "Toggles this rank as a rank that promoter will promote FROM.",
		hidden = function(info)
			if GuildControlGetNumRanks()<=8 then 
				GuildManager.db.profile.rank8promotesearch=false
				return true end
			return false
		end,
		get = function(info)
			return GuildManager.db.profile.rank8promotesearch
		end,
		set = function(info, newValue)
			GuildManager.db.profile.rank8promotesearch = newValue
		end,
		order = 8
	}
	
	guildManagerOptions.args.promotion.args.rankpromotesearch.args.rank9promotesearch = {
		type = 'toggle',
		name = function(info)
			if GuildControlGetRankName(10)==nil then return "Rank 10" end
			return GuildControlGetRankName(10)
		end,
		desc = "Toggles this rank as a rank that promoter will promote FROM.",
		hidden = function(info)
			if GuildControlGetNumRanks()<=9 then 
				GuildManager.db.profile.rank9promotesearch=false
				return true end
			return false
		end,
		get = function(info)
			return GuildManager.db.profile.rank9promotesearch
		end,
		set = function(info, newValue)
			GuildManager.db.profile.rank9promotesearch = newValue
		end,
		order = 9
	}
	
--* Promotion Rank Promote Search *--
guildManagerOptions.args.promotion.args.rankpromoteplacelevel = {
	type = 'group',
	name = "Promote To By Level",
	desc = "Ranks that Guild Promoter will look at when placing qualified candidates",
	order = 8,
	args = {}
}

	guildManagerOptions.args.promotion.args.rankpromoteplacelevel.args.rank1promote = {
		type = 'toggle',
		name = function(info)
			if GuildControlGetRankName(2)==nil then return "Rank 2" end
			return GuildControlGetRankName(2)
		end,
		desc = "Toggles this rank as a rank that promoter will promote TO.",
		hidden = function(info)
			if GuildControlGetNumRanks()<=2 then 
				GuildManager.db.profile.rank1promote=false
				return true end
			return false
		end,
		get = function(info)
			return GuildManager.db.profile.rank1promote
		end,
		set = function(info, newValue)
			GuildManager.db.profile.rank1promote = newValue
		end,
		order = 3
	}
	
	guildManagerOptions.args.promotion.args.rankpromoteplacelevel.args.rank1level = {
		type = 'range',
		width = "normal",
		max = 111,
		min = 1,
		name = strjoin(" ",GuildControlGetRankName(2),"Level Threshold"),
		desc = strjoin(" ","Input for",GuildControlGetRankName(2),"Level Threshold"),
		step = 1,
		disabled = function(info)
			if GuildManager.db.profile.rank1promote then return false end
			return true
		end,
		hidden = function(info)
			if GuildControlGetNumRanks()<=2 then 
				GuildManager.db.profile.rank1level=111
				return true end
			return false
		end,
		get = function(info)
			return GuildManager.db.profile.rank1level
		end,
		set = function(info, newValue)
			GuildManager.db.profile.rank1level = newValue
		end,
		order = 4
	}
	
	guildManagerOptions.args.promotion.args.rankpromoteplacelevel.args.rank2promote = {
		type = 'toggle',
		name = function(info)
			if GuildControlGetRankName(3)==nil then return "Rank 3" end
			return GuildControlGetRankName(3)
		end,
		desc = "Toggles this rank as a rank that promoter will promote TO.",
		hidden = function(info)
			if GuildControlGetNumRanks()<=3 then 
				GuildManager.db.profile.rank2promote=false
				return true end
			return false
		end,
		get = function(info)
			return GuildManager.db.profile.rank2promote
		end,
		set = function(info, newValue)
			GuildManager.db.profile.rank2promote = newValue
		end,
		order = 5
	}
	
	guildManagerOptions.args.promotion.args.rankpromoteplacelevel.args.rank2level = {
		type = 'range',
		width = "normal",
		max = 111,
		min = 1,
		name = strjoin(" ",GuildControlGetRankName(3),"Level Threshold"),
		desc = strjoin(" ","Input for",GuildControlGetRankName(3),"Level Threshold"),
		step = 1,
		disabled = function(info)
			if GuildManager.db.profile.rank2promote then return false end
			return true
		end,
		hidden = function(info)
			if GuildControlGetNumRanks()<=3 then 
				GuildManager.db.profile.rank2level=111
				return true end
			return false
		end,
		get = function(info)
			return GuildManager.db.profile.rank2level
		end,
		set = function(info, newValue)
			GuildManager.db.profile.rank2level = newValue
		end,
		order = 6
	}
	
	guildManagerOptions.args.promotion.args.rankpromoteplacelevel.args.rank3promote = {
		type = 'toggle',
		name = function(info)
			if GuildControlGetRankName(4)==nil then return "Rank 4" end
			return GuildControlGetRankName(4)
		end,
		desc = "Toggles this rank as a rank that promoter will promote TO.",
		hidden = function(info)
			if GuildControlGetNumRanks()<=4 then 
				GuildManager.db.profile.rank3promote=false
				return true end
			return false
		end,
		get = function(info)
			return GuildManager.db.profile.rank3promote
		end,
		set = function(info, newValue)
			GuildManager.db.profile.rank3promote = newValue
		end,
		order = 7
	}
	
	guildManagerOptions.args.promotion.args.rankpromoteplacelevel.args.rank3level = {
		type = 'range',
		width = "normal",
		max = 111,
		min = 1,
		name = strjoin(" ",GuildControlGetRankName(4),"Level Threshold"),
		desc = strjoin(" ","Input for",GuildControlGetRankName(4),"Level Threshold"),
		step = 1,
		disabled = function(info)
			if GuildManager.db.profile.rank3promote then return false end
			return true
		end,
		hidden = function(info)
			if GuildControlGetNumRanks()<=4 then 
				GuildManager.db.profile.rank3level=111
				return true end
			return false
		end,
		get = function(info)
			return GuildManager.db.profile.rank3level
		end,
		set = function(info, newValue)
			GuildManager.db.profile.rank3level = newValue
		end,
		order = 8
	}
	
	guildManagerOptions.args.promotion.args.rankpromoteplacelevel.args.rank4promote = {
		type = 'toggle',
		name = function(info)
			if GuildControlGetRankName(5)==nil then return "Rank 5" end
			return GuildControlGetRankName(5)
		end,
		desc = "Toggles this rank as a rank that promoter will promote TO.",
		hidden = function(info)
			if GuildControlGetNumRanks()<=5 then 
				GuildManager.db.profile.rank4promote=false
				return true end
			return false
		end,
		get = function(info)
			return GuildManager.db.profile.rank4promote
		end,
		set = function(info, newValue)
			GuildManager.db.profile.rank4promote = newValue
		end,
		order = 9
	}
	
	guildManagerOptions.args.promotion.args.rankpromoteplacelevel.args.rank4level = {
		type = 'range',
		width = "normal",
		max = 111,
		min = 1,
		name = strjoin(" ",GuildControlGetRankName(5),"Level Threshold"),
		desc = strjoin(" ","Input for",GuildControlGetRankName(5),"Level Threshold"),
		step = 1,
		disabled = function(info)
			if GuildManager.db.profile.rank4promote then return false end
			return true
		end,
		hidden = function(info)
			if GuildControlGetNumRanks()<=5 then 
				GuildManager.db.profile.rank4level=111
				return true end
			return false
		end,
		get = function(info)
			return GuildManager.db.profile.rank4level
		end,
		set = function(info, newValue)
			GuildManager.db.profile.rank4level = newValue
		end,
		order = 10
	}
	
	guildManagerOptions.args.promotion.args.rankpromoteplacelevel.args.rank5promote = {
		type = 'toggle',
		name = function(info)
			if GuildControlGetRankName(6)==nil then return "Rank 6" end
			return GuildControlGetRankName(6)
		end,
		desc = "Toggles this rank as a rank that promoter will promote TO.",
		hidden = function(info)
			if GuildControlGetNumRanks()<=6 then 
				GuildManager.db.profile.rank5promote=false
				return true end
			return false
		end,
		get = function(info)
			return GuildManager.db.profile.rank5promote
		end,
		set = function(info, newValue)
			GuildManager.db.profile.rank5promote = newValue
		end,
		order = 11
	}
	
	guildManagerOptions.args.promotion.args.rankpromoteplacelevel.args.rank5level = {
		type = 'range',
		width = "normal",
		max = 111,
		min = 1,
		name = strjoin(" ",GuildControlGetRankName(6),"Level Threshold"),
		desc = strjoin(" ","Input for",GuildControlGetRankName(6),"Level Threshold"),
		step = 1,
		disabled = function(info)
			if GuildManager.db.profile.rank5promote then return false end
			return true
		end,
		hidden = function(info)
			if GuildControlGetNumRanks()<=6 then 
				GuildManager.db.profile.rank5level=111
				return true end
			return false
		end,
		get = function(info)
			return GuildManager.db.profile.rank5level
		end,
		set = function(info, newValue)
			GuildManager.db.profile.rank5level = newValue
		end,
		order = 12
	}
	
	guildManagerOptions.args.promotion.args.rankpromoteplacelevel.args.rank6promote = {
		type = 'toggle',
		name = function(info)
			if GuildControlGetRankName(7)==nil then return "Rank 7" end
			return GuildControlGetRankName(7)
		end,
		desc = "Toggles this rank as a rank that promoter will promote TO.",
		hidden = function(info)
			if GuildControlGetNumRanks()<=7 then 
				GuildManager.db.profile.rank6promote=false
				return true end
			return false
		end,
		get = function(info)
			return GuildManager.db.profile.rank6promote
		end,
		set = function(info, newValue)
			GuildManager.db.profile.rank6promote = newValue
		end,
		order = 13
	}
	
	guildManagerOptions.args.promotion.args.rankpromoteplacelevel.args.rank6level = {
		type = 'range',
		width = "normal",
		max = 111,
		min = 1,
		name = strjoin(" ",GuildControlGetRankName(7),"Level Threshold"),
		desc = strjoin(" ","Input for",GuildControlGetRankName(7),"Level Threshold"),
		step = 1,
		disabled = function(info)
			if GuildManager.db.profile.rank6promote then return false end
			return true
		end,
		hidden = function(info)
			if GuildControlGetNumRanks()<=7 then 
				GuildManager.db.profile.rank6level=111
				return true end
			return false
		end,
		get = function(info)
			return GuildManager.db.profile.rank6level
		end,
		set = function(info, newValue)
			GuildManager.db.profile.rank6level = newValue
		end,
		order = 14
	}
	
	guildManagerOptions.args.promotion.args.rankpromoteplacelevel.args.rank7promote = {
		type = 'toggle',
		name = function(info)
			if GuildControlGetRankName(8)==nil then return "Rank 8" end
			return GuildControlGetRankName(8)
		end,
		desc = "Toggles this rank as a rank that promoter will promote TO.",
		hidden = function(info)
			if GuildControlGetNumRanks()<=8 then 
				GuildManager.db.profile.rank7promote=false
				return true end
			return false
		end,
		get = function(info)
			return GuildManager.db.profile.rank7promote
		end,
		set = function(info, newValue)
			GuildManager.db.profile.rank7promote = newValue
		end,
		order = 15
	}
	
	guildManagerOptions.args.promotion.args.rankpromoteplacelevel.args.rank7level = {
		type = 'range',
		width = "normal",
		max = 111,
		min = 1,
		name = strjoin(" ",GuildControlGetRankName(8),"Level Threshold"),
		desc = strjoin(" ","Input for",GuildControlGetRankName(8),"Level Threshold"),
		step = 1,
		disabled = function(info)
			if GuildManager.db.profile.rank7promote then return false end
			return true
		end,
		hidden = function(info)
			if GuildControlGetNumRanks()<=8 then 
				GuildManager.db.profile.rank7level=111
				return true end
			return false
		end,
		get = function(info)
			return GuildManager.db.profile.rank7level
		end,
		set = function(info, newValue)
			GuildManager.db.profile.rank7level = newValue
		end,
		order = 16
	}
	
	guildManagerOptions.args.promotion.args.rankpromoteplacelevel.args.rank8promote = {
		type = 'toggle',
		name = function(info)
			if GuildControlGetRankName(9)==nil then return "Rank 9" end
			return GuildControlGetRankName(9)
		end,
		desc = "Toggles this rank as a rank that promoter will promote TO.",
		hidden = function(info)
			if GuildControlGetNumRanks()<=9 then 
				GuildManager.db.profile.rank8promote=false
				return true end
			return false
		end,
		get = function(info)
			return GuildManager.db.profile.rank8promote
		end,
		set = function(info, newValue)
			GuildManager.db.profile.rank8promote = newValue
		end,
		order = 17
	}
	
	guildManagerOptions.args.promotion.args.rankpromoteplacelevel.args.rank8level = {
		type = 'range',
		max = 111,
		min = 1,
		name = strjoin(" ",GuildControlGetRankName(9),"Level Threshold"),
		desc = strjoin(" ","Input for",GuildControlGetRankName(9),"Level Threshold"),
		step = 1,
		disabled = function(info)
			if GuildManager.db.profile.rank8promote then return false end
			return true
		end,
		hidden = function(info)
			if GuildControlGetNumRanks()<=9 then 
				GuildManager.db.profile.rank8level=111
				return true end
			return false
		end,
		get = function(info)
			return GuildManager.db.profile.rank8level
		end,
		set = function(info, newValue)
			GuildManager.db.profile.rank8level = newValue
		end,
		order = 18
	}
	
--* Promotion Player Exemption List *--
guildManagerOptions.args.promotion.args.demoteexemptlist = {
	type = 'group',
	childGroups = "tab",
	name = "Player Exemption List",
	desc = "List of players who are exempt from demotion.",
	order = 9,
	disabled = function(info)
		if GuildManager.db.profile.demotemode then return false end
		return true
	end,
	args = {}
}

guildManagerOptions.args.promotion.args.demoteexemptlist.args.demoteexemptcontrols = {
	type = 'execute',
	name = "Launch Demote Exempt Controls?",
	desc = "WARNING: Over time the Demote Exemption List can get huge. If you MUST modify or purge the list be prepared for your UI to freeze for 30-60 seconds while the controls load.",
	confirm = true,
	func = 	function(info)
		GuildManager:DemoteExemptUI()
	end,
	order = 11
}

--* Announcments *--
guildManagerOptions.args.announcments = {
	type = 'group',
	name = "Announcements",
	desc = "Guild Announcment Settings",
	order = 5,
	args = {}
}

guildManagerOptions.args.announcments.args.annoucementstats = {
	type = 'execute',
	name = "Annoucement Stats",
	desc = "Prints which message was spammed last and when it was spammed.",
	func = 	function()
		if ValidMessages==1 then
			GuildManager:Print(strjoin(" ","A Guild Annoucnement was made",(GuildManager:GetTime()-GuildManager.db.profile.lastanntime),"minutes ago. Guild Announcement",GuildManager.db.profile.announcenext,"is due to print in",(GuildManager.db.profile.lastanntime+GuildManager.db.profile.nextannouncetime)-GuildManager:GetTime(),"minutes."))
		else
			GuildManager:Print("There Are No Valid Messages!")
		end
	end,
	order = 1
}

guildManagerOptions.args.announcments.args.annoucementskip = {
	type = 'execute',
	name = "Skip Announcement",
	desc = "Skips the next upcoming announcement and loads the one after that.",
	func = 	function()
		if ValidMessages==1 then
			GuildManager:Print(strjoin(" ","Skipping Guild Announcement",GuildManager.db.profile.announcenext))
			announcementskip=1
			GuildManager:LoadNextAnnouncement()
			announcementskip=0
			GuildManager:Print(strjoin(" ","Guild Announcement",GuildManager.db.profile.announcenext,"Loaded"))
		else 
			GuildManager:Print("There Are No Valid Messages!")
		end
	end,
	order = 2
}

guildManagerOptions.args.announcments.args.announcmentoverride = {
	type = 'execute',
	name = "Announce Now",
	desc = "Overrides the timer and broadcasts the next upcoming announcment.",
	func = 	function()
		if ValidMessages==1 then
			GuildManager:ExecuteAnnouncement()
		else
			GuildManager:Print("There Are No Valid Messages!")
		end
	end,
	order = 3
}

guildManagerOptions.args.announcments.args.announcement1 = {
	type = 'input',
	multiline = true,
	width = "full",
	name = "Announcement 1",
	desc = "The message text that will be broadcast in Guild/Officer",
	usage = "<Your message here>",
	get = function(info)
		return GuildManager.db.profile.announcement1
	end,
	set = function(info, newValue)
		GuildManager.db.profile.announcement1 = newValue
	end,
	order = 4
}

guildManagerOptions.args.announcments.args.announcementtimer1 = {
	type = 'range',
	name = "Annoucement 1 Timer",
	desc = "Set the amount of time between the PREVIOUS message and THIS message.",
	min = 1,
	max = 60,
	step = 1,
	get = function(info)
		return GuildManager.db.profile.announcementtimer1
	end,
	set = function(info, newValue)
		GuildManager.db.profile.announcementtimer1 = newValue
	end,
	order = 5
}

guildManagerOptions.args.announcments.args.announcementto1 = {
	type = "select",
	order = 6,
	name = "Announce to Officer/Guild 1",
	desc = "Choose which channel to make this announcement in OR disable it.",
	values = {"Disabled","Officer","Guild"},
	get = function(info)
		return GuildManager.db.profile.announcementto1
	end,
	set = function(info, newValue)
		GuildManager.db.profile.announcementto1 = newValue
	end,
}

guildManagerOptions.args.announcments.args.announcementborder1 = {
	type = "select",
	order = 7,
	name = "Announce Border 1",
	desc = "Border style to wrap around the annoucnement. Great for annoucnements that exceed the single message character limit.",
	values = {"None","Star","Cricle","Diamond","Triangle","Moon","Square","Cross","Skull"},
	get = function(info)
		return GuildManager.db.profile.announcementborder1
	end,
	set = function(info, newValue)
		GuildManager.db.profile.announcementborder1 = newValue
	end
}
	
guildManagerOptions.args.announcments.args.announcement2 = {
	type = 'input',
    multiline = true,
    width = "full",
    name = "Announcement 2",
    desc = "The message text that will be broadcast in Guild/Officer",
    usage = "<Your message here>",
    get = function(info)
		return GuildManager.db.profile.announcement2
	end,
    set = function(info, newValue)
		GuildManager.db.profile.announcement2 = newValue
	end,
	order = 8
}

guildManagerOptions.args.announcments.args.announcementtimer2 = {
	type = 'range',
	name = "Annoucement 2 Timer",
	desc = "Set the amount of time between the PREVIOUS message and THIS message.",
	min = 1,
	max = 60,
	step = 1,
	get = function(info)
		return GuildManager.db.profile.announcementtimer2
	end,
	set = function(info, newValue)
		GuildManager.db.profile.announcementtimer2 = newValue
	end,
	order = 9
}

guildManagerOptions.args.announcments.args.announcementto2 = {
	type = "select",
	order = 10,
	name = "Announce to Officer/Guild 2",
	desc = "Choose which channel to make this announcement in OR disable it.",
	values = {"Disabled","Officer","Guild"},
	get = function(info)
		return GuildManager.db.profile.announcementto2
	end,
	set = function(info, newValue)
		GuildManager.db.profile.announcementto2 = newValue
	end
}

guildManagerOptions.args.announcments.args.announcementborder2 = {
	type = "select",
	order = 11,
	name = "Announce Border 2",
	desc = "Border style to wrap around the annoucnement. Great for annoucnements that exceed the single message character limit.",
	values = {"None","Star","Cricle","Diamond","Triangle","Moon","Square","Cross","Skull"},
	get = function(info)
		return GuildManager.db.profile.announcementborder2
	end,
	set = function(info, newValue)
		GuildManager.db.profile.announcementborder2 = newValue
	end
}

guildManagerOptions.args.announcments.args.announcement3 = {
	type = 'input',
	multiline = true,
	width = "full",
	name = "Announcement 3",
	desc = "The message text that will be broadcast in Guild/Officer",
	usage = "<Your message here>",
	get = function(info)
		return GuildManager.db.profile.announcement3
	end,
	set = function(info, newValue)
		GuildManager.db.profile.announcement3 = newValue
	end,
	order = 12
}

guildManagerOptions.args.announcments.args.announcementtimer3 = {
	type = 'range',
	name = "Annoucement 3 Timer",
	desc = "Set the amount of time between the PREVIOUS message and THIS message.",
	min = 1,
	max = 60,
	step = 1,
	get = function(info)
		return GuildManager.db.profile.announcementtimer3
	end,
	set = function(info, newValue)
		GuildManager.db.profile.announcementtimer3 = newValue
	end,
	order = 13
}

guildManagerOptions.args.announcments.args.announcementto3 = {
	type = "select",
	order = 14,
	name = "Announce to Officer/Guild 3",
	desc = "Choose which channel to make this announcement in OR disable it.",
	values = {"Disabled","Officer","Guild"},
	get = function(info)
		return GuildManager.db.profile.announcementto3
	end,
	set = function(info, newValue)
		GuildManager.db.profile.announcementto3 = newValue
	end
}

guildManagerOptions.args.announcments.args.announcementborder3 = {
	type = "select",
	order = 15,
	name = "Announce Border 3",
	desc = "Border style to wrap around the annoucnement. Great for annoucnements that exceed the single message character limit.",
	values = {"None","Star","Cricle","Diamond","Triangle","Moon","Square","Cross","Skull"},
	get = function(info)
		return GuildManager.db.profile.announcementborder3
	end,
	set = function(info, newValue)
		GuildManager.db.profile.announcementborder3 = newValue
	end
}

guildManagerOptions.args.announcments.args.announcement4 = {
	type = 'input',
    multiline = true,
    width = "full",
    name = "Announcement 4",
    desc = "The message text that will be broadcast in Guild/Officer",
    usage = "<Your message here>",
    get = function(info)
		return GuildManager.db.profile.announcement4
	end,
    set = function(info, newValue)
		GuildManager.db.profile.announcement4 = newValue
	end,
	order = 16
}

guildManagerOptions.args.announcments.args.announcementtimer4 = {
	type = 'range',
	name = "Annoucement 4 Timer",
	desc = "Set the amount of time between the PREVIOUS message and THIS message.",
	min = 1,
	max = 60,
	step = 1,
	get = function(info)
		return GuildManager.db.profile.announcementtimer4
	end,
	set = function(info, newValue)
		GuildManager.db.profile.announcementtimer4 = newValue
	end,
	order = 17
}

guildManagerOptions.args.announcments.args.announcementto4 = {
	type = "select",
	order = 18,
	name = "Announce to Officer/Guild 4",
	desc = "Choose which channel to make this announcement in OR disable it.",
	values = {"Disabled","Officer","Guild"},
	get = function(info)
		return GuildManager.db.profile.announcementto4
	end,
	set = function(info, newValue)
		GuildManager.db.profile.announcementto4 = newValue
	end
}

guildManagerOptions.args.announcments.args.announcementborder4 = {
	type = "select",
	order = 19,
	name = "Announce Border 4",
	desc = "Border style to wrap around the annoucnement. Great for annoucnements that exceed the single message character limit.",
	values = {"None","Star","Cricle","Diamond","Triangle","Moon","Square","Cross","Skull"},
	get = function(info)
		return GuildManager.db.profile.announcementborder4
	end,
	set = function(info, newValue)
		GuildManager.db.profile.announcementborder4 = newValue
	end
}

guildManagerOptions.args.announcments.args.announcement5 = {
	type = 'input',
    multiline = true,
    width = "full",
    name = "Announcement 5",
    desc = "The message text that will be broadcast in Guild/Officer",
    usage = "<Your message here>",
    get = function(info)
		return GuildManager.db.profile.announcement5
	end,
    set = function(info, newValue)
		GuildManager.db.profile.announcement5 = newValue
	end,
	order = 20
}

guildManagerOptions.args.announcments.args.announcementtimer5 = {
	type = 'range',
	name = "Annoucement 5 Timer",
	desc = "Set the amount of time between the PREVIOUS message and THIS message.",
	min = 1,
	max = 60,
	step = 1,
	get = function(info)
		return GuildManager.db.profile.announcementtimer5
	end,
	set = function(info, newValue)
		GuildManager.db.profile.announcementtimer5 = newValue
	end,
	order = 21
}

guildManagerOptions.args.announcments.args.announcementto5 = {
	type = "select",
	order = 22,
	name = "Announce to Officer/Guild 5",
	desc = "Choose which channel to make this announcement in OR disable it.",
	values = {"Disabled","Officer","Guild"},
	get = function(info)
		return GuildManager.db.profile.announcementto5
	end,
	set = function(info, newValue)
		GuildManager.db.profile.announcementto5 = newValue
	end
}

guildManagerOptions.args.announcments.args.announcementborder5 = {
	type = "select",
	order = 23,
	name = "Announce Border 5",
	desc = "Border style to wrap around the annoucnement. Great for annoucnements that exceed the single message character limit.",
	values = {"None","Star","Cricle","Diamond","Triangle","Moon","Square","Cross","Skull"},
	get = function(info)
		return GuildManager.db.profile.announcementborder5
	end,
	set = function(info, newValue)
		GuildManager.db.profile.announcementborder5 = newValue
	end
}