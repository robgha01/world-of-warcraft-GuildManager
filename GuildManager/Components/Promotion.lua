-- Author      : Robert
-- Create Date : 9/1/2017 3:51:08 PM

--*PROMOTION*--
function GuildManager:GMPromoteErrorChecking()
    GuildManager:GMPromoteErrorCheckingLevel()
end

--BY LEVEL--
function GuildManager:GMPromoteErrorCheckingLevel()
    if IsGuildLeader()==true or IsGuildLeader()~=true then
        GPERROR=0
        if GuildManager.db.profile.rank1promote==true then
            if GuildManager.db.profile.rank1level==GuildManager.db.profile.rank2level and GuildManager.db.profile.rank2promote==true then
                GPERROR=1
            end
            if GuildManager.db.profile.rank1level==GuildManager.db.profile.rank3level and GuildManager.db.profile.rank3promote==true then
                GPERROR=1
            end
            if GuildManager.db.profile.rank1level==GuildManager.db.profile.rank4level and GuildManager.db.profile.rank4promote==true then
                GPERROR=1
            end
            if GuildManager.db.profile.rank1level==GuildManager.db.profile.rank5level and GuildManager.db.profile.rank5promote==true then
                GPERROR=1
            end
            if GuildManager.db.profile.rank1level==GuildManager.db.profile.rank6level and GuildManager.db.profile.rank6promote==true then
                GPERROR=1
            end
            if GuildManager.db.profile.rank1level==GuildManager.db.profile.rank7level and GuildManager.db.profile.rank7promote==true then
                GPERROR=1
            end
            if GuildManager.db.profile.rank1level==GuildManager.db.profile.rank8level and GuildManager.db.profile.rank8promote==true then
                GPERROR=1
            end
        end
        if GuildManager.db.profile.rank2promote==true then
            if GuildManager.db.profile.rank2level==GuildManager.db.profile.rank3level and GuildManager.db.profile.rank3promote==true then
                GPERROR=1
            end
            if GuildManager.db.profile.rank2level==GuildManager.db.profile.rank4level and GuildManager.db.profile.rank4promote==true then
                GPERROR=1
            end
            if GuildManager.db.profile.rank2level==GuildManager.db.profile.rank5level and GuildManager.db.profile.rank5promote==true then
                GPERROR=1
            end
            if GuildManager.db.profile.rank2level==GuildManager.db.profile.rank6level and GuildManager.db.profile.rank6promote==true then
                GPERROR=1
            end
            if GuildManager.db.profile.rank2level==GuildManager.db.profile.rank7level and GuildManager.db.profile.rank7promote==true then
                GPERROR=1
            end
            if GuildManager.db.profile.rank2level==GuildManager.db.profile.rank8level and GuildManager.db.profile.rank8promote==true then
                GPERROR=1
            end
        end
        if GuildManager.db.profile.rank3promote==true then
            if GuildManager.db.profile.rank3level==GuildManager.db.profile.rank4level and GuildManager.db.profile.rank4promote==true then
                GPERROR=1
            end
            if GuildManager.db.profile.rank3level==GuildManager.db.profile.rank5level and GuildManager.db.profile.rank5promote==true then
                GPERROR=1
            end
            if GuildManager.db.profile.rank3level==GuildManager.db.profile.rank6level and GuildManager.db.profile.rank6promote==true then
                GPERROR=1
            end
            if GuildManager.db.profile.rank3level==GuildManager.db.profile.rank7level and GuildManager.db.profile.rank7promote==true then
                GPERROR=1
            end
            if GuildManager.db.profile.rank3level==GuildManager.db.profile.rank8level and GuildManager.db.profile.rank8promote==true then
                GPERROR=1
            end
        end
        if GuildManager.db.profile.rank4promote==true then
            if GuildManager.db.profile.rank4level==GuildManager.db.profile.rank5level and GuildManager.db.profile.rank5promote==true then
                GPERROR=1
            end
            if GuildManager.db.profile.rank4level==GuildManager.db.profile.rank6level and GuildManager.db.profile.rank6promote==true then
                GPERROR=1
            end
            if GuildManager.db.profile.rank4level==GuildManager.db.profile.rank7level and GuildManager.db.profile.rank7promote==true then
                GPERROR=1
            end
            if GuildManager.db.profile.rank4level==GuildManager.db.profile.rank8level and GuildManager.db.profile.rank8promote==true then
                GPERROR=1
            end
        end
        if GuildManager.db.profile.rank5promote==true then
            if GuildManager.db.profile.rank5level==GuildManager.db.profile.rank6level and GuildManager.db.profile.rank6promote==true then
                GPERROR=1
            end
            if GuildManager.db.profile.rank5level==GuildManager.db.profile.rank7level and GuildManager.db.profile.rank7promote==true then
                GPERROR=1
            end
            if GuildManager.db.profile.rank5level==GuildManager.db.profile.rank8level and GuildManager.db.profile.rank8promote==true then
                GPERROR=1
            end
        end
        if GuildManager.db.profile.rank6promote==true then
            if GuildManager.db.profile.rank6level==GuildManager.db.profile.rank7level and GuildManager.db.profile.rank7promote==true then
                GPERROR=1
            end
            if GuildManager.db.profile.rank6level==GuildManager.db.profile.rank8level and GuildManager.db.profile.rank8promote==true then
                GPERROR=1
            end
        end
        if GuildManager.db.profile.rank7promote==true then
            if GuildManager.db.profile.rank7level==GuildManager.db.profile.rank8level and GuildManager.db.profile.rank8promote==true then
                GPERROR=1
            end
        end
        GuildManager:GMPromoteLevel()
    else
        GuildManager:Print('Member Promotion Cycle did NOT start! Only Guild Leaders can use this function!')
    end
