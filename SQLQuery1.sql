-- DB: WebShop
CREATE DATABASE WebShop;
GO
USE WebShop;
GO

-- Categories
CREATE TABLE Categories (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL
);

-- Users: role 'ADMIN' or 'CUSTOMER'
CREATE TABLE Users (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Username NVARCHAR(100) NOT NULL UNIQUE,
    PasswordHash NVARCHAR(200) NOT NULL,
    FullName NVARCHAR(200),
    Email NVARCHAR(200),
    Role NVARCHAR(20) NOT NULL, -- 'ADMIN' or 'CUSTOMER'
    CreatedAt DATETIME DEFAULT GETDATE()
);

-- Products
CREATE TABLE Products (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(200) NOT NULL,
    Description NVARCHAR(MAX),
    Price DECIMAL(18,2) NOT NULL,
    Quantity INT NOT NULL DEFAULT 0,
    ImagePath NVARCHAR(500), -- relative path to image
    CategoryId INT NULL,
    CreatedAt DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (CategoryId) REFERENCES Categories(Id)
);

-- Orders
CREATE TABLE Orders (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    UserId INT NOT NULL,
    OrderDate DATETIME DEFAULT GETDATE(),
    Status NVARCHAR(50) DEFAULT 'NEW', -- NEW, SHIPPED, PAID
    TotalAmount DECIMAL(18,2) NOT NULL,
    FOREIGN KEY (UserId) REFERENCES Users(Id)
);

-- OrderItems
CREATE TABLE OrderItems (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    OrderId INT NOT NULL,
    ProductId INT NOT NULL,
    Quantity INT NOT NULL,
    UnitPrice DECIMAL(18,2) NOT NULL,
    FOREIGN KEY (OrderId) REFERENCES Orders(Id),
    FOREIGN KEY (ProductId) REFERENCES Products(Id)
);

USE WebShop;
GO

-- 1️⃣ Insert Categories
INSERT INTO Categories (Name) VALUES 
('Keyboard'), ('Switch');
GO

-- 2️⃣ Insert 30 Keyboard products (CategoryId = 1)
DECLARE @i INT = 1;
WHILE @i <= 30
BEGIN
    INSERT INTO Products (Name, Description, Price, Quantity, ImagePath, CategoryId)
    VALUES (
        CONCAT('Keyboard ', @i),
        CONCAT('High quality keyboard ', @i),
        ROUND( (RAND(CHECKSUM(NEWID())) * 100) + 50, 2), -- random price 50..150
        100,
        CONCAT('/images/products/product', @i, '.jpg'),
        1
    );
    SET @i = @i + 1;
END
GO

-- 3️⃣ Insert 5 Switch products (CategoryId = 2)
SET @i = 31;
WHILE @i <= 35
BEGIN
    INSERT INTO Products (Name, Description, Price, Quantity, ImagePath, CategoryId)
    VALUES (
        CONCAT('Switch ', (@i - 30)),
        CONCAT('Mechanical switch ', (@i - 30)),
        ROUND( (RAND(CHECKSUM(NEWID())) * 50) + 5, 2), -- random price 5..55
        200,
        CONCAT('/images/products/product', @i, '.jpg'),
        2
    );
    SET @i = @i + 1;
END
GO
