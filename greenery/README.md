## Week 1 Project 

**Q1 : How many users do we have?**

A1 : 130

```sql
select 
count(user_id) 
from dbt_carlos_a.stg_users
```

**Q2 : On average, how many orders do we receive per hour?**

A2 : 7.5


```sql
with orders_per_hour as (select 
extract(day from created_at) o_day, 
extract(hour from created_at) o_hour,
count(order_id) order_amt
from dbt_carlos_a.stg_orders
group by 1,2)

select avg(order_amt) avg_orders_per_hour from orders_per_hour
```


**Q3: On average, how long does an order take from being placed to being delivered?**

A3 : 3 days 21 hours 24 minutes and 11 seconds 


```sql
with lead_times as (select 
delivered_at - created_at diff
from dbt_carlos_a.stg_orders
where delivered_at is not null)

select avg(diff) avg_time from lead_times
```

**Q4 : How many users have only made one purchase? Two purchases? Three+ purchases? **

A4: 

1 purchase : 25
2 purchases : 28
3+ purchases : 71

```sql
with amt as (select 
user_id,
count(order_id) purchases_per_user
from dbt_carlos_a.stg_orders
group by 1)

select purchases_per_user, count(amt_orders) amount_of_users from amt group by 1 order by purchases_per_user asc
```

**Q5 : On average, how many unique sessions do we have per hour?**

A5 : 16.3

```sql
with sessions_per_day_hour as (select 
extract(day from created_at) o_day, 
extract(hour from created_at) o_hour,
count(distinct session_id) session_amt
from dbt_carlos_a.stg_events
group by 1,2)

select avg(session_amt) from sessions_per_day_hour
```
