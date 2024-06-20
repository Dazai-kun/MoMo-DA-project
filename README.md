# Overview

This project aims to analyze the performance of MoMo's top-up service.

The data includes:
* Historical daily transactions from Jan-Dec 2020 (table 'Transactions')
* Users' demographic information (table 'User_info')
* Commission percentages paid by Telco merchants to MoMo (table 'Commission')

MoMo's top-up service allows users to recharge prepaid phone accounts via e-Wallet apps, Internet, SMS, or bank accounts. It functions like an online money transfer using phone numbers. Supported network operators include Mobifone, Viettel, VinaPhone, Vietnamobile, and Wintel.

The analysis consists of three steps:

* Use SQL queries to process raw data and derive insights on MoMo's monthly KPIs (Part A).
* Create an interactive Tableau dashboard to track these KPIs (Part B).
* Conduct an in-depth analysis of MoMo's top-up business and offer recommendations to improve monthly performance (Part C).

# The Analysis
### Part A
The initial analysis with PostgreSQL reveals:

* Total revenue in January 2020: 1,409,227 VND
* Most profitable month: September
* Highest average revenue day: Wednesday
* Lowest average revenue day: Monday
* New users in December 2020: 71
### Part B
To better understand the business, I created a performance-tracking dashboard to monitor key KPIs related to the Top-up service's monthly performance. The dashboard is accessible through Tableau Public or by opening the Tableau workbook file (.twb) in this repository. Here's a snapshot of the dashboard.

![image](https://github.com/Dazai-kun/MoMo-DA-project/assets/35169418/954753dd-cc77-4200-acd1-92754b7c5702)


