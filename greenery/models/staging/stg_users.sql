with users as (

select
user_id,
first_name,
last_name,
email,
phone_number,
created_at,
updated_at,
address_id
from {{ source('pg', 'users') }}
),

final as (
    select * from users
)

select * from final