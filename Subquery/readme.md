-- 📌 Advanced SQL Subquery Questions

-- 1️⃣ Find the products that have a price higher than the average price of all products

-- Query:
SELECT * FROM 
    (SELECT *, AVG(price) OVER() AS avg_price FROM sales.products) t
WHERE price > avg_price;

-- 2️⃣ Rank Customers based on their total amount of sales

-- Query:
SELECT *,
       RANK() OVER(ORDER BY total_sales DESC) AS CUSTOMER_RANKING
FROM (
    SELECT customerid, SUM(sales) AS Total_sales 
    FROM sales.orders
    GROUP BY customerid
) T;

-- 3️⃣ Show the product IDs, names, prices, and total number of orders

-- Query:
SELECT PRODUCTID, PRODUCT, PRICE,
       (SELECT COUNT(ORDERID) FROM SALES.ORDERS) AS TOTAL_ORDERS
FROM SALES.PRODUCTS;

-- 4️⃣ Show all customer details and find the total orders for each customer

-- Query:
SELECT C.*, T.ORDERS_BY_CUSTOMERS 
FROM SALES.Customers AS C
LEFT JOIN (
    SELECT CUSTOMERID, COUNT(*) AS ORDERS_BY_CUSTOMERS 
    FROM SALES.ORDERS
    GROUP BY CUSTOMERID
) AS T 
ON T.CustomerID = C.CustomerID;

-- 5️⃣ Find the products that have a price higher than the average price of all products

-- Query:
SELECT *, 
       (SELECT AVG(price) FROM sales.Products) AS AVG_PRICE
FROM sales.Products
WHERE price > (SELECT AVG(price) FROM sales.Products);

-- 6️⃣ Show the details of orders made by customers in Germany

-- Query:
SELECT * FROM sales.orders 
WHERE CustomerID IN (
    SELECT CustomerID FROM sales.Customers
    WHERE Country = 'Germany'
);

-- 7️⃣ Show the details of orders for customers who are not from Germany

-- Query:
SELECT * FROM sales.orders 
WHERE CustomerID IN (
    SELECT CustomerID FROM sales.Customers
    WHERE Country != 'Germany'
);

-- OR

-- Query:
SELECT * FROM sales.orders 
WHERE CustomerID NOT IN (
    SELECT CustomerID FROM sales.Customers
    WHERE Country = 'Germany'
);

-- 8️⃣ Find female employees whose salaries are greater than the salaries of any male employees

-- Query:
SELECT * FROM sales.Employees
WHERE gender='F'
AND salary > ANY (
    SELECT salary FROM sales.Employees WHERE gender = 'M'
);

-- 9️⃣ Find female employees whose salaries are greater than the salaries of all male employees

-- Query:
SELECT * FROM sales.Employees 
WHERE gender = 'F'
AND salary > ALL (
    SELECT salary FROM sales.Employees WHERE gender = 'M'
);

-- Note: No female employee has a salary greater than all male employees.

-- 🔵 Correlated Subquery

-- 🔟 Show all customer details and find the total orders for each customer

-- Query:
SELECT *,
       (SELECT COUNT(*) FROM sales.orders AS o WHERE o.CustomerID = c.CustomerID) AS Total_order
FROM sales.Customers AS c;

-- 1️⃣1️⃣ Show the details of orders for customers who are from Germany using EXISTS

-- Query:
SELECT * FROM sales.orders AS o
WHERE EXISTS (
    SELECT 1 FROM sales.Customers AS c  -- Using 1 in subquery for optimization
    WHERE Country = 'Germany' AND c.CustomerID = o.CustomerID
);

-- 1️⃣2️⃣ Show the details of orders for customers who are not from Germany using EXISTS

-- Query:
SELECT * FROM sales.Orders AS o
WHERE NOT EXISTS (
    SELECT 1 FROM sales.Customers AS c
    WHERE Country = 'Germany' AND c.CustomerID = o.CustomerID
);
