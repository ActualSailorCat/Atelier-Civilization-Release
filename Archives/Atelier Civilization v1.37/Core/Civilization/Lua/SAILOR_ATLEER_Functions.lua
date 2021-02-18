--///////////////////////////////////////////////////////
--///////////////////////////////////////////////////////
-- Atleer Civ / Scripts
--///////////////////////////////////////////////////////
--///////////////////////////////////////////////////////
local iResourceDC = 13
--///////////////////////////////////////////////////////
-- GetCityPlots by LeeS & SailorCat
--///////////////////////////////////////////////////////
function Sailor_AtleerTileCollector(tCities)
	local iCityRadius = 5
	local tTempTable = {}
	for k, pCity in ipairs(tCities) do
		if pCity ~= nil then
			local iCityOwner = pCity:GetOwner()
			local iCityX, iCityY = pCity:GetX(), pCity:GetY()
			for dx = (iCityRadius * -1), iCityRadius do
				for dy = (iCityRadius * -1), iCityRadius do
					local _Plot = Map.GetPlotXYWithRangeCheck(iCityX, iCityY, dx, dy, iCityRadius);
					if _Plot and (_Plot:GetOwner() == iCityOwner) and (pCity == Cities.GetPlotPurchaseCity(_Plot:GetIndex())) then
						if (not _Plot:IsMountain()) and (_Plot:GetResourceType() == -1) and (not _Plot:IsNaturalWonder()) and ((_Plot:GetDistrictType() == -1) or (GameInfo.Districts  [_Plot:GetDistrictType()].DistrictType == "DISTRICT_CITY_CENTER")) then
							if _Plot:GetFeatureType() > -1 then
								if GameInfo.Features[_Plot:GetFeatureType()].FeatureType ~= "FEATURE_GEOTHERMAL_FISSURE" then
									table.insert(tTempTable, _Plot)
								end
							else
								table.insert(tTempTable, _Plot)
							end
						end
					end
				end
			end
		end
	end
	return tTempTable
end

