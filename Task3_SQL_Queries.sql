-- Task 3: SQL for Data Analysis
-- Database: SQLite (also adaptable to MySQL/PostgreSQL)
-- Dataset: Small sample e-commerce database created for this task.
-- Run this script in DB Browser for SQLite or the sqlite3 command-line tool.

PRAGMA foreign_keys = ON;

DROP VIEW IF EXISTS customer_revenue;
DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS customers;

CREATE TABLE customers (
    customer_id INTEGER PRIMARY KEY,
    customer_name TEXT NOT NULL,
    city TEXT,
    email TEXT
);

CREATE TABLE products (
    product_id INTEGER PRIMARY KEY,
    product_name TEXT NOT NULL,
    category TEXT,
    price REAL NOT NULL CHECK (price >= 0)
);

CREATE TABLE orders (
    order_id INTEGER PRIMARY KEY,
    customer_id INTEGER,
    order_date TEXT NOT NULL,
    status TEXT,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE order_items (
    order_item_id INTEGER PRIMARY KEY,
    order_id INTEGER NOT NULL,
    product_id INTEGER NOT NULL,
    quantity INTEGER NOT NULL CHECK (quantity > 0),
    unit_price REAL NOT NULL CHECK (unit_price >= 0),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

INSERT INTO customers VALUES
(1, 'Asha', 'Hyderabad', 'asha@example.com'),
(2, 'Rahul', 'Bengaluru', 'rahul@example.com'),
(3, 'Meena', 'Chennai', 'meena@example.com'),
(4, 'Arjun', 'Hyderabad', 'arjun@example.com'),
(5, 'Sara', NULL, 'sara@example.com');

INSERT INTO products VALUES
(101, 'Laptop', 'Electronics', 55000),
(102, 'Mouse', 'Electronics', 700),
(103, 'Chair', 'Furniture', 4500),
(104, 'Notebook', 'Stationery', 100),
(105, 'Desk', 'Furniture', 8000);

INSERT INTO orders VALUES
(1001, 1, '2026-10-01', 'Delivered'),
(1002, 2, '2026-10-03', 'Delivered'),
(1003, 1, '2026-10-05', 'Shipped'),
(1004, 3, '2026-10-07', 'Delivered'),
(1005, 4, '2026-10-09', 'Cancelled');

INSERT INTO order_items VALUES
(1, 1001, 101, 1, 55000),
(2, 1001, 102, 2, 700),
(3, 1002, 103, 1, 4500),
(4, 1003, 104, 5, 100),
(5, 1003, 102, 1, 700),
(6, 1004, 105, 1, 8000),
(7, 1005, 104, 3, 100);

-- 1. SELECT, WHERE and ORDER BY: products costing more than 500.
SELECT product_name, price
FROM products
WHERE price > 500
ORDER BY price DESC;

-- 2. GROUP BY and aggregate functions: total quantity sold per product.
SELECT p.product_name, SUM(oi.quantity) AS total_quantity
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY p.product_id, p.product_name
ORDER BY total_quantity DESC;

-- 3. INNER JOIN: show orders with customer names.
SELECT o.order_id, c.customer_name, o.order_date, o.status
FROM orders o
INNER JOIN customers c ON o.customer_id = c.customer_id;

-- 4. LEFT JOIN: show every customer, including customers with no orders.
SELECT c.customer_name, o.order_id
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
ORDER BY c.customer_id;

-- 5. RIGHT JOIN: show all customers and their orders (SQLite 3.39+).
-- RIGHT JOIN keeps every row from the table on the right.
SELECT c.customer_name, o.order_id
FROM orders o
RIGHT JOIN customers c ON o.customer_id = c.customer_id
ORDER BY c.customer_id;

-- 6. Revenue by order. Cancelled orders are excluded.
SELECT o.order_id,
       SUM(oi.quantity * oi.unit_price) AS order_revenue
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
WHERE o.status <> 'Cancelled'
GROUP BY o.order_id
ORDER BY order_revenue DESC;

-- 7. Average revenue per purchasing customer (ARPU).
SELECT SUM(oi.quantity * oi.unit_price) * 1.0
       / COUNT(DISTINCT o.customer_id) AS average_revenue_per_user
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
WHERE o.status <> 'Cancelled';

-- 8. Subquery: products priced above the average product price.
SELECT product_name, price
FROM products
WHERE price > (SELECT AVG(price) FROM products);

-- 9. HAVING: customers whose total order value is above 5,000.
SELECT c.customer_name,
       SUM(oi.quantity * oi.unit_price) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
WHERE o.status <> 'Cancelled'
GROUP BY c.customer_id, c.customer_name
HAVING SUM(oi.quantity * oi.unit_price) > 5000;

-- 10. View for reusable customer revenue analysis.
CREATE VIEW customer_revenue AS
SELECT c.customer_id, c.customer_name,
       COALESCE(SUM(
           CASE WHEN o.status <> 'Cancelled'
                THEN oi.quantity * oi.unit_price ELSE 0 END
       ), 0) AS total_revenue
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
LEFT JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY c.customer_id, c.customer_name;

-- Display the view.
SELECT * FROM customer_revenue ORDER BY total_revenue DESC;

-- 11. Indexes to help common joins and filters.
CREATE INDEX idx_orders_customer_id ON orders(customer_id);
CREATE INDEX idx_order_items_order_id ON order_items(order_id);
CREATE INDEX idx_order_items_product_id ON order_items(product_id);
CREATE INDEX idx_orders_status ON orders(status);

-- 12. Example query to inspect the query plan (SQLite).
EXPLAIN QUERY PLAN
SELECT order_id, order_date
FROM orders
WHERE customer_id = 1;
