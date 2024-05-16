--  All the tracks that have a length of 5,000,000 milliseconds or more.
SELECT *
FROM tracks
WHERE milliseconds >= 5000000;

-- All the invoices whose total is between $5 and $15 dollars.
SELECT *
FROM invoices
WHERE total BETWEEN 5 AND 15;

-- All the customers from the following States: RJ, DF, AB, BC, CA, WA, NY.
SELECT * 
FROM customers
WHERE State IN ('RJ','DF','AB','BC','CA','WA','NY');

-- All invoices from the billing city Brasília, Edmonton, and Vancouver in descending order
SELECT InvoiceId, BillingCity, Total
FROM Invoices
WHERE BillingCity IN ('Brasilia','Edmonton','Vancouver')
ORDER BY InvoiceId DESC;

-- Number of orders placed by each customer in descending order
SELECT customerid, count(*) as orders
FROM invoices
GROUP BY customerid
ORDER BY orders DESC;

-- Albums with 12 or more tracks.
SELECT albumid, count(albumid)
FROM tracks
GROUP BY albumid
HAVING count(albumid) >= 12;

--  All the tracks for the album "Californication"
SELECT name, albumid
FROM tracks
WHERE albumid IN (SELECT albumid
					FROM albums
					WHERE title = 'Californication')
;

-- Total number of invoices for each customer along with the customer's full name, city and email.
SELECT firstname, 
		lastname, 
		city, 
		email, 
        COUNT(i.invoiceid) As Invoices
FROM customers c 
LEFT JOIN invoices i 
    ON i.customerid = c.customerid
GROUP BY c.customerid;

-- Retrieve the track name, album, artistID, and trackID for all the albums.
SELECT at.Name AS artist, 
		t.Name As Song, 
		a.title As Album, 
        a.artistid, 
        t.trackid
FROM albums a
LEFT JOIN tracks t  
    ON t.albumid = a.albumid
LEFT JOIN artists at 
    ON at.artistid = a.artistid;
    
-- List with the managers last name, and the last name of the employees who report to him or heR
SELECT m.lastname AS Manager_LastName, 
		e.lastname AS Employee_LastName
FROM employees e 
JOIN employees m
    ON m.employeeid = e.reportsto;
    
-- Name and ID of the artists who do not have albums. 
SELECT at.Name AS Artist,
        a.title AS Album,
        at.artistid
FROM artists at
LEFT JOIN albums a 
    ON a.artistid = at.artistid
WHERE Album IS NULL;

-- List of all the employee's and customer's first names and last names ordered by the last name in descending order
Select FirstName, 
		LastName
From Employees
UNION
Select FirstName,
		LastName
From Customers
Order By LastName DESC
Limit 6;

-- Customers who have a different city listed in their billing city versus their customer city.
SELECT c.firstname, 
		c.lastname, 
        city AS CustomerCity, 
        billingcity
FROM Customers c 
LEFT JOIN Invoices i 
    ON i.customerid = c.customerid
WHERE city != billingcity;

-- List of customer ids, full name, address, city and country
SELECT customerid,
		firstname ||''|| lastname AS FullName,
		Address,
        UPPER(City ||', '|| Country) AS City_Country
FROM Customers;

-- New employee user id from the first 4 letters of the first name and the first 2 letters of the last name.
SELECT SUBSTR(firstname,1,4) AS A, 
       SUBSTR(lastname,1,2) AS B,
       LOWER(SUBSTR(firstname,1,4) || SUBSTR(lastname,1,2)) AS userid
FROM employees;

-- List of employees who have worked for the company for 15 or more years 
SELECT Firstname, 
        Lastname,
        hiredate,
        STRFTIME('%Y', 'now') - STRFTIME('%Y', hiredate) AS YearsWorked
FROM employees
WHERE YearsWorked >= 15
ORDER BY Lastname;

-- Cities with the most customers and rank in descending order.
SELECT City, COUNT(*) AS NCustomers
FROM Customers
GROUP BY City
ORDER BY NCustomers DESC;

-- New customer invoice id by combining a customer’s invoice id with their first and last name 
SELECT firstname, 
        lastname, 
        invoiceid,
        (firstname || lastname || invoiceid) AS NewId
FROM Customers c 
LEFT JOIN Invoices i 
    ON i.customerid = c.customerid
ORDER BY firstname, lastname, invoiceid


