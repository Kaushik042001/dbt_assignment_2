{% macro get_years_from_created_at() %}
    {% if execute %}
        {% set query %}
            SELECT DISTINCT EXTRACT(YEAR FROM created_at) AS year
            FROM {{ ref('dim_hosts_cleansed') }} 
            ORDER BY year
        {% endset %}

        {% set result = run_query(query) %}
        {% if result and result.columns[0].values %}
            {% set years = result.columns[0].values() %}
        {% else %}
            {% set years = [] %}
        {% endif %}
    {% else %}
        {% set years = [] %}
    {% endif %}

    {{ return(years) }}
{% endmacro %}
