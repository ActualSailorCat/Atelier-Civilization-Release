--=============================================
-- Lydie & Suelle / Agenda
--=============================================
-----------------------------------------------	
-- Types
-----------------------------------------------	
INSERT INTO Types
		(Type,							Kind)
VALUES	('TRAIT_AGENDA_SAILOR_LNS',	'KIND_TRAIT');

-----------------------------------------------	
-- Agendas
-----------------------------------------------	
INSERT INTO Agendas
		(AgendaType,			Name,							Description)
VALUES	('AGENDA_SAILOR_LNS',	'LOC_AGENDA_SAILOR_LNS_NAME',	'LOC_AGENDA_SAILOR_LNS_DESCRIPTION');

-----------------------------------------------	
-- Traits
-----------------------------------------------	
INSERT INTO Traits
		(TraitType,						Name,					Description)
VALUES	('TRAIT_AGENDA_SAILOR_LNS',		'LOC_PLACEHOLDER',		'LOC_PLACEHOLDER');

-----------------------------------------------	
-- AgendaTraits
-----------------------------------------------	
INSERT INTO AgendaTraits
		(AgendaType,			TraitType)
VALUES	('AGENDA_SAILOR_LNS',	'TRAIT_AGENDA_SAILOR_LNS');

-----------------------------------------------	
-- TraitModifiers
-----------------------------------------------	
INSERT INTO TraitModifiers
		(TraitType,						ModifierId)
VALUES	('TRAIT_AGENDA_SAILOR_LNS',		'AGENDA_SAILOR_LNS_HAPPY_CITIZENS'),
		('TRAIT_AGENDA_SAILOR_LNS',		'AGENDA_SAILOR_LNS_UNHAPPY_CITIZENS');

-----------------------------------------------	
-- Modifiers
-----------------------------------------------	
INSERT INTO Modifiers	
		(ModifierId,							ModifierType,									SubjectRequirementSetId)
VALUES	('AGENDA_SAILOR_LNS_HAPPY_CITIZENS',	'MODIFIER_PLAYER_DIPLOMACY_SIMPLE_MODIFIER',	'PLAYER_HAS_HIGH_HAPPINESS'),
		('AGENDA_SAILOR_LNS_UNHAPPY_CITIZENS',	'MODIFIER_PLAYER_DIPLOMACY_SIMPLE_MODIFIER',	'PLAYER_HAS_LOW_HAPPINESS');

-----------------------------------------------	
-- ModifierArguments
-----------------------------------------------	
INSERT INTO ModifierArguments
		(ModifierId,								Name,							Value)
VALUES	('AGENDA_SAILOR_LNS_HAPPY_CITIZENS',	'InitialValue',					10),
		('AGENDA_SAILOR_LNS_HAPPY_CITIZENS',	'StatementKey',					'LOC_DIPLO_KUDA_LEADER_SAILOR_LNS_REASON_HAPPY_CITIZENS'),
		('AGENDA_SAILOR_LNS_HAPPY_CITIZENS',	'SimpleModifierDescription',	'LOC_DIPLO_MODIFIER_SAILOR_LNS_HAPPY_CITIZENS'),
		('AGENDA_SAILOR_LNS_UNHAPPY_CITIZENS',	'InitialValue',					-10),
		('AGENDA_SAILOR_LNS_UNHAPPY_CITIZENS',	'StatementKey',					'LOC_DIPLO_KUDA_LEADER_SAILOR_LNS_REASON_UNHAPPY_CITIZENS'),
		('AGENDA_SAILOR_LNS_UNHAPPY_CITIZENS',	'SimpleModifierDescription',	'LOC_DIPLO_MODIFIER_SAILOR_LNS_UNHAPPY_CITIZENS');

-----------------------------------------------	
-- HistoricalAgendas
-----------------------------------------------	
INSERT INTO HistoricalAgendas
		(LeaderType,			AgendaType)
VALUES	('LEADER_SAILOR_LNS',	'AGENDA_SAILOR_LNS');

-----------------------------------------------	
-- ExclusiveAgendas
-----------------------------------------------	
INSERT INTO ExclusiveAgendas
		(AgendaOne,				AgendaTwo)
VALUES	('AGENDA_SAILOR_LNS',	'AGENDA_FUN_LOVING');

-----------------------------------------------	
-- ModifierStrings
-----------------------------------------------	
INSERT INTO ModifierStrings
		(ModifierId,							Context,		Text)
VALUES	('AGENDA_SAILOR_LNS_HAPPY_CITIZENS',	'Sample',		'LOC_TOOLTIP_SAMPLE_DIPLOMACY_ALL'),
		('AGENDA_SAILOR_LNS_UNHAPPY_CITIZENS',	'Sample',		'LOC_TOOLTIP_SAMPLE_DIPLOMACY_ALL');
