
-- Seed Ad Formats and Variants from Excel Export
-- Source: AdFormats_Export.xlsx

DO $$ 
DECLARE 
    plat_id uuid;
    inv_id uuid;
    format_id uuid;
    r text;
    l text;
BEGIN

    -- LinkedIn / LinkedIn / Carousel
    INSERT INTO public.platforms (name) VALUES ('LinkedIn') ON CONFLICT (name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO plat_id;
    INSERT INTO public.inventories (platform_id, name) VALUES (plat_id, 'LinkedIn') ON CONFLICT (platform_id, name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO inv_id;
    
    INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, is_manual_upload, upload_source_file) 
    VALUES (plat_id, inv_id, 'Carousel', 'Conversion', true, 'AdFormats_Export.xlsx')
    RETURNING id INTO format_id;
        INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1:1', NULL, true, 'AdFormats_Export.xlsx');

    -- LinkedIn / LinkedIn / Carousel
    INSERT INTO public.platforms (name) VALUES ('LinkedIn') ON CONFLICT (name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO plat_id;
    INSERT INTO public.inventories (platform_id, name) VALUES (plat_id, 'LinkedIn') ON CONFLICT (platform_id, name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO inv_id;
    
    INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, is_manual_upload, upload_source_file) 
    VALUES (plat_id, inv_id, 'Carousel', 'Consideration', true, 'AdFormats_Export.xlsx')
    RETURNING id INTO format_id;
        INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1:1', NULL, true, 'AdFormats_Export.xlsx');

    -- Google Ads / Search / Text Ads
    INSERT INTO public.platforms (name) VALUES ('Google Ads') ON CONFLICT (name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO plat_id;
    INSERT INTO public.inventories (platform_id, name) VALUES (plat_id, 'Search') ON CONFLICT (platform_id, name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO inv_id;
    
    INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, is_manual_upload, upload_source_file) 
    VALUES (plat_id, inv_id, 'Text Ads', 'Conversion', true, 'AdFormats_Export.xlsx')
    RETURNING id INTO format_id;
        INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, NULL, NULL, true, 'AdFormats_Export.xlsx');

    -- Amazon / Prime Video / Video
    INSERT INTO public.platforms (name) VALUES ('Amazon') ON CONFLICT (name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO plat_id;
    INSERT INTO public.inventories (platform_id, name) VALUES (plat_id, 'Prime Video') ON CONFLICT (platform_id, name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO inv_id;
    
    INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, is_manual_upload, upload_source_file) 
    VALUES (plat_id, inv_id, 'Video', 'Awareness', true, 'AdFormats_Export.xlsx')
    RETURNING id INTO format_id;
        INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1920x1080 (minimum)', '15', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1920x1080 (minimum)', '20', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1920x1080 (minimum)', '30', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1920x1080 (minimum)', '40', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1920x1080 (minimum)', '60', true, 'AdFormats_Export.xlsx');

    -- Meta / Meta / Single Image
    INSERT INTO public.platforms (name) VALUES ('Meta') ON CONFLICT (name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO plat_id;
    INSERT INTO public.inventories (platform_id, name) VALUES (plat_id, 'Meta') ON CONFLICT (platform_id, name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO inv_id;
    
    INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, is_manual_upload, upload_source_file) 
    VALUES (plat_id, inv_id, 'Single Image', 'Awareness', true, 'AdFormats_Export.xlsx')
    RETURNING id INTO format_id;
        INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1:1', NULL, true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', NULL, true, 'AdFormats_Export.xlsx');

    -- Amazon / Sponsored Display / Display ad
    INSERT INTO public.platforms (name) VALUES ('Amazon') ON CONFLICT (name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO plat_id;
    INSERT INTO public.inventories (platform_id, name) VALUES (plat_id, 'Sponsored Display') ON CONFLICT (platform_id, name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO inv_id;
    
    INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, is_manual_upload, upload_source_file) 
    VALUES (plat_id, inv_id, 'Display ad', 'Consideration', true, 'AdFormats_Export.xlsx')
    RETURNING id INTO format_id;
        INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '160x600', NULL, true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '320x50', NULL, true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '728x90', NULL, true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '728x90', NULL, true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '300x600', NULL, true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1940x500', NULL, true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '414x125', NULL, true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '300x250', NULL, true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '300x250', NULL, true, 'AdFormats_Export.xlsx');

    -- Google Ads / Demand Gen / Video
    INSERT INTO public.platforms (name) VALUES ('Google Ads') ON CONFLICT (name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO plat_id;
    INSERT INTO public.inventories (platform_id, name) VALUES (plat_id, 'Demand Gen') ON CONFLICT (platform_id, name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO inv_id;
    
    INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, is_manual_upload, upload_source_file) 
    VALUES (plat_id, inv_id, 'Video', 'Consideration', true, 'AdFormats_Export.xlsx')
    RETURNING id INTO format_id;
        INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1:1', '5', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1:1', '10', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1:1', '15', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1:1', '20', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1:1', '30', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1:1', '45', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1:1', '60', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '5', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '10', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '15', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '20', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '30', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '45', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '60', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '5', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '10', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '15', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '20', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '30', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '45', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '60', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '4:5', '5', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '4:5', '10', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '4:5', '15', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '4:5', '20', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '4:5', '30', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '4:5', '45', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '4:5', '60', true, 'AdFormats_Export.xlsx');

    -- Spotify / Spotify / Spotify Audio Ad Companion Logo
    INSERT INTO public.platforms (name) VALUES ('Spotify') ON CONFLICT (name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO plat_id;
    INSERT INTO public.inventories (platform_id, name) VALUES (plat_id, 'Spotify') ON CONFLICT (platform_id, name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO inv_id;
    
    INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, is_manual_upload, upload_source_file) 
    VALUES (plat_id, inv_id, 'Spotify Audio Ad Companion Logo', 'Awareness', true, 'AdFormats_Export.xlsx')
    RETURNING id INTO format_id;
        INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1:1, 640x640', NULL, true, 'AdFormats_Export.xlsx');

    -- Meta / Meta / Carousel
    INSERT INTO public.platforms (name) VALUES ('Meta') ON CONFLICT (name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO plat_id;
    INSERT INTO public.inventories (platform_id, name) VALUES (plat_id, 'Meta') ON CONFLICT (platform_id, name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO inv_id;
    
    INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, is_manual_upload, upload_source_file) 
    VALUES (plat_id, inv_id, 'Carousel', 'Awareness', true, 'AdFormats_Export.xlsx')
    RETURNING id INTO format_id;
        INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1:1', '5', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1:1', '10', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1:1', '15', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1:1', '20', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1:1', '30', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1:1', '45', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1:1', '60', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '5', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '10', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '15', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '20', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '30', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '45', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '60', true, 'AdFormats_Export.xlsx');

    -- Amazon / Twitch / Display Ad - Super Leaderboard
    INSERT INTO public.platforms (name) VALUES ('Amazon') ON CONFLICT (name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO plat_id;
    INSERT INTO public.inventories (platform_id, name) VALUES (plat_id, 'Twitch') ON CONFLICT (platform_id, name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO inv_id;
    
    INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, is_manual_upload, upload_source_file) 
    VALUES (plat_id, inv_id, 'Display Ad - Super Leaderboard', 'Awareness', true, 'AdFormats_Export.xlsx')
    RETURNING id INTO format_id;
        INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '728x90', NULL, true, 'AdFormats_Export.xlsx');

    -- Spotify / Spotify / Spotify Audio Ad Companion Banner
    INSERT INTO public.platforms (name) VALUES ('Spotify') ON CONFLICT (name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO plat_id;
    INSERT INTO public.inventories (platform_id, name) VALUES (plat_id, 'Spotify') ON CONFLICT (platform_id, name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO inv_id;
    
    INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, is_manual_upload, upload_source_file) 
    VALUES (plat_id, inv_id, 'Spotify Audio Ad Companion Banner', 'Awareness', true, 'AdFormats_Export.xlsx')
    RETURNING id INTO format_id;
        INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1:1, 640x640', NULL, true, 'AdFormats_Export.xlsx');

    -- Google Ads / Demand Gen / Carousel
    INSERT INTO public.platforms (name) VALUES ('Google Ads') ON CONFLICT (name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO plat_id;
    INSERT INTO public.inventories (platform_id, name) VALUES (plat_id, 'Demand Gen') ON CONFLICT (platform_id, name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO inv_id;
    
    INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, is_manual_upload, upload_source_file) 
    VALUES (plat_id, inv_id, 'Carousel', 'Consideration', true, 'AdFormats_Export.xlsx')
    RETURNING id INTO format_id;
        INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1200x628 (2-10 card images)', NULL, true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1200x1200 (2-10 card images)', NULL, true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '960x1200 (2-10 card images)', NULL, true, 'AdFormats_Export.xlsx');

    -- Programmatic / EXTE / Programmatic Display Partner Specific
    INSERT INTO public.platforms (name) VALUES ('Programmatic') ON CONFLICT (name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO plat_id;
    INSERT INTO public.inventories (platform_id, name) VALUES (plat_id, 'EXTE') ON CONFLICT (platform_id, name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO inv_id;
    
    INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, is_manual_upload, upload_source_file) 
    VALUES (plat_id, inv_id, 'Programmatic Display Partner Specific', 'Consideration', true, 'AdFormats_Export.xlsx')
    RETURNING id INTO format_id;
        INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, NULL, NULL, true, 'AdFormats_Export.xlsx');

    -- Reddit / Reddit / Carousel
    INSERT INTO public.platforms (name) VALUES ('Reddit') ON CONFLICT (name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO plat_id;
    INSERT INTO public.inventories (platform_id, name) VALUES (plat_id, 'Reddit') ON CONFLICT (platform_id, name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO inv_id;
    
    INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, is_manual_upload, upload_source_file) 
    VALUES (plat_id, inv_id, 'Carousel', 'Awareness', true, 'AdFormats_Export.xlsx')
    RETURNING id INTO format_id;
        INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, NULL, NULL, true, 'AdFormats_Export.xlsx');

    -- Spotify / Spotify / Image Overlay Ad
    INSERT INTO public.platforms (name) VALUES ('Spotify') ON CONFLICT (name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO plat_id;
    INSERT INTO public.inventories (platform_id, name) VALUES (plat_id, 'Spotify') ON CONFLICT (platform_id, name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO inv_id;
    
    INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, is_manual_upload, upload_source_file) 
    VALUES (plat_id, inv_id, 'Image Overlay Ad', 'Awareness', true, 'AdFormats_Export.xlsx')
    RETURNING id INTO format_id;
        INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '630x920', NULL, true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '800x435', NULL, true, 'AdFormats_Export.xlsx');

    -- Meta / Meta / Single Image
    INSERT INTO public.platforms (name) VALUES ('Meta') ON CONFLICT (name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO plat_id;
    INSERT INTO public.inventories (platform_id, name) VALUES (plat_id, 'Meta') ON CONFLICT (platform_id, name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO inv_id;
    
    INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, is_manual_upload, upload_source_file) 
    VALUES (plat_id, inv_id, 'Single Image', 'Conversion', true, 'AdFormats_Export.xlsx')
    RETURNING id INTO format_id;
        INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1:1', NULL, true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', NULL, true, 'AdFormats_Export.xlsx');

    -- Google Ads / Demand Gen / Single Image
    INSERT INTO public.platforms (name) VALUES ('Google Ads') ON CONFLICT (name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO plat_id;
    INSERT INTO public.inventories (platform_id, name) VALUES (plat_id, 'Demand Gen') ON CONFLICT (platform_id, name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO inv_id;
    
    INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, is_manual_upload, upload_source_file) 
    VALUES (plat_id, inv_id, 'Single Image', 'Consideration', true, 'AdFormats_Export.xlsx')
    RETURNING id INTO format_id;
        INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1200x628', NULL, true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1200x1200', NULL, true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '960x1200', NULL, true, 'AdFormats_Export.xlsx');

    -- Amazon / Twitch / Display Ad - Headliner (Desktop)
    INSERT INTO public.platforms (name) VALUES ('Amazon') ON CONFLICT (name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO plat_id;
    INSERT INTO public.inventories (platform_id, name) VALUES (plat_id, 'Twitch') ON CONFLICT (platform_id, name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO inv_id;
    
    INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, is_manual_upload, upload_source_file) 
    VALUES (plat_id, inv_id, 'Display Ad - Headliner (Desktop)', 'Consideration', true, 'AdFormats_Export.xlsx')
    RETURNING id INTO format_id;
        INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, 'Left Unit: 450x350; Right Unit: 450x350', NULL, true, 'AdFormats_Export.xlsx');

    -- LinkedIn / LinkedIn / Text Ads
    INSERT INTO public.platforms (name) VALUES ('LinkedIn') ON CONFLICT (name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO plat_id;
    INSERT INTO public.inventories (platform_id, name) VALUES (plat_id, 'LinkedIn') ON CONFLICT (platform_id, name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO inv_id;
    
    INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, is_manual_upload, upload_source_file) 
    VALUES (plat_id, inv_id, 'Text Ads', 'Conversion', true, 'AdFormats_Export.xlsx')
    RETURNING id INTO format_id;
        INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, NULL, NULL, true, 'AdFormats_Export.xlsx');

    -- Amazon / Amazon Audio / Amazon Audio Ad Companion Image
    INSERT INTO public.platforms (name) VALUES ('Amazon') ON CONFLICT (name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO plat_id;
    INSERT INTO public.inventories (platform_id, name) VALUES (plat_id, 'Amazon Audio') ON CONFLICT (platform_id, name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO inv_id;
    
    INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, is_manual_upload, upload_source_file) 
    VALUES (plat_id, inv_id, 'Amazon Audio Ad Companion Image', 'Awareness', true, 'AdFormats_Export.xlsx')
    RETURNING id INTO format_id;
        INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1024x1024', NULL, true, 'AdFormats_Export.xlsx');

    -- Meta / Meta / Video
    INSERT INTO public.platforms (name) VALUES ('Meta') ON CONFLICT (name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO plat_id;
    INSERT INTO public.inventories (platform_id, name) VALUES (plat_id, 'Meta') ON CONFLICT (platform_id, name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO inv_id;
    
    INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, is_manual_upload, upload_source_file) 
    VALUES (plat_id, inv_id, 'Video', 'Consideration', true, 'AdFormats_Export.xlsx')
    RETURNING id INTO format_id;
        INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1:1', '5', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1:1', '10', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1:1', '15', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1:1', '20', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1:1', '30', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1:1', '45', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1:1', '60', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '5', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '10', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '15', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '20', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '30', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '45', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '60', true, 'AdFormats_Export.xlsx');

    -- Amazon / Sponsored Brands / Video
    INSERT INTO public.platforms (name) VALUES ('Amazon') ON CONFLICT (name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO plat_id;
    INSERT INTO public.inventories (platform_id, name) VALUES (plat_id, 'Sponsored Brands') ON CONFLICT (platform_id, name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO inv_id;
    
    INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, is_manual_upload, upload_source_file) 
    VALUES (plat_id, inv_id, 'Video', 'Awareness', true, 'AdFormats_Export.xlsx')
    RETURNING id INTO format_id;
        INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9, 1280x720', '5', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9, 1280x720', '10', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9, 1280x720', '15', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9, 1280x720', '20', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9, 1280x720', '30', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9, 1280x720', '45', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9, 1920x1080', '5', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9, 1920x1080', '10', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9, 1920x1080', '15', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9, 1920x1080', '20', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9, 1920x1080', '30', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9, 1920x1080', '45', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9, 3840x2160', '5', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9, 3840x2160', '10', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9, 3840x2160', '15', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9, 3840x2160', '20', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9, 3840x2160', '30', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9, 3840x2160', '45', true, 'AdFormats_Export.xlsx');

    -- Amazon / Sponsored Brands / Product collection
    INSERT INTO public.platforms (name) VALUES ('Amazon') ON CONFLICT (name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO plat_id;
    INSERT INTO public.inventories (platform_id, name) VALUES (plat_id, 'Sponsored Brands') ON CONFLICT (platform_id, name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO inv_id;
    
    INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, is_manual_upload, upload_source_file) 
    VALUES (plat_id, inv_id, 'Product collection', 'Awareness', true, 'AdFormats_Export.xlsx')
    RETURNING id INTO format_id;
        INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, NULL, NULL, true, 'AdFormats_Export.xlsx');

    -- LinkedIn / LinkedIn / Video
    INSERT INTO public.platforms (name) VALUES ('LinkedIn') ON CONFLICT (name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO plat_id;
    INSERT INTO public.inventories (platform_id, name) VALUES (plat_id, 'LinkedIn') ON CONFLICT (platform_id, name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO inv_id;
    
    INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, is_manual_upload, upload_source_file) 
    VALUES (plat_id, inv_id, 'Video', 'Awareness', true, 'AdFormats_Export.xlsx')
    RETURNING id INTO format_id;
        INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1:1', '5', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1:1', '10', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1:1', '15', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1:1', '20', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1:1', '30', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1:1', '45', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1:1', '60', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '5', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '10', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '15', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '20', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '30', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '45', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '60', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '5', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '10', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '15', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '20', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '30', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '45', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '60', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '4:5', '5', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '4:5', '10', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '4:5', '15', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '4:5', '20', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '4:5', '30', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '4:5', '45', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '4:5', '60', true, 'AdFormats_Export.xlsx');

    -- Spotify / Spotify / Spotify Audio Ad
    INSERT INTO public.platforms (name) VALUES ('Spotify') ON CONFLICT (name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO plat_id;
    INSERT INTO public.inventories (platform_id, name) VALUES (plat_id, 'Spotify') ON CONFLICT (platform_id, name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO inv_id;
    
    INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, is_manual_upload, upload_source_file) 
    VALUES (plat_id, inv_id, 'Spotify Audio Ad', 'Awareness', true, 'AdFormats_Export.xlsx')
    RETURNING id INTO format_id;
        INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, NULL, '5', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, NULL, '10', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, NULL, '15', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, NULL, '20', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, NULL, '30', true, 'AdFormats_Export.xlsx');

    -- Meta / Meta / Carousel
    INSERT INTO public.platforms (name) VALUES ('Meta') ON CONFLICT (name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO plat_id;
    INSERT INTO public.inventories (platform_id, name) VALUES (plat_id, 'Meta') ON CONFLICT (platform_id, name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO inv_id;
    
    INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, is_manual_upload, upload_source_file) 
    VALUES (plat_id, inv_id, 'Carousel', 'Consideration', true, 'AdFormats_Export.xlsx')
    RETURNING id INTO format_id;
        INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1:1', '5', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1:1', '10', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1:1', '15', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1:1', '20', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1:1', '30', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1:1', '45', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1:1', '60', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '5', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '10', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '15', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '20', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '30', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '45', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '60', true, 'AdFormats_Export.xlsx');

    -- Amazon / Fire TV / Video
    INSERT INTO public.platforms (name) VALUES ('Amazon') ON CONFLICT (name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO plat_id;
    INSERT INTO public.inventories (platform_id, name) VALUES (plat_id, 'Fire TV') ON CONFLICT (platform_id, name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO inv_id;
    
    INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, is_manual_upload, upload_source_file) 
    VALUES (plat_id, inv_id, 'Video', 'Awareness', true, 'AdFormats_Export.xlsx')
    RETURNING id INTO format_id;
        INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '5', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '10', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '15', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:10', '5', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:10', '10', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:10', '15', true, 'AdFormats_Export.xlsx');

    -- Google Ads / Performance Max / Images, Logos, Text Assets, Video Assets (All required to launch) 
    INSERT INTO public.platforms (name) VALUES ('Google Ads') ON CONFLICT (name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO plat_id;
    INSERT INTO public.inventories (platform_id, name) VALUES (plat_id, 'Performance Max') ON CONFLICT (platform_id, name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO inv_id;
    
    INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, is_manual_upload, upload_source_file) 
    VALUES (plat_id, inv_id, 'Images, Logos, Text Assets, Video Assets (All required to launch) ', 'Conversion', true, 'AdFormats_Export.xlsx')
    RETURNING id INTO format_id;
        INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1:1', '10', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1:1', '15', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1:1', '20', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1:1', '30', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1:1', '40', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1:1', '60', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1:1', '10', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1:1', '15', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1:1', '20', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1:1', '30', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1:1', '40', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1:1', '60', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '10', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '15', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '20', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '30', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '40', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '60', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '10', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '15', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '20', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '30', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '40', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '60', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '4:5', '10', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '4:5', '15', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '4:5', '20', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '4:5', '30', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '4:5', '40', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '4:5', '60', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1:9, 1:1', '10', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1:9, 1:1', '15', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1:9, 1:1', '20', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1:9, 1:1', '30', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1:9, 1:1', '40', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1:9, 1:1', '60', true, 'AdFormats_Export.xlsx');

    -- Amazon / Twitch / Display Ad - Headliner (Mobile)
    INSERT INTO public.platforms (name) VALUES ('Amazon') ON CONFLICT (name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO plat_id;
    INSERT INTO public.inventories (platform_id, name) VALUES (plat_id, 'Twitch') ON CONFLICT (platform_id, name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO inv_id;
    
    INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, is_manual_upload, upload_source_file) 
    VALUES (plat_id, inv_id, 'Display Ad - Headliner (Mobile)', 'Consideration', true, 'AdFormats_Export.xlsx')
    RETURNING id INTO format_id;
        INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1080x1920', NULL, true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '320x50', NULL, true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '640x100', NULL, true, 'AdFormats_Export.xlsx');

    -- Amazon / Sponsored Brands / Store Spotlight
    INSERT INTO public.platforms (name) VALUES ('Amazon') ON CONFLICT (name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO plat_id;
    INSERT INTO public.inventories (platform_id, name) VALUES (plat_id, 'Sponsored Brands') ON CONFLICT (platform_id, name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO inv_id;
    
    INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, is_manual_upload, upload_source_file) 
    VALUES (plat_id, inv_id, 'Store Spotlight', 'Awareness', true, 'AdFormats_Export.xlsx')
    RETURNING id INTO format_id;
        INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1200x628 (minimum)', NULL, true, 'AdFormats_Export.xlsx');

    -- LinkedIn / LinkedIn / Text Ads
    INSERT INTO public.platforms (name) VALUES ('LinkedIn') ON CONFLICT (name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO plat_id;
    INSERT INTO public.inventories (platform_id, name) VALUES (plat_id, 'LinkedIn') ON CONFLICT (platform_id, name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO inv_id;
    
    INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, is_manual_upload, upload_source_file) 
    VALUES (plat_id, inv_id, 'Text Ads', 'Consideration', true, 'AdFormats_Export.xlsx')
    RETURNING id INTO format_id;
        INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, NULL, NULL, true, 'AdFormats_Export.xlsx');

    -- Programmatic / GumGum / Programmatic Display Partner Specific
    INSERT INTO public.platforms (name) VALUES ('Programmatic') ON CONFLICT (name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO plat_id;
    INSERT INTO public.inventories (platform_id, name) VALUES (plat_id, 'GumGum') ON CONFLICT (platform_id, name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO inv_id;
    
    INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, is_manual_upload, upload_source_file) 
    VALUES (plat_id, inv_id, 'Programmatic Display Partner Specific', 'Consideration', true, 'AdFormats_Export.xlsx')
    RETURNING id INTO format_id;
        INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, NULL, NULL, true, 'AdFormats_Export.xlsx');

    -- Reddit / Reddit / Conversation Ad
    INSERT INTO public.platforms (name) VALUES ('Reddit') ON CONFLICT (name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO plat_id;
    INSERT INTO public.inventories (platform_id, name) VALUES (plat_id, 'Reddit') ON CONFLICT (platform_id, name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO inv_id;
    
    INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, is_manual_upload, upload_source_file) 
    VALUES (plat_id, inv_id, 'Conversation Ad', 'Awareness', true, 'AdFormats_Export.xlsx')
    RETURNING id INTO format_id;
        INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, NULL, NULL, true, 'AdFormats_Export.xlsx');

    -- Amazon / Twitch / Display Ad - Headliner (Desktop)
    INSERT INTO public.platforms (name) VALUES ('Amazon') ON CONFLICT (name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO plat_id;
    INSERT INTO public.inventories (platform_id, name) VALUES (plat_id, 'Twitch') ON CONFLICT (platform_id, name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO inv_id;
    
    INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, is_manual_upload, upload_source_file) 
    VALUES (plat_id, inv_id, 'Display Ad - Headliner (Desktop)', 'Awareness', true, 'AdFormats_Export.xlsx')
    RETURNING id INTO format_id;
        INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, 'Left Unit: 450x350; Right Unit: 450x350', NULL, true, 'AdFormats_Export.xlsx');

    -- Amazon / Amazon Audio / Amazon Audio Ad
    INSERT INTO public.platforms (name) VALUES ('Amazon') ON CONFLICT (name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO plat_id;
    INSERT INTO public.inventories (platform_id, name) VALUES (plat_id, 'Amazon Audio') ON CONFLICT (platform_id, name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO inv_id;
    
    INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, is_manual_upload, upload_source_file) 
    VALUES (plat_id, inv_id, 'Amazon Audio Ad', 'Awareness', true, 'AdFormats_Export.xlsx')
    RETURNING id INTO format_id;
        INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, NULL, '10', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, NULL, '15', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, NULL, '20', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, NULL, '30', true, 'AdFormats_Export.xlsx');

    -- Programmatic / Blis / Programmatic Display Partner Specific
    INSERT INTO public.platforms (name) VALUES ('Programmatic') ON CONFLICT (name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO plat_id;
    INSERT INTO public.inventories (platform_id, name) VALUES (plat_id, 'Blis') ON CONFLICT (platform_id, name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO inv_id;
    
    INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, is_manual_upload, upload_source_file) 
    VALUES (plat_id, inv_id, 'Programmatic Display Partner Specific', 'Awareness', true, 'AdFormats_Export.xlsx')
    RETURNING id INTO format_id;
        INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, NULL, NULL, true, 'AdFormats_Export.xlsx');

    -- Amazon / Twitch / First Impression Takeover
    INSERT INTO public.platforms (name) VALUES ('Amazon') ON CONFLICT (name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO plat_id;
    INSERT INTO public.inventories (platform_id, name) VALUES (plat_id, 'Twitch') ON CONFLICT (platform_id, name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO inv_id;
    
    INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, is_manual_upload, upload_source_file) 
    VALUES (plat_id, inv_id, 'First Impression Takeover', 'Awareness', true, 'AdFormats_Export.xlsx')
    RETURNING id INTO format_id;
        INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1920x1080 (minimum)', '5', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1920x1080 (minimum)', '10', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1920x1080 (minimum)', '15', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1920x1080 (minimum)', '20', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1920x1080 (minimum)', '30', true, 'AdFormats_Export.xlsx');

    -- LinkedIn / LinkedIn / Video
    INSERT INTO public.platforms (name) VALUES ('LinkedIn') ON CONFLICT (name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO plat_id;
    INSERT INTO public.inventories (platform_id, name) VALUES (plat_id, 'LinkedIn') ON CONFLICT (platform_id, name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO inv_id;
    
    INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, is_manual_upload, upload_source_file) 
    VALUES (plat_id, inv_id, 'Video', 'Conversion', true, 'AdFormats_Export.xlsx')
    RETURNING id INTO format_id;
        INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1:1', '5', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1:1', '10', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1:1', '15', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1:1', '20', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1:1', '30', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1:1', '45', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1:1', '60', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '5', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '10', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '15', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '20', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '30', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '45', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '60', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '5', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '10', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '15', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '20', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '30', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '45', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '60', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '4:5', '5', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '4:5', '10', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '4:5', '15', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '4:5', '20', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '4:5', '30', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '4:5', '45', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '4:5', '60', true, 'AdFormats_Export.xlsx');

    -- Google Ads / YouTube / Video Reach
    INSERT INTO public.platforms (name) VALUES ('Google Ads') ON CONFLICT (name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO plat_id;
    INSERT INTO public.inventories (platform_id, name) VALUES (plat_id, 'YouTube') ON CONFLICT (platform_id, name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO inv_id;
    
    INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, is_manual_upload, upload_source_file) 
    VALUES (plat_id, inv_id, 'Video Reach', 'Awareness', true, 'AdFormats_Export.xlsx')
    RETURNING id INTO format_id;
        INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1:1', '5', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1:1', '10', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1:1', '15', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1:1', '20', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1:1', '30', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1:1', '45', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1:1', '60', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '5', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '10', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '15', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '20', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '30', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '45', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '60', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '5', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '10', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '15', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '20', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '30', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '45', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '60', true, 'AdFormats_Export.xlsx');

    -- Reddit / Reddit / Single Image
    INSERT INTO public.platforms (name) VALUES ('Reddit') ON CONFLICT (name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO plat_id;
    INSERT INTO public.inventories (platform_id, name) VALUES (plat_id, 'Reddit') ON CONFLICT (platform_id, name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO inv_id;
    
    INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, is_manual_upload, upload_source_file) 
    VALUES (plat_id, inv_id, 'Single Image', 'Awareness', true, 'AdFormats_Export.xlsx')
    RETURNING id INTO format_id;
        INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, NULL, NULL, true, 'AdFormats_Export.xlsx');

    -- Programmatic / GumGum / Programmatic Display Partner Specific
    INSERT INTO public.platforms (name) VALUES ('Programmatic') ON CONFLICT (name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO plat_id;
    INSERT INTO public.inventories (platform_id, name) VALUES (plat_id, 'GumGum') ON CONFLICT (platform_id, name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO inv_id;
    
    INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, is_manual_upload, upload_source_file) 
    VALUES (plat_id, inv_id, 'Programmatic Display Partner Specific', 'Awareness', true, 'AdFormats_Export.xlsx')
    RETURNING id INTO format_id;
        INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, NULL, NULL, true, 'AdFormats_Export.xlsx');

    -- Meta / Meta / Single Image
    INSERT INTO public.platforms (name) VALUES ('Meta') ON CONFLICT (name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO plat_id;
    INSERT INTO public.inventories (platform_id, name) VALUES (plat_id, 'Meta') ON CONFLICT (platform_id, name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO inv_id;
    
    INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, is_manual_upload, upload_source_file) 
    VALUES (plat_id, inv_id, 'Single Image', 'Consideration', true, 'AdFormats_Export.xlsx')
    RETURNING id INTO format_id;
        INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1:1', NULL, true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', NULL, true, 'AdFormats_Export.xlsx');

    -- Amazon / Fire TV / Video Companion Button
    INSERT INTO public.platforms (name) VALUES ('Amazon') ON CONFLICT (name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO plat_id;
    INSERT INTO public.inventories (platform_id, name) VALUES (plat_id, 'Fire TV') ON CONFLICT (platform_id, name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO inv_id;
    
    INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, is_manual_upload, upload_source_file) 
    VALUES (plat_id, inv_id, 'Video Companion Button', 'Awareness', true, 'AdFormats_Export.xlsx')
    RETURNING id INTO format_id;
        INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1200x1920px (P) and 1920x1200px (L)', NULL, true, 'AdFormats_Export.xlsx');

    -- LinkedIn / LinkedIn / Single Image
    INSERT INTO public.platforms (name) VALUES ('LinkedIn') ON CONFLICT (name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO plat_id;
    INSERT INTO public.inventories (platform_id, name) VALUES (plat_id, 'LinkedIn') ON CONFLICT (platform_id, name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO inv_id;
    
    INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, is_manual_upload, upload_source_file) 
    VALUES (plat_id, inv_id, 'Single Image', 'Consideration', true, 'AdFormats_Export.xlsx')
    RETURNING id INTO format_id;
        INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1200x628', NULL, true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1200x1200', NULL, true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '628x1200', NULL, true, 'AdFormats_Export.xlsx');

    -- Amazon / Twitch / Premium Video
    INSERT INTO public.platforms (name) VALUES ('Amazon') ON CONFLICT (name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO plat_id;
    INSERT INTO public.inventories (platform_id, name) VALUES (plat_id, 'Twitch') ON CONFLICT (platform_id, name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO inv_id;
    
    INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, is_manual_upload, upload_source_file) 
    VALUES (plat_id, inv_id, 'Premium Video', 'Awareness', true, 'AdFormats_Export.xlsx')
    RETURNING id INTO format_id;
        INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1920x1080 (minimum)', '15', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1920x1080 (minimum)', '20', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1920x1080 (minimum)', '30', true, 'AdFormats_Export.xlsx');

    -- Programmatic / Seedtag / Programmatic Display Partner Specific
    INSERT INTO public.platforms (name) VALUES ('Programmatic') ON CONFLICT (name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO plat_id;
    INSERT INTO public.inventories (platform_id, name) VALUES (plat_id, 'Seedtag') ON CONFLICT (platform_id, name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO inv_id;
    
    INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, is_manual_upload, upload_source_file) 
    VALUES (plat_id, inv_id, 'Programmatic Display Partner Specific', 'Consideration', true, 'AdFormats_Export.xlsx')
    RETURNING id INTO format_id;
        INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, NULL, NULL, true, 'AdFormats_Export.xlsx');

    -- Google Ads / YouTube / In-Feed Video Ad
    INSERT INTO public.platforms (name) VALUES ('Google Ads') ON CONFLICT (name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO plat_id;
    INSERT INTO public.inventories (platform_id, name) VALUES (plat_id, 'YouTube') ON CONFLICT (platform_id, name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO inv_id;
    
    INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, is_manual_upload, upload_source_file) 
    VALUES (plat_id, inv_id, 'In-Feed Video Ad', 'Awareness', true, 'AdFormats_Export.xlsx')
    RETURNING id INTO format_id;
        INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1:1', '5', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1:1', '10', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1:1', '15', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1:1', '20', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1:1', '30', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1:1', '45', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1:1', '60', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '5', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '10', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '15', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '20', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '30', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '45', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '60', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '5', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '10', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '15', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '20', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '30', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '45', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '60', true, 'AdFormats_Export.xlsx');

    -- Google Ads / Demand Gen / Video
    INSERT INTO public.platforms (name) VALUES ('Google Ads') ON CONFLICT (name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO plat_id;
    INSERT INTO public.inventories (platform_id, name) VALUES (plat_id, 'Demand Gen') ON CONFLICT (platform_id, name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO inv_id;
    
    INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, is_manual_upload, upload_source_file) 
    VALUES (plat_id, inv_id, 'Video', 'Conversion', true, 'AdFormats_Export.xlsx')
    RETURNING id INTO format_id;
        INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1:1', '5', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1:1', '10', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1:1', '15', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1:1', '20', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1:1', '30', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1:1', '45', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1:1', '60', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '5', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '10', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '15', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '20', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '30', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '45', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '60', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '5', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '10', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '15', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '20', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '30', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '45', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '60', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '4:5', '5', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '4:5', '10', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '4:5', '15', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '4:5', '20', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '4:5', '30', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '4:5', '45', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '4:5', '60', true, 'AdFormats_Export.xlsx');

    -- Programmatic / Blis / Programmatic Display Partner Specific
    INSERT INTO public.platforms (name) VALUES ('Programmatic') ON CONFLICT (name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO plat_id;
    INSERT INTO public.inventories (platform_id, name) VALUES (plat_id, 'Blis') ON CONFLICT (platform_id, name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO inv_id;
    
    INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, is_manual_upload, upload_source_file) 
    VALUES (plat_id, inv_id, 'Programmatic Display Partner Specific', 'Consideration', true, 'AdFormats_Export.xlsx')
    RETURNING id INTO format_id;
        INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, NULL, NULL, true, 'AdFormats_Export.xlsx');

    -- Reddit / Reddit / Video
    INSERT INTO public.platforms (name) VALUES ('Reddit') ON CONFLICT (name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO plat_id;
    INSERT INTO public.inventories (platform_id, name) VALUES (plat_id, 'Reddit') ON CONFLICT (platform_id, name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO inv_id;
    
    INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, is_manual_upload, upload_source_file) 
    VALUES (plat_id, inv_id, 'Video', 'Awareness', true, 'AdFormats_Export.xlsx')
    RETURNING id INTO format_id;
        INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, NULL, NULL, true, 'AdFormats_Export.xlsx');

    -- Programmatic / Seedtag / Programmatic Display Partner Specific
    INSERT INTO public.platforms (name) VALUES ('Programmatic') ON CONFLICT (name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO plat_id;
    INSERT INTO public.inventories (platform_id, name) VALUES (plat_id, 'Seedtag') ON CONFLICT (platform_id, name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO inv_id;
    
    INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, is_manual_upload, upload_source_file) 
    VALUES (plat_id, inv_id, 'Programmatic Display Partner Specific', 'Awareness', true, 'AdFormats_Export.xlsx')
    RETURNING id INTO format_id;
        INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, NULL, NULL, true, 'AdFormats_Export.xlsx');

    -- Amazon / Twitch / Display Ad - Stream Display Ad
    INSERT INTO public.platforms (name) VALUES ('Amazon') ON CONFLICT (name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO plat_id;
    INSERT INTO public.inventories (platform_id, name) VALUES (plat_id, 'Twitch') ON CONFLICT (platform_id, name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO inv_id;
    
    INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, is_manual_upload, upload_source_file) 
    VALUES (plat_id, inv_id, 'Display Ad - Stream Display Ad', 'Awareness', true, 'AdFormats_Export.xlsx')
    RETURNING id INTO format_id;
        INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '160x600', NULL, true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '320x50', NULL, true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '728x90', NULL, true, 'AdFormats_Export.xlsx');

    -- Amazon / Twitch / Display Ad - Medium Rectangle
    INSERT INTO public.platforms (name) VALUES ('Amazon') ON CONFLICT (name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO plat_id;
    INSERT INTO public.inventories (platform_id, name) VALUES (plat_id, 'Twitch') ON CONFLICT (platform_id, name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO inv_id;
    
    INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, is_manual_upload, upload_source_file) 
    VALUES (plat_id, inv_id, 'Display Ad - Medium Rectangle', 'Awareness', true, 'AdFormats_Export.xlsx')
    RETURNING id INTO format_id;
        INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '350x250', NULL, true, 'AdFormats_Export.xlsx');

    -- LinkedIn / LinkedIn / Single Image
    INSERT INTO public.platforms (name) VALUES ('LinkedIn') ON CONFLICT (name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO plat_id;
    INSERT INTO public.inventories (platform_id, name) VALUES (plat_id, 'LinkedIn') ON CONFLICT (platform_id, name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO inv_id;
    
    INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, is_manual_upload, upload_source_file) 
    VALUES (plat_id, inv_id, 'Single Image', 'Conversion', true, 'AdFormats_Export.xlsx')
    RETURNING id INTO format_id;
        INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1200x628', NULL, true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1200x1200', NULL, true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '628x1200', NULL, true, 'AdFormats_Export.xlsx');

    -- Google Ads / Display / Responsive Display Ads
    INSERT INTO public.platforms (name) VALUES ('Google Ads') ON CONFLICT (name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO plat_id;
    INSERT INTO public.inventories (platform_id, name) VALUES (plat_id, 'Display') ON CONFLICT (platform_id, name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO inv_id;
    
    INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, is_manual_upload, upload_source_file) 
    VALUES (plat_id, inv_id, 'Responsive Display Ads', 'Consideration', true, 'AdFormats_Export.xlsx')
    RETURNING id INTO format_id;
        INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '5', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '10', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '15', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '20', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '30', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '45', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '60', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '5', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '10', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '15', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '20', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '30', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '45', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '60', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1200x628', '5', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1200x628', '10', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1200x628', '15', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1200x628', '20', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1200x628', '30', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1200x628', '45', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1200x628', '60', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1200x1200', '5', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1200x1200', '10', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1200x1200', '15', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1200x1200', '20', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1200x1200', '30', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1200x1200', '45', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1200x1200', '60', true, 'AdFormats_Export.xlsx');

    -- Amazon / Twitch / Display Ad - Stream Display Ad
    INSERT INTO public.platforms (name) VALUES ('Amazon') ON CONFLICT (name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO plat_id;
    INSERT INTO public.inventories (platform_id, name) VALUES (plat_id, 'Twitch') ON CONFLICT (platform_id, name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO inv_id;
    
    INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, is_manual_upload, upload_source_file) 
    VALUES (plat_id, inv_id, 'Display Ad - Stream Display Ad', 'Consideration', true, 'AdFormats_Export.xlsx')
    RETURNING id INTO format_id;
        INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '160x600', NULL, true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '320x50', NULL, true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '728x90', NULL, true, 'AdFormats_Export.xlsx');

    -- LinkedIn / LinkedIn / Video
    INSERT INTO public.platforms (name) VALUES ('LinkedIn') ON CONFLICT (name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO plat_id;
    INSERT INTO public.inventories (platform_id, name) VALUES (plat_id, 'LinkedIn') ON CONFLICT (platform_id, name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO inv_id;
    
    INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, is_manual_upload, upload_source_file) 
    VALUES (plat_id, inv_id, 'Video', 'Consideration', true, 'AdFormats_Export.xlsx')
    RETURNING id INTO format_id;
        INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1:1', '5', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1:1', '10', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1:1', '15', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1:1', '20', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1:1', '30', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1:1', '45', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1:1', '60', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '5', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '10', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '15', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '20', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '30', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '45', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '60', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '5', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '10', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '15', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '20', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '30', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '45', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '60', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '4:5', '5', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '4:5', '10', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '4:5', '15', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '4:5', '20', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '4:5', '30', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '4:5', '45', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '4:5', '60', true, 'AdFormats_Export.xlsx');

    -- Google Ads / Display / Responsive Display Ads
    INSERT INTO public.platforms (name) VALUES ('Google Ads') ON CONFLICT (name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO plat_id;
    INSERT INTO public.inventories (platform_id, name) VALUES (plat_id, 'Display') ON CONFLICT (platform_id, name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO inv_id;
    
    INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, is_manual_upload, upload_source_file) 
    VALUES (plat_id, inv_id, 'Responsive Display Ads', 'Conversion', true, 'AdFormats_Export.xlsx')
    RETURNING id INTO format_id;
        INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '5', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '10', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '15', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '20', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '30', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '45', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '60', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '5', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '10', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '15', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '20', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '30', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '45', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '60', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1200x628', '5', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1200x628', '10', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1200x628', '15', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1200x628', '20', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1200x628', '30', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1200x628', '45', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1200x628', '60', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1200x1200', '5', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1200x1200', '10', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1200x1200', '15', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1200x1200', '20', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1200x1200', '30', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1200x1200', '45', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1200x1200', '60', true, 'AdFormats_Export.xlsx');

    -- Google Ads / Demand Gen / Carousel
    INSERT INTO public.platforms (name) VALUES ('Google Ads') ON CONFLICT (name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO plat_id;
    INSERT INTO public.inventories (platform_id, name) VALUES (plat_id, 'Demand Gen') ON CONFLICT (platform_id, name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO inv_id;
    
    INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, is_manual_upload, upload_source_file) 
    VALUES (plat_id, inv_id, 'Carousel', 'Conversion', true, 'AdFormats_Export.xlsx')
    RETURNING id INTO format_id;
        INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1200x628 (2-10 card images)', NULL, true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1200x1200 (2-10 card images)', NULL, true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '960x1200 (2-10 card images)', NULL, true, 'AdFormats_Export.xlsx');

    -- Amazon / Sponsored Products / Product led 
    INSERT INTO public.platforms (name) VALUES ('Amazon') ON CONFLICT (name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO plat_id;
    INSERT INTO public.inventories (platform_id, name) VALUES (plat_id, 'Sponsored Products') ON CONFLICT (platform_id, name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO inv_id;
    
    INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, is_manual_upload, upload_source_file) 
    VALUES (plat_id, inv_id, 'Product led ', 'Conversion', true, 'AdFormats_Export.xlsx')
    RETURNING id INTO format_id;
        INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, 'Product ID & Feed Based', NULL, true, 'AdFormats_Export.xlsx');

    -- Google Ads / YouTube / Skippable In-Stream
    INSERT INTO public.platforms (name) VALUES ('Google Ads') ON CONFLICT (name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO plat_id;
    INSERT INTO public.inventories (platform_id, name) VALUES (plat_id, 'YouTube') ON CONFLICT (platform_id, name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO inv_id;
    
    INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, is_manual_upload, upload_source_file) 
    VALUES (plat_id, inv_id, 'Skippable In-Stream', 'Awareness', true, 'AdFormats_Export.xlsx')
    RETURNING id INTO format_id;
        INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1:1', '5', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1:1', '10', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1:1', '15', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1:1', '20', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1:1', '30', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1:1', '45', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1:1', '60', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '5', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '10', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '15', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '20', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '30', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '45', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '60', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '5', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '10', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '15', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '20', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '30', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '45', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '60', true, 'AdFormats_Export.xlsx');

    -- Amazon / Twitch / Display Ad - Medium Rectangle
    INSERT INTO public.platforms (name) VALUES ('Amazon') ON CONFLICT (name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO plat_id;
    INSERT INTO public.inventories (platform_id, name) VALUES (plat_id, 'Twitch') ON CONFLICT (platform_id, name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO inv_id;
    
    INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, is_manual_upload, upload_source_file) 
    VALUES (plat_id, inv_id, 'Display Ad - Medium Rectangle', 'Consideration', true, 'AdFormats_Export.xlsx')
    RETURNING id INTO format_id;
        INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '350x250', NULL, true, 'AdFormats_Export.xlsx');

    -- Meta / Meta / Video
    INSERT INTO public.platforms (name) VALUES ('Meta') ON CONFLICT (name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO plat_id;
    INSERT INTO public.inventories (platform_id, name) VALUES (plat_id, 'Meta') ON CONFLICT (platform_id, name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO inv_id;
    
    INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, is_manual_upload, upload_source_file) 
    VALUES (plat_id, inv_id, 'Video', 'Awareness', true, 'AdFormats_Export.xlsx')
    RETURNING id INTO format_id;
        INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1:1', '5', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1:1', '10', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1:1', '15', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1:1', '20', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1:1', '30', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1:1', '45', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1:1', '60', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '5', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '10', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '15', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '20', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '30', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '45', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '60', true, 'AdFormats_Export.xlsx');

    -- Meta / Meta / Video
    INSERT INTO public.platforms (name) VALUES ('Meta') ON CONFLICT (name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO plat_id;
    INSERT INTO public.inventories (platform_id, name) VALUES (plat_id, 'Meta') ON CONFLICT (platform_id, name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO inv_id;
    
    INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, is_manual_upload, upload_source_file) 
    VALUES (plat_id, inv_id, 'Video', 'Conversion', true, 'AdFormats_Export.xlsx')
    RETURNING id INTO format_id;
        INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1:1', '5', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1:1', '10', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1:1', '15', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1:1', '20', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1:1', '30', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1:1', '45', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1:1', '60', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '5', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '10', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '15', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '20', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '30', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '45', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '60', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '4:5', '5', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '4:5', '10', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '4:5', '15', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '4:5', '20', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '4:5', '30', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '4:5', '45', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '4:5', '60', true, 'AdFormats_Export.xlsx');

    -- LinkedIn / LinkedIn / Lead Generation Form (Form Only)
    INSERT INTO public.platforms (name) VALUES ('LinkedIn') ON CONFLICT (name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO plat_id;
    INSERT INTO public.inventories (platform_id, name) VALUES (plat_id, 'LinkedIn') ON CONFLICT (platform_id, name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO inv_id;
    
    INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, is_manual_upload, upload_source_file) 
    VALUES (plat_id, inv_id, 'Lead Generation Form (Form Only)', 'Conversion', true, 'AdFormats_Export.xlsx')
    RETURNING id INTO format_id;
        INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, NULL, NULL, true, 'AdFormats_Export.xlsx');

    -- Programmatic / EXTE / Programmatic Display Partner Specific
    INSERT INTO public.platforms (name) VALUES ('Programmatic') ON CONFLICT (name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO plat_id;
    INSERT INTO public.inventories (platform_id, name) VALUES (plat_id, 'EXTE') ON CONFLICT (platform_id, name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO inv_id;
    
    INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, is_manual_upload, upload_source_file) 
    VALUES (plat_id, inv_id, 'Programmatic Display Partner Specific', 'Awareness', true, 'AdFormats_Export.xlsx')
    RETURNING id INTO format_id;
        INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, NULL, NULL, true, 'AdFormats_Export.xlsx');

    -- Meta / Meta / Carousel
    INSERT INTO public.platforms (name) VALUES ('Meta') ON CONFLICT (name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO plat_id;
    INSERT INTO public.inventories (platform_id, name) VALUES (plat_id, 'Meta') ON CONFLICT (platform_id, name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO inv_id;
    
    INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, is_manual_upload, upload_source_file) 
    VALUES (plat_id, inv_id, 'Carousel', 'Conversion', true, 'AdFormats_Export.xlsx')
    RETURNING id INTO format_id;
        INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1:1', '5', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1:1', '10', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1:1', '15', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1:1', '20', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1:1', '30', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1:1', '45', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1:1', '60', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '5', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '10', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '15', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '20', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '30', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '45', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '60', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '4:5', '5', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '4:5', '10', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '4:5', '15', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '4:5', '20', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '4:5', '30', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '4:5', '45', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '4:5', '60', true, 'AdFormats_Export.xlsx');

    -- Google Ads / Demand Gen / Single Image
    INSERT INTO public.platforms (name) VALUES ('Google Ads') ON CONFLICT (name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO plat_id;
    INSERT INTO public.inventories (platform_id, name) VALUES (plat_id, 'Demand Gen') ON CONFLICT (platform_id, name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO inv_id;
    
    INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, is_manual_upload, upload_source_file) 
    VALUES (plat_id, inv_id, 'Single Image', 'Conversion', true, 'AdFormats_Export.xlsx')
    RETURNING id INTO format_id;
        INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1200x628', NULL, true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1200x1200', NULL, true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '960x1200', NULL, true, 'AdFormats_Export.xlsx');

    -- Programmatic / StackAdapt / Video
    INSERT INTO public.platforms (name) VALUES ('Programmatic') ON CONFLICT (name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO plat_id;
    INSERT INTO public.inventories (platform_id, name) VALUES (plat_id, 'StackAdapt') ON CONFLICT (platform_id, name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO inv_id;
    
    INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, is_manual_upload, upload_source_file) 
    VALUES (plat_id, inv_id, 'Video', 'Awareness', true, 'AdFormats_Export.xlsx')
    RETURNING id INTO format_id;
        INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '5', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '10', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '15', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '20', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '30', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '5', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '10', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '15', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '20', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '30', true, 'AdFormats_Export.xlsx');

    -- Google Ads / YouTube / Non-Skippable In-Stream
    INSERT INTO public.platforms (name) VALUES ('Google Ads') ON CONFLICT (name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO plat_id;
    INSERT INTO public.inventories (platform_id, name) VALUES (plat_id, 'YouTube') ON CONFLICT (platform_id, name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO inv_id;
    
    INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, is_manual_upload, upload_source_file) 
    VALUES (plat_id, inv_id, 'Non-Skippable In-Stream', 'Awareness', true, 'AdFormats_Export.xlsx')
    RETURNING id INTO format_id;
        INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1:1', '6', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1:1', '15', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1:1', '30', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '6', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '15', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '30', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '6', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '15', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '30', true, 'AdFormats_Export.xlsx');

    -- Amazon / Twitch / Display Ad - Super Leaderboard
    INSERT INTO public.platforms (name) VALUES ('Amazon') ON CONFLICT (name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO plat_id;
    INSERT INTO public.inventories (platform_id, name) VALUES (plat_id, 'Twitch') ON CONFLICT (platform_id, name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO inv_id;
    
    INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, is_manual_upload, upload_source_file) 
    VALUES (plat_id, inv_id, 'Display Ad - Super Leaderboard', 'Consideration', true, 'AdFormats_Export.xlsx')
    RETURNING id INTO format_id;
        INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '728x90', NULL, true, 'AdFormats_Export.xlsx');

    -- Spotify / Spotify / Video Ad
    INSERT INTO public.platforms (name) VALUES ('Spotify') ON CONFLICT (name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO plat_id;
    INSERT INTO public.inventories (platform_id, name) VALUES (plat_id, 'Spotify') ON CONFLICT (platform_id, name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO inv_id;
    
    INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, is_manual_upload, upload_source_file) 
    VALUES (plat_id, inv_id, 'Video Ad', 'Awareness', true, 'AdFormats_Export.xlsx')
    RETURNING id INTO format_id;
        INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '5', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '10', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '15', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '20', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '30', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '5', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '10', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '15', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '20', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '30', true, 'AdFormats_Export.xlsx');

    -- Amazon / Twitch / Display Ad - Headliner (Mobile)
    INSERT INTO public.platforms (name) VALUES ('Amazon') ON CONFLICT (name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO plat_id;
    INSERT INTO public.inventories (platform_id, name) VALUES (plat_id, 'Twitch') ON CONFLICT (platform_id, name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO inv_id;
    
    INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, is_manual_upload, upload_source_file) 
    VALUES (plat_id, inv_id, 'Display Ad - Headliner (Mobile)', 'Awareness', true, 'AdFormats_Export.xlsx')
    RETURNING id INTO format_id;
        INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1080x1920', NULL, true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '320x50', NULL, true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '640x100', NULL, true, 'AdFormats_Export.xlsx');

    -- Amazon / Fire TV / Video Companion Background
    INSERT INTO public.platforms (name) VALUES ('Amazon') ON CONFLICT (name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO plat_id;
    INSERT INTO public.inventories (platform_id, name) VALUES (plat_id, 'Fire TV') ON CONFLICT (platform_id, name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO inv_id;
    
    INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, is_manual_upload, upload_source_file) 
    VALUES (plat_id, inv_id, 'Video Companion Background', 'Awareness', true, 'AdFormats_Export.xlsx')
    RETURNING id INTO format_id;
        INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1200x1920px (P) and 1920x1200px (L)', NULL, true, 'AdFormats_Export.xlsx');

    -- Amazon / Sponsored Display / Display ad
    INSERT INTO public.platforms (name) VALUES ('Amazon') ON CONFLICT (name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO plat_id;
    INSERT INTO public.inventories (platform_id, name) VALUES (plat_id, 'Sponsored Display') ON CONFLICT (platform_id, name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO inv_id;
    
    INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, is_manual_upload, upload_source_file) 
    VALUES (plat_id, inv_id, 'Display ad', 'Conversion', true, 'AdFormats_Export.xlsx')
    RETURNING id INTO format_id;
        INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '160x600', NULL, true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '320x50', NULL, true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '728x90', NULL, true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '300x600', NULL, true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '1940x500', NULL, true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '414x125', NULL, true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '300x250', NULL, true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '728x90 (mobile)', NULL, true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '300x250 (mobile)', NULL, true, 'AdFormats_Export.xlsx');

    -- Programmatic / EXTE / Programmatic Display Partner Specific
    INSERT INTO public.platforms (name) VALUES ('Programmatic') ON CONFLICT (name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO plat_id;
    INSERT INTO public.inventories (platform_id, name) VALUES (plat_id, 'EXTE') ON CONFLICT (platform_id, name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO inv_id;
    
    INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, is_manual_upload, upload_source_file) 
    VALUES (plat_id, inv_id, 'Programmatic Display Partner Specific', 'Conversion', true, 'AdFormats_Export.xlsx')
    RETURNING id INTO format_id;
        INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, NULL, NULL, true, 'AdFormats_Export.xlsx');

    -- Programmatic / GumGum / Programmatic Display Partner Specific
    INSERT INTO public.platforms (name) VALUES ('Programmatic') ON CONFLICT (name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO plat_id;
    INSERT INTO public.inventories (platform_id, name) VALUES (plat_id, 'GumGum') ON CONFLICT (platform_id, name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO inv_id;
    
    INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, is_manual_upload, upload_source_file) 
    VALUES (plat_id, inv_id, 'Programmatic Display Partner Specific', 'Conversion', true, 'AdFormats_Export.xlsx')
    RETURNING id INTO format_id;
        INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, NULL, NULL, true, 'AdFormats_Export.xlsx');

    -- Programmatic / Blis / Programmatic Display Partner Specific
    INSERT INTO public.platforms (name) VALUES ('Programmatic') ON CONFLICT (name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO plat_id;
    INSERT INTO public.inventories (platform_id, name) VALUES (plat_id, 'Blis') ON CONFLICT (platform_id, name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO inv_id;
    
    INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, is_manual_upload, upload_source_file) 
    VALUES (plat_id, inv_id, 'Programmatic Display Partner Specific', 'Conversion', true, 'AdFormats_Export.xlsx')
    RETURNING id INTO format_id;
        INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, NULL, NULL, true, 'AdFormats_Export.xlsx');

    -- Programmatic / Seedtag / Programmatic Display Partner Specific
    INSERT INTO public.platforms (name) VALUES ('Programmatic') ON CONFLICT (name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO plat_id;
    INSERT INTO public.inventories (platform_id, name) VALUES (plat_id, 'Seedtag') ON CONFLICT (platform_id, name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO inv_id;
    
    INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, is_manual_upload, upload_source_file) 
    VALUES (plat_id, inv_id, 'Programmatic Display Partner Specific', 'Conversion', true, 'AdFormats_Export.xlsx')
    RETURNING id INTO format_id;
        INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, NULL, NULL, true, 'AdFormats_Export.xlsx');

    -- Programmatic / StackAdapt / Programmatic Display Partner Specific
    INSERT INTO public.platforms (name) VALUES ('Programmatic') ON CONFLICT (name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO plat_id;
    INSERT INTO public.inventories (platform_id, name) VALUES (plat_id, 'StackAdapt') ON CONFLICT (platform_id, name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO inv_id;
    
    INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, is_manual_upload, upload_source_file) 
    VALUES (plat_id, inv_id, 'Programmatic Display Partner Specific', 'Conversion', true, 'AdFormats_Export.xlsx')
    RETURNING id INTO format_id;
        INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '160x600', NULL, true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '320x50', NULL, true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '728x90', NULL, true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '300x600', NULL, true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '300x250, 970x250', NULL, true, 'AdFormats_Export.xlsx');

    -- Programmatic / StackAdapt / Video
    INSERT INTO public.platforms (name) VALUES ('Programmatic') ON CONFLICT (name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO plat_id;
    INSERT INTO public.inventories (platform_id, name) VALUES (plat_id, 'StackAdapt') ON CONFLICT (platform_id, name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO inv_id;
    
    INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, is_manual_upload, upload_source_file) 
    VALUES (plat_id, inv_id, 'Video', 'Conversion', true, 'AdFormats_Export.xlsx')
    RETURNING id INTO format_id;
        INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '5', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '10', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '15', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '20', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '30', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '5', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '10', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '15', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '20', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '30', true, 'AdFormats_Export.xlsx');

    -- Programmatic / StackAdapt / Video
    INSERT INTO public.platforms (name) VALUES ('Programmatic') ON CONFLICT (name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO plat_id;
    INSERT INTO public.inventories (platform_id, name) VALUES (plat_id, 'StackAdapt') ON CONFLICT (platform_id, name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO inv_id;
    
    INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, is_manual_upload, upload_source_file) 
    VALUES (plat_id, inv_id, 'Video', 'Consideration', true, 'AdFormats_Export.xlsx')
    RETURNING id INTO format_id;
        INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '5', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '10', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '15', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '20', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '30', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '5', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '10', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '15', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '20', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '30', true, 'AdFormats_Export.xlsx');

    -- Programmatic / StackAdapt / Programmatic Display Partner Specific
    INSERT INTO public.platforms (name) VALUES ('Programmatic') ON CONFLICT (name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO plat_id;
    INSERT INTO public.inventories (platform_id, name) VALUES (plat_id, 'StackAdapt') ON CONFLICT (platform_id, name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO inv_id;
    
    INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, is_manual_upload, upload_source_file) 
    VALUES (plat_id, inv_id, 'Programmatic Display Partner Specific', 'Awareness', true, 'AdFormats_Export.xlsx')
    RETURNING id INTO format_id;
        INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '160x600', NULL, true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '320x50', NULL, true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '728x90', NULL, true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '300x600', NULL, true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '300x250, 970x250', NULL, true, 'AdFormats_Export.xlsx');

    -- Programmatic / StackAdapt / Programmatic Display Partner Specific
    INSERT INTO public.platforms (name) VALUES ('Programmatic') ON CONFLICT (name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO plat_id;
    INSERT INTO public.inventories (platform_id, name) VALUES (plat_id, 'StackAdapt') ON CONFLICT (platform_id, name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO inv_id;
    
    INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, is_manual_upload, upload_source_file) 
    VALUES (plat_id, inv_id, 'Programmatic Display Partner Specific', 'Consideration', true, 'AdFormats_Export.xlsx')
    RETURNING id INTO format_id;
        INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '160x600', NULL, true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '320x50', NULL, true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '728x90', NULL, true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '300x600', NULL, true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '300x250, 970x250', NULL, true, 'AdFormats_Export.xlsx');

    -- Programmatic / Readpeak / Programmatic Display Partner Specific
    INSERT INTO public.platforms (name) VALUES ('Programmatic') ON CONFLICT (name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO plat_id;
    INSERT INTO public.inventories (platform_id, name) VALUES (plat_id, 'Readpeak') ON CONFLICT (platform_id, name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO inv_id;
    
    INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, is_manual_upload, upload_source_file) 
    VALUES (plat_id, inv_id, 'Programmatic Display Partner Specific', 'Awareness', true, 'AdFormats_Export.xlsx')
    RETURNING id INTO format_id;
        INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, NULL, NULL, true, 'AdFormats_Export.xlsx');

    -- Programmatic / Readpeak / Programmatic Display Partner Specific
    INSERT INTO public.platforms (name) VALUES ('Programmatic') ON CONFLICT (name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO plat_id;
    INSERT INTO public.inventories (platform_id, name) VALUES (plat_id, 'Readpeak') ON CONFLICT (platform_id, name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO inv_id;
    
    INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, is_manual_upload, upload_source_file) 
    VALUES (plat_id, inv_id, 'Programmatic Display Partner Specific', 'Consideration', true, 'AdFormats_Export.xlsx')
    RETURNING id INTO format_id;
        INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, NULL, NULL, true, 'AdFormats_Export.xlsx');

    -- Programmatic / Readpeak / Programmatic Display Partner Specific
    INSERT INTO public.platforms (name) VALUES ('Programmatic') ON CONFLICT (name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO plat_id;
    INSERT INTO public.inventories (platform_id, name) VALUES (plat_id, 'Readpeak') ON CONFLICT (platform_id, name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO inv_id;
    
    INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, is_manual_upload, upload_source_file) 
    VALUES (plat_id, inv_id, 'Programmatic Display Partner Specific', 'Conversion', true, 'AdFormats_Export.xlsx')
    RETURNING id INTO format_id;
        INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, NULL, NULL, true, 'AdFormats_Export.xlsx');

    -- Programmatic / EXTE / Video
    INSERT INTO public.platforms (name) VALUES ('Programmatic') ON CONFLICT (name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO plat_id;
    INSERT INTO public.inventories (platform_id, name) VALUES (plat_id, 'EXTE') ON CONFLICT (platform_id, name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO inv_id;
    
    INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, is_manual_upload, upload_source_file) 
    VALUES (plat_id, inv_id, 'Video', 'Consideration', true, 'AdFormats_Export.xlsx')
    RETURNING id INTO format_id;
        INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '5', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '10', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '15', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '20', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '30', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '5', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '10', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '15', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '20', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '30', true, 'AdFormats_Export.xlsx');

    -- Programmatic / GumGum / Video
    INSERT INTO public.platforms (name) VALUES ('Programmatic') ON CONFLICT (name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO plat_id;
    INSERT INTO public.inventories (platform_id, name) VALUES (plat_id, 'GumGum') ON CONFLICT (platform_id, name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO inv_id;
    
    INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, is_manual_upload, upload_source_file) 
    VALUES (plat_id, inv_id, 'Video', 'Consideration', true, 'AdFormats_Export.xlsx')
    RETURNING id INTO format_id;
        INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '5', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '10', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '15', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '20', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '30', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '5', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '10', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '15', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '20', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '30', true, 'AdFormats_Export.xlsx');

    -- Programmatic / Blis / Video
    INSERT INTO public.platforms (name) VALUES ('Programmatic') ON CONFLICT (name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO plat_id;
    INSERT INTO public.inventories (platform_id, name) VALUES (plat_id, 'Blis') ON CONFLICT (platform_id, name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO inv_id;
    
    INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, is_manual_upload, upload_source_file) 
    VALUES (plat_id, inv_id, 'Video', 'Awareness', true, 'AdFormats_Export.xlsx')
    RETURNING id INTO format_id;
        INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '5', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '10', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '15', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '20', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '30', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '5', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '10', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '15', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '20', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '30', true, 'AdFormats_Export.xlsx');

    -- Programmatic / GumGum / Video
    INSERT INTO public.platforms (name) VALUES ('Programmatic') ON CONFLICT (name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO plat_id;
    INSERT INTO public.inventories (platform_id, name) VALUES (plat_id, 'GumGum') ON CONFLICT (platform_id, name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO inv_id;
    
    INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, is_manual_upload, upload_source_file) 
    VALUES (plat_id, inv_id, 'Video', 'Awareness', true, 'AdFormats_Export.xlsx')
    RETURNING id INTO format_id;
        INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '5', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '10', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '15', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '20', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '30', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '5', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '10', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '15', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '20', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '30', true, 'AdFormats_Export.xlsx');

    -- Programmatic / Seedtag / Video
    INSERT INTO public.platforms (name) VALUES ('Programmatic') ON CONFLICT (name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO plat_id;
    INSERT INTO public.inventories (platform_id, name) VALUES (plat_id, 'Seedtag') ON CONFLICT (platform_id, name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO inv_id;
    
    INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, is_manual_upload, upload_source_file) 
    VALUES (plat_id, inv_id, 'Video', 'Consideration', true, 'AdFormats_Export.xlsx')
    RETURNING id INTO format_id;
        INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '5', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '10', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '15', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '20', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '30', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '5', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '10', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '15', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '20', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '30', true, 'AdFormats_Export.xlsx');

    -- Programmatic / Blis / Video
    INSERT INTO public.platforms (name) VALUES ('Programmatic') ON CONFLICT (name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO plat_id;
    INSERT INTO public.inventories (platform_id, name) VALUES (plat_id, 'Blis') ON CONFLICT (platform_id, name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO inv_id;
    
    INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, is_manual_upload, upload_source_file) 
    VALUES (plat_id, inv_id, 'Video', 'Consideration', true, 'AdFormats_Export.xlsx')
    RETURNING id INTO format_id;
        INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '5', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '10', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '15', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '20', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '30', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '5', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '10', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '15', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '20', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '30', true, 'AdFormats_Export.xlsx');

    -- Programmatic / Seedtag / Video
    INSERT INTO public.platforms (name) VALUES ('Programmatic') ON CONFLICT (name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO plat_id;
    INSERT INTO public.inventories (platform_id, name) VALUES (plat_id, 'Seedtag') ON CONFLICT (platform_id, name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO inv_id;
    
    INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, is_manual_upload, upload_source_file) 
    VALUES (plat_id, inv_id, 'Video', 'Awareness', true, 'AdFormats_Export.xlsx')
    RETURNING id INTO format_id;
        INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '5', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '10', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '15', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '20', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '30', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '5', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '10', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '15', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '20', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '30', true, 'AdFormats_Export.xlsx');

    -- Programmatic / EXTE / Video
    INSERT INTO public.platforms (name) VALUES ('Programmatic') ON CONFLICT (name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO plat_id;
    INSERT INTO public.inventories (platform_id, name) VALUES (plat_id, 'EXTE') ON CONFLICT (platform_id, name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO inv_id;
    
    INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, is_manual_upload, upload_source_file) 
    VALUES (plat_id, inv_id, 'Video', 'Awareness', true, 'AdFormats_Export.xlsx')
    RETURNING id INTO format_id;
        INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '5', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '10', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '15', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '20', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '30', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '5', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '10', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '15', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '20', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '30', true, 'AdFormats_Export.xlsx');

    -- Programmatic / EXTE / Video
    INSERT INTO public.platforms (name) VALUES ('Programmatic') ON CONFLICT (name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO plat_id;
    INSERT INTO public.inventories (platform_id, name) VALUES (plat_id, 'EXTE') ON CONFLICT (platform_id, name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO inv_id;
    
    INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, is_manual_upload, upload_source_file) 
    VALUES (plat_id, inv_id, 'Video', 'Conversion', true, 'AdFormats_Export.xlsx')
    RETURNING id INTO format_id;
        INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '5', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '10', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '15', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '20', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '30', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '5', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '10', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '15', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '20', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '30', true, 'AdFormats_Export.xlsx');

    -- Programmatic / GumGum / Video
    INSERT INTO public.platforms (name) VALUES ('Programmatic') ON CONFLICT (name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO plat_id;
    INSERT INTO public.inventories (platform_id, name) VALUES (plat_id, 'GumGum') ON CONFLICT (platform_id, name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO inv_id;
    
    INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, is_manual_upload, upload_source_file) 
    VALUES (plat_id, inv_id, 'Video', 'Conversion', true, 'AdFormats_Export.xlsx')
    RETURNING id INTO format_id;
        INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '5', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '10', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '15', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '20', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '30', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '5', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '10', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '15', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '20', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '30', true, 'AdFormats_Export.xlsx');

    -- Programmatic / Blis / Video
    INSERT INTO public.platforms (name) VALUES ('Programmatic') ON CONFLICT (name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO plat_id;
    INSERT INTO public.inventories (platform_id, name) VALUES (plat_id, 'Blis') ON CONFLICT (platform_id, name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO inv_id;
    
    INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, is_manual_upload, upload_source_file) 
    VALUES (plat_id, inv_id, 'Video', 'Conversion', true, 'AdFormats_Export.xlsx')
    RETURNING id INTO format_id;
        INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '5', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '10', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '15', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '20', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '30', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '5', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '10', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '15', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '20', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '30', true, 'AdFormats_Export.xlsx');

    -- Programmatic / Seedtag / Video
    INSERT INTO public.platforms (name) VALUES ('Programmatic') ON CONFLICT (name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO plat_id;
    INSERT INTO public.inventories (platform_id, name) VALUES (plat_id, 'Seedtag') ON CONFLICT (platform_id, name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO inv_id;
    
    INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, is_manual_upload, upload_source_file) 
    VALUES (plat_id, inv_id, 'Video', 'Conversion', true, 'AdFormats_Export.xlsx')
    RETURNING id INTO format_id;
        INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '5', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '10', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '15', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '20', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '30', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '5', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '10', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '15', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '20', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '30', true, 'AdFormats_Export.xlsx');

    -- Programmatic / StackAdapt / Video
    INSERT INTO public.platforms (name) VALUES ('Programmatic') ON CONFLICT (name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO plat_id;
    INSERT INTO public.inventories (platform_id, name) VALUES (plat_id, 'StackAdapt') ON CONFLICT (platform_id, name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO inv_id;
    
    INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, is_manual_upload, upload_source_file) 
    VALUES (plat_id, inv_id, 'Video', 'Conversion', true, 'AdFormats_Export.xlsx')
    RETURNING id INTO format_id;
        INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '5', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '10', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '15', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '20', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '30', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '5', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '10', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '15', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '20', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '30', true, 'AdFormats_Export.xlsx');

    -- Programmatic / StackAdapt / Video
    INSERT INTO public.platforms (name) VALUES ('Programmatic') ON CONFLICT (name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO plat_id;
    INSERT INTO public.inventories (platform_id, name) VALUES (plat_id, 'StackAdapt') ON CONFLICT (platform_id, name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO inv_id;
    
    INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, is_manual_upload, upload_source_file) 
    VALUES (plat_id, inv_id, 'Video', 'Awareness', true, 'AdFormats_Export.xlsx')
    RETURNING id INTO format_id;
        INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '5', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '10', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '15', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '20', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '30', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '5', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '10', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '15', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '20', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '30', true, 'AdFormats_Export.xlsx');

    -- Programmatic / StackAdapt / Video
    INSERT INTO public.platforms (name) VALUES ('Programmatic') ON CONFLICT (name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO plat_id;
    INSERT INTO public.inventories (platform_id, name) VALUES (plat_id, 'StackAdapt') ON CONFLICT (platform_id, name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO inv_id;
    
    INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, is_manual_upload, upload_source_file) 
    VALUES (plat_id, inv_id, 'Video', 'Consideration', true, 'AdFormats_Export.xlsx')
    RETURNING id INTO format_id;
        INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '5', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '10', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '15', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '20', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '30', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '5', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '10', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '15', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '20', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '30', true, 'AdFormats_Export.xlsx');

    -- Programmatic / Readpeak / Video
    INSERT INTO public.platforms (name) VALUES ('Programmatic') ON CONFLICT (name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO plat_id;
    INSERT INTO public.inventories (platform_id, name) VALUES (plat_id, 'Readpeak') ON CONFLICT (platform_id, name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO inv_id;
    
    INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, is_manual_upload, upload_source_file) 
    VALUES (plat_id, inv_id, 'Video', 'Awareness', true, 'AdFormats_Export.xlsx')
    RETURNING id INTO format_id;
        INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '5', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '10', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '15', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '20', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '30', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '5', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '10', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '15', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '20', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '30', true, 'AdFormats_Export.xlsx');

    -- Programmatic / Readpeak / Video
    INSERT INTO public.platforms (name) VALUES ('Programmatic') ON CONFLICT (name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO plat_id;
    INSERT INTO public.inventories (platform_id, name) VALUES (plat_id, 'Readpeak') ON CONFLICT (platform_id, name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO inv_id;
    
    INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, is_manual_upload, upload_source_file) 
    VALUES (plat_id, inv_id, 'Video', 'Consideration', true, 'AdFormats_Export.xlsx')
    RETURNING id INTO format_id;
        INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '5', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '10', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '15', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '20', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '30', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '5', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '10', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '15', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '20', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '30', true, 'AdFormats_Export.xlsx');

    -- Programmatic / Readpeak / Video
    INSERT INTO public.platforms (name) VALUES ('Programmatic') ON CONFLICT (name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO plat_id;
    INSERT INTO public.inventories (platform_id, name) VALUES (plat_id, 'Readpeak') ON CONFLICT (platform_id, name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO inv_id;
    
    INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, is_manual_upload, upload_source_file) 
    VALUES (plat_id, inv_id, 'Video', 'Conversion', true, 'AdFormats_Export.xlsx')
    RETURNING id INTO format_id;
        INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '5', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '10', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '15', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '20', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '30', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '5', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '10', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '15', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '20', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '30', true, 'AdFormats_Export.xlsx');

    -- Programmatic / LoopMe / Video
    INSERT INTO public.platforms (name) VALUES ('Programmatic') ON CONFLICT (name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO plat_id;
    INSERT INTO public.inventories (platform_id, name) VALUES (plat_id, 'LoopMe') ON CONFLICT (platform_id, name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO inv_id;
    
    INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, is_manual_upload, upload_source_file) 
    VALUES (plat_id, inv_id, 'Video', 'Awareness', true, 'AdFormats_Export.xlsx')
    RETURNING id INTO format_id;
        INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '5', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '10', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '15', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '20', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '30', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '5', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '10', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '15', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '20', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '30', true, 'AdFormats_Export.xlsx');

    -- Programmatic / LoopMe / Programmatic Display Partner Specific
    INSERT INTO public.platforms (name) VALUES ('Programmatic') ON CONFLICT (name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO plat_id;
    INSERT INTO public.inventories (platform_id, name) VALUES (plat_id, 'LoopMe') ON CONFLICT (platform_id, name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO inv_id;
    
    INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, is_manual_upload, upload_source_file) 
    VALUES (plat_id, inv_id, 'Programmatic Display Partner Specific', 'Conversion', true, 'AdFormats_Export.xlsx')
    RETURNING id INTO format_id;
        INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, NULL, NULL, true, 'AdFormats_Export.xlsx');

    -- Programmatic / LoopMe / Video
    INSERT INTO public.platforms (name) VALUES ('Programmatic') ON CONFLICT (name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO plat_id;
    INSERT INTO public.inventories (platform_id, name) VALUES (plat_id, 'LoopMe') ON CONFLICT (platform_id, name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO inv_id;
    
    INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, is_manual_upload, upload_source_file) 
    VALUES (plat_id, inv_id, 'Video', 'Conversion', true, 'AdFormats_Export.xlsx')
    RETURNING id INTO format_id;
        INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '5', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '10', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '15', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '20', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '30', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '5', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '10', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '15', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '20', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '30', true, 'AdFormats_Export.xlsx');

    -- Programmatic / LoopMe / Video
    INSERT INTO public.platforms (name) VALUES ('Programmatic') ON CONFLICT (name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO plat_id;
    INSERT INTO public.inventories (platform_id, name) VALUES (plat_id, 'LoopMe') ON CONFLICT (platform_id, name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO inv_id;
    
    INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, is_manual_upload, upload_source_file) 
    VALUES (plat_id, inv_id, 'Video', 'Consideration', true, 'AdFormats_Export.xlsx')
    RETURNING id INTO format_id;
        INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '5', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '10', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '15', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '20', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '30', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '5', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '10', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '15', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '20', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '30', true, 'AdFormats_Export.xlsx');

    -- Programmatic / LoopMe / Programmatic Display Partner Specific
    INSERT INTO public.platforms (name) VALUES ('Programmatic') ON CONFLICT (name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO plat_id;
    INSERT INTO public.inventories (platform_id, name) VALUES (plat_id, 'LoopMe') ON CONFLICT (platform_id, name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO inv_id;
    
    INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, is_manual_upload, upload_source_file) 
    VALUES (plat_id, inv_id, 'Programmatic Display Partner Specific', 'Awareness', true, 'AdFormats_Export.xlsx')
    RETURNING id INTO format_id;
        INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, NULL, NULL, true, 'AdFormats_Export.xlsx');

    -- Programmatic / LoopMe / Programmatic Display Partner Specific
    INSERT INTO public.platforms (name) VALUES ('Programmatic') ON CONFLICT (name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO plat_id;
    INSERT INTO public.inventories (platform_id, name) VALUES (plat_id, 'LoopMe') ON CONFLICT (platform_id, name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO inv_id;
    
    INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, is_manual_upload, upload_source_file) 
    VALUES (plat_id, inv_id, 'Programmatic Display Partner Specific', 'Consideration', true, 'AdFormats_Export.xlsx')
    RETURNING id INTO format_id;
        INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, NULL, NULL, true, 'AdFormats_Export.xlsx');

    -- Programmatic / Sabio / Video
    INSERT INTO public.platforms (name) VALUES ('Programmatic') ON CONFLICT (name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO plat_id;
    INSERT INTO public.inventories (platform_id, name) VALUES (plat_id, 'Sabio') ON CONFLICT (platform_id, name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO inv_id;
    
    INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, is_manual_upload, upload_source_file) 
    VALUES (plat_id, inv_id, 'Video', 'Awareness', true, 'AdFormats_Export.xlsx')
    RETURNING id INTO format_id;
        INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '5', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '10', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '15', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '20', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '30', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '5', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '10', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '15', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '20', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '30', true, 'AdFormats_Export.xlsx');

    -- Programmatic / Sabio / Programmatic Display Partner Specific
    INSERT INTO public.platforms (name) VALUES ('Programmatic') ON CONFLICT (name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO plat_id;
    INSERT INTO public.inventories (platform_id, name) VALUES (plat_id, 'Sabio') ON CONFLICT (platform_id, name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO inv_id;
    
    INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, is_manual_upload, upload_source_file) 
    VALUES (plat_id, inv_id, 'Programmatic Display Partner Specific', 'Conversion', true, 'AdFormats_Export.xlsx')
    RETURNING id INTO format_id;
        INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, NULL, NULL, true, 'AdFormats_Export.xlsx');

    -- Programmatic / Sabio / Video
    INSERT INTO public.platforms (name) VALUES ('Programmatic') ON CONFLICT (name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO plat_id;
    INSERT INTO public.inventories (platform_id, name) VALUES (plat_id, 'Sabio') ON CONFLICT (platform_id, name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO inv_id;
    
    INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, is_manual_upload, upload_source_file) 
    VALUES (plat_id, inv_id, 'Video', 'Conversion', true, 'AdFormats_Export.xlsx')
    RETURNING id INTO format_id;
        INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '5', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '10', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '15', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '20', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '30', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '5', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '10', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '15', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '20', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '30', true, 'AdFormats_Export.xlsx');

    -- Programmatic / Sabio / Video
    INSERT INTO public.platforms (name) VALUES ('Programmatic') ON CONFLICT (name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO plat_id;
    INSERT INTO public.inventories (platform_id, name) VALUES (plat_id, 'Sabio') ON CONFLICT (platform_id, name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO inv_id;
    
    INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, is_manual_upload, upload_source_file) 
    VALUES (plat_id, inv_id, 'Video', 'Consideration', true, 'AdFormats_Export.xlsx')
    RETURNING id INTO format_id;
        INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '5', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '10', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '15', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '20', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '9:16', '30', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '5', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '10', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '15', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '20', true, 'AdFormats_Export.xlsx');
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, '16:9', '30', true, 'AdFormats_Export.xlsx');

    -- Programmatic / Sabio / Programmatic Display Partner Specific
    INSERT INTO public.platforms (name) VALUES ('Programmatic') ON CONFLICT (name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO plat_id;
    INSERT INTO public.inventories (platform_id, name) VALUES (plat_id, 'Sabio') ON CONFLICT (platform_id, name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO inv_id;
    
    INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, is_manual_upload, upload_source_file) 
    VALUES (plat_id, inv_id, 'Programmatic Display Partner Specific', 'Awareness', true, 'AdFormats_Export.xlsx')
    RETURNING id INTO format_id;
        INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, NULL, NULL, true, 'AdFormats_Export.xlsx');

    -- Programmatic / Sabio / Programmatic Display Partner Specific
    INSERT INTO public.platforms (name) VALUES ('Programmatic') ON CONFLICT (name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO plat_id;
    INSERT INTO public.inventories (platform_id, name) VALUES (plat_id, 'Sabio') ON CONFLICT (platform_id, name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO inv_id;
    
    INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, is_manual_upload, upload_source_file) 
    VALUES (plat_id, inv_id, 'Programmatic Display Partner Specific', 'Consideration', true, 'AdFormats_Export.xlsx')
    RETURNING id INTO format_id;
        INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, NULL, NULL, true, 'AdFormats_Export.xlsx');

END $$;
