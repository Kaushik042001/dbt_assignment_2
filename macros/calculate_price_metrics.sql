{% macro calculate_price_metrics(group_by_column) %}
(
    SELECT 
        {{ group_by_column }} AS listing_name, 
        COUNT(listing_id) AS listing_count, 
        AVG(price) AS avg_price,
        SUM(price) AS total_price,
        SUM(minimum_nights) AS available_nights
    FROM {{ ref('dim_listings_cleansed') }}
    WHERE price IS NOT NULL
    GROUP BY {{ group_by_column }}
)
{% endmacro %}
