COPY mining_extraction
FROM 'D:\Portfolio\data analys\Project\mining_project\CSV\mining_extraction.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

COPY hauling_trips
FROM 'D:\Portfolio\data analys\Project\mining_project\CSV\hauling_trips.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

COPY crushing_batches
FROM 'D:\Portfolio\data analys\Project\mining_project\CSV\crushing_batches.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

COPY stockpile_movements
FROM 'D:\Portfolio\data analys\Project\mining_project\CSV\stockpile_movements.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

COPY sales_deliveries
FROM 'D:\Portfolio\data analys\Project\mining_project\CSV\sales_deliveries.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

COPY master_buyers
FROM 'D:\Portfolio\data analys\Project\mining_project\CSV\master_buyers.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

COPY master_equipment
FROM 'D:\Portfolio\data analys\Project\mining_project\CSV\master_equipment.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

COPY master_operators
FROM 'D:\Portfolio\data analys\Project\mining_project\CSV\master_operators.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

COPY master_pits
FROM 'D:\Portfolio\data analys\Project\mining_project\CSV\master_pits.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');


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

CREATE INDEX idx_pit_id ON mining_extraction (pit_id);