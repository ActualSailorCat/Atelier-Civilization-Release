--=============================================
-- Atelier Civ / Resource Harvests
-- This is a barebones stand-in that's meant to
-- run only when the user does not have a mod
-- that tackles resource harvests.
--=============================================
CREATE TABLE IF NOT EXISTS Sailor_Atleer_Harvest_Switch (Enabled INT default 0);

-- CHANGE "VALUES (1)" to "VALUES (0)" to disable this entirely.
INSERT INTO Sailor_Atleer_Harvest_Switch (Enabled) VALUES (1);
--


INSERT INTO Resource_Harvests
		(ResourceType,		YieldType,		Amount,		PrereqTech)
SELECT	ResourceType,		YieldType,		20,			'TECH_ANIMAL_HUSBANDRY'
FROM Resource_YieldChanges WHERE ResourceType NOT IN (SELECT ResourceType FROM Resource_Harvests)
AND ResourceType IN (SELECT ResourceType FROM Improvement_ValidResources WHERE ImprovementType = 'IMPROVEMENT_CAMP' OR ImprovementType = 'IMPROVEMENT_PASTURE')
AND EXISTS (SELECT Enabled FROM Sailor_Atleer_Harvest_Switch WHERE Enabled = 1);

INSERT INTO Resource_Harvests
		(ResourceType,		YieldType,		Amount,		PrereqTech)
SELECT	ResourceType,		YieldType,		20,			'TECH_MINING'
FROM Resource_YieldChanges WHERE ResourceType NOT IN (SELECT ResourceType FROM Resource_Harvests)
AND ResourceType IN (SELECT ResourceType FROM Improvement_ValidResources WHERE ImprovementType = 'IMPROVEMENT_MINE' OR ImprovementType = 'IMPROVEMENT_QUARRY')
AND EXISTS (SELECT Enabled FROM Sailor_Atleer_Harvest_Switch WHERE Enabled = 1);

INSERT INTO Resource_Harvests
		(ResourceType,		YieldType,		Amount,		PrereqTech)
SELECT	ResourceType,		YieldType,		20,			NULL
FROM Resource_YieldChanges WHERE ResourceType NOT IN (SELECT ResourceType FROM Resource_Harvests)
AND ResourceType IN (SELECT ResourceType FROM Improvement_ValidResources WHERE ImprovementType = 'IMPROVEMENT_FARM')
AND EXISTS (SELECT Enabled FROM Sailor_Atleer_Harvest_Switch WHERE Enabled = 1);

INSERT INTO Resource_Harvests
		(ResourceType,		YieldType,		Amount,		PrereqTech)
SELECT	ResourceType,		YieldType,		20,			'TECH_IRRIGATION'
FROM Resource_YieldChanges WHERE ResourceType NOT IN (SELECT ResourceType FROM Resource_Harvests)
AND ResourceType IN (SELECT ResourceType FROM Improvement_ValidResources WHERE ImprovementType = 'IMPROVEMENT_PLANTATION')
AND EXISTS (SELECT Enabled FROM Sailor_Atleer_Harvest_Switch WHERE Enabled = 1);

INSERT INTO Resource_Harvests
		(ResourceType,		YieldType,		Amount,		PrereqTech)
SELECT	ResourceType,		YieldType,		20,			'TECH_SAILING'
FROM Resource_YieldChanges WHERE ResourceType NOT IN (SELECT ResourceType FROM Resource_Harvests)
AND ResourceType IN (SELECT ResourceType FROM Improvement_ValidResources WHERE ImprovementType = 'IMPROVEMENT_FISHING_BOATS')
AND EXISTS (SELECT Enabled FROM Sailor_Atleer_Harvest_Switch WHERE Enabled = 1);

INSERT INTO Resource_Harvests
		(ResourceType,		YieldType,		Amount,		PrereqTech)
SELECT	ResourceType,		YieldType,		20,			'TECH_REFINING'
FROM Resource_YieldChanges WHERE ResourceType NOT IN (SELECT ResourceType FROM Resource_Harvests)
AND ResourceType IN (SELECT ResourceType FROM Improvement_ValidResources WHERE ImprovementType = 'OIL_WELL')
AND EXISTS (SELECT Enabled FROM Sailor_Atleer_Harvest_Switch WHERE Enabled = 1);