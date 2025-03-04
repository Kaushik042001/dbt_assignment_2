{{ 
  config( 
    materialized = 'incremental', 
    on_schema_change='fail' 
    ) 
}} 

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

        -- Clean price_str by removing non-numeric characters
        TRY_CAST(REGEXP_REPLACE(price_str, '[^0-9.]', '') AS NUMBER) AS price,

        created_at,  
        updated_at   
    FROM {{ ref("src_listings") }}
    WHERE listing_url IS NOT NULL  
    AND price_str IS NOT NULL  -- Remove rows where price_str is null
    AND price_str != ''        -- Remove empty strings

    {% if is_incremental() %} 
    AND updated_at > (select max(updated_at) from {{ this }}) 
    {% endif %}
) 


SELECT * FROM raw_listings

