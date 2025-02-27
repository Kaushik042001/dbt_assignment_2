WITH raw_listings AS ( 
    SELECT 
        listing_id,
        listing_url,
        COALESCE(listing_name, 'Anonymous') AS listing_name,  
        CASE 
            WHEN room_type IN ('Private room', 'Entire home/apt', 'Shared room', 'Hotel room') 
                THEN room_type
            ELSE 'unknown' 
        END AS room_type,
        minimum_nights,
        host_id,
        TRY_CAST(REPLACE(price_str, '$', '') AS NUMBER) AS price,
        created_at,  
        updated_at   
    FROM {{ ref("src_listings") }}
    WHERE listing_url IS NOT NULL  -- Remove rows where listing_url is null
    AND price_str IS NOT NULL      -- Remove rows where price_str is null
) 

SELECT * FROM raw_listings
