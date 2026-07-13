Create database Zomato;
use Zomato;


select * from Zomato;



-- 2 Build a Ca;endar table using the colomu Date key --


CREATE TABLE Calendar_Table (
    Datekey DATE,
    Year INT,
    Monthno INT,
    Monthfullname VARCHAR(20),
    Quarter VARCHAR(2),
    YearMonth VARCHAR(10),
    Weekdayno INT,
    Weekdayname VARCHAR(20),
    FinancialMonth VARCHAR(5),
    FinancialQuarter VARCHAR(5)
);


INSERT INTO Calendar_Table
SELECT 
	Datekey_Opening,
    YEAR(Datekey_Opening) AS Year,
    MONTH(Datekey_Opening) AS Monthno,
    MONTHNAME(Datekey_Opening) AS Monthfullname,
    CONCAT('Q', QUARTER(Datekey_Opening)) AS Quarter,
    DATE_FORMAT(Datekey_Opening, '%Y-%b') AS YearMonth,
    WEEKDAY(Datekey_Opening) + 1 AS Weekdayno, -- 1=Monday, 7=Sunday
    DAYNAME(Datekey_Opening) AS Weekdayname,
    
    -- Financial Month (April = FM1)
    CONCAT('FM', CASE 
        WHEN MONTH(Datekey_Opening) >= 4 THEN MONTH(Datekey_Opening) - 3 
        ELSE MONTH(Datekey_Opening) + 9 
    END) AS FinancialMonth,
    
    -- Financial Quarter
    CONCAT('FQ', CASE 
        WHEN MONTH(Datekey_Opening) BETWEEN 4 AND 6 THEN 1
        WHEN MONTH(Datekey_Opening) BETWEEN 7 AND 9 THEN 2
        WHEN MONTH(Datekey_Opening) BETWEEN 10 AND 12 THEN 3
        ELSE 4 
    END) AS FinancialQuarter
FROM zomato;


Select *  from Calendar_table;



# --3 Find the Numbers of Resturants based on City and Country.
SELECT
    c.Country as country,
    z.City as city,
    COUNT(DISTINCT `Restaurant_ID`) AS Number_of_Restaurants
FROM zomato as z join countrycode as c on c.CountryCode = z.CountryCode
GROUP BY Country, city;


# --4 Numbers of Restaurants opening based on Year , Quarter , Montha

SELECT
    YEAR(STR_TO_DATE(`Datekey_Opening`, '%Y-%m-%d')) AS Year,
    CONCAT('Q', QUARTER(Datekey_Opening)) AS Quarter,
    monthname(`Datekey_Opening`) AS Month,
    COUNT(DISTINCT `Restaurant_ID`) AS Number_of_Restaurants
FROM zomato
GROUP BY Year, Quarter, Month;


-- 5. count of restaurents by ratings


SELECT 
    ROUND(rating, 0) AS rating_bucket, 
    COUNT(*) AS restaurant_count
FROM zomato
GROUP BY ROUND(rating, 0)
ORDER BY rating_bucket DESC;

--  6. count of restaurents based on average price group

SELECT 
    CASE 
        WHEN average_cost_for_two between 0 and 500  then '0-500'
        WHEN average_cost_for_two between 500 and 1500  then '500-1500'
        WHEN average_cost_for_two between 1500 and 5000  then '1500-5K'
        WHEN average_cost_for_two between 5000 and 20000  then '5K-20K'
        WHEN average_cost_for_two between 20000 and 100000  then '20K-100K'
        WHEN average_cost_for_two between 100000 and 1000000  then '100K-1M'
    END AS AVG_Cost,
    COUNT(*) AS restaurant_count
FROM Zomato
GROUP BY AVG_Cost
ORDER BY restaurant_count DESC;


-- 7 Precentage of Resturants based on "Has table Booking"


select Has_table_booking,Count(*)Resturant_count,
round(100 * count(*) /(Select Count(*) from Zomato),2) as Percentage
From Zomato	
group by Has_table_booking;


-- 8 Precentage of Resturants based on "Has online Delivery"

Select Has_online_Delivery,count(*)Restutrant_count,
round(100 * Count(*) / (Select Count(*) from Zomato),2) as Percentage
from Zomato 
group by Has_online_Delivery;




--   9 Develop Charts based on Cusnes , City , ratiing 

--  (9_A)
select city,avg(rating) as avg_ratings
 from zomato 
 group by city 
 order by avg_ratings desc;
 
 -- (9_B)
select distinct Cuisines, avg(rating) as avg_ratings
from zomato 
group by Cuisines 
order by avg_ratings desc;
 