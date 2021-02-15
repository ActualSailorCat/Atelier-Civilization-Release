--///////////////////////////////////////////////////////
--///////////////////////////////////////////////////////
-- Atleer Civ / Scripts
--///////////////////////////////////////////////////////
--///////////////////////////////////////////////////////
--ExposedMembers.GameEvents = GameEvents
--[[function Sailor_Atleer_Focus (iTileX, iTileY)
	GameEvents.Sailor_Atleer_Random_Resource.Call(iTileX, iTileY)
end]]--


--///////////////////////////////////////////////////////
-- GetCityPlots by Chrisy15 & SailorCat
--///////////////////////////////////////////////////////
function Atleer_GetCityPlots(pCity)
	local iCityRadius = 5
	local tTempTable = {}
	if pCity ~= nil then
		local iCityOwner = pCity:GetOwner()
		local iCityX, iCityY = pCity:GetX(), pCity:GetY()
		for dx = (iCityRadius * -1), iCityRadius do
			for dy = (iCityRadius * -1), iCityRadius do
				local pPlotNearCity = Map.GetPlotXYWithRangeCheck(iCityX, iCityY, dx, dy, iCityRadius);
				if pPlotNearCity and (pPlotNearCity:GetOwner() == iCityOwner) and (pCity == Cities.GetPlotPurchaseCity(pPlotNearCity:GetIndex())) then
					if pPlotNearCity:GetFeatureType() > -1 then
						local pPlotFeatureIndex = pPlotNearCity:GetFeatureType()
						local pPlotFeatureType = GameInfo.Features[pPlotFeatureIndex].FeatureType
					end
					if (not pPlotNearCity:IsMountain()) and (pPlotFeatureType ~= "FEATURE_GEOTHERMAL_FISSURE") and (pPlotNearCity:GetResourceType() == -1) and (not pPlotNearCity:IsNaturalWonder()) then
						table.insert(tTempTable, pPlotNearCity)
					end
				end
			end
		end
	end
	return tTempTable
end

