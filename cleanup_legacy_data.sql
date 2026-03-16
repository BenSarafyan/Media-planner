-- Clean up legacy ad formats, inventories, and platforms
-- This script removes all ad format data that was NOT part of the manual import

BEGIN;

-- 1. Remove ad formats that are not part of the manual upload
-- This will also remove associated variants due to CASCADE
DELETE FROM public.ad_formats 
WHERE is_manual_upload = false OR is_manual_upload IS NULL;

-- 2. Remove inventories that no longer have any ad formats
DELETE FROM public.inventories 
WHERE id NOT IN (SELECT DISTINCT inventory_id FROM public.ad_formats);

-- 3. Remove platforms that no longer have any inventories
DELETE FROM public.platforms 
WHERE id NOT IN (SELECT DISTINCT platform_id FROM public.inventories);

COMMIT;
