--=============================================
-- Totori / Traits
--=============================================
-----------------------------------------------	
-- Types
-----------------------------------------------	
INSERT INTO Types 
		(Type,									Kind)
VALUES	('TRAIT_LEADER_SAILOR_TOTORI_UA',		'KIND_TRAIT');

-----------------------------------------------
-- Traits
-----------------------------------------------
INSERT INTO Traits
		(TraitType,								Name,											Description)
VALUES	('TRAIT_LEADER_SAILOR_TOTORI_UA',		'LOC_TRAIT_LEADER_SAILOR_TOTORI_UA_NAME',		'LOC_TRAIT_LEADER_SAILOR_TOTORI_UA_DESCRIPTION');

-----------------------------------------------
-- LeaderTraits
-----------------------------------------------	
INSERT INTO LeaderTraits	
		(LeaderType,							TraitType)
VALUES	('LEADER_SAILOR_TOTORI',				'TRAIT_LEADER_SAILOR_TOTORI_UA');

-----------------------------------------------			
-- TraitModifiers		
-----------------------------------------------	
INSERT INTO TraitModifiers
		(TraitType,								ModifierId)
VALUES	('TRAIT_LEADER_SAILOR_TOTORI_UA',		'SAILOR_TOTORI_UA_FREE_SHIP');

-- VANILLA, R&F ONLY
INSERT INTO TraitModifiers
		(TraitType,							ModifierId)
SELECT	'TRAIT_LEADER_SAILOR_TOTORI_UA',	'SAILOR_TOTORI_UA_SAILING'
WHERE NOT EXISTS (SELECT ModifierType FROM DynamicModifiers WHERE ModifierType = 'MODIFIER_PLAYER_GRANT_SPECIFIC_TECHNOLOGY');

INSERT INTO TraitModifiers
		(TraitType,							ModifierId)
SELECT	'TRAIT_LEADER_SAILOR_TOTORI_UA',	'SAILOR_TOTORI_UA_SHIPBUILDING'
WHERE NOT EXISTS (SELECT ModifierType FROM DynamicModifiers WHERE ModifierType = 'MODIFIER_PLAYER_GRANT_SPECIFIC_TECHNOLOGY');

INSERT INTO TraitModifiers
		(TraitType,							ModifierId)
SELECT	'TRAIT_LEADER_SAILOR_TOTORI_UA',	'SAILOR_TOTORI_UA_BOOST'
WHERE NOT EXISTS (SELECT ModifierType FROM DynamicModifiers WHERE ModifierType = 'MODIFIER_PLAYER_GRANT_SPECIFIC_TECHNOLOGY');

-----------------------------------------------
-- Modifiers
-----------------------------------------------
INSERT INTO Modifiers
		(ModifierId,						ModifierType,									RunOnce, Permanent,	OwnerRequirementSetId,	SubjectRequirementSetId)
VALUES	('SAILOR_TOTORI_UA_FREE_SHIP',		'MODIFIER_PLAYER_CITIES_GRANT_UNIT_BY_CLASS',	0,		1,			NULL,					'SAILOR_TOTORI_COASTAL_REQUIREMENT');

-- VANILLA, R&F ONLY
INSERT INTO Modifiers
		(ModifierId,						ModifierType,									SubjectRequirementSetId)
SELECT	'SAILOR_TOTORI_UA_SAILING',			'MODIFIER_PLAYER_GRANT_SPECIFIC_TECH_BOOST',	NULL
WHERE NOT EXISTS (SELECT ModifierType FROM DynamicModifiers WHERE ModifierType = 'MODIFIER_PLAYER_GRANT_SPECIFIC_TECHNOLOGY');

INSERT INTO Modifiers
		(ModifierId,						ModifierType,									SubjectRequirementSetId)
SELECT	'SAILOR_TOTORI_UA_SHIPBUILDING',	'MODIFIER_PLAYER_GRANT_SPECIFIC_TECH_BOOST',	NULL
WHERE NOT EXISTS (SELECT ModifierType FROM DynamicModifiers WHERE ModifierType = 'MODIFIER_PLAYER_GRANT_SPECIFIC_TECHNOLOGY');

INSERT INTO Modifiers
		(ModifierId,						ModifierType,									SubjectRequirementSetId)
SELECT	'SAILOR_TOTORI_UA_BOOST',			'MODIFIER_PLAYER_ADJUST_TECHNOLOGY_BOOST',		'SAILOR_TOTORI_NO_SAILING_REQUIREMENT'
WHERE NOT EXISTS (SELECT ModifierType FROM DynamicModifiers WHERE ModifierType = 'MODIFIER_PLAYER_GRANT_SPECIFIC_TECHNOLOGY');

-----------------------------------------------
-- ModifierArguments
-----------------------------------------------
INSERT INTO ModifierArguments
		(ModifierId,							Name,						Value)
VALUES	('SAILOR_TOTORI_UA_FREE_SHIP',			'UnitPromotionClassType',	'PROMOTION_CLASS_NAVAL_MELEE');

-- VANILLA, R&F ONLY
INSERT INTO ModifierArguments
		(ModifierId,						Name,			Value)
