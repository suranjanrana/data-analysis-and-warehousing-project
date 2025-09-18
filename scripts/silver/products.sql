truncate table silver.products;
insert into silver.products (
    division,
    product_name,
    factory,
    product_id,
    unit_price,
    unit_cost
)
with products as (
    select * from bronze.products
),

products_cleaning as (
    select
        *,
        trim(nullif(product_name, E'\'\'')) as product_name_clean,
        replace(unit_price, '$', '') as unit_price_clean
    from products
),

product_columns as (
    select
        division,
        product_name_clean::varchar as product_name,
        factory,
        product_id,
        unit_price_clean::numeric as unit_price,
        unit_cost::numeric as unit_cost
    from products_cleaning
    where product_name_clean is not null
)

select * from product_columns;
