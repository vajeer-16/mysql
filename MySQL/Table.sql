CREATE TABLE SALESPEOPLE (
    SNUM INT PRIMARY KEY,
    SNAME VARCHAR(50),
    CITY VARCHAR(50),
    COMM DECIMAL(3,2)
);
INSERT INTO SALESPEOPLE (SNUM, SNAME, CITY, COMM)
VALUES (1001, 'Peel', 'London', 0.12),
    (1002, 'Serres', 'San Jose', 0.13),
    (1004, 'Motika', 'London', 0.11),
    (1007, 'Rafkin', 'Barcelona', 0.15),
    (1003, 'Axelrod', 'New York', 0.10);
SELECT*FROM SALESPEOPLE;
CREATE TABLE CUST (
    CNUM INT PRIMARY KEY,
    CNAME VARCHAR(50),
    CITY VARCHAR(50),
    RATING INT,
    SNUM INT,
    FOREIGN KEY (SNUM) REFERENCES SALESPEOPLE(SNUM)
);
INSERT INTO CUST (CNUM, CNAME, CITY, RATING, SNUM) VALUES
(2001, 'Hoffman', 'London', 100, 1001),
(2002, 'Giovanne', 'Rome', 200, 1003),
(2003, 'Liu', 'San Jose', 300, 1002),
(2004, 'Grass', 'Brelin', 100, 1002),
(2006, 'Clemens', 'London', 300, 1007),
(2007, 'Pereira', 'Rome', 100, 1004);
SELECT*FROM CUST;
CREATE TABLE ORDERS (
    ONUM INT,
    AMT DECIMAL(10, 2),
    ODATE DATE,
    CNUM INT,
    SNUM INT
);
INSERT INTO ORDERS (ONUM, AMT, ODATE, CNUM, SNUM) VALUES
(3001, 18.69, '1994-10-03', 2008, 1007),
(3003, 767.19, '1994-10-03', 2001, 1001),
(3002, 1900.10, '1994-10-03', 2007, 1004),
(3005, 5160.45, '1994-10-03', 2003, 1002),
(3006, 1098.16, '1994-10-04', 2008, 1007),
(3009, 1713.23, '1994-10-04', 2002, 1003),
(3007, 75.75, '1994-10-05', 2004, 1002),
(3008, 4723.00, '1994-10-05', 2006, 1001),
(3010, 1309.95, '1994-10-06', 2004, 1002),
(3011, 9891.88, '1994-10-06', 2006, 1001);
SELECT*FROM ORDERS;
/*1.  Display snum,sname,city and comm of all salespeople.*/
	Select snum, sname, city, comm
	from salespeople;
/*2. 	Display all snum without duplicates from all orders.*/
	Select distinct snum 
	from orders;
/*3. 	Display names and commissions of all salespeople in london.*/
	Select sname,comm
	from salespeople
	where city = 'London';
/*4. 	All customers with rating of 100.*/
	Select cname 
	from cust
	where rating = 100;
/*5. 	Produce orderno, amount and date form all rows in the order table.*/
	Select onum, amt, odate
	from orders;
/*6. 	All customers in San Jose, who have rating more than 200.*/
	Select cname
	from cust
	where rating > 200;
/*7. 	All customers who were either located in San Jose or had a rating above 200.*/
	Select cname
	from cust
	where city = 'San Jose' or
	           rating > 200;
/*8. 	All orders for more than $1000.*/
	Select * 
	from orders
	where amt > 1000;
/*9. 	Names and citires of all salespeople in london with commission above 0.10.*/
	SELECT sname, city
FROM salespeople
WHERE comm > 0.10 
AND city = 'London';
/*10. 	All customers excluding those with rating <= 100 unless they are located in Rome.*/
	Select cname
	from cust
	where rating <= 100 or
	           city = 'Rome';	
/*11. 	All salespeople either in Barcelona or in london.*/
	Select sname, city
	from salespeople
	where city in ('Barcelona','London');
/*12. 	All salespeople with commission between 0.10 and 0.12. (Boundary values should be excluded)*/
	Select sname, comm
	from salespeople
	where comm > 0.10 and comm < 0.12;
/*13. 	All customers with NULL values in city column.*/
	Select cname
	from cust
	where city is null;
/*14. 	All orders taken on Oct 3Rd and Oct 4th  1994.*/
	Select *
	from orders 
	where odate in ('03-OCT-94','04-OCT-94');
/*15. 	All customers serviced by peel or Motika.*/
	SELECT cname
