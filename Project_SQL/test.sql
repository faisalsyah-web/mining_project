SELECT
    pit_id,
    EXTRACT(DAY FROM date_time) AS date_time,
    SUM(volume_ton) AS total_volume_ton,
    AVG(grade_pct) AS average_grade_pct
FROM
    mining_extraction
WHERE
    EXTRACT(MONTH FROM date_time) = 1
    AND EXTRACT(DAY FROM date_time) = 3
GROUP BY
    date_time,
    pit_id

SELECT pit_id, date_time, mining_extraction.volume_ton, mining_extraction.grade_pct FROM mining_extraction




SELECT * FROM hauling_trips