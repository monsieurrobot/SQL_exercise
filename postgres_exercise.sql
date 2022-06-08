/* SQL Exercise
====================================================================
We will be working with database northwind.db we have set up and connected to in the activity Connect to Remote PostgreSQL Database earlier.


-- MAKE YOURSELF FAIMLIAR WITH THE DATABASE AND TABLES HERE





--==================================================================
/* TASK I
-- Q1. Write a query to get Product name and quantity/unit.
*/
SELECT ProductName, QuantityPerUnit FROM Products;

/* TASK II
Q2. Write a query to get the most expensive and the least expensive Product (name and unit price) (2 separate queries)
*/
SELECT ProductName, MAX(UnitPrice) as MostExpensive FROM Products
GROUP BY ProductName
ORDER BY MAX(UnitPrice) DESC
LIMIT 1;
SELECT ProductName, MIN(UnitPrice) as LeastExpensive FROM Products
GROUP BY ProductName
ORDER BY MIN(UnitPrice) ASC
LIMIT 1;

/* TASK III
Q3. Write a query to count current and discontinued products.
*/

SELECT SUM(Discontinued) as discontinued FROM Products;
SELECT (COUNT(ProductID) - SUM(Discontinued)) as available FROM Products;

/* TASK IV
Q4. Select all product names and their category names (77 rows)
*/

SELECT Products.ProductName, Categories.CategoryName FROM Products
JOIN Categories ON Products.CategoryID = Categories.CategoryID;

/* TASK V
Q5. Select all product names, unit price and the supplier region that don't have suppliers from the country USA. (65 rows)
*/

SELECT Products.ProductName, Products.UnitPrice, Suppliers.Region FROM Products
RIGHT JOIN Suppliers ON Products.SupplierID = Suppliers.SupplierID
WHERE Suppliers.Country != 'USA';


/* TASK VI
Q6. Get the total quantity of orders sold.( 51317)
*/

SELECT SUM(Quantity) as orders_sold FROM Order_Details;

/* TASK VII
Q7. Get the total quantity of orders sold for each order.(830 rows)
*/

SELECT SUM(Quantity) as orders_sold, OrderID FROM Order_Details
GROUP BY OrderID;

/* TASK VIII
Q8. Get the number of employees who have been working more than 5 year in the company. (9 rows)
*/

SELECT COUNT(HireDate) FROM employees
WHERE HireDate < ('2017-06-06 12:00:00');