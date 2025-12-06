WITH data_teragregasi_per_pit AS (
    SELECT
        prod.pit_id,
        prod.tanggal,
        SUM(prod.volume_ton) AS total_volume_pit,
        SUM(prod.biaya_operasional_terkait) AS total_biaya_pit
    FROM produksi prod
    WHERE
        jenis_produksi = 'Ore'
    GROUP BY
        prod.pit_id,
        prod.tanggal
)

SELECT
    pit_id,
    tanggal
    total_volume_pit,
    total_biaya_pit,
    ROUND(total_biaya_pit * 1.0 / total_volume_pit, 2) AS rata_rata_biaya_per_ton_pit
FROM data_teragregasi_per_pit
ORDER BY tanggal



