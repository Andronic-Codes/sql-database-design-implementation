--CREATE CODE

SALES
CREATE TABLE Sales (
    SaleID INT AUTO_INCREMENT PRIMARY KEY,
    OrderID VARCHAR(20),
    SaleDate DATE DEFAULT CURRENT_DATE,
    Total_Amount DECIMAL(10, 2),
    PaymentMethod VARCHAR(20) CHECK (PaymentMethod IN ('Credit Card', 'PayPal', 'Cash')),
    PaymentStatus VARCHAR(20) DEFAULT 'Pending' CHECK (PaymentStatus IN ('Approved', 'Pending', 'Cancelled')),
    INDEX (SaleDate),
    INDEX (TotalAmount),
    INDEX (PaymentMethod),
    INDEX (PaymentStatus),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);


--SHIPPING
CREATE TABLE Shipping (
    ShippingID VARCHAR(20) PRIMARY KEY,
    MemberID INT,
    ShippingAddress VARCHAR(255),
    Delivery_City VARCHAR(100),
    Delivery_Country VARCHAR(100),
    OrderID VARCHAR(20),
    PostalCode VARCHAR(20),
    ShippingDate VARCHAR(20),
    DeliveryDate VARCHAR(20),
    Delivery_Firm VARCHAR(100) CHECK (Delivery_Firm IN ('Amazon', 'Argus', 'Currys', 'Other')),
    License_Plate VARCHAR(20),
    Shipping_Status VARCHAR(30) CHECK (Shipping_Status IN ('Pending','Cancelled','Shipped')),
    Total_Amount DECIMAL(10, 2),
    INDEX (ShippingAddress),
    INDEX (Delivery_Country),
    INDEX (ShippingDate),
    INDEX (DeliveryDate),
    INDEX (Delivery_Firm),
    INDEX (Shipping_Status),
    INDEX (Total_Amount),
    FOREIGN KEY (MemberID) REFERENCES Members(MemberID),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);



--ORDERS
CREATE TABLE Orders (
    OrderID VARCHAR(20) PRIMARY KEY,
    MemberID INT,
    OrderDate DATE DEFAULT CURRENT_DATE,
    Total_Amount DECIMAL(10, 2),
    INDEX (OrderDate),
    INDEX (Total_Amount),
    FOREIGN KEY (MemberID) REFERENCES Members(MemberID)
);



--ORDERSINFO
CREATE TABLE OrdersInfo (
    OrderInfoID VARCHAR(20) PRIMARY KEY,
    OrderID VARCHAR(20),
    ItemID VARCHAR(20),
    Quantity INT DEFAULT 1,
    Item_Price DECIMAL(10, 2),
    OrderInfoTotal DECIMAL(10, 2),
    INDEX (Quantity),
    INDEX (Item_Price),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ItemID) REFERENCES Electronic_Items(ItemID)
);




--MEMBERS
CREATE TABLE Members (
    MemberID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100) UNIQUE,
    Password VARCHAR(200),
    Address VARCHAR(100),
    Phone VARCHAR(20),
    MemberType VARCHAR(10) CHECK (MemberType IN ('Seller', 'Buyer')),
    DateJoined DATE DEFAULT CURRENT_DATE,
    Total_Profit_Made DECIMAL(10, 2) DEFAULT 0.00,
    Total_Spent_Amount DECIMAL(10, 2) DEFAULT 0.00,
    Total_Orders INT,
    Country VARCHAR(50),
    City VARCHAR(50),
    RecoveryPIN INT,
    INDEX (Name),
    INDEX (Email),
    INDEX (Password),
    INDEX (Address),
    INDEX (Phone),
    INDEX (Total_Profit_Made),
    INDEX (Total_Spent_Amount),
    INDEX (Country),
    INDEX (RecoveryPIN)
);
--BUYERS
CREATE TABLE Buyers (
    MemberID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100),
    MemberType VARCHAR(10) CHECK (MemberType IN ('Buyer')),
    Country VARCHAR(50),
    City VARCHAR(50),
    Total_Spent_Amount DECIMAL(10, 2) DEFAULT 0.00,
    Total_Orders INT,
    INDEX (Name),
    INDEX (Country),
    INDEX (Total_Spent_Amount),
    FOREIGN KEY (MemberID) REFERENCES Members(MemberID)
);


--SELLERS
CREATE TABLE Sellers (
    MemberID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100),
    MemberType VARCHAR(10) CHECK (MemberType IN ('Seller')),
    Country VARCHAR(50),
    City VARCHAR(50),
    Total_Profit_Made DECIMAL(10, 2) DEFAULT 0.00,
    INDEX (Name),
    INDEX (Country),
    INDEX (Total_Profit_Made),
    FOREIGN KEY (MemberID) REFERENCES Members(MemberID)
);

