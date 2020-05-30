--=============================================
-- Atleer Civ / Scripts
--=============================================
-----------------------------------------------
-- GetCityPlots by Chrisy15 & SailorCat
-----------------------------------------------
local iCityRadius = 5
function GetPityClots(pCity)
	local tTempTable = {}
	if pCity ~= nil then
		local iCityOwner = pCity:GetOwner()
		local iCityX, iCityY = pCity:GetX(), pCity:GetY()
		for dx = (iCityRadius * -1), iCityRadius do
			for dy = (iCityRadius * -1), iCityRadius do
				local pPlotNearCity = Map.GetPlotXYWithRangeCheck(iCityX, iCityY, dx, dy, iCityRadius);
				if pPlotNearCity and (pPlotNearCity:GetOwner() == iCityOwner) and (pCity == Cities.GetPlotPurchaseCity(pPlotNearCity:GetIndex())) then
					local pPlotTerrainIndex = pPlotNearCity:GetTerrainType()
					local pPlotTerrainType = GameInfo.Terrains[pPlotTerrainIndex].TerrainType
					if pPlotNearCity:GetFeatureType() > -1 then
						local pPlotFeatureIndex = pPlotNearCity:GetFeatureType()
						local pPlotFeatureType = GameInfo.Features[pPlotFeatureIndex].FeatureType
					end
					if pPlotTerrainType ~= "TERRAIN_PLAINS_MOUNTAIN"
						and (pPlotTerrainType ~= "TERRAIN_PLAINS_MOUNTAIN")
						and (pPlotTerrainType ~= "TERRAIN_DESERT_MOUNTAIN")
						and (pPlotTerrainType ~= "TERRAIN_TUNDRA_MOUNTAIN")
						and (pPlotTerrainType ~= "TERRAIN_SNOW_MOUNTAIN")
						and (pPlotTerrainType ~= "TERRAIN_GRASS_MOUNTAIN")
						and (pPlotFeatureType ~= "FEATURE_GEOTHERMAL_FISSURE")
						and (pPlotNearCity:GetResourceType() == -1)
						and (pPlotNearCity:IsNaturalWonder() == false) then
						table.insert(tTempTable, pPlotNearCity)
					end
				end
			end
		end
	end
	return tTempTable
end

