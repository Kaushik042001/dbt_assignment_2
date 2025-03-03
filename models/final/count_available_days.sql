WITH listing_dates AS (
    SELECT 
        DATE_PART('year', created_at) AS year,
        MAX(created_at) AS max_created_at,
        MIN(created_at) AS min_created_at
    FROM {{ ref('dim_listings_cleansed') }}
    GROUP BY year
)

SELECT 
    year,
    max_created_at,
    min_created_at,
    DATEDIFF(day, min_created_at, max_created_at) AS available_days_in_year
FROM listing_dates
ORDER BY year
