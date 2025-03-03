WITH ranked_hosts AS (
    SELECT *, 
           ROW_NUMBER() OVER (PARTITION BY host_id ORDER BY created_at DESC) AS rn
    FROM {{ ref('dim_hosts_cleansed') }}
)
SELECT * 
FROM ranked_hosts
WHERE rn = 1
