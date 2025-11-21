SELECT 
	o.order_id,
	c.customer_id,
	CONCAT(c.first_name,' ',c.last_name) AS customer_name,
	b.brand_name,
	ca.category_name,
	p.product_name,
	p.model_year,
	oi.quantity,
	oi.list_price,
	SUM(oi.quantity*oi.list_price) AS revenue,
	oi.discount,
	SUM((oi.quantity*oi.list_price)-(oi.discount*oi.list_price)) AS profit,
	o.order_date,
	o.required_date,
	o.shipped_date,
	CONCAT(s.first_name,' ',s.last_name) AS sales_name,
	CONCAT(m.first_name,' ',m.last_name) AS manager_name,
	st.store_name,
	st.city

FROM 
	sales.orders o
LEFT JOIN 
	sales.customers c ON c.customer_id = o.customer_id
LEFT JOIN
	sales.order_items oi ON o.order_id = oi.order_id
LEFT JOIN
	production.products p ON oi.product_id = p.product_id
LEFT JOIN 
	production.categories ca ON p.category_id = ca.category_id
LEFT JOIN 
	production.brands b ON p.brand_id = b.brand_id
LEFT JOIN
	sales.staffs s ON o.staff_id = s.staff_id
LEFT JOIN 
	sales.stores st ON o.store_id = st.store_id
LEFT JOIN
	sales.staffs m ON m.staff_id = s.manager_id

GROUP BY
	o.order_id,
	c.customer_id,
	customer_name,
	b.brand_name,
	ca.category_name,
	p.product_name,
	p.model_year,
	oi.quantity,
	oi.list_price,
	oi.discount,
	o.order_date,
	o.required_date,
	o.shipped_date,
	sales_name,
	manager_name,
	st.store_name,
	st.city
	
ORDER BY o.order_id ASC;

	
	
	
	
	
	