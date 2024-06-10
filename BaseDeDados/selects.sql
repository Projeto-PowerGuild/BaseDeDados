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


-- Obtenha os detalhes dos produtos juntamente com os desenvolvedores que os criaram.
SELECT 
    p.name AS product_name,
    p.price,
    d.name AS developer_name,
    d.contact_email
FROM 
    products p
LEFT JOIN 
    developers d ON p.fk_developers_id = d.id
WHERE 
    p.price > 50;
    
-- Encontre desenvolvedores que tenham mais de 2 produtos

SELECT 
    developers.name AS developer_name,
    COUNT(products.id) AS product_count
FROM 
    developers
LEFT JOIN 
    products ON developers.id = products.fk_developers_id
GROUP BY 
    developers.name
HAVING 
    COUNT(products.id) > 2;

-- Conte o número de produtos por categoria.

SELECT 
    category,
    COUNT(id) AS product_count
FROM 
    products
GROUP BY 
    category;
    
 -- Obtenha a quantidade total de avaliações e a média de classificações por produto.
 
 SELECT 
    products.name AS product_name,
    COUNT(reviews.id) AS review_count,
    AVG(reviews.ratings) AS average_rating
FROM 
    products
LEFT JOIN 
    reviews ON products.id = reviews.fk_product_id
GROUP BY 
    products.name;
    
-- Liste os produtos que têm uma avaliação média maior ou igual que 4.
    
    SELECT 
    products.name AS product_name,
    AVG(reviews.ratings) AS average_rating
FROM 
    products
LEFT JOIN 
    reviews ON products.id = reviews.fk_product_id
GROUP BY 
    products.name
HAVING 
    AVG(reviews.ratings) >= 4;

    