-- ============================================================
-- HOTEL MANAGEMENT SYSTEM - COMBINED SQL SCRIPT
-- ============================================================

CREATE DATABASE IF NOT EXISTS HotelManagement;
USE HotelManagement;

-- ============================================================
-- SECTION 1: TABLE CREATIONS (DDL)
-- ============================================================

CREATE TABLE Guests (
    GID INT PRIMARY KEY IDENTITY(1,1),
    FName VARCHAR(50) NOT NULL,
    LName VARCHAR(50) NOT NULL,
    Gender VARCHAR(10) CHECK (Gender IN ('Male', 'Female', 'Other')),
    Phone VARCHAR(15) NOT NULL,
    Email VARCHAR(100),
    Address VARCHAR(255),
    ID_Proof VARCHAR(50) -- Stores ID type like 'Passport', 'Driving License', etc.
);

CREATE TABLE RType (
    RTID INT PRIMARY KEY IDENTITY(1,1),
    Type VARCHAR(50) NOT NULL,
    Rate DECIMAL(10, 2) NOT NULL,
    Occupancy INT NOT NULL
);

CREATE TABLE Rooms (
    RID INT PRIMARY KEY IDENTITY(1,1),
    Floor INT NOT NULL,
    RTID INT FOREIGN KEY REFERENCES RType(RTID),
    Status VARCHAR(20) NOT NULL CHECK (Status IN ('Available', 'Occupied', 'Maintenance')),
    Views VARCHAR(50),
    Amenities VARCHAR(256)
);

CREATE TABLE Services (
    SID INT PRIMARY KEY IDENTITY(1,1),
    Sname VARCHAR(50) NOT NULL,
    SCOST DECIMAL(10, 2) NOT NULL
);

CREATE TABLE Staff (
    ID INT PRIMARY KEY IDENTITY(1,1),
    Name VARCHAR(100) NOT NULL,
    Role VARCHAR(50) NOT NULL,
    Shift VARCHAR(20) CHECK (Shift IN ('Morning', 'Afternoon', 'Night')),
    Salary DECIMAL(10, 2) NOT NULL
);

CREATE TABLE Bookings (
    BID INT PRIMARY KEY IDENTITY(1,1),
    GID INT FOREIGN KEY REFERENCES Guests(GID),
    RID INT FOREIGN KEY REFERENCES Rooms(RID),
    SID INT FOREIGN KEY REFERENCES Services(SID),
    CIDATE DATE NOT NULL,
    CODATE DATE NOT NULL,
    ADULTS INT NOT NULL DEFAULT 1,
    CHILDRENS INT NOT NULL DEFAULT 0,
    BSTATUS VARCHAR(20) CHECK (BSTATUS IN ('Confirmed', 'CheckedIn', 'CheckedOut', 'Cancelled')),
    BTHROUGH VARCHAR(10) CHECK (BTHROUGH IN ('ONLINE', 'OFFLINE')),
    CONSTRAINT CHK_Dates CHECK (CODATE >= CIDATE)
);

CREATE TABLE PAYMENT (
    PID INT PRIMARY KEY IDENTITY(1,1),
    BID INT FOREIGN KEY REFERENCES Bookings(BID),
    PDATE DATE NOT NULL,
    PAMOUNT DECIMAL(10, 2) NOT NULL,
    PMETHOD VARCHAR(20) CHECK (PMETHOD IN ('Cash', 'UPI', 'Credit Card', 'Debit Card')),
    PSTATUS VARCHAR(20) CHECK (PSTATUS IN ('Paid', 'Pending', 'Refunded'))
);

CREATE TABLE SUSAGE (
    UID INT PRIMARY KEY IDENTITY(1,1),
    BID INT FOREIGN KEY REFERENCES Bookings(BID),
    SID INT FOREIGN KEY REFERENCES Services(SID),
    QUANTITY INT NOT NULL DEFAULT 1,
    UDATE DATE NOT NULL,
    TAMNT DECIMAL(10,2) 
);

