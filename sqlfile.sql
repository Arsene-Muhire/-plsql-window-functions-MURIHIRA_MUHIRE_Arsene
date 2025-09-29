CREATE TABLE passengers (
    passenger_id NUMBER PRIMARY KEY,
    full_name VARCHAR2(100) NOT NULL,
    email VARCHAR2(100) UNIQUE NOT NULL,
    phone VARCHAR2(20),
    nationality VARCHAR2(50),
    date_of_birth DATE,
    registration_date DATE DEFAULT SYSDATE
);

-- Insert 5 sample passengers
INSERT INTO passengers VALUES (1001, 'Jane Mukamana', 'jane.m@email.com', '+250788123456', 'Rwanda', DATE '1985-03-15', DATE '2023-01-10');
INSERT INTO passengers VALUES (1002, 'David Ochieng', 'david.o@email.com', '+254722334455', 'Kenya', DATE '1990-07-22', DATE '2023-02-15');
INSERT INTO passengers VALUES (1003, 'Sarah Nakato', 'sarah.n@email.com', '+256777889900', 'Uganda', DATE '1988-11-30', DATE '2023-03-20');
INSERT INTO passengers VALUES (1004, 'Mohamed Hassan', 'mohamed.h@email.com', '+255655112233', 'Tanzania', DATE '1982-05-18', DATE '2023-04-05');
INSERT INTO passengers VALUES (1005, 'Grace Uwase', 'grace.u@email.com', '+250788234567', 'Rwanda', DATE '1995-09-12', DATE '2023-05-10');

COMMIT;

-- ============================================================================
-- TABLE 2: AIRCRAFT
-- Purpose: Store aircraft fleet information
-- ============================================================================

CREATE TABLE aircraft (
    aircraft_id NUMBER PRIMARY KEY,
    aircraft_type VARCHAR2(50) NOT NULL,
    registration_number VARCHAR2(20) UNIQUE NOT NULL,
    manufacturer VARCHAR2(50),
    total_seats NUMBER NOT NULL,
    business_class_seats NUMBER,
    economy_class_seats NUMBER,
    manufacturing_year NUMBER(4),
    last_maintenance_date DATE
);

-- Insert 5 sample aircraft
INSERT INTO aircraft VALUES (5001, 'Boeing 737-800', '9XR-WA', 'Boeing', 180, 20, 160, 2018, DATE '2024-08-15');
INSERT INTO aircraft VALUES (5002, 'Airbus A320', '9XR-WB', 'Airbus', 150, 16, 134, 2019, DATE '2024-09-01');
INSERT INTO aircraft VALUES (5003, 'Boeing 787 Dreamliner', '9XR-WC', 'Boeing', 250, 30, 220, 2020, DATE '2024-08-20');
INSERT INTO aircraft VALUES (5004, 'Embraer E190', '9XR-WD', 'Embraer', 100, 12, 88, 2017, DATE '2024-09-10');
INSERT INTO aircraft VALUES (5005, 'Airbus A330', '9XR-WE', 'Airbus', 300, 40, 260, 2021, DATE '2024-09-05');

COMMIT;

-- ============================================================================
-- TABLE 3: ROUTES
-- Purpose: Define flight routes and pricing
-- ============================================================================

CREATE TABLE routes (
    route_id NUMBER PRIMARY KEY,
    origin_city VARCHAR2(50) NOT NULL,
    destination_city VARCHAR2(50) NOT NULL,
    region VARCHAR2(50) NOT NULL,
    distance_km NUMBER NOT NULL,
    base_price NUMBER(10,2) NOT NULL
);

