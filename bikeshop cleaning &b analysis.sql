WITH cte_dup AS(
	SELECT *, 
		ROW_NUMBER() OVER(PARTITION BY order_id, brand_name, product_name, order_date, list_price) AS dup_row
	FROM set.bike_shop_dataset
)

SELECT * FROM cte_dup WHERE dup_row > 1

CREATE TABLE set.bikeshop_data_nodup
(
    order_id integer,
    customer_id integer,
    customer_name text COLLATE pg_catalog."default",
    brand_name character varying(255) COLLATE pg_catalog."default",
    category_name character varying(255) COLLATE pg_catalog."default",
    product_name character varying(255) COLLATE pg_catalog."default",
    model_year integer,
    quantity integer,
    list_price numeric,
    revenue numeric,
    discount numeric,
    profit numeric,
    order_date date,
    required_date date,
    shipped_date date,
    sales_name text COLLATE pg_catalog."default",
    manager_name text COLLATE pg_catalog."default",
    store_name character varying(50) COLLATE pg_catalog."default",
    city character varying(50) COLLATE pg_catalog."default",
    shipping_status character varying COLLATE pg_catalog."default",
	dup_row integer
)

INSERT INTO set.bikeshop_data_nodup 
SELECT *, 
		ROW_NUMBER() OVER(PARTITION BY order_id, brand_name, product_name, order_date, list_price) AS dup_row
	FROM set.bike_shop_dataset

DELETE
FROM set.bikeshop_data_nodup
WHERE dup_row > 1

SELECT * FROM set.bikeshop_data_nodup

---melihat total pesanan terlambat berdas


--meihat pesanan terlambat berdasarkan hari pesanan dibuat
SELECT
	TO_CHAR(order_date, 'Day') AS delay_by_day,
	COUNT(order_id) AS total_delay
FROM set.bikeshop_data_nodup
WHERE EXTRACT (YEAR FROM order_date) = 2017
	AND shipping_status = 'Delay'
GROUP BY delay_by_day
ORDER BY total_delay DESC

--melihat pesanan terlambat berdasrkan bulan
SELECT
	TO_CHAR(order_date, 'Month') AS delay_by_month,
	COUNT(order_id) AS total_delay
FROM set.bikeshop_data_nodup
WHERE EXTRACT (YEAR FROM order_date) = 2017
	AND shipping_status = 'Delay'
GROUP BY delay_by_month
ORDER BY total_delay DESC

--melihat pesanan terlambat berdasarkan nama toko cabang
SELECT
	store_name,
	COUNT(order_id) AS total_delay
FROM set.bikeshop_data_nodup
WHERE EXTRACT (YEAR FROM order_date) = 2017
	AND shipping_status = 'Delay'
GROUP BY store_name
ORDER BY total_delay DESC

--melihat pesanan terlambat berdasarkan nama sales
SELECT
	sales_name,
	COUNT(order_id) AS total_delay
FROM set.bikeshop_data_nodup
WHERE EXTRACT (YEAR FROM order_date) = 2017
	AND shipping_status = 'Delay'
GROUP BY sales_name
ORDER BY total_delay DESC

ALTER TABLE set.bikeshop_data_nodup ADD COLUMN cust_city VARCHAR;

UPDATE set.bikeshop_data_nodup AS b
SET cust_city = c.city
FROM sales.customers AS c
WHERE b.customer_id = c.customer_id;

--melihat pesanan terlambat berdasarkan kota tujuan pengiriman
SELECT
	cust_city,
	COUNT(order_id) AS total_delay
FROM set.bikeshop_data_nodup
WHERE EXTRACT (YEAR FROM order_date) = 2017
	AND shipping_status = 'Delay'
GROUP BY cust_city
ORDER BY total_delay DESC

--melihat pesanan terlambat berdasarkan categori barang
SELECT
	category_name,
	COUNT(order_id) AS total_delay
FROM set.bikeshop_data_nodup
WHERE EXTRACT (YEAR FROM order_date) = 2017
	AND shipping_status = 'Delay'
GROUP BY category_name
ORDER BY total_delay DESC

--melihat pesanan terlambat berdasarkan barang
SELECT
	product_name,
	COUNT(order_id) AS total_delay
FROM set.bikeshop_data_nodup
WHERE EXTRACT (YEAR FROM order_date) = 2017
	AND shipping_status = 'Delay'
GROUP BY product_name
ORDER BY total_delay DESC


SELECT  TO_CHAR(order_date,'Day'), TO_CHAR(shipped_date,'Day')
FROM set.bikeshop_data_nodup
WHERE EXTRACT (YEAR FROM order_date) = 2017
	AND shipping_status = 'Delay'
	AND product_name = 'Electra Townie Original 7D EQ - 2016'