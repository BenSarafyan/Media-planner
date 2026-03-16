-- Media Asset Identification Rules Schema
-- This script sets up the database table for the asset identification logic

DROP TABLE IF EXISTS public.media_asset_rules CASCADE;

CREATE TABLE IF NOT EXISTS public.media_asset_rules (
    id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
    funnel_stage text NOT NULL, -- Awareness, Consideration, Conversion
    campaign_goal text NOT NULL, -- Brand Awareness, Product Awareness, Sales conversion
    channel text NOT NULL, -- META, GOOGLE, TIKTOK, LINKEDIN, PARTNER 1
    hero_video_required boolean DEFAULT false,
    asset_list jsonb NOT NULL, -- List of assets with names and specs
    created_at timestamptz DEFAULT now()
);

-- Enable RLS
ALTER TABLE public.media_asset_rules ENABLE ROW LEVEL SECURITY;

-- Allow public read
DROP POLICY IF EXISTS "Allow public read on media_asset_rules" ON public.media_asset_rules;
CREATE POLICY "Allow public read on media_asset_rules" 
ON public.media_asset_rules FOR SELECT 
USING (true);

-- Seed initial data
INSERT INTO public.media_asset_rules (funnel_stage, campaign_goal, channel, hero_video_required, asset_list)
VALUES 
('Awareness', 'Brand Awareness', 'META', true, '[
  {"name": "Meta Video Ad (16:9)", "specs": "1920x1080"},
  {"name": "Meta Stories Video (9:16)", "specs": "1080x1920"}
]'::jsonb),
('Awareness', 'Brand Awareness', 'META', false, '[
  {"name": "Meta Static Image (1:1)", "specs": "1080x1080"},
  {"name": "Meta Stories Static (9:16)", "specs": "1080x1920"}
]'::jsonb),
('Awareness', 'Brand Awareness', 'GOOGLE', true, '[
  {"name": "YouTube Bumper Ad", "specs": "6s"},
  {"name": "YouTube TrueView", "specs": "Skippable"}
]'::jsonb),
('Consideration', 'Product Awareness', 'META', true, '[
  {"name": "Meta Link Ad (Video)", "specs": "1200x628"},
  {"name": "Meta Collection Ad", "specs": "1:1 + layout"}
]'::jsonb);

-- Campaigns Table
-- This table stores the master campaign data
DROP TABLE IF EXISTS public.campaigns CASCADE;

CREATE TABLE IF NOT EXISTS public.campaigns (
    id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
    name text NOT NULL,
    client_name text NOT NULL DEFAULT 'General',
    live_date date DEFAULT CURRENT_DATE + INTERVAL '30 days',
    total_budget numeric NOT NULL DEFAULT 0,
    markets jsonb NOT NULL DEFAULT '[]'::jsonb, -- Array of market objects {code: 'UK', name: 'United Kingdom', isOver40k: boolean}
    assets jsonb DEFAULT '[]'::jsonb, -- Store generated assets
    asset_config jsonb DEFAULT '[]'::jsonb, -- Store survey configuration
    status text DEFAULT 'setup', -- setup, active, completed
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now()
);

-- Enable RLS for campaigns
ALTER TABLE public.campaigns ENABLE ROW LEVEL SECURITY;

-- Allow public read/write for demo purposes
DROP POLICY IF EXISTS "Allow public all on campaigns" ON public.campaigns;
CREATE POLICY "Allow public all on campaigns" 
ON public.campaigns FOR ALL
USING (true)
WITH CHECK (true);