--///////////////////////////////////////////////////////
-- Randomly Spawn Random Resource on Eureka / Inspiration
--///////////////////////////////////////////////////////
function Sailor_Atleer_Random_Resource(playerID, PlotX, PlotY, resourceID, cityID)
	local bAtleerCiv    = false
	local pPlayerConfig = PlayerConfigurations[playerID]
	local sCivilization = pPlayerConfig:GetCivilizationTypeName()
	if sCivilization == 'CIVILIZATION_SAILOR_ATLEER' then
		bAtleerCiv = true
	end

	if bAtleerCiv == true then
		local d100 = TerrainBuilder.GetRandomNumber(100, "d100")
		print("//// d100 Roll = ", d100)
		if d100 < iResourceDC then
            local pPlayer           = Players[playerID]
            local pPlayerCities     = pPlayer:GetCities()
            local pPlayerTechs      = pPlayer:GetTechs()
            local tCities           = {}
            local tValidTiles       = {}
            local tValidResources   = {}
            local dTile             = 0
            local dResource         = 0
			-- // Gathering plots...
            for k, v in pPlayerCities:Members() do
                table.insert(tCities, v)
            end
			tValidTiles = Sailor_AtleerTileCollector(tCities)
            if next(tValidTiles) ~= nil then
                dTile = TerrainBuilder.GetRandomNumber(#tValidTiles, "Atleer Tile Roller") + 1
                for i, _Tile in ipairs(tValidTiles) do
                    if i == dTile then
                        local _TileTerrain = GameInfo.Terrains[_Tile:GetTerrainType()].TerrainType
                        -- // Gathering resources...
                        for k, tRow in ipairs(DB.Query("SELECT * FROM Resources WHERE (Frequency > 0 OR SeaFrequency > 0) AND (ResourceType IN (SELECT ResourceType from Resource_ValidTerrains WHERE TerrainType = '" .. _TileTerrain .. "'))")) do
                            if ((tRow.PrereqTech == nil) or (pPlayerTechs:HasTech(GameInfo.Technologies[tRow.PrereqTech].Index))) then
								if _Tile:GetImprovementType() > -1 then
									local _TileIMPROVEMENT = GameInfo.Improvements[_Tile:GetImprovementType()].ImprovementType
									local tQuery = DB.Query("SELECT ResourceType FROM Improvement_ValidResources WHERE ImprovementType = '" .. _TileIMPROVEMENT .. "'")
									for k, v in ipairs(tQuery) do
										if v.ResourceType == tRow.ResourceType then 
											table.insert(tValidResources, tRow)
										end
									end
								else
									table.insert(tValidResources, tRow)
								end
                            end
                        end
                        if next(tValidResources) ~= nil then
                            dResource = TerrainBuilder.GetRandomNumber(#tValidResources, "Atleer Resource Roller") + 1
                            for c, _Resource in ipairs(tValidResources) do
                                if c == dResource then
                                    local iResource = GameInfo.Resources[_Resource.ResourceType].Index
                                    ResourceBuilder.SetResourceType(_Tile, iResource, 1)
									print("//// Synthesized resource is: ", _Resource.ResourceType)
                                    if pPlayer:IsHuman() then
										-- // UI Notification...
                                        local iTileX, iTileY = _Tile:GetX(), _Tile:GetY()
                                        Game.AddWorldViewText(playerID, Locale.Lookup("[COLOR_LIGHTBLUE]Resource Synthesized![ENDCOLOR]"), iTileX, iTileY, 0)
                                        local iAtleerNotifType	= NotificationTypes.USER_DEFINED_2
                                        local sAtleerNotifText	= Locale.Lookup("Alchemical synthesis activated!")
                                        local resourceStr		= Locale.Lookup(GameInfo.Resources[iResource].Name)
                                        local iNotifDesc		= "A source of " .. resourceStr .. " has been synthesized."
                                        NotificationManager.SendNotification(playerID, iAtleerNotifType, sAtleerNotifText, iNotifDesc, iTileX, iTileY)
                                    end
                                    return
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
-- Atelier Improvement Functions
-- Adds adjacent resource yields to improvement tile.
--///////////////////////////////////////////////////////
local tSailorAtleerResourceNet = {}
for i, tRow in ipairs(DB.Query("SELECT * FROM Sailor_AtleerResourceNet")) do
	tSailorAtleerResourceNet[i] = tRow
end
-- // Check adj. tiles when improvement added to map.
function Sailor_AtleerUIAdded(iX, iY, eImprovement, playerID)
	--print("Running improvement added to map function.")
	local sImprovementType = GameInfo.Improvements[eImprovement].ImprovementType
	if sImprovementType == 'IMPROVEMENT_SAILOR_ATLEER_UI' then
		local pPlot     = Map.GetPlot(iX, iY)
		local pState    = pPlot:GetProperty("Atelierwuzhere")
		if pState == nil or pState == 0 then
			pPlot:SetProperty("Atelierwuzhere", 1)
			local pPlayer       = Players[playerID]
			local pPlayerTechs  = pPlayer:GetTechs()
			for direction = 0, DirectionTypes.NUM_DIRECTION_TYPES - 1, 1 do
				local pAdjacentPlot = Map.GetAdjacentPlot(iX, iY, direction);
				if pAdjacentPlot then
					if pAdjacentPlot:GetResourceType() > -1 then
						local iResource = pAdjacentPlot:GetResourceType()
						if (GameInfo.Resources[iResource].PrereqTech == nil) or (pPlayerTechs:HasTech(GameInfo.Technologies[GameInfo.Resources[iResource].PrereqTech].Index)) then
							for k, v in ipairs(tSailorAtleerResourceNet) do
								if v.ResourceType == GameInfo.Resources[iResource].ResourceType then
									local pProperty1 = pPlot:GetProperty("SAILOR_ATLEER_UI_" .. v.Yield1)
									if pProperty1 == nil then
										pProperty1 = 0
									end
									pProperty1 = pProperty1 + v.YieldChange1
									pPlot:SetProperty("SAILOR_ATLEER_UI_" .. v.Yield1, pProperty1)
									if v.Yield2 ~= nil then
										local pProperty2 = pPlot:GetProperty("SAILOR_ATLEER_UI_" .. v.Yield2)
										if pProperty2 == nil then
											pProperty2 = 0
										end
										local pProperty2 = pProperty2 + v.YieldChange2
										pPlot:SetProperty("SAILOR_ATLEER_UI_" .. v.Yield2, pProperty2)
									end
									pAdjacentPlot:SetProperty("AtleerResourceChecked", 1)
								end
							end
						end
					end
				end
			end
		end
	end
end

-- // Account for resources added after improvement.
function Sailor_AtleerResourceAdded(iX, iY, resourceType)
	--print("Running resource added to map function.")
	local pPlot     = Map.GetPlot(iX, iY)
	local pState    = pPlot:GetProperty("AtleerResourceChecked")
	if pState == nil or pState == 0 then
		pPlot:SetProperty("AtleerResourceChecked", 1)
		for direction = 0, DirectionTypes.NUM_DIRECTION_TYPES - 1, 1 do
			local pAdjacentPlot = Map.GetAdjacentPlot(iX, iY, direction)
			if pAdjacentPlot then
				if pAdjacentPlot:GetImprovementType() == GameInfo.Improvements["IMPROVEMENT_SAILOR_ATLEER_UI"].Index then
					local pPlayer       = Players[pAdjacentPlot:GetOwner()]
					local pPlayerTechs  = pPlayer:GetTechs()
					if (GameInfo.Resources[resourceType].PrereqTech == nil) or (pPlayerTechs:HasTech(GameInfo.Technologies[GameInfo.Resources[resourceType].PrereqTech].Index)) then
						for k, v in ipairs(tSailorAtleerResourceNet) do
							if v.ResourceType == GameInfo.Resources[resourceType].ResourceType then
								local pProperty1 = pAdjacentPlot:GetProperty("SAILOR_ATLEER_UI_" .. v.Yield1)
								if pProperty1 == nil then
									pProperty1 = 0
								end
								pProperty1 = pProperty1 + v.YieldChange1
								pAdjacentPlot:SetProperty("SAILOR_ATLEER_UI_" .. v.Yield1, pProperty1)
								if v.Yield2 ~= nil then
									local pProperty2 = pAdjacentPlot:GetProperty("SAILOR_ATLEER_UI_" .. v.Yield2)
									if pProperty2 == nil then
										pProperty2 = 0
									end
									local pProperty2 = pProperty2 + v.YieldChange2
									pAdjacentPlot:SetProperty("SAILOR_ATLEER_UI_" .. v.Yield2, pProperty2)
								end
							end
						end
					end
				end
			end
		end
	end
end

-- // Account for visibility added after improvement.
function Sailor_AtleerVisibilityAdded(iX, iY, resourceType, visibilityType)
	--print("Running visibility added to map function.")
	if visibilityType == 2 then
		local pPlot     = Map.GetPlot(iX, iY)
		local pState    = pPlot:GetProperty("AtleerResourceChecked")
		if pState == nil or pState == 0 then
			pPlot:SetProperty("AtleerResourceChecked", 1)
			for direction = 0, DirectionTypes.NUM_DIRECTION_TYPES - 1, 1 do
				local pAdjacentPlot = Map.GetAdjacentPlot(iX, iY, direction)
				if pAdjacentPlot then
					if pAdjacentPlot:GetImprovementType() == GameInfo.Improvements["IMPROVEMENT_SAILOR_ATLEER_UI"].Index then
						local pPlayer       = Players[pAdjacentPlot:GetOwner()]
						local pPlayerTechs  = pPlayer:GetTechs()
						if (GameInfo.Resources[resourceType].PrereqTech == nil) or (pPlayerTechs:HasTech(GameInfo.Technologies[GameInfo.Resources[resourceType].PrereqTech].Index)) then
							for k, v in ipairs(tSailorAtleerResourceNet) do
								if v.ResourceType == GameInfo.Resources[resourceType].ResourceType then
									local pProperty1 = pAdjacentPlot:GetProperty("SAILOR_ATLEER_UI_" .. v.Yield1)
									if pProperty1 == nil then
										pProperty1 = 0
									end
									pProperty1 = pProperty1 + v.YieldChange1
									pAdjacentPlot:SetProperty("SAILOR_ATLEER_UI_" .. v.Yield1, pProperty1)
									if v.Yield2 ~= nil then
										local pProperty2 = pAdjacentPlot:GetProperty("SAILOR_ATLEER_UI_" .. v.Yield2)
										if pProperty2 == nil then
											pProperty2 = 0
										end
										local pProperty2 = pProperty2 + v.YieldChange2
										pAdjacentPlot:SetProperty("SAILOR_ATLEER_UI_" .. v.Yield2, pProperty2)
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

-- // Clean tile after improvement removed.
function Sailor_AtleerUIRemoved(iX, iY, eOwner)
	local pPlot = Map.GetPlot(iX, iY)
	if pPlot:GetProperty("Atelierwuzhere") == 1 then
		for v in GameInfo.Yields() do
			pPlot:SetProperty("SAILOR_ATLEER_UI_" .. v.YieldType, 0)
		end
		pPlot:SetProperty("Atelierwuzhere", 0)
	end
end

-- // Clean tile after resource removed.
function Sailor_AtleerResourceRemoved(iX, iY, resourceType)
	local pPlot = Map.GetPlot(iX, iY)
	if pPlot:GetProperty("AtleerResourceChecked") == 1 then
		pPlot:SetProperty("AtleerResourceChecked", 0)
	end
end

-- // Loading separately for situations like Wondrous Goody Huts.
Events.ImprovementAddedToMap.Add(Sailor_AtleerUIAdded)
Events.ResourceAddedToMap.Add(Sailor_AtleerResourceAdded)
Events.ResourceVisibilityChanged.Add(Sailor_AtleerVisibilityAdded)
Events.ImprovementRemovedFromMap.Add(Sailor_AtleerUIRemoved)
Events.ResourceRemovedFromMap.Add(Sailor_AtleerResourceRemoved)

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