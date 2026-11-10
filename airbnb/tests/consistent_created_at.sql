WITH r as (
    SELECT
        listing_id, review_date
    FROM
        {{ ref('fct_reviews') }}
),
l as (
    SELECT
        listing_id, created_at
    FROM
        {{ ref('dim_listings_cleansed') }}
)
SELECT 
    l.listing_id, CAST(l.created_at AS DATE) as listing_created_at, CAST(r.review_date AS DATE) as reviewed_at
FROM l
INNER JOIN r
USING(listing_id)
WHERE CAST(l.created_at AS DATE) > CAST(r.review_date AS DATE)
LIMIT 10