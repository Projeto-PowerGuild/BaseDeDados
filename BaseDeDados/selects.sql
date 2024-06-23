-- Pesquisa 1: Seleciona as plataformas e os desenvolvedores com base em IDs correspondentes

SELECT 
    p.id, 
    p.name AS platform_name, 
    d.id AS developer_id, 
    d.name AS developer_name
FROM 
    platforms p
JOIN 
    developers d
ON 
    p.id = d.id;

-- Pesquisa 2: Seleciona os desenvolvedores e o número de plataformas em que eles estão registrados

SELECT 
    d.id AS developer_id, 
    d.name AS developer_name, 
    COUNT(p.id) AS platform_count
FROM 
    developers d
JOIN 
    platforms p ON d.id = p.id
GROUP BY 
    d.id, d.name;

-- Pesquisa 3: Seleciona os produtos, desenvolvedores e fornecedores com base nas chaves estrangeiras nos produtos

SELECT pr.id 
    AS product_id, pr.name 
    AS product_name, dev.name 
    AS developer_name, sup.name
    AS supplier_name
FROM
    products pr
JOIN 
    developers dev ON pr.fk_developers_id = dev.id
JOIN 
    suppliers sup ON pr.fk_suppliers_id = sup.id;

-- Pesquisa 4: Seleciona os clientes e os detalhes do utilizador associado a cada cliente
SELECT 
    cu.id AS customer_id, cu.address, cu.postal_code, cu.phone_number, 
    usr.name AS user_name, usr.email
FROM 
    customers cu
JOIN 
    users usr ON cu.fk_user_id = usr.id;

-- Pesquisa 5: Seleciona os detalhes dos pagamentos, clientes associados e vendas associadas
SELECT 
    pay.id AS payment_id, pay.card_name, pay.card_number, pay.cvc, pay.due_date, 
    cu.id AS customer_id, 
    sa.id AS sale_id
FROM 
    payments pay
JOIN 
    customers_payments cp 
ON 
    pay.id = cp.fk_payments_id
JOIN 
    customers cu ON cp.fk_customers_id = cu.id
JOIN 
    sales sa ON cp.fk_sales_id = sa.id;

-- Pesquisa 6: Obtenha os detalhes dos produtos com preço superior a 50 juntamente com os desenvolvedores que os criaram.

SELECT     
    p.name AS product_name,
    p.price,
    d.name AS developer_name,
    d.contact_email
FROM 
    products p
JOIN 
    developers d ON p.fk_developers_id = d.id
WHERE 
    p.price > 50;
    
-- Pesquisa 7: Encontre desenvolvedores que tenham mais de 2 produtos

SELECT 
    developers.name AS developer_name,
    COUNT(products.id) AS product_count
FROM 
    developers
JOIN 
    products ON developers.id = products.fk_developers_id
GROUP BY 
    developers.name
HAVING 
    COUNT(products.id) > 2;

-- Pesquisa 8: Conte o número de produtos por categoria.

SELECT 
    category,
    COUNT(id) AS product_count
FROM 
    products
GROUP BY 
    category;
    
 -- Pesquisa 9: Obtenha a quantidade total de avaliações e a média de classificações por produto.
 
SELECT 
    products.name AS product_name,
    COUNT(reviews.id) AS review_count,
    AVG(reviews.ratings) AS average_rating
FROM 
    products
JOIN 
    reviews ON products.id = reviews.fk_product_id
GROUP BY 
    products.name
HAVING 
    COUNT(reviews.id) > 0;

    
-- Pesquisa 10: Mostre os produtos que têm uma avaliação média maior ou igual que 4.
    
SELECT 
    products.name AS product_name,
    AVG(reviews.ratings) AS average_rating
FROM 
    products
JOIN 
    reviews ON products.id = reviews.fk_product_id
GROUP BY 
    products.name
HAVING 
    AVG(reviews.ratings) >= 4;

-- Pesquisa 11: Obtem os detalhes dos produtos juntamente com os nomes das plataformas em que estão disponíveis.

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
    
-- Pesquisa 12: Obtem os detalhes dos desenvolvedores juntamente com a média de classificações das suas avaliações e mostra apenas as avaliações acima de 3.

