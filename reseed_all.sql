-- Reseed All Ad Formats and Variants (Monolithic Script)
-- Use this script in the Supabase SQL Editor

-- Clear existing data
TRUNCATE public.ad_format_variants, public.ad_formats, public.inventories, public.platforms RESTART IDENTITY CASCADE;

-- PART 1: LinkedIn & Google Ads
DO $$ 
DECLARE 
    plat_id uuid;
    inv_id uuid;
    format_id uuid;
BEGIN
    INSERT INTO public.platforms (name) VALUES ('LinkedIn') ON CONFLICT (name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO plat_id;
    INSERT INTO public.inventories (platform_id, name) VALUES (plat_id, 'LinkedIn') ON CONFLICT (platform_id, name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO inv_id;
    INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, requires_video, is_manual_upload) 
    VALUES (plat_id, inv_id, 'Carousel', 'Conversion', false, true) RETURNING id INTO format_id;
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio) VALUES (format_id, '1:1');
    INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, requires_video, is_manual_upload) 
    VALUES (plat_id, inv_id, 'Carousel', 'Consideration', false, true) RETURNING id INTO format_id;
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio) VALUES (format_id, '1:1');
    INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, requires_video, is_manual_upload) 
    VALUES (plat_id, inv_id, 'Text Ads', 'Conversion', false, true) RETURNING id INTO format_id;
    INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, requires_video, is_manual_upload) 
    VALUES (plat_id, inv_id, 'Video', 'Awareness', true, true) RETURNING id INTO format_id;
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration) 
    SELECT format_id, ratio, len FROM unnest(ARRAY['1:1','9:16','16:9','4:5']) ratio, unnest(ARRAY['5','10','15','20','30','45','60']) len;

    INSERT INTO public.platforms (name) VALUES ('Google Ads') ON CONFLICT (name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO plat_id;
    INSERT INTO public.inventories (platform_id, name) VALUES (plat_id, 'Search') ON CONFLICT (platform_id, name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO inv_id;
    INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, requires_video, is_manual_upload) 
    VALUES (plat_id, inv_id, 'Text Ads', 'Conversion', false, true) RETURNING id INTO format_id;
    INSERT INTO public.inventories (platform_id, name) VALUES (plat_id, 'Demand Gen') ON CONFLICT (platform_id, name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO inv_id;
    INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, requires_video, is_manual_upload) 
    VALUES (plat_id, inv_id, 'Video', 'Consideration', true, true) RETURNING id INTO format_id;
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration) 
    SELECT format_id, ratio, len FROM unnest(ARRAY['1:1','9:16','16:9','4:5']) ratio, unnest(ARRAY['5','10','15','20','30','45','60']) len;
    INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, requires_video, is_manual_upload) 
    VALUES (plat_id, inv_id, 'Carousel', 'Consideration', false, true) RETURNING id INTO format_id;
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio) VALUES (format_id, '1200x628 (2-10 card images)'), (format_id, '1200x1200 (2-10 card images)'), (format_id, '960x1200 (2-10 card images)');
    INSERT INTO public.inventories (platform_id, name) VALUES (plat_id, 'YouTube') ON CONFLICT (platform_id, name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO inv_id;
    INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, requires_video, is_manual_upload) 
    VALUES (plat_id, inv_id, 'Video Reach', 'Awareness', true, true) RETURNING id INTO format_id;
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration) 
    SELECT format_id, ratio, len FROM unnest(ARRAY['1:1','9:16','16:9']) ratio, unnest(ARRAY['5','10','15','20','30','45','60']) len;
END $$;

-- PART 2: Amazon
DO $$ 
DECLARE 
    plat_id uuid;
    inv_id uuid;
    format_id uuid;
BEGIN
    INSERT INTO public.platforms (name) VALUES ('Amazon') ON CONFLICT (name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO plat_id;
    INSERT INTO public.inventories (platform_id, name) VALUES (plat_id, 'Prime Video') ON CONFLICT (platform_id, name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO inv_id;
    INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, requires_video, is_manual_upload) 
    VALUES (plat_id, inv_id, 'Video', 'Awareness', true, true) RETURNING id INTO format_id;
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration) 
    SELECT format_id, '1920x1080 (minimum)', len FROM unnest(ARRAY['15','20','30','40','60']) len;
    INSERT INTO public.inventories (platform_id, name) VALUES (plat_id, 'Sponsored Display') ON CONFLICT (platform_id, name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO inv_id;
    INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, requires_video, is_manual_upload) 
    VALUES (plat_id, inv_id, 'Display ad', 'Consideration', false, true) RETURNING id INTO format_id;
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio) 
    SELECT format_id, ratio FROM unnest(ARRAY['160x600','320x50','728x90','300x600','1940x500','414x125','300x250']) ratio;
    INSERT INTO public.inventories (platform_id, name) VALUES (plat_id, 'Twitch') ON CONFLICT (platform_id, name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO inv_id;
    INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, requires_video, is_manual_upload) 
    VALUES (plat_id, inv_id, 'Display Ad - Super Leaderboard', 'Awareness', false, true) RETURNING id INTO format_id;
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio) VALUES (format_id, '728x90');
    INSERT INTO public.inventories (platform_id, name) VALUES (plat_id, 'Amazon Audio') ON CONFLICT (platform_id, name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO inv_id;
    INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, requires_video, is_manual_upload) 
    VALUES (plat_id, inv_id, 'Amazon Audio Ad', 'Awareness', false, true) RETURNING id INTO format_id;
    INSERT INTO public.ad_format_variants (ad_format_id, duration) 
    SELECT format_id, len FROM unnest(ARRAY['10','15','20','30']) len;
    INSERT INTO public.inventories (platform_id, name) VALUES (plat_id, 'Fire TV') ON CONFLICT (platform_id, name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO inv_id;
    INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, requires_video, is_manual_upload) 
    VALUES (plat_id, inv_id, 'Video', 'Awareness', true, true) RETURNING id INTO format_id;
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration) 
    SELECT format_id, ratio, len FROM unnest(ARRAY['16:9','16:10']) ratio, unnest(ARRAY['5','10','15']) len;
