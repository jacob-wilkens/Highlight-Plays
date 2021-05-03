USE NBAPlaysDb

SELECT
  GAME_ID
, EVENTNUM
, CASE WHEN Charindex('(', HOMEDESCRIPTION) > 0 THEN TRIM(Replace(LEFT(HOMEDESCRIPTION, Charindex('(', HOMEDESCRIPTION)), '(', ''))
         ELSE HOMEDESCRIPTION
  END AS HOMEDESCRIPTION
, CASE WHEN Charindex('(', VISITORDESCRIPTION) > 0 THEN TRIM(Replace(LEFT(VISITORDESCRIPTION, Charindex('(', VISITORDESCRIPTION)), '(', ''))
         ELSE VISITORDESCRIPTION
  END AS VISITORDESCRIPTION
, PLAYER1_NAME
, PLAYER2_NAME
, PLAYER3_NAME
INTO #FIRST_PASS
FROM PLAY_DATA
WHERE HOMEDESCRIPTION LIKE '%FOUL%' OR VISITORDESCRIPTION LIKE '%FOUL%'

SELECT 
   GAME_ID
 , EVENTNUM
 , CASE WHEN Charindex(SUBSTRING(PLAYER1_NAME, CHARINDEX(' ', PLAYER1_NAME) + 1, LEN(PLAYER1_NAME)), HOMEDESCRIPTION) > 0 THEN TRIM(REPLACE(HOMEDESCRIPTION, SUBSTRING(PLAYER1_NAME, CHARINDEX(' ', PLAYER1_NAME) + 1, LEN(PLAYER1_NAME)), ''))
		WHEN Charindex(SUBSTRING(PLAYER2_NAME, CHARINDEX(' ', PLAYER2_NAME) + 1, LEN(PLAYER2_NAME)), HOMEDESCRIPTION) > 0 THEN TRIM(REPLACE(HOMEDESCRIPTION, SUBSTRING(PLAYER2_NAME, CHARINDEX(' ', PLAYER2_NAME) + 1, LEN(PLAYER2_NAME)), ''))
		WHEN Charindex(SUBSTRING(PLAYER3_NAME, CHARINDEX(' ', PLAYER3_NAME) + 1, LEN(PLAYER3_NAME)), HOMEDESCRIPTION) > 0 THEN TRIM(REPLACE(HOMEDESCRIPTION, SUBSTRING(PLAYER3_NAME, CHARINDEX(' ', PLAYER3_NAME) + 1, LEN(PLAYER3_NAME)), ''))
 		ELSE HOMEDESCRIPTION
   END AS HOMEDESCRIPTION
 , CASE WHEN Charindex(SUBSTRING(PLAYER1_NAME, CHARINDEX(' ', PLAYER1_NAME) + 1, LEN(PLAYER1_NAME)), VISITORDESCRIPTION) > 0 THEN TRIM(REPLACE(VISITORDESCRIPTION, SUBSTRING(PLAYER1_NAME, CHARINDEX(' ', PLAYER1_NAME) + 1, LEN(PLAYER1_NAME)), ''))
		WHEN Charindex(SUBSTRING(PLAYER2_NAME, CHARINDEX(' ', PLAYER2_NAME) + 1, LEN(PLAYER2_NAME)), VISITORDESCRIPTION) > 0 THEN TRIM(REPLACE(VISITORDESCRIPTION, SUBSTRING(PLAYER2_NAME, CHARINDEX(' ', PLAYER2_NAME) + 1, LEN(PLAYER2_NAME)), ''))
		WHEN Charindex(SUBSTRING(PLAYER3_NAME, CHARINDEX(' ', PLAYER3_NAME) + 1, LEN(PLAYER3_NAME)), VISITORDESCRIPTION) > 0 THEN TRIM(REPLACE(VISITORDESCRIPTION, SUBSTRING(PLAYER3_NAME, CHARINDEX(' ', PLAYER3_NAME) + 1, LEN(PLAYER3_NAME)), ''))
 		ELSE VISITORDESCRIPTION
   END AS VISITORDESCRIPTION
 , PLAYER1_NAME
 , PLAYER2_NAME
 , PLAYER3_NAME
INTO #SECOND_PASS
FROM #FIRST_PASS

