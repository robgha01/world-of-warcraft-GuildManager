-- Author      : Robert
-- Create Date : 9/4/2017 2:16:33 PM

--* Promote To By Level *--
guildManagerOptions.args.promotion.args.rankpromoteplacereputation = {
	type = 'group',
	name = "Promote To By Reputation",
	desc = "Ranks that Guild Promoter will look at when placing qualified candidates",
	order = 9,
	args = {}
}

	guildManagerOptions.args.promotion.args.rankpromoteplacereputation.args.rank1promote = {
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
	
	guildManagerOptions.args.promotion.args.rankpromoteplacereputation.args.rank1level = {
		type = 'range',
		width = "normal",
		max = 8,
		min = 4,
		name = "Reputation Threshold",
		desc = strjoin(" ","Input for",GuildControlGetRankName(2),"Reputation Threshold"),
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
	
	guildManagerOptions.args.promotion.args.rankpromoteplacereputation.args.rank2promote = {
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
	
	guildManagerOptions.args.promotion.args.rankpromoteplacereputation.args.rank2level = {
		type = 'range',
		width = "normal",
		max = 8,
		min = 4,
		name = "Reputation Threshold",
		desc = strjoin(" ","Input for",GuildControlGetRankName(3),"Reputation Threshold"),
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
	
	guildManagerOptions.args.promotion.args.rankpromoteplacereputation.args.rank3promote = {
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
	
	guildManagerOptions.args.promotion.args.rankpromoteplacereputation.args.rank3level = {
		type = 'range',
		width = "normal",
		max = 8,
		min = 4,
		name = "Reputation Threshold",
		desc = strjoin(" ","Input for",GuildControlGetRankName(4),"Reputation Threshold"),
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
	
	guildManagerOptions.args.promotion.args.rankpromoteplacereputation.args.rank4promote = {
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
	
	guildManagerOptions.args.promotion.args.rankpromoteplacereputation.args.rank4level = {
		type = 'range',
		width = "normal",
		max = 8,
		min = 4,
		name = "Reputation Threshold",
		desc = strjoin(" ","Input for",GuildControlGetRankName(5),"Reputation Threshold"),
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
	
	guildManagerOptions.args.promotion.args.rankpromoteplacereputation.args.rank5promote = {
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
	
	guildManagerOptions.args.promotion.args.rankpromoteplacereputation.args.rank5level = {
		type = 'range',
		width = "normal",
		max = 8,
		min = 4,
		name = "Reputation Threshold",
		desc = strjoin(" ","Input for",GuildControlGetRankName(6),"Reputation Threshold"),
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
	
	guildManagerOptions.args.promotion.args.rankpromoteplacereputation.args.rank6promote = {
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
	
	guildManagerOptions.args.promotion.args.rankpromoteplacereputation.args.rank6level = {
		type = 'range',
		width = "normal",
		max = 8,
		min = 4,
		name = "Reputation Threshold",
		desc = strjoin(" ","Input for",GuildControlGetRankName(7),"Reputation Threshold"),
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
	
	guildManagerOptions.args.promotion.args.rankpromoteplacereputation.args.rank7promote = {
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
	
	guildManagerOptions.args.promotion.args.rankpromoteplacereputation.args.rank7level = {
		type = 'range',
		width = "normal",
		max = 8,
		min = 4,
		name = "Reputation Threshold",
		desc = strjoin(" ","Input for",GuildControlGetRankName(8),"Reputation Threshold"),
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
	
	guildManagerOptions.args.promotion.args.rankpromoteplacereputation.args.rank8promote = {
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
	
	guildManagerOptions.args.promotion.args.rankpromoteplacereputation.args.rank8level = {
		type = 'range',
		max = 8,
		min = 4,
		name = "Reputation Threshold",
		desc = strjoin(" ","Input for",GuildControlGetRankName(9),"Reputation Threshold"),
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