FROM cust, orders
WHERE orders.cnum = cust.cnum
AND orders.snum IN (SELECT snum FROM salespeople WHERE sname IN ('Peel', 'Motika'));
/*16. 	All customers whose names begin with a letter from A to B.*/
	SELECT cname 
FROM cust 
WHERE cname LIKE 'A%' 
   OR cname LIKE 'B%';
/*17. 	All orders except those with 0 or NULL value in amt field.*/
	Select onum
	from orders
	where amt != 0 or
	amt is not null;
/*18. 	Count the number of salespeople currently listing orders in the order table.*/
	Select count(distinct snum)
	from orders;
/*19. 	Largest order taken by each salesperson, datewise.*/
	Select odate, snum, max(amt)
	from orders
	group by odate, snum
	order by odate,snum;
/*20. 	Largest order taken by each salesperson with order value more than $3000.*/
	Select odate, snum, max(amt)
	from orders
	where amt > 3000
	group by odate, snum
	order by odate,snum;
/*21. 	Which day had the hightest total amount ordered.*/
	Select odate, amt, snum, cnum
	from orders
	where amt = (select max(amt) 
	from orders)
/*22. 	Count all orders for Oct 3rd.*/
	Select count(*)
	from orders
	where odate = '1994-10-03';
/*23. 	Count the number of different non NULL city values in customers table.*/
	Select count(distinct city)
	from cust;
/*24. 	Select each customer’s smallest order.*/
	Select cnum, min(amt)
	from orders
	group by cnum;
/*25. 	First customer in alphabetical order whose name begins with G.*/
	Select min(cname)
	from cust
	where cname like 'G%';
/*26. 	Get the output like “ For dd/mm/yy there are ___ orders.*/
	Select CONCAT('For ', DATE_FORMAT(odate,'%y/%m/%d'), ' there are ',
	count(*), ' Orders')
	from orders
	group by odate;
/*27. 	Assume that each salesperson has a 12% commission. Produce order no., salesperson no., and amount of salesperson’s commission for that order.*/
	Select onum, snum, amt, amt * 0.12
	from orders
	order by snum;
/*28. 	Find highest rating in each city. Put the output in this form. For the city (city), the highest rating is : (rating).*/
	SELECT CITY, MAX(RATING) AS Highest_Rating FROM CUST
GROUP BY CITY;

/*29. 	Display the totals of orders for each day and place the results in descending order.*/
	Select odate, count(onum)
	from orders
	group by odate
	order by count(onum);
/*30. 	All combinations of salespeople and customers who shared a city. (ie same city).*/
	Select sname, cname
	from salespeople, cust
	where salespeople.city = cust.city;
/*31. 	Name of all customers matched with the salespeople serving them.*/
	Select cname, sname
	from cust, salespeople
	where cust.snum = salespeople.snum;
/*32. 	List each order number followed by the name of the customer who made the order.*/
	Select onum, cname
	from orders, cust
	where orders.cnum = cust.cnum;
/*33. 	Names of salesperson and customer for each order after the order number.*/
	Select onum, sname, cname
	from orders, cust, salespeople
	where orders.cnum = cust.cnum and
	           orders.snum = salespeople.snum;
/*34. 	Produce all customer serviced by salespeople with a commission above 12%.*/
	Select cname, sname, comm
	from cust, salespeople
	where comm > 0.12 and
	           cust.snum = salespeople.snum;
/*35. 	Calculate the amount of the salesperson’s commission on each order with a rating above 100.*/
	Select sname, amt * comm
	from orders, cust, salespeople
	where rating > 100 and
	          salespeople.snum = cust.snum and
	          salespeople.snum = orders.snum and
	          cust.cnum = orders.cnum
/*36. 	Find all pairs of customers having the same rating.*/
	Select a.cname, b.cname,a.rating
	from cust a, cust b
	where a.rating = b.rating and
	          a.cnum != b.cnum
/*37. 	Find all pairs of customers having the same rating, each pair coming once only.*/
	Select a.cname, b.cname,a.rating
	from cust a, cust b
	where a.rating = b.rating and
	          a.cnum != b.cnum and
	  	                a.cnum < b.cnum;
/*38. 	Policy is to assign three salesperson to each customers. Display all such combinations.*/
	SELECT C.CNAME, S.SNAME
FROM CUST C, SALESPEOPLE S;

/*39. 	Display all customers located in cities where salesman serres has customer.*/
	SELECT DISTINCT C.CNAME FROM CUST C
WHERE C.CITY IN (
    SELECT CITY FROM CUST WHERE SNUM = (SELECT SNUM FROM SALESPEOPLE WHERE SNAME = 'Serres')
);

