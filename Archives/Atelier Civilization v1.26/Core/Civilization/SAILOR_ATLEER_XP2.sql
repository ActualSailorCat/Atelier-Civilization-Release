--=============================================
-- Atleer Civ / Gathering Storm
--=============================================
UPDATE Traits SET Description = 'LOC_TRAIT_CIVILIZATION_SAILOR_ATLEER_UA_XP2_DESCRIPTION' WHERE TraitType = 'TRAIT_CIVILIZATION_SAILOR_ATLEER_UA';

-----------------------------------------------		
-- TraitModifiers		
-----------------------------------------------
INSERT INTO ImprovementModifiers
		(ImprovementType,		ModifierId)
SELECT	ImprovementType,		'SAILOR_ATLEER_UA_EARLY_MASS_SYNTHESIS_'||ResourceType
FROM Improvement_ValidResources WHERE (ResourceType IN (SELECT ResourceType FROM Resources WHERE ResourceClassType = 'RESOURCECLASS_STRATEGIC'))
AND (ResourceType NOT IN (SELECT ResourceMaintenanceType FROM Units_XP2 WHERE ResourceMainTenanceType IS NOT NULL));

INSERT INTO ImprovementModifiers
		(ImprovementType,		ModifierId)
SELECT	ImprovementType,		'SAILOR_ATLEER_UA_LATE_MASS_SYNTHESIS_'||ResourceType
FROM Improvement_ValidResources WHERE (ResourceType IN (SELECT ResourceType FROM Resources WHERE ResourceClassType = 'RESOURCECLASS_STRATEGIC'))
AND (ResourceType IN (SELECT ResourceMaintenanceType FROM Units_XP2 WHERE ResourceMainTenanceType IS NOT NULL));

-----------------------------------------------		
-- Modifiers		
-----------------------------------------------
INSERT INTO Modifiers
		(ModifierId,											Permanent,	RunOnce,	ModifierType,									OwnerRequirementSetId,					SubjectRequirementSetId)
SELECT	'SAILOR_ATLEER_UA_EARLY_MASS_SYNTHESIS_'||ResourceType,	0,			1,			'MODIFIER_SINGLE_CITY_GRANT_RESOURCE_IN_CITY', 'SAILOR_REQUIRES_ATLEER_REQUIREMENT',	'SAILOR_ATLEER_UA_'||ResourceType||'_REQUIREMENT'
FROM Resources WHERE ResourceClassType = 'RESOURCECLASS_STRATEGIC'
AND (ResourceType NOT IN (SELECT ResourceMaintenanceType FROM Units_XP2 WHERE ResourceMainTenanceType IS NOT NULL));

INSERT INTO Modifiers
		(ModifierId,											Permanent,	RunOnce,	ModifierType,									OwnerRequirementSetId,					SubjectRequirementSetId)
SELECT	'SAILOR_ATLEER_UA_LATE_MASS_SYNTHESIS_'||ResourceType,	0,			1,			'MODIFIER_SINGLE_CITY_GRANT_RESOURCE_IN_CITY', 'SAILOR_REQUIRES_ATLEER_REQUIREMENT',	'SAILOR_ATLEER_UA_'||ResourceType||'_REQUIREMENT'
FROM Resources WHERE ResourceClassType = 'RESOURCECLASS_STRATEGIC'
AND (ResourceType IN (SELECT ResourceMaintenanceType FROM Units_XP2 WHERE ResourceMainTenanceType IS NOT NULL));

-----------------------------------------------		
-- ModifierArguments
-----------------------------------------------
INSERT INTO ModifierArguments
		(ModifierId,													Name,				Value)
SELECT	'SAILOR_ATLEER_UA_EARLY_MASS_SYNTHESIS_'||ResourceType,			'Amount',			ImprovedExtractionRate * 5
FROM Resource_Consumption WHERE (ResourceType IN (SELECT ResourceType FROM Resources WHERE ResourceClassType = 'RESOURCECLASS_STRATEGIC'))
AND (ResourceType NOT IN (SELECT ResourceMaintenanceType FROM Units_XP2 WHERE ResourceMainTenanceType IS NOT NULL));