--=============================================
-- Randomly Spawn Random Resource on Eureka by SailorCat
--=============================================
function Sailor_Atleer_Random_Resource(playerID, PlotX, PlotY, resourceID, cityID)
	local bAtleerCiv = false
	local pPlayerConfig = PlayerConfigurations[playerID]
	local sCivilization = pPlayerConfig:GetCivilizationTypeName()
	--print(sCivilization)
	if sCivilization == 'CIVILIZATION_SAILOR_ATLEER' then
		bAtleerCiv = true
	end

	if bAtleerCiv == true then
	local pPlayer = Players[playerID]
	--print("Civ is Atleer.")
		local tValidTiles = {}
		local pPlayerCities = pPlayer:GetCities()

		-- / Rolling city...
		local iNumberofCities = 0
		for i, pIterCity in pPlayerCities:Members() do
			iNumberofCities = iNumberofCities + 1
		end

		if iNumberofCities > 0 then
			iRandom = TerrainBuilder.GetRandomNumber(iNumberofCities, "Atleer City Roller")+1
			--print ("random number is : ", iRandom)
			for i, pIterCity in pPlayerCities:Members() do
				--print(i, pIterCity:GetName())
				if i == iRandom then
					print("//// ", pIterCity:GetName(), "gains a resource!")

					-- / Rolling tiles...
					local pCityPlots = GetPityClots(pIterCity)
					local iNumberofTiles = 0
					for i, pTile in ipairs(pCityPlots) do
						iNumberofTiles = iNumberofTiles + 1
					end
					--print("Tiles : ", iNumberofTiles)

					if iNumberofTiles > 0 then
						iRandom2 = TerrainBuilder.GetRandomNumber(iNumberofTiles, "Atleer Tile Roller")+1
						--print ("random tile number is : ", iRandom2)
						for i, pTile in ipairs(pCityPlots) do
							if i == iRandom2 then
								--print("Tile found.")

								-- / Validating resources...
								local tValidResources = {}
								local pTileIndex = pTile:GetTerrainType()
								local pTileTerrainType = GameInfo.Terrains[pTileIndex].TerrainType
								--print(pTileTerrainType, " is chosen tile.")

									-- / Resource tech check...
									local pPlayerTechs = pPlayer:GetTechs()
									local tResTechList = {}
									for i, pRow in ipairs(DB.Query("SELECT TechnologyType FROM Technologies WHERE TechnologyType IN (SELECT PrereqTech FROM Resources WHERE PrereqTech IS NOT NULL AND PrereqTech != 'TECH_ANIMAL_HUSBANDRY')")) do
										tResTechList[i] = pRow.TechnologyType
									--print(pRow.TechnologyType)
									end
									--local tResTechList = {GameInfo.Technologies['TECH_RADIO'].Index, GameInfo.Technologies['TECH_INDUSTRIALIZATION'].Index, GameInfo.Technologies['TECH_BRONZE_WORKING'].Index, GameInfo.Technologies['TECH_MILITARY_ENGINEERING'].Index, GameInfo.Technologies['TECH_REFINING'].Index, GameInfo.Technologies['TECH_COMBINED_ARMS'].Index}
									local tResTechValid = "'TECH_ANIMAL_HUSBANDRY', "

									for i, pTech in ipairs(tResTechList) do
										--print("pTech = ", pTech)
										if pPlayerTechs:HasTech(GameInfo.Technologies[pTech].Index) then
											--local pTechType = GameInfo.Technologies[pTech].TechnologyType
											--print("pTechType = ", pTechType)
											tResTechValid = tResTechValid .. "'" .. pTech .. "', "
										end
									end
									--print("tResTechValid = ", tResTechValid)

									-- / Gathering resources...
									for i, tRow in ipairs(DB.Query("SELECT ResourceType FROM Resources WHERE (Frequency > 0 OR SeaFrequency > 0) AND (ResourceType IN (SELECT ResourceType from Resource_ValidTerrains WHERE TerrainType = '" .. pTileTerrainType .. "')) AND (ResourceType IN (SELECT ResourceType FROM Resources WHERE PrereqTech IS NULL) OR ResourceType IN (SELECT ResourceType FROM Resources WHERE PrereqTech IN (" .. tResTechValid:sub(1,-3) .. ")))")) do
									--print(tRow.ResourceType)
									tValidResources[i] = tRow
									end
									--print("Resources gathered.")

								-- / Rolling resources...
								local iNumberofResources = 0
								for i, pResource in ipairs(tValidResources) do
								iNumberofResources = iNumberofResources + 1
								end
								--print("Resources : ", iNumberofResources)

								if iNumberofResources > 0 then
									iRandom3 = TerrainBuilder.GetRandomNumber(iNumberofResources-1, "Atleer Resource Roller")+1
									--print ("random resource number is : ", iRandom3)
									for i, pResource in ipairs(tValidResources) do
										if i == iRandom3 then
										local pResourceRolled = pResource.ResourceType
										print("//// Random resource is: ", pResourceRolled)
										local iResource = GameInfo.Resources[pResourceRolled].Index
										
										-- / Placing resource...
										iRandom4 = TerrainBuilder.GetRandomNumber(100, "d100")
										print("//// d100 Roll = ", iRandom4)
											if iRandom4 < 13 then
											ResourceBuilder.SetResourceType(pTile, iResource, 1)
												if pPlayer:IsHuman() then
												Game.AddWorldViewText(playerID, Locale.Lookup("[COLOR_LIGHTBLUE]Resource Synthesized![ENDCOLOR]"), pTile:GetX(), pTile:GetY(), 0)
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
			--print (sCivType)
			bAtleerPresent = true
        end
    end
end
if bAtleerPresent == true then
    print ("///// Atleer detected. Loading lua functions...")
	Events.TechBoostTriggered.Add(Sailor_Atleer_Random_Resource)
	Events.CivicBoostTriggered.Add(Sailor_Atleer_Random_Resource)
else
    print ("///// Atleer not detected.")
end