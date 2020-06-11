-- Alchemist Unit Mod
INSERT OR REPLACE INTO LocalizedText
        (Tag,    Language,    Text)
SELECT	"LOC_PEDIA_UNITS_PAGE_UNIT_SAILOR_ALCHEMIST_CHAPTER_HISTORY_PARA_1",
		"ko_KR",
		"훈련할 수 없습니다. 각 연금술사의 탑 건물과 함께 무료 연금술사를 하나씩 받으십시오. [NEWLINE][NEWLINE] 사용 예: [ICON_Resource_Furs] 모피 자원은 [ICON_Food] 식량 +1 및 [ICON_Gold] 금 + 1을 부여합니다. 연금술사가 인접한 타일에는 이 보너스가 [ICON_Food] 식량 +2 및 [ICON_Gold] 금 +2로 향상됩니다."
WHERE NOT EXISTS (SELECT Tag FROM LocalizedText WHERE Tag = "LOC_CIVILIZATION_SAILOR_ATLEER_NAME");