INSERT INTO ModifierArguments
		(ModifierId,													Name,				Value)
SELECT	'SAILOR_ATLEER_UA_EARLY_MASS_SYNTHESIS_'||ResourceType,			'ResourceType',		ResourceType
FROM Resource_Consumption WHERE (ResourceType IN (SELECT ResourceType FROM Resources WHERE ResourceClassType = 'RESOURCECLASS_STRATEGIC'))
AND (ResourceType NOT IN (SELECT ResourceMaintenanceType FROM Units_XP2 WHERE ResourceMainTenanceType IS NOT NULL));

INSERT INTO ModifierArguments
		(ModifierId,													Name,				Value)
SELECT	'SAILOR_ATLEER_UA_LATE_MASS_SYNTHESIS_'||ResourceType,			'Amount',			ImprovedExtractionRate * 5
FROM Resource_Consumption WHERE (ResourceType IN (SELECT ResourceType FROM Resources WHERE ResourceClassType = 'RESOURCECLASS_STRATEGIC'))
AND (ResourceType IN (SELECT ResourceMaintenanceType FROM Units_XP2 WHERE ResourceMainTenanceType IS NOT NULL));

INSERT INTO ModifierArguments
		(ModifierId,													Name,				Value)
SELECT	'SAILOR_ATLEER_UA_LATE_MASS_SYNTHESIS_'||ResourceType,			'ResourceType',		ResourceType
FROM Resource_Consumption WHERE (ResourceType IN (SELECT ResourceType FROM Resources WHERE ResourceClassType = 'RESOURCECLASS_STRATEGIC'))
AND (ResourceType IN (SELECT ResourceMaintenanceType FROM Units_XP2 WHERE ResourceMainTenanceType IS NOT NULL));

-----------------------------------------------		
-- RequirementSets
-----------------------------------------------
INSERT INTO RequirementSets
		(RequirementSetId,							RequirementSetType)
VALUES	('SAILOR_REQUIRES_ATLEER_REQUIREMENT',		'REQUIREMENTSET_TEST_ANY');

INSERT INTO RequirementSets
		(RequirementSetId,									RequirementSetType)
SELECT	'SAILOR_ATLEER_UA_'||ResourceType||'_REQUIREMENT',	'REQUIREMENTSET_TEST_ALL'
FROM Resources WHERE ResourceClassType = 'RESOURCECLASS_STRATEGIC';

-----------------------------------------------
-- RequirementSetRequirements
-----------------------------------------------
INSERT INTO RequirementSetRequirements
		(RequirementSetId,							RequirementId)
VALUES	('SAILOR_REQUIRES_ATLEER_REQUIREMENT',		'SAILOR_REQUIRES_ATLEER_TOTORI'),
		('SAILOR_REQUIRES_ATLEER_REQUIREMENT',		'SAILOR_REQUIRES_ATLEER_LNS');

INSERT INTO RequirementSetRequirements
		(RequirementSetId,										RequirementId)
SELECT	'SAILOR_ATLEER_UA_'||ResourceType||'_REQUIREMENT',		'SAILOR_ATLEER_UA_REQUIRES_'||ResourceType
FROM Resources WHERE ResourceClassType = 'RESOURCECLASS_STRATEGIC';

-- / Future leader support...
CREATE TRIGGER IF NOT EXISTS SailorAtleerLeaderFishing
AFTER INSERT ON CivilizationLeaders
WHEN NEW.CivilizationType = 'CIVILIZATION_SAILOR_ATLEER'
BEGIN
INSERT OR REPLACE INTO RequirementSetRequirements (RequirementSetId, RequirementId) VALUES ('SAILOR_REQUIRES_ATLEER_REQUIREMENT', 'SAILOR_REQUIRES_'||NEW.LeaderType);
INSERT OR REPLACE INTO Requirements (RequirementId, RequirementType) VALUES ('SAILOR_REQUIRES_'||NEW.LeaderType, 'REQUIREMENT_PLAYER_LEADER_TYPE_MATCHES');
INSERT OR REPLACE INTO RequirementArguments (RequirementId, Name, Value) VALUES ('SAILOR_REQUIRES_'||NEW.LeaderType, 'LeaderType', NEW.LeaderType);
END;
-- /

