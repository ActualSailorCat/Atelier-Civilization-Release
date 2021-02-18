--=============================================
-- Atelier Civ / UI
--=============================================
-----------------------------------------------	
-- Types
-----------------------------------------------	
INSERT INTO Types
		(Type,									Kind)
VALUES	('IMPROVEMENT_SAILOR_ATLEER_UI',		'KIND_IMPROVEMENT');

-----------------------------------------------
-- Improvements
-----------------------------------------------
INSERT INTO Improvements	(
		ImprovementType,
		Name,		
		Description,
		TraitType,
		Icon,
		Housing,
		PrereqCivic,
		Buildable,
		OnePerCity,
		PlunderType,
		PlunderAmount,
		TilesRequired,
		SameAdjacentValid,
		Domain
		)
VALUES  (
		'IMPROVEMENT_SAILOR_ATLEER_UI', -- ImprovementType
		'LOC_IMPROVEMENT_SAILOR_ATLEER_UI_NAME', -- Name		
		'LOC_IMPROVEMENT_SAILOR_ATLEER_UI_DESCRIPTION', -- Description
		'TRAIT_CIVILIZATION_IMPROVEMENT_SAILOR_ATLEER_UI', -- TraitType
		'ICON_IMPROVEMENT_SAILOR_ATLEER_UI', -- Icon
		1, -- Housing
		'CIVIC_CRAFTSMANSHIP', -- PrereqCivic
		1, -- Buildable
		1, -- OnePerCity
		'YIELD_SCIENCE', -- PlunderType
		25, -- PlunderAmount
		1, -- TilesRequired
		1, -- SameAdjacentValid
		'DOMAIN_LAND' -- Domain
		);

-----------------------------------------------
-- Improvement_ValidBuildUnits
-----------------------------------------------
INSERT INTO Improvement_ValidBuildUnits
		(ImprovementType,					UnitType)
VALUES	('IMPROVEMENT_SAILOR_ATLEER_UI',	'UNIT_BUILDER');

-----------------------------------------------
-- Improvement_ValidTerrains
-----------------------------------------------
INSERT INTO Improvement_ValidTerrains
		(ImprovementType,					TerrainType)
SELECT	'IMPROVEMENT_SAILOR_ATLEER_UI',		TerrainType
FROM Terrains WHERE Mountain = 0 AND Water = 0;

-----------------------------------------------
-- Improvement_ValidFeatures
-----------------------------------------------
INSERT INTO Improvement_ValidFeatures
		(ImprovementType,					FeatureType)
