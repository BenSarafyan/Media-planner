import { Campaign } from '../services/campaignService';

export type MainTab = 'overview' | 'new-campaign' | 'all-campaigns' | 'project-view' | 'ad-formats';
export type WorkflowStep = 'setup' | 'questions';
export type ProjectSubTab = 'overview' | 'strategy' | 'requirements' | 'creative-masters' | 'team';

export interface NavigationState {
  activeTab: MainTab;
  workflowStep: WorkflowStep;
  campaignData: Campaign | null;
  selectedCampaign: Campaign | null;
  projectSubTab: ProjectSubTab;
  isSidebarCollapsed: boolean;
  isSidebarHovered: boolean;
}
