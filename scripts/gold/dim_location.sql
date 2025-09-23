create or replace view gold.dim_location as
with uszips as (
    select * from silver.us_zips
),
sales_locations as (
    select distinct
        postal_code,
        city,
        country_region as country,
        state_province as state_name,
        region
    from silver.sales
),
unioned_zips as (
    select distinct zip from uszips
    union
    select postal_code as zip from sales_locations
),
uszip_cols as (
    select
        zip as postal_code,
        latitude as latitude,
        longitude as longitude,
        city,
        state_id,
        state_name,
        county_name,
        population as population,
        population_density as population_density,
        is_military,
        timezone
    from uszips
),
sales_loc_cols as (
    select
        postal_code,
        country,
        region,
        state_name
    from sales_locations
),
joined as (
    select
        u.zip as postal_code,
        z.latitude as latitude,
        z.longitude as longitude,
        l.country as country,
        l.region as region,
        z.city as city,
        z.state_id as state_id,
        z.state_name as state_name,
        z.county_name as county_name,
        z.population as population,
        z.population_density as population_density,
        z.is_military as is_military,
        z.timezone as timezone
    from unioned_zips as u
    left join uszip_cols as z
        on u.zip = z.postal_code
    left join sales_loc_cols as l
        on u.zip = l.postal_code
),
dim_location as (
    select
        md5(postal_code) as location_key,
        postal_code,
        latitude,
        longitude,
        case when length(postal_code) = 5 then 'United States' else country end as country,
        region,
        city,
        state_id,
        state_name,
        county_name,
        population,
        population_density,
        is_military,
        timezone
    from joined
)
select * from dim_location;
