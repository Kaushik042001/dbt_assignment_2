
WITH raw_hosts AS ( 

    SELECT * FROM {{ source('assignment_2', 'hosts') }}

) 
SELECT 
    "host_id" as host_id, 
    "host_name" as host_name, 
    "host_is_superhost" as is_superhost, 
    "host_since" as created_at, 
    "last_scraped" as updated_at
FROM 
    raw_hosts