SELECT	'IMPROVEMENT_SAILOR_ATLEER_UI',		FeatureType
FROM Features WHERE NaturalWonder = 0 AND FeatureType != 'FEATURE_VOLCANO' AND FeatureType != 'FEATURE_GEOTHERMAL_FISSURE';
/*
-----------------------------------------------
-- Improvement_YieldChanges
-----------------------------------------------
INSERT INTO Improvement_YieldChanges
		(ImprovementType,					YieldType,		YieldChange)
SELECT	'IMPROVEMENT_SAILOR_ATLEER_UI',		YieldType,		0
FROM Yields WHERE YieldType != 'YIELD_FAITH';

-----------------------------------------------
-- Improvement_Adjacencies
-----------------------------------------------
INSERT INTO Improvement_Adjacencies
		(ImprovementType,					YieldChangeId)
VALUES	('IMPROVEMENT_SAILOR_ATLEER_UI',	'SAILOR_ATLEER_UI_LUXUR_CULTURE'),
		('IMPROVEMENT_SAILOR_ATLEER_UI',	'SAILOR_ATLEER_UI_LUXUR_GOLD'),
		('IMPROVEMENT_SAILOR_ATLEER_UI',	'SAILOR_ATLEER_UI_STRAT_SCIENCE'),
		('IMPROVEMENT_SAILOR_ATLEER_UI',	'SAILOR_ATLEER_UI_STRAT_GOLD'),
		('IMPROVEMENT_SAILOR_ATLEER_UI',	'SAILOR_ATLEER_UI_BONUS_FOOD'),
		('IMPROVEMENT_SAILOR_ATLEER_UI',	'SAILOR_ATLEER_UI_BONUS_PRODUCTION'),
		-- Chemistry
		('IMPROVEMENT_SAILOR_ATLEER_UI',	'SAILOR_ATLEER_UI_LUXUR_CULTURE_INCREASE'),
		('IMPROVEMENT_SAILOR_ATLEER_UI',	'SAILOR_ATLEER_UI_LUXUR_GOLD_INCREASE'),
		('IMPROVEMENT_SAILOR_ATLEER_UI',	'SAILOR_ATLEER_UI_STRAT_SCIENCE_INCREASE'),
		('IMPROVEMENT_SAILOR_ATLEER_UI',	'SAILOR_ATLEER_UI_STRAT_GOLD_INCREASE'),
		('IMPROVEMENT_SAILOR_ATLEER_UI',	'SAILOR_ATLEER_UI_BONUS_FOOD_INCREASE'),
		('IMPROVEMENT_SAILOR_ATLEER_UI',	'SAILOR_ATLEER_UI_BONUS_PRODUCTION_INCREASE');

-----------------------------------------------
-- Adjacency_YieldChanges
-----------------------------------------------
INSERT INTO Adjacency_YieldChanges
		(ID,											Description,	YieldType,			YieldChange,	TilesRequired,	PrereqTech,			AdjacentResourceClass)
VALUES	('SAILOR_ATLEER_UI_LUXUR_CULTURE',				'Placeholder',	'YIELD_CULTURE',	1,				1,				NULL,				'RESOURCECLASS_LUXURY'),
		('SAILOR_ATLEER_UI_LUXUR_GOLD',					'Placeholder',	'YIELD_GOLD',		2,				1,				NULL,				'RESOURCECLASS_LUXURY'),
		('SAILOR_ATLEER_UI_STRAT_SCIENCE',				'Placeholder',	'YIELD_SCIENCE',	1,				1,				NULL,				'RESOURCECLASS_STRATEGIC'),
		('SAILOR_ATLEER_UI_STRAT_GOLD',					'Placeholder',	'YIELD_GOLD',		2,				1,				NULL,				'RESOURCECLASS_STRATEGIC'),
		('SAILOR_ATLEER_UI_BONUS_FOOD',					'Placeholder',	'YIELD_FOOD',		1,				1,				NULL,				'RESOURCECLASS_BONUS'),
		('SAILOR_ATLEER_UI_BONUS_PRODUCTION',			'Placeholder',	'YIELD_PRODUCTION',	1,				1,				NULL,				'RESOURCECLASS_BONUS'),
		-- Chemistry
		('SAILOR_ATLEER_UI_LUXUR_CULTURE_INCREASE',		'Placeholder',	'YIELD_CULTURE',	1,				1,				'TECH_CHEMISTRY',	'RESOURCECLASS_LUXURY'),
		('SAILOR_ATLEER_UI_LUXUR_GOLD_INCREASE',		'Placeholder',	'YIELD_GOLD',		2,				1,				'TECH_CHEMISTRY',	'RESOURCECLASS_LUXURY'),
		('SAILOR_ATLEER_UI_STRAT_SCIENCE_INCREASE',		'Placeholder',	'YIELD_SCIENCE',	1,				1,				'TECH_CHEMISTRY',	'RESOURCECLASS_STRATEGIC'),
		('SAILOR_ATLEER_UI_STRAT_GOLD_INCREASE',		'Placeholder',	'YIELD_GOLD',		2,				1,				'TECH_CHEMISTRY',	'RESOURCECLASS_STRATEGIC'),
		('SAILOR_ATLEER_UI_BONUS_FOOD_INCREASE',		'Placeholder',	'YIELD_FOOD',		1,				1,				'TECH_CHEMISTRY',	'RESOURCECLASS_BONUS'),
		('SAILOR_ATLEER_UI_BONUS_PRODUCTION_INCREASE',	'Placeholder',	'YIELD_PRODUCTION',	1,				1,				'TECH_CHEMISTRY',	'RESOURCECLASS_BONUS');*/

