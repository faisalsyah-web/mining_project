-- Tren Biaya Operasional per Bulan
SELECT
    TO_CHAR(tanggal, 'YYYY-MM') AS bulan,
    SUM(biaya) AS total_biaya
FROM biaya_operasional
GROUP BY
    TO_CHAR(tanggal, 'YYYY-MM')
ORDER BY
    bulan;


-- tren biaya operasional per bulan (katergori)
SELECT
    TO_CHAR(tanggal, 'YYYY-MM') AS bulan,
    kategori_biaya AS kategori,
    equipment_id,
    SUM(biaya) AS total_biaya
FROM biaya_operasional
GROUP BY
    TO_CHAR(tanggal, 'YYYY-MM'),
    kategori_biaya,
    equipment_id
ORDER BY
    bulan;