end

local countPromotions = 0;

function GuildManager:DoGMPromoteLevel(totali,i,name,rankn,ranki,level)
	--print(strjoin(" ","Doing-PromoteLevel:", "at index:", i, "for", name, "rankn:", rankn, "ranki:", ranki, "level:", level ))
	--print(strjoin(" ","Doing-PromoteLevel:", i, "of", totali))
	countPromotions = countPromotions + 1;
	if (GuildManager.db.profile.rank1promotesearch==true and ranki+1==2) or (GuildManager.db.profile.rank2promotesearch==true and ranki+1==3) or (GuildManager.db.profile.rank3promotesearch==true and ranki+1==4) or (GuildManager.db.profile.rank4promotesearch==true and ranki+1==5) or (GuildManager.db.profile.rank5promotesearch==true and ranki+1==6) or (GuildManager.db.profile.rank6promotesearch==true and ranki+1==7) or (GuildManager.db.profile.rank7promotesearch==true and ranki+1==8) or (GuildManager.db.profile.rank8promotesearch==true and ranki+1==9) or (GuildManager.db.profile.rank9promotesearch==true and ranki+1==10) then
		if GuildManager.db.profile.rank1promote==true and level/GuildManager.db.profile.rank1level>=1 and IsGuildRankAssignmentAllowed(ranki,2)==true then
			if level/GuildManager.db.profile.rank2level<1 or level/GuildManager.db.profile.rank2level>level/GuildManager.db.profile.rank1level or GuildManager.db.profile.rank2promote~=true or GuildControlGetNumGuildRanks()<3 then
				if level/GuildManager.db.profile.rank3level<1 or level/GuildManager.db.profile.rank3level>level/GuildManager.db.profile.rank1level or GuildManager.db.profile.rank3promote~=true or GuildControlGetNumGuildRanks()<4 then
					if level/GuildManager.db.profile.rank4level<1 or level/GuildManager.db.profile.rank4level>level/GuildManager.db.profile.rank1level or GuildManager.db.profile.rank4promote~=true or GuildControlGetNumGuildRanks()<5 then
						if level/GuildManager.db.profile.rank5level<1 or level/GuildManager.db.profile.rank5level>level/GuildManager.db.profile.rank1level or GuildManager.db.profile.rank5promote~=true or GuildControlGetNumGuildRanks()<6 then
							if level/GuildManager.db.profile.rank6level<1 or level/GuildManager.db.profile.rank6level>level/GuildManager.db.profile.rank1level or GuildManager.db.profile.rank6promote~=true or GuildControlGetNumGuildRanks()<7 then
								if level/GuildManager.db.profile.rank7level<1 or level/GuildManager.db.profile.rank7level>level/GuildManager.db.profile.rank1level or GuildManager.db.profile.rank7promote~=true or GuildControlGetNumGuildRanks()<8 then
									if level/GuildManager.db.profile.rank8level<1 or level/GuildManager.db.profile.rank8level>level/GuildManager.db.profile.rank1level or GuildManager.db.profile.rank8promote~=true or GuildControlGetNumGuildRanks()<9 then
										SetGuildMemberRank(i,2)
										if ranki+1>2 then
											ANNOUNCErank1promote=ANNOUNCErank1promote+1
										end
									end
								end
							end
						end
					end
				end
			end
		end
		if GuildManager.db.profile.rank2promote==true and level/GuildManager.db.profile.rank2level>=1 and GuildControlGetNumRanks()>3 and IsGuildRankAssignmentAllowed(ranki,3)==true and (ranki+1>3 or (ranki+1<3 and GuildManager.db.profile.demotemode==true and tContains(GuildManager.db.profile.GMDemoteExemptt, name)~=1)) then
			if level/GuildManager.db.profile.rank1level<1 or level/GuildManager.db.profile.rank1level>level/GuildManager.db.profile.rank2level or GuildManager.db.profile.rank1promote~=true then
				if level/GuildManager.db.profile.rank3level<1 or level/GuildManager.db.profile.rank3level>level/GuildManager.db.profile.rank2level or GuildManager.db.profile.rank3promote~=true or GuildControlGetNumGuildRanks()<4 then
					if level/GuildManager.db.profile.rank4level<1 or level/GuildManager.db.profile.rank4level>level/GuildManager.db.profile.rank2level or GuildManager.db.profile.rank4promote~=true or GuildControlGetNumGuildRanks()<5 then
						if level/GuildManager.db.profile.rank5level<1 or level/GuildManager.db.profile.rank5level>level/GuildManager.db.profile.rank2level or GuildManager.db.profile.rank5promote~=true or GuildControlGetNumGuildRanks()<6 then
							if level/GuildManager.db.profile.rank6level<1 or level/GuildManager.db.profile.rank6level>level/GuildManager.db.profile.rank2level or GuildManager.db.profile.rank6promote~=true or GuildControlGetNumGuildRanks()<7 then
								if level/GuildManager.db.profile.rank7level<1 or level/GuildManager.db.profile.rank7level>level/GuildManager.db.profile.rank2level or GuildManager.db.profile.rank7promote~=true or GuildControlGetNumGuildRanks()<8 then
									if level/GuildManager.db.profile.rank8level<1 or level/GuildManager.db.profile.rank8level>level/GuildManager.db.profile.rank2level or GuildManager.db.profile.rank8promote~=true or GuildControlGetNumGuildRanks()<9 then
										SetGuildMemberRank(i,3)
										if ranki+1>3 then
											ANNOUNCErank2promote=ANNOUNCErank2promote+1
										end
										if ranki+1<3 then
											ANNOUNCErankdemote=ANNOUNCErankdemote+1
										end
									end
								end
							end
						end
					end
				end
			end
		end
		if GuildManager.db.profile.rank3promote==true and level/GuildManager.db.profile.rank3level>=1 and GuildControlGetNumRanks()>4 and IsGuildRankAssignmentAllowed(ranki,4)==true and (ranki+1>4 or (ranki+1<4 and GuildManager.db.profile.demotemode==true and tContains(GuildManager.db.profile.GMDemoteExemptt, name)~=1)) then
			if level/GuildManager.db.profile.rank2level<1 or level/GuildManager.db.profile.rank2level>level/GuildManager.db.profile.rank3level or GuildManager.db.profile.rank2promote~=true then
				if level/GuildManager.db.profile.rank1level<1 or level/GuildManager.db.profile.rank1level>level/GuildManager.db.profile.rank3level or GuildManager.db.profile.rank1promote~=true then
					if level/GuildManager.db.profile.rank4level<1 or level/GuildManager.db.profile.rank4level>level/GuildManager.db.profile.rank3level or GuildManager.db.profile.rank4promote~=true or GuildControlGetNumGuildRanks()<5 then
						if level/GuildManager.db.profile.rank5level<1 or level/GuildManager.db.profile.rank5level>level/GuildManager.db.profile.rank3level or GuildManager.db.profile.rank5promote~=true or GuildControlGetNumGuildRanks()<6 then
							if level/GuildManager.db.profile.rank6level<1 or level/GuildManager.db.profile.rank6level>level/GuildManager.db.profile.rank3level or GuildManager.db.profile.rank6promote~=true or GuildControlGetNumGuildRanks()<7 then
								if level/GuildManager.db.profile.rank7level<1 or level/GuildManager.db.profile.rank7level>level/GuildManager.db.profile.rank3level or GuildManager.db.profile.rank7promote~=true or GuildControlGetNumGuildRanks()<8 then
									if level/GuildManager.db.profile.rank8level<1 or level/GuildManager.db.profile.rank8level>level/GuildManager.db.profile.rank3level or GuildManager.db.profile.rank8promote~=true or GuildControlGetNumGuildRanks()<9 then
										SetGuildMemberRank(i,4)
										if ranki+1>4 then
											ANNOUNCErank3promote=ANNOUNCErank3promote+1
										end
										if ranki+1<4 then
											ANNOUNCErankdemote=ANNOUNCErankdemote+1
										end
									end
								end
							end
						end
					end
				end
			end
		end
		if GuildManager.db.profile.rank4promote==true and level/GuildManager.db.profile.rank4level>=1 and GuildControlGetNumRanks()>5 and IsGuildRankAssignmentAllowed(ranki,5)==true and (ranki+1>5 or (ranki+1<5 and GuildManager.db.profile.demotemode==true and tContains(GuildManager.db.profile.GMDemoteExemptt, name)~=1)) then
			if level/GuildManager.db.profile.rank2level<1 or level/GuildManager.db.profile.rank2level>level/GuildManager.db.profile.rank4level or GuildManager.db.profile.rank2promote~=true then
				if level/GuildManager.db.profile.rank3level<1 or level/GuildManager.db.profile.rank3level>level/GuildManager.db.profile.rank4level or GuildManager.db.profile.rank3promote~=true then
					if level/GuildManager.db.profile.rank1level<1 or level/GuildManager.db.profile.rank1level>level/GuildManager.db.profile.rank4level or GuildManager.db.profile.rank1promote~=true then
						if level/GuildManager.db.profile.rank5level<1 or level/GuildManager.db.profile.rank5level>level/GuildManager.db.profile.rank4level or GuildManager.db.profile.rank5promote~=true or GuildControlGetNumGuildRanks()<6 then
							if level/GuildManager.db.profile.rank6level<1 or level/GuildManager.db.profile.rank6level>level/GuildManager.db.profile.rank4level or GuildManager.db.profile.rank6promote~=true or GuildControlGetNumGuildRanks()<7 then
								if level/GuildManager.db.profile.rank7level<1 or level/GuildManager.db.profile.rank7level>level/GuildManager.db.profile.rank4level or GuildManager.db.profile.rank7promote~=true or GuildControlGetNumGuildRanks()<8 then
									if level/GuildManager.db.profile.rank8level<1 or level/GuildManager.db.profile.rank8level>level/GuildManager.db.profile.rank4level or GuildManager.db.profile.rank8promote~=true or GuildControlGetNumGuildRanks()<9 then
										SetGuildMemberRank(i,5)
										if ranki+1>5 then
											ANNOUNCErank4promote=ANNOUNCErank4promote+1
										end
										if ranki+1<5 then
											ANNOUNCErankdemote=ANNOUNCErankdemote+1
										end
									end
								end
							end
						end
					end
				end
			end
		end
		if GuildManager.db.profile.rank5promote==true and level/GuildManager.db.profile.rank5level>=1 and GuildControlGetNumRanks()>6 and IsGuildRankAssignmentAllowed(ranki,6)==true and (ranki+1>6 or (ranki+1<6 and GuildManager.db.profile.demotemode==true and tContains(GuildManager.db.profile.GMDemoteExemptt, name)~=1)) then
			if level/GuildManager.db.profile.rank2level<1 or level/GuildManager.db.profile.rank2level>level/GuildManager.db.profile.rank5level or GuildManager.db.profile.rank2promote~=true then
				if level/GuildManager.db.profile.rank3level<1 or level/GuildManager.db.profile.rank3level>level/GuildManager.db.profile.rank5level or GuildManager.db.profile.rank3promote~=true then
					if level/GuildManager.db.profile.rank4level<1 or level/GuildManager.db.profile.rank4level>level/GuildManager.db.profile.rank5level or GuildManager.db.profile.rank4promote~=true then
						if level/GuildManager.db.profile.rank1level<1 or level/GuildManager.db.profile.rank1level>level/GuildManager.db.profile.rank5level or GuildManager.db.profile.rank1promote~=true then
							if level/GuildManager.db.profile.rank6level<1 or level/GuildManager.db.profile.rank6level>level/GuildManager.db.profile.rank5level or GuildManager.db.profile.rank6promote~=true or GuildControlGetNumGuildRanks()<7 then
								if level/GuildManager.db.profile.rank7level<1 or level/GuildManager.db.profile.rank7level>level/GuildManager.db.profile.rank5level or GuildManager.db.profile.rank7promote~=true or GuildControlGetNumGuildRanks()<8 then
									if level/GuildManager.db.profile.rank8level<1 or level/GuildManager.db.profile.rank8level>level/GuildManager.db.profile.rank5level or GuildManager.db.profile.rank8promote~=true or GuildControlGetNumGuildRanks()<9 then
										SetGuildMemberRank(i,6)
										if ranki+1>6 then
											ANNOUNCErank5promote=ANNOUNCErank5promote+1
										end
										if ranki+1<6 then
											ANNOUNCErankdemote=ANNOUNCErankdemote+1
										end
									end
								end
							end
						end
					end
				end
			end
		end
		if GuildManager.db.profile.rank6promote==true and level/GuildManager.db.profile.rank6level>=1 and GuildControlGetNumRanks()>7 and IsGuildRankAssignmentAllowed(ranki,7)==true and (ranki+1>7 or (ranki+1<7 and GuildManager.db.profile.demotemode==true and tContains(GuildManager.db.profile.GMDemoteExemptt, name)~=1)) then
			if level/GuildManager.db.profile.rank2level<1 or level/GuildManager.db.profile.rank2level>level/GuildManager.db.profile.rank6level or GuildManager.db.profile.rank2promote~=true then
				if level/GuildManager.db.profile.rank3level<1 or level/GuildManager.db.profile.rank3level>level/GuildManager.db.profile.rank6level or GuildManager.db.profile.rank3promote~=true then
					if level/GuildManager.db.profile.rank4level<1 or level/GuildManager.db.profile.rank4level>level/GuildManager.db.profile.rank6level or GuildManager.db.profile.rank4promote~=true then
						if level/GuildManager.db.profile.rank5level<1 or level/GuildManager.db.profile.rank5level>level/GuildManager.db.profile.rank6level or GuildManager.db.profile.rank5promote~=true then
							if level/GuildManager.db.profile.rank1level<1 or level/GuildManager.db.profile.rank1level>level/GuildManager.db.profile.rank6level or GuildManager.db.profile.rank1promote~=true then
								if level/GuildManager.db.profile.rank7level<1 or level/GuildManager.db.profile.rank7level>level/GuildManager.db.profile.rank6level or GuildManager.db.profile.rank7promote~=true or GuildControlGetNumGuildRanks()<8 then
									if level/GuildManager.db.profile.rank8level<1 or level/GuildManager.db.profile.rank8level>level/GuildManager.db.profile.rank6level or GuildManager.db.profile.rank8promote~=true or GuildControlGetNumGuildRanks()<9 then
										SetGuildMemberRank(i,7)
										if ranki+1>7 then
											ANNOUNCErank6promote=ANNOUNCErank6promote+1
										end
										if ranki+1<7 then
											ANNOUNCErankdemote=ANNOUNCErankdemote+1
										end
									end
								end
							end
						end
					end
				end
			end
		end
		if GuildManager.db.profile.rank7promote==true and level/GuildManager.db.profile.rank7level>=1 and GuildControlGetNumRanks()>8 and IsGuildRankAssignmentAllowed(ranki,8)==true and (ranki+1>8 or (ranki+1<8 and GuildManager.db.profile.demotemode==true and tContains(GuildManager.db.profile.GMDemoteExemptt, name)~=1)) then
			if level/GuildManager.db.profile.rank2level<1 or level/GuildManager.db.profile.rank2level>level/GuildManager.db.profile.rank7level or GuildManager.db.profile.rank2promote~=true then
				if level/GuildManager.db.profile.rank3level<1 or level/GuildManager.db.profile.rank3level>level/GuildManager.db.profile.rank7level or GuildManager.db.profile.rank3promote~=true then
					if level/GuildManager.db.profile.rank4level<1 or level/GuildManager.db.profile.rank4level>level/GuildManager.db.profile.rank7level or GuildManager.db.profile.rank4promote~=true then
						if level/GuildManager.db.profile.rank5level<1 or level/GuildManager.db.profile.rank5level>level/GuildManager.db.profile.rank7level or GuildManager.db.profile.rank5promote~=true then
							if level/GuildManager.db.profile.rank6level<1 or level/GuildManager.db.profile.rank6level>level/GuildManager.db.profile.rank7level or GuildManager.db.profile.rank6promote~=true then
								if level/GuildManager.db.profile.rank1level<1 or level/GuildManager.db.profile.rank1level>level/GuildManager.db.profile.rank7level or GuildManager.db.profile.rank1promote~=true then
									if level/GuildManager.db.profile.rank8level<1 or level/GuildManager.db.profile.rank8level>level/GuildManager.db.profile.rank7level or GuildManager.db.profile.rank8promote~=true or GuildControlGetNumGuildRanks()<9 then
										SetGuildMemberRank(i,8)
										if ranki+1>8 then
											ANNOUNCErank7promote=ANNOUNCErank7promote+1
										end
										if ranki+1<8 then
											ANNOUNCErankdemote=ANNOUNCErankdemote+1
										end
									end
								end
							end
						end
					end
				end
			end
		end
		if GuildManager.db.profile.rank8promote==true and level/GuildManager.db.profile.rank8level>=1 and GuildControlGetNumRanks()>9 and IsGuildRankAssignmentAllowed(ranki,9)==true and (ranki+1>9 or (ranki+1<9 and GuildManager.db.profile.demotemode==true and tContains(GuildManager.db.profile.GMDemoteExemptt, name)~=1)) then
			if level/GuildManager.db.profile.rank2level<1 or level/GuildManager.db.profile.rank2level>level/GuildManager.db.profile.rank8level or GuildManager.db.profile.rank2promote~=true then
				if level/GuildManager.db.profile.rank3level<1 or level/GuildManager.db.profile.rank3level>level/GuildManager.db.profile.rank8level or GuildManager.db.profile.rank3promote~=true then
					if level/GuildManager.db.profile.rank4level<1 or level/GuildManager.db.profile.rank4level>level/GuildManager.db.profile.rank8level or GuildManager.db.profile.rank4promote~=true then
						if level/GuildManager.db.profile.rank5level<1 or level/GuildManager.db.profile.rank5level>level/GuildManager.db.profile.rank8level or GuildManager.db.profile.rank5promote~=true then
							if level/GuildManager.db.profile.rank6level<1 or level/GuildManager.db.profile.rank6level>level/GuildManager.db.profile.rank8level or GuildManager.db.profile.rank6promote~=true then
								if level/GuildManager.db.profile.rank7level<1 or level/GuildManager.db.profile.rank7level>level/GuildManager.db.profile.rank8level or GuildManager.db.profile.rank7promote~=true then
									if level/GuildManager.db.profile.rank1level<1 or level/GuildManager.db.profile.rank1level>level/GuildManager.db.profile.rank8level or GuildManager.db.profile.rank1promote~=true then
										SetGuildMemberRank(i,9)
										if ranki+1>9 then
											ANNOUNCErank8promote=ANNOUNCErank8promote+1
										end
										if ranki+1<9 then
											ANNOUNCErankdemote=ANNOUNCErankdemote+1
										end
									end
								end
							end
						end
					end
				end
			end
		end
		if GuildControlGetNumRanks()==10 and ranki+1<10 and IsGuildRankAssignmentAllowed(ranki,10)==true and GuildManager.db.profile.demotemode==true and tContains(GuildManager.db.profile.GMDemoteExemptt, name)~=1 then
			if level/GuildManager.db.profile.rank1level<1 or GuildManager.db.profile.rank1promote~=true then
				if level/GuildManager.db.profile.rank2level<1 or GuildManager.db.profile.rank2promote~=true then
					if level/GuildManager.db.profile.rank3level<1 or GuildManager.db.profile.rank3promote~=true then
						if level/GuildManager.db.profile.rank4level<1 or GuildManager.db.profile.rank4promote~=true then
							if level/GuildManager.db.profile.rank5level<1 or GuildManager.db.profile.rank5promote~=true then
								if level/GuildManager.db.profile.rank6level<1 or GuildManager.db.profile.rank6promote~=true then
									if level/GuildManager.db.profile.rank7level<1 or GuildManager.db.profile.rank7promote~=true then
										if level/GuildManager.db.profile.rank8level<1 or GuildManager.db.profile.rank8promote~=true then
											SetGuildMemberRank(i,10)
											if ranki+1<10 then
												ANNOUNCErankdemote=ANNOUNCErankdemote+1
											end
										end
									end
								end
							end
						end
					end
				end
			end
		end
		if GuildControlGetNumRanks()==9 and ranki+1<9 and IsGuildRankAssignmentAllowed(ranki,9)==true and GuildManager.db.profile.demotemode==true and tContains(GuildManager.db.profile.GMDemoteExemptt, name)~=1 then
			if level/GuildManager.db.profile.rank1level<1 or GuildManager.db.profile.rank1promote~=true then
				if level/GuildManager.db.profile.rank2level<1 or GuildManager.db.profile.rank2promote~=true then
					if level/GuildManager.db.profile.rank3level<1 or GuildManager.db.profile.rank3promote~=true then
						if level/GuildManager.db.profile.rank4level<1 or GuildManager.db.profile.rank4promote~=true then
							if level/GuildManager.db.profile.rank5level<1 or GuildManager.db.profile.rank5promote~=true then
								if level/GuildManager.db.profile.rank6level<1 or GuildManager.db.profile.rank6promote~=true then
									if level/GuildManager.db.profile.rank7level<1 or GuildManager.db.profile.rank7promote~=true then
										SetGuildMemberRank(i,9)
										if ranki+1<9 then
											ANNOUNCErankdemote=ANNOUNCErankdemote+1
										end
									end
								end
							end
						end
					end
				end
			end
		end
		if GuildControlGetNumRanks()==8 and ranki+1<8 and IsGuildRankAssignmentAllowed(ranki,8)==true and GuildManager.db.profile.demotemode==true and tContains(GuildManager.db.profile.GMDemoteExemptt, name)~=1 then
			if level/GuildManager.db.profile.rank1level<1 or GuildManager.db.profile.rank1promote~=true then
				if level/GuildManager.db.profile.rank2level<1 or GuildManager.db.profile.rank2promote~=true then
					if level/GuildManager.db.profile.rank3level<1 or GuildManager.db.profile.rank3promote~=true then
						if level/GuildManager.db.profile.rank4level<1 or GuildManager.db.profile.rank4promote~=true then
							if level/GuildManager.db.profile.rank5level<1 or GuildManager.db.profile.rank5promote~=true then
								if level/GuildManager.db.profile.rank6level<1 or GuildManager.db.profile.rank6promote~=true then
									SetGuildMemberRank(i,8)
									if ranki+1<8 then
										ANNOUNCErankdemote=ANNOUNCErankdemote+1
									end
								end
							end
						end
					end
				end
			end
		end
		if GuildControlGetNumRanks()==7 and ranki+1<7 and IsGuildRankAssignmentAllowed(ranki,7)==true and GuildManager.db.profile.demotemode==true and tContains(GuildManager.db.profile.GMDemoteExemptt, name)~=1 then
			if level/GuildManager.db.profile.rank1level<1 or GuildManager.db.profile.rank1promote~=true then
				if level/GuildManager.db.profile.rank2level<1 or GuildManager.db.profile.rank2promote~=true then
					if level/GuildManager.db.profile.rank3level<1 or GuildManager.db.profile.rank3promote~=true then
						if level/GuildManager.db.profile.rank4level<1 or GuildManager.db.profile.rank4promote~=true then
							if level/GuildManager.db.profile.rank5level<1 or GuildManager.db.profile.rank5promote~=true then
								SetGuildMemberRank(i,7)
								if ranki+1<7 then
									ANNOUNCErankdemote=ANNOUNCErankdemote+1
								end
							end
						end
					end
				end
			end
		end
		if GuildControlGetNumRanks()==6 and ranki+1<6 and IsGuildRankAssignmentAllowed(ranki,6)==true and GuildManager.db.profile.demotemode==true and tContains(GuildManager.db.profile.GMDemoteExemptt, name)~=1 then
			if level/GuildManager.db.profile.rank1level<1 or GuildManager.db.profile.rank1promote~=true then
				if level/GuildManager.db.profile.rank2level<1 or GuildManager.db.profile.rank2promote~=true then
					if level/GuildManager.db.profile.rank3level<1 or GuildManager.db.profile.rank3promote~=true then
						if level/GuildManager.db.profile.rank4level<1 or GuildManager.db.profile.rank4promote~=true then
							SetGuildMemberRank(i,6)
							if ranki+1<6 then
								ANNOUNCErankdemote=ANNOUNCErankdemote+1
							end
						end
					end
				end
			end
		end
		if GuildControlGetNumRanks()==5 and ranki+1<5 and IsGuildRankAssignmentAllowed(ranki,5)==true and GuildManager.db.profile.demotemode==true and tContains(GuildManager.db.profile.GMDemoteExemptt, name)~=1 then
			if level/GuildManager.db.profile.rank1level<1 or GuildManager.db.profile.rank1promote~=true then
				if level/GuildManager.db.profile.rank2level<1 or GuildManager.db.profile.rank2promote~=true then
					if level/GuildManager.db.profile.rank3level<1 or GuildManager.db.profile.rank3promote~=true then
						SetGuildMemberRank(i,5)
						if ranki+1<5 then
							ANNOUNCErankdemote=ANNOUNCErankdemote+1
						end
					end
				end
			end
		end
		if GuildControlGetNumRanks()==4 and ranki+1<4 and IsGuildRankAssignmentAllowed(ranki,4)==true and GuildManager.db.profile.demotemode==true and tContains(GuildManager.db.profile.GMDemoteExemptt, name)~=1 then
			if level/GuildManager.db.profile.rank1level<1 or GuildManager.db.profile.rank1promote~=true then
				if level/GuildManager.db.profile.rank2level<1 or GuildManager.db.profile.rank2promote~=true then
					SetGuildMemberRank(i,4)
					if ranki+1<4 then
						ANNOUNCErankdemote=ANNOUNCErankdemote+1
					end
				end
			end
		end
		if GuildControlGetNumRanks()==3 and ranki+1<3 and IsGuildRankAssignmentAllowed(ranki,3)==true and GuildManager.db.profile.demotemode==true and tContains(GuildManager.db.profile.GMDemoteExemptt, name)~=1 then
			if level/GuildManager.db.profile.rank1level<1 or GuildManager.db.profile.rank1promote~=true then
				SetGuildMemberRank(i,3)
				if ranki+1<3 then
					ANNOUNCErankdemote=ANNOUNCErankdemote+1
				end
			end
		end
	end
