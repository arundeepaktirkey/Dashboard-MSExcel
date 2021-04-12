-- 1. Create a table “Station” to store information about weather observation stations:
create table Station (
ID int,
CITY VARCHAR(20),
STATE VARCHAR(2),
LAT_N INT,
LONG_w INT,
constraint PKEY PRIMARY KEY (ID)
);

-- 2. Insert the following records into the table:
INSERT INTO STATION (ID,CITY,STATE,LAT_N,LONG_W) VALUES (13,'Phoenix','AZ',33,112);
INSERT INTO STATION (ID,CITY,STATE,LAT_N,LONG_W) VALUES (44,'Denver','CO',40,105);
INSERT INTO STATION (ID,CITY,STATE,LAT_N,LONG_W) VALUES (66,'Caribou','ME',47,68);

-- 3. Execute a query to look at table STATION in undefined order.
SELECT *
FROM station;

-- 4. Execute a query to select Northern stations (Northern latitude > 39.7). 
SELECT *
FROM STATION
WHERE LAT_N > 39.7;

-- 5. Create another table, ‘STATS’, to store normalized temperature and precipitation data:
CREATE TABLE STATS (
ID INT,
MONTHS INT,
CONSTRAINT MONTHS CHECK(MONTHS BETWEEN 1 AND 12),
TEMP_F double,
CONSTRAINT TEMP_F CHECK(TEMP_F BETWEEN -80 AND 150),
RAIN_I double,
CONSTRAINT RAIN_I CHECK(RAIN_I BETWEEN 0 AND 100),
CONSTRAINT PK_STATS PRIMARY KEY(ID,MONTHS)
);

-- 6. Populate the table STATS with some statistics for January and July:
INSERT INTO STATS (ID,MONTHS,TEMP_F,RAIN_I) VALUES (13,1,57.4,.31);
INSERT INTO STATS (ID,MONTHS,TEMP_F,RAIN_I) VALUES (13,7,91.7,5.15);
INSERT INTO STATS (ID,MONTHS,TEMP_F,RAIN_I) VALUES (44,1,27.3,.18);
INSERT INTO STATS (ID,MONTHS,TEMP_F,RAIN_I) VALUES (44,7,74.8,2.11);
INSERT INTO STATS (ID,MONTHS,TEMP_F,RAIN_I) VALUES (66,1,6.7,2.1);
INSERT INTO STATS (ID,MONTHS,TEMP_F,RAIN_I) VALUES (66,7,65.8,4.52);

SELECT *
FROM STATS;

-- 7. Execute a query to display temperature stats (from STATS table) for each city (from Station table).
SELECT CITY,TEMP_F
FROM STATS,STATION
WHERE STATS.ID=STATION.ID;

-- 8. Execute a query to look at the table STATS, ordered by month and greatest rainfall, with columns rearranged. It should also show the corresponding cities.
SELECT CITY,MONTHS,RAIN_I
FROM STATS,STATION
WHERE STATS.ID=STATION.ID
ORDER BY MONTHS ASC,RAIN_I DESC;

-- 9. Execute a query to look at temperatures for July from table STATS, lowest temperatures first,picking up city name and latitude.
SELECT TEMP_F,CITY,LAT_N
FROM STATS,STATION
WHERE STATS.ID=STATION.ID AND MONTHS = 7
ORDER BY TEMP_F ASC;

-- 10. Execute a query to show MAX and MIN temperatures as well as average rainfall for each city.
SELECT CITY,ROUND(MAX(TEMP_F),2) AS MAX_TEMP,ROUND(MIN(TEMP_F),2) AS MIN_TEMP,ROUND(AVG(RAIN_I),2) AS AVG_RAINFALL
FROM STATS,STATION
WHERE STATS.ID=STATION.ID
GROUP BY CITY;

-- 11. Execute a query to display each city’s monthly temperature in Celcius and rainfall in Centimeter.
SELECT CITY,MONTHS,ROUND(((TEMP_F-32)*5/9),2) AS TEMP_IN_CELCIUS,ROUND((RAIN_I*2.54),2) AS RAINFALL_IN_CENTI
FROM STATS,STATION
WHERE STATS.ID=STATION.ID;

-- 12. Update all rows of table STATS to compensate for faulty rain gauges known to read 0.01 inches low.
UPDATE  STATS
SET RAIN_I = RAIN_I+0.01;

-- 13. Update Denver's July temperature reading as 74.9
UPDATE STATS
SET TEMP_F =74.9
WHERE MONTHS=7 AND ID IN (SELECT ID FROM STATION WHERE CITY='Denver');