--ELECTRONIC
CREATE TABLE Electronic_Items (
    ItemID VARCHAR(20) PRIMARY KEY,
    MemberID INT,
    Item_Name VARCHAR(100),
    Color VARCHAR(10),
    Brand VARCHAR(20),
    Model VARCHAR(20),
    Item_Condition VARCHAR(20) DEFAULT 'Used' CHECK (Item_Condition IN ('New', 'Used', 'Poor')),    
Description VARCHAR(100),
    Item_Price DECIMAL(6, 2),
    Item_Type VARCHAR(30) CHECK (Item_Type IN ('Gadget', 'Accessory')),
    Stock_Count INT DEFAULT 0,
    Total_Quantity_Sold INT DEFAULT 0,
    YearOfManufacturing INT,
    Specification VARCHAR(100),
    Name VARCHAR(100),
    BatteryLife VARCHAR(50),
    OperatingSystem VARCHAR(100),
    Processor VARCHAR(100),
    CompatibleDevices VARCHAR(200),
    Material VARCHAR(100),
    INDEX (Item_Name),
    INDEX (Item_Condition),
    INDEX (Item_Price),
    INDEX (Stock_Count),
    INDEX (Total_Quantity_Sold),
    INDEX (Name),
    FOREIGN KEY (MemberID) REFERENCES Members(MemberID)
);

--ACCESORIES
CREATE TABLE Accessories (
    ItemID VARCHAR(20) PRIMARY KEY,
    CompatibleDevices VARCHAR(200),
    Material VARCHAR(100),
    FOREIGN KEY (ItemID) REFERENCES Electronic_Items(ItemID)
);



--GADGETS
CREATE TABLE Gadgets (
    ItemID VARCHAR(20) PRIMARY KEY,
    BatteryLife VARCHAR(50),
    OperatingSystem VARCHAR(100),
    Processor VARCHAR(100),
    FOREIGN KEY (ItemID) REFERENCES Electronic_Items(ItemID)
);


--INSERT CODE

--Members
INSERT INTO Members (MemberID, Name, Email, Password, Address, Phone, MemberType, DateJoined, Total_Profit_Made, Total_Spent_Amount, Total_Orders, Country, City, RecoveryPIN)
VALUES
(1, 'Alice Dubois', 'alice.dubois@yahoo.com', 'Abc12', '9 Rue de la Paix', '7123456789', 'Seller', '2023-05-12', 7199.93, 0, 0, 'France', 'Paris', 524891),
(2, 'Bob Brown', 'bob.brown@gmail.com', 'XyZ34', '15 Oxford Street', '7234567890', 'Seller', '2023-06-15', 3199.96, 0, 0, 'UK', 'London', 356712),
(3, 'Carlos García', 'carlos.garcia@yahoo.com', 'Lmn56', '27 Calle de la Princesa', '7345678901', 'Seller', '2023-07-20', 7629.92, 0, 0, 'Spain', 'Madrid', 918273),
(4, 'David Schmidt', 'david.schmidt@gmail.com', 'Pqr78', '6 Unter den Linden', '7456789012', 'Seller', '2023-08-18', 1149.95, 0, 0, 'Germany', 'Berlin', 437829),
(5, 'Lucas Martin', 'lucas.martin@yahoo.com', 'StUv9', '14 Avenue des Champs-Élysées', '7567890123', 'Seller', '2023-09-10', 1449.89, 0, 0, 'France', 'Paris', 649281),
(6, 'Fiona Smith', 'fiona.smith@yahoo.com', 'ZzYy6', '3 High Street', '7678901234', 'Seller', '2024-03-18', 679.94, 0, 0, 'UK', 'Leeds', 567812),
(7, 'Harry Walker', 'harry.walker@gmail.com', 'QwEr1', '16 Oxford Street', '7789012345', 'Seller', '2023-10-05', 1119.93, 0, 0, 'UK', 'London', 182736),
(8, 'Grace González', 'grace.gonzalez@yahoo.com', 'RtY2u', '8 La Rambla', '7890123456', 'Buyer', '2023-11-03', 0, 8899.91, 3, 'Spain', 'Barcelona', 573819),
(9, 'Isabella Green', 'isabella.green@yahoo.com', 'VvWw8', '7 Reeperbahn', '7901234567', 'Buyer', '2024-05-30', 0, 0, 0, 'Germany', 'Hamburg', 475829),
(10, 'Heinrich Müller', 'heinrich.mueller@gmail.com', 'UiOp3', '5 Unter den Linden', '7890123456', 'Buyer', '2023-12-22', 0, 0, 0, 'Germany', 'Berlin', 295847),
(11, 'Nathan Roux', 'nathan.roux@yahoo.com', 'AsDf4', '21 Rue de la République', '7901234567', 'Buyer', '2024-01-14', 0, 1499.98, 1, 'France', 'Marseille', 384756),
(12, 'Oliver Wilson', 'oliver.wilson@gmail.com', 'XxYy9', '1 High Street', '7456789012', 'Buyer', '2024-06-25', 0, 4399.96, 1, 'UK', 'Glasgow', 982734),
(13, 'Lily Harrison', 'lily.harrison@gmail.com', 'GhJk5', '12 Oxford Street', '7012345678', 'Buyer', '2024-02-25', 0, 799.99, 1, 'UK', 'London', 918273),
(14, 'Enzo Thomas', 'enzo.thomas@yahoo.com', 'AaBb1', '18 Avenue de la République', '7567890123', 'Buyer', '2024-07-19', 0, 2399.98, 1, 'France', 'Toulouse', 738291),
(15, 'Charlie Clark', 'charlie.clark@gmail.com', 'CcDd2', '4 High Street', '7678901234', 'Buyer', '2024-08-14', 0, 29.99, 1, 'UK', 'Edinburgh', 183746),
(16, 'Pablo Fernandez', 'pablo.fernandez@yahoo.com', 'EeFf3', '13 Plaza de España', '7789012345', 'Buyer', '2024-09-30', 0, 1149.95, 1, 'Spain', 'Seville', 629184),
(17, 'Manon Bernard', 'manon.bernard@yahoo.com', 'IiJj5', '22 Rue de la République', '7901234567', 'Buyer', '2024-11-12', 0, 649.97, 1, 'France', 'Nice', 293847),
(18, 'Amelia Hughes', 'amelia.hughes@gmail.com', 'KkLl6', '753 Cedar Rd', '7012345678', 'Buyer', '2024-12-08', 0, 1159.9, 1, 'UK', 'Liverpool', 746392),
(19, 'Hannah Schneider', 'hannah.schneider@gmail.com', 'GgHh4', '159 Pine Ln', '7890123456', 'Buyer', '2024-10-25', 0, 0, 0, 'Germany', 'Frankfurt', 293847),
(20, 'Andrea Torres', 'andrea.torres@yahoo.com', 'ZzZz7', '789 Elm St', '7890123456', 'Buyer', '2024-09-28', 0, 1119.93, 2, 'Spain', 'Madrid', 847593);

