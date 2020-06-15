--=============================================
-- Lydie & Suelle / AI
--=============================================
-----------------------------------------------	
-- AiListTypes
-----------------------------------------------	
INSERT INTO AiListTypes	
		(ListType)
VALUES	('SAILOR_LNS_Civics'),
		('SAILOR_LNS_Techs'),
		('SAILOR_LNS_Buildings'),
		('SAILOR_LNS_Districts'),
		('SAILOR_LNS_Improvements'),
		('SAILOR_LNS_PseudoYields'),
		('SAILOR_LNS_Yields'),
		('SAILOR_LNS_Units'),
		('SAILOR_LNS_Diplomacy'),
		('SAILOR_LNS_PlotEvaluation');

-----------------------------------------------	
-- AiLists
-----------------------------------------------	
INSERT INTO AiLists	
		(ListType,							AgendaType,						System)
VALUES	('SAILOR_LNS_Civics',				'TRAIT_AGENDA_SAILOR_LNS',		'Civics'),
		('SAILOR_LNS_Techs',				'TRAIT_AGENDA_SAILOR_LNS',		'Technologies'),
		('SAILOR_LNS_Buildings',			'TRAIT_AGENDA_SAILOR_LNS',		'Buildings'),
		('SAILOR_LNS_Districts',			'TRAIT_AGENDA_SAILOR_LNS',		'Districts'),
		('SAILOR_LNS_Improvements',			'TRAIT_AGENDA_SAILOR_LNS',		'Improvements'),
		('SAILOR_LNS_PseudoYields',			'TRAIT_AGENDA_SAILOR_LNS',		'PseudoYields'),
		('SAILOR_LNS_Yields',				'TRAIT_AGENDA_SAILOR_LNS',		'Yields'),
		('SAILOR_LNS_Units',				'TRAIT_AGENDA_SAILOR_LNS',		'Units');

-----------------------------------------------	
-- AiFavoredItems
-----------------------------------------------
-- YIELDS
INSERT INTO AiFavoredItems	
		(ListType,							Favored,	Item)
VALUES	('SAILOR_LNS_Yields',				1,			'YIELD_GOLD'),	
		('SAILOR_LNS_Yields',				1,			'YIELD_CULTURE'),		
		('SAILOR_LNS_PseudoYields',			1,			'PSEUDOYIELD_GPP_ARTIST');

INSERT INTO AiFavoredItems
		(ListType,							Favored,	Item)
SELECT	'SAILOR_LNS_PseudoYields',			1,			PseudoYieldType AS Item
FROM PseudoYields WHERE PseudoYieldType LIKE '%GREATWORK%';

-- UNITS
INSERT INTO AiFavoredItems	
		(ListType,							Favored,	Item)		
VALUES	('SAILOR_LNS_Units',				1,			'UNIT_SAILOR_ATLEER_UU'),
		('SAILOR_LNS_Units',				1,			'UNIT_NATURALIST');

-- BUILDINGS & DISTRICTS
INSERT INTO AiFavoredItems	
		(ListType,							Favored,	Item)
VALUES	('SAILOR_LNS_Buildings',			1,			'BUILDING_AMPHITHEATER'),			
		('SAILOR_LNS_Buildings',			1,			'BUILDING_MUSEUM_ART'),				
		('SAILOR_LNS_Buildings',			1,			'BUILDING_BROADCAST_CENTER'),			
		('SAILOR_LNS_Districts',			1,			'DISTRICT_THEATER');			

-- IMPROVEMENTS
INSERT INTO AiFavoredItems
		(ListType,							Favored,	Item)
VALUES	('SAILOR_LNS_Improvements',			1,			'IMPROVEMENT_SAILOR_ATLEER_UI');

-- WONDERS
INSERT INTO AiFavoredItems	
		(ListType,							Favored,	Item)
SELECT	'SAILOR_LNS_Buildings',				1,			BuildingType AS Item
FROM Buildings WHERE BuildingType IN (SELECT BuildingType FROM Building_GreatWorks WHERE GreatWorkSlotType = 'GREATWORKSLOT_ART') AND BuildingType IN (SELECT BuildingType FROM Buildings WHERE TraitType IS NULL);

-- CIVICS & TECHS
INSERT INTO AiFavoredItems	
		(ListType,						Item,							Favored)
VALUES	('SAILOR_LNS_Civics',			'CIVIC_DRAMA_AND_POETRY',		1), 
		('SAILOR_LNS_Civics',			'CIVIC_HUMANISM',				1), 
		('SAILOR_LNS_Civics',			'CIVIC_DIPLOMATIC_SERVICE',		1), 
		('SAILOR_LNS_Civics',			'CIVIC_NATURAL_HISTORY',		1), 
		('SAILOR_LNS_Techs',			'TECH_WRITING',					1), 
		('SAILOR_LNS_Techs',			'TECH_CHEMISTRY',				1);