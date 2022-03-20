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
from {{ ref('stg_users') }}
),

final as (
    select * from users
)

select * from final