--ELECTRONIC
INSERT INTO Electronic_Items (ItemID, Name, MemberID, Item_Name, Color, Brand, Model, Item_Condition, Description, Item_Price, Item_Type, Stock_Count, Total_Quantity_Sold, Specification, YearOfManufacturing, BatteryLife, OperatingSystem, Processor, CompatibleDevices, Material)
VALUES 
('Item1', 'Alice Dubois', 1, 'iPhone 13', 'Black', 'Apple', '13', 'Used', 'Latest iPhone model', 799.99, 'Gadget', 5, 2, 'Screen Size: 6.1 inch', 2023, '24 hours', 'iOS', 'Apple A15 Bionic', 'N/A', 'N/A'),
('Item2', 'Alice Dubois', 1, 'Samsung Galaxy S21', 'Silver', 'Samsung', 'S21', 'New', 'High performance phone', 699.99, 'Gadget', 10, 1, 'Screen Size: 6.2 inch', 2009, '32 hours', 'Android', 'Qualcomm Snapdragon 888', 'N/A', 'N/A'),
('Item3', 'Alice Dubois', 1, 'MacBook Pro', 'Gray', 'Apple', '2021', 'Used', 'Professional laptop', 1299.99, 'Gadget', 7, 3, 'Screen Size: 13.3 inch', 2024, '10 hours', 'macOS', 'Apple M1', 'N/A', 'N/A'),
('Item4', 'Alice Dubois', 1, 'Dell XPS 13', 'White', 'Dell', '9310', 'Poor', 'Ultra-thin laptop', 999.99, 'Gadget', 3, 1, 'Screen Size: 13.4 inch', 2012, '16 hours', 'Windows', 'Intel Core i7', 'N/A', 'N/A'),
('Item5', 'Bob Brown', 2, 'iPad Pro', 'Gold', 'Apple', '2020', 'Used', 'Powerful tablet', 849.99, 'Gadget', 6, 2, 'Screen Size: 11 inch', 2010, '12 hours', 'iPadOS', 'Apple A12Z Bionic', 'N/A', 'N/A'),
('Item6', 'Bob Brown', 2, 'Google Pixel 6', 'Black', 'Google', '6', 'New', 'Advanced smartphone', 599.99, 'Gadget', 9, 1, 'Screen Size: 6.4 inch', 2020, '20 hours', 'Android', 'Google Tensor', 'N/A', 'N/A'),
('Item7', 'Bob Brown', 2, 'Microsoft Surface Pro 7', 'Black', 'Microsoft', 'Pro 7', 'Poor', 'Versatile 2-in-1 device', 899.99, 'Gadget', 4, 1, 'Screen Size: 12.3 inch', 2002, '8 hours', 'Windows', 'Intel Core i5', 'N/A', 'N/A'),
('Item8', 'Carlos García', 3, 'Lenovo ThinkPad X1', 'Black', 'Lenovo', 'X1', 'Used', 'Business laptop', 1099.99, 'Gadget', 8, 4, 'Screen Size: 14 inch', 2008, '14 hours', 'Windows', 'Intel Core i7', 'N/A', 'N/A'),
('Item9', 'Carlos García', 3, 'Asus ROG Phone 5', 'Black', 'Asus', '5', 'New', 'Gaming smartphone', 799.99, 'Gadget', 6, 1, 'Screen Size: 6.78 inch', 2022, '16 hours', 'Android', 'Qualcomm Snapdragon 888+', 'N/A', 'N/A'),
('Item10', 'Carlos García', 3, 'Huawei MateBook X Pro', 'Silver', 'Huawei', 'X Pro', 'New', 'High-end laptop', 1199.99, 'Gadget', 5, 2, 'Screen Size: 13.9 inch', 2024, '11 hours', 'Windows', 'Intel Core i7', 'N/A', 'N/A'),
('Item11', 'Carlos García', 3, 'Logitech Wireless Mouse', 'Black', 'Logitech', 'M325', 'New', 'Comfortable wireless mouse', 29.99, 'Accessory', 20, 1, 'Wireless Connectivity', 2013, 'N/A', 'N/A', 'N/A', 'Windows PCs, MacBooks', 'Plastic'),
('Item12', 'David Schmidt', 4, 'Sony WH-1000XM4', 'Black', 'Sony', 'WH-1000XM4', 'New', 'Premium noise-cancelling headphones', 349.99, 'Accessory', 15, 1, 'Noise Cancelling', 2016, 'N/A', 'N/A', 'N/A', 'iPhones, Android smartphones', 'Metal'),
('Item13', 'David Schmidt', 4, 'Razer Mechanical Keyboard', 'Black', 'Razer', 'BlackWidow', 'Used', 'Gaming keyboard with backlighting', 199.99, 'Accessory', 12, 4, 'Mechanical Switches', 2015, 'N/A', 'N/A', 'N/A', 'Gaming PCs, MacBooks', 'Aluminum'),
('Item14', 'Lucas Martin', 5, 'Corsair Gaming Mouse', 'Black', 'Corsair', 'KATAR PRO', 'New', 'Lightweight gaming mouse', 49.99, 'Accessory', 25, 1, 'Optical Sensor', 2024, 'N/A', 'N/A', 'N/A', 'Gaming consoles, PCs', 'Rubber'),
('Item15', 'Lucas Martin', 5, 'Bose QuietComfort 35 II', 'Silver', 'Bose', 'QC35 II', 'Poor', 'Wireless Bluetooth headphones', 299.99, 'Accessory', 18, 2, 'Wireless Bluetooth', 2012, 'N/A', 'N/A', 'N/A', 'iPads, Android tablets', 'Leather'),
('Item16', 'Lucas Martin', 5, 'HyperX Cloud II', 'Red', 'HyperX', 'Cloud II', 'New', 'Comfortable gaming headphones', 99.99, 'Accessory', 20, 8, 'Surround Sound', 2010, 'N/A', 'N/A', 'N/A', 'iPhones, iPads', 'Silicone'),
('Item17', 'Fiona Smith', 6, 'SteelSeries Apex Pro', 'Black', 'SteelSeries', 'Apex Pro', 'New', 'Professional gaming keyboard', 179.99, 'Accessory', 10, 2, 'Adjustable Switches', 2008, 'N/A', 'N/A', 'N/A', 'PCs, MacBooks', 'Plastic'),
('Item18', 'Fiona Smith', 6, 'Apple Magic Mouse', 'White', 'Apple', 'A1296', 'Used', 'Sleek wireless mouse', 79.99, 'Accessory', 15, 4, 'Multi-Touch Surface', 2007, 'N/A', 'N/A', 'N/A', 'Android smartphones, iPhones', 'Metal'),
('Item19', 'Harry Walker', 7, 'Beats Solo3', 'Black', 'Beats', 'Solo3', 'New', 'On-ear wireless headphones', 199.99, 'Accessory', 22, 5, 'Wireless Headphones', 2005, 'N/A', 'N/A', 'N/A', 'MacBooks, Windows laptops', 'Aluminum'),
('Item20', 'Harry Walker', 7, 'Logitech G502 Hero', 'Black', 'Logitech', 'G502 Hero', 'Poor', 'High-performance gaming mouse', 59.99, 'Accessory', 18, 2, 'High-Precision Sensor', 2018, 'N/A', 'N/A', 'N/A', 'Android tablets, iPads', 'Leather');