CREATE TABLE Sailor_AtleerResourceNet (ResourceType TEXT NOT NULL, Yield1 TEXT, Yield2 TEXT, YieldChange1 INTEGER, YieldChange2 INTEGER);
INSERT INTO Sailor_AtleerResourceNet (ResourceType, Yield1, Yield2, YieldChange1, YieldChange2)
SELECT ResourceType, MIN(YieldType) AS Yield1, MAX(YieldType) AS Yield2, MIN(YieldChange) AS YieldChange1, MAX(YieldChange) AS YieldChange2 FROM Resource_YieldChanges GROUP BY ResourceType;
UPDATE Sailor_AtleerResourceNet SET Yield2 = NULL, YieldChange2 = NULL WHERE Yield1 = Yield2;

CREATE TABLE Sailor_YieldConstructor (S text not null, FO text not null, P text not null, C text not null, FA text not null, G text not null);
INSERT INTO Sailor_YieldConstructor (S, FO, P, C, FA, G)
VALUES	('YIELD_SCIENCE', 'YIELD_FOOD', 'YIELD_PRODUCTION', 'YIELD_CULTURE', 'YIELD_FAITH', 'YIELD_GOLD'),
		('YIELD_SCIENCE', 'YIELD_FOOD', 'YIELD_PRODUCTION', 'YIELD_CULTURE', 'YIELD_FAITH', 'YIELD_GOLD'),
		('YIELD_SCIENCE', 'YIELD_FOOD', 'YIELD_PRODUCTION', 'YIELD_CULTURE', 'YIELD_FAITH', 'YIELD_GOLD'),
		('YIELD_SCIENCE', 'YIELD_FOOD', 'YIELD_PRODUCTION', 'YIELD_CULTURE', 'YIELD_FAITH', 'YIELD_GOLD'),
		('YIELD_SCIENCE', 'YIELD_FOOD', 'YIELD_PRODUCTION', 'YIELD_CULTURE', 'YIELD_FAITH', 'YIELD_GOLD'),
		('YIELD_SCIENCE', 'YIELD_FOOD', 'YIELD_PRODUCTION', 'YIELD_CULTURE', 'YIELD_FAITH', 'YIELD_GOLD'),
		('YIELD_SCIENCE', 'YIELD_FOOD', 'YIELD_PRODUCTION', 'YIELD_CULTURE', 'YIELD_FAITH', 'YIELD_GOLD'),
		('YIELD_SCIENCE', 'YIELD_FOOD', 'YIELD_PRODUCTION', 'YIELD_CULTURE', 'YIELD_FAITH', 'YIELD_GOLD'),
		('YIELD_SCIENCE', 'YIELD_FOOD', 'YIELD_PRODUCTION', 'YIELD_CULTURE', 'YIELD_FAITH', 'YIELD_GOLD'),
		('YIELD_SCIENCE', 'YIELD_FOOD', 'YIELD_PRODUCTION', 'YIELD_CULTURE', 'YIELD_FAITH', 'YIELD_GOLD'),
		('YIELD_SCIENCE', 'YIELD_FOOD', 'YIELD_PRODUCTION', 'YIELD_CULTURE', 'YIELD_FAITH', 'YIELD_GOLD'),
		('YIELD_SCIENCE', 'YIELD_FOOD', 'YIELD_PRODUCTION', 'YIELD_CULTURE', 'YIELD_FAITH', 'YIELD_GOLD'),
		('YIELD_SCIENCE', 'YIELD_FOOD', 'YIELD_PRODUCTION', 'YIELD_CULTURE', 'YIELD_FAITH', 'YIELD_GOLD'),
		('YIELD_SCIENCE', 'YIELD_FOOD', 'YIELD_PRODUCTION', 'YIELD_CULTURE', 'YIELD_FAITH', 'YIELD_GOLD'),
		('YIELD_SCIENCE', 'YIELD_FOOD', 'YIELD_PRODUCTION', 'YIELD_CULTURE', 'YIELD_FAITH', 'YIELD_GOLD'),
		('YIELD_SCIENCE', 'YIELD_FOOD', 'YIELD_PRODUCTION', 'YIELD_CULTURE', 'YIELD_FAITH', 'YIELD_GOLD'),
		('YIELD_SCIENCE', 'YIELD_FOOD', 'YIELD_PRODUCTION', 'YIELD_CULTURE', 'YIELD_FAITH', 'YIELD_GOLD'),
		('YIELD_SCIENCE', 'YIELD_FOOD', 'YIELD_PRODUCTION', 'YIELD_CULTURE', 'YIELD_FAITH', 'YIELD_GOLD'),
		('YIELD_SCIENCE', 'YIELD_FOOD', 'YIELD_PRODUCTION', 'YIELD_CULTURE', 'YIELD_FAITH', 'YIELD_GOLD'),
		('YIELD_SCIENCE', 'YIELD_FOOD', 'YIELD_PRODUCTION', 'YIELD_CULTURE', 'YIELD_FAITH', 'YIELD_GOLD');