-- ============================================================
-- SECTION 2: DATA INSERTIONS (DML)
-- ============================================================

-- Insert Guests Data
INSERT INTO Guests (FName, LName, Gender, Phone, Email, Address, ID_Proof) VALUES 
('Aarav', 'Sharma', 'Male', '9876543210', 'aarav@gmail.com', 'Delhi, India', 'Passport'),
('Ananya', 'Mishra', 'Female', '8765432109', 'ananya@gmail.com', 'Bhubaneswar, Odisha', 'Driving License'),
('Vivaan', 'Patel', 'Male', '7654321098', 'vivaan@gmail.com', 'Mumbai, Maharashtra', 'Voter ID'),
('Diya', 'Nair', 'Female', '6543210987', 'diya@gmail.com', 'Kochi, Kerala', 'Passport'),
('Reyansh', 'Das', 'Male', '9123456789', 'reyansh@gmail.com', 'Kolkata, WB', 'PAN Card'),
('Saisha', 'Joshi', 'Female', '8234567890', 'saisha@gmail.com', 'Pune, Maharashtra', 'Driving License'),
('Arjun', 'Reddy', 'Male', '7345678901', 'arjun@gmail.com', 'Hyderabad, Telangana', 'Passport'),
('Ira', 'Gupta', 'Female', '6456789012', 'ira@gmail.com', 'Lucknow, UP', 'Voter ID'),
('Krishna', 'Kumar', 'Male', '9567890123', 'krishna@gmail.com', 'Patna, Bihar', 'Driving License'),
('Kavya', 'Singh', 'Female', '8678901234', 'kavya@gmail.com', 'Jaipur, Rajasthan', 'Passport'),
('Rohan', 'Mehta', 'Male', '7789012345', 'rohan@gmail.com', 'Ahmedabad, Gujarat', 'PAN Card'),
('Myra', 'Sen', 'Female', '6890123456', 'myra@gmail.com', 'Bangalore, Karnataka', 'Passport'),
('Kabir', 'Rao', 'Male', '9901234567', 'kabir@gmail.com', 'Chennai, TN', 'Driving License'),
('Prisha', 'Verma', 'Female', '8912345678', 'prisha@gmail.com', 'Indore, MP', 'Voter ID'),
('Shaurya', 'Choudhury', 'Male', '7923456789', 'shaurya@gmail.com', 'Guwahati, Assam', 'Passport'),
('Anika', 'Gill', 'Female', '6934567890', 'anika@gmail.com', 'Chandigarh, Punjab', 'Driving License'),
('Rudransh', 'Bose', 'Male', '9456789012', 'rudransh@gmail.com', 'Kolkata, WB', 'Passport'),
('Saanvi', 'Ray', 'Female', '8567890123', 'saanvi@gmail.com', 'Cuttack, Odisha', 'Voter ID'),
('Ayaan', 'Malik', 'Male', '7678901234', 'ayaan@gmail.com', 'Srinagar, J&K', 'Driving License'),
('Aadhya', 'Panda', 'Female', '6789012345', 'aadhya@gmail.com', 'Berhampur, Odisha', 'Passport'),
('Dev', 'Pradhan', 'Male', '9111222333', 'dev@gmail.com', 'Sambalpur, Odisha', 'PAN Card'),
('Ishani', 'Tripathy', 'Female', '8222333444', 'ishani@gmail.com', 'Puri, Odisha', 'Driving License'),
('Sai', 'Padhy', 'Male', '7333444555', 'sai@gmail.com', 'Berhampur, Odisha', 'Passport'),
('Riya', 'Mohanty', 'Female', '6444555666', 'riya@gmail.com', 'Bhubaneswar, Odisha', 'Voter ID'),
('Aditya', 'Satapathy', 'Male', '9555666777', 'aditya@gmail.com', 'Balasore, Odisha', 'Driving License'),
('Tanvi', 'Acharya', 'Female', '8666777888', 'tanvi@gmail.com', 'Rourkela, Odisha', 'Passport'),
('Om', 'Patra', 'Male', '7777888999', 'om@gmail.com', 'Ganjam, Odisha', 'PAN Card'),
('Diya', 'Behera', 'Female', '6888999000', 'diya.b@gmail.com', 'Cuttack, Odisha', 'Driving License'),
('Ganesh', 'Jena', 'Male', '9999000111', 'ganesh@gmail.com', 'Bhadrak, Odisha', 'Passport'),
('Sneha', 'Dash', 'Female', '8888111222', 'sneha@gmail.com', 'Jajpur, Odisha', 'Voter ID');

