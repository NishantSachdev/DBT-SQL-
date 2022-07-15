-- query 1 - List all the columns of the Salespeople table.
select COLUMN_NAME
from INFORMATION_SCHEMA.COLUMNS
where TABLE_NAME='Salespeople';

-- query 2 - List all customers with a rating of 100.
select * 
from Customers
where RATING=100;

-- query 3 - Find all records in the Customer table with NULL values in the city column.
from Customers
where CITY='NULL';

-- query 4 - Find the largest order taken by each salesperson on each date (*)
select Orders.SNUM, ODATE, MAX(AMT) as 'Largest order taken for the day', Salespeople.SNAME
from Orders
inner join Salespeople
on Salespeople.SNUM=Orders.SNUM
group by Orders.SNUM, ODATE, Salespeople.SNAME

select * from orders

-- query 5 - Arrange the Orders table by descending customer number.
select * 
from Orders
order by CNUM desc;

-- query 6 - Find which salespeople currently have orders in the Orders table.
from Salespeople
INNER JOIN Orders
ON Salespeople.SNUM = Orders.SNUM;

-- query 7 - List names of all customers matched with the salespeople serving them.
select Customers.CNAME, Salespeople.SNAME
from Salespeople
INNER JOIN Customers
ON Salespeople.SNUM = Customers.SNUM;

-- query 8 - Find the names and numbers of all salespeople who had more than one customer (*)
select Customers.SNUM, Salespeople.SNAME, Count(Customers.SNUM) as 'Number of Customers'
from Salespeople
inner join Customers
on Salespeople.SNUM = Customers.SNUM
group by Customers.SNUM, Salespeople.SNAME
having Count(Customers.SNUM)>1

-- query 9 - Count the orders of each of the salespeople and output the results in descending order.
select SNUM, COUNT(SNUM)
from Orders
group by SNUM
order by COUNT(SNUM) desc;

select * from Orders

-- query 10 - List the Customer table if and only if one or more of the customers in the Customer table are located in San Jose. 
from Orders
inner join Salespeople
on Salespeople.SNUM = Orders.SNUM
group by Orders.SNUM, Salespeople.SNAME
-- query 20 - Find all pairs of customers having the same rating.
from Customers A, Customers B
where A.RATING = B.RATING and A.CNUM < B.CNUM;

-- query 21 - Find all customers whose CNUM is 1000 above the SNUM of Serres.
select * from Customers
where (CNUM-1000)>=(select SNUM from Salespeople where SNAME='Serres');

-- query 22 - Give the salespeople�s commissions as percentages instead of decimal numbers.
select CONCAT(CAST(CAST(COMM*100 as int) as varchar),'%')
from Salespeople;

-- query 23 - Find the largest order taken by each salesperson on each date, eliminating those MAX orders which are less than $3000.00 in value.
select Salespeople.SNAME, Orders.SNUM, MAX(AMT) as 'largest order taken by salesperson on each date', ODATE
from Orders
inner join Salespeople
on Salespeople.SNUM = Orders.SNUM
group by Orders.SNUM, ODATE, Salespeople.SNAME
having MAX(AMT)>3000;

-- query 24 - List the largest orders for October 3, for each salesperson.
select MAX(AMT) as 'largest order for October 3 for each salesperson', Orders.SNUM, Salespeople.SNAME, ODATE
from Orders
inner join Salespeople
on Salespeople.SNUM = Orders.SNUM
group by Orders.SNUM, ODATE, Salespeople.SNAME
having ODATE='10/03/96';

-- query 25 - Find all customers located in cities where Serres (SNUM 1002) has customers.
select * from Customers 
where CITY in (select CITY from Customers where SNUM=1002)

-- query 26 - Select all customers with a rating above 200.00
select * from Customers
where CAST(RATING as decimal)>200.00

-- query 27 - Count the number of salespeople currently listing orders in the Orders table
select COUNT(DISTINCT(SNUM)) as 'number of salespeople currently listing orders in the Orders table'
from Orders

/* query 28 - Write a query that produces all customers serviced by salespeople with a commission above 12%. 
Output the customer�s name and the salesperson�s rate of commission.*/

select Salespeople.SNAME, Customers.CNAME, CONCAT(CAST(CAST(Salespeople.COMM*100 as int) as varchar),'%') as 'COMMISSION'
from Customers
inner join Salespeople
on Customers.SNUM=Salespeople.SNUM
where Salespeople.COMM>0.12

-- query 29 - Find salespeople who have multiple customers.
from Salespeople A, Salespeople B

-- query 47 - Find all salespeople that are located in either Barcelona or London
select * from Salespeople
where CITY in ('Barcelona','London')

-- query 48 - Find all salespeople with only one customer.
select * from Salespeople 
where SNUM in (select SNUM from Customers group by SNUM having COUNT(SNUM)=1)

-- query 49 - Write a query that joins the Customer table to itself to find all pairs of customers served by a single salesperson. (duplicate rows with the order reversed)
select A.CNUM, B.CNUM 
from Customers A, Customers B
where A.SNUM = B.SNUM and  A.CNUM <> B.CNUM

-- query 50 - Write a query that will give you all orders for more than $1000.00.
select * from Orders
where AMT > 1000.00

-- query 51 - Write a query that lists each order number followed by the name of the customer who made that order.
select Orders.ONUM, Customers.CNAME
from Orders
inner join Customers
on Orders.CNUM = Customers.CNUM

-- query 52 - Write 2 queries that select all salespeople (by name and number) who have customers in their cities who they do not service, 
-- one using a join and one a corelated subquery. Which solution is more elegant?

-- join query
select distinct Salespeople.SNAME, Salespeople.SNUM
from Salespeople
inner join Customers
on Salespeople.CITY=Customers.CITY
where Salespeople.SNUM <> Customers.SNUM

-- subquery

-- ** Incomplete ** 

-- query 53 - Write a query that selects all customers whose ratings are equal to or greater than ANY (in the SQL sense) of Serres�?
select * from Customers 
where RATING >= (select MIN(RATING) from Customers where SNUM = (select SNUM from Salespeople where SNAME='Serres'))

-- query 54 - Write 2 queries that will produce all orders taken on October 3 or October 4.
select * from Orders
where ODATE = '10/03/96' or ODATE = '10/04/96'

select * from Orders
where ODATE in ('10/03/96','10/04/96')

-- query 55 - Write a query that produces all pairs of orders by a given customer. Name that customer and eliminate duplicates.
select distinct A.CNUM, A.ONUM, B.ONUM
from Orders A, Orders B 
where A.CNUM = B.CNUM and A.ONUM <> B.ONUM

-- ** Name Part not done **

-- query 56 - Find only those customers whose ratings are higher than every customer in Rome
select * from Customers
where RATING>(select MAX(RATING) from Customers where CITY='Rome')

-- query 57 - Write a query on the Customers table whose output will exclude all customers with a rating <= 100.00, unless they are located in Rome.
select * from Customers 
where RATING>100 or CITY='Rome'

-- query 58 - Find all rows from the Customers table for which the salesperson number is 1001.
select Salespeople.SNAME, Orders.SNUM, SUM(AMT) as 'Total Amount in Orders for each salesperson'  
from Orders
inner join Salespeople
on Salespeople.SNUM = Orders.SNUM
group by Orders.SNUM, Salespeople.SNAME
having SUM(AMT)>(select MAX(AMT) from Orders)

-- query 60 - Write a query that selects all orders save those with zeroes or NULLs in the amount field.
select * from Orders 
where CAST(AMT as varchar) not in ('NULL','0.00')