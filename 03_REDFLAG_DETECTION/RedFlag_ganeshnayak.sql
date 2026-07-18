-- --------REDFLAG FRAUD FILES--------------
select count(*) from redflag.transactions;
select count(distinct user_id) from redflag.transactions;
select min(txn_time),max(txn_time) from redflag.transactions;
-- tier 1 
-- pattern-1 (velocity fraud)
select user_id,Date(txn_time) as attack_date,count(*) as daily_tranx_count
from transactions group by user_id,date(txn_time)
having count(*)>=30
order by daily_tranx_count desc;
-- returned  50 rows---
-- pattern 2 (round amount clustering)
select user_id,count(*) as round_txns from transactions
where amount in (100,200,500,1000,2000,5000,10000)
group by user_id
having count(*) >= 15;
-- 25 rows returned =======

-- pattern-3 (card testing)

select  user_id ,Date(txn_time) as test_date ,count(*) as txn_count 
from transactions where  amount<10
group by user_id,date(txn_time)
having count(*)>= 30;
-- returned 20 rows==========

-- pattern-4 (filed_then-succeded )

select user_id,count(*) as failed_count
from transactions 
where status= 'Failed'
group by user_id
having count(*)>=20;
-- returned 25 rows====

--  pattern-5 (odd hour concentataion)
select user_id,
count(*) as total_txns, 
sum(case when hour(txn_time) between 2 and 4 and 1 then 1 else 0 end) as odd_hour_txns
from transactions 
group by user_id
having count(*) >= 30
	and (odd_hour_txns/count(*))>=0.8;
    -- returned 20 rows=====
-- TIER - 2
-- PATTERN-6 (MULE ACCOUNTS)
select user_id,COUNT(*) AS CREDIT_COUNT
FROM transactions 
where txn_type= 'credit'
group by user_id
having count(*)>=8;
 -- returned 30 rows
 
-- pattern -7 (refund Abuse)

select user_id,
count(*) as total_txns,sum(case when txn_type='REFUND' THEN 1 ELSE 0 END) AS REFUND
from transactions group by user_id
having count(*)>=20
and (REFUND/count(*))>0.4;
-- returned 24 rows

-- PATTERN -8 (MERCANT COLLUTSION)
WITH USER_VOLUME AS (
SELECT merchant_id,user_id,sum(amount) as total_amount
from transactions 
group by merchant_id,user_id),
ranked as 
(select merchant_id,user_id,total_amount,
row_number() over (partition by merchant_id order by total_amount desc) as rn
from user_volume),
top5 as (
select merchant_id,sum(total_amount) as top5_sum
from ranked where rn <=5
group by merchant_id),
merchant_total as (
select merchant_id,sum(amount) as merchant_sum
from transactions 
group by merchant_id)

select m.merchant_id
from merchant_total m
join top5 t on m.merchant_id=t.merchant_id
where t.top5_sum/m.merchant_sum>0.6;
-- returned 15 rows =====

-- pattern - 9 (just under threshold)
select user_id ,count(*) as structuring_count
from transactions
where amount=9999.00
group by user_id
having count(*)>=10;
-- returned 20 rows ===

-- pattern 10------
with gaps as (
select user_id,txn_time, 
lag(txn_time) over (partition by user_id order by txn_time) as prev_time
from transactions)
select user_id
from gaps where timestampdiff(day,prev_time, txn_time)>=90
group by user_id
having count(*)>=15;
-- returned  0 rows ======
-- TIER - 3
-- PATTERN -11---------
-- VELOCITY SPIKE--------
with monthly as (
select user_id,date_format(txn_time,'%Y-%m') AS MONTH,COUNT(*) AS txn_count
from transactions 
group by user_id,Date_FORMAT(txn_time,'%Y-%m')),
stats as (
select user_id, avg(txn_count)as avg_txns,
max(txn_count) as peak_txns
from monthly 
group by user_id)
select user_id
from stats where peak_txns>=20 and peak_txns/avg_txns>=5;
-- returned 3 rows =====
-- pattern -12 ----------
-- geographical impossibility--------

with city_moves as (
select user_id,city,txn_time,
lag(city) over (partition by user_id order by txn_time) as prev_city,
lag(txn_time) over (partition by user_id order by txn_time) as  prev_time
from transactions)
select user_id,txn_time,city,prev_city
from city_moves
where city<> prev_city
and timestampdiff(minute,prev_time, txn_time)<=60;
-- returned 80 rows =======