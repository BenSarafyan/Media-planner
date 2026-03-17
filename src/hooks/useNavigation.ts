import { useState } from 'react';
import { Campaign } from '../services/campaignService';
import { MainTab, WorkflowStep, ProjectSubTab } from '../types/navigation';

export function useNavigation() {
  const [activeTab, setActiveTab] = useState<MainTab>('all-campaigns');
  const [workflowStep, setWorkflowStep] = useState<WorkflowStep>('setup');
  const [campaignData, setCampaignData] = useState<Campaign | null>(null);
  const [selectedCampaign, setSelectedCampaign] = useState<Campaign | null>(null);
  const [projectSubTab, setProjectSubTab] = useState<ProjectSubTab>('overview');

  const [isSidebarCollapsed, setIsSidebarCollapsed] = useState(false);
  const [isSidebarHovered, setIsSidebarHovered] = useState(false);

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
    setProjectSubTab('overview');
    setActiveTab('project-view');
  };

  const isCollapsed = isSidebarCollapsed && !isSidebarHovered;

  return {
    activeTab,
    setActiveTab,
    workflowStep,
    setWorkflowStep,
    campaignData,
    setCampaignData,
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
  };
}
