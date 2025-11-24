CREATE TABLE mining_extraction (
id_extraction int PRIMARY KEY,
date_time timestamp,
pit_id varchar,
operator_id varchar,
equipment_id varchar,
volume_m3 numeric,
grade_pct numeric,
shift varchar,
note text
);

CREATE TABLE hauling_trips (
id_trip int PRIMARY KEY,
date_time_start timestamp,
date_time_end timestamp,
truck_id varchar,
driver_id varchar,
from_location varchar,
to_location varchar,
distance_km numeric,
duration_min int,
payload_ton numeric,
trip_status varchar,
fuel_liter numeric,
note text
);

CREATE TABLE crushing_batches (
id_batch int PRIMARY KEY,
date_time_in timestamp,
date_time_out timestamp,
feed_ton numeric,
product_ton numeric,
throughput_tph numeric,
crusher_id varchar,
downtime_min int,
screening_loss_ton numeric,
note text
);

CREATE TABLE stockpile_movements (
id_movement int PRIMARY KEY,
date_time timestamp,
stockpile_id varchar,
movement_type varchar,
source varchar,
destination varchar,
volume_ton numeric,
stack_height_m numeric,
blending_id varchar,
note text
);

CREATE TABLE sales_deliveries (
id_delivery int PRIMARY KEY,
date_ship timestamp,
buyer_id varchar,
truck_id varchar,
volume_ton numeric,
grade_pct numeric,
contract_id varchar,
delivery_status varchar,
price_per_ton numeric,
note text
);