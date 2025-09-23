create or replace view gold.fact_sales as
with sales as (
    select * from silver.sales
),
dim_product as (
    select product_key, source_id from gold.dim_product
),
dim_customer as (
    select customer_key, customer_id from gold.dim_customer
),
dim_factory as (
    select factory_key, factory_name from gold.dim_factory
),
products as (
    select product_id, factory from silver.products
),
factory as (
    select factory, latitude, longitude from silver.factory
),
dim_location as (
    select location_key, postal_code, latitude, longitude from gold.dim_location
),
joined as (
    select
        case
            when sales.product_id is null then md5('Unknown')
            when dim_product.product_key is null then md5('Not Available')
            else dim_product.product_key
        end as product_key,
        case
            when sales.customer_id is null then md5('Unknown')
            when dim_customer.customer_key is null then md5('Not Available')
            else dim_customer.customer_key
        end as customer_key,
        case
            when products.factory is null then md5('Unknown')
            when dim_factory.factory_key is null then md5('Not Available')
            else dim_factory.factory_key
        end as factory_key,
        case
            when sales.postal_code is null then md5('Unknown')
            when customer_location.location_key is null then md5('Not Available')
            else customer_location.location_key
        end as customer_location_key,
        case
            when factory.latitude is null then md5('Unknown')
            when factory_location.location_key is null then md5('Not Available')
            else factory_location.location_key
        end as factory_location_key,
        dim_product.source_id,
        products.factory,
        sales.*
    from sales
    left join dim_customer
        on sales.customer_id = dim_customer.customer_id
    left join dim_product
        on sales.product_id = dim_product.source_id
    left join products
        on dim_product.source_id = products.product_id
    left join dim_factory
        on products.factory = dim_factory.factory_name
    left join factory
        on products.factory = factory.factory
    left join dim_location as customer_location
        on sales.postal_code = customer_location.postal_code
    left join dim_location as factory_location
        on factory.latitude = factory_location.latitude
            and factory.longitude = factory_location.longitude
),
renamed as (
    select
        product_key,
        customer_key,
        factory_key,
        customer_location_key,
        factory_location_key,
        order_date as order_date_key,
        ship_date as ship_date_key,
        order_id as order_id_degenerate,
        ship_mode as ship_mode_degenerate,
        sales as sales_amount,
        units as units_sold,
        cost as cost_price,
        gross_profit,
        row_id as source_id
    from joined
),
final as (
    select
        product_key,
        customer_key,
        factory_key,
        customer_location_key,
        factory_location_key,
        order_date_key,
        ship_date_key,
        order_id_degenerate,
        ship_mode_degenerate,
        sales_amount,
        units_sold,
        cost_price,
        gross_profit,
        source_id
    from renamed
)
select * from final;
