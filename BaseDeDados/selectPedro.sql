-- Joins Pedro

-- Obtem os detalhes dos produtos juntamente com os nomes das plataformas em que estão disponíveis.
SELECT 
    p.name AS product_name,
    p.price,
    pl.name AS platform_name
FROM 
    products p
JOIN 
    products_platforms pp ON p.id = pp.fk_products_id
JOIN 
    platforms pl ON pp.fk_platforms_id = pl.id;
    
-- Obtem os detalhes dos desenvolvedores juntamente com a média de classificações das suas avaliações e mostra apenas as avaliações acima de 3.
SELECT 
    d.name AS developer_name,
    ROUND(AVG(r.ratings), 0) AS average_rating
FROM 
    developers d
LEFT JOIN 
    products p ON d.id = p.fk_developers_id
LEFT JOIN 
    reviews r ON p.id = r.fk_product_id
WHERE 
    r.ratings IS NOT NULL AND r.ratings > 3
GROUP BY 
    d.id;
    
-- Obtem os detalhes das vendas juntamente com o nome do distribuidor e a quantidade de produtos disponíveis
SELECT
    s.id AS sale_id,
    s.date AS sale_date,
    s.discount AS sale_discount,
    s.distributorsPrice AS distributor_price,
    d.name AS distributor_name,
    p.name AS product_name,
    p.quantity AS products_available
FROM
    sales s
JOIN
    distributors d ON s.fk_distributors_id = d.id
JOIN
    sales_products sp ON s.id = sp.fk_sales_id
JOIN
    products_platforms pp ON sp.fk_products_platforms_id = pp.id
JOIN
    products p ON pp.fk_products_id = p.id
ORDER BY
    s.id;
    
-- Obtem a quantidade dos produtos, clientes, desenvolvedores e fornecedores.

SELECT 
    'Products' AS Entity,
    COUNT(*) AS Count
FROM 
    products
UNION ALL
SELECT 
    'Customers' AS entity,
    COUNT(*) AS count
FROM 
    customers
UNION ALL
SELECT 
    'Developers' AS entity,
    COUNT(*) AS count
FROM 
    developers
UNION ALL
SELECT 
    'Suppliers' AS entity,
    COUNT(*) AS count
FROM 
    suppliers;

-- Obtem os detalhes do cliente, jogo comprado, total gasto e detalhes do pagamento.
SELECT 
    c.id AS customer_id,
    c.address AS customer_address,
    c.phone_number AS customer_phone,
    p.name AS product_name,
    ROUND(SUM(sp.price), 2) AS total_spent,
    pay.card_name AS payment_card_name,
    pay.card_number AS payment_card_number,
    pay.due_date AS payment_due_date
FROM 
    customers c
JOIN 
    customers_payments cp ON c.id = cp.fk_customers_id
JOIN 
    payments pay ON cp.fk_payments_id = pay.id
JOIN 
    sales s ON cp.fk_sales_id = s.id
JOIN 
    sales_products sp ON s.id = sp.fk_sales_id
JOIN 
    products_platforms pp ON sp.fk_products_platforms_id = pp.id
JOIN 
    products p ON pp.fk_products_id = p.id
GROUP BY 
    c.id, c.address, c.phone_number, p.name, pay.card_name, pay.card_number, pay.due_date;
