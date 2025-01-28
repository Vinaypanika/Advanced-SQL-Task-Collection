/* Que 1- Display the full name of customers in a single field 
by merging their first and last names,
and add 10 bonus points to each customer's score */


select customerid,firstname,lastname,score,
concat(firstname,' ',lastname) as fullname,
10 + coalesce(score,0) as final_score
from sales.Customers;

/* Que 2- Sort the customer's form lowest to highest score
with nulls apearing last */


select CustomerID,
FirstName,
score
from sales.Customers
order by case when score is null then 1 else 0 end,score;



/* Que3- Find the sales price for each order by dividing the sales by the quantity */

select orderid,
orderdate,quantity,sales,
sales/nullif(quantity,0) as sales_price
from sales.orders;




/* Que4- Identify the customers who have no score */
select * from sales.Customers
where score is null;






/* Que5- Identify the customers who have score */

select * from sales.customers
where score is not null;




/* Que 6- List all details of customers who have not placed any orders */

select c.customerid,c.firstname,c.lastname,o.orderid
from sales.Customers as c
left join sales.orders as o
on c.CustomerID=o.CustomerID
where o.CustomerID is null;




