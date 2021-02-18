--=============================================
-- Lydie & Suelle / Defines
--=============================================
-----------------------------------------------
-- Types
-----------------------------------------------	
INSERT INTO Types	
		(Type,					Kind)
VALUES	('LEADER_SAILOR_LNS',	'KIND_LEADER');

-----------------------------------------------	
-- Leaders
-----------------------------------------------	
INSERT INTO Leaders	
		(LeaderType,			Name,							Sex,		InheritFrom,		SceneLayers)
VALUES	('LEADER_SAILOR_LNS',	'LOC_LEADER_SAILOR_LNS_NAME',	'Female',	'LEADER_DEFAULT',	4);	

-----------------------------------------------
-- CivilizationLeaders
-----------------------------------------------	
INSERT INTO CivilizationLeaders	
		(CivilizationType,					LeaderType,				CapitalName)
VALUES	('CIVILIZATION_SAILOR_ATLEER',		'LEADER_SAILOR_LNS',	'LOC_CITY_NAME_SAILOR_MERVEILLE');

-----------------------------------------------
-- LeaderQuotes
-----------------------------------------------	
INSERT INTO LeaderQuotes	
		(LeaderType,			Quote)
VALUES	('LEADER_SAILOR_LNS',	'LOC_PEDIA_LEADERS_PAGE_LEADER_SAILOR_LNS_QUOTE');	

-----------------------------------------------	
-- LoadingInfo
-----------------------------------------------	
INSERT INTO LoadingInfo	
		(LeaderType,			BackgroundImage, 					ForegroundImage,				PlayDawnOfManAudio)
VALUES	('LEADER_SAILOR_LNS',	'LEADER_SAILOR_LNS_BACKGROUND',		'LEADER_SAILOR_LNS_NEUTRAL',	0);	
