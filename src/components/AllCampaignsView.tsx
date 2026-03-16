import React, { useEffect, useState } from 'react';
import { campaignService, Campaign } from '../services/campaignService';
import { ProjectView } from './ProjectView';
import './AllCampaignsView.css';

interface AllCampaignsViewProps {
  onSelectCampaign: (campaign: Campaign) => void;
}

export const AllCampaignsView: React.FC<AllCampaignsViewProps> = ({ onSelectCampaign }) => {
  const [campaigns, setCampaigns] = useState<Campaign[]>([]);
  const [loading, setLoading] = useState(true);
  const [searchTerm, setSearchTerm] = useState('');
  const [selectedCampaign, setSelectedCampaign] = useState<Campaign | null>(null);

  useEffect(() => {
    const fetchCampaigns = async () => {
      const data = await campaignService.getCampaigns();
      setCampaigns(data);
      setLoading(false);
    };
    fetchCampaigns();
  }, []);

  const filteredCampaigns = campaigns.filter(c => 
    c.name.toLowerCase().includes(searchTerm.toLowerCase()) || 
    c.client_name.toLowerCase().includes(searchTerm.toLowerCase())
  );

  const groupedByClient = filteredCampaigns.reduce((acc, campaign) => {
    if (!acc[campaign.client_name]) {
      acc[campaign.client_name] = [];
    }
    acc[campaign.client_name].push(campaign);
    return acc;
  }, {} as Record<string, Campaign[]>);

  if (loading) {
    return <div className="loading-state">Loading projects...</div>;
  }

  if (selectedCampaign) {
    return (
      <ProjectView 
        campaign={selectedCampaign} 
        onBack={() => {
          setSelectedCampaign(null);
          // Refresh list to show deletions
          campaignService.getCampaigns().then(setCampaigns);
        }} 
      />
    );
  }

  const handleCampaignClick = (campaign: Campaign) => {
    setSelectedCampaign(campaign);
    onSelectCampaign(campaign);
  };

  const handleDeleteRow = async (e: React.MouseEvent, campaign: Campaign) => {
    e.stopPropagation();
    if (window.confirm(`Are you sure you want to delete the campaign "${campaign.name}"?`)) {
      const success = await campaignService.deleteCampaign(campaign.id);
      if (success) {
        // Refresh list
        const data = await campaignService.getCampaigns();
        setCampaigns(data);
      } else {
        alert('Failed to delete campaign.');
      }
    }
  };

  return (
    <div className="all-campaigns-container">
      <div className="search-bar-container">
        <span className="material-icons-outlined search-icon">search</span>
        <input 
          type="text" 
          placeholder="Search by project or client name..." 
          value={searchTerm}
          onChange={(e) => setSearchTerm(e.target.value)}
        />
      </div>

      <div className="campaigns-list">
        {Object.entries(groupedByClient).map(([client, clientCampaigns]) => (
          <div key={client} className="client-group">
            <div className="client-header">
              <div className="client-logo-placeholder">
                {client === 'Stanley Black & Decker' && (
                  <div className="sbd-logo">
                    <span className="sbd-yellow">Stanley</span>
                    <span className="sbd-black">Black & Decker</span>
                  </div>
                )}
              </div>
              <h2 className="client-name">{client}</h2>
              <span className="project-count">{clientCampaigns.length} Projects</span>
            </div>

            <div className="campaign-rows">
              {clientCampaigns.map((campaign) => (
                <div 
                  key={campaign.id} 
                  className="campaign-row"
                  onClick={() => handleCampaignClick(campaign)}
                  style={{ cursor: 'pointer' }}
                >
                  <div className="campaign-icon">
                    <span className="material-icons-outlined">work_outline</span>
                  </div>
                  <div className="campaign-main-info">
                    <h3 className="campaign-name">{campaign.name}</h3>
                  </div>
                  <div 
                    className="campaign-actions"
                  >
                    <button 
                      className="row-delete-btn"
                      onClick={(e) => handleDeleteRow(e, campaign)}
                      title="Delete Campaign"
                    >
                      <span className="material-icons-outlined">delete</span>
                    </button>
                    <button className="action-btn chevron">
                      <span className="material-icons-outlined">chevron_right</span>
                    </button>
                  </div>
                </div>
              ))}
            </div>
          </div>
        ))}
      </div>
    </div>
  );
};
