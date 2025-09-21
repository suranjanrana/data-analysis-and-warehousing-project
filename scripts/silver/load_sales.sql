truncate table silver.sales;

insert into silver.sales (
    row_id,
    order_id,
    order_date,
    ship_date,
    ship_mode,
    customer_id,
    country_region,
    city,
    state_province,
    postal_code,
    division,
    region,
    product_id,
    product_name,
    sales,
    units,
    gross_profit,
    cost
)

select * from bronze.sales;
