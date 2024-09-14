-- Creating the dim_author_sf table
CREATE TABLE dim_author_sf (
    author_id INT PRIMARY KEY,
    author VARCHAR(256)
);

-- Creating the dim_publisher_sf table
CREATE TABLE dim_publisher_sf (
    publisher_id INT PRIMARY KEY,
    publisher VARCHAR(256)
);

-- Creating the dim_genre_sf table
CREATE TABLE dim_genre_sf (
    genre_id INT PRIMARY KEY,
    genre VARCHAR(128)
);

-- Creating the dim_book_sf table
CREATE TABLE dim_book_sf (
    book_id INT PRIMARY KEY,
    title VARCHAR(256),
    author_id INT,
    publisher_id INT,
    genre_id INT,
    FOREIGN KEY (author_id) REFERENCES dim_author_sf(author_id),
    FOREIGN KEY (publisher_id) REFERENCES dim_publisher_sf(publisher_id),
    FOREIGN KEY (genre_id) REFERENCES dim_genre_sf(genre_id)
);


-- Inserting sample data into dim_author_sf
INSERT INTO dim_author_sf (author_id, author)
VALUES
(1, 'J.K. Rowling'),
(2, 'George R.R. Martin'),
(3, 'J.R.R. Tolkien');

-- Inserting sample data into dim_publisher_sf
INSERT INTO dim_publisher_sf (publisher_id, publisher)
VALUES
(1, 'Bloomsbury'),
(2, 'Bantam Books'),
(3, 'HarperCollins');

-- Inserting sample data into dim_genre_sf
INSERT INTO dim_genre_sf (genre_id, genre)
VALUES
(1, 'Fantasy'),
(2, 'Science Fiction'),
(3, 'Historical Fiction');

-- Inserting sample data into dim_book_sf
INSERT INTO dim_book_sf (book_id, title, author_id, publisher_id, genre_id)
VALUES
(1, 'Harry Potter and the Philosophers Stone', 1, 1, 1),
(2, 'A Game of Thrones', 2, 2, 1),
(3, 'The Hobbit', 3, 3, 1);


select * from dim_author_sf;
select * from dim_publisher_sf;
select * from dim_genre_sf;
select * from dim_book_sf;


-- Example Query: Join books with authors and publishers
SELECT b.title, a.author, p.publisher, g.genre
FROM dim_book_sf b
JOIN dim_author_sf a ON b.author_id = a.author_id
JOIN dim_publisher_sf p ON b.publisher_id = p.publisher_id
JOIN dim_genre_sf g ON b.genre_id = g.genre_id;

-- Creating the dim_country_sf table
CREATE TABLE dim_country_sf (
    country_id INT PRIMARY KEY,
    country VARCHAR(128)
);

-- Creating the dim_state_sf table
CREATE TABLE dim_state_sf (
    state_id INT PRIMARY KEY,
    state VARCHAR(128),
    country_id INT,
    FOREIGN KEY (country_id) REFERENCES dim_country_sf(country_id)
);

-- Creating the dim_city_sf table
CREATE TABLE dim_city_sf (
    city_id INT PRIMARY KEY,
    city VARCHAR(128),
    state_id INT,
    FOREIGN KEY (state_id) REFERENCES dim_state_sf(state_id)
);

-- Creating the dim_store_sf table
CREATE TABLE dim_store_sf (
    store_id INT PRIMARY KEY,
    store_address VARCHAR(256),
    city_id INT,
    FOREIGN KEY (city_id) REFERENCES dim_city_sf(city_id)
);

-- Inserting sample data into dim_country_sf
INSERT INTO dim_country_sf (country_id, country)
VALUES
(1, 'United States'),
(2, 'Canada'),
(3, 'Mexico');

-- Inserting sample data into dim_state_sf
INSERT INTO dim_state_sf (state_id, state, country_id)
VALUES
(1, 'California', 1),
(2, 'Texas', 1),
(3, 'Ontario', 2);

-- Inserting sample data into dim_city_sf
INSERT INTO dim_city_sf (city_id, city, state_id)
VALUES
(1, 'Los Angeles', 1),
(2, 'Houston', 2),
(3, 'Toronto', 3);

-- Inserting sample data into dim_store_sf
INSERT INTO dim_store_sf (store_id, store_address, city_id)
VALUES
(1, '123 Main St, Los Angeles, CA', 1),
(2, '456 Broadway, Houston, TX', 2),
(3, '789 Queen St, Toronto, ON', 3);

-- Query to display all data with joins
SELECT s.store_address, c.city, st.state, co.country
FROM dim_store_sf s
JOIN dim_city_sf c ON s.city_id = c.city_id
JOIN dim_state_sf st ON c.state_id = st.state_id
JOIN dim_country_sf co ON st.country_id = co.country_id;

Select * From dim_country_sf;
Select * From dim_state_sf;
Select * From dim_city_sf;
Select * From dim_store_sf;

-- Creating the dim_year_sf table
CREATE TABLE dim_year_sf (
    year_id INT PRIMARY KEY,
    year INT
);

-- Creating the dim_quarter_sf table
CREATE TABLE dim_quarter_sf (
    quarter_id INT PRIMARY KEY,
    quarter INT,
    year_id INT,
    FOREIGN KEY (year_id) REFERENCES dim_year_sf(year_id)
);

-- Creating the dim_month_sf table
CREATE TABLE dim_month_sf (
    month_id INT PRIMARY KEY,
    month INT,
    quarter_id INT,
    FOREIGN KEY (quarter_id) REFERENCES dim_quarter_sf(quarter_id)
);

-- Creating the dim_time_sf table
CREATE TABLE dim_time_sf (
    time_id INT PRIMARY KEY,
    day INT,
    month_id INT,
    FOREIGN KEY (month_id) REFERENCES dim_month_sf(month_id)
);

-- Inserting sample data into dim_year_sf
INSERT INTO dim_year_sf (year_id, year)
VALUES
(1, 2023),
(2, 2024);

-- Inserting sample data into dim_quarter_sf
INSERT INTO dim_quarter_sf (quarter_id, quarter, year_id)
VALUES
(1, 1, 1),
(2, 2, 1),
(3, 3, 1),
(4, 4, 1),
(5, 1, 2),
(6, 2, 2),
(7, 3, 2),
(8, 4, 2);

-- Inserting sample data into dim_month_sf
INSERT INTO dim_month_sf (month_id, month, quarter_id)
VALUES
(1, 1, 1),
(2, 2, 1),
(3, 3, 1),
(4, 4, 2),
(5, 5, 2),
(6, 6, 2),
(7, 7, 3),
(8, 8, 3),
(9, 9, 3),
(10, 10, 4),
(11, 11, 4),
(12, 12, 4);

-- Inserting sample data into dim_time_sf
INSERT INTO dim_time_sf (time_id, day, month_id)
VALUES
(1, 1, 1),
(2, 2, 1),
(3, 3, 1),
(4, 4, 2),
(5, 5, 2),
(6, 6, 2),
(7, 7, 3),
(8, 8, 3),
(9, 9, 3),
(10, 10, 4),
(11, 11, 4),
(12, 12, 4);

-- Query to display all data with joins
SELECT t.time_id, t.day, m.month, q.quarter, y.year
FROM dim_time_sf t
JOIN dim_month_sf m ON t.month_id = m.month_id
JOIN dim_quarter_sf q ON m.quarter_id = q.quarter_id
JOIN dim_year_sf y ON q.year_id = y.year_id;

SELECT * FROM dim_year_sf;
SELECT * FROM dim_quarter_sf;
SELECT * FROM dim_month_sf;
SELECT * FROM dim_time_sf;