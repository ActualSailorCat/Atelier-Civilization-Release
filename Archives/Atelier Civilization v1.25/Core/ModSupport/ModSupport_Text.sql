-- Alchemist Unit Mod
INSERT OR REPLACE INTO LocalizedText
        (Tag,    Language,    Text)
SELECT	"LOC_PEDIA_UNITS_PAGE_UNIT_SAILOR_ALCHEMIST_CHAPTER_HISTORY_PARA_1",
		"en_US",
		"Cannot be trained. Receive one free Alchemist with each Alchemist's Tower building.[NEWLINE][NEWLINE]Example Usage: The [ICON_Resource_Furs] Furs resource grants +1 [ICON_Food] Food and +1 [ICON_Gold] Gold to its tile. Having an Alchemist on or adjacent to the tile would increase this bonus to +2 [ICON_Food] Food and +2 [ICON_Gold] Gold."
WHERE NOT EXISTS (SELECT Tag FROM LocalizedText WHERE Tag = "LOC_CIVILIZATION_SAILOR_ATLEER_NAME");