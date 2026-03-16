const fs = require('fs');

const data = `funnel_name	channel_name	platform_name	ad_format_name	ratios	lengths
Moment of Purchase (Conversion)	LinkedIn	LinkedIn	Carousel	["1:1"]	
Active Evaluation (Consideration)	LinkedIn	LinkedIn	Carousel	["1:1"]	
Moment of Purchase (Conversion)	Google Ads	Search	Text Ads		
Initial Consideration (Awareness)	Amazon	Prime Video	Video	["1920x1080 (minimum)"]	["15","20","30","40","60"]
Initial Consideration (Awareness)	Meta	Meta	Single Image	["1:1","9:16"]	
Active Evaluation (Consideration)	Amazon	Sponsored Display	Display ad	["160x600","320x50","728x90","728x90","300x600","1940x500","414x125","300x250","300x250"]	
Active Evaluation (Consideration)	Google Ads	Demand Gen	Video	["1:1","9:16","16:9","4:5"]	["5","10","15","20","30","45","60"]
Initial Consideration (Awareness)	Spotify	Spotify	Spotify Audio Ad Companion Logo	["1:1, 640x640"]	
Initial Consideration (Awareness)	Meta	Meta	Carousel	["1:1","9:16"]	["5","10","15","20","30","45","60"]
Initial Consideration (Awareness)	Amazon	Twitch	Display Ad - Super Leaderboard	["728x90"]	
Initial Consideration (Awareness)	Spotify	Spotify	Spotify Audio Ad Companion Banner	["1:1, 640x640"]	
Active Evaluation (Consideration)	Google Ads	Demand Gen	Carousel	["1200x628 (2-10 card images)","1200x1200 (2-10 card images)","960x1200 (2-10 card images)"]	
Active Evaluation (Consideration)	Programmatic	EXTE	Programmatic Display Partner Specific		
Initial Consideration (Awareness)	Reddit	Reddit	Carousel		
Initial Consideration (Awareness)	Spotify	Spotify	Image Overlay Ad	["630x920","800x435"]	
Moment of Purchase (Conversion)	Meta	Meta	Single Image	["1:1","9:16"]	
Active Evaluation (Consideration)	Google Ads	Demand Gen	Single Image	["1200x628","1200x1200","960x1200"]	
Active Evaluation (Consideration)	Amazon	Twitch	Display Ad - Headliner (Desktop)	["Left Unit: 450x350; Right Unit: 450x350"]	
Moment of Purchase (Conversion)	LinkedIn	LinkedIn	Text Ads		
Initial Consideration (Awareness)	Amazon	Amazon Audio	Amazon Audio Ad Companion Image	["1024x1024"]	
Active Evaluation (Consideration)	Meta	Meta	Video	["1:1","9:16"]	["5","10","15","20","30","45","60"]
Initial Consideration (Awareness)	Amazon	Sponsored Brands	Video	["16:9, 1280x720","16:9, 1920x1080","16:9, 3840x2160"]	["5","10","15","20","30","45"]
Initial Consideration (Awareness)	Amazon	Sponsored Brands	Product collection		
Initial Consideration (Awareness)	LinkedIn	LinkedIn	Video	["1:1","9:16","16:9","4:5"]	["5","10","15","20","30","45","60"]
Initial Consideration (Awareness)	Spotify	Spotify	Spotify Audio Ad		["5","10","15","20","30"]
Active Evaluation (Consideration)	Meta	Meta	Carousel	["1:1","9:16"]	["5","10","15","20","30","45","60"]
Initial Consideration (Awareness)	Amazon	Fire TV	Video	["16:9","16:10"]	["5","10","15"]
Moment of Purchase (Conversion)	Google Ads	Performance Max	Images, Logos, Text Assets, Video Assets (All required to launch) 	["1:1","1:1","9:16","16:9","4:5","1:9, 1:1"]	["10","15","20","30","40","60"]
Active Evaluation (Consideration)	Amazon	Twitch	Display Ad - Headliner (Mobile)	["1080x1920","320x50","640x100"]	
Initial Consideration (Awareness)	Amazon	Sponsored Brands	Store Spotlight	["1200x628 (minimum)"]	
Active Evaluation (Consideration)	LinkedIn	LinkedIn	Text Ads		
Active Evaluation (Consideration)	Programmatic	GumGum	Programmatic Display Partner Specific		
Initial Consideration (Awareness)	Reddit	Reddit	Conversation Ad		
Initial Consideration (Awareness)	Amazon	Twitch	Display Ad - Headliner (Desktop)	["Left Unit: 450x350; Right Unit: 450x350"]	
Initial Consideration (Awareness)	Amazon	Amazon Audio	Amazon Audio Ad		["10","15","20","30"]
Initial Consideration (Awareness)	Programmatic	Blis	Programmatic Display Partner Specific		
Initial Consideration (Awareness)	Amazon	Twitch	First Impression Takeover	["1920x1080 (minimum)"]	["5","10","15","20","30"]
Moment of Purchase (Conversion)	LinkedIn	LinkedIn	Video	["1:1","9:16","16:9","4:5"]	["5","10","15","20","30","45","60"]
Initial Consideration (Awareness)	Google Ads	YouTube	Video Reach	["1:1","9:16","16:9"]	["5","10","15","20","30","45","60"]
Initial Consideration (Awareness)	Reddit	Reddit	Single Image		
Initial Consideration (Awareness)	Programmatic	GumGum	Programmatic Display Partner Specific		
Active Evaluation (Consideration)	Meta	Meta	Single Image	["1:1","9:16"]	
Initial Consideration (Awareness)	Amazon	Fire TV	Video Companion Button	["1200x1920px (P) and 1920x1200px (L)"]	
Active Evaluation (Consideration)	LinkedIn	LinkedIn	Single Image	["1200x628","1200x1200","628x1200"]	
Initial Consideration (Awareness)	Amazon	Twitch	Premium Video	["1920x1080 (minimum)"]	["15","20","30"]
Active Evaluation (Consideration)	Programmatic	Seedtag	Programmatic Display Partner Specific		
Initial Consideration (Awareness)	Google Ads	YouTube	In-Feed Video Ad	["1:1","9:16","16:9"]	["5","10","15","20","30","45","60"]
Moment of Purchase (Conversion)	Google Ads	Demand Gen	Video	["1:1","9:16","16:9","4:5"]	["5","10","15","20","30","45","60"]
Active Evaluation (Consideration)	Programmatic	Blis	Programmatic Display Partner Specific		
Initial Consideration (Awareness)	Reddit	Reddit	Video		
Initial Consideration (Awareness)	Programmatic	Seedtag	Programmatic Display Partner Specific		
Initial Consideration (Awareness)	Amazon	Twitch	Display Ad - Stream Display Ad	["160x600","320x50","728x90"]	
Initial Consideration (Awareness)	Amazon	Twitch	Display Ad - Medium Rectangle	["350x250"]	
Moment of Purchase (Conversion)	LinkedIn	LinkedIn	Single Image	["1200x628","1200x1200","628x1200"]	
Active Evaluation (Consideration)	Google Ads	Display	Responsive Display Ads	["9:16","16:9","1200x628","1200x1200"]	["5","10","15","20","30","45","60"]
Active Evaluation (Consideration)	Amazon	Twitch	Display Ad - Stream Display Ad	["160x600","320x50","728x90"]	
Active Evaluation (Consideration)	LinkedIn	LinkedIn	Video	["1:1","9:16","16:9","4:5"]	["5","10","15","20","30","45","60"]
Moment of Purchase (Conversion)	Google Ads	Display	Responsive Display Ads	["9:16","16:9","1200x628","1200x1200"]	["5","10","15","20","30","45","60"]
Moment of Purchase (Conversion)	Google Ads	Demand Gen	Carousel	["1200x628 (2-10 card images)","1200x1200 (2-10 card images)","960x1200 (2-10 card images)"]	
Moment of Purchase (Conversion)	Amazon	Sponsored Products	Product led 	["Product ID & Feed Based"]	
Initial Consideration (Awareness)	Google Ads	YouTube	Skippable In-Stream	["1:1","9:16","16:9"]	["5","10","15","20","30","45","60"]
Active Evaluation (Consideration)	Amazon	Twitch	Display Ad - Medium Rectangle	["350x250"]	
Initial Consideration (Awareness)	Meta	Meta	Video	["1:1","9:16"]	["5","10","15","20","30","45","60"]
Moment of Purchase (Conversion)	Meta	Meta	Video	["1:1","9:16","4:5"]	["5","10","15","20","30","45","60"]
Moment of Purchase (Conversion)	LinkedIn	LinkedIn	Lead Generation Form (Form Only)		
Initial Consideration (Awareness)	Programmatic	EXTE	Programmatic Display Partner Specific		
Moment of Purchase (Conversion)	Meta	Meta	Carousel	["1:1","9:16","4:5"]	["5","10","15","20","30","45","60"]
Moment of Purchase (Conversion)	Google Ads	Demand Gen	Single Image	["1200x628","1200x1200","960x1200"]	
Initial Consideration (Awareness)	Programmatic	StackAdapt	Video	["9:16","16:9"]	["5","10","15","20","30"]
Initial Consideration (Awareness)	Google Ads	YouTube	Non-Skippable In-Stream	["1:1","9:16","16:9"]	["6","15","30"]
Active Evaluation (Consideration)	Amazon	Twitch	Display Ad - Super Leaderboard	["728x90"]	
Initial Consideration (Awareness)	Spotify	Spotify	Video Ad	["9:16","16:9"]	["5","10","15","20","30"]
Initial Consideration (Awareness)	Amazon	Twitch	Display Ad - Headliner (Mobile)	["1080x1920","320x50","640x100"]	
Initial Consideration (Awareness)	Amazon	Fire TV	Video Companion Background	["1200x1920px (P) and 1920x1200px (L)"]	
Moment of Purchase (Conversion)	Amazon	Sponsored Display	Display ad	["160x600","320x50","728x90","300x600","1940x500","414x125","300x250","728x90 (mobile)","300x250 (mobile)"]	
Moment of Purchase (Conversion)	Programmatic	EXTE	Programmatic Display Partner Specific		
Moment of Purchase (Conversion)	Programmatic	GumGum	Programmatic Display Partner Specific		
Moment of Purchase (Conversion)	Programmatic	Blis	Programmatic Display Partner Specific		
Moment of Purchase (Conversion)	Programmatic	Seedtag	Programmatic Display Partner Specific		
Moment of Purchase (Conversion)	Programmatic	StackAdapt	Programmatic Display Partner Specific	["160x600","320x50","728x90","300x600","300x250, 970x250"]	
Moment of Purchase (Conversion)	Programmatic	StackAdapt	Video	["9:16","16:9"]	["5","10","15","20","30"]
Active Evaluation (Consideration)	Programmatic	StackAdapt	Video	["9:16","16:9"]	["5","10","15","20","30"]
Initial Consideration (Awareness)	Programmatic	StackAdapt	Programmatic Display Partner Specific	["160x600","320x50","728x90","300x600","300x250, 970x250"]	
Active Evaluation (Consideration)	Programmatic	StackAdapt	Programmatic Display Partner Specific	["160x600","320x50","728x90","300x600","300x250, 970x250"]	
Initial Consideration (Awareness)	Programmatic	Readpeak	Programmatic Display Partner Specific		
Active Evaluation (Consideration)	Programmatic	Readpeak	Programmatic Display Partner Specific		
Moment of Purchase (Conversion)	Programmatic	Readpeak	Programmatic Display Partner Specific		
Active Evaluation (Consideration)	Programmatic	EXTE	Video	["9:16","16:9"]	["5","10","15","20","30"]
Active Evaluation (Consideration)	Programmatic	GumGum	Video	["9:16","16:9"]	["5","10","15","20","30"]
Initial Consideration (Awareness)	Programmatic	Blis	Video	["9:16","16:9"]	["5","10","15","20","30"]
Initial Consideration (Awareness)	Programmatic	GumGum	Video	["9:16","16:9"]	["5","10","15","20","30"]
Active Evaluation (Consideration)	Programmatic	Seedtag	Video	["9:16","16:9"]	["5","10","15","20","30"]
Active Evaluation (Consideration)	Programmatic	Blis	Video	["9:16","16:9"]	["5","10","15","20","30"]
Initial Consideration (Awareness)	Programmatic	Seedtag	Video	["9:16","16:9"]	["5","10","15","20","30"]
Initial Consideration (Awareness)	Programmatic	EXTE	Video	["9:16","16:9"]	["5","10","15","20","30"]
Moment of Purchase (Conversion)	Programmatic	EXTE	Video	["9:16","16:9"]	["5","10","15","20","30"]
Moment of Purchase (Conversion)	Programmatic	GumGum	Video	["9:16","16:9"]	["5","10","15","20","30"]
Moment of Purchase (Conversion)	Programmatic	Blis	Video	["9:16","16:9"]	["5","10","15","20","30"]
Moment of Purchase (Conversion)	Programmatic	Seedtag	Video	["9:16","16:9"]	["5","10","15","20","30"]
Moment of Purchase (Conversion)	Programmatic	StackAdapt	Video	["9:16","16:9"]	["5","10","15","20","30"]
Initial Consideration (Awareness)	Programmatic	StackAdapt	Video	["9:16","16:9"]	["5","10","15","20","30"]
Active Evaluation (Consideration)	Programmatic	StackAdapt	Video	["9:16","16:9"]	["5","10","15","20","30"]
Initial Consideration (Awareness)	Programmatic	Readpeak	Video	["9:16","16:9"]	["5","10","15","20","30"]
Active Evaluation (Consideration)	Programmatic	Readpeak	Video	["9:16","16:9"]	["5","10","15","20","30"]
Moment of Purchase (Conversion)	Programmatic	Readpeak	Video	["9:16","16:9"]	["5","10","15","20","30"]
Initial Consideration (Awareness)	Programmatic	LoopMe	Video	["9:16","16:9"]	["5","10","15","20","30"]
Moment of Purchase (Conversion)	Programmatic	LoopMe	Programmatic Display Partner Specific		
Moment of Purchase (Conversion)	Programmatic	LoopMe	Video	["9:16","16:9"]	["5","10","15","20","30"]
Active Evaluation (Consideration)	Programmatic	LoopMe	Video	["9:16","16:9"]	["5","10","15","20","30"]
Initial Consideration (Awareness)	Programmatic	LoopMe	Programmatic Display Partner Specific		
Active Evaluation (Consideration)	Programmatic	LoopMe	Programmatic Display Partner Specific		
Initial Consideration (Awareness)	Programmatic	Sabio	Video	["9:16","16:9"]	["5","10","15","20","30"]
Moment of Purchase (Conversion)	Programmatic	Sabio	Programmatic Display Partner Specific		
Moment of Purchase (Conversion)	Programmatic	Sabio	Video	["9:16","16:9"]	["5","10","15","20","30"]
Active Evaluation (Consideration)	Programmatic	Sabio	Video	["9:16","16:9"]	["5","10","15","20","30"]
Initial Consideration (Awareness)	Programmatic	Sabio	Programmatic Display Partner Specific		
Active Evaluation (Consideration)	Programmatic	Sabio	Programmatic Display Partner Specific`;

