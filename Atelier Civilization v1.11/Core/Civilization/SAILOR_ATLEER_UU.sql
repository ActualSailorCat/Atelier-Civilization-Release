--=============================================
-- Atelier Civ / UU
--=============================================
-----------------------------------------------	
-- Tags
-----------------------------------------------	
INSERT INTO Tags
		(Tag,									Vocabulary)
VALUES	('CLASS_SAILOR_ATLEER_UU',				'ABILITY_CLASS');

-----------------------------------------------	
-- Types
-----------------------------------------------	
INSERT INTO Types
		(Type,									Kind)
VALUES	('UNIT_SAILOR_ATLEER_UU',				'KIND_UNIT'),
		('ABILITY_SAILOR_ATLEER_UU_ROLLING',	'KIND_ABILITY');

-----------------------------------------------	
-- TypeTags
-----------------------------------------------	
INSERT INTO TypeTags
		(Type,									Tag)
VALUES	('UNIT_SAILOR_ATLEER_UU',				'CLASS_SAILOR_ATLEER_UU'),
		('ABILITY_SAILOR_ATLEER_UU_ROLLING',	'CLASS_SAILOR_ATLEER_UU');

INSERT INTO TypeTags
		(Type,									Tag)
SELECT	'UNIT_SAILOR_ATLEER_UU',				Tag
FROM TypeTags WHERE Type = 'UNIT_SCOUT';

-----------------------------------------------
-- Units
-----------------------------------------------
INSERT INTO Units	(
		UnitType,
		Name,
		Description,
		TraitType,
		BaseMoves,
		Cost,
		StrategicResource,
		PurchaseYield,
		AdvisorType,
		Combat,
		BaseSightRange,
		ZoneOfControl,
		Domain,
		FormationClass,
		PromotionClass,
		Maintenance
		)
SELECT	'UNIT_SAILOR_ATLEER_UU', -- UnitType
		'LOC_UNIT_SAILOR_ATLEER_UU_NAME', -- Name
		'LOC_UNIT_SAILOR_ATLEER_UU_DESCRIPTION', -- Description
		'TRAIT_CIVILIZATION_UNIT_SAILOR_ATLEER_UU', -- TraitType
		BaseMoves,
		Cost - 5,
		StrategicResource,
		PurchaseYield,
		AdvisorType,
		Combat,
		BaseSightRange,
		ZoneOfControl,
		Domain,
		FormationClass,
		PromotionClass,
		Maintenance
FROM	Units
WHERE	UnitType = 'UNIT_SCOUT';

-----------------------------------------------
-- UnitReplaces
-----------------------------------------------
INSERT INTO UnitReplaces
		(CivUniqueUnitType,			ReplacesUnitType)
VALUES	('UNIT_SAILOR_ATLEER_UU',	'UNIT_SCOUT');

-----------------------------------------------
-- UnitUpgrades
-----------------------------------------------
INSERT INTO UnitUpgrades
		(Unit,						UpgradeUnit)
SELECT 	'UNIT_SAILOR_ATLEER_UU',	UpgradeUnit
FROM UnitUpgrades WHERE Unit = 'UNIT_SCOUT';

-----------------------------------------------
-- UnitAiInfos
-----------------------------------------------
INSERT INTO UnitAiInfos
		(UnitType,					AiType)
SELECT	'UNIT_SAILOR_ATLEER_UU',	AiType
FROM UnitAiInfos WHERE UnitType = 'UNIT_SCOUT';

-----------------------------------------------
-- UnitAbilities
-----------------------------------------------
INSERT INTO UnitAbilities
		(UnitAbilityType,						Name,											Description)
VALUES	('ABILITY_SAILOR_ATLEER_UU_ROLLING',	'LOC_ABILITY_SAILOR_ATLEER_UU_ROLLING_NAME',	'LOC_ABILITY_SAILOR_ATLEER_UU_ROLLING_NAME');

-----------------------------------------------
--  UnitAbilityModifiers
-----------------------------------------------
INSERT INTO UnitAbilityModifiers
		(UnitAbilityType,						ModifierId)
VALUES	('ABILITY_SAILOR_ATLEER_UU_ROLLING',	'ABILITY_SAILOR_ATLEER_UU_ROLLING_MOD');

-----------------------------------------------
-- Modifiers
-----------------------------------------------
INSERT INTO	Modifiers
		(ModifierId,								ModifierType,								Permanent,	SubjectRequirementSetId)
VALUES	('ABILITY_SAILOR_ATLEER_UU_ROLLING_MOD',	'MODIFIER_PLAYER_UNIT_ADJUST_MOVEMENT',		0,			'SAILOR_ATLEER_UU_HILLS_REQUIREMENT');

-----------------------------------------------
-- ModifierArguments
-----------------------------------------------
INSERT INTO	ModifierArguments
		(ModifierId,								Name,		Value)
VALUES	('ABILITY_SAILOR_ATLEER_UU_ROLLING_MOD',	'Amount',	2);

-----------------------------------------------		
-- RequirementSets
-----------------------------------------------
INSERT INTO RequirementSets
		(RequirementSetId,							RequirementSetType)
VALUES	('SAILOR_ATLEER_UU_HILLS_REQUIREMENT',		'REQUIREMENTSET_TEST_ALL');

-----------------------------------------------
-- RequirementSetRequirements
-----------------------------------------------
INSERT INTO RequirementSetRequirements
		(RequirementSetId,							RequirementId)
VALUES  ('SAILOR_ATLEER_UU_HILLS_REQUIREMENT',		'PLOT_IS_HILLS_REQUIREMENT');