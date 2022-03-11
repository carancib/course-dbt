with products as (

select
product_id,
name,
price,
inventory
from {{ source('pg', 'products') }}
),

final as (
    select * from products
)

select * from final