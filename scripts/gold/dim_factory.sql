create or replace view gold.dim_factory as
with factory as (
    select factory from silver.factory
),

seed as (
    select md5('Unknown') as factory_key, 'Unknown' as factory_name
    union all
    select md5('Not Available') as factory_key, 'Not Available' as factory_name
),

dim_factory as (
    select
        md5(factory) as factory_key,
        factory as factory_name
    from factory
),

unioned as (
    select * from dim_factory
    union all
    select * from seed
),

final as (
    select
        factory_key,
        factory_name
    from unioned
)

select * from final;
