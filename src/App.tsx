import { useState } from 'react'
import './App.css'
import { AssetIdentificationWorkflow } from './components/AssetIdentificationWorkflow'
import { CampaignSetup } from './components/CampaignSetup'
import { AllCampaignsView } from './components/AllCampaignsView'
import { AdFormatsAdmin } from './components/AdFormatsAdmin'
import { ProjectView } from './components/ProjectView'
import { type Campaign } from './services/campaignService'

// Interface moved to service

function App() {
  const [activeTab, setActiveTab] = useState<'overview' | 'new-campaign' | 'all-campaigns' | 'project-view' | 'ad-formats'>('all-campaigns')
  const [workflowStep, setWorkflowStep] = useState<'setup' | 'questions'>('setup')
  const [campaignData, setCampaignData] = useState<Campaign | null>(null)
  const [selectedCampaign, setSelectedCampaign] = useState<Campaign | null>(null)

  const [isSidebarCollapsed, setIsSidebarCollapsed] = useState(false)
  const [isSidebarHovered, setIsSidebarHovered] = useState(false)

  const handleStartSetup = () => {
    setActiveTab('new-campaign');
    setWorkflowStep('setup');
  };

  const handleCampaignReady = (campaign: Campaign) => {
    setCampaignData(campaign);
    setWorkflowStep('questions');
  };

  const handleBackToOverview = () => {
    setActiveTab('overview');
    setWorkflowStep('setup');
    setCampaignData(null);
    setSelectedCampaign(null);
  };

  const handleViewAllCampaigns = () => {
    setActiveTab('all-campaigns');
    setWorkflowStep('setup');
    setCampaignData(null);
    setSelectedCampaign(null);
  };

  const handleSelectCampaign = (campaign: Campaign) => {
    setSelectedCampaign(campaign);
    setActiveTab('project-view');
  };

  const isCollapsed = isSidebarCollapsed && !isSidebarHovered;

  return (
    <div className={`app-container ${isSidebarCollapsed ? 'sidebar-collapsed' : ''}`}>
      <aside 
        className={`sidebar ${isCollapsed ? 'collapsed' : ''}`}
        onMouseEnter={() => setIsSidebarHovered(true)}
        onMouseLeave={() => setIsSidebarHovered(false)}
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
            <button 
              className={`sidebar-nav-item active-project-nav ${activeTab === 'project-view' ? 'active' : ''}`}
              onClick={() => setActiveTab('project-view')}
              title={selectedCampaign.name}
            >
              <span className="material-icons-outlined">folder_special</span>
              {!isCollapsed && <span className="nav-text-truncate">{selectedCampaign.name}</span>}
            </button>
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


      <div className="app-main-content">
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

        <main className="app-scroll-area">
          {activeTab === 'overview' && (
            <div className="dashboard-view">
              <div className="welcome-banner">
                <h2>Welcome back, Barbara</h2>
                <p>Ready to plan your next digital campaign?</p>
                <button 
                  className="btn-primary"
                  onClick={handleStartSetup}
                >
                  <span className="material-icons-outlined">psychology</span>
                  Start New Campaign
                </button>
              </div>
            </div>
          )}
          
          {activeTab === 'new-campaign' && (
            <>
              {workflowStep === 'setup' ? (
                <CampaignSetup onCampaignCreated={handleCampaignReady} />
              ) : (
                <AssetIdentificationWorkflow 
                  onBack={() => setWorkflowStep('setup')} 
                  campaignData={campaignData}
                />
              )}
            </>
          )}

          {activeTab === 'all-campaigns' && (
            <AllCampaignsView onSelectCampaign={handleSelectCampaign} />
          )}

          {activeTab === 'project-view' && selectedCampaign && (
            <ProjectView 
              campaign={selectedCampaign} 
              onBack={handleViewAllCampaigns} 
              onUpdate={(updated) => setSelectedCampaign(updated)}
            />
          )}

          {activeTab === 'ad-formats' && (
            <AdFormatsAdmin />
          )}
        </main>
      </div>
    </div>
  )
}

export default App