/*40. 	Find all pairs of customers served by single salesperson.*/
	SELECT A.CNAME AS Customer1, B.CNAME AS Customer2
FROM CUST A, CUST B
WHERE A.SNUM = B.SNUM AND A.CNUM < B.CNUM;
/*41. 	Produce all pairs of salespeople which are living in the same city. Exclude combinations of salespeople with themselves as well as duplicates with the order reversed.*/
	Select a.sname, b.sname
	from salespeople a, salespeople b
	where a.snum > b.snum and
	      a.city = b.city;
/*42. 	Produce all pairs of orders by given customer, names that customers and eliminates duplicates.*/
	Select c.cname, a.onum, b.onum
	from orders a, orders b, cust c
	where a.cnum = b.cnum and 
	          a.onum > b.onum and
	                      c.cnum = a.cnum;
/*43. 	Produce names and cities of all customers with the same rating as Hoffman.*/
	Select cname, city
	from cust
	where rating = (select rating
	            		        from cust
	              where cname = 'Hoffman')
	and cname != 'Hoffman';
/*44. 	Extract all the orders of Motika.*/
	Select Onum
	from orders
	where snum = ( select snum
	   from salespeople
	   where sname = 'Motika');
/*45. 	All orders credited to the same salesperson who services Hoffman.*/
	Select onum, sname, cname, amt
	from orders a, salespeople b, cust c
	where a.snum = b.snum and
	          a.cnum = c.cnum and
	          a.snum = ( select snum
	                            from orders
	                                        where cnum = ( select cnum
	                                                                  from cust
	                                                                  where cname = 'Hoffman'));
/*46. 	All orders that are greater than the average for Oct 4.*/
	Select * 
	from orders
	where amt > ( select avg(amt) 
	                        from orders
	                                    where odate = '1994-10-03');	
/*47. 	Find average commission of salespeople in london.*/
	Select avg(comm)
	from salespeople
	where city = 'London';
/*48. 	Find all orders attributed to salespeople servicing customers in london.*/
	Select snum, cnum 
	from orders
	where cnum in (select cnum 
	  from cust
	                          where city = 'London');
/*49. 	Extract commissions of all salespeople servicing customers in London.*/
	Select comm 
	from salespeople
	where snum in (select snum
	                          from cust
	                          where city = 'London');
/*50. 	Find all customers whose cnum is 1000 above the snum of serres.*/
	Select cnum, cname from cust
	where cnum > ( select snum+1000 
	                          from salespeople
	                          where sname = 'Serres');
/*51. 	Count the customers with rating  above San Jose’s average.*/
	Select cnum, rating
	from cust
	where rating > ( select avg(rating) 
	                           from cust
	                           where city = 'San Jose');
[10:14, 12/03/2025] Bhargavi: /* 52. Obtain all orders for the customer named Cisnerous */
SELECT * FROM ORDERS
WHERE CNUM = (SELECT CNUM FROM CUST WHERE CNAME = 'Cisnerous');

/* 53. Produce the names and rating of all customers who have above average orders */
SELECT CNAME, RATING FROM CUST
WHERE CNUM IN (SELECT CNUM FROM ORDERS GROUP BY CNUM HAVING AVG(AMT) > (SELECT AVG(AMT) FROM ORDERS));

/* 54. Find total amount in orders for each salesperson for whom this total is greater than the amount of the largest order in the table */
SELECT SNUM, SUM(AMT) AS Total_Amount FROM ORDERS
GROUP BY SNUM
HAVING Total_Amount > (SELECT MAX(AMT) FROM ORDERS);

/* 55. Find all customers with order on 3rd Oct */
SELECT DISTINCT CNAME FROM CUST
WHERE CNUM IN (SELECT CNUM FROM ORDERS WHERE ODATE = '1994-10-03');

/* 56. Find names and numbers of all salesperson who have more than one customer */
SELECT SNUM, SNAME FROM SALESPEOPLE
WHERE SNUM IN (SELECT SNUM FROM CUST GROUP BY SNUM HAVING COUNT(CNUM) > 1);

/* 57. Check if the correct salesperson was credited with each sale */
SELECT * FROM ORDERS
WHERE SNUM NOT IN (SELECT SNUM FROM CUST);

/* 58. Find all orders with above average amounts for their customers */
SELECT * FROM ORDERS O
WHERE AMT > (SELECT AVG(AMT) FROM ORDERS WHERE CNUM = O.CNUM);

