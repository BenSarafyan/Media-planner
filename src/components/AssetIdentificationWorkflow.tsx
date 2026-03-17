import React, { useState } from 'react';
import { assetService, type AssetIdentificationQuery, type RecommendedAsset, type FunnelStage } from '../services/assetService';
import { adminService } from '../services/adminService';
import { type Campaign } from '../services/campaignService';
import './AssetIdentificationWorkflow.css';

interface AssetIdentificationWorkflowProps {
  onBack: () => void;
  campaignData: Campaign | null;
  onSave?: (assets: RecommendedAsset[], config: any[]) => void;
  onSaveMasters?: (masters: any[]) => void;
  isEmbedded?: boolean;
  initialConfig?: any[];
  viewMode?: 'strategy' | 'requirements';
  onSubTabChange?: (tab: 'overview' | 'strategy' | 'requirements' | 'creative-masters' | 'team') => void;
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
  onSaveMasters,
  isEmbedded = false,
  initialConfig = [],
  viewMode = 'strategy',
  onSubTabChange
}) => {
  const STAGES: FunnelStage[] = ['Awareness', 'Consideration', 'Conversion'];
  
  // Initialize with all stages but maybe empty channels
  const [funnelConfigs, setFunnelConfigs] = useState<FunnelConfig[]>(() => {
    const defaultConfigs: FunnelConfig[] = STAGES.map(stage => ({
      stage,
      videoIncluded: false,
      channels: [],
      selectedInventories: []
    }));

    if (initialConfig && Array.isArray(initialConfig) && initialConfig.length > 0) {
      // Merge initialConfig with defaults to ensure all stages represent
      return STAGES.map(stage => {
        const existing = initialConfig.find(c => c && c.stage === stage);
        const defaultConfig = defaultConfigs.find(c => c.stage === stage)!;
        
        if (existing) {
          return {
            ...defaultConfig,
            ...existing,
            channels: existing.channels || [],
            selectedInventories: existing.selectedInventories || []
          };
        }
        return defaultConfig;
      });
    }
    return defaultConfigs;
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
  const [showUpdateConfirmModal, setShowUpdateConfirmModal] = useState(false);

  // Filter states for slicer
  const [selectedChannelFilter, setSelectedChannelFilter] = useState<string>('');
  const [selectedPlatformFilter, setSelectedPlatformFilter] = useState<string>('');
  const [selectedTypeFilter, setSelectedTypeFilter] = useState<'all' | 'static' | 'video'>('all');
  const [selectedStatusFilter, setSelectedStatusFilter] = useState<'all' | 'deselected' | 'edited'>('all');

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

  const generateAssets = async (mode: 'scratch' | 'maintain' = 'scratch') => {
    setLoading(true);
    setShowUpdateConfirmModal(false);
    
    try {
      const activeConfigs = funnelConfigs.filter(c => c && activeStages.has(c.stage));
      const allPartners = Array.from(new Set(activeConfigs.flatMap(f => f.channels || [])));
      const allStages = activeConfigs.map(f => f.stage);
      const heroVideoAvailable = activeConfigs.some(f => f && f.videoIncluded);

      const query: AssetIdentificationQuery = {
        funnelStages: allStages,
        goals: [],
        partners: allPartners,
        heroVideoAvailable,
        selectedInventories: activeConfigs.flatMap(f => f.selectedInventories || [])
      };

      const identifiedAssets = await assetService.identifyAssets(query);
      
      if (mode === 'maintain' && results.length > 0) {
        // Merge logic: Maintain previous exclusions and edits if they still apply
        const mergedAssets = identifiedAssets.map(newAsset => {
          // Find matching asset in previous results
          const previousAsset = results.find(prev => 
            prev.channel === newAsset.channel && 
            prev.platform === newAsset.platform && 
            prev.formatName === newAsset.formatName
          );

          if (!previousAsset) return newAsset;

          // Restore selection status
          const selected = previousAsset.selected;
          
          // Restore edits if applicable
          let isEdited = previousAsset.isEdited;
          let selectedRatios = [...newAsset.selectedRatios];
          let selectedLengths = [...newAsset.selectedLengths];
          let aspectRatiosString = newAsset.aspectRatios;
          let lengthsString = newAsset.lengths;

          if (isEdited) {
            // Only maintain ratios/lengths that are still available in the new definition
            const maintainedRatios = previousAsset.selectedRatios.filter(r => 
              newAsset.availableRatios.includes(r)
            );
            const maintainedLengths = previousAsset.selectedLengths.filter(l => 
              newAsset.availableLengths.includes(l)
            );

            // If we have any maintained specs, use them. Otherwise, default to the new ones and clear isEdited
            if (maintainedRatios.length > 0 || maintainedLengths.length > 0) {
              if (maintainedRatios.length > 0) {
                selectedRatios = maintainedRatios;
                aspectRatiosString = maintainedRatios.join(', ');
              }
              if (maintainedLengths.length > 0) {
                selectedLengths = maintainedLengths;
                lengthsString = maintainedLengths.join(', ');
              }
            } else {
              isEdited = false;
            }
          }

          return {
            ...newAsset,
            selected,
            isEdited,
            selectedRatios,
            selectedLengths,
            aspectRatios: aspectRatiosString,
            lengths: lengthsString
          };
        });
        setResults(mergedAssets);
      } else {
        setResults(identifiedAssets);
      }
      onSubTabChange?.('requirements');
    } catch (error) {
      console.error('Error generating assets:', error);
    } finally {
      setLoading(false);
    }
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

  const handleGroupMasters = () => {
    if (onSaveMasters) {
      const masters = assetService.groupMasterAssets(results);
      onSaveMasters(masters);
      // Change tab to creative masters if callback provided
      onSubTabChange?.('creative-masters');
    }
  };

  // Filtering logic for the slicer
  const filteredResults = results.filter(asset => {
    const channelMatch = !selectedChannelFilter || asset.channel === selectedChannelFilter;
    const platformMatch = !selectedPlatformFilter || asset.platform === selectedPlatformFilter;
    const typeMatch = selectedTypeFilter === 'all' || 
                    (selectedTypeFilter === 'video' && asset.requiresVideo) ||
                    (selectedTypeFilter === 'static' && !asset.requiresVideo);
    
    const statusMatch = selectedStatusFilter === 'all' ||
                      (selectedStatusFilter === 'deselected' && !asset.selected) ||
                      (selectedStatusFilter === 'edited' && asset.isEdited && asset.selected);
                      
    return channelMatch && platformMatch && typeMatch && statusMatch;
  });

  // Calculate summary stats
  const stats = React.useMemo(() => {
    const activeResults = results;
    const channels = new Set(activeResults.map(r => r.channel));
    const platforms = new Set(activeResults.map(r => r.platform));
    const formats = new Set(activeResults.map(r => r.formatName));
    
    // Count total variants (selected variants in selected rows)
    let totalVariants = 0;
    activeResults.forEach(r => {
      if (r.selected) {
        totalVariants += (r.selectedRatios.length * (r.selectedLengths.length || 1));
      }
    });

    const deselectedRowsCount = activeResults.filter(r => !r.selected).length;
    const editedRowsCount = activeResults.filter(r => r.isEdited && r.selected).length;
    
    // Count total variants deselected (total available - total selected)
    let variantsDeselected = 0;
    activeResults.forEach(r => {
      if (r.selected && r.isEdited) {
        const totalAvailable = r.availableRatios.length * (r.availableLengths.length || 1);
        const totalSelected = r.selectedRatios.length * (r.selectedLengths.length || 1);
        variantsDeselected += (totalAvailable - totalSelected);
      }
    });

    return {
      channels: channels.size,
      platforms: platforms.size,
      formats: formats.size,
      totalVariants,
      deselectedRowsCount,
      editedRowsCount,
      variantsDeselected
    };
  }, [results]);

  const uniqueChannels = Array.from(new Set(results.map(r => r.channel))).sort();
  const uniquePlatforms = selectedChannelFilter 
    ? Array.from(new Set(results.filter(r => r.channel === selectedChannelFilter).map(r => r.platform))).sort()
    : Array.from(new Set(results.map(r => r.platform))).sort();

  return (
    <>
      {viewMode === 'strategy' ? (
        <div className={`workflow-container-redesign ${isEmbedded ? 'embedded' : ''}`}>
        <div className="workflow-content-redesign">
          {/* Removed big header to match project view */}


          <div className="strategy-section-wrapper">
            <div className="section-header-no-collapse">
              <h3>CHANNEL SELECTION</h3>
                <button className="btn-generate-premium small" onClick={() => setShowUpdateConfirmModal(true)} disabled={activeStages.size === 0}>
                  <span className="material-icons-outlined">auto_awesome</span>
                  Update Assets
                </button>

            </div>
            
            <div className="swimlane-area">
                <section className="funnel-swimlanes">
                  {STAGES.map(stage => {
                    const isActive = activeStages.has(stage);
                    const config = funnelConfigs.find(f => f.stage === stage);
                    const platforms = allPlatformsByStage[stage] || [];
                    
                    if (!config) return null; // Safety check
                    
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

        </div>
      </div>
      ) : (
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
            <h1>Recommended Assets</h1>
            <p>Finalized list of assets across all selected stages and platforms.</p>
          </header>
        )}

        <section className="results-section-redesign">
          <div className="summary-dashboard">
            <div className="stats-grid-premium">
              <div className="stat-card-premium">
                <span className="stat-label">Channels</span>
                <span className="stat-value">{stats.channels}</span>
              </div>
              <div className="stat-card-premium">
                <span className="stat-label">Platforms</span>
                <span className="stat-value">{stats.platforms}</span>
              </div>
              <div className="stat-card-premium">
                <span className="stat-label">Formats</span>
                <span className="stat-value">{stats.formats}</span>
              </div>
              <div className="stat-card-premium">
                <span className="stat-label">Total Assets</span>
                <span className="stat-value">{stats.totalVariants}</span>
              </div>
              {stats.deselectedRowsCount > 0 && (
                <div className="stat-card-premium critical">
                  <span className="stat-label">Deselected Rows</span>
                  <span className="stat-value">{stats.deselectedRowsCount}</span>
                </div>
              )}
              {stats.variantsDeselected > 0 && (
                <div className="stat-card-premium warning">
                  <span className="stat-label">Deselected Variants</span>
                  <span className="stat-value">{stats.variantsDeselected}</span>
                </div>
              )}
            </div>
          </div>

          <div className="results-header">
            <div className="header-title-group" style={{ visibility: 'hidden', height: 0, padding: 0, margin: 0 }}>
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
              <div className="actions-divider"></div>
              <button className="btn-generate-premium small" onClick={() => setShowUpdateConfirmModal(true)} disabled={activeStages.size === 0}>
                <span className="material-icons-outlined">auto_awesome</span>
                Update Assets
              </button>
              <div className="actions-divider"></div>
              <button 
                className="btn-primary-ghost small" 
                onClick={handleGroupMasters} 
                disabled={results.length === 0}
                style={{ height: '36px', padding: '0 12px' }}
              >
                <span className="material-icons-outlined">Groups</span>
                Group Masters
              </button>
            </div>
          </div>
          
          {loading ? (
            <div className="loading-state-redesign">
              <div className="premium-spinner"></div>
              <p>Refreshing list based on your strategy...</p>
            </div>
          ) : results.length === 0 ? (
            <div className="no-results-redesign empty-strategy">
              <span className="material-icons-outlined">TipsAndUpdates</span>
              <h3>No assets identified yet</h3>
              <p>Go to the Channel mix tab to select your channels and generate requirements.</p>
              {onSubTabChange && (
                <button className="btn-primary-ghost" onClick={() => onSubTabChange('strategy')}>
                  Define Channel mix
                  <span className="material-icons-outlined">arrow_forward</span>
                </button>
              )}
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
                    {filteredResults.map(asset => {
                      const isDeselected = !asset.selected;
                      const isEdited = asset.isEdited && asset.selected;
                      const rowClass = isDeselected ? 'row-deselected-critical' : isEdited ? 'row-edited-warning' : '';
                      
                      return (
                        <tr key={asset.id} className={rowClass}>
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
                    );
                  })}
                </tbody>
              </table>
            </div>
          )
        ) : (
            <div className="no-results-redesign">
              <span className="material-icons-outlined">search_off</span>
              <h3>No matches found</h3>
              <p>Adjust your filters or clear them to see all recommended assets.</p>
              <button className="btn-text" onClick={() => {
                setSelectedChannelFilter('');
                setSelectedPlatformFilter('');
                setSelectedTypeFilter('all');
                setSelectedStatusFilter('all');
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
            setSelectedStatusFilter('all');
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

        <div className="filter-section">
          <div className="section-title">STATUS</div>
          <div className="filter-list">
            <button 
              className={`filter-item ${selectedStatusFilter === 'all' ? 'active' : ''}`}
              onClick={() => setSelectedStatusFilter('all')}
            >
              All Statuses
            </button>
            <button 
              className={`filter-item ${selectedStatusFilter === 'deselected' ? 'active' : ''}`}
              onClick={() => setSelectedStatusFilter('deselected')}
            >
              Deselected Rows
            </button>
            <button 
              className={`filter-item ${selectedStatusFilter === 'edited' ? 'active' : ''}`}
              onClick={() => setSelectedStatusFilter('edited')}
            >
              Edited (Modified)
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
    </div>
      )}
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
      {showUpdateConfirmModal && (
        <div className="modal-overlay" onClick={() => setShowUpdateConfirmModal(false)}>
          <div className="modal-content update-confirm-modal" onClick={e => e.stopPropagation()}>
            <div className="modal-header">
              <h3>Update Content Requirements</h3>
              <button className="close-modal" onClick={() => setShowUpdateConfirmModal(false)}>
                <span className="material-icons-outlined">close</span>
              </button>
            </div>
            <div className="modal-body">
              <p className="modal-description">
                How would you like to update your asset list?
              </p>
              
              <div className="update-options-grid">
                <div className="update-option-card" onClick={() => generateAssets('scratch')}>
                  <div className="option-icon scratch">
                    <span className="material-icons-outlined">refresh</span>
                  </div>
                  <div className="option-content">
                    <h4>Start from scratch</h4>
                    <p>Generate a brand new list based on normal rules. All previous exclusions and edits will be reset.</p>
                  </div>
                  <span className="material-icons-outlined arrow">chevron_right</span>
                </div>

                <div className="update-option-card" onClick={() => generateAssets('maintain')}>
                  <div className="option-icon maintain">
                    <span className="material-icons-outlined">history</span>
                  </div>
                  <div className="option-content">
                    <h4>Maintain previous edits</h4>
                    <p>Update the list while preserving excluded rows and variant edits where they still apply.</p>
                  </div>
                  <span className="material-icons-outlined arrow">chevron_right</span>
                </div>
              </div>
            </div>
          </div>
        </div>
      )}
    </>
  );
};


