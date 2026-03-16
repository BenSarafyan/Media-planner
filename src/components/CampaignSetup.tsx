import React, { useState } from 'react';
import { MarketSelectionModal } from './MarketSelectionModal';
import { campaignService, type Market, type Campaign } from '../services/campaignService';
import { getFlagUrl } from '../utils/marketUtils';
import './CampaignSetup.css';

// Interface definitions moved to campaignService or handled locally as needed

interface CampaignSetupProps {
  onCampaignCreated: (campaign: Campaign) => void;
}

export const CampaignSetup: React.FC<CampaignSetupProps> = ({ onCampaignCreated }) => {
  const [name, setName] = useState('');
  const [totalBudget, setTotalBudget] = useState('');
  const [selectedMarkets, setSelectedMarkets] = useState<Market[]>([]);
  const [isModalOpen, setIsModalOpen] = useState(false);
  const [isCreating, setIsCreating] = useState(false);
  const toggleMarket = (market: any) => {
    setSelectedMarkets((prev) =>
      prev.some((m) => m.code === market.code)
        ? prev.filter((m) => m.code !== market.code)
        : [...prev, { ...market, isOver40k: false }]
    );
  };

  const toggleMarketValue = (code: string) => {
    setSelectedMarkets((prev) =>
      prev.map((m) =>
        m.code === code ? { ...m, isOver40k: !m.isOver40k } : m
      )
    );
  };

  const handleCreateCampaign = async () => {
    if (!name || !totalBudget || selectedMarkets.length === 0) {
      alert('Please fill in all campaign details.');
      return;
    }

    setIsCreating(true);
    try {
      const newCampaign = await campaignService.createCampaign({
        name,
        client_name: 'Stanley Black & Decker', // Default for now
        live_date: new Date(Date.now() + 30 * 24 * 60 * 60 * 1000).toISOString().split('T')[0],
        total_budget: parseFloat(totalBudget),
        markets: selectedMarkets
      });

      if (newCampaign) {
        onCampaignCreated(newCampaign);
      } else {
        alert('Failed to create campaign. Please try again.');
      }
    } catch (error) {
      console.error('Error creating campaign:', error);
      alert('An error occurred while creating the campaign.');
    } finally {
      setIsCreating(false);
    }
  };

  return (
    <div className="campaign-setup-container">

      <div className="setup-grid">
        {/* Basic Info Card */}
        <div className="premium-card setup-card">
          <div className="card-header">
            <h3>Campaign Identity</h3>
          </div>
          <div className="card-body">
            <div className="input-group">
              <label>Campaign Name</label>
              <input
                type="text"
                placeholder="e.g. Summer Launch 2024"
                value={name}
                onChange={(e) => setName(e.target.value)}
              />
            </div>
            <div className="input-group">
              <label>Total Budget (€)</label>
              <input
                type="number"
                placeholder="Total available budget"
                value={totalBudget}
                onChange={(e) => setTotalBudget(e.target.value)}
              />
            </div>
          </div>
        </div>

        {/* Markets Card */}
        <div className="premium-card setup-card">
          <div className="card-header">
            <h3>Markets & Value</h3>
            <button className="btn-secondary" onClick={() => setIsModalOpen(true)}>
              + Add Market
            </button>
          </div>
          <div className="card-body">
            <div className="markets-config-list">
              {selectedMarkets.length === 0 ? (
                <div className="empty-state">No markets selected</div>
              ) : (
                selectedMarkets.map((market) => (
                  <div key={market.code} className="market-config-row">
                    <div className="market-info">
                      <img src={getFlagUrl(market.code, 40)} alt={market.name} />
                      <span className="market-name">{market.name}</span>
                    </div>
                    
                    <div className="market-value-toggle">
                      <span className={!market.isOver40k ? 'active' : ''}>Under €40k</span>
                      <label className="switch">
                        <input
                          type="checkbox"
                          checked={market.isOver40k}
                          onChange={() => toggleMarketValue(market.code)}
                        />
                        <span className="slider round"></span>
                      </label>
                      <span className={market.isOver40k ? 'active' : ''}>Over €40k</span>
                    </div>

                    <button className="remove-market-btn" onClick={() => toggleMarket(market)}>
                      <span className="material-icons-outlined">close</span>
                    </button>
                  </div>
                ))
              )}
            </div>
          </div>
        </div>
      </div>

      <div className="setup-actions">
        <button 
          className="btn btn-primary btn-large" 
          onClick={handleCreateCampaign}
          disabled={isCreating}
        >
          {isCreating ? (
            <>
              <div className="spinner-border spinner-border-sm me-2" role="status"></div>
              Creating Campaign...
            </>
          ) : 'Create Campaign'}
        </button>
      </div>

      <MarketSelectionModal
        isOpen={isModalOpen}
        onClose={() => setIsModalOpen(false)}
        selectedMarkets={selectedMarkets}
        onToggleMarket={toggleMarket}
      />
    </div>
  );
};
