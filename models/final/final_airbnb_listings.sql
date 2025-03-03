WITH final_airbnb_listings AS (
    SELECT 
        l.listing_id,
        l.listing_url,
        l.listing_name,
        l.room_type,
        l.minimum_nights,
        l.price,
        l.created_at,
        l.updated_at,
        H.host_id,
        h.host_name,
        h.is_superhost,
        h.created_at AS host_since,
        h.updated_at AS host_updated,    
        r.review_date,
        r.reviewer_name,
        r.review_text,
        r.review_sentiment
    FROM {{ ref("dim_hosts_cleansed") }} h
    INNER JOIN {{ ref("dim_listings_cleansed") }} l
    ON h.host_id = l.host_id
    INNER JOIN {{ ref("dim_reviews_cleansed") }} r
    ON l.listing_id = r.listing_id
)

SELECT * FROM final_airbnb_listings