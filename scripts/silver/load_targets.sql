truncate table silver.targets;

insert into silver.targets (
    division,
    target_2024
)

select * from bronze.targets;