-- Insert 5 sample routes
INSERT INTO routes VALUES (2001, 'Kigali', 'Nairobi', 'East Africa', 850, 180000);
INSERT INTO routes VALUES (2002, 'Kigali', 'Dar es Salaam', 'East Africa', 1200, 250000);
INSERT INTO routes VALUES (2003, 'Kigali', 'Entebbe', 'East Africa', 380, 120000);
INSERT INTO routes VALUES (2004, 'Nairobi', 'Dar es Salaam', 'East Africa', 680, 160000);
INSERT INTO routes VALUES (2005, 'Entebbe', 'Nairobi', 'East Africa', 620, 150000);

COMMIT;

-- ============================================================================
-- TABLE 4: FLIGHTS
-- Purpose: Schedule and flight operations
-- ============================================================================

CREATE TABLE flights (
    flight_id NUMBER PRIMARY KEY,
    route_id NUMBER NOT NULL,
    aircraft_id NUMBER NOT NULL,
    flight_number VARCHAR2(10) NOT NULL,
    flight_date DATE NOT NULL,
    departure_time TIMESTAMP NOT NULL,
    arrival_time TIMESTAMP NOT NULL,
    flight_status VARCHAR2(20) DEFAULT 'Scheduled',
    CONSTRAINT fk_flights_route FOREIGN KEY (route_id) REFERENCES routes(route_id),
    CONSTRAINT fk_flights_aircraft FOREIGN KEY (aircraft_id) REFERENCES aircraft(aircraft_id)
);

-- Insert 5 sample flights
INSERT INTO flights VALUES (3001, 2001, 5001, 'SC101', DATE '2024-09-15', 
    TIMESTAMP '2024-09-15 08:00:00', TIMESTAMP '2024-09-15 10:30:00', 'Completed');
    
INSERT INTO flights VALUES (3002, 2002, 5003, 'SC102', DATE '2024-09-16', 
    TIMESTAMP '2024-09-16 14:00:00', TIMESTAMP '2024-09-16 17:00:00', 'Completed');
    
INSERT INTO flights VALUES (3003, 2003, 5002, 'SC103', DATE '2024-09-17', 
    TIMESTAMP '2024-09-17 10:30:00', TIMESTAMP '2024-09-17 12:00:00', 'Completed');
    
INSERT INTO flights VALUES (3004, 2004, 5004, 'SC104', DATE '2024-09-18', 
    TIMESTAMP '2024-09-18 15:30:00', TIMESTAMP '2024-09-18 17:45:00', 'Completed');
    
INSERT INTO flights VALUES (3005, 2005, 5005, 'SC105', DATE '2024-09-19', 
    TIMESTAMP '2024-09-19 09:00:00', TIMESTAMP '2024-09-19 11:15:00', 'Scheduled');

COMMIT;

-- ============================================================================
-- TABLE 5: BOOKINGS
-- Purpose: Track passenger reservations and revenue
-- ============================================================================

CREATE TABLE bookings (
    booking_id NUMBER PRIMARY KEY,
    passenger_id NUMBER NOT NULL,
    flight_id NUMBER NOT NULL,
    booking_date DATE NOT NULL,
    ticket_price NUMBER(10,2) NOT NULL,
    seat_number VARCHAR2(10),
    seat_class VARCHAR2(20) NOT NULL,
    booking_status VARCHAR2(20) DEFAULT 'Confirmed',
    payment_method VARCHAR2(30),
    CONSTRAINT fk_bookings_passenger FOREIGN KEY (passenger_id) REFERENCES passengers(passenger_id),
    CONSTRAINT fk_bookings_flight FOREIGN KEY (flight_id) REFERENCES flights(flight_id)
);

-- Insert 5 sample bookings
INSERT INTO bookings VALUES (4001, 1001, 3001, DATE '2024-09-10', 180000, '12A', 'Economy', 'Confirmed', 'Credit Card');
INSERT INTO bookings VALUES (4002, 1002, 3002, DATE '2024-09-11', 280000, '2B', 'Business', 'Confirmed', 'Mobile Money');
INSERT INTO bookings VALUES (4003, 1003, 3003, DATE '2024-09-12', 120000, '15C', 'Economy', 'Confirmed', 'Bank Transfer');
INSERT INTO bookings VALUES (4004, 1004, 3004, DATE '2024-09-13', 170000, '8A', 'Economy', 'Confirmed', 'Credit Card');
INSERT INTO bookings VALUES (4005, 1005, 3005, DATE '2024-09-14', 200000, '5D', 'Business', 'Confirmed', 'Cash');



