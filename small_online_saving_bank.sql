CREATE DATABASE OnlineSavingsBank;

USE OnlineSavingsBank;

CREATE TABLE Customer (
    CustomerID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Address VARCHAR(255),
    Phone VARCHAR(15),
    Email VARCHAR(100),
    DateOfBirth DATE
);

CREATE TABLE Branch (
    BranchID INT AUTO_INCREMENT PRIMARY KEY,
    BranchName VARCHAR(100) NOT NULL,
    Address VARCHAR(255),
    Phone VARCHAR(15)
);

CREATE TABLE Employee (
    EmployeeID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Role VARCHAR(50),
    BranchID INT,
    ContactInfo VARCHAR(255),
    FOREIGN KEY (BranchID) REFERENCES Branch(BranchID)
);

CREATE TABLE Account (
    AccountID INT AUTO_INCREMENT PRIMARY KEY,
    AccountType ENUM('Savings', 'Checking', 'Fixed Deposit'),
    Balance DECIMAL(10, 2) NOT NULL,
    CustomerID INT,
    BranchID INT,
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
    FOREIGN KEY (BranchID) REFERENCES Branch(BranchID)
);

CREATE TABLE Transaction (
    TransactionID INT AUTO_INCREMENT PRIMARY KEY,
    AccountID INT,
    TransactionType ENUM('Deposit', 'Withdrawal', 'Transfer', 'Bill Payment'),
    Amount DECIMAL(10, 2) NOT NULL,
    Date DATE,
    Description VARCHAR(255),
    FOREIGN KEY (AccountID) REFERENCES Account(AccountID)
);

CREATE TABLE Loan (
    LoanID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerID INT,
    LoanType ENUM('Personal', 'Home', 'Auto'),
    Amount DECIMAL(10, 2),
    InterestRate DECIMAL(5, 2),
    StartDate DATE,
    EndDate DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);

CREATE TABLE CreditCard (
    CardID INT AUTO_INCREMENT PRIMARY KEY,
    CardNumber VARCHAR(16) NOT NULL,
    ExpiryDate DATE,
    CustomerID INT,
    AccountID INT,
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
    FOREIGN KEY (AccountID) REFERENCES Account(AccountID)
);

CREATE TABLE BillPay (
    BillPayID INT AUTO_INCREMENT PRIMARY KEY,
    AccountID INT,
    BillerName VARCHAR(100) NOT NULL,
    BillerAccountNumber VARCHAR(20) NOT NULL,
    Amount DECIMAL(10, 2) NOT NULL,
    PaymentDate DATE,
    FOREIGN KEY (AccountID) REFERENCES Account(AccountID)
);

CREATE TABLE LoanPayment (
    PaymentID INT AUTO_INCREMENT PRIMARY KEY,
    LoanID INT,
    PaymentDate DATE,
    Amount DECIMAL(10, 2) NOT NULL,
    PaymentMethod ENUM('Cash', 'Transfer'),
    FOREIGN KEY (LoanID) REFERENCES Loan(LoanID)
);

-- Insert sample data into Branch table
INSERT INTO Branch (BranchName, Address, Phone) VALUES ('Main Branch', '123 Main St', '555-1234');
INSERT INTO Branch (BranchName, Address, Phone) VALUES ('West Branch', '456 West Ave', '555-5678');

-- Insert sample data into Employee table
INSERT INTO Employee (Name, Role, BranchID, ContactInfo) VALUES ('Alice Johnson', 'Manager', 1, 'alice@example.com');
INSERT INTO Employee (Name, Role, BranchID, ContactInfo) VALUES ('Bob Brown', 'Teller', 2, 'bob@example.com');

-- Insert sample data into Customer table
INSERT INTO Customer (Name, Address, Phone, Email, DateOfBirth) VALUES ('John Doe', '789 Maple Rd', '555-1122', 'john@example.com', '1980-01-01');
INSERT INTO Customer (Name, Address, Phone, Email, DateOfBirth) VALUES ('Jane Smith', '321 Oak St', '555-3344', 'jane@example.com', '1990-02-02');