SELECT 
   GAME_ID
 , EVENTNUM
 , CASE WHEN Charindex(SUBSTRING(PLAYER1_NAME, CHARINDEX(' ', PLAYER1_NAME) + 1, LEN(PLAYER1_NAME)), HOMEDESCRIPTION) > 0 THEN TRIM(REPLACE(HOMEDESCRIPTION, SUBSTRING(PLAYER1_NAME, CHARINDEX(' ', PLAYER1_NAME) + 1, LEN(PLAYER1_NAME)), ''))
		WHEN Charindex(SUBSTRING(PLAYER2_NAME, CHARINDEX(' ', PLAYER2_NAME) + 1, LEN(PLAYER2_NAME)), HOMEDESCRIPTION) > 0 THEN TRIM(REPLACE(HOMEDESCRIPTION, SUBSTRING(PLAYER2_NAME, CHARINDEX(' ', PLAYER2_NAME) + 1, LEN(PLAYER2_NAME)), ''))
		WHEN Charindex(SUBSTRING(PLAYER3_NAME, CHARINDEX(' ', PLAYER3_NAME) + 1, LEN(PLAYER3_NAME)), HOMEDESCRIPTION) > 0 THEN TRIM(REPLACE(HOMEDESCRIPTION, SUBSTRING(PLAYER3_NAME, CHARINDEX(' ', PLAYER3_NAME) + 1, LEN(PLAYER3_NAME)), ''))
 		ELSE HOMEDESCRIPTION
   END AS HOMEDESCRIPTION
 , CASE WHEN Charindex(SUBSTRING(PLAYER1_NAME, CHARINDEX(' ', PLAYER1_NAME) + 1, LEN(PLAYER1_NAME)), VISITORDESCRIPTION) > 0 THEN TRIM(REPLACE(VISITORDESCRIPTION, SUBSTRING(PLAYER1_NAME, CHARINDEX(' ', PLAYER1_NAME) + 1, LEN(PLAYER1_NAME)), ''))
		WHEN Charindex(SUBSTRING(PLAYER2_NAME, CHARINDEX(' ', PLAYER2_NAME) + 1, LEN(PLAYER2_NAME)), VISITORDESCRIPTION) > 0 THEN TRIM(REPLACE(VISITORDESCRIPTION, SUBSTRING(PLAYER2_NAME, CHARINDEX(' ', PLAYER2_NAME) + 1, LEN(PLAYER2_NAME)), ''))
		WHEN Charindex(SUBSTRING(PLAYER3_NAME, CHARINDEX(' ', PLAYER3_NAME) + 1, LEN(PLAYER3_NAME)), VISITORDESCRIPTION) > 0 THEN TRIM(REPLACE(VISITORDESCRIPTION, SUBSTRING(PLAYER3_NAME, CHARINDEX(' ', PLAYER3_NAME) + 1, LEN(PLAYER3_NAME)), ''))
 		ELSE VISITORDESCRIPTION
   END AS VISITORDESCRIPTION
 , PLAYER1_NAME
 , PLAYER2_NAME
 , PLAYER3_NAME
INTO #THIRD_PASS
FROM #SECOND_PASS