function parseList(str) {
    if (!str || str.trim() === '') return [];
    try {
        const parsed = JSON.parse(str);
        return Array.isArray(parsed) ? parsed : [parsed];
    } catch (e) {
        return str.split(',').map(s => s.trim()).filter(s => s !== '');
    }
}

function mapFunnel(name) {
    if (name.includes('Awareness')) return 'Awareness';
    if (name.includes('Consideration')) return 'Consideration';
    if (name.includes('Conversion')) return 'Conversion';
    return name;
}

const lines = data.split('\n').filter(l => l.trim() !== '');
const headers = lines[0].split('\t');
const rows = lines.slice(1).map(line => {
    const parts = line.split('\t');
    return {
        funnel: mapFunnel(parts[0]),
        channel: parts[1],
        platform: parts[2],
        format: parts[3],
        ratios: parseList(parts[4]),
        lengths: parseList(parts[5])
    };
});

let sql = `
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
`;

const sourceFile = 'AdFormats_Export.xlsx';

rows.forEach(row => {
    sql += `
    -- ${row.channel} / ${row.platform} / ${row.format}
    INSERT INTO public.platforms (name) VALUES ('${row.channel.replace(/'/g, "''")}') ON CONFLICT (name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO plat_id;
    INSERT INTO public.inventories (platform_id, name) VALUES (plat_id, '${row.platform.replace(/'/g, "''")}') ON CONFLICT (platform_id, name) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO inv_id;
    
    INSERT INTO public.ad_formats (platform_id, inventory_id, name, funnel_stage, is_manual_upload, upload_source_file) 
    VALUES (plat_id, inv_id, '${row.format.replace(/'/g, "''")}', '${row.funnel}', true, '${sourceFile}')
    RETURNING id INTO format_id;
    `;

    const ratios = row.ratios.length > 0 ? row.ratios : [null];
    const lengths = row.lengths.length > 0 ? row.lengths : [null];

    ratios.forEach(ratio => {
        lengths.forEach(length => {
            const rVal = ratio ? `'${ratio.replace(/'/g, "''")}'` : 'NULL';
            const lVal = length ? `'${length.replace(/'/g, "''")}'` : 'NULL';
            sql += `    INSERT INTO public.ad_format_variants (ad_format_id, aspect_ratio, duration, is_manual_upload, upload_source_file) VALUES (format_id, ${rVal}, ${lVal}, true, '${sourceFile}');\n`;
        });
    });
});

sql += `
END $$;
`;

fs.writeFileSync('c:/Users/Ben/.gemini/antigravity/scratch/Media Tool/seed_excel_data.sql', sql);
console.log('SQL generated successfully.');
