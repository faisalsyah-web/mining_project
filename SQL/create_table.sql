CREATE TABLE master_pit (
pit_id INT PRIMARY KEY,
nama_pit VARCHAR(100),
area VARCHAR(50),
status VARCHAR(50)
);

CREATE TABLE master_equipment (
equipment_id INT PRIMARY KEY,
jenis VARCHAR(50),
kapasitas_ton INT,
status VARCHAR(50),
tanggal_beli DATE
);

CREATE TABLE master_buyer (
buyer_id INT PRIMARY KEY,
nama VARCHAR(100),
negara VARCHAR(50),
kontrak_aktif VARCHAR(20)
);

CREATE TABLE master_supplier (
supplier_id INT PRIMARY KEY,
nama VARCHAR(100),
kategori VARCHAR(50)
);

CREATE TABLE biaya_operasional (
cost_id INT PRIMARY KEY,
tanggal DATE,
kategori_biaya VARCHAR(50),
sub_kategori VARCHAR(50),
pit_id INT,
equipment_id INT,
biaya NUMERIC,
mata_uang VARCHAR(10),
keterangan TEXT,
FOREIGN KEY (pit_id) REFERENCES master_pit(pit_id),
FOREIGN KEY (equipment_id) REFERENCES master_equipment(equipment_id)
);

CREATE INDEX idx_biaya_pit ON biaya_operasional(pit_id);
CREATE INDEX idx_biaya_equipment ON biaya_operasional(equipment_id);

CREATE TABLE produksi (
prod_id INT PRIMARY KEY,
tanggal DATE,
pit_id INT,
equipment_id INT,
volume_ton NUMERIC,
shift VARCHAR(20),
jenis_produksi VARCHAR(50),
biaya_operasional_terkait NUMERIC,
keterangan TEXT,
FOREIGN KEY (pit_id) REFERENCES master_pit(pit_id),
FOREIGN KEY (equipment_id) REFERENCES master_equipment(equipment_id)
);

CREATE INDEX idx_prod_pit ON produksi(pit_id);
CREATE INDEX idx_prod_equipment ON produksi(equipment_id);

CREATE TABLE ore_grade (
grade_id INT PRIMARY KEY,
tanggal_sampel DATE,
pit_id INT,
lokasi_sampel VARCHAR(100),
bench INT,
blok INT,
grade_pct NUMERIC,
volume_terkait_ton NUMERIC,
metode_sampling VARCHAR(50),
analis_lab VARCHAR(100),
keterangan TEXT,
FOREIGN KEY (pit_id) REFERENCES master_pit(pit_id)
);

CREATE INDEX idx_grade_pit ON ore_grade(pit_id);

CREATE TABLE keselamatan_trifr (
incident_id INT PRIMARY KEY,
tanggal DATE,
jam_kerja_total INT,
jumlah_insiden INT,
kategori_insiden VARCHAR(50),
tingkat_keparahan VARCHAR(50),
lokasi VARCHAR(100),
shift VARCHAR(20),
karyawan_terlibat VARCHAR(20),
status_penanganan VARCHAR(50),
keterangan TEXT
);

CREATE INDEX idx_trifr_tanggal ON keselamatan_trifr(tanggal);

CREATE TABLE kepatuhan_lingkungan (
audit_id INT PRIMARY KEY,
tanggal DATE,
jenis_audit VARCHAR(50),
parameter VARCHAR(50),
nilai_ukur NUMERIC,
batas_regulasi NUMERIC,
status_hasil VARCHAR(50),
lokasi VARCHAR(100),
auditor VARCHAR(100),
tindakan_diperlukan TEXT,
keterangan TEXT
);

CREATE INDEX idx_lingkungan_tanggal ON kepatuhan_lingkungan(tanggal);

CREATE TABLE arus_kas_operasional (
cash_id INT PRIMARY KEY,
tanggal DATE,
jenis_transaksi VARCHAR(50),
kategori VARCHAR(50),
nilai NUMERIC,
mata_uang VARCHAR(10),
buyer_id INT,
kontrak_id INT,
keterangan TEXT,
FOREIGN KEY (buyer_id) REFERENCES master_buyer(buyer_id)
);

CREATE INDEX idx_cash_buyer ON arus_kas_operasional(buyer_id);

CREATE TABLE capex (
capex_id INT PRIMARY KEY,
tanggal DATE,
kategori VARCHAR(50),
equipment_id INT,
nilai NUMERIC,
umur_ekonomis_tahun INT,
mata_uang VARCHAR(10),
keterangan TEXT,
FOREIGN KEY (equipment_id) REFERENCES master_equipment(equipment_id)
);

CREATE INDEX idx_capex_equipment ON capex(equipment_id);

CREATE TABLE working_capital (
wc_id INT PRIMARY KEY,
tanggal DATE,
jenis VARCHAR(50),
nilai NUMERIC,
mata_uang VARCHAR(10),
buyer_id INT,
supplier_id INT,
status VARCHAR(50),
keterangan TEXT,
FOREIGN KEY (buyer_id) REFERENCES master_buyer(buyer_id),
FOREIGN KEY (supplier_id) REFERENCES master_supplier(supplier_id)
);

CREATE INDEX idx_wc_buyer ON working_capital(buyer_id);
CREATE INDEX idx_wc_supplier ON working_capital(supplier_id);