-- Insert Room Types Data
INSERT INTO RType (Type, Rate, Occupancy) VALUES 
('Standard', 1500.00, 2), 
('Deluxe', 2500.00, 2), 
('Executive', 4000.00, 3), 
('Family', 5500.00, 5), 
('Suite', 8000.00, 4),
('Standard', 1600.00, 2), 
('Deluxe', 2600.00, 2), 
('Executive', 4200.00, 3), 
('Family', 5800.00, 5), 
('Suite', 8500.00, 4),
('Standard', 1700.00, 2), 
('Deluxe', 2700.00, 2), 
('Executive', 4400.00, 3), 
('Family', 6000.00, 5), 
('Suite', 9000.00, 4),
('Standard', 1550.00, 2), 
('Deluxe', 2550.00, 2), 
('Executive', 4100.00, 3), 
('Family', 5600.00, 5), 
('Suite', 8200.00, 4),
('Standard', 1650.00, 2), 
('Deluxe', 2650.00, 2), 
('Executive', 4300.00, 3), 
('Family', 5900.00, 5), 
('Suite', 8800.00, 4),
('Standard', 1750.00, 2), 
('Deluxe', 2750.00, 2), 
('Executive', 4500.00, 3), 
('Family', 6200.00, 5), 
('Suite', 9500.00, 4);

-- Insert Rooms Data
INSERT INTO Rooms (Floor, RTID, Status, Views, Amenities) VALUES 
(1, 1, 'Available', 'Garden View', 'WiFi, TV, AC'), 
(1, 2, 'Occupied', 'Garden View', 'WiFi, TV, AC, Mini Fridge'),
(1, 3, 'Available', 'City View', 'WiFi, TV, AC, Safe, Geyser'), 
(2, 4, 'Occupied', 'Pool View', 'WiFi, TV, AC, Kitchenette'),
(2, 5, 'Maintenance', 'Sea View', 'WiFi, TV, AC, Bathtub, Jacuzzi'), 
(2, 1, 'Available', 'No View', 'WiFi, TV, Fan'),
(3, 2, 'Occupied', 'City View', 'WiFi, TV, AC'), 
(3, 3, 'Available', 'Sea View', 'WiFi, TV, AC, Coffee Maker'),
(3, 4, 'Occupied', 'Pool View', 'WiFi, TV, AC, Balcony'), 
(4, 5, 'Available', 'Mountain View', 'WiFi, TV, AC, Private Pool'),
(4, 1, 'Available', 'Garden View', 'WiFi, TV, AC'), 
(4, 2, 'Occupied', 'Garden View', 'WiFi, TV, AC, Mini Fridge'),
(5, 3, 'Available', 'City View', 'WiFi, TV, AC, Safe'), 
(5, 4, 'Occupied', 'Pool View', 'WiFi, TV, AC'),
(5, 5, 'Available', 'Sea View', 'WiFi, TV, AC, Bathtub'), 
(1, 6, 'Available', 'Garden View', 'WiFi, TV, AC'),
(1, 7, 'Occupied', 'Garden View', 'WiFi, TV, AC'), 
(2, 8, 'Available', 'City View', 'WiFi, TV, AC'),
(2, 9, 'Occupied', 'Pool View', 'WiFi, TV, AC'), 
(3, 10, 'Available', 'Sea View', 'WiFi, TV, AC'),
(3, 11, 'Available', 'No View', 'WiFi, TV, Fan'), 
(4, 12, 'Occupied', 'City View', 'WiFi, TV, AC'),
(4, 13, 'Available', 'Sea View', 'WiFi, TV, AC'), 
(5, 14, 'Occupied', 'Pool View', 'WiFi, TV, AC'),
(5, 15, 'Available', 'Mountain View', 'WiFi, TV, AC'), 
(1, 16, 'Available', 'Garden View', 'WiFi, TV, AC'),
(2, 17, 'Occupied', 'Garden View', 'WiFi, TV, AC'), 
(3, 18, 'Available', 'City View', 'WiFi, TV, AC'),
(4, 19, 'Occupied', 'Pool View', 'WiFi, TV, AC'), 
(5, 20, 'Available', 'Sea View', 'WiFi, TV, AC');

