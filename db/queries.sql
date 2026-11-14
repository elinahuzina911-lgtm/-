-- Магазин обуви «Шаг»: примеры запросов (после create_v1.sql и загрузки данных)
USE shoe_shop;

-- 1. Каталог: товар, категория, производитель, цена со скидкой
SELECT p.article, p.name, c.name AS category, m.name AS manufacturer,
       p.price, p.discount,
       ROUND(p.price * (100 - p.discount) / 100, 2) AS final_price,
       p.stock
FROM products p
JOIN categories c    ON c.id = p.category_id
JOIN manufacturers m ON m.id = p.manufacturer_id
ORDER BY p.name;

-- 2. Поиск по названию
SELECT article, name, price, stock
FROM products
WHERE name LIKE '%кроссовки%';

-- 3. Фильтр: категория + производитель + есть в наличии
SELECT p.article, p.name, p.price, p.stock
FROM products p
JOIN categories c    ON c.id = p.category_id
JOIN manufacturers m ON m.id = p.manufacturer_id
WHERE c.name = 'Женская обувь'
  AND m.name = 'Kari'
  AND p.stock > 0;

-- 4. Сортировка по цене со скидкой (по возрастанию)
SELECT article, name, ROUND(price * (100 - discount) / 100, 2) AS final_price
FROM products
ORDER BY final_price ASC;

-- 5. Остатки по категориям
SELECT c.name AS category, COUNT(*) AS items, SUM(p.stock) AS total_stock
FROM products p
JOIN categories c ON c.id = p.category_id
GROUP BY c.name;

-- 6. Товары с низким остатком (меньше 10 шт.)
SELECT article, name, stock
FROM products
WHERE stock < 10
ORDER BY stock;

-- 7. Заказы: клиент, пункт выдачи, статус, сумма заказа
SELECT o.id, o.order_date, u.full_name AS client, pv.address, s.name AS status,
       SUM(po.quantity * ROUND(p.price * (100 - p.discount) / 100, 2)) AS total
FROM orders o
JOIN users u         ON u.id = o.user_id
JOIN pvz pv          ON pv.id = o.pvz_id
JOIN orderstatus s   ON s.id = o.status_id
JOIN prodorders po   ON po.order_id = o.id
JOIN products p      ON p.id = po.product_id
GROUP BY o.id, o.order_date, u.full_name, pv.address, s.name
ORDER BY o.id;

-- 8. Состав конкретного заказа
SELECT p.article, p.name, po.quantity
FROM prodorders po
JOIN products p ON p.id = po.product_id
WHERE po.order_id = 1;

-- 9. Самые продаваемые товары
SELECT p.name, SUM(po.quantity) AS sold
FROM prodorders po
JOIN products p ON p.id = po.product_id
GROUP BY p.id, p.name
ORDER BY sold DESC
LIMIT 5;

-- 10. Пользователи и их роли
SELECT u.login, u.full_name, r.name AS role
FROM users u
JOIN roles r ON r.id = u.role_id
ORDER BY r.id, u.full_name;

-- 11. Количество заказов по статусам
SELECT s.name AS status, COUNT(o.id) AS orders_count
FROM orderstatus s
LEFT JOIN orders o ON o.status_id = s.id
GROUP BY s.name;

-- 12. Списание остатка при оформлении заказа (пример транзакции)
START TRANSACTION;
UPDATE products p
JOIN prodorders po ON po.product_id = p.id
SET p.stock = p.stock - po.quantity
WHERE po.order_id = 7;
COMMIT;
