create database blinkit;
use blinkit;

select * from Blinkit_Data;
set sql_safe_updates=0;
update Blinkit_Data set `Item Fat Content` = case when `Item Fat Content` in ('LF','low fat') then 'Low Fat' else `Item Fat Content` end;

-- business requirements --


select  cast(sum(Sales)/1000000 as decimal(10,2)) as Total_Sales from Blinkit_Data ;
select cast(avg(Sales) as decimal (10,0))as avg_sales from Blinkit_Data;
select count(*)as No_Of_items from Blinkit_Data;
select cast(avg(Rating) as decimal (10,2))as avg_rating from Blinkit_Data;

-- Total Sales by Fat Content--

SELECT
    `Item Fat Content`,
    ROUND(SUM(Sales),2) AS Total_Sales,
    ROUND(AVG(Sales),2) AS Average_Sales,
    COUNT(*) AS Number_of_Items,
    ROUND(AVG(Rating),2) AS Average_Rating
FROM blinkit_data
GROUP BY `Item Fat Content`
ORDER BY Total_Sales DESC;

-- Total Sales by Item Type -- 

SELECT
    `Item Type`,
    ROUND(SUM(Sales),2) AS Total_Sales,
    DENSE_RANK() OVER (ORDER BY SUM(Sales) DESC) AS Sales_Rank
FROM blinkit_data
GROUP BY `Item Type`
ORDER BY Total_Sales DESC;

-- Fat Content by Outlet for Total Sales --

SELECT
    `Outlet Identifier`,
    `Item Fat Content`,
    ROUND(SUM(Sales),2) AS Total_Sales
FROM blinkit_data
GROUP BY `Outlet Identifier`, `Item Fat Content`
ORDER BY `Outlet Identifier`;

-- Total Sales by Outlet Establishment Year --

SELECT
    `Outlet Establishment Year`,
    ROUND(SUM(Sales),2) AS Total_Sales
FROM blinkit_data
GROUP BY `Outlet Establishment Year`
ORDER BY `Outlet Establishment Year`;

-- Percentage of Sales by Outlet Size --

SELECT
    `Outlet Size`,
    ROUND(SUM(Sales),2) AS Total_Sales,
    ROUND(SUM(Sales) * 100 /(SELECT SUM(Sales) FROM blinkit_data),2) AS Sales_Percentage
FROM blinkit_data
GROUP BY `Outlet Size`
ORDER BY Sales_Percentage DESC;

-- Sales by Outlet Location --

SELECT
    `Outlet Location Type`,
    ROUND(SUM(Sales),2) AS Total_Sales
FROM blinkit_data
GROUP BY `Outlet Location Type`
ORDER BY Total_Sales DESC;

-- All Metrics by Outlet Type --

SELECT
    `Outlet Type`,
    ROUND(SUM(Sales),2) AS Total_Sales,
    ROUND(AVG(Sales),2) AS Average_Sales,
    COUNT(*) AS Number_of_Items,
    ROUND(AVG(Rating),2) AS Average_Rating
FROM blinkit_data
GROUP BY `Outlet Type`
ORDER BY Total_Sales DESC;

-- 