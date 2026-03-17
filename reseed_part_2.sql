-- Reseed Ad Formats and Variants - Part 2: Amazon
DO $$ 
DECLARE 
    plat_id uuid;
    inv_id uuid;
    format_id uuid;
BEGIN
    INSERT INTO public.platforms (name) VALUES ('Amazon') ON CONFLICT (name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO plat_id;
    
    -- Amazon / Prime Video / Video (Awareness)
    INSERT INTO public.inventories (platform_id, name) VALUES (plat_id, 'Prime Video') ON CONFLICT (platform_id, name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO inv_id;
    INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, requires_video, is_manual_upload) 
    VALUES (plat_id, inv_id, 'Video', 'Awareness', true, true) RETURNING id INTO format_id;
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration) 
    SELECT format_id, '1920x1080 (minimum)', len FROM unnest(ARRAY['15','20','30','40','60']) len;

    -- Amazon / Sponsored Display / Display ad (Consideration)
    INSERT INTO public.inventories (platform_id, name) VALUES (plat_id, 'Sponsored Display') ON CONFLICT (platform_id, name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO inv_id;
    INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, requires_video, is_manual_upload) 
    VALUES (plat_id, inv_id, 'Display ad', 'Consideration', false, true) RETURNING id INTO format_id;
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio) 
    SELECT format_id, ratio FROM unnest(ARRAY['160x600','320x50','728x90','300x600','1940x500','414x125','300x250']) ratio;

    -- Amazon / Twitch / Display Ad - Super Leaderboard (Awareness)
    INSERT INTO public.inventories (platform_id, name) VALUES (plat_id, 'Twitch') ON CONFLICT (platform_id, name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO inv_id;
    INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, requires_video, is_manual_upload) 
    VALUES (plat_id, inv_id, 'Display Ad - Super Leaderboard', 'Awareness', false, true) RETURNING id INTO format_id;
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio) VALUES (format_id, '728x90');

    -- Amazon / Amazon Audio / Amazon Audio Ad (Awareness) - NO VIDEO
    INSERT INTO public.inventories (platform_id, name) VALUES (plat_id, 'Amazon Audio') ON CONFLICT (platform_id, name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO inv_id;
    INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, requires_video, is_manual_upload) 
    VALUES (plat_id, inv_id, 'Amazon Audio Ad', 'Awareness', false, true) RETURNING id INTO format_id;
    INSERT INTO public.ad_format_variants (ad_format_id, duration) 
    SELECT format_id, len FROM unnest(ARRAY['10','15','20','30']) len;

    -- Amazon / Fire TV / Video (Awareness)
    INSERT INTO public.inventories (platform_id, name) VALUES (plat_id, 'Fire TV') ON CONFLICT (platform_id, name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO inv_id;
    INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, requires_video, is_manual_upload) 
    VALUES (plat_id, inv_id, 'Video', 'Awareness', true, true) RETURNING id INTO format_id;
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration) 
    SELECT format_id, ratio, len FROM unnest(ARRAY['16:9','16:10']) ratio, unnest(ARRAY['5','10','15']) len;

END $$;
