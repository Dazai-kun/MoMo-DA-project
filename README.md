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

#### 3. Due to aggressive cashback strageties from other vendor merchants, MoMo is considering deducting a part of revenue to increase cashback for users in all Telco merchants. How would it affect the service? The proposed change is as follows:

| Merchant       | % cashback (current) | % cashback (proposed) |
| :------------- | -------------------: | --------------------: |
| Viettel        | 1                    | 2                     |
| Mobifone       | 1                    | 2.5                   |
| Vinaphone      | 1                    | 3                     |
| Vietnamobile   | 1                    | 3                     |
| Gmobile        | 1                    | 3                     |

To assess the affects of adopting the new cashback rates on MoMo’s Topup service, there are four perspectives to consider, of which I consider the fourth to be of most importance.

**Customer perspective**
- The increased cashback rates may have positive effects in retaining existing users and encourage both current and new users to be more active in using MoMo’s top-up services.
- This would likely lead to a rise in transaction volumes, although there is not enough data to predict the quantity. 

**Competitive perspective**
- By offering higher cashback rates, MoMo can solidify its position in the market due to cashback and discounts being significant drivers of user preference.
- However, this is a double-edged sword as this could very well turn out to be a lose-lose cashback war for MoMo and its competitors. 

**Strategic perspective**
- In the short term, increased cashback can rapidly grow the user base. However, MoMo must consider long-term sustainability and whether it can maintain these rates or if they are a temporary measure to gain market share.

**Financial perspective**
- Doubling or even tripling the cashback rates may bring MoMo under a tremendous financial stress. If not planned out well, it could leave the company’s finance in shambles. However, the following simple calculations have convinced me that the proposed rates are very sustainable:
    * Cost-Benefit Analysis of Increased Cashback Rates

      **Strategic Justification:**
      - Higher cashback is a form of marketing expense.
      - If the additional cashback cost is lower than other acquisition costs (advertising, promotions), it could be more efficient.

      **Profitability Assessment:**
      - Evaluated by comparing the increased cashback cost against the Customer Lifetime Value (CLV) of new users.
      - For profitability, the aggregate benefit from new users must offset the additional cashback costs.

      **Calculation Insights:**
      - To break even, new user count (N) must be ≥ cost/CLV ratio.
      - Based on my analysis (see [Part-C.sql](https://github.com/Dazai-kun/MoMo-DA-project/blob/main/Part-C.sql)), N needs to exceed 45.8, roughly under half of the current average new users.
       
      **Feasibility:**
      - Given the rapid growth of digital wallet adoption globally and the specific trends in Vietnam, achieving the above amount of average new users per month is, in my opinion and with limited data, completely attainable. 

THE END!


