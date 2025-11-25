CREATE TABLE master_buyers (
buyer_id VARCHAR PRIMARY KEY,
name VARCHAR,
contract_terms VARCHAR,
preferred_delivery VARCHAR
);

CREATE TABLE master_equipment (
equipment_id VARCHAR PRIMARY KEY,
equipment_type VARCHAR,
capacity_ton FLOAT,
purchase_date TIMESTAMP,
status TEXT,
fuel_rate_lph FLOAT
);

CREATE TABLE master_operators (
operator_id VARCHAR PRIMARY KEY,
name VARCHAR,
cert_level VARCHAR,
hire_date TIMESTAMP,
shift_pref VARCHAR
);


CREATE TABLE master_pits (
pit_id VARCHAR PRIMARY KEY,
name VARCHAR,
geo_lat numeric,
geo_lon numeric,
bench_depth_m numeric,
material_type TEXT
);

CREATE TABLE sales_deliveries (
id_delivery VARCHAR,
date_ship timestamp,
buyer_id VARCHAR,
truck_id VARCHAR,
volume_ton numeric,
grade_pct numeric,
contract_id VARCHAR,
delivery_status VARCHAR,
price_per_ton numeric,
note TEXT
);

CREATE TABLE crushing_batches (
id_batch int PRIMARY KEY,
date_time_in TIMESTAMP,
date_time_out TIMESTAMP,
feed_ton FLOAT,
product_ton FLOAT,
throughput_tph FLOAT,
crusher_id VARCHAR,
downtime_min int,
screening_loss_ton INT,
note TEXT
);

CREATE TABLE hauling_trips (
id_trip INT PRIMARY KEY,
date_time_start TIMESTAMP,
date_time_end TIMESTAMP,
truck_id VARCHAR,
driver_id VARCHAR,
from_location VARCHAR,
to_location VARCHAR,
distance_km FLOAT,
duration_min INT,
payload_ton FLOAT,
trip_status TEXT,
fuel_liter FLOAT,
note TEXT
);

CREATE TABLE mining_extraction (
id_extraction INT PRIMARY KEY,
date_time TIMESTAMP,
pit_id VARCHAR,
operator_id VARCHAR,
equipment_id VARCHAR,
volume_ton FLOAT,
grade_pct FLOAT,
shift FLOAT,
note TEXT
);


CREATE TABLE stockpile_movements (
id_movement INT PRIMARY KEY,
date_time TIMESTAMP,
stockpile_id VARCHAR,
movement_type VARCHAR,
source VARCHAR,
destination VARCHAR,
volume_ton FLOAT,
stack_height_m FLOAT,
blending_id VARCHAR,
note TEXT
);