-- Insert Staff Data
INSERT INTO Staff (Name, Role, Shift, Salary) VALUES 
('Rajesh Kumar', 'Manager', 'Morning', 55000.00), ('Suman Lata', 'Receptionist', 'Morning', 25000.00),
('Anil Biswal', 'Receptionist', 'Afternoon', 25000.00), ('Suresh Dash', 'Receptionist', 'Night', 27000.00),
('Mamata Mohanty', 'Housekeeping', 'Morning', 15000.00), ('Prakash Jena', 'Housekeeping', 'Afternoon', 15000.00),
('Ranjan Patra', 'Housekeeping', 'Night', 16500.00), ('Binod Pradhan', 'Chef', 'Morning', 40000.00),
('Sita Samal', 'Chef', 'Afternoon', 40000.00), ('Lipika Sahu', 'Accountant', 'Morning', 35000.00),
('Deepak Nayak', 'Security', 'Night', 18000.00), ('Pradeep Naik', 'Security', 'Morning', 17000.00),
('Kalyani Rao', 'Spa Therapist', 'Afternoon', 30000.00), ('Subrat Tripathy', 'Bellboy', 'Morning', 14000.00),
('Tusar Behera', 'Bellboy', 'Afternoon', 14000.00), ('Alok Mishra', 'Assistant Manager', 'Afternoon', 45000.00),
('Sunita Sethi', 'Laundry Staff', 'Morning', 13500.00), ('Ramesh Naik', 'Laundry Staff', 'Afternoon', 13500.00),
('Bikram Swain', 'Electrician', 'Morning', 20000.00), ('Jyoti Gouda', 'Kitchen Helper', 'Morning', 12000.00),
('Hari Padhi', 'Gardener', 'Morning', 13000.00), ('Nila Muduli', 'Cleanliness Supervisor', 'Morning', 22000.00),
('Gita Panigrahi', 'Receptionist', 'Morning', 25000.00), ('Santosh Kar', 'Valet Driver', 'Afternoon', 16000.00),
('Manoj Barik', 'Plumber', 'Afternoon', 19000.00), ('Rashmi Panda', 'HR Executive', 'Morning', 38000.00),
('Debasish Sahu', 'IT Support', 'Morning', 32000.00), ('Sarat Khuntia', 'Store Keeper', 'Morning', 21000.00),
('Minati Rout', 'Kitchen Helper', 'Afternoon', 12000.00), ('Kulamani Ojha', 'Carpenter', 'Morning', 19500.00);

