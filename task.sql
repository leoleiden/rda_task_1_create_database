-- Створення бази даних ShopDB, якщо вона ще не існує
CREATE DATABASE IF NOT EXISTS ShopDB;

-- Використання бази даних ShopDB
USE ShopDB;

-- Створення таблиці Products (Товари)
CREATE TABLE IF NOT EXISTS Products (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Description VARCHAR(255), -- Збільшена довжина для опису
    Price DECIMAL(10, 2) NOT NULL, -- Використання DECIMAL для цін
    WarehouseAmount INT NOT NULL DEFAULT 0
);

-- Створення таблиці Customers (Покупці)
CREATE TABLE IF NOT EXISTS Customers (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE, -- Додано UNIQUE для email
    Address VARCHAR(255)
);

-- Створення таблиці Orders (Замовлення)
CREATE TABLE IF NOT EXISTS Orders (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE NOT NULL, -- Змінено назву на OrderDate для уникнення конфлікту зі словом 'Date'
    FOREIGN KEY (CustomerID) REFERENCES Customers(ID) ON DELETE SET NULL
);

-- Створення таблиці OrderItems (Елементи Замовлення)
CREATE TABLE IF NOT EXISTS OrderItems (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT NOT NULL DEFAULT 1, -- Додано Quantity для кількості товару в замовленні
    PriceAtOrder DECIMAL(10, 2) NOT NULL, -- Додано PriceAtOrder для фіксації ціни на момент замовлення
    FOREIGN KEY (OrderID) REFERENCES Orders(ID) ON DELETE SET NULL,
    FOREIGN KEY (ProductID) REFERENCES Products(ID) ON DELETE SET NULL
);
