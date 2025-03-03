WITH review_aggregates AS (
    SELECT
        listing_id,
        COUNT(*) AS total_reviews,
        AVG(review_sentiment) AS avg_review_sentiment,
        MAX(review_date) AS latest_review_date
    FROM {{ ref("dim_reviews_cleansed") }}
    GROUP BY listing_id
)

SELECT * FROM review_aggregates
