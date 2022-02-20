 create database if not exists TRAVEL_ON_THE_GO;
 use TRAVEL_ON_THE_GO;
 
 -- Q1) You are required to create two tables PASSENGER and PRICE with the following attributes and properties 
 
 CREATE TABLE PASSENGER
 (Passenger_name varchar(50),
 Category varchar(15),
 Gender varchar(1),
 Boarding_City varchar(25),
 Destination_City varchar(25),
 Distance int,
 Bus_Type varchar(10));
 
 CREATE TABLE PRICE
 ( 
 Bus_Type varchar(10),
 Distance int,
 Price int
 );

-- Q2) Insert the following data in the tables

INSERT INTO PASSENGER VALUES ('Sejal','AC','F','Bengaluru','Chennai',350,'Sleeper');
INSERT INTO PASSENGER VALUES ('Anmol','Non-AC','M','Mumbai','Hyderabad',700,'Sitting');
INSERT INTO PASSENGER VALUES ('Pallavi','AC','F','Panaji','Bengaluru',600,'Sleeper');
INSERT INTO PASSENGER VALUES ('Khushboo','AC','F','Chennai','Mumbai',1500,'Sleeper');
INSERT INTO PASSENGER VALUES ('Udit','Non-AC','M','Trivandrum','Panaji',1000,'Sleeper');
INSERT INTO PASSENGER VALUES ('Ankur','AC','M','Nagpur','Hyderabad',500,'Sitting');
INSERT INTO PASSENGER VALUES ('Hemant','Non-AC','M','Panaji','Mumbai',700,'Sleeper');
INSERT INTO PASSENGER VALUES ('Manish','Non-AC','M','Hyderabad','Bengaluru',500,'Sitting');
INSERT INTO PASSENGER VALUES ('Piyush','AC','M','Pune','Nagpur',700,'Sitting');

INSERT INTO PRICE VALUES ('Sleeper',350,770);
INSERT INTO PRICE VALUES ('Sleeper',500,1100);
INSERT INTO PRICE VALUES ('Sleeper',600,1320);
INSERT INTO PRICE VALUES ('Sleeper',700,1540);
INSERT INTO PRICE VALUES ('Sleeper',1000,2200);
INSERT INTO PRICE VALUES ('Sleeper',1200,2640);
INSERT INTO PRICE VALUES ('Sleeper',1500,2700);
INSERT INTO PRICE VALUES ('Sitting',500,620);
INSERT INTO PRICE VALUES ('Sitting',600,744);
INSERT INTO PRICE VALUES ('Sitting',700,868);
INSERT INTO PRICE VALUES ('Sitting',1000,1240);
INSERT INTO PRICE VALUES ('Sitting',1200,1488);
INSERT INTO PRICE VALUES ('Sitting',1500,1860);

-- Q3) How many females and how many male passengers travelled for a minimum distance of 600 KM s?

SELECT GENDER, COUNT(*)
FROM PASSENGER 
WHERE DISTANCE >=600
GROUP BY GENDER;

-- Q4) Find the minimum ticket price for Sleeper Bus. 

SELECT min(price) FROM PRICE WHERE bus_type = 'Sleeper';

-- Q5) Select passenger names whose names start with character 'S'

SELECT * FROM PASSENGER WHERE passenger_name like 'S%';

-- Q6) Calculate price charged for each passenger displaying Passenger name, Boarding City, Destination City, Bus_Type, Price in the output

SELECT p1.Passenger_name, p1.Boarding_city,p1.Destination_city, p1.Category, p1.Bus_type,
max(p2.price) as Max_price
FROM passenger p1
INNER JOIN price p2
USING (bus_type, distance)
GROUP BY p1.Passenger_name, p1.Boarding_city,p1.Destination_city, p1.Category, p1.Bus_type;

-- Q7) What are the passenger name/s and his/her ticket price who travelled in the Sitting bus for a distance of 1000 KM s 

SELECT Passenger_name, Price
FROM Passenger p1, Price p2
WHERE p1.Distance = p2.Distance
AND p1.Bus_Type = p2.Bus_Type
AND p1.Bus_Type = 'Sitting'
AND p2.Distance = 1000;

-- Q8) What will be the Sitting and Sleeper bus charge for Pallavi to travel from Bangalore to Panaji?

SELECT p1.Passenger_name, p1.Boarding_city,p1.Destination_city, p1.Category, p1.Bus_type,
p2.price as Price
FROM Passenger p1
INNER JOIN 	price p2
USING (distance)
WHERE
((p1.Boarding_city = 'Bengaluru' and p1.Destination_city = 'Panaji') 
OR (p1.Boarding_city = 'Panaji' and p1.Destination_city = 'Bengaluru'));

-- Q9) List the distances from the "Passenger" table which are unique (non-repeated distances) in descending order.

SELECT distinct(distance) FROM passenger ORDER BY distance DESC;

-- Q10) Display the passenger name and percentage of distance travelled by that passenger from the total distance 
-- travelled by all passengers without using user variables.

SELECT p1.passenger_name, (p1.distance/(SELECT sum(distance) FROM passenger))*100 percentage FROM passenger p1;

-- Q11) Display the distance, price in three categories in table Price

SELECT  p1.distance, p1.price, 
CASE 
WHEN p1.price > 1000 THEN 'Expensive'
WHEN (p1.price > 500 AND p1.price < 1000) THEN 'Average'
ELSE 'Cheap' 
END p1_category
FROM price p1;


