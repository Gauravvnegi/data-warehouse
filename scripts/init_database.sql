/*
===============================================================
 Project: Data Warehouse Setup
 Description:
 This script initializes a Data Warehouse database using the 
 Medallion Architecture (Bronze, Silver, Gold layers).

 - Bronze Layer: Raw data ingestion (as-is from source)
 - Silver Layer: Cleaned and transformed data
 - Gold Layer: Business-ready data for reporting

 This script is safe to run multiple times (idempotent).
===============================================================
*/

-- Step 1: Switch to master database
USE master;
GO

-- Step 2: Create Database if it does not exist
IF NOT EXISTS (
    SELECT name FROM sys.databases WHERE name = 'DataWarehouse'
)
BEGIN
    CREATE DATABASE DataWarehouse;
END
GO

-- Step 3: Switch to DataWarehouse database
USE DataWarehouse;
GO

-- Step 4: Create Bronze Schema (Raw Layer)
IF NOT EXISTS (
    SELECT * FROM sys.schemas WHERE name = 'bronze'
)
BEGIN
    EXEC('CREATE SCHEMA bronze');
END
GO

-- Step 5: Create Silver Schema (Cleaned Layer)
IF NOT EXISTS (
    SELECT * FROM sys.schemas WHERE name = 'silver'
)
BEGIN
    EXEC('CREATE SCHEMA silver');
END
GO

-- Step 6: Create Gold Schema (Business Layer)
IF NOT EXISTS (
    SELECT * FROM sys.schemas WHERE name = 'gold'
)
BEGIN
    EXEC('CREATE SCHEMA gold');
END
GO

/*
===============================================================
 Summary:
 - Database: DataWarehouse created (if not exists)
 - Schemas:
     bronze → raw data
     silver → cleaned data
     gold   → analytics-ready data
===============================================================
*/