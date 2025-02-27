SELECT count(host_id) FROM {{ref("src_hosts")}} 
SELECT distinct count(host_id) FROM {{ref("src_hosts")}} 

SELECT count(*) FROM {{ref("dim_hosts_cleansed")}} where host_name is null

SELECT count(*) 
FROM {{ref("dim_hosts_cleansed")}}
WHERE is_superhost NOT IN ('t', 'f') OR is_superhost IS NULL

SELECT count(*) 
FROM {{ref("dim_hosts_cleansed")}}
WHERE is_superhost = 'unknown'

SELECT distinct *
FROM {{ref("src_hosts")}}
WHERE is_superhost NOT IN ('t', 'f') OR is_superhost IS NULL

SELECT distinct count(*)
FROM {{ref("src_hosts")}}
WHERE created_at IS NULL

SELECT distinct count(*)
FROM {{ref("dim_hosts_cleansed")}}
WHERE created_at IS NULL

SELECT distinct count(*)
FROM {{ref("src_hosts")}}
WHERE updated_at IS NULL


SELECT count(*) from {{ref("src_listings")}} where listing_id is null
SELECT count(listing_id) from {{ref("src_listings")}}
SELECT distinct count(listing_id) from {{ref("src_listings")}} 

SELECT listing_id
FROM {{ref("src_listings")}}
WHERE TRY_CAST(listing_id AS NUMBER) IS NULL;



