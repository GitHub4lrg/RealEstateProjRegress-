-- drop database if exists house_price_regression;

--  1. Create a database called house_price_regression.
create database if not exists house_price_regression;
use house_price_regression;
-- 2. Create a table house_price_data with the same columns as given in the csv file
create table house_price_regression.house_price_data (
  `id` BIGINT UNIQUE NOT NULL,
  `date` DATETIME DEFAULT NULL,
  `bedrooms` INT DEFAULT NULL,
  `bathrooms` FLOAT DEFAULT NULL,
  `sqft_living` INT DEFAULT NULL,
  `sqft_lot` INT DEFAULT NULL,
  `floors` FLOAT DEFAULT NULL,
  `waterfront` INT DEFAULT NULL,
  `view` INT DEFAULT NULL,
  `condition` FLOAT DEFAULT NULL,
  `grade` INT DEFAULT NULL,
  `sqft_above` INT DEFAULT NULL,
  `sqft_basement` INT DEFAULT NULL,
  `yr_built` INT DEFAULT NULL,
  `yr_renovated` INT DEFAULT NULL,
  `zipcode` INT DEFAULT NULL,
  `lat` FLOAT DEFAULT NULL,
  `long` FLOAT DEFAULT NULL,
  `sqft_living15` INT DEFAULT NULL,
  `sqft_lot15` INT DEFAULT NULL,
  `price` INT DEFAULT NULL,
  CONSTRAINT PRIMARY KEY (id)
  );
  
SHOW VARIABLES LIKE 'local_infile'; -- This query would show you the status of the variable ‘local_infile’. If it is off, use the next command, otherwise you should be good to go

SET GLOBAL local_infile = 1;     -- swtiching local_infile On
show variables like 'secure_file_priv';

-- 3. Import the data from the csv file into the table.
load data infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/regression_data_sqlcpy.csv'
into table house_price_regression.house_price_data
fields terminated by ','
lines terminated by '\n';

select count(id) from house_price_data;

-- 4. Select all the data from table house_price_data to check if the data was imported correctly
select * from house_price_data   -- and we can see the data loaded
limit 10;

-- answering the requested queries for SQL
-- 5. Use the alter table command to drop the column date from the database, as we would not use it in the analysis with SQL. 
-- Select all the data from the table to verify if the command worked. Limit your returned results to 10.
alter table house_price_data
drop column date;
select * from house_price_data
limit 5;

-- 6. Use sql query to find how many rows of data you have
select distinct count(id) from house_price_data;

-- 7. Now we will try to find the unique values in some of the categorical columns:
select distinct bedrooms from house_price_data
order by bedrooms;
select distinct bathrooms from house_price_data
order by bathrooms;
select distinct floors from house_price_data
order by floors;
select distinct house_price_data.condition from house_price_data
order by house_price_data.condition;
select distinct grade from house_price_data
order by grade;

-- 8. Arrange the data in a decreasing order by the price of the house. Return only the IDs of the top 10 most expensive houses in your data.
select id from house_price_data
order by price desc
limit 10;

-- 9. What is the average price of all the properties in your data?
select avg(price) from house_price_data;

-- 10. In this exercise we will use simple group by to check the properties of some of the categorical variables in our data
select bedrooms, avg(price) as Average_Price from house_price_data
group by bedrooms;
select bedrooms, avg(sqft_living) as Living_area from house_price_data
group by bedrooms;
select waterfront, avg(price) as Average_Price from house_price_data
group by waterfront;
select house_price_data.condition, avg(grade) from house_price_data
group by house_price_data.condition 
order by house_price_data.condition; -- as we can see from the value there is positive correlation from the beginning and it start dropping that correlation at the end.

-- 11. One of the customers is only interested in the following houses:
select bedrooms, bathrooms, floors, waterfront, house_price_data.condition, grade, price from house_price_data
where bedrooms >= 3 and bathrooms > 3 and floors = 1 and waterfront = 0 and house_price_data.condition > 2 and grade >= 5 and price < 300000;
-- alternative for this one customer, however if he compromise in more than 2 bathrooms then will find way more than 3 options available.

-- 12. Your manager wants to find out the list of properties whose prices are twice more than the average of all the properties in the database. 
-- Write a query to show them the list of such properties. You might need to use a sub query for this problem. 
select id, price from house_price_data
where price > 2*(
  select avg(price)
  from house_price_data
);

-- 13. Since this is something that the senior management is regularly interested in, create a view of the same query.
create view star_properties as
select id, price from house_price_data
where price > 2*(
  select avg(price)
  from house_price_data
);

-- 14. Most customers are interested in properties with three or four bedrooms. What is the difference in average prices of the properties with three and four bedrooms?
select avg(price)
from (select bedrooms, price from house_price_data
where bedrooms in (3, 4)) as Average_34;

-- 15. What are the different locations where properties are available in your database? (distinct zip codes) 
select distinct zipcode from house_price_data;

-- 16. Show the list of all the properties that were renovated.
select id, yr_renovated from house_price_data;

-- 17. Provide the details of the property that is the 11th most expensive property in your database.
select * 
from (select * from house_price_data
order by price desc
limit 11) as eleven
order by price
limit 1;

-- Understanding which factors are responsible for higher property value - Features of properties $650K and above.
select bedrooms, round(avg(bathrooms)) as bathrooms, round(avg(sqft_living)) as sqft_living, round(avg(`condition`)) as 'condition', round(avg(grade)) as grade, yr_built from house_price_data
where price > 650000;

select bedrooms, price, count(*) from house_price_data
where price > 650000
group by bedrooms
order by count(*) DESC;

select bathrooms, price, count(*) from house_price_data
where price>650000
group by bathrooms
order by count(*) DESC;

select sqft_living, price, count(*) from house_price_data
where price > 650000
group by sqft_living
order by count(*) DESC;

select `condition`, price, count(*) from house_price_data
where price > 650000
group by `condition`
order by count(*) DESC;

select grade, price, count(*) from house_price_data
where price>650000
group by grade
order by count(*) DESC;

select yr_built, price, count(*) from house_price_data
where price > 650000
group by yr_built
order by count(*) DESC;

-- most expensive zipcodes are 98039, 98053, 98065
select zipcode, price, count(*), count(*)*price from house_price_data
where price > 650000
group by zipcode
order by count(*)*price DESC;