- Query 1.1: RANK() - Top 5 routes by revenue per region
SELECT 
    r.route_id,
    r.origin_city,
    r.destination_city,
    r.region,
    SUM(b.ticket_price) as total_revenue,
    RANK() OVER (PARTITION BY r.region ORDER BY SUM(b.ticket_price) DESC) as revenue_rank
FROM routes r
JOIN flights f ON r.route_id = f.route_id
JOIN bookings b ON f.flight_id = b.flight_id
WHERE b.booking_status = 'Confirmed'
GROUP BY r.route_id, r.origin_city, r.destination_city, r.region
ORDER BY r.region, revenue_rank;

/* Interpretation:
   This query ranks routes by total revenue within each region using RANK().
   It identifies the top-performing routes per region, helping management allocate
   resources to high-revenue routes and optimize scheduling decisions.
*/


-- Query 1.2: DENSE_RANK() - Rank passengers by spending
SELECT 
    p.passenger_id,
    p.full_name,
    SUM(b.ticket_price) as total_spent,
    DENSE_RANK() OVER (ORDER BY SUM(b.ticket_price) DESC) as spending_rank
FROM passengers p
JOIN bookings b ON p.passenger_id = b.passenger_id
WHERE b.booking_status = 'Confirmed'
GROUP BY p.passenger_id, p.full_name
ORDER BY spending_rank;

/* Interpretation:
   DENSE_RANK() assigns consecutive ranks without gaps, ideal for loyalty tier assignment.
   High-spending passengers are identified for VIP treatment and targeted promotions.
*/


-- ============================================================================
-- CATEGORY 2: AGGREGATE WINDOW FUNCTIONS (1 point)
-- Use Case: Running totals & trends (ROWS vs RANGE comparison)
-- ============================================================================

-- Query 2.1: Running Total Revenue with SUM() OVER()
SELECT 
    b.booking_date,
    b.booking_id,
    b.ticket_price,
    SUM(b.ticket_price) OVER (ORDER BY b.booking_date, b.booking_id 
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) as running_total
FROM bookings b
WHERE b.booking_status = 'Confirmed'
ORDER BY b.booking_date, b.booking_id;

/* Interpretation:
   This calculates cumulative revenue over time, showing how total revenue grows
   with each booking. Management can track progress toward revenue targets and
   identify periods of accelerated or slowed booking activity.
*/


-- Query 2.2: Moving Average - 3-booking window
SELECT 
    b.booking_date,
    b.ticket_price,
    AVG(b.ticket_price) OVER (ORDER BY b.booking_date 
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) as moving_avg_3bookings
FROM bookings b
WHERE b.booking_status = 'Confirmed'
ORDER BY b.booking_date;

/* Interpretation:
   The 3-booking moving average smooths price fluctuations to reveal underlying trends.
   This helps forecast demand and adjust pricing strategies based on recent patterns.
*/


-- ============================================================================
-- CATEGORY 3: NAVIGATION FUNCTIONS (1 point)
-- Use Case: Period-to-period analysis (Month-over-month growth)
-- ============================================================================

-- Query 3.1: LAG() - Calculate booking-over-booking growth percentage
SELECT 
    b.booking_date,
    b.booking_id,
    b.ticket_price,
    LAG(b.ticket_price, 1) OVER (ORDER BY b.booking_date) as previous_price,
    b.ticket_price - LAG(b.ticket_price, 1) OVER (ORDER BY b.booking_date) as price_change,
    ROUND(((b.ticket_price - LAG(b.ticket_price, 1) OVER (ORDER BY b.booking_date)) / 
        NULLIF(LAG(b.ticket_price, 1) OVER (ORDER BY b.booking_date), 0)) * 100, 2) as growth_percentage
