use mysql_practical;

-- Fetch all the User order list and include atleast following details in that.
select c.customer_name, p.product_name, o.order_date, datediff(o.delivery_date,(current_date)) as `Delivery within`
from orders o
join customer c on o.customer_id = c.customer_id
join order_details od on o.order_id = od.order_id
join product p on od.product_id = p.product_id ;

-- All undelivered Orders
select c.customer_name, p.product_name, o.order_status
from orders o
join customer c on o.customer_id = c.customer_id
join order_details od on o.order_id = od.order_id
join product p on od.product_id = p.product_id
where o.order_status = 'pending';

-- 5 Most recent orders
select o.order_id, c.customer_name, p.product_name, o.order_status
from orders o
join customer c on o.customer_id = c.customer_id
join order_details od on o.order_id = od.order_id
join product p on od.product_id = p.product_id
order by o.order_id desc limit 5;

-- Top 5 active users (Users having most number of orders)
select c.customer_name, count(o.order_id) as `No. of orders`
from orders o
join customer c on o.customer_id = c.customer_id
group by c.customer_name
order by count(o.order_id) desc limit 5;

-- Inactive users (Users who hasn’t done any order)
select customer_name as `Inactive Customers`
from customer
where customer_id not in (select distinct orders.customer_id from orders);

-- Top 5 Most purchased products
select od.product_id, p.product_name, sum(od.product_quantity) as `Quantity`  
from order_details od
join product p on od.product_id = p.product_id
group by od.product_id
order by `Quantity` desc limit 5;

-- Most expensive order.
select od.order_id, p.product_name, od.product_quantity, od.total_amount as `Amount`
from order_details od
join product p on od.product_id = p.product_id
order by `Amount` desc limit 1; 

-- most chepest orders
select od.order_id, p.product_name, od.product_quantity, od.total_amount as `Amount`
from order_details od
join product p on od.product_id = p.product_id
order by `Amount` limit 1; 
