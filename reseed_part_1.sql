-- Reseed Ad Formats and Variants - Part 1: LinkedIn & Google Ads
DO $$ 
DECLARE 
    plat_id uuid;
    inv_id uuid;
    format_id uuid;
BEGIN
    -- LinkedIn
    INSERT INTO public.platforms (name) VALUES ('LinkedIn') ON CONFLICT (name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO plat_id;
    
    -- LinkedIn / LinkedIn / Carousel (Conversion)
    INSERT INTO public.inventories (platform_id, name) VALUES (plat_id, 'LinkedIn') ON CONFLICT (platform_id, name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO inv_id;
    INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, requires_video, is_manual_upload) 
    VALUES (plat_id, inv_id, 'Carousel', 'Conversion', false, true) RETURNING id INTO format_id;
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio) VALUES (format_id, '1:1');

    -- LinkedIn / LinkedIn / Carousel (Consideration)
    INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, requires_video, is_manual_upload) 
    VALUES (plat_id, inv_id, 'Carousel', 'Consideration', false, true) RETURNING id INTO format_id;
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio) VALUES (format_id, '1:1');

    -- LinkedIn / LinkedIn / Text Ads (Conversion)
    INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, requires_video, is_manual_upload) 
    VALUES (plat_id, inv_id, 'Text Ads', 'Conversion', false, true) RETURNING id INTO format_id;

    -- LinkedIn / LinkedIn / Video (Awareness)
    INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, requires_video, is_manual_upload) 
    VALUES (plat_id, inv_id, 'Video', 'Awareness', true, true) RETURNING id INTO format_id;
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration) 
    SELECT format_id, ratio, len FROM unnest(ARRAY['1:1','9:16','16:9','4:5']) ratio, unnest(ARRAY['5','10','15','20','30','45','60']) len;

    -- Google Ads
    INSERT INTO public.platforms (name) VALUES ('Google Ads') ON CONFLICT (name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO plat_id;
    
    -- Google Ads / Search / Text Ads (Conversion)
    INSERT INTO public.inventories (platform_id, name) VALUES (plat_id, 'Search') ON CONFLICT (platform_id, name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO inv_id;
    INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, requires_video, is_manual_upload) 
    VALUES (plat_id, inv_id, 'Text Ads', 'Conversion', false, true) RETURNING id INTO format_id;

    -- Google Ads / Demand Gen / Video (Consideration)
    INSERT INTO public.inventories (platform_id, name) VALUES (plat_id, 'Demand Gen') ON CONFLICT (platform_id, name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO inv_id;
    INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, requires_video, is_manual_upload) 
    VALUES (plat_id, inv_id, 'Video', 'Consideration', true, true) RETURNING id INTO format_id;
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration) 
    SELECT format_id, ratio, len FROM unnest(ARRAY['1:1','9:16','16:9','4:5']) ratio, unnest(ARRAY['5','10','15','20','30','45','60']) len;

    -- Google Ads / Demand Gen / Carousel (Consideration)
    INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, requires_video, is_manual_upload) 
    VALUES (plat_id, inv_id, 'Carousel', 'Consideration', false, true) RETURNING id INTO format_id;
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio) VALUES (format_id, '1200x628 (2-10 card images)'), (format_id, '1200x1200 (2-10 card images)'), (format_id, '960x1200 (2-10 card images)');

    -- Google Ads / YouTube / Video Reach (Awareness)
    INSERT INTO public.inventories (platform_id, name) VALUES (plat_id, 'YouTube') ON CONFLICT (platform_id, name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO inv_id;
    INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, requires_video, is_manual_upload) 
    VALUES (plat_id, inv_id, 'Video Reach', 'Awareness', true, true) RETURNING id INTO format_id;
    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration) 
    SELECT format_id, ratio, len FROM unnest(ARRAY['1:1','9:16','16:9']) ratio, unnest(ARRAY['5','10','15','20','30','45','60']) len;

END $$;