-- Insert Bookings Data
INSERT INTO Bookings (GID, RID, SID, CIDATE, CODATE, ADULTS, CHILDRENS, BSTATUS, BTHROUGH) VALUES 
(1, 1, 1, '2026-05-01', '2026-05-03', 2, 0, 'CheckedOut', 'ONLINE'), 
(2, 2, 2, '2026-05-01', '2026-05-05', 2, 1, 'CheckedOut', 'OFFLINE'),
(3, 3, 3, '2026-05-02', '2026-05-04', 1, 0, 'CheckedOut', 'ONLINE'), 
(4, 4, 4, '2026-05-02', '2026-05-06', 2, 2, 'CheckedOut', 'ONLINE'),
(5, 6, 1, '2026-05-03', '2026-05-04', 1, 0, 'CheckedOut', 'OFFLINE'), 
(6, 7, 6, '2026-05-04', '2026-05-07', 2, 0, 'CheckedOut', 'ONLINE'),
(7, 8, 5, '2026-05-05', '2026-05-06', 2, 1, 'CheckedOut', 'ONLINE'), 
(8, 9, 8, '2026-05-05', '2026-05-09', 3, 1, 'CheckedOut', 'OFFLINE'),
(9, 11, 1, '2026-05-10', '2026-05-12', 2, 0, 'CheckedOut', 'ONLINE'), 
(10, 12, 11, '2026-05-11', '2026-05-15', 2, 0, 'CheckedOut', 'ONLINE'),
(11, 13, 12, '2026-05-12', '2026-05-14', 1, 0, 'CheckedOut', 'OFFLINE'), 
(12, 14, 15, '2026-05-12', '2026-05-15', 4, 1, 'CheckedOut', 'ONLINE'),
(13, 16, 1, '2026-05-15', '2026-05-16', 2, 0, 'CheckedOut', 'ONLINE'), 
(14, 17, 3, '2026-05-16', '2026-05-20', 2, 0, 'CheckedOut', 'OFFLINE'),
(15, 18, 2, '2026-05-18', '2026-05-21', 2, 1, 'CheckedOut', 'ONLINE'), 
(16, 19, 4, '2026-05-19', '2026-05-20', 1, 0, 'CheckedOut', 'ONLINE'),
(17, 21, 6, '2026-05-20', '2026-05-23', 2, 0, 'CheckedOut', 'OFFLINE'), 
(18, 22, 1, '2026-05-22', '2026-05-25', 2, 2, 'CheckedOut', 'ONLINE'),
(19, 23, 15, '2026-05-25', '2026-05-26', 3, 0, 'CheckedOut', 'ONLINE'), 
(20, 24, 16, '2026-05-26', '2026-05-29', 2, 0, 'CheckedOut', 'OFFLINE'),
(21, 26, 1, '2026-06-01', '2026-06-03', 2, 0, 'CheckedIn', 'ONLINE'), 
(22, 27, 2, '2026-06-01', '2026-06-04', 2, 1, 'CheckedIn', 'OFFLINE'),
(23, 29, 3, '2026-06-02', '2026-06-05', 1, 0, 'CheckedIn', 'ONLINE'), 
(24, 2, 7, '2026-06-03', '2026-06-07', 2, 0, 'CheckedIn', 'ONLINE'),
(25, 4, 1, '2026-06-04', '2026-06-05', 2, 2, 'CheckedIn', 'OFFLINE'), 
(26, 7, 11, '2026-06-05', '2026-06-08', 2, 0, 'Confirmed', 'ONLINE'),
(27, 9, 14, '2026-06-08', '2026-06-10', 3, 0, 'Confirmed', 'ONLINE'), 
(28, 12, 1, '2026-06-12', '2026-06-14', 2, 0, 'Confirmed', 'OFFLINE'),
(29, 14, 22, '2026-06-15', '2026-06-18', 2, 1, 'Confirmed', 'ONLINE'), 
(30, 17, 1, '2026-06-20', '2026-06-22', 2, 0, 'Cancelled', 'ONLINE');

