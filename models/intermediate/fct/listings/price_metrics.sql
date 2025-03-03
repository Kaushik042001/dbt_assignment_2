WITH price_metrics AS (
    {{ calculate_price_metrics('listing_name') }}
)

SELECT * FROM price_metrics
