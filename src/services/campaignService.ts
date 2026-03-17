import { supabase } from './supabase';

export interface Market {
  code: string;
  name: string;
  isOver40k: boolean;
}

export interface Campaign {
  id: string;
  name: string;
  client_name: string;
  live_date: string;
  total_budget: number;
  markets: Market[];
  status: 'setup' | 'active' | 'completed';
  assets?: any[]; // Store generated assets
  asset_config?: any[]; // Store survey configuration
  master_assets?: any[]; // Store grouped master assets
}

export const campaignService = {
  getCampaigns: async (): Promise<Campaign[]> => {
    const { data, error } = await supabase
      .from('campaigns')
      .select('*')
      .order('created_at', { ascending: false });

    if (error) {
      console.error('Error fetching campaigns:', error);
      return [];
    }

    return (data || []) as Campaign[];
  },

  createCampaign: async (campaign: Omit<Campaign, 'id' | 'status'>): Promise<Campaign | null> => {
    const { data, error } = await supabase
      .from('campaigns')
      .insert([
        {
          ...campaign,
          status: 'setup'
        }
      ])
      .select()
      .single();

    if (error) {
      console.error('Error creating campaign:', error);
      return null;
    }

    return data as Campaign;
  },

  deleteCampaign: async (id: string): Promise<boolean> => {
    const { error } = await supabase
      .from('campaigns')
      .delete()
      .eq('id', id);

    if (error) {
      console.error('Error deleting campaign:', error);
      return false;
    }

    return true;
  },

  updateCampaignAssets: async (id: string, assets: any[], asset_config: any[]): Promise<boolean> => {
    const { error } = await supabase
      .from('campaigns')
      .update({ 
        assets, 
        asset_config,
        updated_at: new Date().toISOString() 
      })
      .eq('id', id);

    if (error) {
      console.error('Error updating campaign assets:', error);
      return false;
    }

    return true;
  },

  updateCampaignMasterAssets: async (id: string, master_assets: any[]): Promise<boolean> => {
    const { error } = await supabase
      .from('campaigns')
      .update({ 
        master_assets,
        updated_at: new Date().toISOString() 
      })
      .eq('id', id);

    if (error) {
      console.error('Error updating campaign master assets:', error);
      return false;
    }

    return true;
  }
};
