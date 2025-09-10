-- Q1. Simple SELECT: List the first name, last name, and email of all customers.
-- Q2. Filtering with WHERE: Find all invoices that have a total greater than $10.
-- Q3. Counting Rows: How many customers are there in the database?
-- Q4. Counting with a Condition: How many tracks are there in the "Rock" genre?
-- Q5. Basic JOIN: Find the name of all tracks and the name of their corresponding album.
-- Q6. JOIN with WHERE: Find the names of all employees who are sales support agents.
-- Q7. Aggregating with COUNT and GROUP BY: How many customers are there from each country?
-- Q8. Aggregating with SUM and GROUP BY: What is the total sales amount for each country?
-- Q9. Aggregating with ORDER BY: List the top 5 customers who have the highest total spending.
-- Q10. Multiple Joins: List the first name and last name of all customers who are from the same country as their support representative.


USE chinook;
-- Q1. Simple SELECT: List the first name, last name, and email of all customers.
select * from customer;
select firstName, LastName, Email from customer;

-- Q2. Filtering with WHERE: Find all invoices that have a total greater than $10.
select * from invoice WHERE total>10 order by Total desc;

-- Q3. Counting Rows: How many customers are there in the database?
select * from customer;
select count(customerid) from customer;


-- Q4. Counting with a Condition: How many tracks are there in the "Rock" genre?
select * from genre;
select * from track;

select count( distinct tr.trackid) from track tr inner join genre g 
using(genreid)
where g.name='rock';


SELECT g.Name, COUNT(t.TrackId)
FROM genres g
JOIN tracks t ON g.GenreId = t.GenreId
WHERE g.Name LIKE'%Rock%'
GROUP BY g.Name;
-- select colunms from table1 join_type table2 ON table1.column = table2.column;
-- select columns from table join table2 USING (column__name);
-- select column1, column2 from table1 INNER JOIN table2 ON table1.common_column = table2.common_column;
SELECT 
    track.Name, track.AlbumId
FROM
    track
        INNER JOIN
    genre ON track.GenreId = genre.GenreId
WHERE
    genre.Name = Rock
GROUP BY genre.Name; 


-- Q5. Basic JOIN: Find the name of all tracks and the name of their corresponding album.
-- select table1.column, table2.column from table1 INNER JOIN table2 ON table1.common_column = table2.common_column; 
select * from track;
select * from album;
SELECT 
    track.name, album.AlbumId, album.Title
FROM
    track
        INNER JOIN
    album ON track.albumId = album.albumId;
    



-- Q6. JOIN with WHERE: Find the names of all employees who are sales support agents.
select * from employee;
select * from employee WHERE Title ='Sales Support Agent';

-- Q7. Aggregating with COUNT and GROUP BY: How many customers are there from each country?
select * from customer;
select country, count(*) from customer
group by country
order by 2 desc;

select country , count(customerid) from customer
group by country
order by 2 desc;

-- Q8. Aggregating with SUM and GROUP BY: What is the total sales amount for each country?



select  billingcountry,sum(total) as Total_sales from invoice
group by billingcountry
order by 2 desc ;

-- Q9. Aggregating with ORDER BY: List the top 5 customers who have the highest total spending.

select * from invoice;


select customerid,sum(total) from invoice
group by customerid
order  by 2 desc
limit 5;


-- join to get the name
 select i.customerid,c.firstName,sum(total) from customer c inner join invoice i 
 using(customerid)
 group by i.customerid, c.firstname
 order by sum(total) desc
 limit 5;
 
 
 -- sub q 
 
 select customerid from invoice
group by customerid
order  by sum(total) desc
limit 5;

select * from customer
where customerid in (6,26,57,45,46);


create view  temp as
 select customerid from invoice
group by customerid
order  by sum(total) desc
limit 5;

select * from temp ;
 
 select firstname from customer
where customerid in (select * from temp);


 -- Q10. Multiple Joins: List the first name and last name of all customers who are from the same country as their support representative.
 
 
 select c.firstname as customer_name ,c.Country,e.firstname as emp_name,e.Country from customer c inner join employee e 
 on c.SupportRepId = e.EmployeeId
 where c.Country= e.Country;
 
 