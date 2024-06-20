
/*----------------
-- PART C
*/---------------


--## PROBLEM 6: Based on the provided data, what observations and insights can you draw about user demographics and transaction behavior (e.g. trends, classifications)?

-- User demographics

--##### Age group analysis

-- Identify which age groups are most active and generate the most revenue. -- 

select age, count(*), sum(amount), sum(revenue) from transactions t group by age order by sum(revenue) desc; -- age group 23 to 32 is the most active and this age group also generates the most revenue

--> customers aged 23 to 32 show the highest transaction volume and value, indicating a key target demographic.

--##### Gender distribution

select 
    gender,
    count(*) as num_customers,
    round(100.0 * count(*) / sum(count(*)) over (), 2) as percentage
from users u 
group by gender;

--##### High-value transactions by gender

with high_value_transactions as (
    select 
        user_id,
        order_id,
        amount
    from transactions
    where amount > (select avg(amount) from transactions t)  -- Assuming above average is the high-value threshold
)
select
    u.gender,
    count(hvt.order_id) as high_value_transaction_count,
    sum(hvt.amount) as total_high_value_amount,
    avg(hvt.amount) as avg_high_value_amount
from users u
join high_value_transactions hvt on u.user_id = hvt.user_id
group by u.gender;
-->>> High-value transactions are predominantly made by men, while women exhibit both lower frequency and average amount in high-value transactions.
-- The lower transaction frequency for women is due to a smaller user base, but the lower average amount needs attention and improvement.



--##### Geographical analysis

select 
	"location",
	count(order_id) as total_transactions,
	sum(revenue) as total_revenue,
	avg(revenue) as average_revenue
from transactions t
group by "location"
order by average_revenue desc;

--> *Ho Chi Minh City generates the highest average and total revenue, making it ideal for large marketing campaigns and events.
--- *Despite lower transaction volume, Hanoi's average revenue is nearly as high as Ho Chi Minh City's, indicating significant potential.

--##### RFM analysis

with latest_date as (
    select max(trans_date) as max_date
    from transactions
), 
base as
(select 
	user_id,
	max(trans_date) as most_recently_purchase_date,
	(ld.max_date - max(t.trans_date)) as recency_score,
	count(order_id) as frequency_score,
	sum(revenue) as monetary_score
from transactions t,
	latest_date ld
group by user_id, ld.max_date
),
rfm_score as (
select
	user_id,
	recency_score,
	ntile(5) over(order by recency_score DESC) as R,
	ntile(5) over(order by frequency_score) as F,
	ntile(5) over(order by monetary_score) as M
from base
order by R desc)
select 
	(R+F+M)/3 as rfm_group,
	count(rfm.user_id) as user_count,
	sum(base.monetary_score) as total_revenue,
	cast(sum(base.monetary_score)/count(rfm.user_id) as decimal(12,2)) as avg_revenue_per_user
from rfm_score as rfm join base on base.user_id = rfm.user_id
group by rfm_group order by rfm_group desc;

-- from the data, group 5 customers although accounted for only 3.56% but they are the highest spenders on average.
-- 43.8% is only using momo topup service sparingly, we need to find ways to convert these into the higher tier
-- maybe they are not used to paying phone bills with top up services. that's why we might need to focus on educating these groups of users.
-- group 4 + 5 accounted for 23.2% user base. revenue generated from group 4 equals to 86% of group 5, implying a good potential to convert
-- group 4 users to the highest valued group. We just need to find that one sweet spot. 
-- the mid-range user group accounted for 33% of the user base. this is where the largest portion of users belongs. we have to at least maintain
-- this level of engagement. but the better outcome would be to have this mid-range group join group 4 as soon as possible. 



--## PROBLEM 8

-- 1. Calculate the CLV of for a new user

WITH total_revenue_per_user AS (
    SELECT 
        type_user, 
        SUM(revenue) AS total_revenue
    FROM 
        transactions
    GROUP BY 
        type_user
),
first_and_last_transaction AS (
    SELECT 
        type_user, 
        MIN(first_tran_date) AS first_tran_date, 
        MAX(trans_date) AS last_tran_date
    FROM 
        transactions
    GROUP BY 
        type_user
),
customer_lifespan AS (
    SELECT 
        type_user, 
        AVG(DATE_PART('day', AGE(last_tran_date, first_tran_date))) AS avg_lifespan_days
    FROM 
        first_and_last_transaction
    GROUP BY 
        type_user
),
avg_transaction_value AS (
    SELECT 
        type_user, 
        AVG(amount) AS avg_amount
    FROM 
        transactions
    GROUP BY 
        type_user
),
transaction_frequency AS (
    SELECT 
        type_user, 
        (COUNT(order_id)::float / COUNT(DISTINCT trans_date))/(count(distinct user_id)) as avg_transactions_per_day --per type 
    FROM 
        transactions
    GROUP BY 
        type_user
)
SELECT 
    tr.type_user,
    tr.total_revenue,
    cl.avg_lifespan_days,
    atv.avg_amount,
    tf.avg_transactions_per_day,
    (atv.avg_amount * tf.avg_transactions_per_day * cl.avg_lifespan_days) AS clv  -- CLV without profit margin
FROM 
    total_revenue_per_user tr
JOIN 
    customer_lifespan cl ON tr.type_user = cl.type_user
JOIN 
    avg_transaction_value atv ON tr.type_user = atv.type_user
JOIN 
    transaction_frequency tf ON tr.type_user = tf.type_user;

  ----> 
   
-- 2. Calculate the additional cost for the proposed cashback rates   


create temp table if not exists cashback_rates (
	merchant_id int primary key,
	current_cashback int not null,
	proposed_cashback decimal(16,2) not null
);

insert into cashback_rates
values (12, 1, 2),  -- Viettel
        (13, 1, 2.5), -- Mobifone
        (14, 1, 3), -- Vinaphone
        (15, 1, 3), -- Vietnamobile
        (16, 1, 3); -- Gmobile

with total_amount_per_merchant as (
	select
		merchant_id,
		sum(amount) as total_amount
	from transactions t
	group by merchant_id
), additional_cost_per_merchant as (
select 
	tr.merchant_id,
    tr.total_amount,
    cr.current_cashback,
    cr.proposed_cashback,
    (tr.total_amount * cr.current_cashback / 100) AS current_cashback_cost,
    (tr.total_amount * cr.proposed_cashback / 100) AS proposed_cashback_cost,
    ((tr.total_amount * cr.proposed_cashback / 100) - (tr.total_amount * cr.current_cashback / 100)) AS additional_cashback_cost
FROM 
    total_amount_per_merchant tr
JOIN 
    cashback_rates cr ON tr.merchant_id = cr.merchant_id
)
select 
	avg(additional_cashback_cost) as avg_additonal_cost
from additional_cost_per_merchant ad;








