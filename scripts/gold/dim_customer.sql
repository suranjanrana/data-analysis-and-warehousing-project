create or replace view gold.dim_customer as

with customers as (
	select customer_id, order_date, sales
	from silver.sales
),

customer_overall as (
	select
		customer_id,
		sum(sales) as total_sales,
		max(order_date) as max_order_date
	from customers
	group by 1
),

customer_details as (
	select
		*,
		case
			when total_sales >= 60 then 'High value'
			when total_sales >= 30 then 'Medium value'
			else 'Low value'
		end as customer_segmentation,
		case
			when '2025-01-01' - max_order_date <= 365 then true
			else false
		end as is_active
	from customer_overall

),

dim_customer as (
    select
        md5(customer_id) as customer_key,
        customer_id,
        customer_segmentation,
        is_active
    from customer_details
),

seed as (
    select
        md5('Unknown') as customer_key,
        'Unknown' as customer_id,
        'Unknown' as customer_segmentation,
        false as is_active
    union all
    select
        md5('Not Available') as customer_key,
        'Not Available' as customer_id,
        'Not Available' as customer_segmentation,
        false as is_active
),

unioned as (
    select * from dim_customer
    union all
    select * from seed
),

final as (
    select
        customer_key,
        customer_id,
        customer_segmentation,
        is_active
    from unioned
)

select * from final;
