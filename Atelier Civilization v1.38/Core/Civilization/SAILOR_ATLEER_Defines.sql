--=============================================
-- Atelier Civ / Defines
--=============================================
-----------------------------------------------
-- Types
-----------------------------------------------
INSERT INTO Types	
		(Type,									Kind)
VALUES	('CIVILIZATION_SAILOR_ATLEER',		'KIND_CIVILIZATION');

-----------------------------------------------
-- Civilizations
-----------------------------------------------	
INSERT INTO Civilizations	(
		CivilizationType,
		Name,
		Description,
		Adjective,
		StartingCivilizationLevelType,
		RandomCityNameDepth,
		Ethnicity
		)
VALUES	(
		'CIVILIZATION_SAILOR_ATLEER', -- CivilizationType
		'LOC_CIVILIZATION_SAILOR_ATLEER_NAME', -- Name
		'LOC_CIVILIZATION_SAILOR_ATLEER_DESCRIPTION', -- Description
		'LOC_CIVILIZATION_SAILOR_ATLEER_ADJECTIVE', -- Adjective
		'CIVILIZATION_LEVEL_FULL_CIV', -- StartingCivilizationLevelType
		38, -- RandomCityNameDepth
		'ETHNICITY_EURO' -- Ethnicity
		);	

-----------------------------------------------			
-- CityNames			
-----------------------------------------------		
INSERT INTO CityNames	
		(CivilizationType,			    CityName)	
