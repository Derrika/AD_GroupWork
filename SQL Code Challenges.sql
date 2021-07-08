-- Created By: Derrika Coley
-- Date: April 20, 2021
-- Topic: SQL Code Challenges 

-- **************** IN THE RESTAURANT **************

CREATE DATABASE The_Restaurant;

-- *************** CREATE TABLES *****************

CREATE TABLE Customers (
	CustomerID INT Primary Key AUTO,
	FirstName Varchar(1000) NOT NULL,
	LastName VARCHAR(1000) NOT NULL,
	Email VARCHAR(100) ,
	Address VARCHAR(500),
	City VARCHAR(500),
	State VARCHAR(500),
	Phone VARCHAR(50),
	Birthday VARCHAR(50),
	Favorite INT,
);

CREATE TABLE CustomerDishes (
	CustomersDishesID INT,
	CustomerID INT,
	DishID INT,
);

CREATE TABLE CustomersEvents (
	CustomersEventsID INT,
	CustomersID INTEGER,
	EventID INT,
);

CREATE TABLE Dishes (
	DishID INTEGER,
	Name VARCHAR(1000),
	Description VARCHAR(1000),
	Price Money,
	Type VARCHAR(500),

);

CREATE TABLE Events (
	EventID INTEGER,
	Name VARCHAR(1000),
	Description VARCHAR(1000),
	Date Date,
	Location VARCHAR(500),
);

CREATE TABLE EventsLocations (
	EventsLocationsID INT,
	EventName VARCHAR(1000),
	Locations VARCHAR(500),

);

-- ******************** CREATE INVITE  ********************

1. SELECT FirstName, LastName, Email from Customers ORDER BY LastName;

-- ************************ CREATE A TABLE TO STORE INFORMATION   *********************

2. Create TABLE AttendingCustomers (
	CustomerID INT,
	Number_of_persons int,
);

-- ************************ PRINT A MENU ********************

3a. Select * from Dishes ORDER BY Price;

b. Select * from Dishes WHERE Type = "Appetizer" OR Type = "Beverages" Order by Type;

c. SELECT * from Dishes WHERE Type != "Beverage" ORDER BY Type;

-- ******************** SIGN A CUSTOMER UP FOR THE RESTAURANT LOYALTY PROGRAM **************************

4. Insert into Customer (FirstName, LastName, Email, Address, City, State, Phone, Birthday, FavoriteDish)
	Values ("Maggi", "Domney", "", "", "",);

b. SELECT * FROM Customers ORBER BY CustomerID DESC;


-- **************************** UPDATE A CUSTOMER'S PERSONAL INFORMATION *****************************

SELECT CustomerID, FirstName, LastName, Address FROM Customers WHERE FirstName = "Maggi" AND LastName = "Domney";

5.UPDATE Customers SET
	Address="74 Pine St.",
	City="New York",
	State="NY",
WHERE CustomerID="26";

SELECT * FROM Customers WHERE CustomerID="26";

-- ****************************** REMOVE A CUSTOMER'S RECORD ****************************

6. SELECT * from Customers WHERE FirstName="John" AND LastName="James";

	DELETE FROM Customers WHERE CustomerID="4";

-- ************************** LOG CUSTOMER'S RESPONSES *********************
-- The invites the restaurant sent their customers invite to their anniversary event.

7. INSERT INTO AttendingCustomers (CustomerID, PartySize)
	values ((SELECT CustomerID FROM Customer WHERE Email="atapley2j@kinetec"), 12);

-- **************************** LOOK UP RESERVATIONS **********************************

8. SELECT Customers.FirstName, Customer.LastName, Reservations.Date, Reservations.PartySize
	FROM Reservations JOIN Customers ON Customers.CustomerID = Reservations.CustomerID WHERE
	Customers.LastName LIKE "Ste%";


-- ***************************  TAKE A RESERVATION **************************
  
  
  -- ************ Check if customer is in the restaurant database *******************

9. SELECT * FROM Customers WHERE FirstName = "Sam" AND LastName = "McAdams";
	
	-- if customer not in the database already, add the customer to the database

	INSERT INTO Customers (FirstName, LastName, Email, Phone) 
	Values ("Sam", "McAdams", "smac@kinetecoinc.com", "(555) 556-1232");

	-- Check that the customer was added successfully

	SELECT * FROM Customers WHERE Email="smac@kinetecoinc.com";

b. INSERT INTO Reservations (CustomerID, Date, PartySize) VALUES
	("102", "2021-04-19 17:00:00", "6");