end

function GuildManager:GMPromoteLevel()
    GuildRoster()
    if GPERROR~=1 then
        ANNOUNCErank1promote=0
        ANNOUNCErank2promote=0
        ANNOUNCErank3promote=0
        ANNOUNCErank3promote=0
        ANNOUNCErank4promote=0
        ANNOUNCErank5promote=0
        ANNOUNCErank6promote=0
        ANNOUNCErank7promote=0
        ANNOUNCErank8promote=0
        ANNOUNCErankdemote=0
        GuildRoster()

		countPromotions = 0;
		local totalGuildMembers = GetNumGuildMembers(true)

        for i=1,totalGuildMembers do local name,rankn,ranki,level = GetGuildRosterInfo(i);
			--print(strjoin(" ","Scheduling-PromoteLevel:", "for", name, "rankn:", rankn, "ranki:", ranki, "level:", level ))
            self:ScheduleTimer("DoGMPromoteLevel", 2, totalGuildMembers, i, name, rankn, ranki, level)
        end

        if GuildManager.db.profile.promoteannounce==3 then
            GuildManager:GMPromoteStatsGuildAnnounceLevel()
        end
        if GuildManager.db.profile.promoteannounce==2 then
            GuildManager:GMPromoteStatsOfficerAnnounceLevel()
        end
    else
        GuildManager:Print("ERROR! Multiple Active Ranks have EQUAL Level Requirements! Change your settings and try again.")
        if GuildManager.db.profile.automatepromote==true then
            GuildManager:Print("Disabling Automatic Promotions!")
            GuildManager.db.profile.automatepromote=false
        end
    end