VALUES	('CIVILIZATION_SAILOR_ATLEER', 'LOC_CITY_NAME_SAILOR_ARLAND'),			--1
		('CIVILIZATION_SAILOR_ATLEER', 'LOC_CITY_NAME_SAILOR_RIESENGANG'),		--2
		('CIVILIZATION_SAILOR_ATLEER', 'LOC_CITY_NAME_SAILOR_VIERZEBERG'),		--3
		('CIVILIZATION_SAILOR_ATLEER', 'LOC_CITY_NAME_SAILOR_HORNHEIM'),		--4
		('CIVILIZATION_SAILOR_ATLEER', 'LOC_CITY_NAME_SAILOR_ALANYA'),			--5
		('CIVILIZATION_SAILOR_ATLEER', 'LOC_CITY_NAME_SAILOR_FLUSSHEIM'),		--6
		('CIVILIZATION_SAILOR_ATLEER', 'LOC_CITY_NAME_SAILOR_FLOCKE'),			--7
		('CIVILIZATION_SAILOR_ATLEER', 'LOC_CITY_NAME_SAILOR_WEISSLARK'),		--8
		('CIVILIZATION_SAILOR_ATLEER', 'LOC_CITY_NAME_SAILOR_GRAU_TAL'),		--9
		('CIVILIZATION_SAILOR_ATLEER', 'LOC_CITY_NAME_SAILOR_MERVEILLE'),		--10
		('CIVILIZATION_SAILOR_ATLEER', 'LOC_CITY_NAME_SAILOR_KIRCHEN_BELL'),	--11
		('CIVILIZATION_SAILOR_ATLEER', 'LOC_CITY_NAME_SAILOR_STELLARD'),		--12
		('CIVILIZATION_SAILOR_ATLEER', 'LOC_CITY_NAME_SAILOR_ARLS'),			--13
		('CIVILIZATION_SAILOR_ATLEER', 'LOC_CITY_NAME_SAILOR_SALBURG'),			--14
		('CIVILIZATION_SAILOR_ATLEER', 'LOC_CITY_NAME_SAILOR_GRAMNAD'),			--15
		('CIVILIZATION_SAILOR_ATLEER', 'LOC_CITY_NAME_SAILOR_KANALLAND'),		--16
		('CIVILIZATION_SAILOR_ATLEER', 'LOC_CITY_NAME_SAILOR_KAROTTE'),			--17
		('CIVILIZATION_SAILOR_ATLEER', 'LOC_CITY_NAME_SAILOR_REGALLZINE'),		--18
		('CIVILIZATION_SAILOR_ATLEER', 'LOC_CITY_NAME_SAILOR_ZEY_MERUZE'),		--19
		('CIVILIZATION_SAILOR_ATLEER', 'LOC_CITY_NAME_SAILOR_AL_REVIS'),		--20
		('CIVILIZATION_SAILOR_ATLEER', 'LOC_CITY_NAME_SAILOR_ARKLYS'),			--21
		('CIVILIZATION_SAILOR_ATLEER', 'LOC_CITY_NAME_SAILOR_ERTONA'),			--22
		('CIVILIZATION_SAILOR_ATLEER', 'LOC_CITY_NAME_SAILOR_LUGION'),			--23
		('CIVILIZATION_SAILOR_ATLEER', 'LOC_CITY_NAME_SAILOR_MYSLEE'),			--24
		('CIVILIZATION_SAILOR_ATLEER', 'LOC_CITY_NAME_SAILOR_VESTABALT'),		--25
		('CIVILIZATION_SAILOR_ATLEER', 'LOC_CITY_NAME_SAILOR_BRESSISLE'),		--26
		('CIVILIZATION_SAILOR_ATLEER', 'LOC_CITY_NAME_SAILOR_REISENBERG'),		--27
		('CIVILIZATION_SAILOR_ATLEER', 'LOC_CITY_NAME_SAILOR_LUGION'),			--28
		('CIVILIZATION_SAILOR_ATLEER', 'LOC_CITY_NAME_SAILOR_COLSEIT'),			--29
		('CIVILIZATION_SAILOR_ATLEER', 'LOC_CITY_NAME_SAILOR_KAVOC'),			--30
		('CIVILIZATION_SAILOR_ATLEER', 'LOC_CITY_NAME_SAILOR_WESTWALD'),		--31
		('CIVILIZATION_SAILOR_ATLEER', 'LOC_CITY_NAME_SAILOR_CENTRAL_CITY'),	--33
		('CIVILIZATION_SAILOR_ATLEER', 'LOC_CITY_NAME_SAILOR_DURAN'),			--34
		('CIVILIZATION_SAILOR_ATLEER', 'LOC_CITY_NAME_SAILOR_RIESEVELT'),		--35
		('CIVILIZATION_SAILOR_ATLEER', 'LOC_CITY_NAME_SAILOR_HAFEN'),			--36
		('CIVILIZATION_SAILOR_ATLEER', 'LOC_CITY_NAME_SAILOR_FASSBINDER'),		--37
		('CIVILIZATION_SAILOR_ATLEER', 'LOC_CITY_NAME_SAILOR_METTERBURG');		--38

-----------------------------------------------
-- CivilizationCitizenNames
-----------------------------------------------	
INSERT INTO CivilizationCitizenNames	
		(CivilizationType,				CitizenName,									Female,		Modern)
