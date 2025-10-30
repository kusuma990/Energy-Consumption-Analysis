CREATE DATABASE energy;

USE energy;

drop database energy;

-- 1. country table
CREATE TABLE country (
CID VARCHAR(10) PRIMARY KEY,
Country VARCHAR(100) UNIQUE
);

select * from country;

-- 2. emission_3 table
CREATE TABLE emission (
country VARCHAR(100),
energy_type VARCHAR(50),
year INT,
emission INT,
per_capita_emission DOUBLE,
FOREIGN KEY (country) REFERENCES country(Country)
);

SELECT * FROM emission;

-- 3. population table
CREATE TABLE population (
countries VARCHAR(100),
year INT,
Value DOUBLE,
FOREIGN KEY (countries) REFERENCES country(Country)
);

SELECT * FROM population;

-- 4. production table
CREATE TABLE production (
country VARCHAR(100),
energy VARCHAR(50),
year INT,
production INT,
FOREIGN KEY (country) REFERENCES country(Country)
);

select * from production;

-- 5. gdp_dd table
CREATE TABLE gdp_dd (
Country VARCHAR(100),
year INT,
Value DOUBLE,
FOREIGN KEY (Country) REFERENCES country(Country)
);

select * from gdp_dd;

-- 6. consumption table
CREATE TABLE consumption (
country VARCHAR(100),
energy VARCHAR(50),
year INT,
consumption INT,
FOREIGN KEY (country) REFERENCES country(Country)
);

select * from consumption;

# Data Analysis Questions

## General & Comparative Analysis
-- 1.What is the total emission per country for the most recent year available?

select * from emission;

select country,sum(emission) as total_emission,year from emission
where year=(select max(year) from emission)
group by country,year;

-- 2.What are the top 5 countries by GDP in the most recent year?

SELECT Country, Value AS GDP
FROM gdp_dd
WHERE year = (SELECT MAX(year) FROM gdp_dd)
ORDER BY GDP DESC
LIMIT 5;


 -- 3.Compare energy production and consumption by country and year.

select p.country as country,sum(p.production),sum(c.consumption),p.year as year
from production as p 
left join consumption as c
on p.country=c.country
group by country,year;


-- 4.Which energy types contribute most to emissions across all countries?

SELECT energy_type, SUM(emission) AS total_emission
FROM emission
GROUP BY energy_type
ORDER BY total_emission DESC;

## Trend Analysis Over Time
-- 5.How have global emissions changed year over year?

SELECT year, SUM(emission) AS total_emission
FROM emission
GROUP BY year
ORDER BY year;

-- 6.What is the trend in GDP for each country over the given years?

SELECT Country, year, Value AS GDP
FROM gdp_dd
ORDER BY Country, year;

-- 7.How has population growth affected total emissions in each country?

SELECT e.country, e.year, 
       SUM(e.emission) AS total_emission, 
       p.Value AS population,
       SUM(e.emission) / p.Value AS emission_per_capita
FROM emission as  e
JOIN population as p 
  ON e.country = p.countries AND e.year = p.year
GROUP BY e.country, e.year, p.Value
ORDER BY e.country, e.year;


-- 8.Has energy consumption increased or decreased over the years for major economies?

WITH top_gdp AS (
  SELECT Country
  FROM gdp_dd
  WHERE year = (SELECT MAX(year) FROM gdp_dd)
  ORDER BY Value DESC
  LIMIT 5
)
SELECT c.country, c.year, SUM(c.consumption) AS total_consumption
FROM consumption as  c
WHERE c.country IN (SELECT Country FROM top_gdp)
GROUP BY c.country, c.year
ORDER BY c.country, c.year;


-- 9.What is the average yearly change in emissions per capita for each country?

select country,year,avg(per_capita_emission) as avg_yearly_change
from emission
group by country,year;

## Ratio & Per Capita Analysis
-- 10.What is the emission-to-GDP ratio for each country by year?

SELECT e.country, e.year, SUM(e.emission) / g.Value AS emission_to_gdp
FROM emission as  e
JOIN gdp_dd as  g
  ON e.country = g.Country AND e.year = g.year
GROUP BY e.country, e.year, g.Value
ORDER BY e.country, e.year;


-- 11.What is the energy consumption per capita for each country over the last decade

select p.countries,sum(c.consumption)/sum(p.Value) as energy_consumption_per_capita
from population as p
join consumption as c
on p.countries=c.country
group by p.countries;


-- 12.How does energy production per capita vary across countries?

SELECT p.country, p.year, SUM(p.production)/pop.Value AS production_per_capita
FROM production p
JOIN population pop 
  ON p.country = pop.countries AND p.year = pop.year
GROUP BY p.country, p.year, pop.Value
ORDER BY p.country, p.year;

-- 13.Which countries have the highest energy consumption relative to GDP?

select c.country,c.year,sum(c.consumption)/sum(gd.Value) as Energy_Consumption_to_GDPRatio 
from consumption as c 
join gdp_dd as gd
on c.country=gd.Country and c.year=gd.year
group by c.country,c.year
order by Energy_Consumption_to_GDPRatio desc
limit 10;


-- 14.What is the correlation between GDP growth and energy production growth?

select p.country,p.year,sum(p.production) as total_production,sum(gd.Value) as gdp
from production p
join gdp_dd as gd
on p.country=gd.Country and p.year=gd.year
group by p.country,p.year;


## Global Comparisons
-- 15.What are the top 10 countries by population and how do their emissions compare?

SELECT 
    p.countries AS country,
    MAX(p.value) AS population,
    SUM(e.emission) AS total_emission
FROM population p
JOIN emission e 
    ON p.countries = e.country
GROUP BY p.countries
ORDER BY population DESC
LIMIT 10;


-- 16.What is the global share (%) of emissions by country?

WITH total AS (
  SELECT SUM(emission) AS total_emission
  FROM emission
)
SELECT country, SUM(emission) AS country_emission,
       (SUM(emission)/(SELECT total_emission FROM total))*100 AS share_percent
FROM emission
GROUP BY country
ORDER BY share_percent DESC;

-- 17.What is the global average GDP, emission, and population by year?

select g.year,
round(avg(g.Value),2) as avg_gdp,
round(avg(e.emission),2) as avg_emission,
round(avg(p.Value),2) as avg_population 
from gdp_dd as g
join emission as e
on g.Country=e.country and g.year=e.year
join population as p
on g.country=p.countries and g.year=p.year
group by g.year
order by g.year;


