-- Created By: Derrika Coley
-- Date: April 20, 2021
-- Topic: SQL Code Challenges


---- ************************ IN THE LIBRARY ****************

CREATE DATABASE The_Library

-- *********************** CREATE TABLE ************************

--  ******************** Check book Availabilty ****************

--*********** Check the number of Dracula books the library has *****************

1.	SELECT COUNT(BookID) FROM Books WHERE Title="Dracula";


--************ Checks the how many of the Dracula books are out on loan *************

b.	SELECT COUNT(Books.Title) FROM Loans JOIN Books ON Loans.BookID=Books.BookID
	WHERE Books.Title="Dracula" AND Loans.ReturenedDate IS NULL;


-- *************** Shows how many Dracula books are available to be loan **************

c. SELECT 
	(SELECT COUNT(Books.Title) FROM Books WHERE Books.Title="Dracula")
	-
	(SELECT COUNT(Books.Title) 
		FROM Loans
		JOIN Books ON Loans.BookID=Books.BookID
		WHERE Books.Title="Dracula" AND Loans.ReturnedDate IS NULL)
	AS AvailableBooks;


-- ****************** Add new books to the library *****************

2. INSERT INTO Books (Title, Author, Published, Barcode)
	Values
	("Dracula", "Bram Stoker", "1897", "4819277482"),
	("Gulliver's Travels", "Jonathan Swift", "1729", "489925440");


-- **************** Check out books from the library  ***********************

3. INSERT INTO Loans (BookID, PatronID, LoanDate, DueDate)
	VALUES
	((SELECT BookID FROM Books WHERE Barcode="2855934983"),
	 (SELECT PatronID FROM Patrons WHERE Email="jvaan@wisdompets.com"), 
	 "2020-08-25", "2020-09-02");
	
	INSERT INTO Loans (BookID, PatronID, LoanDate, DueDate)
	VALUES
	((SELECT BookID FROM Books WHERE Barcode="4043822646"),
	 (SELECT PatronID FROM Patrons WHERE Email="jvaan@wisdompets.com"), 
	 "2020-08-25", "2020-09-02");

-- Verify Insert by joining the books and loans 

b.	SELECT * FROM Loans JOIN Books ON Loans.BookID=Books.BooksID
	WHERE PatronID=(SELECT PatronID FROM Patrons WHERE Email="jvaan@wisdompets.com");

-- ************** Check for books due for return *************

4. SELECT Loans.DueDate, Books.Title, Patrons.Email, Patrons.FirstName
   FROM Loans 
   JOIN Books ON Loans.BookID=Books.BookID
   JOIN Patron ON Loans.PatronID=Patron.PatronID
   WHERE Loans.DueDate="2021-04-20" AND Loans.ReturnedDate IS NULL;


-- ***************** Return book to the library ****************

5. UPDATE Loans SET ReturnedDate="2021-04-19"
   WHERE BookID=(SELECT BookID FROM Books WHERE Barcode="6435968624")
   AND ReturnedDate IS NULL;

    UPDATE Loans SET ReturnedDate="2021-04-19"
   WHERE BookID=(SELECT BookID FROM Books WHERE Barcode="5677520613")
   AND ReturnedDate IS NULL;

    UPDATE Loans SET ReturnedDate="2021-04-19"
   WHERE BookID=(SELECT BookID FROM Books WHERE Barcode="8730298424")
   AND ReturnedDate IS NULL;


   -- *************** ENCOURAGE PATRONS TO CHECK OUT BOOKS ***************

6. SELECT COUNT(Loans.LoanID), Patrons.FirstName, Patrons.LastName, Patrons.Email 
   FROM Loans
   JOIN Patrons ON Loans.PatronID=Loans.PatronID
   GROUP BY Loans.PatronID
   ORDER BY loanCount ASC  LIMIT 10;
   

-- **************** FIND BOOKS TO FEATURE FOR AN EVENT ********************
7. SELECT Books.BookID, Books.Title, Books.Author, Books.Published FROM Books
   JOIN Loans ON Books.BookID=Loans.BookID	
   WHERE Books.Published > 1889 AND Published <1900
   AND Loans.ReturnedDate IS NOT NULL
   GROUP BY Books.BookID
   ORDER BY Books.Title;

   	 
-- ***************** BOOK STATISTICS ***************************

8.	SELECT Published, COUNT(DISTINCT(Title)) AS publishedcount FROM Books
	GROUP BY Published
	ORDER BY publishedcount DESC;

	SELECT COUNT(Loans.LoanID) AS loancount, Books.Title FROM Loans
	JOIN Books ON Loans.BookID=Books.BookID
	GROUP BY Books.Title
	ORDER BY loancount DESC LIMIT 5;
