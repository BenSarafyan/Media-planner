import React, { useState } from 'react';
import { Campaign, campaignService } from '../services/campaignService';
import { AssetIdentificationWorkflow } from './AssetIdentificationWorkflow';
import { CreativeMastersView } from './CreativeMastersView';
import { RecommendedAsset, MasterAsset } from '../services/assetService';
import { getFlagUrl } from '../utils/marketUtils';
import './ProjectView.css';

interface ProjectViewProps {
  campaign: Campaign;
  onBack: () => void;
  onUpdate?: (campaign: Campaign) => void;
  activeSubTab?: ProjectTab;
  onSubTabChange?: (tab: ProjectTab) => void;
}

type ProjectTab = 'overview' | 'strategy' | 'requirements' | 'creative-masters' | 'team';

export const ProjectView: React.FC<ProjectViewProps> = ({ campaign, onUpdate, activeSubTab, onSubTabChange }) => {
  const [internalTab, setInternalTab] = useState<ProjectTab>('overview');
  const activeTab = activeSubTab || internalTab;
  const setActiveTab = onSubTabChange || setInternalTab;

  const [currentAssets, setCurrentAssets] = useState<RecommendedAsset[]>(campaign.assets || []);
  const [currentConfig, setCurrentConfig] = useState<any[]>(campaign.asset_config || []);
  const [currentMasters, setCurrentMasters] = useState<MasterAsset[]>(campaign.master_assets || []);

  const handleSaveAssets = async (assets: RecommendedAsset[], config: any[]) => {
    const success = await campaignService.updateCampaignAssets(campaign.id, assets, config);
    if (success) {
      setCurrentAssets(assets);
      setCurrentConfig(config);
      if (onUpdate) {
        onUpdate({
          ...campaign,
          assets,
          asset_config: config
        });
      }
    }
  };

  const handleSaveMasters = async (masters: MasterAsset[]) => {
    const success = await campaignService.updateCampaignMasterAssets(campaign.id, masters);
    if (success) {
      setCurrentMasters(masters);
      if (onUpdate) {
        onUpdate({
          ...campaign,
          master_assets: masters
        });
      }
    }
  };

  // Removed overlay logic to embed in tab instead

  return (
    <div className="project-view-container">
      <div className="project-nav-tabs">
        <button 
          className={`nav-tab ${activeTab === 'overview' ? 'active' : ''}`}
          onClick={() => setActiveTab('overview')}
        >
          Overview
        </button>
        <button 
          className={`nav-tab ${activeTab === 'strategy' ? 'active' : ''}`}
          onClick={() => setActiveTab('strategy')}
        >
          Channel mix
        </button>
        <button 
          className={`nav-tab ${activeTab === 'requirements' ? 'active' : ''}`}
          onClick={() => setActiveTab('requirements')}
        >
          Recommended Assets
        </button>
        <button 
          className={`nav-tab ${activeTab === 'creative-masters' ? 'active' : ''}`}
          onClick={() => setActiveTab('creative-masters')}
        >
          Creative Masters
        </button>
        <button 
          className={`nav-tab ${activeTab === 'team' ? 'active' : ''}`}
          onClick={() => setActiveTab('team')}
        >
          Team
        </button>
      </div>

      <div className="project-content-area">
        {activeTab === 'overview' && (
          <div className="vertical-stack">
            <div className="premium-card info-section">
              <div className="card-header">
                <h3>Campaign Details</h3>
              </div>
              <div className="info-grid">
                <div className="info-item">
                  <span className="label">Client</span>
                  <span className="value">{campaign.client_name}</span>
                </div>
                <div className="info-item">
                  <span className="label">Live Date</span>
                  <span className="value">
                    {new Date(campaign.live_date).toLocaleDateString('en-GB', { 
                      day: 'numeric', month: 'long', year: 'numeric' 
                    })}
                  </span>
                </div>
                <div className="info-item">
                  <span className="label">Status</span>
                  <span className={`status-pill ${campaign.status}`}>{campaign.status}</span>
                </div>
              </div>
            </div>

            <div className="premium-card market-selection-section">
              <div className="card-header">
                <h3>Campaign Markets</h3>
                <p>Showing active regions with budget status for this campaign</p>
              </div>
              <div className="market-tile-grid modern-grid">
                {campaign.markets.map((market) => {
                  return (
                    <div 
                      key={market.code} 
                      className="market-tile modern-tile"
                    >
                      <div className="flag-icon-small">
                        <img 
                          src={getFlagUrl(market.code, 40)} 
                          alt={market.name} 
                        />
                      </div>
                      <div className="market-details-compact">
                        <span className="market-name-label">{market.name}</span>
                        <div className={`budget-status-tag ${market.isOver40k ? 'over' : 'under'}`}>
                          <span className="dot"></span>
                          {market.isOver40k ? 'Budget > €40k' : 'Budget < €40k'}
                        </div>
                      </div>
                    </div>
                  );
                })}
                {campaign.markets.length === 0 && (
                  <div className="empty-markets">
                    <p>No markets selected for this campaign.</p>
                  </div>
                )}
              </div>
            </div>

            <div className="premium-card summary-section">
              <div className="card-header">
                <h3>Executive Summary</h3>
              </div>
              <div className="summary-content">
                <p>This campaign is currently in the <strong>{campaign.status}</strong> phase with a total budget of <strong>€{campaign.total_budget.toLocaleString()}</strong>.</p>
                <div className="quick-stats">
                  <div className="q-stat">
                    <span className="num">{campaign.markets.length}</span>
                    <span className="desc">Active Markets</span>
                  </div>
                  <div className="q-stat">
                    <span className="num">{currentAssets.length > 0 ? currentAssets.length : '--'}</span>
                    <span className="desc">Asset Reqs</span>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          )}


        {(activeTab === 'strategy' || activeTab === 'requirements') && (
          <div className="assets-tab-content">
            <AssetIdentificationWorkflow 
              campaignData={{
                ...campaign,
                assets: currentAssets,
                asset_config: currentConfig,
                master_assets: currentMasters
              }} 
              onBack={() => setActiveTab('overview')}
              onSave={handleSaveAssets}
              onSaveMasters={handleSaveMasters}
              isEmbedded={true}
              initialConfig={currentConfig}
              viewMode={activeTab === 'strategy' ? 'strategy' : 'requirements'}
              onSubTabChange={setActiveTab}
            />
          </div>
        )}

        {activeTab === 'creative-masters' && (
          <div className="assets-tab-content" style={{ padding: '0px' }}>
            <CreativeMastersView 
              masters={currentMasters}
              projectName={campaign.name}
            />
          </div>
        )}

        {activeTab === 'team' && (
          <div className="empty-state-card">
            <span className="material-icons-outlined">group</span>
            <h3>Project Team</h3>
            <p>Assign team members to manage different roles in this project.</p>
          </div>
        )}
      </div>
    </div>
  );
};