C.	SELECT CustomerS.FirstName, Customers.LastName, Customers.Email, Reservations.Date, Reservations.PartySize
	FROM Customers JOIN Reservations ON Customers.CustomerID=Reservations.CustomersID
	WHERE Customers.Email="smac@kinetecoinc.com";


-- *************************** TAKE A DELIVERY ORDER **************************

-- Customer Order: For: Loretta Hundey, 6959 Elka Place. Meal: House Salad, 
-- Mini Cheeseburgers, Tropical Blue Smoothie

-- Enter data in database. Require: tables Customer, Dishes, Orders, and OrdersDishes
--     Create the record,  and
-- Calculate the total cost 

-- ************************** Find the Customer ************************

10.	SELECT CustomerID, FirstName, LastName,Phone FROM Customers
	WHERE Address="6959 Elka Place" AND LastName="Hundey";

	-- ***********************  Create an Order   ***********************

b.	INSERT INTO Orders (CustomerID, OrderDate) VALUES (70, "2021-04-20");

-- ************************** add items to the order  ***************************

	-- ************* LOOK FOR ORDER ID *****************

C.	SELECT * FROM Orders WHERE CustomerID="70" ORDER BY OrderDate DESC;
	
	--**************** ADD ORDER ITEMS TO ORDERS TABLE *************

	INSERT INTO OredersDishes (OrderID, DishID) VALUES
	  ("1001", (SELECT DishID FROM Dishes WHERE Name="House Salad")),
	  ("1001", (SELECT DishesID FROM Dishes WHERE Name="MINI Cheeseburgers")),
	  ("1001", (SELECT DishesID FROM Dishes WHERE Name="Tropical Blue Smoothie"));

	-- ************ CHECK THAT THE ORDER WAS INSERTED ****************

	SELECT * FROM Dishes JOIN OrdersDishes ON Dishes.DishesID=OrdersDishes.DishID
	WHERE OrdersDishes.OrderID="1001";

	-- ************* CALCULATE THE TOTAL COST *****************

d.	SELECT SUM(Dishes.Price) FROM Dishes JOIN OrdersDishes ON Dishes.DishID=OrdersDishes.DishID
	WHERE OrdersDishes.OrderID="1001";


-- ********************** TRACK YOUR CUSTOMER'S FAVORITE DISHES  ***********************

	-- Personalized Customer preferrence. In order to do this you can store all in 

	-- *************** FIND THE DISH ID FOR CUSTOMER FAVORITE DISH ***************

11.	SELECT DishID FROM Dishes WHERE Name="Quinoa Salmon Salad";

	-- ********** SEARCH FOR THE CUSTOMER ID THAT YOU WANT TO UPDATE *****************
b.	SELECT * FROM Customers WHERE FirstName="Cleo" AND LastName="Goldwater"
	
	-- ******************* UPDATE THE CUSTOMER RECORDS ********************

c.	UPDATE Customers SET FavoriteDish="9" WHERE CustomerID="42"; OR

	UPDATE Customers SET FavoriteDish = (SELECT DishID FROM Dishes WHERE Name="Quinoa Salmon Salad")
	WHERE CustomerID="42";

	-- ******************** Chect that customer record was updated ************
	SELECT Customers.FirstName, Customers.LastName, Customers.FavoriteDish, Dishes.Name FROM Customers
	JOIN Dishes ON Customers.FavoriteDish=Dishes.DishID;

-- ********************** Prepare a report of your top five customers ****************

	-- ************ Send a personalized birthday wish to customer *************

	-- ******* Provide the Number of Orders by mostly buying customers, *************
	-- ******* FirstName, LastName and Email. Sorted by number of orders ************
		

12.	SELECT COUNT(Orders.OrderID), Customers.FirstNmae, Customers.LastName, Customers.Email
	FROM Orders 
	JOIN Customers 
	ON Orders.CustomerID=Customers.CustomersID
	GROUP BY Orders.CustomersID 
	ORDER BY OrderCount DESC LIMIT 5;
	
	




/***************************************************************************   QUESTION *********************************************
	Find the difference between the total number of CITY entries in the table and the number of distinct CITY entries in the table. 
	The STATION table is described as follows:

	where LAT_N is the northern latitude and LONG_W is the western longitude.
	For example, if there are three records in the table with CITY values 'New York',
	'New York', 'Bengalaru', there are 2 different city names: 'New York' and 'Bengalaru'. 
	The query returns , because 

**************************************************************************************************************************************/


1. -- *****************************************  ANSWER ***************************
	
	SELECT (COUNT(CITY) - COUNT(DISTINCT CITY) FROM STATION;
	






	










