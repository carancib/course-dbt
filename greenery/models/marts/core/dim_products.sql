with products as (

select
product_id,
name,
price,
inventory
from {{ ref('stg_products') }}
),

final as (
    select * from products
)

select * from final