DROP TABLE IF EXISTS transactions;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS merchants;

CREATE TABLE customers (
    cc_num BIGINT PRIMARY KEY
);

CREATE TABLE merchants (
    merchant TEXT PRIMARY KEY
);

CREATE TABLE transactions (
    trans_num TEXT PRIMARY KEY,
    trans_date_trans_time TIMESTAMP NOT NULL,
    cc_num BIGINT NOT NULL,
    merchant TEXT NOT NULL,
    amt DECIMAL(10,2) NOT NULL,
    is_fraud INT NOT NULL,
    FOREIGN KEY (cc_num) REFERENCES customers(cc_num),
    FOREIGN KEY (merchant) REFERENCES merchants(merchant)
);