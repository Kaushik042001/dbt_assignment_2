WITH raw_reviews AS ( 
SELECT 
* 
FROM 
        {{ source('assignment_2', 'reviews') }}
) 
SELECT 
    "id" AS listing_id,
    "last_review" AS review_date,
    "neighbourhood_cleansed" AS reviewer_name,
    "neighborhood_overview" AS review_text,
    "review_scores_rating" AS review_sentiment
FROM 
    raw_reviews