-----------------------------------------------		
-- ImprovementModifiers		
-----------------------------------------------
INSERT INTO ImprovementModifiers (ImprovementType, ModifierID) SELECT 'IMPROVEMENT_SAILOR_ATLEER_UI', 'SAILOR_ATLEER_UI_'||S||rowid FROM Sailor_YieldConstructor;
INSERT INTO ImprovementModifiers (ImprovementType, ModifierID) SELECT 'IMPROVEMENT_SAILOR_ATLEER_UI', 'SAILOR_ATLEER_UI_'||FO||rowid FROM Sailor_YieldConstructor;
INSERT INTO ImprovementModifiers (ImprovementType, ModifierID) SELECT 'IMPROVEMENT_SAILOR_ATLEER_UI', 'SAILOR_ATLEER_UI_'||P||rowid FROM Sailor_YieldConstructor;
INSERT INTO ImprovementModifiers (ImprovementType, ModifierID) SELECT 'IMPROVEMENT_SAILOR_ATLEER_UI', 'SAILOR_ATLEER_UI_'||C||rowid FROM Sailor_YieldConstructor;
INSERT INTO ImprovementModifiers (ImprovementType, ModifierID) SELECT 'IMPROVEMENT_SAILOR_ATLEER_UI', 'SAILOR_ATLEER_UI_'||FA||rowid FROM Sailor_YieldConstructor;
INSERT INTO ImprovementModifiers (ImprovementType, ModifierID) SELECT 'IMPROVEMENT_SAILOR_ATLEER_UI', 'SAILOR_ATLEER_UI_'||G||rowid FROM Sailor_YieldConstructor;

-----------------------------------------------		
-- Modifiers		
-----------------------------------------------
INSERT INTO Modifiers
		(ModifierId,						ModifierType,								SubjectRequirementSetId)
SELECT	'SAILOR_ATLEER_UI_'||S||rowid,		'MODIFIER_SINGLE_PLOT_ADJUST_PLOT_YIELDS',	'SAILOR_ATLEER_UI_REQUIRES_'||S||rowid
FROM Sailor_YieldConstructor;

INSERT INTO Modifiers
		(ModifierId,						ModifierType,								SubjectRequirementSetId)
SELECT	'SAILOR_ATLEER_UI_'||FO||rowid,		'MODIFIER_SINGLE_PLOT_ADJUST_PLOT_YIELDS',	'SAILOR_ATLEER_UI_REQUIRES_'||FO||rowid
FROM Sailor_YieldConstructor;

INSERT INTO Modifiers
		(ModifierId,						ModifierType,								SubjectRequirementSetId)
SELECT	'SAILOR_ATLEER_UI_'||P||rowid,		'MODIFIER_SINGLE_PLOT_ADJUST_PLOT_YIELDS',	'SAILOR_ATLEER_UI_REQUIRES_'||P||rowid
FROM Sailor_YieldConstructor;

