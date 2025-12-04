SELECT pit_id, COUNT(*)
FROM ore_grade
GROUP BY pit_id
ORDER BY pit_id;

SELECT og.pit_id, og.tanggal_sampel
FROM ore_grade og
WHERE pit_id = 155
ORDER BY tanggal_sampel;

SELECT og.pit_id, og.tanggal
FROM produksi og
WHERE pit_id = 155
ORDER BY tanggal;