-----------------------------------------------
-- Requirements
-----------------------------------------------
INSERT INTO Requirements
		(RequirementId, 						RequirementType)
VALUES	('SAILOR_REQUIRES_ATLEER_TOTORI',		'REQUIREMENT_PLAYER_LEADER_TYPE_MATCHES'),
		('SAILOR_REQUIRES_ATLEER_LNS',			'REQUIREMENT_PLAYER_LEADER_TYPE_MATCHES');

INSERT INTO Requirements
		(RequirementId, 								RequirementType)
SELECT	'SAILOR_ATLEER_UA_REQUIRES_'||ResourceType,		'REQUIREMENT_PLOT_RESOURCE_TYPE_MATCHES'
FROM Resources WHERE ResourceClassType = 'RESOURCECLASS_STRATEGIC';

-----------------------------------------------
-- RequirementArguments
-----------------------------------------------
INSERT INTO RequirementArguments
		(RequirementId, 						Name,			Value)
VALUES	('SAILOR_REQUIRES_ATLEER_TOTORI',		'LeaderType',	'LEADER_SAILOR_TOTORI'),
		('SAILOR_REQUIRES_ATLEER_LNS',			'LeaderType',	'LEADER_SAILOR_LNS');

INSERT INTO RequirementArguments
		(RequirementId, 								Name,			Value)
SELECT	'SAILOR_ATLEER_UA_REQUIRES_'||ResourceType,		'ResourceType',	ResourceType
FROM Resources WHERE ResourceClassType = 'RESOURCECLASS_STRATEGIC';

--=============================================
-- Atleer Civ / Named Items
--=============================================
-----------------------------------------------
-- Types
-----------------------------------------------
INSERT INTO Types
		(Type,												Kind)
VALUES	-- Mountains
		('NAMED_SAILOR_MOUNTAIN_CALAMITOUS_MOUNTAINS',		'KIND_NAMED_MOUNTAIN'),
		('NAMED_SAILOR_MOUNTAIN_STER_HIGHLANDS',			'KIND_NAMED_MOUNTAIN'),
		('NAMED_SAILOR_MOUNTAIN_MORRAKIS_RANGE',			'KIND_NAMED_MOUNTAIN'),
		-- Rivers
		('NAMED_SAILOR_RIVER_MORNING_MIST_RIVER',			'KIND_NAMED_RIVER'),
		('NAMED_SAILOR_RIVER_STRUDEL_RIVER',				'KIND_NAMED_RIVER'),
		('NAMED_SAILOR_RIVER_FORGETFUL_STREAM',				'KIND_NAMED_RIVER'),
		('NAMED_SAILOR_RIVER_ABANDONED_RIVER',				'KIND_NAMED_RIVER'),
		-- Deserts	
		('NAMED_SAILOR_DESERT_DUSK_SEA',					'KIND_NAMED_DESERT'),
		('NAMED_SAILOR_DESERT_SCORCHED_WASTELAND',			'KIND_NAMED_DESERT'),
		('NAMED_SAILOR_DESERT_WITHERING_PLAINS',			'KIND_NAMED_DESERT'),
		('NAMED_SAILOR_DESERT_SEARING_WASTES',				'KIND_NAMED_DESERT'),
		('NAMED_SAILOR_DESERT_BRAISEWEST_DESERT',			'KIND_NAMED_DESERT'),
		-- Volcanoes
		('NAMED_SAILOR_VOLCANO_GREAT_CASCADES_OF_ANFEL',	'KIND_NAMED_VOLCANO'),
		('NAMED_SAILOR_VOLCANO_FATALIA_SUMMIT',				'KIND_NAMED_VOLCANO'),
		('NAMED_SAILOR_VOLCANO_MOUNT_VELUS',				'KIND_NAMED_VOLCANO'),
		('NAMED_SAILOR_VOLCANO_MOUNT_WIELAND',				'KIND_NAMED_VOLCANO'),
		('NAMED_SAILOR_VOLCANO_MOUNT_GREUGNET',				'KIND_NAMED_VOLCANO'),
		('NAMED_SAILOR_VOLCANO_WEISSBERG_VOLCANO',			'KIND_NAMED_VOLCANO'),
		-- Lakes
		('NAMED_SAILOR_LAKE_NABEL_LAKE',					'KIND_NAMED_LAKE'),
		('NAMED_SAILOR_LAKE_SEA_DRAGON_POOL',				'KIND_NAMED_LAKE'),
		('NAMED_SAILOR_LAKE_TIMELOST_LAKE',					'KIND_NAMED_LAKE'),
		('NAMED_SAILOR_LAKE_LAKE_FORWEL',					'KIND_NAMED_LAKE'),
		('NAMED_SAILOR_LAKE_CRESCENT_LAKE',					'KIND_NAMED_LAKE'),
		('NAMED_SAILOR_LAKE_HEBEL_LAKE',					'KIND_NAMED_LAKE'),
		('NAMED_SAILOR_LAKE_PROSPECTORS_STRAND',			'KIND_NAMED_LAKE'),
		('NAMED_SAILOR_LAKE_LAKE_MIDGARD',					'KIND_NAMED_LAKE'),
		-- Seas
		('NAMED_SAILOR_SEA_TWILIGHT_OCEAN',					'KIND_NAMED_SEA'),
		('NAMED_SAILOR_SEA_WAVEBREAKER_COVE',				'KIND_NAMED_SEA');

