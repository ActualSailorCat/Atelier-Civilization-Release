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
FROM Features WHERE NaturalWonder = 0 AND FeatureType != 'FEATURE_VOLCANO' AND FeatureType NOT IN ('FEATURE_GEOTHERMAL_FISSURE', 'FEATURE_OASIS', 'FEATURE_REEF');