USE nbaplaysdb

IF OBJECT_ID(N'tempdb..#FINAL_RESULTS') IS NOT NULL
BEGIN
    DROP TABLE #FINAL_RESULTS
END

CREATE TABLE #FINAL_RESULTS
(
    ROW_ID int IDENTITY(1, 1),
    GAME_ID varchar(10),
    EVENTNUM int,
    DESCRIPTION varchar(100),
    DESCRIPTION_TYPE char(1),
    SCORE decimal(19, 4),
	Q INT,
	SECONDS_LEFT_IN_PERIOD INT,
	SCORE_MARGIN INT
        PRIMARY KEY CLUSTERED
        (
            GAME_ID,
            EVENTNUM,
            DESCRIPTION,
            DESCRIPTION_TYPE
        )
)

INSERT INTO #FINAL_RESULTS
(
    GAME_ID,
    EVENTNUM,
    DESCRIPTION,
    DESCRIPTION_TYPE
)
(SELECT GAME_ID,
        EVENTNUM,
        HOMEDESCRIPTION,
        'H'
 FROM PLAY_DATA_SHORT
 WHERE HOMEDESCRIPTION IS NOT NULL)

INSERT INTO #FINAL_RESULTS
(
    GAME_ID,
    EVENTNUM,
    DESCRIPTION,
    DESCRIPTION_TYPE
)
(SELECT GAME_ID,
        EVENTNUM,
        VISITORDESCRIPTION,
        'V'
 FROM PLAY_DATA_SHORT
 WHERE VISITORDESCRIPTION IS NOT NULL)

DECLARE @ROW_NUM int = (SELECT COUNT(*) FROM #FINAL_RESULTS)
DECLARE @COUNTER int = 1

WHILE @COUNTER <= @ROW_NUM
BEGIN

    DECLARE @WORDS varchar(max) = (SELECT DESCRIPTION FROM #FINAL_RESULTS WHERE ROW_ID = @COUNTER)

    IF OBJECT_ID(N'tempdb..#WORDS') IS NOT NULL
    BEGIN
        DROP TABLE #WORDS
    END

    SELECT TRIM(VALUE) AS VALUE
    INTO #WORDS
    FROM STRING_SPLIT(@WORDS, '''')

    UPDATE #WORDS
    SET #WORDS.VALUE = N.NEW_WORD
    FROM
    (
        SELECT VALUE + '''' AS NEW_WORD,
               VALUE
        FROM #WORDS
        WHERE VALUE LIKE '[0-9][0-9]'
              OR VALUE LIKE '[0-9]'
              OR VALUE LIKE 'MISS  [0-9]'
              OR VALUE LIKE 'MISS  [0-9][0-9]'
    ) AS N
    WHERE N.VALUE = #WORDS.VALUE

	UPDATE #FINAL_RESULTS
	SET SCORE = N.SCORE FROM (SELECT SUM(ISNULL(S.SCORE, 0)) AS SCORE
							  FROM #WORDS W
							  JOIN SCORING S ON W.VALUE = S.PHRASE) AS N WHERE #FINAL_RESULTS.ROW_ID = @COUNTER

    SET @COUNTER += 1
END

UPDATE #FINAL_RESULTS
SET #FINAL_RESULTS.SECONDS_LEFT_IN_PERIOD = U.SL,
    #FINAL_RESULTS.SCORE_MARGIN = U.SM,
	#FINAL_RESULTS.Q = U.Q
FROM (SELECT
  GAME_ID,
  EVENTNUM,
  PERIOD AS Q,
  ((CAST(SUBSTRING(CAST(pctimestring AS varchar(2)), 1, 2) AS int)) * 60) + CAST(SUBSTRING(CAST(pctimestring AS varchar(5)), 4, 4) AS int) AS SL,
  ABS(scoremargin) AS SM
FROM play_data) AS U
WHERE #FINAL_RESULTS.GAME_ID = U.GAME_ID
AND #FINAL_RESULTS.EVENTNUM = U.EVENTNUM

--SELECT TOP 10
--  pd.game_id,
--  pd.eventnum,
--  fr.score,
--  pw1.weight,
--  (fr.score + ISNULL(pw1.weight, 0) + ISNULL(pw2.weight, 0) + ISNULL(pw3.weight, 0)) AS total,
--  pd.player1_name,
--  pd.player2_name,
--  pd.player3_name,
--  pd.homedescription,
--  pd.visitordescription,
--  pd.period,
--  pd.pctimestring,
--  scoremargin,
--  pd.score
--FROM #final_results fr
--JOIN play_data pd
--  ON fr.game_id = pd.game_id
--  AND fr.eventnum = pd.eventnum
--LEFT JOIN player_weight pw1
--  ON pd.player1_name = pw1.player_name
--LEFT JOIN player_weight pw2
--  ON pd.player2_name = pw2.player_name
--LEFT JOIN player_weight pw3
--  ON pd.player3_name = pw3.player_name
--WHERE pd.video_available_flag = 1
--ORDER BY (fr.score + ISNULL(pw1.weight, 0) + ISNULL(pw2.weight, 0) + ISNULL(pw3.weight, 0)) DESC