--SELLERS

INSERT INTO Sellers (MemberID, Name, MemberType, Country, City, Total_Profit_Made)
VALUES
(1, 'Alice Dubois', 'Seller', 'France', 'Paris', 7199.93),
(2, 'Bob Brown', 'Seller', 'UK', 'London', 3199.96),
(3, 'Carlos García', 'Seller', 'Spain', 'Madrid', 7629.92),
(4, 'David Schmidt', 'Seller', 'Germany', 'Berlin', 1149.95),
(5, 'Lucas Martin', 'Seller', 'France', 'Paris', 1449.89),
(6, 'Fiona Smith', 'Seller', 'UK', 'Leeds', 679.94),
(7, 'Harry Walker', 'Seller', 'UK', 'London', 1119.93);

--BUYERS

INSERT INTO Buyers (MemberID, Name, MemberType, Country, City, Total_Spent_Amount, Total_Orders)
VALUES
(8, 'Grace González', 'Buyer', 'Spain', 'Barcelona', 8899.91, 3),
(9, 'Isabella Green', 'Buyer', 'Germany', 'Hamburg', 0, 0),
(10, 'Heinrich Müller', 'Buyer', 'Germany', 'Berlin', 0, 0),
(11, 'Nathan Roux', 'Buyer', 'France', 'Marseille', 1499.98, 1),
(12, 'Oliver Wilson', 'Buyer', 'UK', 'Glasgow', 4399.96, 1),
(13, 'Lily Harrison', 'Buyer', 'UK', 'London', 799.99, 1),
(14, 'Enzo Thomas', 'Buyer', 'France', 'Toulouse', 2399.98, 1),
(15, 'Charlie Clark', 'Buyer', 'UK', 'Edinburgh', 29.99, 1),
(16, 'Pablo Fernandez', 'Buyer', 'Spain', 'Seville', 1149.95, 1),
(17, 'Manon Bernard', 'Buyer', 'France', 'Nice', 649.97, 1),
(18, 'Amelia Hughes', 'Buyer', 'UK', 'Liverpool', 1159.9, 1),
(19, 'Hannah Schneider', 'Buyer', 'Germany', 'Frankfurt', 0, 0),
(20, 'Andrea Torres', 'Buyer', 'Spain', 'Madrid', 1119.93, 2);