-- Insert sample data into Account table
INSERT INTO Account (AccountType, Balance, CustomerID, BranchID) VALUES ('Savings', 5000.00, 1, 1);
INSERT INTO Account (AccountType, Balance, CustomerID, BranchID) VALUES ('Checking', 1500.00, 2, 2);

-- Insert sample data into Transaction table
INSERT INTO Transaction (AccountID, TransactionType, Amount, Date, Description) VALUES (1, 'Deposit', 1000.00, '2024-01-01', 'Initial deposit');
INSERT INTO Transaction (AccountID, TransactionType, Amount, Date, Description) VALUES (2, 'Withdrawal', 500.00, '2024-01-02', 'ATM withdrawal');

-- Insert sample data into Loan table
INSERT INTO Loan (CustomerID, LoanType, Amount, InterestRate, StartDate, EndDate) VALUES (1, 'Home', 250000.00, 3.5, '2024-01-01', '2044-01-01');
INSERT INTO Loan (CustomerID, LoanType, Amount, InterestRate, StartDate, EndDate) VALUES (2, 'Auto', 20000.00, 5.0, '2024-02-01', '2029-02-01');

-- Insert sample data into CreditCard table
INSERT INTO CreditCard (CardNumber, ExpiryDate, CustomerID, AccountID) VALUES ('1234567812345678', '2026-01-01', 1, 1);
INSERT INTO CreditCard (CardNumber, ExpiryDate, CustomerID, AccountID) VALUES ('8765432187654321', '2026-01-01', 2, 2);

-- Insert sample data into BillPay table
INSERT INTO BillPay (AccountID, BillerName, BillerAccountNumber, Amount, PaymentDate) VALUES (1, 'Electric Company', 'ELEC12345', 150.00, '2024-01-05');
INSERT INTO BillPay (AccountID, BillerName, BillerAccountNumber, Amount, PaymentDate) VALUES (2, 'Water Company', 'WATER67890', 75.00, '2024-01-06');

-- Insert sample data into LoanPayment table
INSERT INTO LoanPayment (LoanID, PaymentDate, Amount, PaymentMethod) VALUES (1, '2024-02-01', 1000.00, 'Transfer');
INSERT INTO LoanPayment (LoanID, PaymentDate, Amount, PaymentMethod) VALUES (2, '2024-03-01', 500.00, 'Cash');


-- Select all from Customer
SELECT * FROM Customer;

-- Select all from Branch
SELECT * FROM Branch;

-- Select all from Employee
SELECT * FROM Employee;

-- Select all from Account
SELECT * FROM Account;
truncate table account;
-- Select all from Transaction
SELECT * FROM Transaction;

-- Select all from Loan
SELECT * FROM Loan;

-- Select all from CreditCard
SELECT * FROM CreditCard;

-- Select all from BillPay
SELECT * FROM BillPay;

-- Select all from LoanPayment
SELECT * FROM LoanPayment;


SELECT c.CustomerID, c.Name, a.AccountType, a.Balance
FROM Customer c
JOIN Account a ON c.CustomerID = a.CustomerID;

SELECT t.TransactionID, t.TransactionType, t.Amount, t.Date, t.Description
FROM Account a
JOIN Transaction t ON a.AccountID = t.AccountID
WHERE a.AccountID = 1;

SELECT e.EmployeeID, e.Name, e.Role, b.BranchName
FROM Employee e
JOIN Branch b ON e.BranchID = b.BranchID
WHERE b.BranchID = 1;

SELECT l.LoanID, l.LoanType, l.Amount, p.PaymentID, p.PaymentDate, p.Amount as PaymentAmount
FROM Loan l
JOIN LoanPayment p ON l.LoanID = p.LoanID
WHERE l.CustomerID = 1;

SELECT AccountType, SUM(Balance) as TotalBalance
FROM Account
GROUP BY AccountType;

UPDATE Customer
SET Phone = '555-9988'
WHERE CustomerID = 1;

select * from customer where customer;

DELETE FROM Transaction
WHERE TransactionID = 1;

select * from Transaction;