-- Insert Payment Data
INSERT INTO PAYMENT (BID, PDATE, PAMOUNT, PMETHOD, PSTATUS) VALUES 
(1, '2026-05-03', 3700.00, 'UPI', 'Paid'), 
(2, '2026-05-05', 11200.00, 'Cash', 'Paid'),
(3, '2026-05-04', 9500.00, 'Credit Card', 'Paid'), 
(4, '2026-05-06', 22450.00, 'Debit Card', 'Paid'),
(5, '2026-05-04', 1950.00, 'Cash', 'Paid'), 
(6, '2026-05-07', 8600.00, 'UPI', 'Paid'),
(7, '2026-05-06', 5000.00, 'Credit Card', 'Paid'), 
(8, '2026-05-09', 23200.00, 'Cash', 'Paid'),
(9, '2026-05-12', 3900.00, 'UPI', 'Paid'), 
(10, '2026-05-15', 11400.00, 'Debit Card', 'Paid'),
(11, '2026-05-14', 6200.00, 'Cash', 'Paid'), 
(12, '2026-05-15', 17300.00, 'UPI', 'Paid'),
(13, '2026-05-16', 2300.00, 'Credit Card', 'Paid'), 
(14, '2026-05-20', 13400.00, 'Cash', 'Paid'),
(15, '2026-05-21', 9350.00, 'UPI', 'Paid'), 
(16, '2026-05-20', 1900.00, 'Debit Card', 'Paid'),
(17, '2026-05-23', 8600.00, 'UPI', 'Paid'), 
(18, '2026-05-25', 14300.00, 'Credit Card', 'Paid'),
(19, '2026-05-26', 9300.00, 'Cash', 'Paid'), 
(20, '2026-05-29', 28900.00, 'UPI', 'Paid'),
(21, '2026-06-01', 3700.00, 'UPI', 'Paid'), 
(22, '2026-06-01', 11200.00, 'Cash', 'Pending'),
(23, '2026-06-02', 9500.00, 'Credit Card', 'Paid'), 
(24, '2026-06-03', 8600.00, 'Debit Card', 'Paid'),
(25, '2026-06-04', 22450.00, 'Cash', 'Pending'), 
(26, '2026-06-05', 11400.00, 'UPI', 'Pending'),
(27, '2026-06-08', 5000.00, 'Credit Card', 'Pending'), 
(28, '2026-06-12', 3900.00, 'Cash', 'Pending'),
(29, '2026-06-15', 17300.00, 'UPI', 'Pending'), 
(30, '2026-06-20', 0.00, 'UPI', 'Refunded');

-- Insert Service Usage Data
INSERT INTO SUSAGE (BID, SID, QUANTITY, UDATE, TAMNT) VALUES 
(1, 1, 2, '2026-05-01', 700.00), 
(2, 2, 1, '2026-05-01', 1200.00), 
(3, 3, 1, '2026-05-02', 1500.00),
(4, 4, 3, '2026-05-03', 450.00), 
(5, 1, 1, '2026-05-03', 350.00), 
(6, 6, 1, '2026-05-04', 800.00),
(7, 5, 2, '2026-05-05', 600.00), 
(8, 8, 4, '2026-05-06', 800.00), 
(9, 1, 2, '2026-05-10', 700.00),
(10, 11, 1, '2026-05-11', 1000.00), 
(11, 12, 1, '2026-05-12', 1800.00), 
(12, 15, 1, '2026-05-13', 500.00),
(13, 1, 2, '2026-05-15', 700.00), 
(14, 3, 2, '2026-05-17', 3000.00), 
(15, 2, 1, '2026-05-18', 1200.00),
(16, 4, 2, '2026-05-19', 300.00), 
(17, 6, 1, '2026-05-20', 800.00), 
(18, 1, 4, '2026-05-23', 1400.00),
(19, 15, 1, '2026-05-25', 500.00), 
(20, 16, 1, '2026-05-27', 2500.00), 
(21, 1, 2, '2026-06-01', 700.00),
(22, 2, 1, '2026-06-02', 1200.00), 
(23, 3, 1, '2026-06-02', 1500.00), 
(24, 7, 1, '2026-06-03', 700.00),
(25, 1, 4, '2026-06-04', 1400.00), 
(26, 11, 2, '2026-06-06', 2000.00), 
(27, 14, 1, '2026-06-08', 150.00),
(28, 1, 2, '2026-06-12', 700.00), 
(29, 22, 3, '2026-06-16', 450.00), 
(30, 1, 0, '2026-06-20', 0.00);

-- ============================================================
-- SECTION 3: VERIFICATION QUERIES (DQL)
-- ============================================================

SELECT * FROM Guests;
SELECT * FROM RType;
SELECT * FROM Rooms;
SELECT * FROM Staff;
SELECT * FROM Bookings;
SELECT * FROM Payment;
SELECT * FROM SUSAGE;