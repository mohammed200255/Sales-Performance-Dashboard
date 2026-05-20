
use DataWarehouseAnalytics;

if object_id('gold.report_products','v') is not null
	drop view gold.report_products

go
	 
create or alter view gold.report_products  
as
	with base_CTE as (
		select  
			f.order_number,
			f.product_key,
			f.order_date,
			f.sales_amount,
			f.customer_key,
			f.quantity,
			p.product_name,
			p.category,
			p.subcategory,
			p.cost
		from gold.fact_sales f
		join gold.dim_products p 
			on f.product_key = p.product_key
		where f.order_date is not null
	),

	product_aggregation as (
		select 
			product_name,
			category,
			subcategory,
			cost,
			count(distinct order_number) as total_order,
			sum(sales_amount) as total_sales,
			sum(quantity) as total_quantity,
			count(distinct customer_key) as total_customers,
			datediff(month, min(order_date), max(order_date)) as lifespan,
			max(order_date) as last_order_date
		from base_CTE
		group by product_name, category, subcategory, cost
	)

	select 
		product_name,
		category,
		subcategory,
		cost,
		total_quantity,
		total_sales,

		case
			when total_sales < 15000 then 'Low-Performers'
			when total_sales between 15000 and 100000 then 'Mid-Range'
			else 'High-Performers'
		end as product_segment,

		total_order,
		
		
		total_customers,
		lifespan,

		last_order_date,
		datediff(month, last_order_date, getdate()) as recency,

		case
			when total_order = 0 then 0
			else cast(total_sales * 1.0 / total_order as decimal(18,2))
		end as average_order_revenue,

		case
			when lifespan = 0 then 0
			else cast(total_sales*1.0 / lifespan as decimal(18,2))
		end as average_monthly_revenues

	from product_aggregation;

 
--select * from gold.report_products