--ACCESSORIES

INSERT INTO Accessories (ItemID, CompatibleDevices, Material)
VALUES
('Item11', 'Windows PCs, MacBooks', 'Plastic'),
('Item12', 'iPhones, Android smartphones', 'Metal'),
('Item13', 'Gaming PCs, MacBooks', 'Aluminum'),
('Item14', 'Gaming consoles, PCs', 'Rubber'),
('Item15', 'iPads, Android tablets', 'Leather'),
('Item16', 'iPhones, iPads', 'Silicone'),
('Item17', 'PCs, MacBooks', 'Plastic'),
('Item18', 'Android smartphones, iPhones', 'Metal'),
('Item19', 'MacBooks, Windows laptops', 'Aluminum'),
('Item20', 'Android tablets, iPads', 'Leather');

--GADGETS

INSERT INTO Gadgets (ItemID, BatteryLife, OperatingSystem, Processor)
VALUES
    ('Item1', '24 hours', 'iOS', 'Apple A15 Bionic'),
    ('Item2', '32 hours', 'Android', 'Qualcomm Snapdragon 888'),
    ('Item3', '10 hours', 'macOS', 'Apple M1'),
    ('Item4', '16 hours', 'Windows', 'Intel Core i7'),
    ('Item5', '12 hours', 'iPadOS', 'Apple A12Z Bionic'),
    ('Item6', '20 hours', 'Android', 'Google Tensor'),
    ('Item7', '8 hours', 'Windows', 'Intel Core i5'),
    ('Item8', '14 hours', 'Windows', 'Intel Core i7'),
    ('Item9', '16 hours', 'Android', 'Qualcomm Snapdragon 888+'),
    ('Item10', '11 hours', 'Windows', 'Intel Core i7');

--ORDERS
INSERT INTO Orders (OrderID, MemberID, OrderDate, Total_Amount)
VALUES
    ('Order1', 8, '2024-06-15', 2299.97),
    ('Order2', 8, '2024-06-16', 3899.97),
    ('Order3', 8, '2024-06-17', 2699.97),
    ('Order4', 11, '2024-06-18', 1499.98),
    ('Order5', 12, '2024-06-19', 4399.96),
    ('Order6', 13, '2024-06-20', 799.99),
    ('Order7', 14, '2024-06-21', 2399.98),
    ('Order8', 15, '2024-06-22', 29.99),
    ('Order9', 16, '2024-06-23', 1149.95),
    ('Order10', 17, '2024-06-24', 649.97),
    ('Order11', 18, '2024-06-25', 1159.90),
    ('Order12', 20, '2024-06-26', 319.96),
    ('Order13', 20, '2024-06-27', 1119.93);

--ORDERSINFO

