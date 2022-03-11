with addresses as (

select
address_id,
address,
zipcode,
state,
country
from {{ source('pg', 'addresses') }}
),

final as (
    select * from addresses
)

select * from final