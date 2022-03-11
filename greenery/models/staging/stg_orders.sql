with orders as (

select
order_id,
user_id,
promo_id,
address_id,
created_at,
order_cost,
tracking_id,
shipping_service,
estimated_delivery_at,
delivered_at,
status
from {{ source('pg', 'orders') }}
),

final as (
    select * from orders
)

select * from final