INSERT INTO OrdersInfo (OrderInfoID, OrderID, ItemID, Quantity, Item_Price, OrderInfoTotal)
VALUES
    ('Info1', 'Order1', 'Item1', 2, 799.99, 1599.98),
    ('Info2', 'Order1', 'Item2', 1, 699.99, 699.99),
    ('Info3', 'Order2', 'Item3', 3, 1299.99, 3899.97),
    ('Info4', 'Order3', 'Item4', 1, 999.99, 999.99),
    ('Info5', 'Order3', 'Item5', 2, 849.99, 1699.98),
    ('Info6', 'Order4', 'Item6', 1, 599.99, 599.99),
    ('Info7', 'Order4', 'Item7', 1, 899.99, 899.99),
    ('Info8', 'Order5', 'Item8', 4, 1099.99, 4399.96),
    ('Info9', 'Order6', 'Item9', 1, 799.99, 799.99),
    ('Info10', 'Order7', 'Item10', 2, 1199.99, 2399.98),
    ('Info11', 'Order8', 'Item11', 1, 29.99, 29.99),
    ('Info12', 'Order9', 'Item12', 1, 349.99, 349.99),
    ('Info13', 'Order9', 'Item13', 4, 199.99, 799.96),
    ('Info14', 'Order10', 'Item14', 1, 49.99, 49.99),
    ('Info15', 'Order10', 'Item15', 2, 299.99, 599.98),
    ('Info16', 'Order11', 'Item16', 8, 99.99, 799.92),
    ('Info17', 'Order11', 'Item17', 2, 179.99, 359.98),
    ('Info18', 'Order12', 'Item18', 4, 79.99, 319.96),
    ('Info19', 'Order13', 'Item19', 5, 199.99, 999.95),
    ('Info20', 'Order13', 'Item20', 2, 59.99, 119.98);


--SALES

INSERT INTO Sales (SaleID, OrderID, SaleDate, TotalAmount, PaymentMethod, PaymentStatus)
VALUES
    (1, 'Order1', '2023-06-15', 2299.97, 'PayPal', 'Cancelled'),
    (2, 'Order1', '2023-06-16', 2299.97, 'Credit Card', 'Approved'),
    (3, 'Order2', '2023-06-17', 3899.97, 'Credit Card', 'Pending'),
    (4, 'Order3', '2023-06-18', 2699.97, 'PayPal', 'Cancelled'),
    (5, 'Order3', '2023-06-19', 2699.97, 'Credit Card', 'Cancelled'),
    (6, 'Order3', '2023-06-20', 2699.97, 'Cash', 'Approved'),
    (7, 'Order4', '2023-06-21', 1499.98, 'Credit Card', 'Pending'),
    (8, 'Order5', '2023-06-22', 4399.96, 'PayPal', 'Approved'),
    (9, 'Order6', '2023-06-23', 799.99, 'Cash', 'Approved'),
    (10, 'Order7', '2023-06-24', 2399.98, 'PayPal', 'Cancelled'),
    (11, 'Order7', '2023-06-25', 2399.98, 'Credit Card', 'Pending'),
    (12, 'Order8', '2023-06-25', 29.99, 'Cash', 'Approved'),
    (13, 'Order9', '2023-06-25', 1149.95, 'Credit Card', 'Approved'),
    (14, 'Order10', '2023-06-26', 649.97, 'Credit Card', 'Pending'),
    (15, 'Order11', '2023-06-26', 1159.90, 'Credit Card', 'Approved'),
    (16, 'Order12', '2023-06-27', 319.96, 'Credit Card', 'Approved'),
    (17, 'Order13', '2023-06-28', 1119.93, 'PayPal', 'Cancelled'),
    (18, 'Order13', '2023-06-28', 1119.93, 'Credit Card', 'Approved');

--SHIPPING

INSERT INTO Shipping (
    ShippingID, MemberID, ShippingAddress, Delivery_City, Delivery_Country,
    OrderID, PostalCode, ShippingDate, DeliveryDate, Delivery_Firm,
    License_Plate, Shipping_Status, Total_Amount
)
VALUES
    ('Ship1', 8, '8 La Rambla', 'Barcelona', 'Spain', 'Order1', '75001', '2024-07-01', '2024-07-06', 'Amazon', 'ABC123', 'Shipped', 2299.97),
    ('Ship2', 8, '9 La Rambla', 'Barcelona', 'Spain', 'Order2', '75001', 'N/A', 'N/A', 'Argus', 'DEF456', 'Pending', 3899.97),
    ('Ship3', 8, '10 La Rambla', 'Barcelona', 'Spain', 'Order3', '75001', '2024-07-03', '2024-07-08', 'Currys', 'GHI789', 'Shipped', 2699.97),
    ('Ship4', 11, '21 Rue de la République', 'Marseille', 'France', 'Order4', '27795', 'N/A', 'N/A', 'Other', 'JKL012', 'Pending', 1499.98),
    ('Ship5', 12, '1 High Street', 'Glasgow', 'UK', 'Order5', 'GL1A 3FF', '2024-07-05', '2024-07-10', 'Amazon', 'MNO345', 'Shipped', 4399.96),
    ('Ship6', 13, '12 Oxford Street', 'London', 'UK', 'Order6', 'SW1A 1AA', '2024-07-06', '2024-07-11', 'Argus', 'PQR678', 'Shipped', 799.99),
    ('Ship7', 14, '18 Avenue de la République', 'Toulouse', 'France', 'Order7', '20800', 'N/A', 'N/A', 'Currys', 'STU901', 'Pending', 2399.98),
    ('Ship8', 15, '4 High Street', 'Edinburgh', 'UK', 'Order8', 'ED1A 1AB', '2024-07-08', '2024-07-13', 'Other', 'VWX234', 'Shipped', 29.99),
    ('Ship9', 16, '13 Plaza de España', 'Seville', 'Spain', 'Order9', '25595', '2024-07-09', '2024-07-14', 'Amazon', 'YZA567', 'Shipped', 1149.95),
    ('Ship10', 17, '22 Rue de la République', 'Nice', 'France', 'Order10', '10117', 'N/A', 'N/A', 'Argus', 'BCD890', 'Pending', 649.97),
    ('Ship11', 18, '753 Cedar Rd', 'Liverpool', 'UK', 'Order11', 'LV1A 4DD', '2024-07-11', '2024-07-16', 'Currys', 'EFG123', 'Shipped', 1159.9),
    ('Ship12', 20, '799 Elm St', 'Madrid', 'Spain', 'Order12', '20095', '2024-07-12', '2024-07-17', 'Other', 'HIJ456', 'Shipped', 319.96),
    ('Ship13', 20, '789 Elm St', 'Madrid', 'Spain', 'Order13', '20095', '2024-07-13', '2024-07-18', 'Amazon', 'KLM789', 'Shipped', 1119.93);
