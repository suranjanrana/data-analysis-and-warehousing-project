truncate table bronze.sales;
copy bronze.sales from 'D:/Data Analysis course/Datasets/US+Candy+Distributor/Candy_Sales.csv' with (
    format csv,
    header true,
    delimiter ','
);

truncate table bronze.factory;
copy bronze.factory from 'D:/Data Analysis course/Datasets/US+Candy+Distributor/Candy_Factories.csv' with (
    format csv,
    header true,
    delimiter ','
);

truncate table bronze.products;
copy bronze.products from 'D:/Data Analysis course/Datasets/us_candy_bad_data/Candy_Products.csv' with (
    format csv,
    header true,
    delimiter ','
);

truncate table bronze.targets;
copy bronze.targets from 'D:/Data Analysis course/Datasets/US+Candy+Distributor/Candy_Targets.csv' with (
    format csv,
    header true,
    delimiter ','
);

truncate table bronze.us_zips;
copy bronze.us_zips from 'D:/Data Analysis course/Datasets/US+Candy+Distributor/uszips.csv' with (
    format csv,
    header true,
    delimiter ','
);
