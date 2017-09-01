-- Author      : Robert
-- Create Date : 9/1/2017 12:09:30 PM

local function ChatCmd(input)
	if not input or input:trim() == "" then
		InterfaceOptionsFrame_OpenToCategory(GuildManager.optionsframe)
	else
		LibStub("AceConfigCmd-3.0").HandleCommand(GuildManager, "gm", "GuildManager", input:trim() ~= "help" and input or "")
	end
end

GuildManager:RegisterChatCommand("GuildManager", ChatCmd)
GuildManager:RegisterChatCommand("gm", ChatCmd)