end

function GuildManager:GMPromoteStatsGuildAnnounceLevel()
    if ANNOUNCErank1promote>0 then
        SendChatMessage(strjoin(" ",ANNOUNCErank1promote,"Members were promoted to",GuildControlGetRankName(2),"for reaching LEVEL",GuildManager.db.profile.rank1level,"!"),"guild", nil,"GUILD")
    end
    if ANNOUNCErank2promote>0 then
        SendChatMessage(strjoin(" ",ANNOUNCErank2promote,"Members were promoted to",GuildControlGetRankName(3),"for reaching LEVEL",GuildManager.db.profile.rank2level,"!"),"guild", nil,"GUILD")
    end
    if ANNOUNCErank3promote>0 then
        SendChatMessage(strjoin(" ",ANNOUNCErank3promote,"Members were promoted to",GuildControlGetRankName(4),"for reaching LEVEL",GuildManager.db.profile.rank3level,"!"),"guild", nil,"GUILD")
    end
    if ANNOUNCErank4promote>0 then
        SendChatMessage(strjoin(" ",ANNOUNCErank4promote,"Members were promoted to",GuildControlGetRankName(5),"for reaching LEVEL",GuildManager.db.profile.rank4level,"!"),"guild", nil,"GUILD")
    end
    if ANNOUNCErank5promote>0 then
        SendChatMessage(strjoin(" ",ANNOUNCErank5promote,"Members were promoted to",GuildControlGetRankName(6),"for reaching LEVEL",GuildManager.db.profile.rank5level,"!"),"guild", nil,"GUILD")
    end
    if ANNOUNCErank6promote>0 then
        SendChatMessage(strjoin(" ",ANNOUNCErank6promote,"Members were promoted to",GuildControlGetRankName(7),"for reaching LEVEL",GuildManager.db.profile.rank6level,"!"),"guild", nil,"GUILD")
    end
    if ANNOUNCErank7promote>0 then
        SendChatMessage(strjoin(" ",ANNOUNCErank7promote,"Members were promoted to",GuildControlGetRankName(8),"for reaching LEVEL",GuildManager.db.profile.rank7level,"!"),"guild", nil,"GUILD")
    end
    if ANNOUNCErank8promote>0 then
        SendChatMessage(strjoin(" ",ANNOUNCErank8promote,"Members were promoted to",GuildControlGetRankName(9),"for reaching LEVEL",GuildManager.db.profile.rank8level,"!"),"guild", nil,"GUILD")
    end
    if ANNOUNCErankdemote>0 then
        SendChatMessage(strjoin(" ",ANNOUNCErankdemote,"Members were demoted for having a Level that is LESS then the rank requires!"),"guild", nil,"GUILD")
    end
