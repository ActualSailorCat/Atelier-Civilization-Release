--///////////////////////////////////////////////////////
--///////////////////////////////////////////////////////
-- Totori Leader Scripts
--///////////////////////////////////////////////////////
--///////////////////////////////////////////////////////
--///////////////////////////////////////////////////////
-- Eureka on Continent Discovery Supplemental by SeelingCat & SailorCat
--///////////////////////////////////////////////////////
function Sailor_Totori_Adventurer_Supplemental(playerID, pPlayer, plot, pCapital)
	local sContinentType = plot:GetContinentType()
	ContinentCheck = Game:GetProperty(playerID .. "TotoriContinent" ..sContinentType)
	if ContinentCheck ~= nil and sContinentType ~= -1 then
	else
		if pCapital ~= nil then
			local iCapitalX, iCapitalY	= pCapital:GetX(), pCapital:GetY()
			local pCapitalPlot			= Map.GetPlot(iCapitalX,iCapitalY)
			local sCapitalContinent		= pCapitalPlot:GetContinentType()
			if sContinentType == -1 then
				Game:SetProperty(playerID .. "TotoriContinent" .. sContinentType, 1)
			elseif sCapitalContinent == sContinentType then	
				Game:SetProperty(playerID .. "TotoriContinent" .. sContinentType, 1)
			else
				Game:SetProperty(playerID .. "TotoriContinent" .. sContinentType, 1)
				-- // Validating Techs...
				local tTechList		= {}
				local pPlayerTechs	= pPlayer:GetTechs()
				local pPlayerEras	= pPlayer:GetEras()
				local iEra			= pPlayerEras:GetEra()
				local pEraType		= GameInfo.Eras[iEra].EraType
				for i, tRow in ipairs(DB.Query("SELECT TechnologyType FROM Technologies WHERE TechnologyType IN (SELECT TechnologyType FROM Boosts) AND EraType = '" .. pEraType .. "'")) do
					local tQueryTech = GameInfo.Technologies[tRow.TechnologyType].Index
					if not pPlayerTechs:HasTech(tQueryTech) and not pPlayerTechs:HasBoostBeenTriggered(tQueryTech) then
						table.insert(tTechList, tRow)
					else
					end
				end
				-- // Rolling Techs...
				if next(tTechList) ~= nil then
					local dTech = TerrainBuilder.GetRandomNumber(#tTechList-1, "Totori Tech Roller")+1
					for i, _Tech in ipairs(tTechList) do
						if i == dTech then
							local _TechRolled = _Tech.TechnologyType
							print("//// Random Eureka gained: ", _TechRolled)
							local iTech = GameInfo.Technologies[_TechRolled].Index
							pPlayerTechs:TriggerBoost(iTech, 1)
							return true
						end
					end
				end
			end
		end
		return false
	end
end
--///////////////////////////////////////////////////////
-- Eureka on Continent Discovery Main by SeelingCat & SailorCat
--///////////////////////////////////////////////////////
function Sailor_Totori_Adventurer()
	local bTOTORILeader = false
	local playerID		= 0
	for k, v in ipairs(PlayerManager.GetAliveIDs()) do
		if bTOTORILeader == false then
			local sLeaderType = PlayerConfigurations[v]:GetLeaderTypeName()
			if sLeaderType == 'LEADER_SAILOR_TOTORI' then
				bTOTORILeader	= true
				playerID		= v
			end
		end
	end

	if bTOTORILeader == true then
		local pPlayer		= Players[playerID]
		local pPlayerUnits	= pPlayer:GetUnits()
		local sUnits		= {}
		local pPlayerCities	= pPlayer:GetCities()
		local pCapital		= pPlayerCities:GetCapitalCity()
		for i, pUnit in pPlayerUnits:Members() do
			table.insert(sUnits, pUnit)
		end
		for k, pUnit in ipairs(sUnits) do
			local sUnitType         = UnitManager.GetTypeName(pUnit)
			local iUnitX, iUnitY    = pUnit:GetX(), pUnit:GetY()
			local _Plot				= Map.GetPlot(iUnitX, iUnitY)
			local foundContinent	= false
			if _Plot then
				foundContinent = Sailor_Totori_Adventurer_Supplemental(playerID, pPlayer, _Plot, pCapital)
				--if foundContinent == false then
					for direction = 0, DirectionTypes.NUM_DIRECTION_TYPES - 1, 1 do
						local pAdjacentPlot = Map.GetAdjacentPlot(iUnitX, iUnitY, direction)
						if pAdjacentPlot then
							foundContinent = Sailor_Totori_Adventurer_Supplemental(playerID, pPlayer, pAdjacentPlot, pCapital)
							--if foundContinent == true then break end
						end
					end
				--end
			end
		end
	end
end
--///////////////////////////////////////////////////////
-- Leader Present Detection by SeelingCat
--///////////////////////////////////////////////////////
local bTotoriPresent = false

for k, v in ipairs(PlayerManager.GetWasEverAliveIDs()) do
    if bTotoriPresent == false then
        local sLeaderType = PlayerConfigurations[v]:GetLeaderTypeName()
        if sLeaderType == 'LEADER_SAILOR_TOTORI' then
			bTotoriPresent = true
        end
    end
end
if bTotoriPresent == true then
    print ("///// Totori detected. Loading lua functions...")
	Events.LocalPlayerTurnBegin.Add(Sailor_Totori_Adventurer)
else
    print ("///// Totori not detected.")
end