VALUES	('CIVILIZATION_SAILOR_ATLEER',	'LOC_CITIZEN_SAILOR_ATLEER_MALE_1',				0,			0),
		('CIVILIZATION_SAILOR_ATLEER',	'LOC_CITIZEN_SAILOR_ATLEER_MALE_2',				0,			0),
		('CIVILIZATION_SAILOR_ATLEER',	'LOC_CITIZEN_SAILOR_ATLEER_MALE_3',				0,			0),
		('CIVILIZATION_SAILOR_ATLEER',	'LOC_CITIZEN_SAILOR_ATLEER_MALE_4',				0,			0),
		('CIVILIZATION_SAILOR_ATLEER',	'LOC_CITIZEN_SAILOR_ATLEER_MALE_5',				0,			0),
		('CIVILIZATION_SAILOR_ATLEER',	'LOC_CITIZEN_SAILOR_ATLEER_MALE_6',				0,			0),
		('CIVILIZATION_SAILOR_ATLEER',	'LOC_CITIZEN_SAILOR_ATLEER_MALE_7',				0,			0),
		('CIVILIZATION_SAILOR_ATLEER',	'LOC_CITIZEN_SAILOR_ATLEER_MALE_8',				0,			0),
		('CIVILIZATION_SAILOR_ATLEER',	'LOC_CITIZEN_SAILOR_ATLEER_MALE_9',				0,			0),
		('CIVILIZATION_SAILOR_ATLEER',	'LOC_CITIZEN_SAILOR_ATLEER_MALE_10',			0,			0),
		('CIVILIZATION_SAILOR_ATLEER',	'LOC_CITIZEN_SAILOR_ATLEER_FEMALE_1',			1,			0),
		('CIVILIZATION_SAILOR_ATLEER',	'LOC_CITIZEN_SAILOR_ATLEER_FEMALE_2',			1,			0),
		('CIVILIZATION_SAILOR_ATLEER',	'LOC_CITIZEN_SAILOR_ATLEER_FEMALE_3',			1,			0),
		('CIVILIZATION_SAILOR_ATLEER',	'LOC_CITIZEN_SAILOR_ATLEER_FEMALE_4',			1,			0),
		('CIVILIZATION_SAILOR_ATLEER',	'LOC_CITIZEN_SAILOR_ATLEER_FEMALE_5',			1,			0),
		('CIVILIZATION_SAILOR_ATLEER',	'LOC_CITIZEN_SAILOR_ATLEER_FEMALE_6',			1,			0),
		('CIVILIZATION_SAILOR_ATLEER',	'LOC_CITIZEN_SAILOR_ATLEER_FEMALE_7',			1,			0),
		('CIVILIZATION_SAILOR_ATLEER',	'LOC_CITIZEN_SAILOR_ATLEER_FEMALE_8',			1,			0),
		('CIVILIZATION_SAILOR_ATLEER',	'LOC_CITIZEN_SAILOR_ATLEER_FEMALE_9',			1,			0),
		('CIVILIZATION_SAILOR_ATLEER',	'LOC_CITIZEN_SAILOR_ATLEER_FEMALE_10',			1,			0),
		('CIVILIZATION_SAILOR_ATLEER',	'LOC_CITIZEN_SAILOR_ATLEER_MODERN_MALE_1',		0,			1),
		('CIVILIZATION_SAILOR_ATLEER',	'LOC_CITIZEN_SAILOR_ATLEER_MODERN_MALE_2',		0,			1),
		('CIVILIZATION_SAILOR_ATLEER',	'LOC_CITIZEN_SAILOR_ATLEER_MODERN_MALE_3',		0,			1),
		('CIVILIZATION_SAILOR_ATLEER',	'LOC_CITIZEN_SAILOR_ATLEER_MODERN_MALE_4',		0,			1),
		('CIVILIZATION_SAILOR_ATLEER',	'LOC_CITIZEN_SAILOR_ATLEER_MODERN_MALE_5',		0,			1),
		('CIVILIZATION_SAILOR_ATLEER',	'LOC_CITIZEN_SAILOR_ATLEER_MODERN_MALE_6',		0,			1),
		('CIVILIZATION_SAILOR_ATLEER',	'LOC_CITIZEN_SAILOR_ATLEER_MODERN_MALE_7',		0,			1),
		('CIVILIZATION_SAILOR_ATLEER',	'LOC_CITIZEN_SAILOR_ATLEER_MODERN_MALE_8',		0,			1),
		('CIVILIZATION_SAILOR_ATLEER',	'LOC_CITIZEN_SAILOR_ATLEER_MODERN_MALE_9',		0,			1),
		('CIVILIZATION_SAILOR_ATLEER',	'LOC_CITIZEN_SAILOR_ATLEER_MODERN_MALE_10',		0,			1),
		('CIVILIZATION_SAILOR_ATLEER',	'LOC_CITIZEN_SAILOR_ATLEER_MODERN_FEMALE_1',	1,			1),
		('CIVILIZATION_SAILOR_ATLEER',	'LOC_CITIZEN_SAILOR_ATLEER_MODERN_FEMALE_2',	1,			1),
		('CIVILIZATION_SAILOR_ATLEER',	'LOC_CITIZEN_SAILOR_ATLEER_MODERN_FEMALE_3',	1,			1),
		('CIVILIZATION_SAILOR_ATLEER',	'LOC_CITIZEN_SAILOR_ATLEER_MODERN_FEMALE_4',	1,			1),
		('CIVILIZATION_SAILOR_ATLEER',	'LOC_CITIZEN_SAILOR_ATLEER_MODERN_FEMALE_5',	1,			1),
		('CIVILIZATION_SAILOR_ATLEER',	'LOC_CITIZEN_SAILOR_ATLEER_MODERN_FEMALE_6',	1,			1),
		('CIVILIZATION_SAILOR_ATLEER',	'LOC_CITIZEN_SAILOR_ATLEER_MODERN_FEMALE_7',	1,			1),
		('CIVILIZATION_SAILOR_ATLEER',	'LOC_CITIZEN_SAILOR_ATLEER_MODERN_FEMALE_8',	1,			1),
		('CIVILIZATION_SAILOR_ATLEER',	'LOC_CITIZEN_SAILOR_ATLEER_MODERN_FEMALE_9',	1,			1),
		('CIVILIZATION_SAILOR_ATLEER',	'LOC_CITIZEN_SAILOR_ATLEER_MODERN_FEMALE_10',	1,			1);	