end

function GuildManager:GMPromoteStatsOfficerAnnounceLevel()
    if ANNOUNCErank1promote>0 then
        SendChatMessage(strjoin(" ",ANNOUNCErank1promote,"Members were promoted to",GuildControlGetRankName(2),"for reaching LEVEL",GuildManager.db.profile.rank1level,"!"),"officer", nil,"OFFICER")
    end
    if ANNOUNCErank2promote>0 then
        SendChatMessage(strjoin(" ",ANNOUNCErank2promote,"Members were promoted to",GuildControlGetRankName(3),"for reaching LEVEL",GuildManager.db.profile.rank2level,"!"),"officer", nil,"OFFICER")
    end
    if ANNOUNCErank3promote>0 then
        SendChatMessage(strjoin(" ",ANNOUNCErank3promote,"Members were promoted to",GuildControlGetRankName(4),"for reaching LEVEL",GuildManager.db.profile.rank3level,"!"),"officer", nil,"OFFICER")
    end
    if ANNOUNCErank4promote>0 then
        SendChatMessage(strjoin(" ",ANNOUNCErank4promote,"Members were promoted to",GuildControlGetRankName(5),"for reaching LEVEL",GuildManager.db.profile.rank4level,"!"),"officer", nil,"OFFICER")
    end
    if ANNOUNCErank5promote>0 then
        SendChatMessage(strjoin(" ",ANNOUNCErank5promote,"Members were promoted to",GuildControlGetRankName(6),"for reaching LEVEL",GuildManager.db.profile.rank5level,"!"),"officer", nil,"OFFICER")
    end
    if ANNOUNCErank6promote>0 then
        SendChatMessage(strjoin(" ",ANNOUNCErank6promote,"Members were promoted to",GuildControlGetRankName(7),"for reaching LEVEL",GuildManager.db.profile.rank6level,"!"),"officer", nil,"OFFICER")
    end
    if ANNOUNCErank7promote>0 then
        SendChatMessage(strjoin(" ",ANNOUNCErank7promote,"Members were promoted to",GuildControlGetRankName(8),"for reaching LEVEL",GuildManager.db.profile.rank7level,"!"),"officer", nil,"OFFICER")
    end
    if ANNOUNCErank8promote>0 then
        SendChatMessage(strjoin(" ",ANNOUNCErank8promote,"Members were promoted to",GuildControlGetRankName(9),"for reaching LEVEL",GuildManager.db.profile.rank8level,"!"),"officer", nil,"OFFICER")
    end
    if ANNOUNCErankdemote>0 then
        SendChatMessage(strjoin(" ",ANNOUNCErankdemote,"Members were demoted for having a Level that is LESS then the rank requires!"),"officer", nil,"OFFICER")
    end
end