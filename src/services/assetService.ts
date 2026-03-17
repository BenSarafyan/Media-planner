import { supabase } from './supabase';

export type FunnelStage = 'Awareness' | 'Consideration' | 'Conversion';
export type CampaignGoal = 'Brand Awareness' | 'Product Awareness' | 'Sales conversion';
export type Partner = string; // Now dynamic from database

export interface AssetIdentificationQuery {
  funnelStages: FunnelStage[];
  goals: CampaignGoal[];
  partners: Partner[];
  heroVideoAvailable: boolean;
  selectedInventories?: string[]; // Added this to filter by specific inventories
}

export interface RecommendedAsset {
  id: string;
  channel: string;       // Platform Name (e.g., Meta, Google Ads)
  platform: string;      // Inventory Name (e.g., Instagram Feed)
  formatName: string;    // Ad Format Name (e.g., Stories Video)
  funnelStage: FunnelStage;
  aspectRatios: string;  // Aggregated "1:1, 9:16"
  lengths: string;       // Aggregated "15s, 30s"
  requiresVideo: boolean;
  selected: boolean;
  isEdited: boolean;
  availableRatios: string[];
  availableLengths: string[];
  selectedRatios: string[];
  selectedLengths: string[];
}

export interface MasterAsset {
  id: string;
  funnelStage: FunnelStage;
  type: 'Video' | 'Static';
  ratio: string;
  length: string;
  originalAssets: {
    channel: string;
    platform: string;
    formatName: string;
  }[];
}

export const assetService = {
  identifyAssets: async (query: AssetIdentificationQuery): Promise<RecommendedAsset[]> => {
    const { funnelStages, partners } = query;

    if (partners.length === 0 || funnelStages.length === 0) return [];

    // Query ad_formats with related platforms, inventories, and variants
    let dbQuery = supabase
      .from('ad_formats')
      .select(`
        id,
        name,
        funnel_stage,
        requires_video,
        platform:platforms!inner(name),
        inventory:inventories!inner(name),
        variants:ad_format_variants(aspect_ratio, duration)
      `)
      .in('platform.name', partners)
      .in('funnel_stage', funnelStages);

    if (query.selectedInventories && query.selectedInventories.length > 0) {
      dbQuery = dbQuery.in('inventory.name', query.selectedInventories);
    }

    // Filter out assets that require video if hero video is NOT available
    if (!query.heroVideoAvailable) {
      dbQuery = dbQuery.eq('requires_video', false);
    }
    
    const { data, error } = await dbQuery;

    if (error) {
      console.error('Error identifying assets:', error);
      return [];
    }

    if (!data) return [];

    // Transform and aggregate variants
    return data.map((format: any) => {
      const variants = format.variants || [];
      
      const uniqueRatios = Array.from(new Set(variants.map((v: any) => v.aspect_ratio).filter(Boolean))) as string[];
      const uniqueLengths = Array.from(new Set(variants.map((v: any) => v.duration).filter(Boolean))) as string[];

      return {
        id: format.id,
        channel: format.platform.name,
        platform: format.inventory.name,
        formatName: format.name,
        funnelStage: format.funnel_stage as FunnelStage,
        aspectRatios: uniqueRatios.length > 0 ? uniqueRatios.join(', ') : '-',
        lengths: uniqueLengths.length > 0 ? uniqueLengths.join(', ') : '-',
        requiresVideo: !!format.requires_video,
        selected: true,
        isEdited: false,
        availableRatios: uniqueRatios,
        availableLengths: uniqueLengths,
        selectedRatios: uniqueRatios,
        selectedLengths: uniqueLengths
      };
    });
  },

  groupMasterAssets: (assets: RecommendedAsset[]): MasterAsset[] => {
    const masters: Record<string, MasterAsset> = {};

    assets.filter(a => a.selected).forEach(asset => {
      const type = asset.requiresVideo ? 'Video' : 'Static';
      const ratios = asset.selectedRatios;
      const lengths = asset.selectedLengths;

      // For each combination of ratio and length in the asset
      ratios.forEach(ratio => {
        const lengthsToUse = type === 'Video' ? lengths : ['-'];
        
        lengthsToUse.forEach(length => {
          const key = `${asset.funnelStage}|${type}|${ratio}|${length}`;
          
          if (!masters[key]) {
            masters[key] = {
              id: crypto.randomUUID(),
              funnelStage: asset.funnelStage,
              type,
              ratio,
              length,
              originalAssets: []
            };
          }

          // Avoid duplicates in original assets
          const exists = masters[key].originalAssets.some(oa => 
            oa.channel === asset.channel && 
            oa.platform === asset.platform && 
            oa.formatName === asset.formatName
          );

          if (!exists) {
            masters[key].originalAssets.push({
              channel: asset.channel,
              platform: asset.platform,
              formatName: asset.formatName
            });
          }
        });
      });
    });

    return Object.values(masters);
  }
};

