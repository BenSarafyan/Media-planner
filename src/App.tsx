import './App.css'
import { AssetIdentificationWorkflow } from './components/AssetIdentificationWorkflow'
import { CampaignSetup } from './components/CampaignSetup'
import { campaignService } from './services/campaignService'
import { AllCampaignsView } from './components/AllCampaignsView'
import { AdFormatsAdmin } from './components/AdFormatsAdmin'
import { ProjectView } from './components/ProjectView'
import { TopBar } from './components/layout/TopBar/TopBar'
import { Sidebar } from './components/layout/Sidebar/Sidebar'
import { WelcomeBanner } from './components/dashboard/WelcomeBanner'
import { useNavigation } from './hooks/useNavigation'

function App() {
  const {
    activeTab,
    setActiveTab,
    workflowStep,
    setWorkflowStep,
    campaignData,
    selectedCampaign,
    setSelectedCampaign,
    projectSubTab,
    setProjectSubTab,
    isSidebarCollapsed,
    setIsSidebarCollapsed,
    isSidebarHovered,
    setIsSidebarHovered,
    isCollapsed,
    handleStartSetup,
    handleCampaignReady,
    handleBackToOverview,
    handleViewAllCampaigns,
    handleSelectCampaign,
  } = useNavigation();

  return (
    <div className={`app-container ${isSidebarCollapsed ? 'sidebar-collapsed' : ''}`}>
      <Sidebar 
        activeTab={activeTab}
        isSidebarCollapsed={isSidebarCollapsed}
        setIsSidebarCollapsed={setIsSidebarCollapsed}
        isCollapsed={isCollapsed}
        selectedCampaign={selectedCampaign}
        projectSubTab={projectSubTab}
        setProjectSubTab={setProjectSubTab}
        setActiveTab={setActiveTab}
        handleBackToOverview={handleBackToOverview}
        handleStartSetup={handleStartSetup}
        handleViewAllCampaigns={handleViewAllCampaigns}
      />

      <div className="app-main-content">
        <TopBar 
          selectedCampaign={selectedCampaign}
          activeTab={activeTab}
          workflowStep={workflowStep}
          handleViewAllCampaigns={handleViewAllCampaigns}
        />

        <main className="app-scroll-area">
          {activeTab === 'overview' && (
            <WelcomeBanner onStartSetup={handleStartSetup} />
          )}
          
          {activeTab === 'new-campaign' && (
            <>
              {workflowStep === 'setup' ? (
                <CampaignSetup onCampaignCreated={handleCampaignReady} />
              ) : (
                <AssetIdentificationWorkflow 
                  onBack={() => setWorkflowStep('setup')} 
                  campaignData={campaignData}
                  onSave={async (assets, config) => {
                    if (campaignData) {
                      await campaignService.updateCampaignAssets(campaignData.id, assets, config);
                    }
                  }}
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
              activeSubTab={projectSubTab}
              onSubTabChange={setProjectSubTab}
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
