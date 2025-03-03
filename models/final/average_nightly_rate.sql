WITH average_nightly_rate AS (
    SELECT 
        dim_listings.listing_id,
        price_metrics.listing_name,
        price_metrics.listing_count,
        price_metrics.total_price,
        price_metrics.available_nights,
        price_metrics.total_price / NULLIF(price_metrics.available_nights, 0) AS average_nightly_rate
    FROM {{ ref('dim_listings_cleansed') }} AS dim_listings
    INNER JOIN {{ ref("price_metrics") }} AS price_metrics
    ON dim_listings.listing_name = price_metrics.listing_name
)
SELECT * FROM average_nightly_rate
