CREATE VIEW transaction_counts AS
SELECT 
    trans_num,
    cc_num,
	trans_date_trans_time,
    COUNT(*) OVER (
        PARTITION BY cc_num 
        ORDER BY trans_date_trans_time 
        RANGE BETWEEN INTERVAL '24 hours' PRECEDING AND CURRENT ROW
    ) - 1 AS count_last24h,  -- Exclude current transaction
    COUNT(*) OVER (
        PARTITION BY cc_num 
        ORDER BY trans_date_trans_time 
        RANGE BETWEEN INTERVAL '7 days' PRECEDING AND CURRENT ROW
    ) - 1 AS count_last7days, -- Exclude current transaction
	COUNT(*) OVER (
        PARTITION BY cc_num 
        ORDER BY trans_date_trans_time 
        RANGE BETWEEN INTERVAL '30 days' PRECEDING AND CURRENT ROW
    ) - 1 AS count_last30days, -- Exclude current transaction
	is_fraud
FROM transactions
ORDER BY cc_num, trans_date_trans_time;

COPY (SELECT * FROM transaction_counts) 
TO '/Users/jinlynn/Desktop/NUS/Y4S2/DSA4288/kaggle2/transaction_counts.csv' WITH CSV HEADER;

CREATE VIEW past_count_with_merchant AS
SELECT 
    trans_num,
    COUNT(*) OVER (
        PARTITION BY cc_num, merchant
        ORDER BY trans_date_trans_time ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING
    ) AS past_count_with_merchant
FROM raw_transactions t;

COPY (SELECT * FROM past_count_with_merchant) 
TO '/Users/jinlynn/Desktop/NUS/Y4S2/DSA4288/kaggle2/past_count_with_merchant.csv' WITH CSV HEADER;