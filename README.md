# Database_PosgreSQL
### This repository includes everything that I have done in the Database course for which I took in my master at Schulich.
### The primary software that I use for this course is PostgreSQL.
### This repository contains all of my assignments as well as the projects that I have been worked on.
### Please take a look!!! And have fun!!!
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
## 5100_DB_Group_Assignment_1.sql:
In this sql file, I practiced using queries to analyze and gain insights from the bakery_sales data set.

-------------------------------------------------------------------------------------------------------------------------------------------------------------------
## A2 - Data Ingestion Pipeline.ipynb:
In this jupyternote book, My group developed a data ingestion pipeline to pull data from the Ontario Data Catalog, which we aimed at pulling data that contains information on violent crime rates in Ontario from 2008 to 2012. The dataset is available in CSV format named: "violent_crime_rates.csv"

In this file, our group used API technique to request connection between our terminal and the website source end. We used request library for that part and then standardized the content from the website in a json file. And we did a data extraction using the according attributes. Finally we did a data cleaning to prepare the data for the file to be ready to submit.

-------------------------------------------------------------------------------------------------------------------------------------------------------------------
## P1_customer_360.sql:
This is the project that I did in this course for which it analyze cutomer lifetime value. 
It is a valid forecast of a customer's future profits and is used to measure how valuable a customer (user) is to the organization over a period of time.

This SQL script is structured to analyze customer behavior in terms of conversions and orders.
It aims to link conversion events (like subscribing or making a purchase) with specific order details, providing a comprehensive view of customer activity.
The script for a Customer 360 view, to understand and analyze customer interactions and behaviors across various touchpoints.

I utilized ROW_NUMBER(), and LEAD() functions, partitioned by customer_id and ordered by conversion_date to analyze reccurrence and sequence of conversion.
I did time frame analysis, date-related analysis, and order-week analysis to provide a comprehensive view on customer engagements and interactions.
