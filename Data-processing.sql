/* ingest into staging tables */

--drop table stg_users;
--drop table stg_transactions;
--drop table stg_commission;
--
--drop table transactions cascade;
--drop table users cascade;
--drop table commissions cascade;

create table if not exists stg_users (
	user_id varchar(255),
	first_tran_date date,
	location varchar(128),
	age varchar(128),
	gender varchar(128)
);

copy stg_users(user_id, first_tran_date, location, age, gender)
from 'D:\OneDrive\Data analysis\Momo_takehome\data\users.csv'
delimiter ','
csv header;

create table if not exists stg_transactions (
	user_id varchar(255),
	order_id varchar(255),
	trans_date date,
	amount varchar(255),
	merchant_id varchar(255),
	purchase_status varchar(255)
);

copy stg_transactions from 'D:\OneDrive\Data analysis\Momo_takehome\data\transactions.csv'
delimiter ','
csv header;

create table if not exists stg_commission (
	merchant_name varchar(128),
	merchant_id varchar(255),
	rate_pct varchar(255)
);


insert into stg_commission (merchant_name, merchant_id, rate_pct) 
values ('viettel', 12, 2),
		('mobifone', 13, 3),
		('vinaphone', 14, 4),
		('vietnamobile', 15, 4),
		('gmobile',16,4);


/*-------------- DATA PROCESSING -----------------*/

/*-------------------
 1. USERS
---------------------*/


-- check to see if the id is unique
	
select count(*) from stg_users su; -- there are 13,428 observations, how many of that are unique?
select count(distinct user_id) from stg_users su; -- only 13,390 obs, what causes the dups?

--- *** take a look at the duplicates


select * from stg_users su where user_id in 
(SELECT user_id
FROM stg_users su2 
GROUP BY user_id 
HAVING COUNT(*) > 1) order by user_id ;


--> it seems that these duplicates are from the historical data left by every update. Solution?

--### Solution: remove all the duplicates in both the users as it wont affect the analysis

delete from stg_users where user_id in (SELECT user_id
FROM stg_users su2 
GROUP BY user_id 
HAVING COUNT(*) > 1);


-- check to see if there are any null values in any of the columns

select * from stg_users su where user_id is null;
select * from stg_users su where first_tran_date is null;
select * from stg_users su where "location" is null;
select * from stg_users su where age is null;
select * from stg_users su where gender is null;

--> there are not any null values

--** data integrity check **--

--# gender column

select distinct gender from stg_users su ; --there are a lot of inconsistent inputs

-- fix the data integrity problem
update stg_users set gender = 'female' where gender in ('N?','f');
update stg_users set gender = 'male' where gender in ('M','Nam');
update stg_users set gender = upper(gender); 

-- verify
select gender from stg_users su ;
select distinct gender from stg_users su;


--# age column
select distinct age from stg_users su order by age; -- this col. is all good


--# set unknown to NULL
SELECT
    COUNT(CASE WHEN lower(user_id) = 'unknown' THEN 1 ELSE NULL END) AS user_id_unknown_count,
    COUNT(CASE WHEN lower("location") = 'unknown' THEN 1 ELSE NULL END) AS location_unknown_count,
    COUNT(CASE WHEN lower(age) = 'unknown' THEN 1 ELSE NULL END) AS age_unknown_count,
    COUNT(CASE WHEN lower(gender) = 'unknown' THEN 1 ELSE NULL END) AS gender_unknown_count
FROM stg_users;

-- only the age and location column has "unknown" values, let's set it right:

update stg_users set
age = null where age = 'unknown';
	
update stg_users set
"location" = null where lower("location") = 'unknown';

-- recode the values for location column
select distinct "location" from stg_users su ;

update stg_users set 
	"location" = 'HCMC' where "location" = 'Ho Chi Minh City';

update stg_users set "location" = 'Other' where lower("location") = 'other cities';
	
select * from stg_users su where age is not null;

/*-------------------
 2. TRANSACTIONS
---------------------*/

select distinct amount from stg_transactions st;
select distinct merchant_id from stg_transactions st ;
select distinct purchase_status from stg_transactions st ;

-- recode the null values in the purchase_status column
update stg_transactions 
set purchase_status = case
	when purchase_status is null then 'truc tiep' 
	when purchase_status = 'Mua h?' then 'mua ho' 
	else purchase_status 
end;

-- replace the ',' separators in the amount col and convert it into int type.

alter table stg_transactions add column amount_int int;

update stg_transactions set amount_int = cast(replace(amount,',','') as int);

alter table stg_transactions drop column amount;

alter table stg_transactions rename column amount_int to amount;

select * from stg_transactions st ;

-- check order_id uniqueness 
select count(*) from stg_transactions st;

select count( distinct order_id) from stg_transactions st ;


delete from stg_transactions where user_id not in (select distinct user_id from stg_users);


/*-------------------
 3. LOAD DATA INTO TABLES
---------------------*/
select distinct "gender" from stg_users su ;

create type gender_list as enum('MALE','FEMALE');
create table if not exists users (
	user_id integer primary key,
	first_tran_date date not null,
	"location" varchar(128),
	"age" varchar(128),
	"gender" gender_list
	);

insert into users(user_id, first_tran_date, "location","age", gender)
select 
	cast(user_id as int) as user_id, 
	first_tran_date,
	"location", age, 
	cast(gender as gender_list) as gender 
from stg_users;



create table if not exists commissions (
	merchant_name varchar(128) not null,
	merchant_id int primary key,
	rate_pct numeric not null
);

insert into commissions
select 
	merchant_name,
	cast(merchant_id as int) as merchant_id,
	cast(rate_pct as numeric) as rate_pct
from stg_commission ;



drop table transactions;
create type status as enum('truc tiep', 'mua ho');
create table if not exists transactions (
	user_id int references users,
	order_id bigint primary key,
	trans_date date not null,
	merchant_id int references commissions,
	purchase_status status,
	amount int not null
);


insert into transactions
select
	cast(user_id as int) as user_id,
	cast(order_id as bigint) as order_id,
	trans_date,
	cast(merchant_id as int) as merchant_id,
	cast(purchase_status as status) as purchase_status,
	amount 
from stg_transactions ;

select count(*) from transactions;


