WITH raw_listings AS ( 
SELECT 
* 
FROM 
        {{ source('assignment_2', 'listings') }} 
) 
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
    raw_listings