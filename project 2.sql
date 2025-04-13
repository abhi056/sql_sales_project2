CREATE DATABASE PROJECT2;

DROP TABLE IF EXISTS sales;

CREATE TABLE sales(
		transactions_id	INT PRIMARY KEY,
		sale_date DATE,
		sale_time TIME, 	
		customer_id	INT,
		gender VARCHAR(50),	
		age	INT,
		category VARCHAR(20),	
		quantiy	INT,
		price_per_unit FLOAT,
		cogs FLOAT,
		total_sale FLOAT
);


ALTER TABLE sales
RENAME COLUMN quantiy TO quantity;
select * from sales;


SELECT 
COUNT(*) FROM SALES

--DATA CLEANING

SELECT *FROM SALES
WHERE 
sale_time is null
or
transactions_id is null
or
sale_date is null
or
gender is null
or 
category is null
or
quantiy is null
or
price_per_unit is null
or 
cogs is null
or
 total_sale is null;


--delete the null value column
delete from sales
WHERE 
sale_time is null
or
transactions_id is null
or
sale_date is null
or
gender is null
or 
category is null
or
quantiy is null
or
price_per_unit is null
or 
cogs is null
or
 total_sale is null;


--DATA EXPLORATION

--how many sales we have?
SELECT COUNT(*) AS total_sales from sales;

--how many unique customers we have?
SELECT COUNT( distinct customer_id) AS total_customers from sales;

--shows the only total types of category
SELECT distinct category from sales;


-- Data Analysis & Business Key Problems & Answers

-- My Analysis & Findings
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05

select *
from sales
where sale_date ='2022-11-05';



-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022

select * 
from sales
where category ='Clothing' and  to_char(sale_date, 'yyyy-mm') = '2022-11'
and quantity>=4;




-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.

select category, sum(total_sale) as net_sale, count(*) as total_orders
from sales
group by category;

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

select  round(avg(age),2)as average_age
from sales
where category='Beauty';



-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.

select transactions_id
from sales
where total_sale >=1000;


-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.

SELECT gender, category, count(*) as total_transaction
from sales
group by category, gender
order by 1;


-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
select *from
(
select 
extract(year from sale_date) as year,
extract (month from sale_date)as month,
round (avg(total_sale),2) as total_sale,
rank() over(partition by extract(year from sale_date) order by  round (avg(total_sale),2) desc)
from sales
group by 1,2
) as t1
where rank = 1;


-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 

select 
customer_id,
sum(total_sale)
from  sales
group by 1
order by 2 desc
limit 5



-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.

select
count(distinct customer_id) as unique_customers,
category
from sales
group by category





-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)



with hourly_sales
as(
select *,
case
when extract (hour from sale_time)<=12 then 'morning'
when extract (hour from sale_time) between 12 and 17 then 'afternoon'
else 'Evening' 
end as shift
from sales
)
select 
shift,
count(*) as total_orders
from hourly_sales
group by shift

--END--


