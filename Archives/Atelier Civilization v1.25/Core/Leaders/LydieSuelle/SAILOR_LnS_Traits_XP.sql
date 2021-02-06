--=============================================
-- Lydie & Suelle / Gathering Storm Traits
--=============================================
UPDATE Traits SET Description = 'LOC_TRAIT_LEADER_SAILOR_LNS_UA_XP_DESCRIPTION' WHERE TraitType = 'TRAIT_LEADER_SAILOR_LNS_UA';

-----------------------------------------------			
-- TraitModifiers		
-----------------------------------------------	
INSERT INTO TraitModifiers
		(TraitType,							ModifierId)
SELECT	'TRAIT_LEADER_SAILOR_LNS_UA',		'SAILOR_LNS_UA_'||BuildingType
FROM Buildings WHERE PrereqDistrict = 'DISTRICT_GOVERNMENT' AND TraitType IS NULL;

-----------------------------------------------
-- Modifiers
-----------------------------------------------
INSERT INTO Modifiers
		(ModifierId,						ModifierType)
SELECT	'SAILOR_LNS_UA_'||BuildingType,		'MODIFIER_PLAYER_CITIES_ADJUST_EXTRA_GREAT_WORK_SLOTS'
FROM Buildings WHERE PrereqDistrict = 'DISTRICT_GOVERNMENT' AND TraitType IS NULL;

-----------------------------------------------
-- ModifierArguments
-----------------------------------------------
INSERT INTO ModifierArguments
		(ModifierId,						Name,				Value)
SELECT	'SAILOR_LNS_UA_'||BuildingType,		'Amount',			1
FROM Buildings WHERE PrereqDistrict = 'DISTRICT_GOVERNMENT' AND TraitType IS NULL;

INSERT INTO ModifierArguments
		(ModifierId,						Name,				Value)
SELECT	'SAILOR_LNS_UA_'||BuildingType,		'BuildingType',		BuildingType
FROM Buildings WHERE PrereqDistrict = 'DISTRICT_GOVERNMENT' AND TraitType IS NULL;

INSERT INTO ModifierArguments
		(ModifierId,						Name,					Value)
SELECT	'SAILOR_LNS_UA_'||BuildingType,		'GreatWorkSlotType',	'GREATWORKSLOT_ART'
FROM Buildings WHERE PrereqDistrict = 'DISTRICT_GOVERNMENT' AND TraitType IS NULL;