use music_database;
# Q1) Who is the senior most employee based on job title
select * from employee
order by levels desc
limit 1;

# Q2) Which country has the most invoices
select billing_country, count(invoice_id) as TotalIn from invoice 
group by billing_country
order by TotalIn desc;

# Q3) What are top 3 values of total invoice
select * from invoice;
select total from invoice
order by total desc
limit 3;

/* Q4) Which city has the best customers? Write a query that returns one city
that has the highest sum of invoice totals. Return both the city name &
sum of all invoice totals*/
select * from invoice;
select billing_city, sum(total) as TotalIn from invoice
group by billing_city
order by TotalIn desc;

/* Q5) Who is the best customer? The customer who has spent the most
money will be declared the best customer. Write a query that returns the person
who has spent the most money */
select * from invoice;
select * from customer;
select customer.customer_id, customer.First_name , customer.last_name, sum(invoice.total) as MaxMoney
from customer
join invoice on customer.customer_id = invoice.customer_id
group by customer.customer_id,
customer.First_name,
customer.last_name
order by MaxMoney desc
limit 1;