WITH data_teragregasi_per_pit AS (
    SELECT
        prod.pit_id,
        SUM(prod.volume_ton) AS total_volume_pit,
        SUM(prod.biaya_operasional_terkait) AS total_biaya_pit
    FROM produksi prod
    WHERE
        prod.jenis_produksi = 'Ore'
    GROUP BY prod.pit_id
),

biaya_per_ton AS (
    SELECT
        pit_id,
        total_volume_pit,
        total_biaya_pit,
        ROUND(total_biaya_pit::numeric / NULLIF(total_volume_pit, 0), 2) AS rata_rata_biaya_per_ton_pit
    FROM data_teragregasi_per_pit
)

SELECT
    bpt.pit_id,
    bpt.rata_rata_biaya_per_ton_pit,
    ROUND(AVG(og.grade_pct), 2) AS rata_rata_grade
FROM biaya_per_ton bpt
JOIN ore_grade og
    ON og.pit_id = bpt.pit_id
GROUP BY
    bpt.pit_id,
    bpt.rata_rata_biaya_per_ton_pit
ORDER BY
    bpt.rata_rata_biaya_per_ton_pit DESC;