-----------------------------------------------			
-- CivilizationInfo			
-----------------------------------------------		
/*INSERT INTO CivilizationInfo	
		(CivilizationType,				Header,						Caption,									SortIndex)	
VALUES	('CIVILIZATION_SAILOR_ATLEER',	'LOC_CIVINFO_LOCATION',		'LOC_CIVINFO_SAILOR_ATLEER_LOCATION',		10),	
		('CIVILIZATION_SAILOR_ATLEER',	'LOC_CIVINFO_SIZE',			'LOC_CIVINFO_SAILOR_ATLEER_SIZE',			20),	
		('CIVILIZATION_SAILOR_ATLEER',	'LOC_CIVINFO_POPULATION',	'LOC_CIVINFO_SAILOR_ATLEER_POPULATION',		30),	
		('CIVILIZATION_SAILOR_ATLEER',	'LOC_CIVINFO_CAPITAL', 		'LOC_CIVINFO_SAILOR_ATLEER_CAPITAL',		40);*/

-----------------------------------------------			
-- StartBias
-----------------------------------------------	
INSERT INTO StartBiasResources
		(CivilizationType,				ResourceType,	Tier)
SELECT	'CIVILIZATION_SAILOR_ATLEER',	ResourceType,	2
FROM Resources;

-----------------------------------------------			
-- UnitNames
-----------------------------------------------	
INSERT INTO UnitNames
		(ID,				NameType,			TextKey)
SELECT	MAX(ID)+1 AS ID,	'SUFFIX_ALL',		'LOC_UNITNAME_SUFFIX_SAILOR_ALCHEMIST'
FROM UnitNames;

INSERT INTO UnitNames
		(ID,				NameType,			TextKey)
SELECT	MAX(ID)+1 AS ID,	'SUFFIX_MONK',		'LOC_UNITNAME_SUFFIX_SAILOR_ALCHEMIST'
FROM UnitNames;

INSERT INTO UnitNames
		(ID,				NameType,			TextKey)
SELECT	MAX(ID)+1 AS ID,	'SUFFIX_RECON',		'LOC_UNITNAME_SUFFIX_SAILOR_ALCHEMIST'
FROM UnitNames;

INSERT INTO UnitNames
		(ID,				NameType,			TextKey)
SELECT	MAX(ID)+1 AS ID,	'SUFFIX_CAVALRY',	'LOC_UNITNAME_SUFFIX_SAILOR_ALCHEMIST'
FROM UnitNames;

INSERT INTO UnitNames
		(ID,				NameType,			TextKey)
SELECT	MAX(ID)+1 AS ID,	'SUFFIX_RANGED',	'LOC_UNITNAME_SUFFIX_SAILOR_ALCHEMIST'
FROM UnitNames;