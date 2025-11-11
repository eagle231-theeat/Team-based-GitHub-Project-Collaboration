CREATE DATABASE HotelManagement;
USE HotelManagement;

CREATE TABLE Hotel (
    hotel_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    address VARCHAR(255),
    city VARCHAR(100),
    country VARCHAR(100),
    phone VARCHAR(20)
);

CREATE TABLE Room (
    room_id INT PRIMARY KEY AUTO_INCREMENT,
    hotel_id INT NOT NULL,
    room_number VARCHAR(10) NOT NULL,
    room_type VARCHAR(50),
    price_per_night DECIMAL(10,2),
    is_available BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (hotel_id) REFERENCES Hotel(hotel_id)
);

CREATE TABLE Customer (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(20),
    address VARCHAR(255)
);

CREATE TABLE Booking (
    booking_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    room_id INT NOT NULL,
    check_in_date DATE NOT NULL,
    check_out_date DATE NOT NULL,
    total_amount DECIMAL(10,2),
    booking_status VARCHAR(20) DEFAULT 'Confirmed',
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),
    FOREIGN KEY (room_id) REFERENCES Room(room_id)
);

CREATE TABLE Payment (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    booking_id INT NOT NULL,
    payment_date DATE NOT NULL,
    amount_paid DECIMAL(10,2),
    payment_method VARCHAR(50),
    FOREIGN KEY (booking_id) REFERENCES Booking(booking_id)
);

CREATE TABLE Staff (
    staff_id INT PRIMARY KEY AUTO_INCREMENT,
    hotel_id INT NOT NULL,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    position VARCHAR(50),
    salary DECIMAL(10,2),
    FOREIGN KEY (hotel_id) REFERENCES Hotel(hotel_id)
);

CREATE TABLE Service (
    service_id INT PRIMARY KEY AUTO_INCREMENT,
    service_name VARCHAR(100),
    price DECIMAL(10,2)
);

CREATE TABLE ServiceUsage (
    usage_id INT PRIMARY KEY AUTO_INCREMENT,
    booking_id INT NOT NULL,
    service_id INT NOT NULL,
    usage_date DATE NOT NULL,
    quantity INT DEFAULT 1,
    total_cost DECIMAL(10,2),
    FOREIGN KEY (booking_id) REFERENCES Booking(booking_id),
    FOREIGN KEY (service_id) REFERENCES Service(service_id)
);

INSERT INTO Hotel (name, address, city, country, phone)
VALUES 
('Ocean View Resort', '123 Beach Rd', 'Miami', 'USA', '+1-305-555-9000'),
('Mountain Escape Hotel', '99 Hilltop Ave', 'Aspen', 'USA', '+1-970-555-1000');

INSERT INTO Room (hotel_id, room_number, room_type, price_per_night, is_available)
VALUES
(1, '101', 'Single', 120.00, TRUE),
(1, '102', 'Double', 200.00, TRUE),
(2, '201', 'Suite', 350.00, TRUE);

INSERT INTO Customer (first_name, last_name, email, phone, address)
VALUES
('John', 'Doe', 'john@example.com', '+1-555-1111', '12 Main St'),
('Sara', 'Smith', 'sara@example.com', '+1-555-2222', '99 Pine Rd');

INSERT INTO Booking (customer_id, room_id, check_in_date, check_out_date, total_amount)
VALUES
(1, 1, '2025-11-15', '2025-11-17', 240.00),
(2, 3, '2025-12-01', '2025-12-05', 1400.00);

INSERT INTO Payment (booking_id, payment_date, amount_paid, payment_method)
VALUES
(1, '2025-11-10', 240.00, 'Credit Card'),
(2, '2025-11-11', 1400.00, 'Online');

INSERT INTO Service (service_name, price)
VALUES
('Room Cleaning', 25.00),
('Laundry', 15.00),
('Spa', 60.00);

INSERT INTO ServiceUsage (booking_id, service_id, usage_date, quantity, total_cost)
VALUES
(1, 1, '2025-11-16', 1, 25.00),
(2, 3, '2025-12-02', 1, 60.00);

INSERT INTO Staff (hotel_id, first_name, last_name, position, salary)
VALUES
(1, 'Emma', 'Johnson', 'Manager', 4500.00),
(1, 'Michael', 'Brown', 'Receptionist', 2800.00),
(2, 'Linda', 'Davis', 'Housekeeper', 2200.00);

SELECT b.booking_id, c.first_name, c.last_name, r.room_number, r.room_type, b.check_in_date, b.check_out_date, b.total_amount
FROM Booking b
JOIN Customer c ON b.customer_id = c.customer_id
JOIN Room r ON b.room_id = r.room_id;

SELECT b.booking_id, SUM(su.total_cost) AS total_service_cost
FROM Booking b
JOIN ServiceUsage su ON b.booking_id = su.booking_id
GROUP BY b.booking_id;

SELECT * FROM Room WHERE is_available = TRUE;
