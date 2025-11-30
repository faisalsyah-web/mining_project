
SELECT
    me.pit_id,
    mp.name AS pit_name, -- Beri alias untuk kejelasan
    mo.name AS operator_name, -- Beri alias untuk kejelasan
    TO_CHAR(date_time, 'MM-DD') AS month_day, -- Format menjadi 'Bulan-Hari'
    SUM(volume_ton) AS total_volume_ton,
    AVG(grade_pct) AS average_grade_pct
FROM
    mining_extraction me
INNER JOIN
    master_pits mp ON mp.pit_id = me.pit_id
INNER JOIN
    master_operators mo ON mo.operator_id = me.operator_id
WHERE
    EXTRACT(MONTH FROM date_time) = 1
GROUP BY
    month_day, -- Gunakan alias yang diformat di GROUP BY
    me.pit_id,
    mp.name,
    mo.name
ORDER BY
    month_day, pit_id;