FROM bookings b
WHERE b.booking_status = 'Confirmed'
ORDER BY b.booking_date;

/* Interpretation:
   LAG() retrieves the previous booking's price, enabling period-over-period comparison.
   The growth percentage shows pricing trends and helps identify opportunities for
   dynamic pricing adjustments to maximize revenue.
*/


-- Query 3.2: LEAD() - Compare current booking with next booking
SELECT 
    b.booking_date,
    b.ticket_price,
    LEAD(b.ticket_price, 1) OVER (ORDER BY b.booking_date) as next_price,
    LEAD(b.ticket_price, 1) OVER (ORDER BY b.booking_date) - b.ticket_price as price_diff_to_next
FROM bookings b
WHERE b.booking_status = 'Confirmed'
ORDER BY b.booking_date;

/* Interpretation:
   LEAD() looks forward to the next booking's price, useful for forecasting and
   understanding if prices are trending upward or downward in upcoming bookings.
*/


-- ============================================================================
-- CATEGORY 4: DISTRIBUTION FUNCTIONS (1 point)
-- Use Case: Customer segmentation (NTILE for quartiles)
-- ============================================================================

-- Query 4.1: NTILE(4) - Segment passengers into 4 quartiles
SELECT 
    p.passenger_id,
    p.full_name,
    SUM(b.ticket_price) as total_spent,
    NTILE(4) OVER (ORDER BY SUM(b.ticket_price) DESC) as customer_quartile,
    CASE NTILE(4) OVER (ORDER BY SUM(b.ticket_price) DESC)
        WHEN 1 THEN 'Platinum - Top 25%'
        WHEN 2 THEN 'Gold - 50-75%'
        WHEN 3 THEN 'Silver - 25-50%'
        WHEN 4 THEN 'Bronze - Bottom 25%'
    END as loyalty_tier
FROM passengers p
JOIN bookings b ON p.passenger_id = b.passenger_id
WHERE b.booking_status = 'Confirmed'
GROUP BY p.passenger_id, p.full_name
ORDER BY total_spent DESC;

/* Interpretation:
   NTILE(4) divides passengers into four equal groups based on spending levels.
   This enables targeted marketing campaigns and loyalty benefits for different
   customer segments, improving retention and lifetime value.
*/
SELECT 
    b.booking_id,
    p.full_name,
    b.booking_date,
    b.ticket_price,
    b.seat_class,
    ROW_NUMBER() OVER (PARTITION BY p.passenger_id ORDER BY b.booking_date) as booking_sequence
FROM bookings b
JOIN passengers p ON b.passenger_id = p.passenger_id
ORDER BY p.full_name, b.booking_date;

/* Interpretation: 
   This query assigns a unique sequential number to each booking made by a passenger.
   ROW_NUMBER() guarantees no duplicate ranks, making it perfect for tracking the exact
   order of bookings. This helps identify first-time vs repeat customers.
*/


-- Query 1.2: RANK() - Rank routes by total revenue (with gaps for ties)
-- Use Case: Top performing routes analysis
SELECT 
    r.route_id,
    r.origin_city,
    r.destination_city,
    r.region,
    SUM(b.ticket_price) as total_revenue,
    RANK() OVER (ORDER BY SUM(b.ticket_price) DESC) as revenue_rank
FROM routes r
JOIN flights f ON r.route_id = f.route_id
JOIN bookings b ON f.flight_id = b.flight_id
WHERE b.booking_status = 'Confirmed'
GROUP BY r.route_id, r.origin_city, r.destination_city, r.region
ORDER BY revenue_rank;

/* Interpretation:
   RANK() assigns the same rank to routes with identical revenue and skips subsequent ranks.
   For example, if two routes tie for rank 1, the next route gets rank 3 (not 2).
   This is useful for identifying true top performers while acknowledging ties.
*/