-----------------------------------------------
-- NamedX
-----------------------------------------------
INSERT INTO NamedMountains
		(NamedMountainType,			Name)
SELECT	Type AS NamedMountainType,	'LOC_'||Type AS Name
FROM Types WHERE Type LIKE '%SAILOR_MOUNTAIN%';

INSERT INTO NamedRivers
		(NamedRiverType,			Name)
SELECT	Type AS NamedRiverType,	'LOC_'||Type AS Name
FROM Types WHERE Type LIKE '%SAILOR_RIVER%';

INSERT INTO NamedDeserts
		(NamedDesertType,			Name)
SELECT	Type AS NamedDesertType,	'LOC_'||Type AS Name
FROM Types WHERE Type LIKE '%SAILOR_DESERT%';

INSERT INTO NamedVolcanoes
		(NamedVolcanoType,			Name)
SELECT	Type AS NamedVolcanoType,	'LOC_'||Type AS Name
FROM Types WHERE Type LIKE '%SAILOR_VOLCANO%';

INSERT INTO NamedLakes
		(NamedLakeType,			Name)
SELECT	Type AS NamedLakeType,	'LOC_'||Type AS Name
FROM Types WHERE Type LIKE '%SAILOR_LAKE%';

INSERT INTO NamedSeas
		(NamedSeaType,			Name)
SELECT	Type AS NamedSeaType,	'LOC_'||Type AS Name
FROM Types WHERE Type LIKE '%SAILOR_SEA%';

-----------------------------------------------
-- NamedMountains
-----------------------------------------------
INSERT INTO NamedMountainCivilizations
		(CivilizationType,				NamedMountainType)
VALUES	('CIVILIZATION_SAILOR_ATLEER',	'NAMED_SAILOR_MOUNTAIN_CALAMITOUS_MOUNTAINS'),
		('CIVILIZATION_SAILOR_ATLEER',	'NAMED_SAILOR_MOUNTAIN_STER_HIGHLANDS'),
		('CIVILIZATION_SAILOR_ATLEER',	'NAMED_SAILOR_MOUNTAIN_MORRAKIS_RANGE');

-----------------------------------------------
-- NamedRivers
-----------------------------------------------
INSERT INTO NamedRiverCivilizations
		(CivilizationType,				NamedRiverType)
