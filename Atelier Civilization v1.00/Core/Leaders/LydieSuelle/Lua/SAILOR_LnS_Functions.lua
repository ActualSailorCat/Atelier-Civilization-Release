--=============================================
-- Lydie & Suelle / Scripts
--=============================================
--=============================================
-- Great Artist Inspiration
--=============================================
function Sailor_LNS_ArtistInspiration (playerID, unitID, greatPersonClassID, greatPersonIndividualID, pPlayerCivics, iEra)
	local bLNSLeader = false
	local pPlayerConfig = PlayerConfigurations[playerID]
	local sLeader = pPlayerConfig:GetLeaderTypeName()
	--print(sLeader)
	if sLeader == 'LEADER_SAILOR_LNS' then
		bLNSLeader = true
	end

	if bLNSLeader == true then
		--print("Is LNS!")
		-- / Gathering Civics...
		local pPlayer = Players[playerID]
		local tCivicList = {}
		local pPlayerCivics = pPlayer:GetCulture()
		local pPlayerEras = pPlayer:GetEras()
		local iEra = pPlayerEras:GetEra()
		--print("iEra", iEra)
		local pEraType = GameInfo.Eras[iEra].EraType
		local pEraTypeNext = GameInfo.Eras[iEra].EraType
			if iEra ~= 8 then
				pEraTypeNext = GameInfo.Eras[(iEra + 1)].EraType
			end
		--print("pEraType :", pEraType)
		--print("pEraTypeNext :", pEraTypeNext)
		for i, tRow in ipairs(DB.Query("SELECT CivicType FROM Civics WHERE CivicType IN (SELECT CivicType FROM Boosts) AND (EraType = '" .. pEraType .. "' OR EraType = '" .. pEraTypeNext .. "')")) do
			local tQueryCivic = GameInfo.Civics[tRow.CivicType].Index
			if not pPlayerCivics:HasCivic(tQueryCivic) and not pPlayerCivics:HasBoostBeenTriggered(tQueryCivic) then
			--print(tRow.CivicType)
			tCivicList[i] = tRow
			else --print(tRow.CivicType, " removed.")
			end
		end
		--print("Civics gathered.")

		-- / Rolling Civics...
		local iNumberofCivics = 0
		for i, pCivic in ipairs(tCivicList) do
			iNumberofCivics = iNumberofCivics + 1
		end
		--print("Civics : ", iNumberofCivics)
		if iNumberofCivics > 0 then
			iRandomCivic = TerrainBuilder.GetRandomNumber(iNumberofCivics-1, "LNS Civic Roller")+1
			--print ("random civic number is : ", iRandomCivic)
			for i, pCivic in ipairs(tCivicList) do
				if i == iRandomCivic then
				local pCivicRolled = pCivic.CivicType
				--print("random civic is: ", pCivicRolled)
				local iCivic = GameInfo.Civics[pCivicRolled].Index
				pPlayerCivics:TriggerBoost(iCivic, 1)
				end
			end
		end
	end
end

--=============================================
-- Atleer Improvement GPP
--=============================================
-----------------------------------------------
-- GetCityPlots by Chrisy15 & SailorCat
-----------------------------------------------
function Sailor_LNS_AtelierGPP (playerID, improvementID, improvementX, improvementY, iImprovementType, PlotX, PlotY, cityID)
	local bLNSLeader = false
	local pPlayerConfig = PlayerConfigurations[playerID]
	local sLeader = pPlayerConfig:GetLeaderTypeName()
	--print(sLeader)
	if sLeader == 'LEADER_SAILOR_LNS' then
		bLNSLeader = true
	end

	if bLNSLeader == true then
	local pPlayer = Players[playerID]
	local pPlayerCities = pPlayer:GetCities()
	local iCityRadius = 5
		for i, pCityIterate in pPlayerCities:Members() do
			if pCityIterate ~= nil then
			--print("pCityIterate: ", pCityIterate)
				local iCityOwner = pCityIterate:GetOwner()
				--print("iCityOwner :", iCityOwner)
				local iCityX, iCityY = pCityIterate:GetX(), pCityIterate:GetY()
				--print("iCityX, iCityY: ", iCityX, iCityY)
				for dx = (iCityRadius * -1), iCityRadius do
					--print("dx City Radius")
					for dy = (iCityRadius * -1), iCityRadius do
					--print("dy City Radius")
					local pPlotNearCity = Map.GetPlotXYWithRangeCheck(iCityX, iCityY, dx, dy, iCityRadius);
						if pPlotNearCity and (pPlotNearCity:GetOwner() == iCityOwner) and (pCityIterate == Cities.GetPlotPurchaseCity(pPlotNearCity:GetIndex())) and (pPlotNearCity:GetImprovementType() > -1) then
						--print("2")
						local pPlotImprovementIndex = pPlotNearCity:GetImprovementType()
						local pPlotImprovementType = GameInfo.Improvements[pPlotImprovementIndex].ImprovementType
							if pPlotImprovementType == "IMPROVEMENT_SAILOR_ATLEER_UI" then
								--print("Is Atelier improvement!")
								local iNumberAdjResources = 0
								for direction = 0, DirectionTypes.NUM_DIRECTION_TYPES - 1, 1 do
									local pAdjacentPlot = Map.GetAdjacentPlot(pPlotNearCity:GetX(), pPlotNearCity:GetY(), direction);
									if pAdjacentPlot then
										--print("pAdjacentPlot: ", pAdjacentPlot)
										local iResource = pAdjacentPlot:GetResourceType()
										--print(iResource)
										if iResource > -1 then -- Need to account for hidden improvements
											--print("4")
											iNumberAdjResources = iNumberAdjResources + 1
											--print("4 iNumberAdjResources: ", iNumberAdjResources)
										end
									end
								end
								--print("iNumberAdjResources : ", iNumberAdjResources)
								-- / Granting GPP...
								if iNumberAdjResources > 2 then
									local pGPP = 1
									local pPlayerGP = pPlayer:GetGreatPeoplePoints()
									--print("Adding GPP!")
									local pGreatArtist = GameInfo.GreatPersonClasses["GREAT_PERSON_CLASS_ARTIST"].Index
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
--=============================================
-- Leader Present Detection by SeelingCat
--=============================================
local bLNSPresent = false

for k, v in ipairs(PlayerManager.GetWasEverAliveIDs()) do
    if bLNSPresent == false then
        local sLeaderType = PlayerConfigurations[v]:GetLeaderTypeName()
        if sLeaderType == 'LEADER_SAILOR_LNS' then
			--print (sLeaderType)
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