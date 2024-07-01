--SQL queries used to check the data 
---------------------------------------------------------------------------------------------
--To calc the total_revenue of the pizza shop
Select
  sum(total_price) as Total_Revenue
from
  pizza_sales;

--output
--Total_Revenue =  817860.05083847
---------------------------------------------------------------------------------------------
--To calc average order value
Select
  sum(total_price) / count(Distinct order_id) as Average_order_value
from
  pizza_sales;

-- output
--Average_order_value  = 38.3072623343546
---------------------------------------------------------------------------------------------
--To calc total pizza sold
Select
  sum(quantity) as total_pizza_sold
from
  pizza_sales;

-- output
--total_pizza_sold  = 49574
---------------------------------------------------------------------------------------------
--Total order placed
Select
  count(distinct order_id) as total_order
from
  pizza_sales;

--output
--21350
---------------------------------------------------------------------------------------------
-- average pizzas per order
Select
  CAST(sum(quantity) as decimal(10, 2)) / cast(count(distinct order_id) as decimal(10, 2)) as avg_pizza_per_order
from
  pizza_sales
  --output =2.3219672131147
  ---------------------------------------------------------------------------------------------------
  -- daiy trend of orders as per the week day
Select
  DATENAME (DW, order_date) as order_day,
  count(Distinct order_id) as Total_order
from
  pizza_sales
group by
  DATENAME (DW, order_date);

--output
--   Saturday	3158
-- Wednesday	3024
-- Monday	2794
-- Sunday	2624
-- Friday	3538
-- Thursday	3239
-- Tuesday	2973
---------------------------------------------------------------------------------------------
--hourly trend
Select
  datepart (hour, order_time) as order_hour,
  count(distinct order_id) as Total_orders
from
  pizza_sales
group by
  datepart (hour, order_time)
order by
  datepart (hour, order_time);

--output
--hour --total_orders
-- 9	1
-- 10	8
-- 11	1231
-- 12	2520
-- 13	2455
-- 14	1472
-- 15	1468
-- 16	1920
-- 17	2336
-- 18	2399
-- 19	2009
-- 20	1642
-- 21	1198
-- 22	663
-- 23	28
---------------------------------------------------------------------------------------------
--percentage of sales by pizza category
select
  pizza_category,
  sum(total_price) * 100 / (
    select
      sum(total_price)
    from
      pizza_sales
  ) as sales_percentage
from
  pizza_sales
group by
  pizza_category;

--output
-- category --sales_percentage
-- Classic	26.9059602306976
-- Chicken	23.9551375322885
-- Veggie	23.6825910258677
-- Supreme	25.4563112111462
--note-- to get the sales percentage for a specific month
select
  pizza_category,
  sum(total_price) * 100 / (
    select
      sum(total_price)
    from
      pizza_sales
    where
      Month (order_date) = 1
  ) as sales_percentage
from
  pizza_sales
where
  Month (order_date) = 1
group by
  pizza_category;

--note -- getting the sales percentage of quarter year
select
  pizza_category,
  sum(total_price) * 100 / (
    select
      sum(total_price)
    from
      pizza_sales here DATEPART (quarter, order_date) = 1
  ) as sales_percentage
from
  pizza_sales
where
  DATEPART (quarter, order_date) = 1
group by
  pizza_category;

---------------------------------------------------------------------------------------------
--percentage of sales by pizza size
select
  pizza_size,
  sum(total_price) as Total_Sales,
  sum(total_price) * 100 / (
    select
      sum(total_price)
    from
      pizza_sales
  ) as sales_percentage
from
  pizza_sales
group by
  pizza_size
order by
  sales_percentage;

--output
-- size -- total_sales -- sales_percentage
--XXL	1006.6000213623	0.123077294254725
-- XL	14076	1.72107684995364
-- S	178076.49981308	21.7734684107037
-- M	249382.25	30.492044420599
-- L	375318.701004028	45.8903330244889
--note -- month wise and qaurter wise data can be tested as previous
------------------------------------------------------------------------------------
--total pizza sold as per category
select
  pizza_category,
  sum(quantity) as total_pizza_sold_category_wise
from
  pizza_sales
group by
  pizza_category;

--output
--pizza_category -- total_pizza_sold_category_wise
--Classic	14888
-- Chicken	11050
-- Veggie	11649
-- Supreme	11987
-----------------------------------------------------------------------------------------
--top 5 best seller for total pizza sold
select
  top 5 pizza_name,
  sum(quantity) as Total_pizza_sold
from
  pizza_sales
group by
  pizza_name
order by
  sum(quantity) DESC
  --output--
  --pizza name   --- Total_pizza_sold
  --   The Classic Deluxe Pizza	2453
  -- The Barbecue Chicken Pizza	2432
  -- The Hawaiian Pizza	2422
  -- The Pepperoni Pizza	2418
  -- The Thai Chicken Pizza	2371
  ---------------------------------------------------------------------------------------------
  -- bottom 5 pizza sold
select
  top 5 pizza_name,
  sum(quantity) as Total_pizza_sold
from
  pizza_sales
group by
  pizza_name
order by
  sum(quantity)
  --output
  --pizza name   --- Total_pizza_sold
  --   The Brie Carre Pizza	490
  -- The Mediterranean Pizza	934
  -- The Calabrese Pizza	937
  -- The Spinach Supreme Pizza	950
  -- The Soppressata Pizza	961
  ---------------------------------------------------------------------------------------------