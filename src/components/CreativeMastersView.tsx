import React, { useState } from 'react';
import { type MasterAsset, type FunnelStage } from '../services/assetService';
import './AssetIdentificationWorkflow.css'; // Reusing some styles

interface CreativeMastersViewProps {
  masters: MasterAsset[];
  projectName: string;
}

export const CreativeMastersView: React.FC<CreativeMastersViewProps> = ({ masters, projectName }) => {
  const [selectedMaster, setSelectedMaster] = useState<MasterAsset | null>(null);

  const groupedByStage = masters.reduce((acc, master) => {
    if (!acc[master.funnelStage]) acc[master.funnelStage] = [];
    acc[master.funnelStage].push(master);
    return acc;
  }, {} as Record<FunnelStage, MasterAsset[]>);

  const STAGES: FunnelStage[] = ['Awareness', 'Consideration', 'Conversion'];

  return (
    <div className="workflow-container-redesign creative-masters-layout">
      <div className="workflow-content-redesign">
        <header className="redesign-header">
          <div className="header-top">
            <div className="project-badge">{projectName}</div>
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

              return (
                <div key={stage} className="master-stage-section" style={{ marginBottom: '32px' }}>
                  <div className="section-header-no-collapse" style={{ borderBottom: '1px solid var(--border-color)', marginBottom: '16px' }}>
                    <h3 style={{ textTransform: 'uppercase', letterSpacing: '0.05em' }}>{stage}</h3>
                    <span className="results-count">{stageMasters.length} Masters</span>
                  </div>
                  
                  <div className="assets-table-container-premium">
                    <table className="assets-table-premium">
                      <thead>
                        <tr>
                          <th>TYPE</th>
                          <th>RATIO</th>
                          <th>LENGTH</th>
                          <th style={{ textAlign: 'right' }}>USAGE</th>
                          <th></th>
                        </tr>
                      </thead>
                      <tbody>
                        {stageMasters.map(master => (
                          <tr key={master.id}>
                            <td>
                              <span className={`channel-tag-table ${master.type.toLowerCase()}`}>
                                {master.type}
                              </span>
                            </td>
                            <td><strong>{master.ratio}</strong></td>
                            <td>{master.length}</td>
                            <td style={{ textAlign: 'right' }}>
                              <span className="usage-count" style={{ background: 'rgba(59, 130, 246, 0.1)', color: 'var(--primary-blue)', padding: '2px 8px', borderRadius: '12px', fontSize: '12px', fontWeight: 600 }}>
                                {master.originalAssets.length} Channels/Platforms
                              </span>
                            </td>
                            <td style={{ textAlign: 'right' }}>
                              <button 
                                className="btn-edit-cell" 
                                onClick={() => setSelectedMaster(master)}
                                style={{ color: 'var(--primary-blue)' }}
                              >
                                <span className="material-icons-outlined">visibility</span>
                                View Details
                              </button>
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
          <div className="modal-content-premium" onClick={e => e.stopPropagation()} style={{ maxWidth: '600px' }}>
            <div className="modal-header-premium">
              <div className="modal-title-group">
                <h3>Master Asset Details</h3>
                <p>{selectedMaster.funnelStage} • {selectedMaster.type} • {selectedMaster.ratio} • {selectedMaster.length}</p>
              </div>
              <button className="btn-icon-only" onClick={() => setSelectedMaster(null)}>
                <span className="material-icons-outlined">close</span>
              </button>
            </div>
            
            <div className="modal-body-premium">
              <div className="mapping-section">
                <h4 style={{ marginBottom: '16px', fontSize: '14px', color: 'var(--text-secondary)' }}>MAPPED TO THE FOLLOWING CHANNELS & PLATFORMS:</h4>
                <div className="mapped-assets-list">
                  {selectedMaster.originalAssets.map((asset, idx) => (
                    <div key={idx} className="mapped-asset-item" style={{ display: 'flex', alignItems: 'center', padding: '12px', background: 'var(--bg-secondary)', borderRadius: '8px', marginBottom: '8px' }}>
                      <span className="material-icons-outlined" style={{ marginRight: '12px', color: 'var(--primary-blue)' }}>link</span>
                      <div className="item-details">
                        <div style={{ fontWeight: 600 }}>{asset.channel}</div>
                        <div style={{ fontSize: '12px', opacity: 0.7 }}>{asset.platform} — {asset.formatName}</div>
                      </div>
                    </div>
                  ))}
                </div>
              </div>
            </div>
            
            <div className="modal-footer-premium">
              <button className="btn-primary-premium" onClick={() => setSelectedMaster(null)}>Close</button>
            </div>
          </div>
        </div>
      )}
    </div>
  );
};
