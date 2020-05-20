-- / Alchemist Unit
UPDATE Buildings SET Name = 'LOC_BUILDING_SAILOR_ALCHEMIST_SHOP_ALT_NAME' WHERE BuildingType = 'BUILDING_SAILOR_ALCHEMIST_SHOP' AND EXISTS (SELECT BuildingType FROM Buildings WHERE BuildingType = 'BUILDING_SAILOR_ALCHEMIST_SHOP');
-- / End

-- / YNAEMP
CREATE TABLE IF NOT EXISTS StartPosition (MapName TEXT, Civilization TEXT, Leader TEXT, X INT default 0, Y INT default 0);

INSERT INTO StartPosition
		(Civilization,						Leader,				MapName,			X,		Y)
SELECT	'CIVILIZATION_SAILOR_ATLEER',		LeaderType,			'GiantEarth',		20,		66
FROM	CivilizationLeaders
WHERE	CivilizationType = 'CIVILIZATION_SAILOR_ATLEER';

INSERT INTO StartPosition
		(Civilization,						Leader,				MapName,			X,		Y)
SELECT	'CIVILIZATION_SAILOR_ATLEER',		LeaderType,			'GreatestEarthMap',	48,		50
FROM	CivilizationLeaders
WHERE	CivilizationType = 'CIVILIZATION_SAILOR_ATLEER';

INSERT INTO StartPosition
		(Civilization,						Leader,				MapName,			X,		Y)
SELECT	'CIVILIZATION_SAILOR_ATLEER',		LeaderType,			'CordiformEarth',	39,		30
FROM	CivilizationLeaders
WHERE	CivilizationType = 'CIVILIZATION_SAILOR_ATLEER';

INSERT INTO StartPosition
		(Civilization,						Leader,				MapName,			X,		Y)
SELECT	'CIVILIZATION_SAILOR_ATLEER',		LeaderType,			'PlayEuropeAgain',	39,		30
FROM	CivilizationLeaders
WHERE	CivilizationType = 'CIVILIZATION_SAILOR_ATLEER';

INSERT INTO StartPosition
		(Civilization,						Leader,				MapName,			X,		Y)
SELECT	'CIVILIZATION_SAILOR_ATLEER',		LeaderType,			'LargeEurope',		39,		30
FROM	CivilizationLeaders
WHERE	CivilizationType = 'CIVILIZATION_SAILOR_ATLEER';
-- / End

-- / Sui Generis
CREATE TABLE IF NOT EXISTS SG_Civ_Assignments (
        SG_CivilizationType      text,
        SG_LeaderCategory        text,
        PRIMARY KEY (SG_CivilizationType)
        );

INSERT OR REPLACE INTO SG_Civ_Assignments
        (SG_CivilizationType,			SG_LeaderCategory)
VALUES  ('CIVILIZATION_SAILOR_ATLEER',  'SG_LEADER_CENTRAL_EUROPEAN');
-- / End