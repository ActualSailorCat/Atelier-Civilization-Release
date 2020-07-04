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
		('SAILOR_ATLEER_UI_BONUS_PRODUCTION_INCREASE',	'Placeholder',	'YIELD_PRODUCTION',	1,				1,				'TECH_CHEMISTRY',	'RESOURCECLASS_BONUS');