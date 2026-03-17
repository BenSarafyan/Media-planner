import { Campaign } from '../../../services/campaignService';
import { MainTab, WorkflowStep } from '../../../types/navigation';

interface TopBarProps {
  selectedCampaign: Campaign | null;
  activeTab: MainTab;
  workflowStep: WorkflowStep;
  handleViewAllCampaigns: () => void;
}

export const TopBar = ({ 
  selectedCampaign, 
  activeTab, 
  workflowStep, 
  handleViewAllCampaigns 
}: TopBarProps) => {
  return (
    <header className="top-bar">
      <div className="top-bar-breadcrumbs">
        <span>MediaPlanner</span>
        <span className="material-icons-outlined separator">chevron_right</span>
        <span className="breadcrumb-clickable" onClick={handleViewAllCampaigns}>All Projects</span>
        {selectedCampaign && (
          <>
            <span className="material-icons-outlined separator">chevron_right</span>
            <span className="breadcrumb-client-tag">{selectedCampaign.client_name}</span>
            <span className="material-icons-outlined separator">chevron_right</span>
            <span className="breadcrumb-current-project">{selectedCampaign.name}</span>
            <div className="breadcrumb-project-meta">
              <span className="budget-tag">€{selectedCampaign.total_budget.toLocaleString()}</span>
              <span className={`status-dot ${selectedCampaign.status}`}></span>
            </div>
          </>
        )}
        {activeTab === 'new-campaign' && (
          <>
            <span className="material-icons-outlined separator">chevron_right</span>
            <span>{workflowStep === 'setup' ? 'Campaign Setup' : 'Asset Identification'}</span>
          </>
        )}
      </div>
      <div className="user-profile-widget">
        <div className="avatar">BL</div>
        <span>Barbara Lopez</span>
        <span className="material-icons-outlined">expand_more</span>
      </div>
    </header>
  );
};
