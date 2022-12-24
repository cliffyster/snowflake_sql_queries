// First step: Load Raw JSON

//You need to create schemas before you can load data
CREATE OR REPLACE SCHEMA MANAGE_DB.EXTERNAL_STAGES;
CREATE OR REPLACE  SCHEMA MANAGE_DB.FILE_FORMATS;

CREATE OR REPLACE stage MANAGE_DB.EXTERNAL_STAGES.JSONSTAGE
     url='s3://bucketsnowflake-jsondemo';

CREATE OR REPLACE file format MANAGE_DB.FILE_FORMATS.JSONFORMAT
    TYPE = JSON;

//Need to create database and warehouse before you can load the raw file
CREATE OR REPLACE DATABASE OUR_FIRST_DB;     
CREATE OR REPLACE warehouse OUR_FIRST_DB;
    
CREATE OR REPLACE table OUR_FIRST_DB.PUBLIC.JSON_RAW (
    raw_file variant);

//Use warehouse in order for the below copy into function to work 
USE WAREHOUSE OUR_FIRST_DB;
    
COPY INTO OUR_FIRST_DB.PUBLIC.JSON_RAW
    FROM @MANAGE_DB.EXTERNAL_STAGES.JSONSTAGE
    file_format= MANAGE_DB.FILE_FORMATS.JSONFORMAT
    files = ('HR_data.json');
    
   
SELECT * FROM OUR_FIRST_DB.PUBLIC.JSON_RAW;