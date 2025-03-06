{{ 
  config(
    materialized='table',
    cluster_by=['listing_id', 'host_id']
  ) 
}}

WITH valid_listings AS (
    SELECT 
        listing_id,
        listing_url,
        listing_name,
        room_type,
        minimum_nights,
        price,
        created_at,
        updated_at,
        host_id
    FROM {{ ref("dim_listings_cleansed") }}
    WHERE listing_id IS NOT NULL
      AND listing_url IS NOT NULL
      AND listing_name IS NOT NULL
      AND price IS NOT NULL
),

valid_hosts AS (
    SELECT 
        host_id,
        host_name,
        is_superhost,
        created_at AS host_since,
        updated_at AS host_updated
    FROM {{ ref("dim_hosts_cleansed") }}
    WHERE host_id IS NOT NULL
      AND host_name IS NOT NULL
),

valid_reviews AS (
    SELECT 
        listing_id,
        review_date,
        reviewer_name,
        review_text,
        review_sentiment
    FROM {{ ref("dim_reviews_cleansed") }}
    WHERE review_date IS NOT NULL
      AND review_sentiment BETWEEN 1 AND 5  -- Ensure valid sentiment scores
)

SELECT 
    l.listing_id,
    l.listing_url,
    l.listing_name,
    l.room_type,
    l.minimum_nights,
    l.price,
    l.created_at AS listing_created,
    l.updated_at AS listing_updated,
    h.host_id,
    h.host_name,
    h.is_superhost,
    h.host_since,
    h.host_updated,
    r.review_date,
    r.reviewer_name,
    r.review_text,
    r.review_sentiment
FROM valid_listings l
LEFT JOIN valid_hosts h ON l.host_id = h.host_id
LEFT JOIN valid_reviews r ON l.listing_id = r.listing_id