END $$;

-- PART 3: Meta & Spotify
DO $$ 
DECLARE 
    plat_id uuid;
    inv_id uuid;
    format_id uuid;
BEGIN
    INSERT INTO public.platforms (name) VALUES ('Meta') ON CONFLICT (name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO plat_id;
    INSERT INTO public.inventories (platform_id, name) VALUES (plat_id, 'Meta') ON CONFLICT (platform_id, name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO inv_id;
    INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, requires_video, is_manual_upload) 
    VALUES (plat_id, inv_id, 'Single Image', 'Awareness', false, true) RETURNING id INTO format_id;
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio) VALUES (format_id, '1:1'), (format_id, '9:16');
    INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, requires_video, is_manual_upload) 
    VALUES (plat_id, inv_id, 'Video', 'Consideration', true, true) RETURNING id INTO format_id;
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration) 
    SELECT format_id, ratio, len FROM unnest(ARRAY['1:1','9:16']) ratio, unnest(ARRAY['5','10','15','20','30','45','60']) len;

    INSERT INTO public.platforms (name) VALUES ('Spotify') ON CONFLICT (name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO plat_id;
    INSERT INTO public.inventories (platform_id, name) VALUES (plat_id, 'Spotify') ON CONFLICT (platform_id, name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO inv_id;
    INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, requires_video, is_manual_upload) 
    VALUES (plat_id, inv_id, 'Spotify Audio Ad', 'Awareness', false, true) RETURNING id INTO format_id;
    INSERT INTO public.ad_format_variants (ad_format_id, duration) 
    SELECT format_id, len FROM unnest(ARRAY['5','10','15','20','30']) len;
    INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, requires_video, is_manual_upload) 
    VALUES (plat_id, inv_id, 'Video Ad', 'Awareness', true, true) RETURNING id INTO format_id;
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration) 
    SELECT format_id, ratio, len FROM unnest(ARRAY['9:16','16:9']) ratio, unnest(ARRAY['5','10','15','20','30']) len;
END $$;

-- PART 4: Programmatic & Reddit
DO $$ 
DECLARE 
    plat_id uuid;
    inv_id uuid;
    format_id uuid;
    partner text;
BEGIN
    INSERT INTO public.platforms (name) VALUES ('Programmatic') ON CONFLICT (name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO plat_id;
    FOREACH partner IN ARRAY ARRAY['EXTE', 'GumGum', 'Blis', 'Seedtag', 'Readpeak', 'LoopMe', 'Sabio'] LOOP
        INSERT INTO public.inventories (platform_id, name) VALUES (plat_id, partner) ON CONFLICT (platform_id, name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO inv_id;
        INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, requires_video, is_manual_upload) 
        VALUES (plat_id, inv_id, 'Programmatic Display Partner Specific', 'Awareness', false, true);
        INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, requires_video, is_manual_upload) 
        VALUES (plat_id, inv_id, 'Programmatic Display Partner Specific', 'Consideration', false, true);
        INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, requires_video, is_manual_upload) 
        VALUES (plat_id, inv_id, 'Programmatic Display Partner Specific', 'Conversion', false, true);
        INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, requires_video, is_manual_upload) 
        VALUES (plat_id, inv_id, 'Video', 'Awareness', true, true) RETURNING id INTO format_id;
        INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration) SELECT format_id, ratio, len FROM unnest(ARRAY['9:16','16:9']) ratio, unnest(ARRAY['5','10','15','20','30']) len;
        INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, requires_video, is_manual_upload) 
        VALUES (plat_id, inv_id, 'Video', 'Consideration', true, true) RETURNING id INTO format_id;
        INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration) SELECT format_id, ratio, len FROM unnest(ARRAY['9:16','16:9']) ratio, unnest(ARRAY['5','10','15','20','30']) len;
        INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, requires_video, is_manual_upload) 
        VALUES (plat_id, inv_id, 'Video', 'Conversion', true, true) RETURNING id INTO format_id;
        INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration) SELECT format_id, ratio, len FROM unnest(ARRAY['9:16','16:9']) ratio, unnest(ARRAY['5','10','15','20','30']) len;
    END LOOP;

    INSERT INTO public.platforms (name) VALUES ('Reddit') ON CONFLICT (name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO plat_id;
    INSERT INTO public.inventories (platform_id, name) VALUES (plat_id, 'Reddit') ON CONFLICT (platform_id, name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO inv_id;
    INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, requires_video, is_manual_upload) 
    VALUES (plat_id, inv_id, 'Carousel', 'Awareness', false, true);
    INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, requires_video, is_manual_upload) 
    VALUES (plat_id, inv_id, 'Single Image', 'Awareness', false, true);
    INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, requires_video, is_manual_upload) 
    VALUES (plat_id, inv_id, 'Conversation Ad', 'Awareness', false, true);
    INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, requires_video, is_manual_upload) 
    VALUES (plat_id, inv_id, 'Video', 'Awareness', true, true);
END $$;
