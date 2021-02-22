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