SELECT	'SAILOR_TOTORI_UA_SAILING',			'TechType',		'TECH_SAILING'
WHERE NOT EXISTS (SELECT ModifierType FROM DynamicModifiers WHERE ModifierType = 'MODIFIER_PLAYER_GRANT_SPECIFIC_TECHNOLOGY');

INSERT INTO ModifierArguments
		(ModifierId,						Name,			Value)
SELECT	'SAILOR_TOTORI_UA_SHIPBUILDING',	'TechType',		'TECH_SHIPBUILDING'
WHERE NOT EXISTS (SELECT ModifierType FROM DynamicModifiers WHERE ModifierType = 'MODIFIER_PLAYER_GRANT_SPECIFIC_TECHNOLOGY');
 
INSERT INTO ModifierArguments
(ModifierId,								Name,			Value)
SELECT	'SAILOR_TOTORI_UA_BOOST',			'Amount',		100
WHERE NOT EXISTS (SELECT ModifierType FROM DynamicModifiers WHERE ModifierType = 'MODIFIER_PLAYER_GRANT_SPECIFIC_TECHNOLOGY');

-----------------------------------------------		
-- RequirementSets
-----------------------------------------------
INSERT INTO RequirementSets
		(RequirementSetId,										RequirementSetType)
VALUES	('SAILOR_TOTORI_COASTAL_REQUIREMENT',					'REQUIREMENTSET_TEST_ALL');

-- VANILLA, R&F ONLY
INSERT INTO RequirementSets
		 (RequirementSetId,							RequirementSetType)
SELECT	 'SAILOR_TOTORI_NO_SAILING_REQUIREMENT',	'REQUIREMENTSET_TEST_ANY'
WHERE NOT EXISTS (SELECT ModifierType FROM DynamicModifiers WHERE ModifierType = 'MODIFIER_PLAYER_GRANT_SPECIFIC_TECHNOLOGY');

-----------------------------------------------
-- RequirementSetRequirements
-----------------------------------------------
INSERT INTO RequirementSetRequirements
		(RequirementSetId,										RequirementId)
VALUES	('SAILOR_TOTORI_COASTAL_REQUIREMENT',					'SAILOR_TOTORI_REQUIRES_COASTAL');

-- VANILLA, R&F ONLY
INSERT INTO RequirementSetRequirements
		(RequirementSetId,							RequirementId)
SELECT	'SAILOR_TOTORI_NO_SAILING_REQUIREMENT',		'SAILOR_NO_SAILING_ZONE'
WHERE NOT EXISTS (SELECT ModifierType FROM DynamicModifiers WHERE ModifierType = 'MODIFIER_PLAYER_GRANT_SPECIFIC_TECHNOLOGY');

INSERT INTO RequirementSetRequirements
		(RequirementSetId,							RequirementId)
SELECT	'SAILOR_TOTORI_NO_SAILING_REQUIREMENT',		'SAILOR_NO_CANON_ZONE'
WHERE NOT EXISTS (SELECT ModifierType FROM DynamicModifiers WHERE ModifierType = 'MODIFIER_PLAYER_GRANT_SPECIFIC_TECHNOLOGY');

-----------------------------------------------
-- Requirements
-----------------------------------------------
INSERT INTO Requirements
		(RequirementId,							RequirementType)
VALUES	('SAILOR_TOTORI_REQUIRES_COASTAL',		'REQUIREMENT_PLOT_IS_COASTAL_LAND');

-- VANILLA, R&F ONLY
INSERT INTO Requirements
		(RequirementId,					RequirementType,						Inverse) 
SELECT	'SAILOR_NO_SAILING_ZONE',		'REQUIREMENT_PLAYER_HAS_TECHNOLOGY',	1
WHERE NOT EXISTS (SELECT ModifierType FROM DynamicModifiers WHERE ModifierType = 'MODIFIER_PLAYER_GRANT_SPECIFIC_TECHNOLOGY');

INSERT INTO Requirements
		(RequirementId,					RequirementType,						Inverse) 
SELECT	'SAILOR_NO_CANON_ZONE',			'REQUIREMENT_PLAYER_HAS_TECHNOLOGY',	1
WHERE NOT EXISTS (SELECT ModifierType FROM DynamicModifiers WHERE ModifierType = 'MODIFIER_PLAYER_GRANT_SPECIFIC_TECHNOLOGY');

-----------------------------------------------
-- RequirementArguments
-----------------------------------------------
-- VANILLA, R&F ONLY
INSERT INTO RequirementArguments 
		(RequirementId,					Name,				Value) 
SELECT	'SAILOR_NO_SAILING_ZONE',		'TechnologyType',	'TECH_SAILING'
WHERE NOT EXISTS (SELECT ModifierType FROM DynamicModifiers WHERE ModifierType = 'MODIFIER_PLAYER_GRANT_SPECIFIC_TECHNOLOGY');

INSERT INTO RequirementArguments 
		(RequirementId,					Name,				Value) 
SELECT	'SAILOR_NO_CANON_ZONE',			'TechnologyType',	'TECH_SHIPBUILDING'
WHERE NOT EXISTS (SELECT ModifierType FROM DynamicModifiers WHERE ModifierType = 'MODIFIER_PLAYER_GRANT_SPECIFIC_TECHNOLOGY');