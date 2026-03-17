interface WelcomeBannerProps {
  onStartSetup: () => void;
}

export const WelcomeBanner = ({ onStartSetup }: WelcomeBannerProps) => {
  return (
    <div className="dashboard-view">
      <div className="welcome-banner">
        <h2>Welcome back, Barbara</h2>
        <p>Ready to plan your next digital campaign?</p>
        <button 
          className="btn-primary"
          onClick={onStartSetup}
        >
          <span className="material-icons-outlined">psychology</span>
          Start New Campaign
        </button>
      </div>
    </div>
  );
};
