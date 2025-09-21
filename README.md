# US Candy Sales Data Analysis and Warehouse Project

Link to dataset: [https://mavenanalytics.io/data-playground/us-candy-distributor](https://mavenanalytics.io/data-playground/us-candy-distributor)

## Project Overview

This project implements an end-to-end data warehouse solution for analyzing US candy sales data. The solution follows Kimball dimensional modeling methodology to create a comprehensive business intelligence platform that enables deep analytics across sales performance, customer behavior, geographic markets, and manufacturing operations.

## Business Context

This data warehouse enables stakeholders to track sales performance across different candy divisions, analyze customer purchasing patterns, optimize manufacturing and distribution, and understand geographic market penetration.

## Data Model Design

- **Schema Type:** Star Schema
- **Grain:** Sales transaction at order line item level (Order ID + Product ID)
- **Fact Table:** `fact_sales` - Central sales transactions
- **Core Dimensions:** `dim_customer`, `dim_product`, `dim_date`, `dim_factory`, `dim_location` (shared geographic data),

---

## Star Schema

![US candy sales star schema](/img/us_candy_sales_star_schema.png)

---

## Original Data Dictionary

### Sales Table

| Field          | Description                            |
| -------------- | -------------------------------------- |
| Row ID         | Unique row identifier                  |
| Order ID       | Unique order identifier                |
| Order Date     | Date of order                          |
| Ship Date      | Date of shipment                       |
| Ship Mode      | Shipping method of order               |
| Customer ID    | Unique customer identifier             |
| Country/Region | Country or region of customer          |
| City           | City of customer                       |
| State/Province | State/province of customer             |
| Postal Code    | Postal code / zip code of customer     |
| Division       | Product division                       |
| Region         | Region of customer                     |
| Product ID     | Unique product identifier              |
| Product Name   | Product long name                      |
| Sales          | Total sales value of order             |
| Units          | Total units of order                   |
| Gross Profit   | Gross profit of order ( Sales - Cost ) |
| Cost           | Cost to manufacture                    |

### Factories Table

| Field     | Description           |
| --------- | --------------------- |
| Factory   | Factory Name          |
| Latitude  | Latitude Coordinates  |
| Longitude | Longitude Coordinates |

### Products Table

| Field        | Description               |
| ------------ | ------------------------- |
| Division     | Product Division          |
| Product Name | Product Descriptive Name  |
| Factory      | Factory Name              |
| Product ID   | Product Unique Identifier |
| Unit Price   | Selling Price of Product  |
| Unit Cost    | Cost to Produce Product   |

### Targets Table

| Field    | Description       |
| -------- | ----------------- |
| Division | Product Division  |
| Target   | Sales Target 2024 |

### US Zips Table

| Field          | Description                                                                                        |
| -------------- | -------------------------------------------------------------------------------------------------- |
| zip            | The 5-digit zip code assigned by the U.S. Postal Service                                           |
| lat            | The latitude of the zip code                                                                       |
| lng            | The longitude of the zip code                                                                      |
| city           | The official USPS city name                                                                        |
| state_id       | The official USPS state abbreviation                                                               |
| state_name     | The state's name                                                                                   |
| zcta           | TRUE if the zip code is a Zip Code Tabulation area                                                 |
| parent_zcta    | The ZCTA that contains this zip code. Only exists if zcta is FALSE                                 |
| population     | An estimate of the zip code's population. Only exists if zcta is TRUE                              |
| density        | The estimated population per square kilometer. Only exists if zcta is TRUE                         |
| county_fips    | The zip's primary county in the FIPS format                                                        |
| county_name    | The name of the county_fips                                                                        |
| county_weights | A JSON dictionary listing all county_fips and their weights (by area) associated with the zip code |
| imprecise      | TRUE if the lat/lng has been geolocated using the city (rare)                                      |
| military       | TRUE if the zip code is used by the US Military (lat/lng not available)                            |
| timezone       | The city's time zone in the tz database format. (e.g. America/Los_Angeles)                         |