SELECT 
   GAME_ID
 , EVENTNUM
 , CASE WHEN Charindex(SUBSTRING(PLAYER1_NAME, CHARINDEX(' ', PLAYER1_NAME) + 1, LEN(PLAYER1_NAME)), HOMEDESCRIPTION) > 0 THEN TRIM(REPLACE(HOMEDESCRIPTION, SUBSTRING(PLAYER1_NAME, CHARINDEX(' ', PLAYER1_NAME) + 1, LEN(PLAYER1_NAME)), ''))
		WHEN Charindex(SUBSTRING(PLAYER2_NAME, CHARINDEX(' ', PLAYER2_NAME) + 1, LEN(PLAYER2_NAME)), HOMEDESCRIPTION) > 0 THEN TRIM(REPLACE(HOMEDESCRIPTION, SUBSTRING(PLAYER2_NAME, CHARINDEX(' ', PLAYER2_NAME) + 1, LEN(PLAYER2_NAME)), ''))
		WHEN Charindex(SUBSTRING(PLAYER3_NAME, CHARINDEX(' ', PLAYER3_NAME) + 1, LEN(PLAYER3_NAME)), HOMEDESCRIPTION) > 0 THEN TRIM(REPLACE(HOMEDESCRIPTION, SUBSTRING(PLAYER3_NAME, CHARINDEX(' ', PLAYER3_NAME) + 1, LEN(PLAYER3_NAME)), ''))
 		ELSE HOMEDESCRIPTION
   END AS HOMEDESCRIPTION
 , CASE WHEN Charindex(SUBSTRING(PLAYER1_NAME, CHARINDEX(' ', PLAYER1_NAME) + 1, LEN(PLAYER1_NAME)), VISITORDESCRIPTION) > 0 THEN TRIM(REPLACE(VISITORDESCRIPTION, SUBSTRING(PLAYER1_NAME, CHARINDEX(' ', PLAYER1_NAME) + 1, LEN(PLAYER1_NAME)), ''))
		WHEN Charindex(SUBSTRING(PLAYER2_NAME, CHARINDEX(' ', PLAYER2_NAME) + 1, LEN(PLAYER2_NAME)), VISITORDESCRIPTION) > 0 THEN TRIM(REPLACE(VISITORDESCRIPTION, SUBSTRING(PLAYER2_NAME, CHARINDEX(' ', PLAYER2_NAME) + 1, LEN(PLAYER2_NAME)), ''))
		WHEN Charindex(SUBSTRING(PLAYER3_NAME, CHARINDEX(' ', PLAYER3_NAME) + 1, LEN(PLAYER3_NAME)), VISITORDESCRIPTION) > 0 THEN TRIM(REPLACE(VISITORDESCRIPTION, SUBSTRING(PLAYER3_NAME, CHARINDEX(' ', PLAYER3_NAME) + 1, LEN(PLAYER3_NAME)), ''))
 		ELSE VISITORDESCRIPTION
   END AS VISITORDESCRIPTION
INTO #FOURTH_PASS
FROM #THIRD_PASS

SELECT
   GAME_ID
 , EVENTNUM
 , CASE WHEN Charindex(T.NICKNAME, HOMEDESCRIPTION) > 0 THEN TRIM(REPLACE(HOMEDESCRIPTION, T.NICKNAME, ''))
 		ELSE NULL
   END AS HOMEDESCRIPTION
  , CASE WHEN Charindex(T.NICKNAME, VISITORDESCRIPTION) > 0 THEN TRIM(REPLACE(VISITORDESCRIPTION, T.NICKNAME, ''))
 		ELSE NULL
   END AS VISITORDESCRIPTION
INTO #FIFTH_PASS
FROM #FOURTH_PASS
CROSS APPLY  (SELECT NICKNAME FROM NBA.dbo.TEAMS) T

UPDATE #FOURTH_PASS
SET HOMEDESCRIPTION = NEW.HOMEDESCRIPTION
   ,VISITORDESCRIPTION = NEW.VISITORDESCRIPTION
   FROM (
			SELECT
		    GAME_ID
		  , EVENTNUM
		  , CASE WHEN Charindex('HOR', HOMEDESCRIPTION) > 0 THEN TRIM(REPLACE(HOMEDESCRIPTION, 'HOR', ''))
		 		ELSE HOMEDESCRIPTION
		   END AS HOMEDESCRIPTION
		  , CASE WHEN Charindex('HOR', VISITORDESCRIPTION) > 0 THEN TRIM(REPLACE(VISITORDESCRIPTION, 'HOR', ''))
		 		ELSE VISITORDESCRIPTION
		   END AS VISITORDESCRIPTION
		FROM #FIFTH_PASS
		WHERE HOMEDESCRIPTION IS NOT NULL OR VISITORDESCRIPTION IS NOT NULL
   ) AS NEW 
   WHERE NEW.GAME_ID = #FOURTH_PASS.GAME_ID AND NEW.EVENTNUM = #FOURTH_PASS.EVENTNUM

INSERT INTO dbo.PLAY_DATA_SHORT
            (GAME_ID,
             EVENTNUM,
             HOMEDESCRIPTION,
             VISITORDESCRIPTION)
(SELECT FP.GAME_ID,
        FP.EVENTNUM,
        FP.HOMEDESCRIPTION,
        FP.VISITORDESCRIPTION
 FROM   #FOURTH_PASS FP)
 
DROP TABLE #FIRST_PASS, #SECOND_PASS, #THIRD_PASS, #FOURTH_PASS, #FIFTH_PASS