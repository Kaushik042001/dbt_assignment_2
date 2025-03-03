WITH raw_hosts AS ( 
    SELECT * FROM {{ ref('src_hosts') }} 
) 

SELECT 
    host_id, 
    COALESCE(host_name, 'Anonymous') AS host_name, 
    CASE 
        WHEN is_superhost IN ('t', 'f') THEN is_superhost 
        ELSE 'unknown' 
    END AS is_superhost, 
    created_at, 
    updated_at
FROM raw_hosts
WHERE created_at IS NOT NULL
