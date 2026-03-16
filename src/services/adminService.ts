import { supabase } from './supabase';

export interface Platform {
  id: string;
  name: string;
}

export interface Inventory {
  id: string;
  platform_id: string;
  name: string;
}

export interface AdFormat {
  id: string;
  platform_id: string;
  inventory_id: string;
  name: string;
  funnel_stage: string;
  requires_video: boolean;
  format_type: string;
  aspect_ratio: string;
  dimensions: string;
  file_extension: string;
  file_size: string;
  duration: string;
  specs: string;
  // Included fields for convenience
  platform?: { name: string };
  inventory?: { name: string };
  variants?: AdFormatVariant[];
}

export interface AdFormatVariant {
  id: string;
  ad_format_id: string;
  aspect_ratio: string;
  duration: string;
}


export const adminService = {
  getPlatforms: async (): Promise<Platform[]> => {
    const { data, error } = await supabase
      .from('platforms')
      .select('*')
      .order('name');

    if (error) {
      console.error('Error fetching platforms:', error);
      return [];
    }

    return data as Platform[];
  },

  getPlatformsByStage: async (stage: string): Promise<Platform[]> => {
    try {
      // Fetch all platforms that have ad formats for this specific stage
      const { data, error } = await supabase
        .from('platforms')
        .select(`
          id,
          name,
          ad_formats!inner(funnel_stage)
        `)
        .eq('ad_formats.funnel_stage', stage);

      if (error) {
        console.error(`Error fetching platforms for stage ${stage}:`, error);
        return [];
      }

      if (!data) return [];

      // Sort unique platforms by name
      return (data as any[]).map(p => ({
        id: p.id,
        name: p.name
      })).sort((a, b) => a.name.localeCompare(b.name));
    } catch (err) {
      console.error('Unexpected error in getPlatformsByStage:', err);
      return [];
    }
  },

  getInventories: async (platformId?: string): Promise<Inventory[]> => {
    let query = supabase
      .from('inventories')
      .select('*')
      .order('name');

    if (platformId) {
      query = query.eq('platform_id', platformId);
    }

    const { data, error } = await query;

    if (error) {
      console.error('Error fetching inventories:', error);
      return [];
    }

    return data as Inventory[];
  },

  getAdFormats: async (filters: { platformId?: string; inventoryId?: string }): Promise<AdFormat[]> => {
    let query = supabase
      .from('ad_formats')
      .select(`
        *,
        platform:platforms(name),
        inventory:inventories(name),
        variants:ad_format_variants(aspect_ratio, duration)
      `)
      .order('name');

    if (filters.platformId) {
      query = query.eq('platform_id', filters.platformId);
    }

    if (filters.inventoryId) {
      query = query.eq('inventory_id', filters.inventoryId);
    }

    const { data, error } = await query;

    if (error) {
      console.error('Error fetching ad formats:', error);
      return [];
    }

    return (data || []) as AdFormat[];
  },

  createAdFormat: async (format: Omit<AdFormat, 'id' | 'platform' | 'inventory'>): Promise<AdFormat | null> => {
    const { data, error } = await supabase
      .from('ad_formats')
      .insert([format])
      .select(`
        *,
        platform:platforms(name),
        inventory:inventories(name)
      `)
      .single();

    if (error) {
      console.error('Error creating ad format:', error);
      return null;
    }

    return data as AdFormat;
  },

  updateAdFormat: async (id: string, format: Partial<Omit<AdFormat, 'id' | 'platform' | 'inventory'>>): Promise<AdFormat | null> => {
    const { data, error } = await supabase
      .from('ad_formats')
      .update(format)
      .eq('id', id)
      .select(`
        *,
        platform:platforms(name),
        inventory:inventories(name)
      `)
      .single();

    if (error) {
      console.error('Error updating ad format:', error);
      return null;
    }

    return data as AdFormat;
  },

  deleteAdFormat: async (id: string): Promise<boolean> => {
    const { error } = await supabase
      .from('ad_formats')
      .delete()
      .eq('id', id);

    if (error) {
      console.error('Error deleting ad format:', error);
      return false;
    }

    return true;
  },

  getAdFormatVariants: async (adFormatId: string): Promise<AdFormatVariant[]> => {
    const { data, error } = await supabase
      .from('ad_format_variants')
      .select('*')
      .eq('ad_format_id', adFormatId);

    if (error) {
      console.error('Error fetching variants:', error);
      return [];
    }

    return data as AdFormatVariant[];
  }
};