/* 59. Find the sums of the amounts from order table grouped by date, eliminating all those dates where the sum was not at least 2000 above the maximum amount */
SELECT ODATE, SUM(AMT) AS Total_Amount FROM ORDERS
GROUP BY ODATE
HAVING Total_Amount >= (SELECT MAX(AMT) + 2000 FROM ORDERS);

/* 60. Find names and numbers of all customers with ratings equal to the maximum for their city */
SELECT CNAME, CNUM FROM CUST
WHERE RATING = (SELECT MAX(RATING) FROM CUST C WHERE C.CITY = CUST.CITY);

/* 61. Find all salespeople who have customers in their cities who they don’t service */
SELECT SNAME FROM SALESPEOPLE S
WHERE EXISTS (
    SELECT * FROM CUST C
    WHERE S.CITY = C.CITY AND S.SNUM != C.SNUM
);

/* 62. Extract cnum, cname and city from customer table if and only if one or more of the customers in the table are located in San Jose */
SELECT CNUM, CNAME, CITY FROM CUST
WHERE CITY = 'San Jose';

/* 63. Find salespeople no. who have multiple customers */
SELECT SNUM FROM CUST
GROUP BY SNUM
HAVING COUNT(CNUM) > 1;

/* 64. Find salespeople number, name and city who have multiple customers */
SELECT SNUM, SNAME, CITY FROM SALESPEOPLE
WHERE SNUM IN (SELECT SNUM FROM CUST GROUP BY SNUM HAVING COUNT(CNUM) > 1);

/* 65. Find salespeople who serve only one customer */
SELECT SNUM, SNAME FROM SALESPEOPLE
WHERE SNUM IN (SELECT SNUM FROM CUST GROUP BY SNUM HAVING COUNT(CNUM) = 1);

/* 66. Extract rows of all salespeople with more than one current order */
SELECT SNUM, COUNT(ONUM) AS Orders FROM ORDERS
GROUP BY SNUM
HAVING COUNT(ONUM) > 1;

/* 67. Find all salespeople who have customers with a rating of 300 (use EXISTS) */
SELECT SNAME FROM SALESPEOPLE S
WHERE EXISTS (
    SELECT * FROM CUST C
    WHERE C.RATING = 300 AND C.SNUM = S.SNUM
);

/* 68. Find all salespeople who have customers with a rating of 300 (use Join) */
SELECT DISTINCT S.SNAME FROM SALESPEOPLE S
JOIN CUST C ON S.SNUM = C.SNUM
WHERE C.RATING = 300;

/* 69. Select all salespeople with customers located in their cities who are not assigned to them (use EXISTS) */
SELECT SNAME FROM SALESPEOPLE S
WHERE EXISTS (
    SELECT * FROM CUST C
    WHERE C.CITY = S.CITY AND C.SNUM != S.SNUM
);

-- Remaining queries from 70 to 89 are still pending. Would you like me to proceed?
[10:14, 12/03/2025] Bhargavi: /* 70. Extract from customers table every customer assigned to a salesperson who currently has at least one other customer (besides the customer being selected) with orders in order table */
SELECT * FROM CUST C
WHERE EXISTS (
    SELECT * FROM ORDERS O
    WHERE O.CNUM != C.CNUM AND O.SNUM = C.SNUM
);

/* 71. Find salespeople with customers located in their cities (using both ANY and IN) */
SELECT SNAME FROM SALESPEOPLE
WHERE CITY IN (SELECT CITY FROM CUST);

/* 72. Find all salespeople for whom there are customers that follow them in alphabetical order. (Using ANY and EXISTS) */
SELECT SNAME FROM SALESPEOPLE S
WHERE EXISTS (
    SELECT * FROM CUST C
    WHERE C.CNAME > S.SNAME
);

/* 73. Select customers who have a greater rating than any customer in Rome */
SELECT * FROM CUST
WHERE RATING > ANY (SELECT RATING FROM CUST WHERE CITY = 'Rome');

/* 74. Select all orders that had amounts that were greater than at least one of the orders from Oct 6th */
SELECT * FROM ORDERS
WHERE AMT > ANY (SELECT AMT FROM ORDERS WHERE ODATE = '1994-10-06');

/* 75. Find all orders with amounts smaller than any amount for a customer in San Jose. (Both using ANY and without ANY) */
SELECT * FROM ORDERS
WHERE AMT < ANY (SELECT AMT FROM ORDERS O
                  JOIN CUST C ON O.CNUM = C.CNUM
                  WHERE C.CITY = 'San Jose');