INSERT INTO Modifiers
		(ModifierId,						ModifierType,								SubjectRequirementSetId)
SELECT	'SAILOR_ATLEER_UI_'||C||rowid,		'MODIFIER_SINGLE_PLOT_ADJUST_PLOT_YIELDS',	'SAILOR_ATLEER_UI_REQUIRES_'||C||rowid
FROM Sailor_YieldConstructor;

INSERT INTO Modifiers
		(ModifierId,						ModifierType,								SubjectRequirementSetId)
SELECT	'SAILOR_ATLEER_UI_'||FA||rowid,		'MODIFIER_SINGLE_PLOT_ADJUST_PLOT_YIELDS',	'SAILOR_ATLEER_UI_REQUIRES_'||FA||rowid
FROM Sailor_YieldConstructor;

INSERT INTO Modifiers
		(ModifierId,						ModifierType,								SubjectRequirementSetId)
SELECT	'SAILOR_ATLEER_UI_'||G||rowid,		'MODIFIER_SINGLE_PLOT_ADJUST_PLOT_YIELDS',	'SAILOR_ATLEER_UI_REQUIRES_'||G||rowid
FROM Sailor_YieldConstructor;

-----------------------------------------------		
-- ModifierArguments
-----------------------------------------------
INSERT INTO ModifierArguments (ModifierId, Name, Value) SELECT 'SAILOR_ATLEER_UI_'||S||rowid, 'YieldType', S FROM Sailor_YieldConstructor;
INSERT INTO ModifierArguments (ModifierId, Name, Value) SELECT 'SAILOR_ATLEER_UI_'||FO||rowid, 'YieldType', FO FROM Sailor_YieldConstructor;
INSERT INTO ModifierArguments (ModifierId, Name, Value) SELECT 'SAILOR_ATLEER_UI_'||P||rowid, 'YieldType', P FROM Sailor_YieldConstructor;
INSERT INTO ModifierArguments (ModifierId, Name, Value) SELECT 'SAILOR_ATLEER_UI_'||C||rowid, 'YieldType', C FROM Sailor_YieldConstructor;
INSERT INTO ModifierArguments (ModifierId, Name, Value) SELECT 'SAILOR_ATLEER_UI_'||FA||rowid, 'YieldType', FA FROM Sailor_YieldConstructor;
INSERT INTO ModifierArguments (ModifierId, Name, Value) SELECT 'SAILOR_ATLEER_UI_'||G||rowid, 'YieldType', G FROM Sailor_YieldConstructor;

INSERT INTO ModifierArguments (ModifierId, Name, Value) SELECT 'SAILOR_ATLEER_UI_'||S||rowid, 'Amount', 1 FROM Sailor_YieldConstructor;
INSERT INTO ModifierArguments (ModifierId, Name, Value) SELECT 'SAILOR_ATLEER_UI_'||FO||rowid, 'Amount', 1 FROM Sailor_YieldConstructor;
INSERT INTO ModifierArguments (ModifierId, Name, Value) SELECT 'SAILOR_ATLEER_UI_'||P||rowid, 'Amount', 1 FROM Sailor_YieldConstructor;
INSERT INTO ModifierArguments (ModifierId, Name, Value) SELECT 'SAILOR_ATLEER_UI_'||C||rowid, 'Amount', 1 FROM Sailor_YieldConstructor;
INSERT INTO ModifierArguments (ModifierId, Name, Value) SELECT 'SAILOR_ATLEER_UI_'||FA||rowid, 'Amount', 1 FROM Sailor_YieldConstructor;
INSERT INTO ModifierArguments (ModifierId, Name, Value) SELECT 'SAILOR_ATLEER_UI_'||G||rowid, 'Amount', 1 FROM Sailor_YieldConstructor;

