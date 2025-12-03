WITH biaya_volume as (
SELECT
    prod.pit_id,
    prod.tanggal,
    prod.equipment_id,
    prod.jenis_produksi,
    SUM(prod.volume_ton) as volume_ton,
    SUM(prod.biaya_operasional_terkait) AS biaya_operasional
FROM produksi prod
GROUP BY
    prod.pit_id,
    prod.tanggal,
    prod.equipment_id,
    prod.jenis_produksi
)
   
SELECT 
    pit_id,
    tanggal,
    equipment_id,
    jenis_produksi,
    volume_ton,
    biaya_operasional,
    ROUND(biaya_operasional / volume_ton) as biaya_per_ton
FROM biaya_volume
GROUP BY
    pit_id
ORDER BY
    pit_id





WITH data_teragregasi_per_pit AS (
    SELECT
        prod.pit_id,
        SUM(prod.volume_ton) AS total_volume_pit,
        SUM(prod.biaya_operasional_terkait) AS total_biaya_pit
    FROM produksi prod
    GROUP BY
        prod.pit_id
)

SELECT
    pit_id,
    total_volume_pit,
    total_biaya_pit,
    ROUND(total_biaya_pit * 1.0 / total_volume_pit, 2) AS rata_rata_biaya_per_ton_pit
FROM data_teragregasi_per_pit
ORDER BY pit_id;


