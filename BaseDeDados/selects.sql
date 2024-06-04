SELECT p.id, p.name AS platform_name, d.id AS developer_id, d.name AS developer_name
FROM platforms p, developers d
WHERE p.id = d.id;

SELECT p.id, p.name AS platform_name, d.id AS developer_id, d.name AS developer_name
FROM platforms p
JOIN developers d
ON p.id = d.id;

SELECT pr.id AS product_id, pr.name AS product_name, dev.name AS developer_name, sup.name AS supplier_name
FROM products pr
JOIN developers dev ON pr.fk_developers_id = dev.id
JOIN suppliers sup ON pr.fk_suppliers_id = sup.id;

SELECT cu.id AS customer_id, cu.address, cu.postal_code, cu.phone_number, usr.name AS user_name, usr.email
FROM customers cu
JOIN users usr ON cu.fk_user_id = usr.id;

SELECT pay.id AS payment_id, pay.card_name, pay.card_number, pay.cvc, pay.due_date, cu.id AS customer_id, sa.id AS sale_id
FROM payments pay
JOIN customers_payments cp ON pay.id = cp.fk_payments_id
JOIN customers cu ON cp.fk_customers_id = cu.id
JOIN sales sa ON cp.fk_sales_id = sa.id;