-----------------------------------------------		
-- RequirementSets
-----------------------------------------------
INSERT INTO RequirementSets (RequirementSetId, RequirementSetType) SELECT 'SAILOR_ATLEER_UI_REQUIRES_'||S||rowid, 'REQUIREMENTSET_TEST_ALL' FROM Sailor_YieldConstructor;
INSERT INTO RequirementSets (RequirementSetId, RequirementSetType) SELECT 'SAILOR_ATLEER_UI_REQUIRES_'||FO||rowid, 'REQUIREMENTSET_TEST_ALL' FROM Sailor_YieldConstructor;
INSERT INTO RequirementSets (RequirementSetId, RequirementSetType) SELECT 'SAILOR_ATLEER_UI_REQUIRES_'||P||rowid, 'REQUIREMENTSET_TEST_ALL' FROM Sailor_YieldConstructor;
INSERT INTO RequirementSets (RequirementSetId, RequirementSetType) SELECT 'SAILOR_ATLEER_UI_REQUIRES_'||C||rowid, 'REQUIREMENTSET_TEST_ALL' FROM Sailor_YieldConstructor;
INSERT INTO RequirementSets (RequirementSetId, RequirementSetType) SELECT 'SAILOR_ATLEER_UI_REQUIRES_'||FA||rowid, 'REQUIREMENTSET_TEST_ALL' FROM Sailor_YieldConstructor;
INSERT INTO RequirementSets (RequirementSetId, RequirementSetType) SELECT 'SAILOR_ATLEER_UI_REQUIRES_'||G||rowid, 'REQUIREMENTSET_TEST_ALL' FROM Sailor_YieldConstructor;

-----------------------------------------------
-- RequirementSetRequirements
-----------------------------------------------
INSERT INTO RequirementSetRequirements (RequirementSetId, RequirementId) SELECT 'SAILOR_ATLEER_UI_REQUIRES_'||S||rowid, 'SAILOR_ATLEER_UI_HAS_'||S||rowid FROM Sailor_YieldConstructor;
INSERT INTO RequirementSetRequirements (RequirementSetId, RequirementId) SELECT 'SAILOR_ATLEER_UI_REQUIRES_'||FO||rowid, 'SAILOR_ATLEER_UI_HAS_'||FO||rowid FROM Sailor_YieldConstructor;
INSERT INTO RequirementSetRequirements (RequirementSetId, RequirementId) SELECT 'SAILOR_ATLEER_UI_REQUIRES_'||P||rowid, 'SAILOR_ATLEER_UI_HAS_'||P||rowid FROM Sailor_YieldConstructor;
INSERT INTO RequirementSetRequirements (RequirementSetId, RequirementId) SELECT 'SAILOR_ATLEER_UI_REQUIRES_'||C||rowid, 'SAILOR_ATLEER_UI_HAS_'||C||rowid FROM Sailor_YieldConstructor;
INSERT INTO RequirementSetRequirements (RequirementSetId, RequirementId) SELECT 'SAILOR_ATLEER_UI_REQUIRES_'||FA||rowid, 'SAILOR_ATLEER_UI_HAS_'||FA||rowid FROM Sailor_YieldConstructor;
INSERT INTO RequirementSetRequirements (RequirementSetId, RequirementId) SELECT 'SAILOR_ATLEER_UI_REQUIRES_'||G||rowid, 'SAILOR_ATLEER_UI_HAS_'||G||rowid FROM Sailor_YieldConstructor;

