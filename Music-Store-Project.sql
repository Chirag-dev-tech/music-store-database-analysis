use music_database;
# SET - 1
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

# SET - 2
/* Q1) Write a query to return the email, first_name, last_name & genre of all rock music listeners.
Return your list ordered alphabetically by email starting with A */
select * from genre;
select * from track;
select * from customer;
select * from invoice;
select * from invoice_line;

select distinct email,first_name,last_name, genre.name as genre from customer
join invoice on customer.customer_id = invoice.customer_id
join invoice_line on invoice.invoice_id = invoice_line.invoice_id
join track on track.track_id = invoice_line.track_id
join genre on genre.genre_id = track.genre_id
where invoice_line.track_id in (
select track_id from track
join genre on
track.genre_id = genre.genre_id
where genre.name like 'Rock')
order by email asc;

# OR

select distinct email,first_name,last_name from customer
join invoice on customer.customer_id = invoice.customer_id
join invoice_line on invoice.invoice_id = invoice_line.invoice_id
join track on track.track_id = invoice_line.track_id
where invoice_line.track_id in (
select track_id from track
join genre on
track.genre_id = genre.genre_id
where genre.name like 'Rock')
order by email asc;


/* Q2) Write a query that returns the artist name and total track count of the top 10
rock bands */
select * from artist;
select * from album;
select * from track;

select artist.artist_id, artist.name, count(artist.artist_id) as Total_songs
from artist
join album on artist.artist_id = album.artist_id
join track on album.album_Id = track.album_Id
join genre on Genre.Genre_Id = track.Genre_Id
where genre.name like "Rock"
group by artist.artist_id,
artist.name
order by Total_songs desc
limit 10;

# OR

select artist.artist_id, artist.name, count(artist.artist_id) as TotSongs
from artist
join album on artist.artist_id = album.artist_id
join track on album.album_id = track.album_id
where track.genre_id = 1
group by artist.artist_id, artist.name
order by TotSongs desc
limit 10;

/* Q3) Return all the track names that have a song length longer than the average song length.
Return the name and milliseconds for each track. Order by the song length with the longest songs listed first */
select * from track;

select name, milliseconds from track
where milliseconds > 
(select round(avg(milliseconds)) as AvgLength from track)
order by milliseconds desc;

# SET 3