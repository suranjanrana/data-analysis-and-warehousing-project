truncate table silver.us_zips;

insert into silver.us_zips (
    zip,
    latitude,
    longitude,
    city,
    state_id,
    state_name,
    population,
    population_density,
    county_fips,
    county_name,
    is_military,
    timezone
)

select
    zip,
    lat::numeric as latitude,
    lng::numeric as longitude,
    city,
    state_id,
    state_name,
    nullif(population, '')::int as population,
    nullif(density, '')::numeric as population_density,
    county_fips::varchar as county_fips,
    county_name,
    military::boolean as is_military,
    timezone
from bronze.us_zips;
