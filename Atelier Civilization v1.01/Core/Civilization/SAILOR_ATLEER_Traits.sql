--=============================================
-- Atelier Civ / Traits
--=============================================
INSERT INTO Types
		(Type,												Kind)
VALUES	('TRAIT_CIVILIZATION_SAILOR_ATLEER_UA',				'KIND_TRAIT'),
		('TRAIT_CIVILIZATION_UNIT_SAILOR_ATLEER_UU',		'KIND_TRAIT'),
		('TRAIT_CIVILIZATION_IMPROVEMENT_SAILOR_ATLEER_UI',	'KIND_TRAIT');

-----------------------------------------------			
-- CivilizationTraits			
-----------------------------------------------				
INSERT INTO CivilizationTraits
		(CivilizationType,								TraitType)
VALUES	('CIVILIZATION_SAILOR_ATLEER',					'TRAIT_CIVILIZATION_SAILOR_ATLEER_UA'),
		('CIVILIZATION_SAILOR_ATLEER',					'TRAIT_CIVILIZATION_UNIT_SAILOR_ATLEER_UU'),
		('CIVILIZATION_SAILOR_ATLEER',					'TRAIT_CIVILIZATION_IMPROVEMENT_SAILOR_ATLEER_UI');

-----------------------------------------------			
-- Traits			
-----------------------------------------------				
INSERT INTO Traits				
		(TraitType,											Name,														Description)
VALUES	('TRAIT_CIVILIZATION_SAILOR_ATLEER_UA',				'LOC_TRAIT_CIVILIZATION_SAILOR_ATLEER_UA_NAME',				'LOC_TRAIT_CIVILIZATION_SAILOR_ATLEER_UA_DESCRIPTION'),
		('TRAIT_CIVILIZATION_UNIT_SAILOR_ATLEER_UU',		'LOC_TRAIT_CIVILIZATION_UNIT_SAILOR_ATLEER_UU_NAME',		'LOC_TRAIT_CIVILIZATION_UNIT_SAILOR_ATLEER_UU_DESCRIPTION'),
		('TRAIT_CIVILIZATION_IMPROVEMENT_SAILOR_ATLEER_UI',	'LOC_TRAIT_CIVILIZATION_IMPROVEMENT_SAILOR_ATLEER_UI_NAME',	'LOC_TRAIT_CIVILIZATION_IMPROVEMENT_SAILOR_ATLEER_UI_DESCRIPTION');

-----------------------------------------------		
-- TraitModifiers		
-----------------------------------------------
INSERT INTO TraitModifiers
		(TraitType,									ModifierId)
SELECT	'TRAIT_CIVILIZATION_SAILOR_ATLEER_UA',		'SAILOR_ATLEER_UA_ALCHEMICAL_ITEMS_ABILITY'
WHERE NOT EXISTS (SELECT ModifierType FROM DynamicModifiers WHERE ModifierType = 'MODIFIER_PLAYER_GRANT_SPECIFIC_TECHNOLOGY');
-----------------------------------------------		
-- Modifiers		
-----------------------------------------------
INSERT INTO Modifiers
		(ModifierId,									Permanent,	ModifierType,							OwnerRequirementSetId)
SELECT	'SAILOR_ATLEER_UA_ALCHEMICAL_ITEMS_ABILITY',	1,			'MODIFIER_PLAYER_UNITS_GRANT_ABILITY',	NULL
WHERE NOT EXISTS (SELECT ModifierType FROM DynamicModifiers WHERE ModifierType = 'MODIFIER_PLAYER_GRANT_SPECIFIC_TECHNOLOGY');

-----------------------------------------------		
-- ModifierArguments
-----------------------------------------------
INSERT INTO ModifierArguments
		(ModifierId,									Name,				Value)
SELECT	'SAILOR_ATLEER_UA_ALCHEMICAL_ITEMS_ABILITY',	'AbilityType',		'ABILITY_SAILOR_ATLEER_UA'
WHERE NOT EXISTS (SELECT ModifierType FROM DynamicModifiers WHERE ModifierType = 'MODIFIER_PLAYER_GRANT_SPECIFIC_TECHNOLOGY');

-----------------------------------------------		
-- Tags
-----------------------------------------------
INSERT INTO Tags
		(Tag,							Vocabulary)
