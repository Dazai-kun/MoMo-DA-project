/*----------------------------------------
 * WORKSPACE
 *--------------------------------------- */

-- PART A
--## PROBLEM 1

/*Using data from the 'Commission' table, 
 * add a column 'Revenue' in the 'Transactions' table that displays MoMo's earned revenue for each order, 
 * and then calculate MoMo's total revenue in January 2020.*/


/**** add a column 'Revenue' in the 'Transactions' table that displays MoMo's earned revenue for each order ****/

alter table transactions add column revenue double precision;
-- Step 1: Calculate revenue using a CTE
WITH revenue_calculation AS (
    SELECT t.order_id, t.merchant_id, t.amount, c.rate_pct, (c.rate_pct * t.amount / 100) AS revenue
    FROM transactions t
    JOIN commissions c ON c.merchant_id = t.merchant_id
)
-- Step 2: Update transactions table
UPDATE transactions AS t
SET revenue = rc.revenue
FROM revenue_calculation rc
WHERE t.order_id = rc.order_id;


/****  calculate MoMo's total revenue in January 2020 ****/

select sum(revenue) from transactions t where trans_date between '2020-01-01'and '2020-01-31';

select order_id ,trans_date, sum(revenue) over(order by trans_date rows between unbounded preceding and unbounded following) from transactions where trans_date BETWEEN '2020-01-01' AND '2020-01-31';

--> MOMO'S TOTAL REVENUE IN JAN 2020 IS 1,409,227.02 vnd

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--## PROBLEM 2
/*What is MoMo's most profitable month?*/

select 
	to_char(date_trunc('month', trans_date), 'month') as trans_month,
	sum(revenue) as monthly_revenue 
from transactions t 
	group by trans_month 
	order by monthly_revenue desc;
--> the most profitable month is September.
--> the least profitable month is February.

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--## PROBLEM 3
/*What day of the week does MoMo make the most money, on average? The least money?*/

select
	to_char(date_trunc('day',trans_date),'day') as day_of_week,
	avg(revenue) as avg_revenue_dow
from transactions t group by day_of_week
order by avg_revenue_dow desc;

--> momo makes the most money on wednesday and the least money on monday.

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--## PROBLEM 4
/*Combined with the 'User_Info' table, add columns: Age, Gender, Location, Type_user (New/Current) in 'Transactions' table and calculate the total number of new users in December 2020.
 * (New = the transaction was in the month of the first time the user used Topup; Current = the user had used Topup before that month)
 * */

-- Step 1: add the new columns to transactions table
alter table transactions 
	add column "age" varchar(128),
	add column "gender" gender_list,
	add column "location" varchar(128),
	add column "type_user" varchar(64),
	add column "first_tran_date" date;

-- Step 2: populate the newly-added columns with the right data from users table
update transactions tns
set 
	age = u.age,
	gender = u.gender,
	"location" = u."location",
	"first_tran_date" = u.first_tran_date 
from users u
where tns.user_id = u.user_id;


-- Step 3: Setting the conditions for type_user column with new/current values

update transactions set type_user = case
	when to_char(date_trunc('month', first_tran_date), 'YYYY-month') = to_char(date_trunc('month', timestamp '2020-12-01 00:00:00'), 'YYYY-month') then 'new'
	else 'current'	
end;


-- Step 4: Calculate the total number of new users in December 2020

select count(distinct user_id) from transactions t where type_user = 'new';

--> THERE ARE 71 NEW USERS IN DECEMBER 2020
















