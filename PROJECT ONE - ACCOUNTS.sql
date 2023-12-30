---DISPLAY TOTAL SALES BY MONTH--

SELECT
DATENAME(MONTH, SaleDate) AS MONTH,
ROUND(SUM(SalePrice), 2) AS Total_Sales
FROM Nashville
GROUP BY DATENAME(MONTH, SaleDate)
ORDER BY Total_Sales DESC


/* Question
This company wants to create an email address for each customer
The email address should be the first name of the primary_poc . last name of the primary_poc @ company name .com
KEY 
You may have noticed that in your solution  that some of the company names include spaces, 
which will certainly not work in an email address. 
See if you can create an email address that will work by removing all of the spaces in the account name, 
AND make sure all the email is in lower case*/

SELECT primary_poc, name
FROM accounts

WITH WALE AS
(SELECT name,primary_poc,
LEFT(primary_poc, CHARINDEX(' ', primary_poc)-1)AS First_Name,
RIGHT(primary_poc, LEN(primary_poc)-CHARINDEX(' ', primary_poc)) AS Last_Name
FROM accounts)
SELECT *,LOWER(REPLACE(CONCAT(First_Name, '.', Last_Name, '@', name, '.com'),' ',''))AS Staff_email
FROM WALE

SELECT name,primary_poc,
LOWER(REPLACE(CONCAT(LEFT(primary_poc, CHARINDEX(' ', primary_poc)-1),'.', RIGHT(primary_poc, 
LEN(primary_poc)-CHARINDEX(' ', primary_poc)),'@',name,'.com'),' ',''))AS Staff_Email
FROM accounts


/*Question 2
This company wants to create an email address for each customer
The email address should be the first letter of the first name of the primary_poc . last name of the primary_poc @ company name .com
KEY 
You may have noticed that in your solution  that some of the company names include spaces, 
which will certainly not work in an email address. 
See if you can create an email address that will work by removing all of the spaces in the account name, 
AND make sure all the email is in lower case*/


---USING CTE--
WITH WALE AS
(SELECT primary_poc, name,
LEFT(primary_poc, CHARINDEX(' ', primary_poc)-1 )AS Fristname,
RIGHT(primary_poc, LEN(primary_poc) - CHARINDEX(' ', primary_poc)) AS Lastname
FROM accounts)
SELECT * , 
LOWER(CONCAT(LEFT(Fristname, 1), lastname, '@', REPLACE(name, ' ',''))) AS Email_address
FROM WALE

---USING SUB-QUERY--
SELECT *, LOWER(REPLACE(CONCAT(Frist_Name,'.',Last_Name,'@',name,'.com'),' ','')) AS Staff_email
FROM
(SELECT primary_poc, name, 
LEFT(primary_poc, CHARINDEX(' ',primary_poc)-1) AS Frist_Name,
RIGHT(primary_poc, LEN(primary_poc) - CHARINDEX(' ', primary_poc)) Last_Name
FROM accounts) Table1

---WITHOUT CTE AND SUB-QUERY---
SELECT primary_poc, name,
LOWER(CONCAT(LEFT(primary_poc, 1), RIGHT(primary_poc, LEN(primary_poc) - CHARINDEX(' ', primary_poc)), '@', REPLACE(name, ' ',''))) AS Staff_email
FROM accounts


/*QUESTION 2--
We would also like to create an initial password, which they will change after their first log in 
the first password will be the first letter of the primary_poc's first name (lowercase), then the last 
letter of their first name (lowercase), the first letter of their last name (lowercase), the last letter of 
their last name (lowercase), the number of letters in their first name, the number of letters in their last name, 
and then the name of the company they are working with, all capitalized with no spaces*/

---USING SUB-QUERY--
SELECT *,CONCAT(LEFT(LOWER(First_name),1), RIGHT(First_name,1), LEFT(LOWER(Last_name),1), 
RIGHT(Last_name,1), LEN(First_name), LEN(Last_name),UPPER(REPLACE(name, ' ',''))) AS Password
FROM 
(SELECT name, primary_poc,
LEFT(primary_poc, CHARINDEX(' ', primary_poc)-1) AS First_name,
RIGHT(primary_poc, LEN(primary_poc)-CHARINDEX(' ',primary_poc)) AS Last_name
FROM accounts)TABLE1


---USING CTE---
WITH WALE AS
(SELECT name, primary_poc,
LEFT(primary_poc, CHARINDEX(' ', primary_poc)-1) AS First_name,
RIGHT(primary_poc, LEN(primary_poc)-CHARINDEX(' ',primary_poc)) AS Last_name
FROM accounts)
SELECT * ,CONCAT(LEFT(LOWER(First_name),1), RIGHT(First_name,1), LEFT(LOWER(Last_name),1), 
RIGHT(Last_name,1),LEN(First_name), LEN(Last_name),UPPER(REPLACE(name, ' ',''))) AS Password
FROM WALE

