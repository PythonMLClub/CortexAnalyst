-- Create Stage
CREATE OR REPLACE STAGE CORTEX_ANALYSTSTAGE DIRECTORY = (ENABLE = TRUE);

-- Upload the book_model.yaml & Medical_books_clean.csv to the above stage
LIST @CORTEX_ANALYSTSTAGE;

--------------------------------Create Table---------------------------------------------
CREATE OR REPLACE TABLE CORTEX_LAB_DB.CORTEX_LAB_SCHEMA.MEDICAL_BOOKS (
    TITLE STRING,
    AUTHORS STRING,
    DESCRIPTION STRING,
    CATEGORY STRING,
    PUBLISHER STRING,
    PRICE_STARTING_WITH FLOAT,
    PUBLISH_DATE_MONTH STRING,
    PUBLISH_DATE_YEAR INT
);

COPY INTO CORTEX_LAB_DB.CORTEX_LAB_SCHEMA.MEDICAL_BOOKS
FROM @CORTEX_ANALYSTSTAGE/Medical_books_clean.csv
FILE_FORMAT = (
    TYPE = 'CSV',
    FIELD_OPTIONALLY_ENCLOSED_BY = '"',
    SKIP_HEADER = 1,
    FIELD_DELIMITER = ',',
    NULL_IF = ('')
)
ON_ERROR = CONTINUE;

---------------------Role, DB, Schema, Warehouse, Table, Stage---------------------------
CREATE ROLE CORTEX_LAB;

SELECT CURRENT_USER;  -- CORETXSEARCHANALYST

-- Grant User
GRANT ROLE CORTEX_LAB TO USER CORETXSEARCHANALYST;

-- Grant CREATE DATABASE privilege
GRANT CREATE DATABASE ON ACCOUNT TO ROLE CORTEX_LAB;

-- Grant CREATE WAREHOUSE privilege
GRANT CREATE WAREHOUSE ON ACCOUNT TO ROLE CORTEX_LAB;

-- Grant for Analyst
GRANT ROLE ACCOUNTADMIN TO ROLE CORTEX_LAB;

USE ROLE CORTEX_LAB;

-- Create Database
CREATE OR REPLACE DATABASE CORTEX_LAB_DB;

-- Create Schema
CREATE OR REPLACE SCHEMA CORTEX_LAB_SCHEMA;

-- Create Warehouse
CREATE OR REPLACE WAREHOUSE CORTEX_LAB_WH
WITH WAREHOUSE_SIZE = 'X-SMALL'
AUTO_SUSPEND = 120
AUTO_RESUME = TRUE
INITIALLY_SUSPENDED = TRUE;

USE WAREHOUSE CORTEX_LAB_WH;

-- Enable Cortex Cross-Region
ALTER ACCOUNT SET CORTEX_ENABLED_CROSS_REGION = 'ANY_REGION';

-- Grant Usage on Database
GRANT USAGE ON DATABASE CORTEX_LAB_DB TO ROLE CORTEX_LAB;

-- Grant Usage on Schema
GRANT USAGE ON SCHEMA CORTEX_LAB_DB.CORTEX_LAB_SCHEMA TO ROLE CORTEX_LAB;

-- Grant Usage on Warehouse
GRANT USAGE ON WAREHOUSE CORTEX_LAB_WH TO ROLE CORTEX_LAB;


--------------------------------Create Table---------------------------------------------

CREATE OR REPLACE TABLE CORTEX_LAB_DB.CORTEX_LAB_SCHEMA.MEDICAL_BOOKS (
    TITLE STRING,
    AUTHORS STRING,
    DESCRIPTION STRING,
    CATEGORY STRING,
    PUBLISHER STRING,
    PRICE_STARTING_WITH FLOAT,
    PUBLISH_DATE_MONTH STRING,
    PUBLISH_DATE_YEAR INT
);

COPY INTO CORTEX_LAB_DB.CORTEX_LAB_SCHEMA.MEDICAL_BOOKS
FROM @CORTEX_ANALYSTSTAGE/Medical_books_clean.csv
FILE_FORMAT = (
    TYPE = 'CSV',
    FIELD_OPTIONALLY_ENCLOSED_BY = '"',
    SKIP_HEADER = 1,
    FIELD_DELIMITER = ',',
    NULL_IF = ('')
)
ON_ERROR = CONTINUE;

-- Create a New Streamlit app in Snowflake. Make sure you use the same datbase and schema for to create this app. 
-- copy paste the streamlit.py code from the repo to your SiS (Streamlit in Snowflake) app. Run it


---------------Sample questions to test your app---------------

1. show top 10 most common categories of scientific books?
2. How many scientific books are in the dataset?
3. What is the average price of books in each category?
4. What is the average price of scientific books?
5. How many books were published in each category per year?

Sample SQL generated: 

WITH BookCategories AS (
    SELECT CATEGORY, COUNT(TITLE) AS category_count
    FROM cortex_lab_db.cortex_lab_schema.MEDICAL_BOOKS
    GROUP BY CATEGORY
)
SELECT CATEGORY, category_count
FROM BookCategories
ORDER BY category_count DESC
LIMIT 10;