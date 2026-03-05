-- =============================================
-- RFM Analysis - SQL Data Cleaning
-- =============================================

-- Step 1: Database Create చేయండి
CREATE DATABASE IF NOT EXISTS rfm_analysis;
USE rfm_analysis;

-- Step 2: Table Create చేయండి
CREATE TABLE IF NOT EXISTS online_retail (
    InvoiceNo    VARCHAR(20),
    StockCode    VARCHAR(20),
    Description  VARCHAR(100),
    Quantity     INT,
    InvoiceDate  DATETIME,
    UnitPrice    DECIMAL(10,2),
    CustomerID   VARCHAR(20),
    Country      VARCHAR(50)
);

-- Step 3: CSV Import చేయండి
-- (MySQL Workbench లో Table Data Import Wizard వాడండి)
-- లేదా:
LOAD DATA INFILE 'Online_Retail.csv'
INTO TABLE online_retail
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(InvoiceNo, StockCode, Description, 
 Quantity, InvoiceDate, UnitPrice, 
 CustomerID, Country);

-- =============================================
-- Step 4: Data Quality Check చేయండి
-- =============================================

-- Total rows check
SELECT COUNT(*) AS Total_Rows 
FROM online_retail;
-- Expected: 541909

-- Null values check
SELECT 
    SUM(CASE WHEN CustomerID IS NULL 
        THEN 1 ELSE 0 END) AS Null_CustomerID,
    SUM(CASE WHEN Quantity <= 0 
        THEN 1 ELSE 0 END) AS Negative_Quantity,
    SUM(CASE WHEN UnitPrice <= 0 
        THEN 1 ELSE 0 END) AS Negative_Price,
    SUM(CASE WHEN InvoiceNo LIKE 'C%' 
        THEN 1 ELSE 0 END) AS Cancelled_Orders
FROM online_retail;

-- =============================================
-- Step 5: Clean Data Table Create చేయండి
-- =============================================

CREATE TABLE online_retail_clean AS
SELECT 
    InvoiceNo,
    StockCode,
    Description,
    Quantity,
    STR_TO_DATE(InvoiceDate, '%m/%d/%Y %H:%i') 
        AS InvoiceDate,
    UnitPrice,
    CustomerID,
    Country,
    (Quantity * UnitPrice) AS Revenue
FROM online_retail
WHERE 
    CustomerID IS NOT NULL        -- Null CustomerID remove
    AND Quantity > 0              -- Negative quantity remove
    AND UnitPrice > 0             -- Negative price remove
    AND InvoiceNo NOT LIKE 'C%';  -- Cancelled orders remove

-- Clean data check
SELECT COUNT(*) AS Clean_Rows 
FROM online_retail_clean;
-- Expected: ~406,829

-- =============================================
-- Step 6: RFM Base Data Extract చేయండి
-- =============================================

-- Reference date (max date + 1 day)
SET @today = (
    SELECT DATE_ADD(MAX(InvoiceDate), INTERVAL 1 DAY) 
    FROM online_retail_clean
);

SELECT @today; -- Check: 2011-12-10

-- RFM Table Create చేయండి
CREATE TABLE rfm_base AS
SELECT 
    CustomerID,
    -- Recency: Last purchase నుండి days
    DATEDIFF(@today, MAX(InvoiceDate)) 
        AS Recency,
    -- Frequency: Unique invoices count
    COUNT(DISTINCT InvoiceNo) 
        AS Frequency,
    -- Monetary: Total revenue
    ROUND(SUM(Revenue), 2) 
        AS Monetary
FROM online_retail_clean
GROUP BY CustomerID;

-- RFM Base check
SELECT COUNT(*) AS Total_Customers 
FROM rfm_base;
-- Expected: ~4338 customers

-- Sample check
SELECT * FROM rfm_base LIMIT 10;

-- =============================================
-- Step 7: Export చేయండి Python కోసం
-- =============================================

-- rfm_base table ని CSV గా export చేయండి
-- MySQL Workbench లో:
-- Right click on rfm_base → Table Data Export Wizard
-- File name: rfm_base.csv

SELECT 
    CustomerID,
    Recency,
    Frequency,
    ROUND(Monetary, 2) AS Monetary
FROM rfm_base
ORDER BY Monetary DESC;
