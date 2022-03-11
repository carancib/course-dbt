with promos as (

select
promo_id,
discount,
status
from {{ source('pg', 'promos') }}
),

final as (
    select * from promos
)

select * from final