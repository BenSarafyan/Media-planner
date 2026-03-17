import { Campaign } from '../../../services/campaignService';
import { MainTab, ProjectSubTab } from '../../../types/navigation';

interface SidebarProps {
  activeTab: MainTab;
  isSidebarCollapsed: boolean;
  setIsSidebarCollapsed: (collapsed: boolean) => void;
  isCollapsed: boolean;
  selectedCampaign: Campaign | null;
  projectSubTab: ProjectSubTab;
  setProjectSubTab: (tab: ProjectSubTab) => void;
  setActiveTab: (tab: MainTab) => void;
  handleBackToOverview: () => void;
  handleStartSetup: () => void;
  handleViewAllCampaigns: () => void;
}

export const Sidebar = ({
  activeTab,
  isSidebarCollapsed,
  setIsSidebarCollapsed,
  isCollapsed,
  selectedCampaign,
  projectSubTab,
  setProjectSubTab,
  setActiveTab,
  handleBackToOverview,
  handleStartSetup,
  handleViewAllCampaigns,
}: SidebarProps) => {
  return (
    <aside 
      className={`sidebar ${isCollapsed ? 'collapsed' : ''}`}
    >
      <div className="sidebar-header-row">
        <div className="sidebar-logo">
          <span className="material-icons-outlined">layers</span>
          {!isCollapsed && <h1>Media Planner</h1>}
        </div>
        <button 
          className="sidebar-collapse-toggle"
          onClick={() => setIsSidebarCollapsed(!isSidebarCollapsed)}
        >
          <span className="material-icons-outlined">
            {isSidebarCollapsed ? 'menu_open' : 'menu'}
          </span>
        </button>
      </div>

      <div className="sidebar-section-label">{isCollapsed ? '•' : 'PROJECT'}</div>
      <nav className="sidebar-nav">
        <button 
          className={`sidebar-nav-item ${activeTab === 'overview' ? 'active' : ''}`}
          onClick={handleBackToOverview}
          title="Dashboard"
        >
          <span className="material-icons-outlined">dashboard</span>
          {!isCollapsed && <span>Dashboard</span>}
        </button>
        <button 
          className={`sidebar-nav-item ${activeTab === 'new-campaign' ? 'active' : ''}`}
          onClick={handleStartSetup}
          title="New Project"
        >
          <span className="material-icons-outlined">add_circle_outline</span>
          {!isCollapsed && <span>New Project</span>}
        </button>
        <button 
          className={`sidebar-nav-item ${activeTab === 'all-campaigns' ? 'active' : ''}`}
          onClick={handleViewAllCampaigns}
          title="All Projects"
        >
          <span className="material-icons-outlined">view_list</span>
          {!isCollapsed && <span>All Projects</span>}
        </button>
        {selectedCampaign && (
          <div className={`sidebar-project-group ${activeTab === 'project-view' ? 'active' : ''}`}>
            <button 
              className={`sidebar-nav-item active-project-nav ${activeTab === 'project-view' && projectSubTab === 'overview' ? 'active' : ''}`}
              onClick={() => {
                setActiveTab('project-view');
                setProjectSubTab('overview');
              }}
              title={selectedCampaign.name}
            >
              <span className="material-icons-outlined">folder_special</span>
              {!isCollapsed && <span className="nav-text-truncate">{selectedCampaign.name}</span>}
            </button>
            
            {!isCollapsed && (
              <div className="sidebar-sub-nav">
                <button 
                  className={`sidebar-sub-nav-item ${activeTab === 'project-view' && projectSubTab === 'strategy' ? 'active' : ''}`}
                  onClick={() => {
                    setActiveTab('project-view');
                    setProjectSubTab('strategy');
                  }}
                >
                  <span className="material-icons-outlined">insights</span>
                  <span>Channel mix</span>
                </button>
                <button 
                  className={`sidebar-sub-nav-item ${activeTab === 'project-view' && projectSubTab === 'requirements' ? 'active' : ''}`}
                  onClick={() => {
                    setActiveTab('project-view');
                    setProjectSubTab('requirements');
                  }}
                >
                  <span className="material-icons-outlined">assignment</span>
                  <span>Recommended Assets</span>
                </button>
                <button 
                  className={`sidebar-sub-nav-item ${activeTab === 'project-view' && projectSubTab === 'creative-masters' ? 'active' : ''}`}
                  onClick={() => {
                    setActiveTab('project-view');
                    setProjectSubTab('creative-masters');
                  }}
                >
                  <span className="material-icons-outlined">Groups</span>
                  <span>Creative Masters</span>
                </button>
                <button 
                  className={`sidebar-sub-nav-item ${activeTab === 'project-view' && projectSubTab === 'team' ? 'active' : ''}`}
                  onClick={() => {
                    setActiveTab('project-view');
                    setProjectSubTab('team');
                  }}
                >
                  <span className="material-icons-outlined">group</span>
                  <span>Team</span>
                </button>
              </div>
            )}
          </div>
        )}
      </nav>

      <div className="sidebar-section-label">{isCollapsed ? '•' : 'ADMIN'}</div>
      <nav className="sidebar-nav">
        <button 
          className={`sidebar-nav-item ${activeTab === 'ad-formats' ? 'active' : ''}`}
          onClick={() => setActiveTab('ad-formats')}
          title="Ad Formats"
        >
          <span className="material-icons-outlined">settings_suggest</span>
          {!isCollapsed && <span>Ad Formats</span>}
        </button>
      </nav>
      
      <div className="sidebar-footer">
        <button className="sidebar-nav-item" title="Settings">
          <span className="material-icons-outlined">settings</span>
          {!isCollapsed && <span>Settings</span>}
        </button>
      </div>
    </aside>
  );
};