--///////////////////////////////////////////////////////
-- Randomly Spawn Random Resource on Eureka by SailorCat
--///////////////////////////////////////////////////////
function Sailor_Atleer_Random_Resource(playerID, PlotX, PlotY, resourceID, cityID)
	local bAtleerCiv = false
	local pPlayerConfig = PlayerConfigurations[playerID]
	local sCivilization = pPlayerConfig:GetCivilizationTypeName()
	if sCivilization == 'CIVILIZATION_SAILOR_ATLEER' then
		bAtleerCiv = true
	end

	if bAtleerCiv == true then
		local pPlayer = Players[playerID]
		local tValidTiles = {}
		local pPlayerCities = pPlayer:GetCities()

		-- // Rolling city...
		local iNumberofCities = 0
		local tCities = {}
		for k, v in pPlayerCities:Members() do
			tCities[k] = v
			iNumberofCities = iNumberofCities + 1
		end
		local rollResolved = false
		while iNumberofCities > 0 and rollResolved == false do
			iRandom = TerrainBuilder.GetRandomNumber(iNumberofCities, "Atleer City Roller")+1
			for i, pIterCity in ipairs(tCities) do
				if i == iRandom then
					local pCityLoc = pIterCity:GetName()
					local iIteration = i
					print("//// ", Locale.Lookup(pCityLoc), "rolls the resource die!")

					-- // Rolling tiles...
					local pCityPlots = Atleer_GetCityPlots(pIterCity)
					local iNumberofTiles = 0
					for i, pTile in ipairs(pCityPlots) do
						iNumberofTiles = iNumberofTiles + 1
					end

					if iNumberofTiles > 0 then
						iRandom2 = TerrainBuilder.GetRandomNumber(iNumberofTiles, "Atleer Tile Roller")+1
						for i, pTile in ipairs(pCityPlots) do
							if i == iRandom2 then

								-- // Validating resources...
								local tValidResources = {}
								local pTileIndex = pTile:GetTerrainType()
								local pTileTerrainType = GameInfo.Terrains[pTileIndex].TerrainType

								-- // Resource tech check...
								local pPlayerTechs = pPlayer:GetTechs()
								local tResTechList = {}
								for i, pRow in ipairs(DB.Query("SELECT TechnologyType FROM Technologies WHERE TechnologyType IN (SELECT PrereqTech FROM Resources WHERE PrereqTech IS NOT NULL AND PrereqTech != 'TECH_ANIMAL_HUSBANDRY')")) do
									tResTechList[i] = pRow.TechnologyType
								end
								local tResTechValid = "'TECH_ANIMAL_HUSBANDRY', "

								for i, pTech in ipairs(tResTechList) do
									if pPlayerTechs:HasTech(GameInfo.Technologies[pTech].Index) then
										tResTechValid = tResTechValid .. "'" .. pTech .. "', "
									end
								end

								-- // Gathering resources...
								for i, tRow in ipairs(DB.Query("SELECT ResourceType FROM Resources WHERE (Frequency > 0 OR SeaFrequency > 0) AND (ResourceType IN (SELECT ResourceType from Resource_ValidTerrains WHERE TerrainType = '" .. pTileTerrainType .. "')) AND (ResourceType IN (SELECT ResourceType FROM Resources WHERE PrereqTech IS NULL) OR ResourceType IN (SELECT ResourceType FROM Resources WHERE PrereqTech IN (" .. tResTechValid:sub(1,-3) .. ")))")) do
									tValidResources[i] = tRow
								end

								-- // Rolling resources...
								local iNumberofResources = 0
								for i, pResource in ipairs(tValidResources) do
									iNumberofResources = iNumberofResources + 1
								end

								if iNumberofResources > 0 then
									iRandom3 = TerrainBuilder.GetRandomNumber(iNumberofResources-1, "Atleer Resource Roller")+1
									for i, pResource in ipairs(tValidResources) do
										if i == iRandom3 then
											local pResourceRolled = pResource.ResourceType
											print("//// Random resource is: ", pResourceRolled)
											local iResource = GameInfo.Resources[pResourceRolled].Index
										
											-- // Placing resource...
											iRandom4 = TerrainBuilder.GetRandomNumber(100, "d100")
											print("//// d100 Roll = ", iRandom4)
											if iRandom4 < 13 then
												ResourceBuilder.SetResourceType(pTile, iResource, 1)
												if pPlayer:IsHuman() then
													Game.AddWorldViewText(playerID, Locale.Lookup("[COLOR_LIGHTBLUE]Resource Synthesized![ENDCOLOR]"), pTile:GetX(), pTile:GetY(), 0)
													local iTileX, iTileY = pTile:GetX(), pTile:GetY()
													--Sailor_Atleer_Focus(iTileX, iTileY)
													-- // Notification
													local iAtleerNotifType = NotificationTypes.USER_DEFINED_5
													local sAtleerNotifText = Locale.Lookup("Alchemical synthesis activated!")
													local pResourceStr = Locale.Lookup(GameInfo.Resources[iResource].Name)
													local pCityStr = Locale.Lookup(pCityLoc)
													local iNotifDesc = "A source of " .. pResourceStr .. " has been synthesized in the cauldrons of " .. pCityStr .. "."
													NotificationManager.SendNotification(playerID, iAtleerNotifType, sAtleerNotifText, iNotifDesc, iTileX, iTileY);
												end
											end
											rollResolved = true
										end
									end
								end
							end
						end
					else
						iNumberofCities = iNumberofCities - 1
						table.remove(tCities, iIteration)
						break
					end
				end
			end
		end
	end
end

--=============================================
-- Civilization Present Detection by SeelingCat
--=============================================
local bAtleerPresent = false

for k, v in ipairs(PlayerManager.GetWasEverAliveIDs()) do
    if bAtleerPresent == false then
        local sCivType = PlayerConfigurations[v]:GetCivilizationTypeName()
        if sCivType == 'CIVILIZATION_SAILOR_ATLEER' then
			bAtleerPresent = true
        end
    end
end
if bAtleerPresent == true then
    print ("//// Atleer detected. Loading lua functions...")
	Events.TechBoostTriggered.Add(Sailor_Atleer_Random_Resource)
	Events.CivicBoostTriggered.Add(Sailor_Atleer_Random_Resource)
else
    print ("//// Atleer not detected.")
end