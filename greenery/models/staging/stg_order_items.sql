with order_items as (

select
order_id,
product_id,
quantity
from {{ source('pg', 'order_items') }}
),

final as (
    select * from order_items
)

select * from final