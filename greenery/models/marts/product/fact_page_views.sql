with events as (

select
event_id,
session_id,
user_id,
page_url,
created_at,
event_type,
order_id,
product_id
from {{ ref('stg_events') }}
where event_type = 'page_view'
),

final as (
    select * from events
)

select * from final