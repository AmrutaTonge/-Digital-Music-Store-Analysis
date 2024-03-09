create database music;

use music;

-- 1. who is the senior most employee based on job title ?
select * from employee;
select * from employee order by levels desc limit 1 ;

-- 2. which countries have the most invoices ? 
select billing_country,count(*) as c from invoice group by billing_country order by c desc;

-- 3.what are top 3 values of total invoice ?
select total from invoice order by total desc limit 3;

-- Q4: Which city has the best customers? We would like to throw a promotional Music Festival in the city we made the most money. 
-- Write a query that returns one city that has the highest sum of invoice totals. 
-- Return both the city name & sum of all invoice totals
select * from invoice;
select billing_city,sum(total)as invoice_total  from invoice group by billing_city order by  invoice_total desc;

--  Q5: Who is the best customer? The customer who has spent the most money will be declared the best customer. 
-- Write a query that returns the person who has spent the most money.
select c.customer_id ,sum(i.total) as total  from customer c join invoice i on c.customer_id=i.customer_id group by c.customer_id order by total desc limit 1;

-- Question Set 2 - Moderate
-- /* Q1: Write query to return the email, first name, last name, & Genre of all Rock Music listeners. 
-- Return your list ordered alphabetically by email starting with A. 
SELECT DISTINCT email AS Email,first_name AS FirstName, last_name AS LastName, genre.name AS Name
FROM customer
JOIN invoice ON invoice.customer_id = customer.customer_id
JOIN invoice_line ON invoice_line.invoice_id = invoice.invoice_id
JOIN track ON track.track_id = invoice_line.track_id
JOIN genre ON genre.genre_id = track.genre_id
WHERE genre.name LIKE 'Rock'
ORDER BY email;

-- Q2: Let's invite the artists who have written the most rock music in our dataset. 
-- Write a query that returns the Artist name and total track count of the top 10 rock bands.
select a.name,count(a.artist_id) as song from artist a 
join album2 ab on a.artist_id=ab.artist_id
join  track t on t.album_id=ab.album_id
join genre g on g.genre_id=t.genre_id
where g.name = 'Rock' 
group by a.name
order by song desc
limit 10;

-- Q3: Return all the track names that have a song length longer than the average song length. 
-- Return the Name and Milliseconds for each track. Order by the song length with the longest songs listed first.
select name,milliseconds from track 
where milliseconds > (select avg(milliseconds) as track_length from track)
order by milliseconds desc;

/* Question Set 3 - Advance */

-- Q1: Find how much amount spent by each customer on artists? Write a query to return customer name,
-- artist name and total spent
select c.customer_id, c.first_name, c.last_name, a.name, SUM(il.unit_price*il.quantity) AS amount_spent
FROM invoice i
JOIN customer c ON c.customer_id = i.customer_id
JOIN invoice_line il ON il.invoice_id = i.invoice_id
JOIN track t ON t.track_id = il.track_id
JOIN album2 alb ON alb.album_id = t.album_id
JOIN artist a ON a.artist_id = alb.artist_id
GROUP BY 1,2,3,4
ORDER BY 5 DESC;

