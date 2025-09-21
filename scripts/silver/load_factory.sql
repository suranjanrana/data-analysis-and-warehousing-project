truncate table silver.factory;

insert into silver.factory (
    factory,
    latitude,
    longitude
)

select * from bronze.factory;
