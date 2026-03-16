import React, { useState } from 'react';
import { assetService, type AssetIdentificationQuery, type RecommendedAsset, type FunnelStage } from '../services/assetService';
import { adminService } from '../services/adminService';
import { type Campaign } from '../services/campaignService';
import './AssetIdentificationWorkflow.css';

interface AssetIdentificationWorkflowProps {
  onBack: () => void;
  campaignData: Campaign | null;
  onSave?: (assets: RecommendedAsset[], config: any[]) => void;
  isEmbedded?: boolean;
  initialConfig?: any[];
  viewMode?: 'strategy' | 'requirements';
}

interface FunnelConfig {
  stage: FunnelStage;
  videoIncluded: boolean;
  channels: string[];
  selectedInventories: string[]; // Added this to track nested platform selection
}

// Partner is now dynamic string
type Partner = string;

export const AssetIdentificationWorkflow: React.FC<AssetIdentificationWorkflowProps> = ({ 
  onBack, 
  campaignData, 
  onSave,
  isEmbedded = false,
  initialConfig = [],
  viewMode = 'strategy'
}) => {
  const STAGES: FunnelStage[] = ['Awareness', 'Consideration', 'Conversion'];
  
  // Initialize with all stages but maybe empty channels
  const [funnelConfigs, setFunnelConfigs] = useState<FunnelConfig[]>(() => {
    if (initialConfig.length > 0) {
      return initialConfig.map(c => ({
        ...c,
        channels: c.channels || [],
        selectedInventories: c.selectedInventories || []
      }));
    }
    return STAGES.map(stage => ({
      stage,
      videoIncluded: false,
      channels: [],
      selectedInventories: []
    }));
  });

  const [activeStages, setActiveStages] = useState<Set<FunnelStage>>(() => {
    if (initialConfig.length > 0) return new Set(initialConfig.map(c => c.stage));
    return new Set();
  });

  const [results, setResults] = useState<RecommendedAsset[]>(campaignData?.assets || []);
  const [loading, setLoading] = useState(false);
  const [resultsDisplayMode, setResultsDisplayMode] = useState<'grid' | 'table'>('table');
  const [allPlatformsByStage, setAllPlatformsByStage] = useState<Record<string, string[]>>({});
  const [allInventoriesByPlatform, setAllInventoriesByPlatform] = useState<Record<string, string[]>>({});
  const [editingAssetId, setEditingAssetId] = useState<string | null>(null);
  const [isSidebarOpen, setIsSidebarOpen] = useState(true);

  // Filter states for slicer
  const [selectedChannelFilter, setSelectedChannelFilter] = useState<string>('');
  const [selectedPlatformFilter, setSelectedPlatformFilter] = useState<string>('');
  const [selectedTypeFilter, setSelectedTypeFilter] = useState<'all' | 'static' | 'video'>('all');

  // Fetch all platforms and their inventories on mount
  React.useEffect(() => {
    const fetchData = async () => {
      const platformMap: Record<string, string[]> = {};
      const inventoryMap: Record<string, string[]> = {};
      
      await Promise.all(STAGES.map(async (stage) => {
        const platforms = await adminService.getPlatformsByStage(stage);
        platformMap[stage] = platforms.map(p => p.name);
        
        // For each platform, fetch its inventories
        await Promise.all(platforms.map(async (platform) => {
          if (!inventoryMap[platform.name]) {
            const inventories = await adminService.getInventories(platform.id);
            inventoryMap[platform.name] = inventories.map(i => i.name);
          }
        }));
      }));
      
      setAllPlatformsByStage(platformMap);
      setAllInventoriesByPlatform(inventoryMap);
    };
    fetchData();
  }, []);

  // Autosave when funnel configuration or results change
  React.useEffect(() => {
    if (onSave && (activeStages.size > 0 || results.length > 0)) {
      const timer = setTimeout(() => {
        const configsToSave = funnelConfigs.filter(c => activeStages.has(c.stage));
        onSave(results, configsToSave);
      }, 1000); // 1 second debounce
      return () => clearTimeout(timer);
    }
  }, [funnelConfigs, activeStages, results, onSave]);

  const ensureStageActive = (stage: FunnelStage) => {
    setActiveStages(prev => {
      if (prev.has(stage)) return prev;
      const next = new Set(prev);
      next.add(stage);
      return next;
    });
  };

  const toggleFunnelStage = (stage: FunnelStage) => {
    setActiveStages(prev => {
      const next = new Set(prev);
      if (next.has(stage)) {
        next.delete(stage);
      } else {
        next.add(stage);
      }
      return next;
    });
  };

  const toggleVideo = (stage: FunnelStage) => {
    ensureStageActive(stage);
    setFunnelConfigs(prev => prev.map(f => 
      f.stage === stage ? { ...f, videoIncluded: !f.videoIncluded } : f
    ));
  };

  const toggleChannel = (stage: FunnelStage, partner: Partner) => {
    ensureStageActive(stage);
    setFunnelConfigs(prev => prev.map(f => {
      if (f.stage === stage) {
        const isSelected = f.channels.includes(partner);
        const channels = isSelected
          ? f.channels.filter(p => p !== partner)
          : [...f.channels, partner];
        
        // When selecting a channel, automatically select all its inventories
        // When deselecting, remove all its inventories
        const platformInventories = allInventoriesByPlatform[partner] || [];
        let selectedInventories = [...f.selectedInventories];
        
        if (isSelected) {
          // Deselecting channel: remove its inventories
          selectedInventories = selectedInventories.filter(i => !platformInventories.includes(i));
        } else {
          // Selecting channel: add its inventories
          const newInventories = platformInventories.filter(i => !selectedInventories.includes(i));
          selectedInventories = [...selectedInventories, ...newInventories];
        }
        
        return { ...f, channels, selectedInventories };
      }
      return f;
    }));
  };

  const toggleInventory = (stage: FunnelStage, inventory: string) => {
    ensureStageActive(stage);
    setFunnelConfigs(prev => prev.map(f => {
      if (f.stage === stage) {
        const selectedInventories = f.selectedInventories.includes(inventory)
          ? f.selectedInventories.filter(i => i !== inventory)
          : [...f.selectedInventories, inventory];
        return { ...f, selectedInventories };
      }
      return f;
    }));
  };

  const generateAssets = async () => {
    setLoading(true);
    
    const activeConfigs = funnelConfigs.filter(c => activeStages.has(c.stage));
    const allPartners = Array.from(new Set(activeConfigs.flatMap(f => f.channels)));
    const allStages = activeConfigs.map(f => f.stage);
    const heroVideoAvailable = activeConfigs.some(f => f.videoIncluded);

    const query: AssetIdentificationQuery = {
      funnelStages: allStages,
      goals: [],
      partners: allPartners,
      heroVideoAvailable,
      selectedInventories: activeConfigs.flatMap(f => f.selectedInventories)
    };

    const identifiedAssets = await assetService.identifyAssets(query);
    setResults(identifiedAssets);
    setLoading(false);
  };

  const toggleAssetSelection = (assetId: string) => {
    setResults(prev => prev.map(asset => 
      asset.id === assetId ? { ...asset, selected: !asset.selected } : asset
    ));
  };

  const toggleAssetSpec = (assetId: string, type: 'ratios' | 'lengths', value: string) => {
    setResults(prev => prev.map(asset => {
      if (asset.id === assetId) {
        const isRatios = type === 'ratios';
        const selectedKey = isRatios ? 'selectedRatios' : 'selectedLengths';
        const displayKey = isRatios ? 'aspectRatios' : 'lengths';
        
        const currentSelection = asset[selectedKey];
        const isSelected = currentSelection.includes(value);
        
        const newSelection = isSelected 
          ? currentSelection.filter(v => v !== value)
          : [...currentSelection, value];
          
        return {
          ...asset,
          [selectedKey]: newSelection,
          [displayKey]: newSelection.length > 0 ? newSelection.join(', ') : '-',
          isEdited: true
        };
      }
      return asset;
    }));
  };

  // Filtering logic for the slicer
  const filteredResults = results.filter(asset => {
    const channelMatch = !selectedChannelFilter || asset.channel === selectedChannelFilter;
    const platformMatch = !selectedPlatformFilter || asset.platform === selectedPlatformFilter;
    const typeMatch = selectedTypeFilter === 'all' || 
                    (selectedTypeFilter === 'video' && asset.requiresVideo) ||
                    (selectedTypeFilter === 'static' && !asset.requiresVideo);
    return channelMatch && platformMatch && typeMatch;
  });

  const uniqueChannels = Array.from(new Set(results.map(r => r.channel))).sort();
  const uniquePlatforms = selectedChannelFilter 
    ? Array.from(new Set(results.filter(r => r.channel === selectedChannelFilter).map(r => r.platform))).sort()
    : Array.from(new Set(results.map(r => r.platform))).sort();

  if (viewMode === 'strategy') {
    return (
      <div className={`workflow-container-redesign ${isEmbedded ? 'embedded' : ''}`}>
        <div className="workflow-content-redesign">
          {!isEmbedded && (
            <header className="redesign-header">
              <div className="header-top">
                <button className="back-link" onClick={onBack}>
                  <span className="material-icons-outlined">arrow_back</span>
                  Back to Project
                </button>
                <div className="project-badge">{campaignData?.name || 'New Project'}</div>
              </div>
              <h1>Channel Strategy</h1>
              <p>Define your campaign strategy by funnel stage to generate requirements.</p>
            </header>
          )}

          <div className="strategy-section-wrapper">
            <div className="section-header-no-collapse">
              <h3>CHANNEL SELECTION</h3>
            </div>
            
            <div className="swimlane-area">
                <section className="funnel-swimlanes">
                  {STAGES.map(stage => {
                    const isActive = activeStages.has(stage);
                    const config = funnelConfigs.find(f => f.stage === stage)!;
                    const platforms = allPlatformsByStage[stage] || [];
                    
                    return (
                      <div key={stage} className={`swimlane-column ${isActive ? 'active' : ''}`}>
                        <div className="swimlane-header" onClick={() => toggleFunnelStage(stage)}>
                          <div className="stage-title">
                            <span className="material-icons-outlined">
                              {stage === 'Awareness' ? 'visibility' : stage === 'Consideration' ? 'touch_app' : 'shopping_cart'}
                            </span>
                            <h3>{stage}</h3>
                          </div>
                          <div className={`status-indicator ${isActive ? 'active' : ''}`}>
                            {isActive ? 'Active' : 'Disabled'}
                          </div>
                        </div>

                        <div className="swimlane-content">
                          <div className="config-option">
                            <div className="option-info">
                              <span className="label">Include Video</span>
                              <span className="desc">Active creative for this stage</span>
                            </div>
                            <div 
                              className={`custom-toggle ${config.videoIncluded ? 'active' : ''}`}
                              onClick={() => toggleVideo(stage)}
                            >
                              <div className="toggle-thumb"></div>
                            </div>
                          </div>

                          <div className="persistent-channels">
                            <div className="label">CHANNELS</div>
                            <div className="channels-grid">
                              {platforms.map(partner => {
                                const isSelected = config.channels.includes(partner);
                                const platformInventories = allInventoriesByPlatform[partner] || [];
                                
                                return (
                                  <div key={partner} className="channel-group">
                                    <div 
                                      className={`channel-item ${isSelected ? 'selected' : ''}`}
                                      onClick={() => toggleChannel(stage, partner)}
                                    >
                                      <div className="checkbox">
                                        {isSelected && <span className="material-icons-outlined">check</span>}
                                      </div>
                                      <span className="channel-name">{partner}</span>
                                    </div>
                                    
                                    {isSelected && platformInventories.length > 0 && (
                                      <div className="nested-inventories">
                                        {platformInventories.map(inv => {
                                          const isInvSelected = config.selectedInventories?.includes(inv);
                                          return (
                                            <div 
                                              key={inv} 
                                              className={`inventory-item ${isInvSelected ? 'selected' : ''}`}
                                              onClick={() => toggleInventory(stage, inv)}
                                            >
                                              <div className="checkbox">
                                                {isInvSelected && <span className="material-icons-outlined">check</span>}
                                              </div>
                                              <span className="inventory-name">{inv}</span>
                                            </div>
                                          );
                                        })}
                                      </div>
                                    )}
                                  </div>
                                );
                              })}
                              {platforms.length === 0 && <span className="placeholder">Loading channels...</span>}
                            </div>
                          </div>
                        </div>
                      </div>
                    );
                  })}
                </section>
            </div>
          </div>

          <div className="generate-actions">
            <button className="btn-generate-premium" onClick={generateAssets} disabled={activeStages.size === 0}>
              Update Asset Requirements
              <span className="material-icons-outlined">auto_awesome</span>
            </button>
          </div>
        </div>
      </div>
    );
  }

  // Requirements View
  return (
    <div className={`workflow-container-redesign requirements-layout ${!isSidebarOpen ? 'sidebar-collapsed' : ''} ${isEmbedded ? 'embedded' : ''}`}>
      <div className="workflow-content-redesign">
        {!isEmbedded && (
          <header className="redesign-header">
            <div className="header-top">
              <button className="back-link" onClick={onBack}>
                <span className="material-icons-outlined">arrow_back</span>
                Back to Project
              </button>
              <div className="project-badge">{campaignData?.name || 'New Project'}</div>
            </div>
            <h1>Asset Requirements</h1>
            <p>Finalized list of assets across all selected stages and platforms.</p>
          </header>
        )}

        <section className="results-section-redesign">
          <div className="results-header">
            <div className="header-title-group">
              <h3>RECOMMENDED ASSETS</h3>
              <span className="results-count">{filteredResults.length} assets identified</span>
            </div>
            <div className="header-actions">
              <div className="view-toggle-premium">
                <button 
                  className={`toggle-icon-btn ${resultsDisplayMode === 'grid' ? 'active' : ''}`}
                  onClick={() => setResultsDisplayMode('grid')}
                  title="Grid View"
                >
                  <span className="material-icons-outlined">grid_view</span>
                </button>
                <button 
                  className={`toggle-icon-btn ${resultsDisplayMode === 'table' ? 'active' : ''}`}
                  onClick={() => setResultsDisplayMode('table')}
                  title="Table View"
                >
                  <span className="material-icons-outlined">table_chart</span>
                </button>
              </div>
              <div className="actions-divider"></div>
              <button 
                className={`sidebar-toggle-btn ${isSidebarOpen ? 'active' : ''}`}
                onClick={() => setIsSidebarOpen(!isSidebarOpen)}
                title={isSidebarOpen ? 'Collapse Filters' : 'Expand Filters'}
              >
                <span className="material-icons-outlined">filter_list</span>
                <span>Filters</span>
              </button>
            </div>
          </div>
          
          {loading ? (
            <div className="loading-state-redesign">
              <div className="premium-spinner"></div>
              <p>Refreshing list based on your strategy...</p>
            </div>
          ) : filteredResults.length > 0 ? (
            resultsDisplayMode === 'grid' ? (
              <div className="assets-grid-redesign">
                {filteredResults.map(asset => (
                  <div key={asset.id} className="asset-card-redesign">
                    <div className="asset-meta">
                      <span className="channel-tag">{asset.channel}</span>
                      <span className="platform-tag" style={{ marginLeft: '8px', fontSize: '10px', opacity: 0.7 }}>{asset.platform}</span>
                      {asset.requiresVideo && (
                        <span className="material-icons-outlined video-tag" title="Video Required">videocam</span>
                      )}
                    </div>
                    <h4>{asset.formatName}</h4>
                    <div style={{ fontSize: '12px', marginTop: '8px' }}>
                      <div className="spec-row"><strong>Ratios:</strong> {asset.aspectRatios}</div>
                      <div className="spec-row"><strong>Lengths:</strong> {asset.lengths}</div>
                    </div>
                    <div className="card-footer-actions">
                      <button className="btn-edit-cell" onClick={() => setEditingAssetId(asset.id)}>
                        <span className="material-icons-outlined">edit</span>
                        Edit
                      </button>
                    </div>
                  </div>
                ))}
              </div>
            ) : (
              <div className="assets-table-container-premium">
                <table className="assets-table-premium">
                  <thead>
                    <tr>
                      <th style={{ width: '40px' }}></th>
                      <th>CHANNEL</th>
                      <th>AD PLATFORM</th>
                      <th>FORMAT NAME</th>
                      <th>RATIOS</th>
                      <th>LENGTHS</th>
                    </tr>
                  </thead>
                  <tbody>
                    {filteredResults.map(asset => (
                      <tr key={asset.id} className={!asset.selected ? 'row-deselected' : ''}>
                        <td>
                          <div 
                            className={`custom-checkbox ${asset.selected ? 'checked' : ''}`}
                            onClick={() => toggleAssetSelection(asset.id)}
                          >
                            {asset.selected && <span className="material-icons-outlined">check</span>}
                          </div>
                        </td>
                        <td>
                          <span className="channel-tag-table">{asset.channel}</span>
                        </td>
                        <td>
                          <div className="asset-name-cell">{asset.platform}</div>
                        </td>
                        <td>
                          <div className="asset-name-cell" style={{ fontWeight: 600, display: 'flex', alignItems: 'center' }}>
                            {asset.formatName}
                            {asset.isEdited && (
                              <span className="material-icons-outlined edited-icon" title="Edited">info</span>
                            )}
                            {asset.requiresVideo && (
                              <span className="material-icons-outlined video-icon-small" title="Requires Video">videocam</span>
                            )}
                          </div>
                        </td>
                        <td>
                          <div 
                            className="asset-specs-cell editable"
                            onClick={() => setEditingAssetId(asset.id)}
                          >
                            {asset.aspectRatios}
                          </div>
                        </td>
                        <td>
                          <div 
                            className="asset-specs-cell editable"
                            onClick={() => setEditingAssetId(asset.id)}
                          >
                            {asset.lengths}
                          </div>
                        </td>
                      </tr>
                    ))}
                  </tbody>
                </table>
              </div>
            )
          ) : (
            <div className="no-results-redesign">
              <span className="material-icons-outlined">search_off</span>
              <p>No assets match your current filters.</p>
              <button className="btn-text" onClick={() => {
                setSelectedChannelFilter('');
                setSelectedPlatformFilter('');
                setSelectedTypeFilter('all');
              }}>Clear all filters</button>
            </div>
          )}
        </section>
      </div>

      <aside className={`assets-slicer-sidebar ${!isSidebarOpen ? 'collapsed' : ''}`}>
        <div className="sidebar-header">
          <h3>Filters</h3>
          <button className="btn-text-only" onClick={() => {
            setSelectedChannelFilter('');
            setSelectedPlatformFilter('');
            setSelectedTypeFilter('all');
          }}>Reset</button>
        </div>

        <div className="filter-section">
          <div className="section-title">CHANNELS</div>
          <div className="filter-list">
            <button 
              className={`filter-item ${!selectedChannelFilter ? 'active' : ''}`}
              onClick={() => {
                setSelectedChannelFilter('');
                setSelectedPlatformFilter('');
              }}
            >
              All Channels
            </button>
            {uniqueChannels.map(channel => (
              <button 
                key={channel} 
                className={`filter-item ${selectedChannelFilter === channel ? 'active' : ''}`}
                onClick={() => {
                  setSelectedChannelFilter(channel);
                  setSelectedPlatformFilter('');
                }}
              >
                {channel}
              </button>
            ))}
          </div>
        </div>

        <div className="filter-section animate-fade-in">
          <div className="section-title">AD PLATFORMS</div>
          <div className="filter-list">
            <button 
              className={`filter-item ${!selectedPlatformFilter ? 'active' : ''}`}
              onClick={() => setSelectedPlatformFilter('')}
            >
              All Platforms
            </button>
            {uniquePlatforms.map(platform => (
              <button 
                key={platform} 
                className={`filter-item ${selectedPlatformFilter === platform ? 'active' : ''}`}
                onClick={() => setSelectedPlatformFilter(platform)}
              >
                {platform}
              </button>
            ))}
          </div>
        </div>

        <div className="filter-section">
          <div className="section-title">ASSET TYPE</div>
          <div className="filter-list">
            <button 
              className={`filter-item ${selectedTypeFilter === 'all' ? 'active' : ''}`}
              onClick={() => setSelectedTypeFilter('all')}
            >
              All Types
            </button>
            <button 
              className={`filter-item ${selectedTypeFilter === 'static' ? 'active' : ''}`}
              onClick={() => setSelectedTypeFilter('static')}
            >
              Static Only
            </button>
            <button 
              className={`filter-item ${selectedTypeFilter === 'video' ? 'active' : ''}`}
              onClick={() => setSelectedTypeFilter('video')}
            >
              Video Only
            </button>
          </div>
        </div>

        <div className="sidebar-footer-stats">
          <div className="stats-row">
            <span>Showing</span>
            <span className="stats-value">{filteredResults.length} / {results.length}</span>
          </div>
        </div>
      </aside>

      {editingAssetId && (
        <div className="modal-overlay" onClick={() => setEditingAssetId(null)}>
          <div className="modal-content combined-edit-modal" onClick={e => e.stopPropagation()}>
            <div className="modal-header">
              <div className="modal-title-group">
                <h3>Edit Asset Requirements</h3>
                <span className="modal-subtitle">
                  {results.find(r => r.id === editingAssetId)?.formatName} — {results.find(r => r.id === editingAssetId)?.platform}
                </span>
              </div>
              <button className="close-modal" onClick={() => setEditingAssetId(null)}>
                <span className="material-icons-outlined">close</span>
              </button>
            </div>
            
            <div className="modal-scroll-area">
              {(() => {
                const asset = results.find(r => r.id === editingAssetId);
                if (!asset) return null;
                
                return (
                  <div className="combined-edit-sections">
                    <div className="edit-section">
                      <h4>Ratios</h4>
                      <div className="options-grid">
                        {asset.availableRatios.map(ratio => {
                          const isSelected = asset.selectedRatios.includes(ratio);
                          return (
                            <div 
                              key={ratio} 
                              className={`option-item ${isSelected ? 'selected' : ''}`}
                              onClick={() => toggleAssetSpec(asset.id, 'ratios', ratio)}
                            >
                              <div className="checkbox">
                                {isSelected && <span className="material-icons-outlined">check</span>}
                              </div>
                              <span>{ratio}</span>
                            </div>
                          );
                        })}
                      </div>
                    </div>

                    <div className="edit-section">
                      <h4>Lengths</h4>
                      <div className="options-grid">
                        {asset.availableLengths.map(length => {
                          const isSelected = asset.selectedLengths.includes(length);
                          return (
                            <div 
                              key={length} 
                              className={`option-item ${isSelected ? 'selected' : ''}`}
                              onClick={() => toggleAssetSpec(asset.id, 'lengths', length)}
                            >
                              <div className="checkbox">
                                {isSelected && <span className="material-icons-outlined">check</span>}
                              </div>
                              <span>{length}</span>
                            </div>
                          );
                        })}
                      </div>
                    </div>
                  </div>
                );
              })()}
            </div>
            
            <div className="modal-footer">
              <button className="btn-primary" onClick={() => setEditingAssetId(null)}>Done</button>
            </div>
          </div>
        </div>
      )}
    </div>
  );
};


