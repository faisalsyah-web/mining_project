--Load CSV to Table

COPY master_buyer
FROM 'D:\Portfolio\data analys\Project\mining_project\CSV\master_buyer.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

COPY master_equipment
FROM 'D:\Portfolio\data analys\Project\mining_project\CSV\master_equipment.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

COPY master_pit
FROM 'D:\Portfolio\data analys\Project\mining_project\CSV\master_pit.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

COPY master_supplier
FROM 'D:\Portfolio\data analys\Project\mining_project\CSV\master_supplier.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

COPY arus_kas_operasional
FROM 'D:\Portfolio\data analys\Project\mining_project\CSV\arus_kas_operasional.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

COPY biaya_operasional
FROM 'D:\Portfolio\data analys\Project\mining_project\CSV\biaya_operasional.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

COPY capex
FROM 'D:\Portfolio\data analys\Project\mining_project\CSV\capex.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

COPY kepatuhan_lingkungan
FROM 'D:\Portfolio\data analys\Project\mining_project\CSV\kepatuhan_lingkungan.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

COPY keselamatan_trifr
FROM 'D:\Portfolio\data analys\Project\mining_project\CSV\keselamatan_trifr.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

COPY ore_grade
FROM 'D:\Portfolio\data analys\Project\mining_project\CSV\ore_grade.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

COPY produksi
FROM 'D:\Portfolio\data analys\Project\mining_project\CSV\produksi.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

COPY working_capital
FROM 'D:\Portfolio\data analys\Project\mining_project\CSV\working_capital.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

--Define Foreign Key
ALTER TABLE mining_extraction
ADD CONSTRAINT fk_mining_extraction_equipment_id
FOREIGN KEY (equipment_id)
REFERENCES master_equipment (equipment_id);

ALTER TABLE hauling_trips
ADD CONSTRAINT fk_mining_extraction_equipment_id
FOREIGN KEY (truck_id)
REFERENCES master_equipment (equipment_id);

ALTER TABLE hauling_trips
ADD CONSTRAINT fk_mining_extraction_operators_id
FOREIGN KEY (driver_id)
REFERENCES master_operators (operator_id);

ALTER TABLE crushing_batches
ADD CONSTRAINT fk_mining_extraction_equipment_id
FOREIGN KEY (crusher_id)
REFERENCES master_equipment (equipment_id);

ALTER TABLE sales_deliveries
ADD CONSTRAINT fk_mining_extraction_equipment_id
FOREIGN KEY (truck_id)
REFERENCES master_equipment (equipment_id);

ALTER TABLE sales_deliveries
ADD CONSTRAINT fk_mining_extraction_buyers_id
FOREIGN KEY (buyer_id)
REFERENCES master_buyers (buyer_id);

ALTER TABLE stockpile_movements
ADD CONSTRAINT fk_stockpile_movements_pit_id
FOREIGN KEY (source)
REFERENCES master_pits (pit_id);


--Index Mining extraxtion
CREATE INDEX idx_pit_id ON mining_extraction (pit_id);
CREATE INDEX idx_equipment_id ON mining_extraction (equipment_id);
CREATE INDEX idx_operator_id ON mining_extraction (operator_id);

--Index Crushin Batches
CREATE INDEX idx_crushing_batches_equipment_id ON crushing_batches (crusher_id);

--Index hauling_trips
CREATE INDEX idx_hauling_trips_equipment_id ON hauling_trips (truck_id);
CREATE INDEX idx_hauling_trips_operator_id ON hauling_trips (driver_id);

--Index sales_deliveries
CREATE INDEX idx_sales_deliveries_equipment_id ON sales_deliveries (truck_id);
CREATE INDEX idx_sales_deliveries_buyer_id ON sales_deliveries (buyer_id);

--Index stockpile_movements
CREATE INDEX idx_stockpile_movements_equipment_id ON stockpile_movements (source);

drop Table master_buyers, crushing_batches, hauling_trips, master_buyers, master_equipment, master_operators, master_pits, mining_extraction, sales_deliveries, stockpile_movements;
