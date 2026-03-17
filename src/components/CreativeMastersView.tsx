import React, { useState } from 'react';
import { type MasterAsset, type FunnelStage } from '../services/assetService';
import './AssetIdentificationWorkflow.css'; // Reusing some styles

interface CreativeMastersViewProps {
  masters: MasterAsset[];
  projectName: string;
}

export const CreativeMastersView: React.FC<CreativeMastersViewProps> = ({ masters, projectName }) => {
  const [selectedMaster, setSelectedMaster] = useState<MasterAsset | null>(null);
  const [viewMode, setViewMode] = useState<'detailed' | 'aggregated'>('detailed');

  const groupedByStage = masters.reduce((acc, master) => {
    if (!acc[master.funnelStage]) acc[master.funnelStage] = [];
    acc[master.funnelStage].push(master);
    return acc;
  }, {} as Record<FunnelStage, MasterAsset[]>);

  const STAGES: FunnelStage[] = ['Awareness', 'Consideration', 'Conversion'];

  const getDisplayMasters = (stageMasters: MasterAsset[]) => {
    if (viewMode === 'detailed') return stageMasters;

    const aggregated: Record<string, MasterAsset> = {};
    
    stageMasters.forEach(master => {
      const type = master.type;
      if (!aggregated[type]) {
        aggregated[type] = {
          ...master,
          id: `agg-${master.funnelStage}-${type}`,
          ratio: master.ratio,
          length: master.length,
          originalAssets: [...master.originalAssets]
        };
      } else {
        // Collect unique ratios
        const existingRatios = aggregated[type].ratio.split(', ').map(r => r.trim());
        const newRatios = master.ratio.split(', ').map(r => r.trim());
        const allRatios = Array.from(new Set([...existingRatios, ...newRatios])).filter(Boolean).sort();
        aggregated[type].ratio = allRatios.join(', ');

        // Collect unique lengths
        const existingLengths = aggregated[type].length.split(', ').map(l => l.trim());
        const newLengths = master.length.split(', ').map(l => l.trim());
        const allLengths = Array.from(new Set([...existingLengths, ...newLengths])).filter(l => l !== '-').sort();
        aggregated[type].length = allLengths.length > 0 ? allLengths.join(', ') : '-';

        // Flatten original assets and avoid duplicates
        master.originalAssets.forEach(newAsset => {
          const exists = aggregated[type].originalAssets.some(oa => 
            oa.channel === newAsset.channel && 
            oa.platform === newAsset.platform && 
            oa.formatName === newAsset.formatName
          );
          if (!exists) {
            aggregated[type].originalAssets.push(newAsset);
          }
        });
      }
    });

    return Object.values(aggregated);
  };

  return (
    <div className="workflow-container-redesign creative-masters-layout">
      <div className="workflow-content-redesign">
        <header className="redesign-header">
          <div className="header-top">
            <div className="project-badge">{projectName}</div>
            <div className="header-actions">
              <div className="view-toggle-premium">
                <button 
                  className={`toggle-icon-btn ${viewMode === 'detailed' ? 'active' : ''}`}
                  onClick={() => setViewMode('detailed')}
                  title="Detailed View"
                >
                  <span className="material-icons-outlined">list</span>
                  <span>Detailed</span>
                </button>
                <button 
                  className={`toggle-icon-btn ${viewMode === 'aggregated' ? 'active' : ''}`}
                  onClick={() => setViewMode('aggregated')}
                  title="Aggregate View"
                >
                  <span className="material-icons-outlined">summary</span>
                  <span>Aggregate</span>
                </button>
              </div>
            </div>
          </div>
          <h1>Creative Masters</h1>
          <p>Grouped asset requirements for production planning.</p>
        </header>

        <section className="results-section-redesign">
          {masters.length === 0 ? (
            <div className="no-results-redesign empty-strategy">
              <span className="material-icons-outlined">Groups</span>
              <h3>No master assets generated yet</h3>
              <p>Go to the Recommended Assets tab and click 'Group Masters' to generate this list.</p>
            </div>
          ) : (
            STAGES.map(stage => {
              const stageMasters = groupedByStage[stage] || [];
              if (stageMasters.length === 0) return null;

              const displayMasters = getDisplayMasters(stageMasters);

              return (
                <div key={stage} className="master-stage-section" style={{ marginBottom: '32px' }}>
                  <div className="section-header-no-collapse" style={{ borderBottom: '1px solid var(--border-color)', marginBottom: '16px' }}>
                    <h3 style={{ textTransform: 'uppercase', letterSpacing: '0.05em' }}>{stage}</h3>
                    <span className="results-count">{displayMasters.length} {viewMode === 'aggregated' ? 'Groups' : 'Masters'}</span>
                  </div>
                  
                  <div className="assets-table-container-premium">
                    <table className="assets-table-premium">
                      <thead>
                        <tr>
                          <th>TYPE</th>
                          <th>RATIO</th>
                          <th>LENGTH</th>
                          <th style={{ textAlign: 'right' }}>USAGE</th>
                        </tr>
                      </thead>
                      <tbody>
                        {displayMasters.map(master => (
                          <tr key={master.id}>
                            <td>
                              <span className={`channel-tag-table ${master.type.toLowerCase()}`}>
                                {master.type}
                              </span>
                            </td>
                            <td 
                              className="clickable-cell"
                              onClick={() => setSelectedMaster(master)}
                            >
                              <strong>{master.ratio}</strong>
                            </td>
                            <td 
                              className="clickable-cell"
                              onClick={() => setSelectedMaster(master)}
                            >
                              {master.length}
                            </td>
                            <td 
                              style={{ textAlign: 'right' }}
                              className="clickable-cell"
                              onClick={() => setSelectedMaster(master)}
                            >
                              <span className="usage-count" style={{ background: 'rgba(59, 130, 246, 0.1)', color: 'var(--primary-blue)', padding: '2px 8px', borderRadius: '12px', fontSize: '12px', fontWeight: 600 }}>
                                {master.originalAssets.length} Channels/Platforms
                              </span>
                            </td>
                          </tr>
                        ))}
                      </tbody>
                    </table>
                  </div>
                </div>
              );
            })
          )}
        </section>
      </div>

      {selectedMaster && (
        <div className="modal-overlay" onClick={() => setSelectedMaster(null)}>
          <div className="modal-content-premium" onClick={e => e.stopPropagation()}>
            <div className="modal-header-premium">
              <div className="modal-title-group">
                <h3 style={{ fontSize: '1.5rem', fontWeight: 800, color: '#0f172a', marginBottom: '0.5rem' }}>Master Asset Details</h3>
                <p style={{ fontSize: '0.95rem', color: '#64748b' }}>
                  <strong>{selectedMaster.funnelStage}</strong> • {selectedMaster.type} • {selectedMaster.ratio} • {selectedMaster.length}
                </p>
              </div>
              <button className="btn-icon-only" onClick={() => setSelectedMaster(null)}>
                <span className="material-icons-outlined">close</span>
              </button>
            </div>
            
            <div className="modal-body-premium">
              <div className="mapping-section">
                <h4 style={{ marginBottom: '1.5rem', fontSize: '0.8rem', fontWeight: 800, color: '#94a3b8', letterSpacing: '0.1em', textTransform: 'uppercase' }}>
                  MAPPED TO THE FOLLOWING {selectedMaster.originalAssets.length} CHANNELS & PLATFORMS:
                </h4>
                <div className="mapped-assets-list">
                  {selectedMaster.originalAssets.map((asset, idx) => (
                    <div key={idx} className="mapped-asset-item">
                      <span className="material-icons-outlined" style={{ marginRight: '1rem', color: '#6366f1', fontSize: '1.25rem' }}>link</span>
                      <div className="item-details">
                        <div style={{ fontWeight: 700, fontSize: '0.95rem', color: '#1e293b' }}>{asset.channel}</div>
                        <div style={{ fontSize: '0.8rem', color: '#64748b', fontWeight: 500 }}>{asset.platform}</div>
                        <div style={{ fontSize: '0.75rem', color: '#94a3b8', marginTop: '0.1rem' }}>{asset.formatName}</div>
                      </div>
                    </div>
                  ))}
                </div>
              </div>
            </div>
            
            <div className="modal-footer-premium">
              <button 
                className="btn-generate-premium small" 
                onClick={() => setSelectedMaster(null)}
                style={{ background: '#6366f1' }}
              >
                Close Details
              </button>
            </div>
          </div>
        </div>
      )}
    </div>
  );
};
