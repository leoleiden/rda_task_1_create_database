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
    CustomerID INT NULL, -- Явно визначено як NULL
    Date DATE NOT NULL, -- Змінено назву назад на Date, щоб відповідати test.sql
    FOREIGN KEY (CustomerID) REFERENCES Customers(ID) ON DELETE SET NULL
);

-- Створення таблиці OrderItems (Елементи Замовлення)
CREATE TABLE IF NOT EXISTS OrderItems (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    OrderID INT NULL, -- Явно визначено як NULL
    ProductID INT NULL, -- Явно визначено як NULL
    Quantity INT NOT NULL DEFAULT 1, -- Додано Quantity для кількості товару в замовленні
    PriceAtOrder DECIMAL(10, 2) NOT NULL, -- Додано PriceAtOrder для фіксації ціни на момент замовлення
    FOREIGN KEY (OrderID) REFERENCES Orders(ID) ON DELETE SET NULL,
    FOREIGN KEY (ProductID) REFERENCES Products(ID) ON DELETE SET NULL
);

-- Коментарі для пояснення структури
-- Таблиця Products: Зберігає інформацію про товари, їх назву, опис, ціну та кількість на складі.
-- ID: Унікальний ідентифікатор товару (первинний ключ, автоінкремент).
-- Name: Назва товару.
-- Description: Детальний опис товару.
-- Price: Ціна товару.
-- WarehouseAmount: Кількість товару на складі.

-- Таблиця Customers: Зберігає інформацію про покупців.
-- ID: Унікальний ідентифікатор покупця (первинний ключ, автоінкремент).
-- FirstName: Ім'я покупця.
-- LastName: Прізвище покупця.
-- Email: Електронна пошта покупця (унікальна).
-- Address: Адреса покупця.

-- Таблиця Orders: Зберігає інформацію про замовлення.
-- ID: Унікальний ідентифікатор замовлення (первинний ключ, автоінкремент).
-- CustomerID: Ідентифікатор покупця, який зробив замовлення (зовнішній ключ, посилається на Customers.ID).
--            Явно визначено як NULL, оскільки він може бути встановлений в NULL при видаленні покупця.
-- Date: Дата створення замовлення (назва повернена до 'Date' для сумісності з test.sql).

-- Таблиця OrderItems: Деталізує, які товари включені в кожне замовлення.
-- ID: Унікальний ідентифікатор елемента замовлення (первинний ключ, автоінкремент).
-- OrderID: Ідентифікатор замовлення, до якого належить цей елемент (зовнішній ключ, посилається на Orders.ID).
--          Явно визначено як NULL, оскільки він може бути встановлений в NULL при видаленні замовлення.
-- ProductID: Ідентифікатор товару, який включено в замовлення (зовнішній ключ, посилається на Products.ID).
--            Явно визначено як NULL, оскільки він може бути встановлений в NULL при видаленні товару.
-- Quantity: Кількість даного товару в цьому замовленні.
-- PriceAtOrder: Ціна товару на момент замовлення (важливо для історії, якщо ціна товару зміниться пізніше).

