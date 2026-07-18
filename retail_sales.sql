-- create table
CREATE TABLE retail_sales (
    transactions_id INT PRIMARY KEY,
    sale_date DATE,
    sale_time TIME,
    customer_id INT,
    gender VARCHAR(15),
    age INT,
    category VARCHAR(15),
    quantity INT,
    price_per_unit FLOAT,
    cogs FLOAT,
    total_sale FLOAT
);

alter table retail_sales
rename column quantiy to quantity;
SELECT * from retail_sales
limit 5

select count(*) from retail_sales

-- data cleaning --
-- check null values
select * from retail_sales
where 
	transactions_id is null
	or 
	sale_date is null
	or 
	sale_time is null
	or 
	customer_id is null
	or 
	gender is null
	or 
	age is null
	or 
	category is null
	or 
	quantity is null
	or 
	price_per_unit is null
	or 
	cogs is null
	or 
	total_sale is null;

-- delete null values
delete from retail_sales
where 
	transactions_id is null
	or 
	sale_date is null
	or 
	sale_time is null
	or 
	customer_id is null
	or 
	gender is null
	or 
	age is null
	or 
	category is null
	or 
	quantity is null
	or 
	price_per_unit is null
	or 
	cogs is null
	or 
	total_sale is null;


-- data exploration --
-- how many sales we have
select count(*) as total_sales from retail_sales

-- how many  unique customers id we have 
select count(distinct customer_id) as total_sales from retail_sales

select distinct category from retail_sales

-- Data Analysis & Business Key Problems & Answers

-- My Analysis & Findings
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)



-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05'

select * from retail_sales
where 
	sale_date = '2022-12-05';

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022

select 
*
from retail_sales
where 
	category = 'Clothing'
	and 
	to_char(sale_date, 'YYYY-MM') = '2022-11'
	and
	quantity >= 4

-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
	
select 
	category, 
	sum(total_sale) as net_sales,
	count(*) as total_orders
from retail_sales
group by 1

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

select 
	round(avg(age),2) as average_age
from retail_sales
where 
	category = 'Electronics'

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.

select
	* 
from retail_sales
WHERE 
	total_sale > 1000

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.

select 
	category,
	gender,
	count(*) as total_trans
from retail_sales
group by 
	category, gender
order by 1
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
select
	year, month, avg_sale from
(
	select 
		extract(year from sale_date) as year,
		extract(month from sale_date) as month,
		avg(total_sale) as avg_sale, 
		rank() over(partition by extract (year from sale_date)  order by avg(total_sale)desc)as Rank
	from retail_sales
	group by 1,2
	order by 1,3 desc
)as t2
where rank = 1

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 

select 
	customer_id, 
	sum(total_sale) as total_sales 
from retail_sales
group by 1
order by 2 desc
limit 5

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.

SELECT 
    category,    
    COUNT(DISTINCT customer_id) as cnt_unique_cs
FROM retail_sales
GROUP BY category

-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)

WITH hourly_sale
AS
(
SELECT *,
    CASE
        WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END as shift
FROM retail_sales
)
SELECT 
    shift,
    COUNT(*) as total_orders    
FROM hourly_sale
GROUP BY shift

-- END OF PROJECT --
