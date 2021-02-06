--[[GameEvents = ExposedMembers.GameEvents

function Sailor_Atleer_Focus (iTileX, iTileY)
	UI.LookAtPlot(iTileX, iTileY)
end

GameEvents.Sailor_Atleer_Random_Resource.Add(Sailor_Atleer_Focus)]]--