-----------------------------------------------
-- Requirements
-----------------------------------------------
INSERT INTO Requirements (RequirementId, RequirementType) SELECT 'SAILOR_ATLEER_UI_HAS_'||S||rowid, 'REQUIREMENT_PLOT_PROPERTY_MATCHES' FROM Sailor_YieldConstructor;
INSERT INTO Requirements (RequirementId, RequirementType) SELECT 'SAILOR_ATLEER_UI_HAS_'||FO||rowid, 'REQUIREMENT_PLOT_PROPERTY_MATCHES' FROM Sailor_YieldConstructor;
INSERT INTO Requirements (RequirementId, RequirementType) SELECT 'SAILOR_ATLEER_UI_HAS_'||P||rowid, 'REQUIREMENT_PLOT_PROPERTY_MATCHES' FROM Sailor_YieldConstructor;
INSERT INTO Requirements (RequirementId, RequirementType) SELECT 'SAILOR_ATLEER_UI_HAS_'||C||rowid, 'REQUIREMENT_PLOT_PROPERTY_MATCHES' FROM Sailor_YieldConstructor;
INSERT INTO Requirements (RequirementId, RequirementType) SELECT 'SAILOR_ATLEER_UI_HAS_'||FA||rowid, 'REQUIREMENT_PLOT_PROPERTY_MATCHES' FROM Sailor_YieldConstructor;
INSERT INTO Requirements (RequirementId, RequirementType) SELECT 'SAILOR_ATLEER_UI_HAS_'||G||rowid, 'REQUIREMENT_PLOT_PROPERTY_MATCHES' FROM Sailor_YieldConstructor;

-----------------------------------------------
-- RequirementArguments
-----------------------------------------------
INSERT INTO RequirementArguments (RequirementId, Name, Value) SELECT 'SAILOR_ATLEER_UI_HAS_'||S||rowid, 'PropertyName', 'SAILOR_ATLEER_UI_'||S FROM Sailor_YieldConstructor;
INSERT INTO RequirementArguments (RequirementId, Name, Value) SELECT 'SAILOR_ATLEER_UI_HAS_'||S||rowid, 'PropertyMinimum', rowid FROM Sailor_YieldConstructor;
INSERT INTO RequirementArguments (RequirementId, Name, Value) SELECT 'SAILOR_ATLEER_UI_HAS_'||FO||rowid, 'PropertyName', 'SAILOR_ATLEER_UI_'||FO FROM Sailor_YieldConstructor;
INSERT INTO RequirementArguments (RequirementId, Name, Value) SELECT 'SAILOR_ATLEER_UI_HAS_'||FO||rowid, 'PropertyMinimum', rowid FROM Sailor_YieldConstructor;
INSERT INTO RequirementArguments (RequirementId, Name, Value) SELECT 'SAILOR_ATLEER_UI_HAS_'||P||rowid, 'PropertyName', 'SAILOR_ATLEER_UI_'||P FROM Sailor_YieldConstructor;
INSERT INTO RequirementArguments (RequirementId, Name, Value) SELECT 'SAILOR_ATLEER_UI_HAS_'||P||rowid, 'PropertyMinimum', rowid FROM Sailor_YieldConstructor;
INSERT INTO RequirementArguments (RequirementId, Name, Value) SELECT 'SAILOR_ATLEER_UI_HAS_'||C||rowid, 'PropertyName', 'SAILOR_ATLEER_UI_'||C FROM Sailor_YieldConstructor;
INSERT INTO RequirementArguments (RequirementId, Name, Value) SELECT 'SAILOR_ATLEER_UI_HAS_'||C||rowid, 'PropertyMinimum', rowid FROM Sailor_YieldConstructor;
INSERT INTO RequirementArguments (RequirementId, Name, Value) SELECT 'SAILOR_ATLEER_UI_HAS_'||FA||rowid, 'PropertyName', 'SAILOR_ATLEER_UI_'||FA FROM Sailor_YieldConstructor;
INSERT INTO RequirementArguments (RequirementId, Name, Value) SELECT 'SAILOR_ATLEER_UI_HAS_'||FA||rowid, 'PropertyMinimum', rowid FROM Sailor_YieldConstructor;
INSERT INTO RequirementArguments (RequirementId, Name, Value) SELECT 'SAILOR_ATLEER_UI_HAS_'||G||rowid, 'PropertyName', 'SAILOR_ATLEER_UI_'||G FROM Sailor_YieldConstructor;
INSERT INTO RequirementArguments (RequirementId, Name, Value) SELECT 'SAILOR_ATLEER_UI_HAS_'||G||rowid, 'PropertyMinimum', rowid FROM Sailor_YieldConstructor;

DROP TABLE Sailor_YieldConstructor;