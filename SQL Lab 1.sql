create database Gsm1;

use Gsm1;

create table Employees
(
Employee_ID int NOT NULL,
Salary int NOT NULL,
Namee varchar(20),
Surname varchar(20),
PRIMARY KEY (Employee_ID),
);

create table Brand
(
Name_Brand varchar(30) UNIQUE,
Profit float UNIQUE,
PRIMARY KEY(Name_Brand),
);

create table Computers
(
Name_Brand varchar(30) REFERENCES Brand(Name_Brand),
Model varchar(20),
Price int,
Date_model Date,
);

create table Phones
(
Price int NOT NULL,
CPU varchar(20) UNIQUE,
RAM varchar(20),
Name_Brand varchar(30) REFERENCES Brand(Name_Brand),
);

create table Shifts
(
Shift_ID int NOT NULL,
Time_open int NOT NULL,
Time_close int NOT NULL,
Time_date date Not NULL,
PRIMARY KEY(Shift_ID),
)
create table Shifts_employees
(
Employee_ID int REFERENCES Employees(Employee_ID),
Shift_ID int REFERENCES Shifts(Shift_ID),
);

INSERT INTO Employees (Employee_ID, Salary, Namee, Surname) VALUES
(1, 1500, 'Lungu', 'Rares'),
(2, 1500, 'Puscasu', 'Alex'),
(3, 2000, 'George', 'Racos'),
(4, 3000, 'Gabriel', 'Herbei');

INSERT INTO Brand (Name_Brand, Profit) VALUES
('Microsoft', 1000000),
('Intel', 100000),
('Invidia', 25000),
('Sony', 200000),
('PC Garage', 10000);

INSERT INTO Computers (Name_Brand, Model, Price, Date_model) VALUES
(NULL, 'IDK', 3450, '2021/11/08'),
(NULL, 'V2', 1500., '2021/11/02'),
('Intel', 'V2', 2000, '2021/10/01'),
('Intel', 'V2 Pro', 2200, '2022/03/15'),
('Invidia', 'V1', 800, '2018/06/10'),
('Invidia', 'V2', 900, '2019/06/10'),
('Invidia', 'V3', 1000, '2020/06/10'),
('Sony', 'V1', 3000, '2023/10/07'),
('Sony', 'V2', 3500, '2024/10/07'),
('PC Garage', 'V1', 180, '1995/05/05'),
('Intel', 'V1', 1500, '2020/10/05');

INSERT INTO Phones (Name_Brand, CPU, RAM, Price) VALUES
(NULL, NULL, '6 GB', 2500),
('Intel', 'I5', '8 GB', 2000),
('Intel', 'I7', '16 GB', 3000),
('Invidia', 'AMD RYZEN 5', '8 GB', 1500),
('Invidia', 'AMD RYZEN 7', '16 GB', 1800),
('Sony', 'SONYO 4', '4 GB', 800),
('PC Garage', 'SONYO knockoff', '2 GB', 200);

DELETE FROM Phones;

INSERT INTO Shifts (Shift_ID, Time_open, Time_close, Time_date) VALUES
(10, 0, 8, '2024/10/29'),
(1, 0, 8, '2024/10/29'),
(2, 8, 16, '2024/10/29'),
(3, 16, 24, '2024/10/29'),
(4, 0, 8, '2024/10/30'),
(5, 8, 16, '2024/10/30'),
(6, 16, 24, '2024/10/30'),
(7, 0, 8, '2024/10/31'),
(8, 8, 16, '2024/10/31'),
(9, 16, 24, '2024/10/31');

INSERT INTO Shifts_employees (Employee_ID, Shift_ID) VALUES
(1, 1),
(1, 4),
(1, 7),
(2, 2),
(2, 3),
(3, 5),
(3, 6),
(4, 8),
(4, 9);

UPDATE Shifts
SET Time_date='2024/10/28'
WHERE Shift_ID=10

DELETE FROM Computers
WHERE Price=1500

DELETE FROM Phones
WHERE Price BETWEEN 2000 AND 2500

