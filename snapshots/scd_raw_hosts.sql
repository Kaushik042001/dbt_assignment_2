{% snapshot raw_hosts_snapshot %}

{{
    config(
        target_schema='dev',
        unique_key='unique_id',
        strategy='timestamp',
        updated_at='updated_at',
        invalidate_hard_deletes=True
    )
}}

WITH source_data AS (
    SELECT 
        "host_id" AS host_id,
        "host_name" AS host_name, 
        "host_is_superhost" AS is_superhost,  
        "host_since" AS created_at, 
        "last_scraped" AS updated_at
    FROM {{ source('assignment_2', 'hosts') }}
)

SELECT 
    *,
    {{ dbt_utils.generate_surrogate_key(['host_id', 'host_name', 'is_superhost', 'created_at', 'updated_at']) }} AS unique_id
FROM source_data

{% endsnapshot %}
