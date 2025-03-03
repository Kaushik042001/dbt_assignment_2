{% macro count_hosts_by_month(year) %}
(
    SELECT 
        EXTRACT(MONTH FROM created_at) AS month_number,
        LEFT(TO_CHAR(created_at, 'Month'), 3) AS month_name,  -- Ensures 'Jan', 'Feb', etc.
        COUNT(host_id) AS host_count
    FROM {{ ref('dim_hosts_cleansed') }} 
    WHERE EXTRACT(YEAR FROM created_at) = {{ year }}
    GROUP BY 1, 2
    ORDER BY month_number
)
{% endmacro %}