-- Seed some sample campaigns for the "All Projects" view
INSERT INTO public.campaigns (name, client_name, live_date, total_budget, markets, status)
VALUES 
('Shopper insights checker', 'Stanley Black & Decker', '2026-06-01', 50000, '[{"code": "US", "name": "United States", "isOver40k": true}]'::jsonb, 'active'),
('DEMO - Assets Submitted', 'Stanley Black & Decker', '2026-06-01', 25000, '[{"code": "GB", "name": "United Kingdom", "isOver40k": false}]'::jsonb, 'active'),
('New layout and look test', 'Stanley Black & Decker', '2026-06-01', 15000, '[{"code": "DE", "name": "Germany", "isOver40k": false}]'::jsonb, 'active'),
('SBD user test', 'Stanley Black & Decker', '2026-06-01', 10000, '[{"code": "FR", "name": "France", "isOver40k": false}]'::jsonb, 'setup'),
('Summer Launch Meta', 'Nike', '2026-07-15', 120000, '[{"code": "US", "name": "United States", "isOver40k": true}, {"code": "FR", "name": "France", "isOver40k": false}]'::jsonb, 'active'),
('Holiday Blast', 'Nike', '2026-11-20', 80000, '[{"code": "GB", "name": "United Kingdom", "isOver40k": true}]'::jsonb, 'setup');
-- Morning Coffee Drive
INSERT INTO public.campaigns (name, client_name, live_date, total_budget, markets, status)
VALUES ('Morning Coffee Drive', 'Nestle', '2026-05-10', 45000, '[{"code": "IT", "name": "Italy", "isOver40k": true}]'::jsonb, 'active');

-- Platforms Table
DROP TABLE IF EXISTS public.platforms CASCADE;
CREATE TABLE IF NOT EXISTS public.platforms (
    id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
    name text NOT NULL UNIQUE,
    created_at timestamptz DEFAULT now()
);

-- Inventories Table
DROP TABLE IF EXISTS public.inventories CASCADE;
CREATE TABLE IF NOT EXISTS public.inventories (
    id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
    platform_id uuid REFERENCES public.platforms(id) ON DELETE CASCADE,
    name text NOT NULL,
    created_at timestamptz DEFAULT now(),
    UNIQUE(platform_id, name)
);

-- Ad Formats Table
DROP TABLE IF EXISTS public.ad_formats CASCADE;
CREATE TABLE IF NOT EXISTS public.ad_formats (
    id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
    platform_id uuid REFERENCES public.platforms(id) ON DELETE CASCADE,
    inventory_id uuid REFERENCES public.inventories(id) ON DELETE CASCADE,
    name text NOT NULL,
    funnel_stage text NOT NULL, -- Awareness, Consideration, Conversion
    requires_video boolean DEFAULT false,
    format_type text, -- Static, Video, Carousel, HTML5
    aspect_ratio text, -- 9:16, 1:1, 16:9, 4:5
    dimensions text, -- 1080x1920, 1080x1080
    file_extension text, -- .mp4, .png, .jpg, .mov, .gif
    file_size text, -- 500KB, 15MB
    duration text, -- 6s, 15s, 30s, 60s
    specs text, -- Legacy catch-all field
    is_manual_upload boolean DEFAULT false,
    upload_source_file text,
    created_at timestamptz DEFAULT now()
);

-- Ad Format Variants Table
DROP TABLE IF EXISTS public.ad_format_variants CASCADE;
CREATE TABLE IF NOT EXISTS public.ad_format_variants (
    id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
    ad_format_id uuid REFERENCES public.ad_formats(id) ON DELETE CASCADE,
    aspect_ratio text,
    duration text,
    is_manual_upload boolean DEFAULT false,
    upload_source_file text,
    created_at timestamptz DEFAULT now()
);

-- Enable RLS for New Tables
ALTER TABLE public.platforms ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.inventories ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.ad_formats ENABLE ROW LEVEL SECURITY;

-- Allow public read/write for demo purposes
DROP POLICY IF EXISTS "Allow public all on platforms" ON public.platforms;
CREATE POLICY "Allow public all on platforms" ON public.platforms FOR ALL USING (true) WITH CHECK (true);

DROP POLICY IF EXISTS "Allow public all on inventories" ON public.inventories;
CREATE POLICY "Allow public all on inventories" ON public.inventories FOR ALL USING (true) WITH CHECK (true);

DROP POLICY IF EXISTS "Allow public all on ad_formats" ON public.ad_formats;
CREATE POLICY "Allow public all on ad_formats" ON public.ad_formats FOR ALL USING (true) WITH CHECK (true);

-- Enable RLS for variants
ALTER TABLE public.ad_format_variants ENABLE ROW LEVEL SECURITY;
DROP POLICY IF EXISTS "Allow public all on ad_format_variants" ON public.ad_format_variants;
CREATE POLICY "Allow public all on ad_format_variants" ON public.ad_format_variants FOR ALL USING (true) WITH CHECK (true);


-- Note: Platforms, Inventories, and Ad Formats are now managed via manual imports.
-- Seed data is provided in separate scripts (e.g., seed_excel_data.sql)