VIEWS

	--SupiciousActivityTracker View
CREATE VIEW SupiciousActivityTracker AS
SELECT 
    s.SaleID,
    s.OrderID,
    o.MemberID,
    m.Name AS MemberName,
    m.Email AS MemberEmail,
    o.Total_Amount AS OrderTotalAmount,
    s.Total_Amount AS SaleTotalAmount,
    s.SaleDate,
    s.PaymentMethod,
    s.PaymentStatus,
    TotalCancellations.TotalCancellationsByMember,
    MethodCancellations.CancellationsByMethodForMember,
    s.PaymentMethod AS MethodOfPayment
FROM Sales s
JOIN Orders o ON s.OrderID = o.OrderID
JOIN Members m ON o.MemberID = m.MemberID
JOIN (
    SELECT 
        o.MemberID,
        COUNT(s.SaleID) AS TotalCancellationsByMember
    FROM Sales s
    JOIN Orders o ON s.OrderID = o.OrderID
    WHERE s.PaymentStatus = 'Cancelled'
    GROUP BY o.MemberID
) AS TotalCancellations ON o.MemberID = TotalCancellations.MemberID
JOIN (
    SELECT 
        o.MemberID,
        s.PaymentMethod,
        COUNT(s.SaleID) AS CancellationsByMethodForMember
    FROM Sales s
    JOIN Orders o ON s.OrderID = o.OrderID
    WHERE s.PaymentStatus = 'Cancelled'
    GROUP BY o.MemberID, s.PaymentMethod
) AS MethodCancellations ON o.MemberID = MethodCancellations.MemberID 
    AND s.PaymentMethod = MethodCancellations.PaymentMethod
WHERE s.PaymentStatus = 'Cancelled';

--PriorityResearchItems View
CREATE VIEW PriorityResearchItems AS
SELECT e.ItemID, e.Item_Name, e.Item_Type, e.Brand, e.Model, e.Condition,
       e.Item_Price, e.Total_Quantity_Sold, e.Stock_Count,
       m.Name AS SellerName, m.Country AS SellerCountry, m.City AS SellerCity
FROM Electronic_Items e
JOIN Members m ON e.MemberID = m.MemberID
WHERE e.ItemID IN ('Item1', 'Item7', 'Item13', 'Item17', 'Item19')  -- Specify the ItemIDs of the items you want to include
ORDER BY RAND()
LIMIT 5;






--TopBuyersAnalysis View
CREATE VIEW TopBuyersAnalysis AS
SELECT m.MemberID, 
       m.Name AS BuyerName, 
       m.Country AS BuyerCountry, 
       m.City AS BuyerCity,
       COUNT(o.OrderID) AS TotalOrders,
       SUM(o.Total_Amount) AS TotalSpent,
       AVG(o.Total_Amount) AS AvgSpentPerOrder
FROM Members m
JOIN Orders o ON m.MemberID = o.MemberID
WHERE m.MemberType = 'Buyer'
GROUP BY m.MemberID, m.Name, m.Country, m.City
ORDER BY TotalSpent DESC
LIMIT 10;

--Store Procedures

--COMPLEX:

--CalculateProfitDifference
DELIMITER //

CREATE PROCEDURE CalculateProfitDifference()
BEGIN
    DECLARE maxProfit DECIMAL(10,2);
    DECLARE minProfit DECIMAL(10,2);
    DECLARE profitDifference DECIMAL(10,2);

    SELECT MAX(Total_Profit_Made) INTO maxProfit
    FROM Sellers
    WHERE Total_Profit_Made > 0;

    SELECT MIN(Total_Profit_Made) INTO minProfit
    FROM Sellers
    WHERE Total_Profit_Made > 0;

    SET profitDifference = maxProfit - minProfit;

  
    SELECT maxProfit AS MaxProfit, minProfit AS MinProfit, profitDifference AS ProfitDifference;
