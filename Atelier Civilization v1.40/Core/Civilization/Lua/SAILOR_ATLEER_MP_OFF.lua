--///////////////////////////////////////////////////////
-- Atelier Improvement Functions
-- Adds adjacent resource yields to improvement tile.
--///////////////////////////////////////////////////////
local tSailorAtleerResourceNet = {}
for i, tRow in ipairs(DB.Query("SELECT * FROM Sailor_AtleerResourceNet")) do
	table.insert(tSailorAtleerResourceNet, tRow)
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

--///////////////////////////////////////////////////////
-- Civilization Present Detection by SeelingCat
--///////////////////////////////////////////////////////
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
    print ("//// Atleer detected. Loading improvement functions...")
	Events.ImprovementAddedToMap.Add(Sailor_AtleerUIAdded)
	Events.ResourceAddedToMap.Add(Sailor_AtleerResourceAdded)
	Events.ResourceVisibilityChanged.Add(Sailor_AtleerVisibilityAdded)
	Events.ImprovementRemovedFromMap.Add(Sailor_AtleerUIRemoved)
	Events.ResourceRemovedFromMap.Add(Sailor_AtleerResourceRemoved)
else
    print ("//// Atleer not detected.")
end