VALUES	('CIVILIZATION_SAILOR_ATLEER',	'NAMED_SAILOR_RIVER_MORNING_MIST_RIVER'),
		('CIVILIZATION_SAILOR_ATLEER',	'NAMED_SAILOR_RIVER_STRUDEL_RIVER'),
		('CIVILIZATION_SAILOR_ATLEER',	'NAMED_SAILOR_RIVER_FORGETFUL_STREAM'),
		('CIVILIZATION_SAILOR_ATLEER',	'NAMED_SAILOR_RIVER_ABANDONED_RIVER');

-----------------------------------------------
-- NamedDeserts
-----------------------------------------------
INSERT INTO NamedDesertCivilizations
		(CivilizationType,				NamedDesertType)
VALUES	('CIVILIZATION_SAILOR_ATLEER',	'NAMED_SAILOR_DESERT_DUSK_SEA'),
		('CIVILIZATION_SAILOR_ATLEER',	'NAMED_SAILOR_DESERT_SCORCHED_WASTELAND'),
		('CIVILIZATION_SAILOR_ATLEER',	'NAMED_SAILOR_DESERT_WITHERING_PLAINS'),
		('CIVILIZATION_SAILOR_ATLEER',	'NAMED_SAILOR_DESERT_SEARING_WASTES'),
		('CIVILIZATION_SAILOR_ATLEER',	'NAMED_SAILOR_DESERT_BRAISEWEST_DESERT');

-----------------------------------------------
-- NamedVolcanoCivilizations
-----------------------------------------------
INSERT INTO NamedVolcanoCivilizations
		(CivilizationType,				NamedVolcanoType)
VALUES	('CIVILIZATION_SAILOR_ATLEER',	'NAMED_SAILOR_VOLCANO_GREAT_CASCADES_OF_ANFEL'),
		('CIVILIZATION_SAILOR_ATLEER',	'NAMED_SAILOR_VOLCANO_FATALIA_SUMMIT'),
		('CIVILIZATION_SAILOR_ATLEER',	'NAMED_SAILOR_VOLCANO_MOUNT_VELUS'),
		('CIVILIZATION_SAILOR_ATLEER',	'NAMED_SAILOR_VOLCANO_MOUNT_WIELAND'),
		('CIVILIZATION_SAILOR_ATLEER',	'NAMED_SAILOR_VOLCANO_MOUNT_GREUGNET'),
		('CIVILIZATION_SAILOR_ATLEER',	'NAMED_SAILOR_VOLCANO_WEISSBERG_VOLCANO');

-----------------------------------------------
-- NamedLakeCivilizations
-----------------------------------------------
INSERT INTO NamedLakeCivilizations
		(CivilizationType,				NamedLakeType)
VALUES	('CIVILIZATION_SAILOR_ATLEER',	'NAMED_SAILOR_LAKE_NABEL_LAKE'),
		('CIVILIZATION_SAILOR_ATLEER',	'NAMED_SAILOR_LAKE_SEA_DRAGON_POOL'),
		('CIVILIZATION_SAILOR_ATLEER',	'NAMED_SAILOR_LAKE_TIMELOST_LAKE'),
		('CIVILIZATION_SAILOR_ATLEER',	'NAMED_SAILOR_LAKE_LAKE_FORWEL'),
		('CIVILIZATION_SAILOR_ATLEER',	'NAMED_SAILOR_LAKE_CRESCENT_LAKE'),
		('CIVILIZATION_SAILOR_ATLEER',	'NAMED_SAILOR_LAKE_HEBEL_LAKE'),
		('CIVILIZATION_SAILOR_ATLEER',	'NAMED_SAILOR_LAKE_PROSPECTORS_STRAND'),
		('CIVILIZATION_SAILOR_ATLEER',	'NAMED_SAILOR_LAKE_LAKE_MIDGARD');

-----------------------------------------------
-- NamedSeaCivilizations
-----------------------------------------------
INSERT INTO NamedSeaCivilizations
		(CivilizationType,				NamedSeaType)
VALUES	('CIVILIZATION_SAILOR_ATLEER',	'NAMED_SAILOR_SEA_TWILIGHT_OCEAN'),
		('CIVILIZATION_SAILOR_ATLEER',	'NAMED_SAILOR_SEA_WAVEBREAKER_COVE');