--=============================================
-- Totori / Agenda
--=============================================
-----------------------------------------------	
-- Types
-----------------------------------------------	
INSERT INTO Types
		(Type,							Kind)
VALUES	('TRAIT_AGENDA_SAILOR_TOTORI',	'KIND_TRAIT');

-----------------------------------------------	
-- Agendas
-----------------------------------------------	
INSERT INTO Agendas
		(AgendaType,				Name,								Description)
VALUES	('AGENDA_SAILOR_TOTORI',	'LOC_AGENDA_SAILOR_TOTORI_NAME',	'LOC_AGENDA_SAILOR_TOTORI_DESCRIPTION');

-----------------------------------------------	
-- Traits
-----------------------------------------------	
INSERT INTO Traits
		(TraitType,							Name,					Description)
VALUES	('TRAIT_AGENDA_SAILOR_TOTORI',		'LOC_PLACEHOLDER',		'LOC_PLACEHOLDER');

-----------------------------------------------	
-- AgendaTraits
-----------------------------------------------	
INSERT INTO AgendaTraits
		(AgendaType,						TraitType)
VALUES	('AGENDA_SAILOR_TOTORI',			'TRAIT_AGENDA_SAILOR_TOTORI');

-----------------------------------------------	
-- TraitModifiers
-----------------------------------------------	
INSERT INTO TraitModifiers
		(TraitType,								ModifierId)
VALUES	('TRAIT_AGENDA_SAILOR_TOTORI',			'AGENDA_SAILOR_TOTORI_HIGH_EXPLORATION'),
		('TRAIT_AGENDA_SAILOR_TOTORI',			'AGENDA_SAILOR_TOTORI_LOW_EXPLORATION');

-----------------------------------------------	
-- Modifiers
-----------------------------------------------	
INSERT INTO Modifiers	
		(ModifierId,								ModifierType,									SubjectRequirementSetId)
VALUES	('AGENDA_SAILOR_TOTORI_HIGH_EXPLORATION',	'MODIFIER_PLAYER_DIPLOMACY_SIMPLE_MODIFIER',	'PLAYER_HAS_HIGH_EXPLORATION'),
		('AGENDA_SAILOR_TOTORI_LOW_EXPLORATION',	'MODIFIER_PLAYER_DIPLOMACY_SIMPLE_MODIFIER',	'PLAYER_HAS_LOW_EXPLORATION');

-----------------------------------------------	
-- ModifierArguments
-----------------------------------------------	
INSERT INTO ModifierArguments
		(ModifierId,								Name,							Value)
VALUES	('AGENDA_SAILOR_TOTORI_HIGH_EXPLORATION',	'InitialValue',					-10),
		('AGENDA_SAILOR_TOTORI_HIGH_EXPLORATION',	'StatementKey',					'LOC_DIPLO_KUDA_LEADER_SAILOR_TOTORI_REASON_HIGH_EXPLORATION'),
		('AGENDA_SAILOR_TOTORI_HIGH_EXPLORATION',	'SimpleModifierDescription',	'LOC_DIPLO_MODIFIER_SAILOR_TOTORI_HIGH_EXPLORATION'),
		('AGENDA_SAILOR_TOTORI_LOW_EXPLORATION',	'InitialValue',					10),
		('AGENDA_SAILOR_TOTORI_LOW_EXPLORATION',	'StatementKey',					'LOC_DIPLO_KUDA_LEADER_SAILOR_TOTORI_REASON_LOW_EXPLORATION'),
		('AGENDA_SAILOR_TOTORI_LOW_EXPLORATION',	'SimpleModifierDescription',	'LOC_DIPLO_MODIFIER_SAILOR_TOTORI_LOW_EXPLORATION');

-----------------------------------------------	
-- HistoricalAgendas
-----------------------------------------------	
INSERT INTO HistoricalAgendas
		(LeaderType,				AgendaType)
VALUES	('LEADER_SAILOR_TOTORI',	'AGENDA_SAILOR_TOTORI');

-----------------------------------------------	
-- ExclusiveAgendas
-----------------------------------------------	
INSERT INTO ExclusiveAgendas
		(AgendaOne,					AgendaTwo)
VALUES	('AGENDA_SAILOR_TOTORI',	'AGENDA_EXPLORER');

-----------------------------------------------	
-- AgendaPreferredLeaders
-----------------------------------------------	
INSERT INTO AgendaPreferredLeaders
		(AgendaType,					LeaderType,					PercentageChance)
SELECT	'AGENDA_GREAT_WHITE_FLEET',		'LEADER_SAILOR_TOTORI',		35
WHERE EXISTS (SELECT 1 FROM Agendas WHERE AgendaType = 'AGENDA_GREAT_WHITE_FLEET');

-----------------------------------------------	
-- ModifierStrings
-----------------------------------------------	
INSERT INTO ModifierStrings
		(ModifierId,								Context,		Text)
VALUES	('AGENDA_SAILOR_TOTORI_HIGH_EXPLORATION',	'Sample',		'LOC_TOOLTIP_SAMPLE_DIPLOMACY_ALL'),
		('AGENDA_SAILOR_TOTORI_LOW_EXPLORATION',	'Sample',		'LOC_TOOLTIP_SAMPLE_DIPLOMACY_ALL');

--=============================================
-- Mod Support
--=============================================
INSERT INTO AgendaPreferredLeaders
		(AgendaType,					LeaderType,					PercentageChance)
SELECT	'AGENDA_SAILOR_CURMUDGEON',		'LEADER_SAILOR_TOTORI',		15
WHERE EXISTS (SELECT 1 FROM Agendas WHERE AgendaType = 'AGENDA_SAILOR_CURMUDGEON');
