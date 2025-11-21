SELECT 
	order_date,
	required_date,
	shipped_date,
	CASE WHEN required_date < shipped_date THEN 'Delay'
	ELSE 'On-Time' END AS shipping_status
FROM set.bike_shop_dataset

ALTER TABLE set.bike_shop_dataset ADD COLUMN shipping_status varchar;

UPDATE set.bike_shop_dataset
SET shipping_status = CASE WHEN required_date < shipped_date THEN 'Delay'
	ELSE 'On-Time' END;

SELECT * FROM set.bike_shop_dataset

SELECT 
	SUM(revenue) AS marcelene_revenue
FROM set.bike_shop_dataset
WHERE sales_name = 'Marcelene Boyer';

--Produk apa yang paling banyak terjual (berdasarkan jumlah unit)?
SELECT
	product_name,
	SUM(quantity) AS total_quantity
FROM set.bike_shop_dataset
GROUP BY product_name
ORDER BY total_quantity DESC;

--Kategori produk mana yang menyumbang penjualan terbesar?
SELECT 
	category_name,
	SUM(revenue) AS total_revenue
FROM set.bike_shop_dataset
GROUP BY category_name
ORDER BY total_revenue DESC;

--Berapa rata-rata transaksi per pelanggan?
SELECT
	customer_name,
	ROUND(AVG(revenue),2) AS total_transaction
FROM set.bike_shop_dataset
GROUP BY customer_name
ORDER BY total_transaction DESC;

--Bulan apa yang memiliki penjualan tertinggi dan terendah?


SELECT
	TO_CHAR(order_date, 'Month') AS month_sales,
	SUM(revenue) AS total_month_sales
FROM set.bike_shop_dataset
GROUP BY month_sales
ORDER BY total_month_sales DESC

--Bagaimana tren penjualan dari bulan ke bulan?
SELECT
	EXTRACT(MONTH FROM order_date) AS month_sales,
	SUM(revenue) AS total_month_sales
FROM set.bike_shop_dataset
GROUP BY month_sales
ORDER BY month_sales 

--Apakah ada perbedaan pola pembelian antara hari kerja dan akhir pekan?
SELECT 
	TO_CHAR(order_date, 'Day') AS month_sales,
	SUM(revenue) AS total_sales
FROM set.bike_shop_dataset
GROUP BY month_sales

--Pelanggan dengan jumlah pembelian terbanyak (top customers) siapa saja?
SELECT
	customer_name,
	ROUND(SUM(revenue),2) AS total_transaction
FROM set.bike_shop_dataset
GROUP BY customer_name
ORDER BY total_transaction DESC;

--Produk dengan margin keuntungan tertinggi dan terendah apa?
SELECT
	product_name,
	SUM(profit) - SUM(revenue) AS margin
FROM set.bike_shop_dataset
GROUP BY product_name
ORDER BY margin DESC

SELECT
	order_id,
	list_price,
	revenue,
	profit,
	SUM(profit) - SUM(revenue) AS margin
FROM set.bike_shop_dataset
GROUP BY order_id,
list_price,
	revenue,
	profit
ORDER BY order_id