drop table if exists bronze.sales;
create table bronze.sales (
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
    cost numeric
);

drop table if exists bronze.factory;
create table bronze.factory (
    factory varchar,
    latitude numeric,
    longitude numeric
);

drop table if exists bronze.products;
create table bronze.products (
    division varchar,
    product_name varchar,
    factory varchar,
    product_id varchar,
    unit_price varchar,
    unit_cost varchar
);

drop table if exists bronze.targets;
create table bronze.targets (
    division varchar,
    target int
);

drop table if exists bronze.us_zips;
create table bronze.us_zips (
    zip varchar,
    lat varchar,
    lng varchar,
    city varchar,
    state_id varchar,
    state_name varchar,
    zcta varchar,
    parent_zcta varchar,
    population varchar,
    density varchar,
    county_fips varchar,
    county_name varchar,
    county_weights JSONB,
    county_names_all varchar,
    county_fips_all varchar,
    imprecise varchar,
    military varchar,
    timezone varchar
);