-- Query 1.3: DENSE_RANK() - Rank passengers by total spending (no gaps)
-- Use Case: Loyalty program tier assignment
SELECT 
    p.passenger_id,
    p.full_name,
    SUM(b.ticket_price) as total_spent,
    DENSE_RANK() OVER (ORDER BY SUM(b.ticket_price) DESC) as spending_tier
FROM passengers p
JOIN bookings b ON p.passenger_id = b.passenger_id
WHERE b.booking_status = 'Confirmed'
GROUP BY p.passenger_id, p.full_name
ORDER BY spending_tier;

/* Interpretation:
   Unlike RANK(), DENSE_RANK() maintains consecutive ranking numbers even with ties.
   If two passengers tie for rank 1, the next passenger gets rank 2.
   This is ideal for loyalty tiers (Platinum, Gold, Silver) where we want continuous levels.
*/


-- Query 1.4: PERCENT_RANK() - Calculate percentile ranking of ticket prices
-- Use Case: Price positioning analysis
SELECT 
    b.booking_id,
    f.flight_number,
    b.ticket_price,
    b.seat_class,
    PERCENT_RANK() OVER (ORDER BY b.ticket_price) as price_percentile,
    CASE 
        WHEN PERCENT_RANK() OVER (ORDER BY b.ticket_price) >= 0.75 THEN 'Premium (Top 25%)'
        WHEN PERCENT_RANK() OVER (ORDER BY b.ticket_price) >= 0.50 THEN 'Above Average'
        WHEN PERCENT_RANK() OVER (ORDER BY b.ticket_price) >= 0.25 THEN 'Below Average'
        ELSE 'Budget (Bottom 25%)'
    END as price_category
FROM bookings b
JOIN flights f ON b.flight_id = f.flight_id
ORDER BY b.ticket_price DESC;

/* Interpretation:
   PERCENT_RANK() returns values from 0 to 1, showing relative position in the dataset.
   A value of 0.75 means 75% of prices are lower. This helps categorize bookings
   into price segments for targeted marketing strategies.
*/


-- ============================================================================
-- CATEGORY 2: AGGREGATE WINDOW FUNCTIONS (1 point)
-- Functions: SUM(), AVG(), MIN(), MAX() with ROWS vs RANGE
-- ============================================================================

-- Query 2.1: Running Total Revenue using SUM() with ROWS
-- Use Case: Cumulative revenue tracking over time
SELECT 
    b.booking_date,
    b.booking_id,
    b.ticket_price,
    SUM(b.ticket_price) OVER (ORDER BY b.booking_date, b.booking_id 
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) as running_total_rows,
    SUM(b.ticket_price) OVER (ORDER BY b.booking_date, b.booking_id 
        RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) as running_total_range
FROM bookings b
WHERE b.booking_status = 'Confirmed'
ORDER BY b.booking_date, b.booking_id;

/* Interpretation:
   ROWS counts physical rows while RANGE considers logical values.
   With ROWS, each row adds to the running total sequentially.
   With RANGE, all rows with the same ORDER BY value are included together.
   This query shows daily cumulative revenue for cash flow monitoring.
*/


-- Query 2.2: Moving Average Revenue (3-booking window)
-- Use Case: Revenue trend smoothing
SELECT 
    b.booking_date,
    b.booking_id,
    b.ticket_price,
    AVG(b.ticket_price) OVER (ORDER BY b.booking_date, b.booking_id 
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) as moving_avg_3bookings,
    MIN(b.ticket_price) OVER (ORDER BY b.booking_date, b.booking_id 
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) as min_in_window,
    MAX(b.ticket_price) OVER (ORDER BY b.booking_date, b.booking_id 
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) as max_in_window
FROM bookings b
WHERE b.booking_status = 'Confirmed'
ORDER BY b.booking_date, b.booking_id;





