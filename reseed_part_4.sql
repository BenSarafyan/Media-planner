-- Reseed Ad Formats and Variants - Part 4: Programmatic & Reddit
DO $$ 
DECLARE 
    plat_id uuid;
    inv_id uuid;
    format_id uuid;
    partner text;
BEGIN
    -- Programmatic Partners
    INSERT INTO public.platforms (name) VALUES ('Programmatic') ON CONFLICT (name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO plat_id;
    
    FOREACH partner IN ARRAY ARRAY['EXTE', 'GumGum', 'Blis', 'Seedtag', 'Readpeak', 'LoopMe', 'Sabio'] LOOP
        INSERT INTO public.inventories (platform_id, name) VALUES (plat_id, partner) ON CONFLICT (platform_id, name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO inv_id;
        
        -- Display (Awareness, Consideration, Conversion)
        INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, requires_video, is_manual_upload) 
        VALUES (plat_id, inv_id, 'Programmatic Display Partner Specific', 'Awareness', false, true);
        INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, requires_video, is_manual_upload) 
        VALUES (plat_id, inv_id, 'Programmatic Display Partner Specific', 'Consideration', false, true);
        INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, requires_video, is_manual_upload) 
        VALUES (plat_id, inv_id, 'Programmatic Display Partner Specific', 'Conversion', false, true);
        
        -- Video (Awareness, Consideration, Conversion)
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

    -- Reddit
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
