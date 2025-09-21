create or replace view gold.dim_product as
with products as (
    select * from silver.products
),

sales as (
    select * from silver.sales
),

recent_active_at as (
    select
        product_id,
        max(order_date) as recent_active_date
    from sales
    group by product_id
),

dim_product as (
    select
        md5(product_id) as product_key,
        product_name,
        division as product_division,
        unit_price,
        unit_cost,
        product_id as source_id
    from products
),

active_prodcuts as (
    select
        p.*,
        case when r.recent_active_date >= current_date - interval '1 year' then true else false end as is_active
    from dim_product as p
    join recent_active_at as r
        on p.source_id = r.product_id
),

seed as (
    select
        md5('Unknown') as product_key,
        'Unknown' as product_name,
        'Unknown' as product_division,
        -1 as unit_price,
        -1 as unit_cost,
        false as is_active,
        null as source_id

    union all

    select
        md5('Not Available') as product_key,
        'Not Available' as product_name,
        'Not Available' as product_division,
        -2 as unit_price,
        -2 as unit_cost,
        false as is_active,
        null as source_id
),

unioned as (
    select
        product_key,
        product_name,
        product_division,
        unit_price,
        unit_cost,
        is_active,
        source_id
    from active_prodcuts

    union all

    select * from seed
),

final as (
    select
        product_key,
        product_name,
        product_division,
        unit_price,
        unit_cost,
        is_active,
        source_id
    from unioned
)

select * from final;
