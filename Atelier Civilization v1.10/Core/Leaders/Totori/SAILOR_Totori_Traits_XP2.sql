--=============================================
-- Totori / Gathering Storm Traits
--=============================================
-----------------------------------------------			
-- TraitModifiers		
-----------------------------------------------	
INSERT INTO TraitModifiers
		(TraitType,								ModifierId)
VALUES	('TRAIT_LEADER_SAILOR_TOTORI_UA',		'SAILOR_TOTORI_UA_EARLY_SAILING'),
		('TRAIT_LEADER_SAILOR_TOTORI_UA',		'SAILOR_TOTORI_UA_EARLY_SHIPBUILDING');

-----------------------------------------------
-- Modifiers
-----------------------------------------------
INSERT INTO Modifiers
		(ModifierId,							ModifierType,										Permanent,	SubjectRequirementSetId)
VALUES	('SAILOR_TOTORI_UA_EARLY_SAILING',		'MODIFIER_PLAYER_GRANT_SPECIFIC_TECHNOLOGY',		1,			NULL),
		('SAILOR_TOTORI_UA_EARLY_SHIPBUILDING',	'MODIFIER_PLAYER_GRANT_SPECIFIC_TECHNOLOGY',		1,			NULL);

-----------------------------------------------
-- ModifierArguments
-----------------------------------------------
INSERT INTO ModifierArguments
		(ModifierId,							Name,			Value)
VALUES	('SAILOR_TOTORI_UA_EARLY_SAILING',		'TechType',		'TECH_SAILING'),
		('SAILOR_TOTORI_UA_EARLY_SHIPBUILDING',	'TechType',		'TECH_SHIPBUILDING');