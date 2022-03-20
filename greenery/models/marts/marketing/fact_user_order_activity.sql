with usage_metrics as (

select user_id, 
sum(order_cost) total_spend, 
count(distinct order_id) order_count,
max(created_at) last_order_date,
current_date - max(created_at) days_since_last_order
from {{ ref('stg_orders') }}
group by 1
),


final as (

select 
user_id,
total_spend,
order_count,
last_order_date,
days_since_last_order
from usage_metrics

)

select * from final