## Week 2 Project 

## Part 1

**Q1 : What is our user repeat rate?**

A1 : 79.8%

```sql
with user_count as (
select
user_id, 
count(distinct order_id) as total_user_purchase
from dbt_carlos_a.stg_orders
group by 1
),

classification as (
select
sum(case when total_user_purchase > 1 then 1 end) repeat_user,
sum(case when total_user_purchase = 1 then 1 end) one_time_user
from user_count
)

select
repeat_user,
one_time_user,
repeat_user :: decimal / (repeat_user :: decimal  + one_time_user :: decimal ) retention_rate
from classification
```

**Q2 : What are good indicators of a user who will likely purchase again? What about indicators of users who are likely NOT to purchase again? If you had more data, what features would you want to look into to answer this question?**

A2 : 

I think we could discover users who are likely to purchase again by looking at:

1. The basket of products they bought
2. If we delivered the order on time (good experience)
3. If they have visited our website/app after making their first order
4. If they have been given a promo code after their first order

On the contrary, users who had their orders delivered late or haven't been visiting our website/app after their first purchase are likely to not purchase again.

With more data about the products they purchased or maybe order reviews (5 star vs 1 star orders) we could make better inference about repeated customers.


**Q3 : Explain the marts models you added. Why did you organize the models in the way you did? ?**

I added some basic marts like dim_products, dim_users and fact_orders which are a copy of the staging models given the data structure

I also added a user_order_activity model in the marketing mart with a summary per user of total spent, amount of orders, last order date and days since last order. This could be helpful to quickly determine users who are big spenders but haven't purchased recently, and trigger a retention action.


## Part 2 ## 

**What assumptions are you making about each model? (i.e. why are you adding each test?)** 

I'm making some basic assumptions about the data generating process for each model, for example:

* fact_orders: every order has an id, and this id is unique (no duplicate lines for each order in the table)
* dim_products: every product has an id, and this id is unique for each product
* dim_users: every user has an id, and this id is unique for each user
* fact_page_views: every event has an id and a session id, also checked for accepted values for each event type, in case an uknown event type appears afterwards

**Did you find any “bad” data as you added and ran tests on your models? How did you go about either cleaning the data in the dbt model or adjusting your assumptions/tests?**

No bad data was found, but I think with more testing I can find some "errors"

**Your stakeholders at Greenery want to understand the state of the data each day. Explain how you would ensure these tests are passing regularly and how you would alert stakeholders about bad data getting through.**

After carefully constructing the dbt project, I would schedule our daily dbt build with a cronjob.
I would configure some automatic slack alerts and maybe some email alerts when tests fail. Also I think its important for everyone to know when the models are done building and data can be safely consumed.