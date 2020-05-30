--==========================================================================================================================
-- Continent Boosts by SeelingCat and SailorCat
--==========================================================================================================================
function Sailor_Totori_Adventurer (playerID, unitID, iX, iY, locallyVisible, stateChange, pPlayerTechs, iEra)
	local bTotoriLeader = false
	local pPlayerConfig = PlayerConfigurations[playerID]
	local sLeader = pPlayerConfig:GetLeaderTypeName()
	--print(sLeader)
	if sLeader == 'LEADER_SAILOR_TOTORI' then
		bTotoriLeader = true
	end

	if bTotoriLeader == true then
		--print("Is Totori!")
		local pPlayer = Players[playerID]
		local pPlayerUnits = pPlayer:GetUnits()
		local pUnit = pPlayerUnits:FindID(unitID)

		if pUnit then
			sUnitType = UnitManager.GetTypeName(pUnit)
			--print(sUnitType)

			local iUnitX, iUnitY = pUnit:GetX(), pUnit:GetY()
			for direction = 0, DirectionTypes.NUM_DIRECTION_TYPES - 1, 1 do
				local pAdjacentPlot = Map.GetAdjacentPlot(iUnitX, iUnitY, direction)
				if pAdjacentPlot then
					local sContinentType = pAdjacentPlot:GetContinentType()
					--print(sContinentType)
					ContinentCheck = Game:GetProperty(playerID .. "TotoriContinent" ..sContinentType)

					if ContinentCheck ~= nil and sContinentType ~= -1 then
					--print ("already claimed this continent!")
					else
						local pPlayerCities = pPlayer:GetCities()
						local pCapital = pPlayerCities:GetCapitalCity()
						if pCapital ~= nil then
						local iCapitalX, iCapitalY = pCapital:GetX(), pCapital:GetY()
						local pCapitalPlot = Map.GetPlot(iCapitalX,iCapitalY)
						local sCapitalContinent = pCapitalPlot:GetContinentType()

						if sContinentType == -1 then
							--print ("this is not a continent!")
							Game:SetProperty(playerID .. "TotoriContinent" .. sContinentType, 1)
						elseif sCapitalContinent == sContinentType then	
							--print ("this your capital continent, silly!")
							Game:SetProperty(playerID .. "TotoriContinent" .. sContinentType, 1)
						else
							Game:SetProperty(playerID .. "TotoriContinent" .. sContinentType, 1)
							-- / Validating Techs...
							local tTechList = {}
							local pPlayerTechs = pPlayer:GetTechs()
							local pPlayerEras = pPlayer:GetEras()
							local iEra = pPlayerEras:GetEra()
							--print("iEra", iEra)
							local pEraType = GameInfo.Eras[iEra].EraType
							--print("pEraType :", pEraType)
							for i, tRow in ipairs(DB.Query("SELECT TechnologyType FROM Technologies WHERE TechnologyType IN (SELECT TechnologyType FROM Boosts) AND EraType = '" .. pEraType .. "'")) do
								local tQueryTech = GameInfo.Technologies[tRow.TechnologyType].Index
								if not pPlayerTechs:HasTech(tQueryTech) and not pPlayerTechs:HasBoostBeenTriggered(tQueryTech) then
								--print(tRow.TechnologyType)
								tTechList[i] = tRow
								else --print(tRow.TechnologyType, " removed.")
								end
							end
								--print("Techs gathered.")

							-- / Rolling Techs...
							local iNumberofTechs = 0
							for i, pTech in ipairs(tTechList) do
							iNumberofTechs = iNumberofTechs + 1
							end
							--print("Techs : ", iNumberofTechs)

							if iNumberofTechs > 0 then
								iRandomTech = TerrainBuilder.GetRandomNumber(iNumberofTechs-1, "Totori Tech Roller")+1
								--print ("random tech number is : ", iRandomTech)
								for i, pTech in ipairs(tTechList) do
									if i == iRandomTech then
									local pTechRolled = pTech.TechnologyType
									print("//// Random Eureka gained: ", pTechRolled)
									local iTech = GameInfo.Technologies[pTechRolled].Index
									pPlayerTechs:TriggerBoost(iTech, 1)
									end
								end
							end
						end
						end
					end
				else
					--print ("no plot somehow?")
				end
			end
		else
			--print ("no unit?")
		end
	end
end
--=============================================
-- Leader Present Detection by SeelingCat
--=============================================
local bTotoriPresent = false

for k, v in ipairs(PlayerManager.GetWasEverAliveIDs()) do
    if bTotoriPresent == false then
        local sLeaderType = PlayerConfigurations[v]:GetLeaderTypeName()
        if sLeaderType == 'LEADER_SAILOR_TOTORI' then
			--print (sLeaderType)
			bTotoriPresent = true
        end
    end
end
if bTotoriPresent == true then
    print ("///// Totori detected. Loading lua functions...")
	Events.UnitMoved.Add(Sailor_Totori_Adventurer)
else
    print ("///// Totori not detected.")
end