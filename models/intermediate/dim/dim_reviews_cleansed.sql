WITH raw_reviews AS ( 
    SELECT 
        listing_id,
        review_date,
        COALESCE(reviewer_name, 'anonymous') AS reviewer_name,  
        COALESCE(review_text, 'empty') AS review_text,
        -- Convert review_sentiment to INTEGER and remove rows where it's NULL
        CAST(ROUND(review_sentiment) AS INT) AS review_sentiment
    FROM {{ ref("src_reviews") }}
    WHERE review_date IS NOT NULL  
    AND review_sentiment IS NOT NULL  
) 

SELECT * FROM raw_reviews
