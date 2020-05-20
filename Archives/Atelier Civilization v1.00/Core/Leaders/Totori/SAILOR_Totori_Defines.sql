--=============================================
-- Totori / Defines
--=============================================
-----------------------------------------------
-- Types
-----------------------------------------------	
INSERT INTO Types	
		(Type,						Kind)
VALUES	('LEADER_SAILOR_TOTORI',	'KIND_LEADER');

-----------------------------------------------	
-- Leaders
-----------------------------------------------	
INSERT INTO Leaders	
		(LeaderType,				Name,								Sex,		InheritFrom,		SceneLayers)
VALUES	('LEADER_SAILOR_TOTORI',	'LOC_LEADER_SAILOR_TOTORI_NAME',	'Female',	'LEADER_DEFAULT',	4);	

-----------------------------------------------
-- CivilizationLeaders
-----------------------------------------------	
INSERT INTO CivilizationLeaders	
		(CivilizationType,					LeaderType,					CapitalName)
VALUES	('CIVILIZATION_SAILOR_ATLEER',		'LEADER_SAILOR_TOTORI',		'LOC_CITY_NAME_SAILOR_ALANYA');

-----------------------------------------------
-- LeaderQuotes
-----------------------------------------------	
INSERT INTO LeaderQuotes	
		(LeaderType,				Quote)
VALUES	('LEADER_SAILOR_TOTORI',	'LOC_PEDIA_LEADERS_PAGE_LEADER_SAILOR_TOTORI_QUOTE');	

-----------------------------------------------	
-- LoadingInfo
-----------------------------------------------	
INSERT INTO LoadingInfo	
		(LeaderType,				BackgroundImage, 						ForegroundImage,				PlayDawnOfManAudio)
VALUES	('LEADER_SAILOR_TOTORI',	'LEADER_SAILOR_TOTORI_BACKGROUND',		'LEADER_SAILOR_TOTORI_NEUTRAL',	0);	
