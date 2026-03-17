-- Update requires_video column based on asset name or duration variants
-- 1. Set to true if name contains 'video'
UPDATE public.ad_formats
SET requires_video = true
WHERE name ILIKE '%video%';

-- 2. Set to true if any associated variant has a duration
UPDATE public.ad_formats
SET requires_video = true
WHERE id IN (
    SELECT DISTINCT ad_format_id 
    FROM public.ad_format_variants 
    WHERE duration IS NOT NULL AND duration <> ''
);

-- 3. Set to false if neither of the above (default is already false, but to be sure)
-- This is optional but ensures consistency if some were accidentally set to true
-- UPDATE public.ad_formats
-- SET requires_video = false
-- WHERE name NOT ILIKE '%video%'
-- AND id NOT IN (
--     SELECT DISTINCT ad_format_id 
--     FROM public.ad_format_variants 
--     WHERE duration IS NOT NULL AND duration <> ''
-- );