VALUES	('CLASS_SAILOR_ATLEER_UA',		'ABILITY_CLASS'),
		('CLASS_SAILOR_ATLEER_UA_NON',	'ABILITY_CLASS');

-----------------------------------------------	
-- Types
-----------------------------------------------	
INSERT INTO Types 
		(Type,							Kind)
VALUES	('ABILITY_SAILOR_ATLEER_UA',	'KIND_ABILITY');

-----------------------------------------------	
-- TypeTags
-----------------------------------------------	
INSERT INTO TypeTags
		(Type,							Tag)
VALUES	('ABILITY_SAILOR_ATLEER_UA',	'CLASS_SAILOR_ATLEER_UA');

INSERT INTO TypeTags
		(Type,		Tag)
SELECT DISTINCT	Type,		'CLASS_SAILOR_ATLEER_UA'
FROM TypeTags WHERE Type IN (SELECT UnitType FROM Units WHERE StrategicResource IS NOT NULL AND TraitType IS NULL);

INSERT INTO TypeTags
		(Type,		Tag)
SELECT DISTINCT	Type,		'CLASS_SAILOR_ATLEER_UA_NON'
FROM TypeTags WHERE Type IN (SELECT UnitType FROM Units WHERE StrategicResource IS NULL AND Combat > 0);

-----------------------------------------------
-- UnitAbilities
-----------------------------------------------
INSERT INTO UnitAbilities
		(UnitAbilityType,				Name,									Description,								Inactive)
VALUES	('ABILITY_SAILOR_ATLEER_UA',	'LOC_ABILITY_SAILOR_ATLEER_UA_NAME',	'LOC_ABILITY_SAILOR_ATLEER_UA_DESCRIPTION',	1);

-----------------------------------------------
--  UnitAbilityModifiers
-----------------------------------------------
INSERT INTO UnitAbilityModifiers
		(UnitAbilityType,				ModifierId)
VALUES	('ABILITY_SAILOR_ATLEER_UA',	'ABILITY_SAILOR_ATLEER_UA_MOD');

-----------------------------------------------
--  Modifiers
-----------------------------------------------
INSERT INTO Modifiers
		(ModifierId,						ModifierType,								SubjectRequirementSetId)
VALUES	('ABILITY_SAILOR_ATLEER_UA_MOD',	'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH',		'SAILOR_ATLEER_UA_UNITABILITY_REQUIREMENTSET');

-----------------------------------------------
-- ModifierArguments
-----------------------------------------------
INSERT INTO ModifierArguments
		(ModifierId,						Name,		Value)
VALUES	('ABILITY_SAILOR_ATLEER_UA_MOD',	'Amount',	6);

-----------------------------------------------
-- ModifierStrings
-----------------------------------------------
INSERT INTO ModifierStrings
		(ModifierId,						Context,	Text)
VALUES	('ABILITY_SAILOR_ATLEER_UA_MOD',	'Preview',	'LOC_ABILITY_SAILOR_ATLEER_UA_MOD_PREVIEW_TEXT');

-----------------------------------------------		
-- RequirementSets
-----------------------------------------------
INSERT INTO RequirementSets
		(RequirementSetId,									RequirementSetType)
VALUES	('SAILOR_ATLEER_UA_UNITABILITY_REQUIREMENTSET',		'REQUIREMENTSET_TEST_ALL');

-----------------------------------------------
-- RequirementSetRequirements
-----------------------------------------------
INSERT INTO RequirementSetRequirements
		(RequirementSetId,									RequirementId)
VALUES	('SAILOR_ATLEER_UA_UNITABILITY_REQUIREMENTSET',		'SAILOR_ATLEER_UA_UNITABILITY_REQUIRES_ILLEQUIPPED');

-----------------------------------------------
-- Requirements
-----------------------------------------------
INSERT INTO Requirements
		(RequirementId, 										RequirementType)
VALUES	('SAILOR_ATLEER_UA_UNITABILITY_REQUIRES_ILLEQUIPPED',	'REQUIREMENT_OPPONENT_UNIT_TAG_MATCHES');

-----------------------------------------------
-- RequirementArguments
-----------------------------------------------
INSERT INTO RequirementArguments
		(RequirementId, 										Name,	Value)
VALUES	('SAILOR_ATLEER_UA_UNITABILITY_REQUIRES_ILLEQUIPPED',	'Tag',	'CLASS_SAILOR_ATLEER_UA_NON');
