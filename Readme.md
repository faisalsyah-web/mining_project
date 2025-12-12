# Introduction
📊 Jelajahi analisis biaya operasional tambang menggunakan SQL. Project ini membahas 💰 perhitungan biaya per ton, 🔥 kategori biaya yang paling berpengaruh, dan 📈 hubungan antara grade ore dan biaya produksi. Semua analisis dilakukan dengan query SQL yang terstruktur dan visualisasi pendukung.

🔍 Ingin melihat query SQL. Cek di folder berikut.
[Project_SQL folder](/Project_SQL/)

# Background
Project ini saya buat untuk membaca struktur biaya tambang dan menemukan pola biaya yang penting untuk keputusan operasional. Analisis ini membantu melihat kategori biaya yang dominan, tren biaya bulanan, serta hubungan antara kualitas ore dan biaya produksi.

Data project di buat oleh chatgpt dapat dilihat pada folder [CSV](CSV).berasal dari dataset produksi, biaya operasional, dan grade ore. Di dalamnya terdapat volume, biaya, kategori biaya, pit, dan grade pct.

### Pertanyaan utama yang ingin saya jawab melalui analisis SQL

1. Berapa biaya per ton pada tiap pit.
2. Bagaimana tren biaya operasional per bulan.
3. Kategori biaya mana yang paling besar kontribusinya.
4. Bagaimana hubungan biaya per ton dengan grade ore.
5. Pit mana yang paling efisien dan mana yang perlu evaluasi.

# Tools I Used

Saya menggunakan beberapa tools untuk melakukan analisis ini.
- **SQ**L untuk agregasi dan perhitungan metrik biaya.
- **PostgreSQL** sebagai database utama.
- **Visual Studio Code** untuk menjalankan query.
- **Python** untuk visualisasi.
- **Git dan GitHub** untuk dokumentasi dan version control.

# The Analysis
### 1. **Biaya per Ton per Pit**
Query pada file [Biaya_per_ton.sql](/Project_SQL/Biaya_per_Ton.sql) menghitung total volume dan biaya untuk setiap pit lalu menghasilkan metrik utama biaya per ton.

```sql 
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
```
📌 Temuan penting
- Ada pit dengan biaya per ton jauh lebih tinggi dibanding pit lain.
- Perbedaan biaya bisa dipengaruhi jarak hauling, kondisi alat, atau efisiensi tim.

![Top Paying role](/visualization/assets/top10_biaya_per_pit.png)
*Grafik batang yang memvisualisasikan 10 biaya operasional per pit teratas dihasil menggunakan python*

### 2. **Hubungan Grade Ore dan Biaya per Ton**
Query pada file [grade.sql](/Project_SQL/grade.sql) menggabungkan biaya per ton dengan grade ore untuk melihat hubungan keduanya.

``` sql
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

```
📌 Temuan penting
- Tidak ada korelasi kuat antara grade tinggi dan biaya rendah.
- Pit dengan grade baik belum tentu memiliki biaya efisien.

![Top Paying role](/visualization/assets/scatter_biaya_vs_grade.png)
*Grafik scatter yang memvisualisasikan kerolasi antara biaya dengan grade dihasil menggunakan python*

### 3. **Tren Biaya Operasional Bulanan**
Query pada file [tren_biaya_operasional.sql](/Project_SQL/tren_biaya_operasional.sql) pada bagian pertama, query menjumlahkan biaya per bulan untuk melihat pola jangka panjang.
```sql
SELECT
    TO_CHAR(tanggal, 'YYYY-MM') AS bulan,
    SUM(biaya) AS total_biaya
FROM biaya_operasional
GROUP BY
    TO_CHAR(tanggal, 'YYYY-MM')
ORDER BY
    bulan;
```
📌 Temuan penting
- Biaya bulanan berfluktuasi.
- Ada beberapa bulan dengan lonjakan yang signifikan.

![Top Paying role](/visualization/assets/tren_biaya_operasional.png)
*Grafik line yang memvisualisasikan tren biaya operasional dari januari 2023 sampai desember 2024 dihasil menggunakan python*

### 4. **Tren Biaya per Kategori**
Masih di file file [tren_biaya_operasional.sql](/Project_SQL/tren_biaya_operasional.sql), bagian kedua menghasilkan tren kategori biaya seperti BBM, Gaji, Overhead, dan Perbaikan.
```sql
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
```
📌 Temuan penting
- BBM dan Overhead sering menjadi penyumbang biaya terbesar.
- Kenaikan biaya Gaji terjadi pada beberapa periode tertentu.
- Perbaikan memiliki pola yang tidak stabil.

![Top Paying role](/visualization/assets/tren_biaya_per_kategori.png)
*Grafik line yang memvisualisasikan tren biaya operasional per kategori dari januari 2023 sampai desember 2024 dihasil menggunakan python*

# What I Learned

- Saya menguasai penggunaan CTE untuk agregasi biaya.
- Saya memahami pola biaya operasional melalui visualisasi multi kategori.
- Saya membaca hubungan antar metrik untuk menentukan area efisiensi.
- Saya meningkatkan kemampuan dokumentasi dan struktur project.

# Conclusions
### Insights
1. Biaya per ton antar pit memiliki perbedaan besar.
2. Tren biaya bulanan menunjukkan pola fluktuasi yang harus dipantau.
3. Kategori BBM, Gaji, dan Overhead memberi kontribusi terbesar.
4. Grade ore tidak selalu menentukan biaya efisien.
5. Pit tertentu membutuhkan evaluasi berdasarkan metrik dan tren biaya.

# Future Improvements

• Tambahkan perhitungan efisiensi alat dan fuel rate.
• Analisis jarak hauling untuk pit yang mahal.
• Tambah model prediksi biaya bulanan.
• Buat dashboard interaktif dengan Power BI atau Metabase.
• Tambahkan analisis downtime alat dan dampaknya ke biaya.