-- depends_on: {{ ref('dim_hosts_cleansed') }}

{% set years = get_years_from_created_at() %}

WITH 
{% for year in years %}
    hosts_by_month_{{ year }} AS (
        {{ count_hosts_by_month(year) }}
    )
    {% if not loop.last %}, {% endif %}
{% endfor %}

SELECT * FROM (
    {% for year in years %}
        SELECT month_name, host_count, '{{ year }}' AS year FROM hosts_by_month_{{ year }}
        {% if not loop.last %} UNION ALL {% endif %}
    {% endfor %}
)
ORDER BY year, 
         CASE month_name
            WHEN 'Jan' THEN 1
            WHEN 'Feb' THEN 2
            WHEN 'Mar' THEN 3
            WHEN 'Apr' THEN 4
            WHEN 'May' THEN 5
            WHEN 'Jun' THEN 6
            WHEN 'Jul' THEN 7
            WHEN 'Aug' THEN 8
            WHEN 'Sep' THEN 9
            WHEN 'Oct' THEN 10
            WHEN 'Nov' THEN 11
            WHEN 'Dec' THEN 12
         END