END //

DELIMITER ;

--GetMemberSecurityDetails

DELIMITER //

CREATE PROCEDURE GetMemberSecurityDetails(IN memberID INT)
BEGIN
    DECLARE memberName VARCHAR(100);
    DECLARE memberEmail VARCHAR(100);
    DECLARE memberPassword VARCHAR(200);
    DECLARE memberRecoveryPIN INT;
    
    SELECT m.Name, m.Email, m.Password, m.RecoveryPIN
    INTO memberName, memberEmail, memberPassword, memberRecoveryPIN
    FROM Members m
    WHERE m.MemberID = memberID;
    
    SELECT memberName AS MemberName,
           memberEmail AS MemberEmail,
           memberPassword AS MemberPassword,
           memberRecoveryPIN AS MemberRecoveryPIN;
END //

DELIMITER ;
GetDeliveryPeople
DELIMITER //

CREATE PROCEDURE GetDeliveryPeople()
BEGIN
    SELECT s.ShippingID, s.OrderID, s.License_Plate, s.Delivery_Firm
    FROM Shipping s;
END //

DELIMITER ;

--GetTop3CheapestItems
DELIMITER //

CREATE PROCEDURE GetWorst3Items()
BEGIN
    SELECT Item_Name, Item_Price
    FROM Electronic_Items
    ORDER BY Item_Price ASC
    LIMIT 3;
END //

DELIMITER ;

TRIGGERS

--UpdateStockOnOrder

DELIMITER //

CREATE TRIGGER UpdateStockOnOrder
AFTER INSERT ON OrdersInfo
FOR EACH ROW
BEGIN
    DECLARE new_quantity INT;
    
    
    SELECT Quantity INTO new_quantity
    FROM OrdersInfo
    WHERE OrderInfoID = NEW.OrderInfoID;
    
    
    UPDATE Electronic_Items
    SET Stock_Count = Stock_Count - new_quantity
    WHERE ItemID = NEW.ItemID;
END //

DELIMITER ;

--TEST UpdateStockOnOrder:
SELECT ItemID, Item_Name, Stock_Count
FROM Electronic_Items
WHERE ItemID IN ('Item1', 'Item2');


INSERT INTO Orders (OrderID, MemberID, OrderDate, Total_Amount)
VALUES ('Order14', 9, '2024-07-15', 1599.98),
       ('Order15', 9, '2024-07-15', 2099.97);



INSERT INTO OrdersInfo (OrderInfoID, OrderID, ItemID, Quantity, Item_Price, OrderInfoTotal)
VALUES (‘Info21’, 'Order14', 'Item1', 2, 799.99, 1599.98),
       (‘Info22’, 'Order15', 'Item2', 3, 699.99, 2099.97);


--trg_audit_members
DELIMITER //

CREATE TRIGGER trg_audit_members
AFTER INSERT ON Members
FOR EACH ROW
BEGIN
    INSERT INTO AuditMembersTrail (TableName, Action, DateTime)
    VALUES ('Members', 'INSERT', NOW());
END//

DELIMITER ;

--Create table for trigger trg_audit_members
CREATE TABLE AuditMembersTrail (
    AuditTrailID INT AUTO_INCREMENT PRIMARY KEY,
    TableName VARCHAR(50) NOT NULL,
    Action VARCHAR(10) NOT NULL,
    DateTime DATETIME NOT NULL
);

--TEST trg_audit_members:
INSERT INTO Members (MemberID, Name, Email, Password, Address, Phone, MemberType, DateJoined, Total_Profit_Made, Total_Spent_Amount, Total_Orders, Country, City, RecoveryPIN)
VALUES
(21, 'Jon Torres', 'Jon.torres@yahoo.com', 'YuZz7', '781 Elm St', '7890127856', 'Buyer', '2024-09-28', 0, 1119.93, 2, 'France', 'Paris', 666593);


--trg_audit_orders
DELIMITER //

CREATE TRIGGER trg_audit_orders
AFTER INSERT ON Orders
FOR EACH ROW
BEGIN
    INSERT INTO AuditOrdersTrail (TableName, Action, DateTime)
    VALUES ('Orders', 'INSERT', NOW());
END//

DELIMITER ;

--Create table for trigger trg_audit_orders
CREATE TABLE AuditOrdersTrail (
    AuditTrailID INT AUTO_INCREMENT PRIMARY KEY,
    TableName VARCHAR(50) NOT NULL,
    Action VARCHAR(10) NOT NULL,
    DateTime DATETIME NOT NULL
);

--TEST trg_audit_orders:
INSERT INTO Orders (OrderID, MemberID, OrderDate, Total_Amount)
VALUES
 ('Order40', 20, '2024-06-28', 799.99);
