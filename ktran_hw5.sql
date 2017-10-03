-- Kevin Tran 
-- CPSC 321 - 02
-- Homework 5
-- Description: Updated bordering countries and cities homework

SET sql_mode = STRICT_ALL_TABLES;

DROP TABLE IF EXISTS Country;
DROP TABLE IF EXISTS Province;
DROP TABLE IF EXISTS City;
DROP TABLE IF EXISTS Border;

CREATE TABLE Country(
   code VARCHAR(4) NOT NULL,                             
   country_name TEXT NOT NULL,        
   gdp INT NOT NULL, 
   inflation DECIMAL(18,1) NOT NULL,
   PRIMARY KEY (code)
) ENGINE = InnoDB;

CREATE TABLE Province(
   province_name VARCHAR(255) NOT NULL,                             
   country VARCHAR(4) NOT NULL,        
   area INT NOT NULL, 
   PRIMARY KEY (province_name, country),
  FOREIGN KEY(country) REFERENCES Country(code)
) ENGINE = InnoDB;

CREATE TABLE City(
   city_name VARCHAR(255) NOT NULL,                             
   province VARCHAR(255) NOT NULL,        
   country VARCHAR(4) NOT NULL, 
   population int NOT NULL,
   PRIMARY KEY (city_name, province,country),
   FOREIGN KEY(province, country) REFERENCES Province(province_name, country)
) ENGINE = InnoDB;

CREATE TABLE Border(
   country1 VARCHAR(4) NOT NULL,                             
   country2 VARCHAR(4) NOT NULL,        
   border_length int NOT NULL, 
   PRIMARY KEY (country1, country2),
   FOREIGN KEY(country1) REFERENCES Country(code),
   FOREIGN KEY(country2) REFERENCES Country(code)
) ENGINE = InnoDB;


INSERT INTO Country(code, country_name, gdp, inflation)VALUES
("US", "United States of America", 46900, 10.8),
("DPRK", "North Korea", 100000, 7.9),
("MEX", "Mexico", 80000, 6.3);

INSERT INTO Province(province_name, country, area) VALUES
("California", "US", 20000),
("Chagang", "DPRK", 10000),
("South Hangyuang", "DPRK", 900000),
("South Hwanghae", "DPRK", 937821),
("Baja", "MEX", 500000);

INSERT INTO City(city_name, province, country, population)VALUES
("Tijuana", "Baja", "MEX", 23452),
("LA", "California", "US", 253452),
("Pyongyang", "Chagang", "DPRK", 432532),
("Cool Place", "Chagang", "DPRK", 900321),
("San Fransico", "California", "US", 10324921),
("Even Cooler Place", "Chagang", "DPRK", 65042),
("Liberty", "Chagang", "DPRK", 65042),
("Freedom", "Chagang", "DPRK", 65042),
("Taxes", "Chagang", "DPRK", 65042),
("Burger King", "Chagang", "DPRK", 65042);


INSERT INTO Border(country1, country2, border_length)VALUES
("US", "DPRK", 10000),
("DPRK", "US", 10000),
("US", "MEX", 390123),
("MEX", "DPRK", 289743);

-- 3
SELECT c.code, c.inflation, c.gdp, SUM(c1.population)
FROM Country c JOIN City c1 WHERE c1.country = c.code
GROUP BY c.code;

-- 4
SELECT p.province_name, p.area, SUM(c.population)
FROM Province p, City c
WHERE p.province_name = c.province 
GROUP BY p.province_name
HAVING SUM(c.population) > 1000000;

-- 5 
SELECT c1.code, COUNT(c2.country)
FROM Country c1 JOIN City c2 ON c1.code = c2.country
GROUP BY c1.code
HAVING COUNT(c2.country) > 0
ORDER BY COUNT(c2.country) DESC;


-- 6
SELECT c.code, SUM(p.area)
FROM Province p JOIN Country c ON p.country = c.code
GROUP BY c.code
ORDER BY SUM(p.area) DESC;

-- 7
SELECT c1.code, COUNT(p.province_name)
FROM Country c1 JOIN Province p ON p.country = c1.code JOIN City c2 ON p.province_name = c2.province
GROUP BY c1.code
HAVING COUNT(p.province_name) >= 1 AND COUNT(c2.country) > 4;

-- 8 
CREATE VIEW assoc_borders AS
SELECT *
FROM Border
UNION ALL
SELECT country2 AS country1, country1 AS country2, border_length
FROM Border;

-- 9
SELECT DISTINCT c.code, AVG(c2.gdp), AVG(c2.inflation)
FROM Country c JOIN assoc_borders ab ON c.code = ab.country1 JOIN Country c2 ON c2.code = ab.country2
GROUP BY c.code;



























