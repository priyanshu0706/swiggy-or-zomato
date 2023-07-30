# Q1 Find the users who never order from zomato #

SELECT * 
FROM users
left join orders
on users.user_id = orders.user_id
where order_id is null

# Q2 find the average price of food #

select (food.f_name) , avg (menu.price) as avg_price
from food
join menu
on food.f_id = menu.f_id
group by food.f_name
order by avg_price desc


#Q3 Find the top restaurant in terms of the number of orders for a given month #

SELECT  (restaurants.r_name), count(orders.r_id) as num_of_orders
from restaurants
join orders
on restaurants.r_id = orders.r_id
where monthname(orders.date) like 'june'
group by restaurants.r_name
order by num_of_orders desc

# Q4 restaurants with monthly sales greater than 5000 for june month #

SELECT restaurants.r_name , sum( orders.amount) as total_amount
FROM orders 
join restaurants 
on orders.r_id = restaurants.r_id 
where monthname(orders.date)  like 'june'
group by restaurants.r_name
having total_amount > 500
order by total_amount desc

# Q5 Show all orders with order details for a particular customer in a particular date range

SELECT orders.order_id, restaurants.r_name, food.f_name
FROM orders
join restaurants
on  restaurants.r_id = orders.r_id
join khana
on orders.order_id = khana.order_id
join food
on food.f_id = khana.f_id
where user_id = '4'


# Q6 Find restaurants with max repeated customers 

SELECT users.name, restaurants.r_name, count(*) as 'n_of_order'
FROM orders
join users
on users.user_id = orders.user_id
join restaurants
on restaurants.r_id = orders.r_id
group by users.name, restaurants.r_name
order by n_of_order desc 
limit 5


# Q7 Month over month revenue growth of swiggy

select month, ((profit - last_yr_prf)/last_yr_prf)*100 as che_in_profit
from
(
	with sales as
	(
    SELECT monthname(date) as month ,  sum(amount) as profit
	FROM orders
    group by monthname(date)
     )


select month, profit, lag(profit, 1) over (order by profit) as last_yr_prf
from sales
 ) t

# Q8  most order food

SELECT   food.f_name, count(food.f_name) as no_of_order
FROM khana
join food
on food.f_id = khana.f_id
group by food.f_name
order by no_of_order desc
limit 5

# Q9  Customer  favorite food

with temp as
(
SELECT users.name, food.f_name, count(food.f_name) as no_of_order
FROM orders
join khana
on khana.order_id = orders.order_id
join food
on food.f_id = khana.f_id
join users
on users.user_id = orders.user_id
group by food.f_name , users.name
order by no_of_order desc
)
select *
from temp
where no_of_order  =
 ( select max(no_of_order)
 from temp
   
 )







