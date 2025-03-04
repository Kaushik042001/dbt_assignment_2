{% snapshot raw_listings_snapshot %}

{{
    config(
        target_schema='dev',
        unique_key='listing_id',
        strategy='timestamp',
        updated_at='updated_at',
        invalidate_hard_deletes=True
    )
}}
    
SELECT 
    "id" AS listing_id,
    "listing_url" AS listing_url, 
    "name" AS listing_name,  
    "room_type" AS room_type, 
    "minimum_nights" AS minimum_nights, 
    "host_id" AS host_id, 
    "price" AS price_str, 
    "last_scraped" AS created_at, 
    "calendar_last_scraped" AS updated_at 
FROM 
    {{source('assignment_2', 'listings')}}

{% endsnapshot %}