/* 76. Select those customers whose ratings are higher than every customer in Paris. (Using both ALL and NOT EXISTS) */
SELECT * FROM CUST
WHERE RATING > ALL (SELECT RATING FROM CUST WHERE CITY = 'Paris');

/* 77. Select all customers whose ratings are equal to or greater than ANY of the Serres */
SELECT * FROM CUST
WHERE RATING >= ANY (SELECT RATING FROM CUST WHERE SNUM = (SELECT SNUM FROM SALESPEOPLE WHERE SNAME = 'Serres'));

/* 78. Find all salespeople who have no customers located in their city. (Both using ANY and ALL) */
SELECT SNAME FROM SALESPEOPLE
WHERE CITY != ALL (SELECT CITY FROM CUST WHERE SNUM = SALESPEOPLE.SNUM);

/* 79. Find all orders for amounts greater than any for the customers in London */
SELECT * FROM ORDERS
WHERE AMT > ANY (SELECT AMT FROM ORDERS O
                  JOIN CUST C ON O.CNUM = C.CNUM
                  WHERE C.CITY = 'London');

/* 80. Find all salespeople and customers located in London */
SELECT SNAME, CNAME FROM SALESPEOPLE
JOIN CUST ON SALESPEOPLE.CITY = CUST.CITY
WHERE SALESPEOPLE.CITY = 'London';

/* 81. For every salesperson, dates on which highest and lowest orders were brought */
SELECT SNUM, MAX(ODATE) AS Highest_Order_Date, MIN(ODATE) AS Lowest_Order_Date
FROM ORDERS
GROUP BY SNUM;

/* 82. List all of the salespeople and indicate those who don’t have customers in their cities as well as those who do have. */
SELECT SNAME, CITY,
       CASE
         WHEN SNUM IN (SELECT SNUM FROM CUST) THEN 'Has Customer'
         ELSE 'No Customer'
       END AS Customer_Status
FROM SALESPEOPLE;

/* 83. Append strings to the selected fields, indicating whether or not a given salesperson was matched to a customer in his city. */
SELECT SNAME, CITY,
       CASE
         WHEN SNUM IN (SELECT SNUM FROM CUST WHERE CITY = SALESPEOPLE.CITY) THEN 'Matched'
         ELSE 'Not Matched'
       END AS Match_Status
FROM SALESPEOPLE;
/* 84. Create a union of two queries that shows the names, cities, and ratings of all customers. Those with a rating of 200 or greater will also have the words 'High Rating', while the others will have the words 'Low Rating'. */
SELECT CNAME, CITY, RATING, 'High Rating' AS Status FROM CUST WHERE RATING >= 200
UNION
SELECT CNAME, CITY, RATING, 'Low Rating' AS Status FROM CUST WHERE RATING < 200;

/* 85. Write command that produces the name and number of each salesperson and each customer with more than one current order. Put the result in alphabetical order. */
SELECT SNAME, SNUM FROM SALESPEOPLE
WHERE SNUM IN (SELECT SNUM FROM ORDERS GROUP BY SNUM HAVING COUNT(ONUM) > 1)
ORDER BY SNAME;

/* 86. Form a union of three queries. Have the first select the snums of all salespeople in San Jose, the second the cnums of all customers in San Jose, and the third the onums of all orders on Oct. 3. Retain duplicates between the last two queries but eliminate redundancies between either of them and the first. */
SELECT SNUM FROM SALESPEOPLE WHERE CITY = 'San Jose'
UNION
SELECT CNUM FROM CUST WHERE CITY = 'San Jose'
UNION ALL
SELECT ONUM FROM ORDERS WHERE ODATE = '1994-10-03';

/* 87. Produce all the salesperson in London who had at least one customer there. */
SELECT SNAME FROM SALESPEOPLE
WHERE CITY = 'London' AND SNUM IN (SELECT SNUM FROM CUST WHERE CITY = 'London');

/* 88. Produce all the salesperson in London who did not have customers there. */
SELECT SNAME FROM SALESPEOPLE
WHERE CITY = 'London' AND SNUM NOT IN (SELECT SNUM FROM CUST WHERE CITY = 'London');

/* 89. We want to see salespeople matched to their customers without excluding those salesperson who were not currently assigned to any customers. (Use OUTER join and UNION) */
SELECT SNAME, CNAME FROM SALESPEOPLE
LEFT JOIN CUST ON SALESPEOPLE.SNUM = CUST.SNUM
UNION
SELECT SNAME, NULL AS CNAME FROM SALESPEOPLE
WHERE SNUM NOT IN (SELECT SNUM FROM CUST);
