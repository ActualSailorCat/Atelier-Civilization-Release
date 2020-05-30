--=============================================
-- Totori / AI
--=============================================
-----------------------------------------------	
-- AiListTypes
-----------------------------------------------	
INSERT INTO AiListTypes	
		(ListType)
VALUES	('SAILOR_TOTORI_Civics'),
		('SAILOR_TOTORI_Techs'),
		('SAILOR_TOTORI_Buildings'),
		('SAILOR_TOTORI_Districts'),
		('SAILOR_TOTORI_Improvements'),
		('SAILOR_TOTORI_PseudoYields'),
		('SAILOR_TOTORI_Exploration'),
		('SAILOR_TOTORI_Yields'),
		('SAILOR_TOTORI_Units'),
		('SAILOR_TOTORI_Settle'),
		('SAILOR_TOTORI_Diploaction'),
		('SAILOR_TOTORI_PlotEvaluation');

-----------------------------------------------	
-- AiLists
-----------------------------------------------	
INSERT INTO AiLists	
		(ListType,								AgendaType,						System)
VALUES	('SAILOR_TOTORI_Civics',				'TRAIT_AGENDA_SAILOR_TOTORI',		'Civics'),
		('SAILOR_TOTORI_Techs',					'TRAIT_AGENDA_SAILOR_TOTORI',		'Technologies'),
		('SAILOR_TOTORI_Buildings',				'TRAIT_AGENDA_SAILOR_TOTORI',		'Buildings'),
		('SAILOR_TOTORI_Districts',				'TRAIT_AGENDA_SAILOR_TOTORI',		'Districts'),
		('SAILOR_TOTORI_Improvements',			'TRAIT_AGENDA_SAILOR_TOTORI',		'Improvements'),
		('SAILOR_TOTORI_PseudoYields',			'TRAIT_AGENDA_SAILOR_TOTORI',		'PseudoYields'),
		('SAILOR_TOTORI_Exploration',			'TRAIT_AGENDA_SAILOR_TOTORI',		'AiScoutUses'),
		('SAILOR_TOTORI_Yields',				'TRAIT_AGENDA_SAILOR_TOTORI',		'Yields'),
		('SAILOR_TOTORI_Units',					'TRAIT_AGENDA_SAILOR_TOTORI',		'Units'),
		('SAILOR_TOTORI_Settle',				'TRAIT_AGENDA_SAILOR_TOTORI',		'Settle'),
		('SAILOR_TOTORI_Diploaction',			'TRAIT_AGENDA_SAILOR_TOTORI',		'DiplomaticActions'),
		('SAILOR_TOTORI_PlotEvaluation',		'TRAIT_AGENDA_SAILOR_TOTORI',		'PlotEvaluation');

-----------------------------------------------	
-- AiFavoredItems
-----------------------------------------------
INSERT INTO AiFavoredItems	
		(ListType,							Favored,	Item,								Value)
VALUES	
-- YIELDS
		('SAILOR_TOTORI_Yields',			1,			'YIELD_GOLD',						0),	
		('SAILOR_TOTORI_Yields',			1,			'YIELD_SCIENCE',					0),		
-- PSEUDOYIELDS
		('SAILOR_TOTORI_PseudoYields',		1,			'PSEUDOYIELD_GPP_ADMIRAL',			0),
		('SAILOR_TOTORI_PseudoYields',		1,			'PSEUDOYIELD_DISTRICT',				0),
-- UNITS
		('SAILOR_TOTORI_Units',				1,			'UNIT_SAILOR_ATLEER_UU',			10),
-- BUILDINGS & DISTRICTS
		('SAILOR_TOTORI_Buildings',			1,			'BUILDING_LIBRARY',					0),			
		('SAILOR_TOTORI_Buildings',			1,			'BUILDING_UNIVERSITY',				0),				
		('SAILOR_TOTORI_Buildings',			1,			'BUILDING_RESEARCH_LAB',			0),			
		('SAILOR_TOTORI_Buildings',			1,			'BUILDING_SHIPYARD',				20),			
		('SAILOR_TOTORI_Buildings',			1,			'BUILDING_LIGHTHOUSE',				20),			
		('SAILOR_TOTORI_Buildings',			1,			'BUILDING_SEAPORT',					20),	
		('SAILOR_TOTORI_Districts',			1,			'DISTRICT_HARBOR',					20),				
		('SAILOR_TOTORI_Districts',			1,			'DISTRICT_CAMPUS',					0),
-- IMPROVEMENTS
		('SAILOR_TOTORI_Improvements',		1,			'IMPROVEMENT_SAILOR_ATLEER_UI',		50),
		('SAILOR_TOTORI_Improvements',		1,			'IMPROVEMENT_FISHERY',				20),
		('SAILOR_TOTORI_Improvements',		1,			'IMPROVEMENT_OFFSHORE_WIND_FARM',	20),
		('SAILOR_TOTORI_Improvements',		1,			'IMPROVEMENT_SEASTEAD',				20),
-- WONDERS
		('SAILOR_TOTORI_Buildings',			1,			'BUILDING_VENETIAN_ARSENAL',		0),
-- CIVICS & TECHS
		('SAILOR_TOTORI_Civics',			1,			'CIVIC_MERCENARIES',				0), 
		('SAILOR_TOTORI_Civics',			1,			'CIVIC_EXPLORATION',				0), 
		('SAILOR_TOTORI_Techs',				1,			'TECH_CELESTIAL_NAVIGATION',		0), 
		('SAILOR_TOTORI_Techs',				1,			'TECH_WRITING',						0), 
		('SAILOR_TOTORI_Techs',				1,			'TECH_CHEMISTRY',					0),
-- SETTLE
		('SAILOR_TOTORI_Settle',			1,			'Foreign Continent',				20),
-- EXPLORATION
		('SAILOR_TOTORI_Exploration',		1,			'NAVAL_SCOUTS_FOR_WORLD_EXPLORATION',	50),
-- DIPLOACTION
		('SAILOR_TOTORI_Diploaction',		1,			'DIPLOACTION_OPEN_BORDERS',			50);

-- PLOT EVALUATION
INSERT INTO AiFavoredItems
		(ListType,							Item,				Favored,		StringVal,					Value)
VALUES  ('SAILOR_TOTORI_PlotEvaluation',	'Resource Class',	1,				'RESOURCECLASS_STRATEGIC',	0);	

-- UNITS SELECT
INSERT INTO AiFavoredItems
		(ListType,							Favored,	Item,				Value)
SELECT	'SAILOR_TOTORI_Units',				1,			UnitType AS Item,	50
FROM Units WHERE UnitType IN (SELECT UnitType FROM Units WHERE Domain = 'DOMAIN_SEA' AND TraitType IS NULL);		