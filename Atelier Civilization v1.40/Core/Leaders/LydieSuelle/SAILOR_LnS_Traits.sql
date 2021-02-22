--=============================================
-- Lydie & Suelle / Traits
--=============================================
-----------------------------------------------	
-- Types
-----------------------------------------------	
INSERT INTO Types 
		(Type,								Kind)
VALUES	('TRAIT_LEADER_SAILOR_LNS_UA',		'KIND_TRAIT');

-----------------------------------------------
-- Traits
-----------------------------------------------
INSERT INTO Traits
		(TraitType,							Name,										Description)
VALUES	('TRAIT_LEADER_SAILOR_LNS_UA',		'LOC_TRAIT_LEADER_SAILOR_LNS_UA_NAME',		'LOC_TRAIT_LEADER_SAILOR_LNS_UA_DESCRIPTION');

-----------------------------------------------
-- LeaderTraits
-----------------------------------------------	
INSERT INTO LeaderTraits	
		(LeaderType,						TraitType)
VALUES	('LEADER_SAILOR_LNS',				'TRAIT_LEADER_SAILOR_LNS_UA');

-----------------------------------------------			
-- TraitModifiers		
-----------------------------------------------	
INSERT INTO TraitModifiers
		(TraitType,							ModifierId)
VALUES	('TRAIT_LEADER_SAILOR_LNS_UA',		'SAILOR_LNS_UA_PALACE_SLOT');

-----------------------------------------------
-- Modifiers
-----------------------------------------------
INSERT INTO Modifiers
		(ModifierId,					ModifierType,												OwnerRequirementSetId,	SubjectRequirementSetId)
VALUES	('SAILOR_LNS_UA_PALACE_SLOT',	'MODIFIER_PLAYER_CITIES_ADJUST_EXTRA_GREAT_WORK_SLOTS',		NULL,					NULL);

-----------------------------------------------
-- ModifierArguments
-----------------------------------------------
INSERT INTO ModifierArguments
		(ModifierId,					Name,					Value)
VALUES	('SAILOR_LNS_UA_PALACE_SLOT',	'Amount',				1),
		('SAILOR_LNS_UA_PALACE_SLOT',	'BuildingType',			'BUILDING_PALACE'),
		('SAILOR_LNS_UA_PALACE_SLOT',	'GreatWorkSlotType',	'GREATWORKSLOT_ART');