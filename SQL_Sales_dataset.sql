--What is the total revenue generated across all transactions?

SELECT 
	SUM(total_amount) as totalrevenue
FROM sales_dataset;

--Which product category contributes the highest total revenue and quantity sold?

SELECT * FROM sales_dataset;

SELECT
	product_category,
	MAX(total_amount) as highest_revenue,
	MAX(quantity) as highestquantitysold
FROM sales_dataset
group by product_category;

--How does average order value differ by gender?

SELECT
	gender,
	AVG(total_amount) as avg_value
FROM sales_dataset
GROUP BY gender;

--What is the monthly sales trend throughout 2023?

SELECT
	FORMAT(date,'MM-yy') as month_year,
	SUM(total_amount) as total_revenue,
	COALESCE(LAG(SUM(total_amount)) OVER (ORDER BY FORMAT(date,'MM-yy')),0) as previous_month_revenue,
	(SUM(total_amount) - COALESCE(LAG(SUM(total_amount)) OVER (ORDER BY FORMAT(date,'MM-yy')),0)) as differenc,
	CASE
		WHEN (SUM(total_amount) - COALESCE(LAG(SUM(total_amount)) OVER (ORDER BY FORMAT(date,'MM-yy')),0)) > 0 THEN 'Positive'
		WHEN (SUM(total_amount) - COALESCE(LAG(SUM(total_amount)) OVER (ORDER BY FORMAT(date,'MM-yy')),0)) < 0 THEN 'Negative'
		ELSE 'Same'
	END as tren
FROM sales_dataset
GROUP BY FORMAT(date,'MM-yy'), year(date)
HAVING YEAR(date) = 2023;

--Which age group (e.g., 18-25, 26-35) spends the most on average?


SELECT
	CASE
		WHEN Age > 35 THEN 'Adult'
		WHEN Age >= 26 AND Age <= 35 THEN 'Young Adult'
		WHEN Age < 26 THEN 'Young'
		Else 'Review'
	END as age_group,
	AVG(total_amount) as avg_spend
FROM sales_dataset
GROUP BY CASE
		WHEN Age > 35 THEN 'Adult'
		WHEN Age >= 26 AND Age <= 35 THEN 'Young Adult'
		WHEN Age < 26 THEN 'Young'
		Else 'Review'
		END;

--What is the relationship between quantity purchased and total amount spent?

SELECT * FROM sales_dataset;

SELECT
	quantity,
	SUM(total_amount) as total_revenue_by_quantity
FROM sales_dataset
GROUP BY quantity
ORDER BY quantity;

--Which day of the week records the highest number of transactions?



SELECT 
	DATENAME(WEEKDAY, Date) as dayofsale,
	SUM(total_amount) as total_sale
FROM sales_dataset
GROUP BY DATENAME(WEEKDAY, Date)
ORDER BY total_sale DESC;

--How do sales patterns vary across product categories by gender?



SELECT
	product_category,
	gender,
	SUM(total_amount) as totalsales
FROM sales_dataset
GROUP BY product_category,
	gender;


--What is the distribution of customer ages in the dataset?


SELECT
	CASE
		WHEN Age > 50 THEN 'Senior_customer'
		WHEN Age >= 35 AND Age <= 50 THEN 'Adult Customer'
		WHEN Age > 25 AND Age < 35 THEN 'Young_adult'
		WHEN Age <= 25 AND Age >= 18 THEN 'young'
	END As age_group,
	COUNT(CASE WHEN Age > 50 THEN 1 END) as senior_customer,
	COUNT(CASE WHEN Age >= 35 AND Age <= 50 THEN 1 END) as Adult_customer,
	COUNT(CASE WHEN Age > 25 AND Age < 35 THEN 1 END) as young_adult,
	COUNT(CASE WHEN Age <= 25 AND Age >= 18 THEN 1 END) as young
FROM sales_dataset
GROUP BY 
CASE
	WHEN Age > 50 THEN 'Senior_customer'
	WHEN Age >= 35 AND Age <= 50 THEN 'Adult Customer'
	WHEN Age > 25 AND Age < 35 THEN 'Young_adult'
	WHEN Age <= 25 AND Age >= 18 THEN 'young'
	END;

--Which product category shows the highest average price per unit?

SELECT * FROM sales_dataset;

SELECT TOP 1
	product_Category,
	AVG(price_per_unit) as avg_unitprice
FROM sales_dataset
GROUP BY product_category
ORDER BY avg_unitprice DESC;