SELECT 
    d.name AS developer_name,
    ROUND(AVG(r.ratings), 0) AS average_rating
FROM 
    developers d
LEFT JOIN 
    products p ON d.id = p.fk_developers_id
JOIN 
    reviews r ON p.id = r.fk_product_id
WHERE 
    r.ratings IS NOT NULL AND r.ratings > 3
GROUP BY 
    d.id;
    
-- Pesquisa 13: Obtem os detalhes das vendas juntamente com o nome do distribuidor e a quantidade de produtos disponíveis

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
    
-- Pesquisa 14: Obtem a quantidade dos produtos, clientes, desenvolvedores e fornecedores.

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

-- Pesquisa 15: Obtem os detalhes do cliente, jogo comprado, total gasto e detalhes do pagamento.

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
    
-- Pesquisa 16: A subconsulta retorna os IDs dos produtos com média de classificações superior a 4, a consulta externa retorna detalhes dos produtos, incluindo nome do produto, nome do desenvolvedor e média das classificações

SELECT
    p.name AS product_name,
    d.name AS developer_name,
    AVG(r.ratings) AS average_rating
FROM 
    products p
JOIN 
    developers d ON p.fk_developers_id = d.id
JOIN 
    reviews r ON p.id = r.fk_product_id
WHERE 
    p.id IN (
        SELECT 
            r.fk_product_id
        FROM 
            reviews r
        GROUP BY 
            r.fk_product_id
        HAVING 
            AVG(r.ratings) > 4
    )
GROUP BY 
    p.id, d.name;

-- Pesquisa 17: A subconsulta retorna os IDs dos distribuidores cujas vendas, somadas pelo preço e quantidade dos produtos, ultrapassam 1000, a consulta externa retorna detalhes dos distribuidores, incluindo ID, nome e localização, apenas para aqueles cujos IDs foram retornados pela subconsulta.

SELECT 
    d.id AS distributor_id,
    d.name AS distributor_name,
    d.location
FROM 
    distributors d
WHERE 
    d.id IN (
        SELECT 
            s.fk_distributors_id
        FROM 
            sales s
        JOIN 
            sales_products sp ON s.id = sp.fk_sales_id
        GROUP BY 
            s.fk_distributors_id
        HAVING 
            SUM(sp.price * sp.quantity) > 1000
);

-- Pesquisa 18: A subconsulta retorna a média dos preços de todos os produtos, a consulta externa seleciona o ID, nome e preço dos produtos, juntamente com o nome do desenvolvedor

SELECT 
    p.id AS product_id,
    p.name AS product_name,
    p.price,
    d.name AS developer_name
FROM 
    products p
JOIN 
    developers d ON p.fk_developers_id = d.id
WHERE 
    p.price > (SELECT AVG(price) FROM products);

-- Pesquisa 19: A subconsulta retorna os IDs dos clientes que realizaram pagamentos associados a vendas ocorridas nos últimos 30 dias, a consulta externa seleciona o ID do cliente, endereço, número de telefone, nome e e-mail do usuário associado a cada cliente

SELECT 
    c.id AS customer_id,
    c.address AS customer_address,
    c.phone_number AS customer_phone,
    u.name AS user_name,
    u.email AS user_email
FROM 
    customers c
JOIN 
    users u ON c.fk_user_id = u.id
WHERE 
    c.id IN (
        SELECT cp.fk_customers_id
        FROM customers_payments cp
        JOIN sales s ON cp.fk_sales_id = s.id
        WHERE s.date >= NOW() - INTERVAL 30 DAY
);

-- Pesquisa 20: A subconsulta retorna os IDs dos desenvolvedores associados a produtos que têm desconto maior que 44, a consulta externa seleciona o ID, nome, localização e e-mail de contato dos desenvolvedores

SELECT 
    d.id AS developer_id,
    d.name AS developer_name,
    d.location,
    d.contact_email
FROM 
    developers d
WHERE 
    d.id IN (
        SELECT p.fk_developers_id
        FROM products p
        WHERE p.discount > 044
);
