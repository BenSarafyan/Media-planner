-- Reseed Ad Formats and Variants - Part 3: Meta & Spotify
DO $$ 
DECLARE 
    plat_id uuid;
    inv_id uuid;
    format_id uuid;
BEGIN
    -- Meta
    INSERT INTO public.platforms (name) VALUES ('Meta') ON CONFLICT (name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO plat_id;
    
    -- Meta / Meta / Single Image (Awareness)
    INSERT INTO public.inventories (platform_id, name) VALUES (plat_id, 'Meta') ON CONFLICT (platform_id, name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO inv_id;
    INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, requires_video, is_manual_upload) 
    VALUES (plat_id, inv_id, 'Single Image', 'Awareness', false, true) RETURNING id INTO format_id;
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio) VALUES (format_id, '1:1'), (format_id, '9:16');

    -- Meta / Meta / Video (Consideration)
    INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, requires_video, is_manual_upload) 
    VALUES (plat_id, inv_id, 'Video', 'Consideration', true, true) RETURNING id INTO format_id;
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration) 
    SELECT format_id, ratio, len FROM unnest(ARRAY['1:1','9:16']) ratio, unnest(ARRAY['5','10','15','20','30','45','60']) len;

    -- Spotify
    INSERT INTO public.platforms (name) VALUES ('Spotify') ON CONFLICT (name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO plat_id;
    
    -- Spotify / Spotify / Spotify Audio Ad (Awareness) - NO VIDEO
    INSERT INTO public.inventories (platform_id, name) VALUES (plat_id, 'Spotify') ON CONFLICT (platform_id, name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO inv_id;
    INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, requires_video, is_manual_upload) 
    VALUES (plat_id, inv_id, 'Spotify Audio Ad', 'Awareness', false, true) RETURNING id INTO format_id;
    INSERT INTO public.ad_format_variants (ad_format_id, duration) 
    SELECT format_id, len FROM unnest(ARRAY['5','10','15','20','30']) len;

    -- Spotify / Spotify / Video Ad (Awareness)
    INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, requires_video, is_manual_upload) 
    VALUES (plat_id, inv_id, 'Video Ad', 'Awareness', true, true) RETURNING id INTO format_id;
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration) 
    SELECT format_id, ratio, len FROM unnest(ARRAY['9:16','16:9']) ratio, unnest(ARRAY['5','10','15','20','30']) len;

END $$;
