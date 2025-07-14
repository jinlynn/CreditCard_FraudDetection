-- table to hold csv data
DROP TABLE IF EXISTS raw_transactions;

CREATE TABLE raw_transactions (
	Unnamed_0 SERIAL,
	trans_date_trans_time TIMESTAMP,
	cc_num BIGINT,
	merchant TEXT,
	category TEXT,
	amt DECIMAL(10,2),
	first TEXT,
	last TEXT,
	gender TEXT,
	street TEXT,
	city TEXT,
	state TEXT,
	zip BIGINT,
	lat DECIMAL(9,6),
	long DECIMAL(9,6),
	city_pop INT,
	job TEXT,
	dob DATE,
    trans_num TEXT,
    unix_time BIGINT,
	merch_lat DECIMAL(9,6),
	merch_long DECIMAL(9,6),
	is_fraud INT
);

-- read csv data
COPY raw_transactions
FROM '/Users/jinlynn/Desktop/NUS/Y4S2/DSA4288/kaggle2/data/fraudTrain.csv' DELIMITER ',' CSV HEADER;

COPY raw_transactions
FROM '/Users/jinlynn/Desktop/NUS/Y4S2/DSA4288/kaggle2/data/fraudTest.csv' DELIMITER ',' CSV HEADER;

-- insert unique customers, merchants and transactions
INSERT INTO customers (cc_num)
SELECT DISTINCT cc_num FROM raw_transactions
ON CONFLICT (cc_num) DO NOTHING;

INSERT INTO merchants (merchant)
SELECT DISTINCT merchant FROM raw_transactions
ON CONFLICT (merchant) DO NOTHING;

INSERT INTO transactions (trans_num, trans_date_trans_time, cc_num, merchant, amt, is_fraud)
SELECT trans_num, trans_date_trans_time, cc_num, merchant, amt, is_fraud
FROM raw_transactions
ON CONFLICT (trans_num) DO NOTHING;

