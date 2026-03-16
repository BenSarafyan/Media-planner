import React from 'react';
import { getFlagUrl } from '../utils/marketUtils';

interface Market {
  code: string;
  name: string;
}

const AVAILABLE_MARKETS: Market[] = [
  { code: 'FR', name: 'France' },
  { code: 'DE', name: 'Germany' },
  { code: 'ES', name: 'Spain' },
  { code: 'IT', name: 'Italy' },
  { code: 'UK', name: 'United Kingdom' },
  { code: 'NL', name: 'Netherlands' },
  { code: 'BE', name: 'Belgium' },
  { code: 'SE', name: 'Sweden' },
  { code: 'PL', name: 'Poland' },
  { code: 'PT', name: 'Portugal' },
  { code: 'IE', name: 'Ireland' },
  { code: 'AT', name: 'Austria' },
  { code: 'CH', name: 'Switzerland' },
  { code: 'NO', name: 'Norway' },
  { code: 'DK', name: 'Denmark' },
  { code: 'FI', name: 'Finland' },
];

interface MarketSelectionModalProps {
  isOpen: boolean;
  onClose: () => void;
  selectedMarkets: Market[];
  onToggleMarket: (market: Market) => void;
}

export const MarketSelectionModal: React.FC<MarketSelectionModalProps> = ({
  isOpen,
  onClose,
  selectedMarkets,
  onToggleMarket,
}) => {
  if (!isOpen) return null;

  return (
    <div className="modal-overlay">
      <div className="modal-content premium-card">
        <div className="modal-header">
          <h2>Select Markets</h2>
          <button className="close-btn" onClick={onClose}>&times;</button>
        </div>
        <div className="market-picker-grid">
          {AVAILABLE_MARKETS.map((market) => {
            const isSelected = selectedMarkets.some((m) => m.code === market.code);
            return (
              <div
                key={market.code}
                className={`market-picker-item ${isSelected ? 'selected' : ''}`}
                onClick={() => onToggleMarket(market)}
              >
                <div className="market-flag">
                  <img src={getFlagUrl(market.code, 80)} alt={market.name} />
                </div>
                <div className="market-info">
                  <span className="market-name">{market.name}</span>
                </div>
              </div>
            );
          })}
        </div>
        <div className="modal-footer">
          <button className="btn btn-primary" onClick={onClose}>Done</button>
        </div>
      </div>
    </div>
  );
};