UPDATE Phones
SET RAM='4 GB'
WHERE CPU LIKE 'SONYO 4'

DELETE FROM Computers
WHERE Name_Brand IS NULL

SELECT * FROM Computers;

--The employees whose names start with a g and have the salary bigger than 2000
SELECT * FROM Employees
WHERE Namee LIKE 'G%'
INTERSECT
SELECT * FROM Employees
WHERE Salary >2000

--The Computers prices that have the Namebrand starting with Int and the phones prices
--that have the CPU starting with I(The phones and Computers that have components or are from Intel and amd)
SELECT Price FROM Computers
WHERE Name_Brand LIKE 'In%'
UNION
SELECT Price FROM Phones
WHERE CPU LIKE 'I%' AND CPU LIKE 'A'

--Shifts that have the time of opening at 00:00 and dont have the Date ending in 9
SELECT * FROM Shifts
WHERE Time_open=0
EXCEPT
SELECT * FROM Shifts
WHERE Time_Date LIKE '%9' OR Time_Date LIKE '%8'

--Brands alltoghther with the coresponding computers that they make
SELECT *
FROM Brand INNER JOIN Computers ON
Brand.Name_Brand=Computers.Name_Brand

-- Brands connected to the computers (if there are any computers that dont have a brand from Brand table, they will appear)
SELECT *
FROM Brand RIGHT OUTER JOIN Computers ON
Brand.Name_Brand=Computers.Name_Brand

--Brands connected to the phones (if there are any brands in the sistem and not a single phone in the gms store of that brand,
--the brand will still apear) 
SELECT *
FROM Brand LEFT OUTER JOIN Phones ON
Brand.Name_Brand=Phones.Name_Brand

--Brands coneected to phones(if there are any computers without a brand, or any brand without any computers in the store, 
--they will appear)
SELECT *
FROM Brand FULL OUTER JOIN Computers ON
Brand.Name_Brand=Computers.Name_Brand

SELECT *
FROM Brand FULL OUTER JOIN Computers ON
Brand.Name_Brand=Computers.Name_Brand FULL OUTER JOIN Phones ON
Phones.Name_Brand=Brand.Name_Brand


--Select all Employees that Have shifts in shifts_employees that have an ID bigger than 5
SELECT *
FROM Employees
WHERE Employee_ID IN(SELECT Employee_ID FROM  Shifts_employees WHERE Shift_ID>5)

--Selects all the Brands that are nonempty in computers
SELECT Name_Brand
FROM Phones
WHERE EXISTS(SELECT Name_Brand FROM Brand WHERE Phones.Name_Brand=Brand.Name_Brand);

SELECT * 
FROM Brand

--Selects and Orders by grouping All The Name brands From computers Having the number of appeareances bigger than one
SELECT Name_Brand, COUNT(*)
FROM Computers
GROUP BY Name_Brand
HAVING COUNT(*)>1
ORDER BY COUNT(*) DESC

SELECT RAM, COUNT(*)
FROM Phones
GROUP BY RAM
HAVING COUNT(*)<3
ORDER BY COUNT(*)

--Selects the name brand of the phones and averages the price of all the phones with that brand
SELECT Name_Brand, AVG(Price)
FROM Phones
GROUP BY Name_Brand
HAVING AVG(Price)>=800


--Selects the name brand of the computers and gets the most expensive price of an computer with the specific brand
SELECT Name_Brand, MAX(Price)
FROM Computers
GROUP BY Name_Brand, Price
HAVING Price>=1000

SELECT Name_Brand, MAX(Price)
FROM Computers
GROUP BY Name_Brand
HAVING MAX(Price)>1000

--Gives the names brands from computers that dont repeat
SELECT DISTINCT Name_Brand
FROM Computers

-- Gives the first tree colloms from computers
SELECT TOP 3 *
FROM Computers

--Gives the date model and model from computers that have a price bigger than 1500
SELECT A.Date_Model, A.Model
FROM
(SELECT *
FROM Computers
WHERE Price>1500)A


select * from Employees
order by Salary
