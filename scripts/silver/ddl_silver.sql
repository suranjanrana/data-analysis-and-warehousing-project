drop table if exists silver.sales;
create table silver.sales (
    row_id varchar,
    order_id varchar,
    order_date date,
    ship_date date,
    ship_mode varchar,
    customer_id varchar,
    country_region varchar,
    city varchar,
    state_province varchar,
    postal_code varchar,
    division varchar,
    region varchar,
    product_id varchar,
    product_name varchar,
    sales numeric,
    units int,
    gross_profit numeric,
    cost numeric,
    dwh_created_at timestamp default current_timestamp
);

drop table if exists silver.factory;
create table silver.factory (
    factory varchar,
    latitude numeric,
    longitude numeric,
    dwh_created_at timestamp default current_timestamp
);

drop table if exists silver.products;
create table silver.products (
    division varchar,
    product_name varchar,
    factory varchar,
    product_id varchar,
    unit_price numeric,
    unit_cost numeric,
    dwh_created_at timestamp default current_timestamp
);

drop table if exists silver.targets;
create table silver.targets (
    division varchar,
    target_2024 int,
    dwh_created_at timestamp default current_timestamp
);

drop table if exists silver.us_zips;
create table silver.us_zips (
    zip varchar,
    latitude numeric,
    longitude numeric,
    city varchar,
    state_id varchar,
    state_name varchar,
    population int,
    population_density numeric,
    county_fips varchar,
    county_name varchar,
    is_military boolean,
    timezone varchar,
    dwh_created_at timestamp default current_timestamp
);
