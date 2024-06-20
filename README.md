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
To better understand the business, I created a performance-tracking dashboard to monitor key KPIs related to the Top-up service's monthly performance. The dashboard is accessible through [Tableau Public](https://public.tableau.com/views/Momo-TopupDashboardlatest/Dashboard?:language=en-US&publish=yes&:sid=&:display_count=n&:origin=viz_share_link) or by opening the Tableau workbook file (.twb) in this repository. Here's a snapshot of the dashboard.

![image](https://github.com/Dazai-kun/MoMo-DA-project/assets/35169418/954753dd-cc77-4200-acd1-92754b7c5702)

### Part C
#### 1. Further analysis reveals interesting facts about user demographics and transaction behavior:

- **Age Demographics**: Customers aged 23 to 32 have the highest transaction volume and value, making them a key target demographic.

  ![Age Demographics](https://github.com/Dazai-kun/MoMo-DA-project/assets/35169418/b73c0450-66ec-4fb8-b74c-373f24df5e4b)

- **Gender Demographics**: High-value transactions are predominantly made by males, while females show lower frequency and average transaction value. The lower frequency may be due to a smaller user base, but the lower average amount requires attention.

  ![Gender Demographics](https://github.com/Dazai-kun/MoMo-DA-project/assets/35169418/fd21938c-bb78-437e-9da0-3c93f4f35877)

- **Location Insights**:
  * HCMC dominates with the highest total revenue despite lower transaction volume in other locations.
  * Hanoi shows comparable average revenue per transaction to HCMC, indicating significant revenue potential with increased transaction volume.
  * Other locations have high transaction volume but lower average revenue per transaction, suggesting opportunities for revenue optimization.

   ![image](https://github.com/Dazai-kun/MoMo-DA-project/assets/35169418/9fad18f4-31e6-4719-a86d-788cdac20014)

    
- **RFM Ananlysis**
  Using RFM analysis, I segmented users into 5 groups:
  * Group 5: Top spenders and highly engaged, crucial for revenue and retention.
  * Group 4: High spenders, contributing 86% of Group 5's revenue, with potential for top-tier conversion.
  * Group 3: Largest group, moderate spend, significant opportunity for higher value conversion.
  * Group 2: Low spenders with engagement potential, suitable for targeted growth initiatives.
  * Group 1: Least engaged, minimal revenue impact, requiring minimal retention efforts.
  Groups 1 and 2 may benefit from education on regular top-up service usage, such as for phone bills, to increase engagement and value.

    ![image](https://github.com/Dazai-kun/MoMo-DA-project/assets/35169418/9a3bcfcc-5e59-4572-82a1-b60e9151f021)

#### 2. Marketing promotion strategies to improve performance
Based on the previous insights, I recommend the following strategies to enhance performance:

**Enhance Retention of High Value Users**
* Personalized offers and loyalty programs: Exclusive benefits to maintain satisfaction and spending.
* Exceptional customer service: Top-notch support for high-value users.
**Convert High Potential Users**
* Replicate successful strategies: Apply Group 5 engagement tactics to Group 4.
* Targeted marketing: Highlight additional services and benefits to boost loyalty.

**Increase Engagement of Mid-Range Users**
* Consistent communication: Regular and targeted messages to keep users engaged.
* Promotions and incentives: Encourage increased transactions and usage.

**Educate and Convert Low Engagement Users**
* Educational campaigns: Teach the benefits of using MoMo Top Up for regular payments.
* Introductory promotions: Attractive offers to encourage frequent use.
* Simplify user experience: Remove barriers for easier access and use.

**Target Key Demographic (Ages 23-32)**
* Tailored marketing campaigns: Emphasize features and benefits for this age group.
* Social media and influencers: Increase reach and engagement with popular platforms and personalities.
* Targeted campaigns in certain locations: Focus on promoting higher-value top-up options in Ho Chi Minh City, increasing transaction volume in Hanoi through localized campaigns, and incentivizing larger transactions in other locations to optimize Topup's monthly performance.

**Address Gender Differences in Transactions**
* Increase female engagement: Targeted strategies to boost female users.
* Understand and address lower transaction amounts: Investigate reasons and provide incentives for higher transactions.





