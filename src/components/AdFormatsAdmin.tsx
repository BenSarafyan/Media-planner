import React, { useState, useEffect } from 'react';
import { adminService, Platform, Inventory, AdFormat } from '../services/adminService';
import './AdFormatsAdmin.css';

export const AdFormatsAdmin: React.FC = () => {
  const [platforms, setPlatforms] = useState<Platform[]>([]);
  const [inventories, setInventories] = useState<Inventory[]>([]);
  const [adFormats, setAdFormats] = useState<AdFormat[]>([]);
  
  const [selectedPlatform, setSelectedPlatform] = useState<string>('');
  const [selectedInventory, setSelectedInventory] = useState<string>('');
  const [loading, setLoading] = useState<boolean>(true);
  const [isAdding, setIsAdding] = useState<boolean>(false);
  const [editingId, setEditingId] = useState<string | null>(null);
  const [formState, setFormState] = useState<Partial<AdFormat>>({
    name: '',
    platform_id: '',
    inventory_id: '',
    funnel_stage: 'Awareness',
    format_type: '',
    aspect_ratio: '',
    dimensions: '',
    file_extension: '',
    file_size: '',
    duration: '',
    requires_video: false
  });

  useEffect(() => {
    loadInitialData();
  }, []);

  useEffect(() => {
    if (selectedPlatform) {
      loadInventories(selectedPlatform);
    } else {
      setInventories([]);
      setSelectedInventory('');
    }
    loadAdFormats();
  }, [selectedPlatform, selectedInventory]);

  const loadInitialData = async () => {
    setLoading(true);
    const platformsData = await adminService.getPlatforms();
    setPlatforms(platformsData);
    await loadAdFormats();
    setLoading(false);
  };

  const loadInventories = async (platformId: string) => {
    const inventoriesData = await adminService.getInventories(platformId);
    setInventories(inventoriesData);
  };

  const loadAdFormats = async () => {
    const formats = await adminService.getAdFormats({
      platformId: selectedPlatform || undefined,
      inventoryId: selectedInventory || undefined
    });
    setAdFormats(formats);
  };

  const handleAddClick = () => {
    setIsAdding(true);
    setEditingId(null);
    setFormState({
      name: '',
      platform_id: selectedPlatform || '',
      inventory_id: selectedInventory || '',
      funnel_stage: 'Awareness',
      format_type: '',
      aspect_ratio: '',
      dimensions: '',
      file_extension: '',
      file_size: '',
      duration: '',
      requires_video: false
    });
  };

  const handleEditClick = (format: AdFormat) => {
    setEditingId(format.id);
    setIsAdding(false);
    setFormState(format);
  };

  const handleDeleteClick = async (id: string) => {
    if (window.confirm('Are you sure you want to delete this ad format?')) {
      const success = await adminService.deleteAdFormat(id);
      if (success) {
        await loadAdFormats();
      }
    }
  };

  const handleCancel = () => {
    setIsAdding(false);
    setEditingId(null);
  };

  const handleSave = async () => {
    if (!formState.name || !formState.platform_id || !formState.inventory_id) {
      alert('Please fill in Name, Platform, and Inventory');
      return;
    }

    if (isAdding) {
      const newFormat = await adminService.createAdFormat(formState as Omit<AdFormat, 'id' | 'platform' | 'inventory'>);
      if (newFormat) {
        setIsAdding(false);
        await loadAdFormats();
      }
    } else if (editingId) {
      const updatedFormat = await adminService.updateAdFormat(editingId, formState as Partial<AdFormat>);
      if (updatedFormat) {
        setEditingId(null);
        await loadAdFormats();
      }
    }
  };

  const handleInputChange = (e: React.ChangeEvent<HTMLInputElement | HTMLSelectElement>) => {
    const { name, value, type } = e.target;
    const val = type === 'checkbox' ? (e.target as HTMLInputElement).checked : value;
    setFormState(prev => ({ ...prev, [name]: val }));
  };

  return (
    <div className="admin-layout">
      <div className="admin-main-content">
        <div className="admin-header">
          <div className="header-content">
            <span className="material-icons-outlined">settings_suggest</span>
            <h2>Ad Formats Directory</h2>
            <button className="btn-primary add-record-btn" onClick={handleAddClick}>
              <span className="material-icons">add</span>
              Add New Record
            </button>
          </div>
          <p className="header-subtitle">View and explore ad formats across your marketing stack</p>
        </div>

        <div className="admin-content-card">
          {loading ? (
            <div className="loading-state">
              <div className="spinner"></div>
              <p>Loading formats...</p>
            </div>
          ) : adFormats.length > 0 ? (
            <div className="table-responsive">
              <table className="admin-table">
                <thead>
                  <tr>
                    <th>Asset Name</th>
                    <th>Platform / Inventory</th>
                    <th>Funnel Stage</th>
                    <th>Asset Type</th>
                    <th>Aspect Ratios</th>
                    <th>Dimensions</th>
                    <th>File Ext</th>
                    <th>Max File Size</th>
                    <th>Lengths/Durations</th>
                    <th className="text-center">Req. Video</th>
                    <th className="text-right">Actions</th>
                  </tr>
                </thead>
                <tbody>
                  {isAdding && (
                    <tr className="inline-form-row">
                      <td>
                        <input 
                          name="name" 
                          value={formState.name} 
                          onChange={handleInputChange} 
                          placeholder="Format Name"
                          className="inline-input"
                        />
                      </td>
                      <td>
                        <div className="inline-select-group">
                          <select 
                            name="platform_id" 
                            value={formState.platform_id} 
                            onChange={(e) => {
                              handleInputChange(e);
                              loadInventories(e.target.value);
                            }}
                            className="inline-select"
                          >
                            <option value="">Select Platform</option>
                            {platforms.map(p => <option key={p.id} value={p.id}>{p.name}</option>)}
                          </select>
                          <select 
                            name="inventory_id" 
                            value={formState.inventory_id} 
                            onChange={handleInputChange}
                            className="inline-select"
                          >
                            <option value="">Select Inventory</option>
                            {inventories.map(i => <option key={i.id} value={i.id}>{i.name}</option>)}
                          </select>
                        </div>
                      </td>
                      <td>
                        <select 
                          name="funnel_stage" 
                          value={formState.funnel_stage} 
                          onChange={handleInputChange}
                          className="inline-select"
                        >
                          <option value="Awareness">Awareness</option>
                          <option value="Consideration">Consideration</option>
                          <option value="Conversion">Conversion</option>
                        </select>
                      </td>
                      <td><input name="format_type" value={formState.format_type} onChange={handleInputChange} className="inline-input" /></td>
                      <td><input name="aspect_ratio" value={formState.aspect_ratio} onChange={handleInputChange} className="inline-input" /></td>
                      <td><input name="dimensions" value={formState.dimensions} onChange={handleInputChange} className="inline-input" /></td>
                      <td><input name="file_extension" value={formState.file_extension} onChange={handleInputChange} className="inline-input" /></td>
                      <td><input name="file_size" value={formState.file_size} onChange={handleInputChange} className="inline-input" /></td>
                      <td><input name="duration" value={formState.duration} onChange={handleInputChange} className="inline-input" /></td>
                      <td className="text-center">
                        <input 
                          type="checkbox" 
                          name="requires_video" 
                          checked={formState.requires_video} 
                          onChange={handleInputChange} 
                        />
                      </td>
                      <td className="text-right Actions-cell">
                        <div className="action-buttons">
                          <button className="btn-icon save-btn" onClick={handleSave} title="Save">
                            <span className="material-icons">check</span>
                          </button>
                          <button className="btn-icon cancel-btn" onClick={handleCancel} title="Cancel">
                            <span className="material-icons">close</span>
                          </button>
                        </div>
                      </td>
                    </tr>
                  )}
                  {adFormats.map((format) => (
                    editingId === format.id ? (
                      <tr key={format.id} className="inline-form-row">
                        <td>
                          <input 
                            name="name" 
                            value={formState.name} 
                            onChange={handleInputChange} 
                            className="inline-input"
                          />
                        </td>
                        <td>
                          <div className="inline-select-group">
                            <select 
                              name="platform_id" 
                              value={formState.platform_id} 
                              onChange={(e) => {
                                handleInputChange(e);
                                loadInventories(e.target.value);
                              }}
                              className="inline-select"
                            >
                              <option value="">Select Platform</option>
                              {platforms.map(p => <option key={p.id} value={p.id}>{p.name}</option>)}
                            </select>
                            <select 
                              name="inventory_id" 
                              value={formState.inventory_id} 
                              onChange={handleInputChange}
                              className="inline-select"
                            >
                              <option value="">Select Inventory</option>
                              {inventories.map(i => <option key={i.id} value={i.id}>{i.name}</option>)}
                            </select>
                          </div>
                        </td>
                        <td>
                          <select 
                            name="funnel_stage" 
                            value={formState.funnel_stage} 
                            onChange={handleInputChange}
                            className="inline-select"
                          >
                            <option value="Awareness">Awareness</option>
                            <option value="Consideration">Consideration</option>
                            <option value="Conversion">Conversion</option>
                          </select>
                        </td>
                        <td><input name="format_type" value={formState.format_type} onChange={handleInputChange} className="inline-input" /></td>
                        <td><input name="aspect_ratio" value={formState.aspect_ratio} onChange={handleInputChange} className="inline-input" /></td>
                        <td><input name="dimensions" value={formState.dimensions} onChange={handleInputChange} className="inline-input" /></td>
                        <td><input name="file_extension" value={formState.file_extension} onChange={handleInputChange} className="inline-input" /></td>
                        <td><input name="file_size" value={formState.file_size} onChange={handleInputChange} className="inline-input" /></td>
                        <td><input name="duration" value={formState.duration} onChange={handleInputChange} className="inline-input" /></td>
                        <td className="text-center">
                          <input 
                            type="checkbox" 
                            name="requires_video" 
                            checked={formState.requires_video} 
                            onChange={handleInputChange} 
                          />
                        </td>
                        <td className="text-right Actions-cell">
                          <div className="action-buttons">
                            <button className="btn-icon save-btn" onClick={handleSave} title="Save">
                              <span className="material-icons">check</span>
                            </button>
                            <button className="btn-icon cancel-btn" onClick={handleCancel} title="Cancel">
                              <span className="material-icons">close</span>
                            </button>
                          </div>
                        </td>
                      </tr>
                    ) : (
                      <tr key={format.id}>
                        <td className="font-bold">{format.name}</td>
                        <td>
                          <div className="platform-inventory-cell">
                            <span className="platform-text">{format.platform?.name}</span>
                            <span className="inventory-text">{format.inventory?.name}</span>
                          </div>
                        </td>
                        <td>
                          <span className={`badge stage-badge stage-${format.funnel_stage.toLowerCase()}`}>
                            {format.funnel_stage}
                          </span>
                        </td>
                        <td>{format.format_type || '—'}</td>
                        <td>
                          {format.aspect_ratio || (format.variants && format.variants.length > 0
                            ? [...new Set(format.variants.map(v => v.aspect_ratio).filter(Boolean))].join(', ')
                            : '—')}
                        </td>
                        <td className="text-sm">{format.dimensions || '—'}</td>
                        <td>{format.file_extension || '—'}</td>
                        <td>{format.file_size || '—'}</td>
                        <td>
                          {format.duration || (format.variants && format.variants.length > 0
                            ? [...new Set(format.variants.map(v => v.duration).filter(Boolean))].join(', ')
                            : '—')}
                        </td>
                        <td className="text-center">
                          <span className={`material-icons-outlined ${format.requires_video ? 'video-required' : 'video-not-required'}`}>
                            {format.requires_video ? 'videocam' : 'image'}
                          </span>
                        </td>
                        <td className="text-right Actions-cell">
                          <div className="action-buttons">
                            <button className="btn-icon edit-btn" onClick={() => handleEditClick(format)} title="Edit">
                              <span className="material-icons">edit</span>
                            </button>
                            <button className="btn-icon delete-btn" onClick={() => handleDeleteClick(format.id)} title="Delete">
                              <span className="material-icons">delete</span>
                            </button>
                          </div>
                        </td>
                      </tr>
                    )
                  ))}
                </tbody>
              </table>

            </div>
          ) : (
            <div className="empty-state">
              <span className="material-icons-outlined">search_off</span>
              <p>No ad formats found for the selected filters.</p>
            </div>
          )}
        </div>
      </div>

      <aside className="admin-sidebar-right">
        <div className="sidebar-header">
          <h3>Filters</h3>
          <button className="btn-text-only" onClick={() => {
            setSelectedPlatform('');
            setSelectedInventory('');
          }}>Reset</button>
        </div>

        <div className="filter-section">
          <div className="section-title">PLATFORMS</div>
          <div className="filter-list">
            <button 
              className={`filter-item ${!selectedPlatform ? 'active' : ''}`}
              onClick={() => {
                setSelectedPlatform('');
                setSelectedInventory('');
              }}
            >
              All Platforms
            </button>
            {platforms.map(p => (
              <button 
                key={p.id} 
                className={`filter-item ${selectedPlatform === p.id ? 'active' : ''}`}
                onClick={() => {
                  setSelectedPlatform(p.id);
                  setSelectedInventory('');
                }}
              >
                {p.name}
              </button>
            ))}
          </div>
        </div>

        {selectedPlatform && (
          <div className="filter-section animate-fade-in">
            <div className="section-title">INVENTORIES</div>
            <div className="filter-list">
              <button 
                className={`filter-item ${!selectedInventory ? 'active' : ''}`}
                onClick={() => setSelectedInventory('')}
              >
                All Inventories
              </button>
              {inventories.map(i => (
                <button 
                  key={i.id} 
                  className={`filter-item ${selectedInventory === i.id ? 'active' : ''}`}
                  onClick={() => setSelectedInventory(i.id)}
                >
                  {i.name}
                </button>
              ))}
            </div>
          </div>
        )}

        <div className="sidebar-footer-stats">
          <div className="stats-row">
            <span>Results</span>
            <span className="stats-value">{adFormats.length}</span>
          </div>
        </div>
      </aside>
    </div>
  );
};
