--///////////////////////////////////////////////////////
--///////////////////////////////////////////////////////
-- Lydie & Suelle Leader Scripts
--///////////////////////////////////////////////////////
--///////////////////////////////////////////////////////
--///////////////////////////////////////////////////////
-- Inspiration on Great Artist
--///////////////////////////////////////////////////////
function Sailor_LNS_ArtistInspiration (playerID, unitID, greatPersonClassID, greatPersonIndividualID, pPlayerCivics, iEra)
	local bLNSLeader = false
	local pPlayerConfig = PlayerConfigurations[playerID]
	local sLeader = pPlayerConfig:GetLeaderTypeName()
	if sLeader == 'LEADER_SAILOR_LNS' then
		bLNSLeader = true
	end

	if bLNSLeader == true then
		-- // Gathering Civics...
		local pPlayer		= Players[playerID]
		local pUnit			= pPlayer:GetUnits():FindID(unitID)
		local pGreatArtist	= GameInfo.Units["UNIT_GREAT_ARTIST"].Index
		if pUnit:GetType() == pGreatArtist then
			local tCivicList	= {}
			local pPlayerCivics = pPlayer:GetCulture()
			local pPlayerEras	= pPlayer:GetEras()
			local iEra			= pPlayerEras:GetEra()
			local pEraType		= GameInfo.Eras[iEra].EraType
			local pEraTypeNext	= GameInfo.Eras[iEra].EraType
			if iEra ~= 8 then
				pEraTypeNext = GameInfo.Eras[(iEra + 1)].EraType
			end
			for i, tRow in ipairs(DB.Query("SELECT CivicType FROM Civics WHERE CivicType IN (SELECT CivicType FROM Boosts) AND (EraType = '" .. pEraType .. "' OR EraType = '" .. pEraTypeNext .. "')")) do
				if not pPlayerCivics:HasCivic(GameInfo.Civics[tRow.CivicType].Index) and not pPlayerCivics:HasBoostBeenTriggered(GameInfo.Civics[tRow.CivicType].Index) then
					table.insert(tCivicList, tRow)
				end
			end
			-- // Rolling Civics...
			if next(tCivicList) ~= nil then
				local dCivic = TerrainBuilder.GetRandomNumber(#tCivicList-1, "LNS Civic Roller")+1
				local _Civic = tCivicList[dCivic]
				local _CivicIndex = GameInfo.Civics[_Civic.CivicType].Index
				pPlayerCivics:TriggerBoost(_CivicIndex, 1)
				print("//// Civic", _Civic.CivicType, "boosted!")
			end
		end
	end
end

--///////////////////////////////////////////////////////
-- Atelier Improvement GPP
--///////////////////////////////////////////////////////
function Sailor_LNS_AtelierGPP (playerID, improvementID, improvementX, improvementY, iImprovementType, PlotX, PlotY, cityID)
	local bLNSLeader	= false
	local pPlayerConfig = PlayerConfigurations[playerID]
	local sLeader		= pPlayerConfig:GetLeaderTypeName()
	if sLeader == 'LEADER_SAILOR_LNS' then
		bLNSLeader = true
	end

	if bLNSLeader == true then
	    local pPlayer       = Players[playerID]
	    local pPlayerCities = pPlayer:GetCities()
        local pPlayerTechs  = pPlayer:GetTechs()
        local pPlayerGP     = pPlayer:GetGreatPeoplePoints()
        local pGreatArtist  = GameInfo.GreatPersonClasses["GREAT_PERSON_CLASS_ARTIST"].Index
        local pGPP          = 1
		local iCityRadius	= 5
        -- // Checking for atelier, then adj. resources...
		for i, pCityIterate in pPlayerCities:Members() do
			if pCityIterate ~= nil then
				local iCityOwner = pCityIterate:GetOwner()
				local iCityX, iCityY = pCityIterate:GetX(), pCityIterate:GetY()
				for dx = (iCityRadius * -1), iCityRadius do
					for dy = (iCityRadius * -1), iCityRadius do
					local pPlotNearCity = Map.GetPlotXYWithRangeCheck(iCityX, iCityY, dx, dy, iCityRadius);
						if pPlotNearCity and (pPlotNearCity:GetOwner() == iCityOwner) and (pCityIterate == Cities.GetPlotPurchaseCity(pPlotNearCity:GetIndex())) and (pPlotNearCity:GetImprovementType() > -1) then
							local pPlotImprovementType = GameInfo.Improvements[pPlotNearCity:GetImprovementType()].ImprovementType
							if pPlotImprovementType == "IMPROVEMENT_SAILOR_ATLEER_UI" then
								local iNumberAdjResources = 0
								for direction = 0, DirectionTypes.NUM_DIRECTION_TYPES - 1, 1 do
									local pAdjacentPlot = Map.GetAdjacentPlot(pPlotNearCity:GetX(), pPlotNearCity:GetY(), direction);
									if pAdjacentPlot then
										local iResource = pAdjacentPlot:GetResourceType()
										if iResource > -1 then
											iNumberAdjResources = iNumberAdjResources + 1
										end
									end
								end
								-- // Granting GPP...
								if iNumberAdjResources > 2 then
									pPlayerGP:ChangePointsTotal(pGreatArtist, pGPP)
									if pPlayer:IsHuman() then
										Game.AddWorldViewText(playerID, Locale.Lookup("+1 [ICON_GreatArtist]"), pPlotNearCity:GetX(), pPlotNearCity:GetY(), 0)
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
--///////////////////////////////////////////////////////
-- Leader Present Detection by SeelingCat
--///////////////////////////////////////////////////////
local bLNSPresent = false
for k, v in ipairs(PlayerManager.GetWasEverAliveIDs()) do
    if bLNSPresent == false then
        local sLeaderType = PlayerConfigurations[v]:GetLeaderTypeName()
        if sLeaderType == 'LEADER_SAILOR_LNS' then
			bLNSPresent = true
        end
    end
end

if bLNSPresent == true then
    print ("///// Lydie & Suelle detected. Loading lua functions...")
	Events.UnitGreatPersonCreated.Add(Sailor_LNS_ArtistInspiration)
	GameEvents.PlayerTurnStarted.Add(Sailor_LNS_AtelierGPP)
else
    print ("///// Lydie & Suelle not detected.")
end