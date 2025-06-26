# Tokenized Treasury Investment Portfolio Management

A comprehensive smart contract system for managing tokenized treasury investment portfolios on the Stacks blockchain using Clarity.

## 🏗️ Architecture

The system consists of five interconnected smart contracts that work together to provide a complete portfolio management solution:

### 1. Portfolio Manager Verification (`portfolio-manager.clar`)
Handles the registration and verification of portfolio managers with role-based access control.

**Key Functions:**
- `register-manager`: Register a new portfolio manager
- `verify-manager`: Verify manager credentials (owner only)
- `is-authorized-manager`: Check manager authorization status
- `get-manager-details`: Retrieve manager information

### 2. Investment Selection (`investment-selection.clar`)
Manages treasury investment opportunities and the approval process.

**Key Functions:**
- `add-investment`: Add new investment opportunity
- `approve-investment`: Approve investment for portfolio inclusion
- `set-investment-category`: Categorize investments
- `get-investment-details`: Retrieve investment information

### 3. Risk Assessment (`risk-assessment.clar`)
Provides risk scoring and evaluation for investments and portfolios.

**Key Functions:**
- `assess-investment-risk`: Calculate risk score for investments
- `set-risk-threshold`: Configure risk tolerance levels
- `update-portfolio-risk`: Update portfolio-wide risk metrics
- `get-investment-risk`: Retrieve risk assessment details

### 4. Performance Tracking (`performance-tracking.clar`)
Tracks portfolio performance metrics and historical data.

**Key Functions:**
- `update-performance`: Record performance data
- `update-portfolio-metrics`: Update portfolio-wide metrics
- `get-performance-record`: Retrieve performance statistics
- `calculate-current-roi`: Calculate return on investment

### 5. Rebalancing Coordination (`rebalancing-coordination.clar`)
Coordinates portfolio rebalancing based on predefined criteria.

**Key Functions:**
- `initiate-rebalancing`: Start rebalancing process
- `set-target-allocation`: Define target asset allocations
- `complete-rebalancing`: Finalize rebalancing session
- `set-rebalancing-rules`: Configure auto-rebalancing rules

## 🚀 Getting Started

### Prerequisites
- Stacks blockchain development environment
- Clarity CLI tools
- Node.js (v16 or higher) for testing
- PostgreSQL (optional, for off-chain analytics)

### Installation

1. **Clone the repository**
   \`\`\`bash
   git clone <repository-url>
   cd treasury-portfolio-management
   \`\`\`

2. **Install dependencies**
   \`\`\`bash
   npm install
   \`\`\`

3. **Run tests**
   \`\`\`bash
   npm test
   \`\`\`

4. **Set up database (optional)**
   \`\`\`bash
   # Run the SQL scripts to create tables and seed data
   psql -d your_database -f scripts/create-tables.sql
   psql -d your_database -f scripts/seed-data.sql
   \`\`\`

### Deployment

Deploy contracts in the following order to ensure proper dependencies:

1. `portfolio-manager.clar`
2. `risk-assessment.clar`
3. `investment-selection.clar`
4. `performance-tracking.clar`
5. `rebalancing-coordination.clar`

\`\`\`bash
# Example deployment using Clarinet
clarinet deploy --network testnet
\`\`\`

## 📊 Usage Examples

### 1. Register as a Portfolio Manager
\`\`\`clarity
(contract-call? .portfolio-manager register-manager
"John Doe"
"Senior Portfolio Manager")
\`\`\`

### 2. Add a New Investment Opportunity
\`\`\`clarity
(contract-call? .investment-selection add-investment
"US Treasury 10Y Bond"
"10-Year Treasury Bond with 2.5% yield"
u1000000
u3650)
\`\`\`

### 3. Assess Investment Risk
\`\`\`clarity
(contract-call? .risk-assessment assess-investment-risk
u1
u1000000
u3650)
\`\`\`

### 4. Track Performance
\`\`\`clarity
(contract-call? .performance-tracking update-performance
u1
u1050000
u1000000)
\`\`\`

### 5. Set Target Allocation
\`\`\`clarity
(contract-call? .rebalancing-coordination set-target-allocation
u1
"Government Bonds"
u60)
\`\`\`

### 6. Initiate Rebalancing
\`\`\`clarity
(contract-call? .rebalancing-coordination initiate-rebalancing u1)
\`\`\`

## 🧪 Testing

The project includes comprehensive tests using Vitest covering all contract functionality:

\`\`\`bash
# Run all tests
npm test

# Run tests in watch mode
npm run test:watch

# Run tests with coverage
npm run test:coverage

# Run specific test file
npm test portfolio-manager.test.js
\`\`\`

### Test Coverage
- ✅ Manager registration and verification
- ✅ Investment selection workflows
- ✅ Risk assessment calculations
- ✅ Performance tracking accuracy
- ✅ Rebalancing logic validation
- ✅ Error handling and edge cases

## 🔒 Security Features

### Access Control
- **Role-based permissions**: Only verified managers can perform critical operations
- **Owner privileges**: Contract deployment address has special verification rights
- **Input validation**: All functions validate inputs and reject invalid data

### Risk Management
- **Automated risk scoring**: Investments are automatically assessed for risk
- **Risk thresholds**: Configurable limits prevent high-risk investments
- **Portfolio-wide limits**: Overall portfolio risk is monitored and controlled

### Data Integrity
- **Immutable records**: All transactions are recorded on-chain
- **Event logging**: Important actions emit events for transparency
- **State consistency**: Cross-contract calls ensure data consistency

## 📈 Key Benefits

### For Portfolio Managers
- **Streamlined Operations**: Automated workflows reduce manual processes
- **Risk Transparency**: Clear risk metrics for all investments
- **Performance Insights**: Real-time performance tracking and analytics
- **Compliance**: Built-in compliance and audit trails

### For Investors
- **Transparency**: All operations recorded on blockchain
- **Professional Management**: Only verified managers can operate portfolios
- **Risk Control**: Automated risk assessment and monitoring
- **Performance Tracking**: Detailed performance metrics and history

### For Organizations
- **Scalability**: Modular design allows for easy expansion
- **Integration**: APIs and events enable third-party integrations
- **Automation**: Reduces operational overhead through smart contracts
- **Compliance**: Built-in regulatory compliance features

## 🏛️ Contract Architecture

### Data Flow
1. **Manager Registration** → Portfolio managers register and get verified
2. **Investment Addition** → Managers add investment opportunities
3. **Risk Assessment** → Automatic risk evaluation before approval
4. **Investment Approval** → Investments are approved based on risk criteria
5. **Performance Tracking** → Continuous monitoring of investment performance
6. **Rebalancing** → Periodic or triggered portfolio rebalancing

### Inter-Contract Dependencies
\`\`\`
portfolio-manager ← investment-selection
← risk-assessment
← performance-tracking
← rebalancing-coordination

risk-assessment ← investment-selection

performance-tracking ← rebalancing-coordination
\`\`\`

## 🔧 Configuration

### Risk Assessment Parameters
- **Risk Threshold**: Maximum acceptable risk score (default: 75/100)
- **Portfolio Risk Limit**: Portfolio-wide risk limit (default: 60/100)
- **Risk Levels**: Low (≤25), Medium (26-50), High (51-75), Very High (>75)

### Rebalancing Parameters
- **Deviation Threshold**: Minimum deviation to trigger rebalancing (default: 5%)
- **Frequency**: Automatic rebalancing frequency in blocks
- **Max Deviation**: Maximum allowed deviation before forced rebalancing

### Performance Metrics
- **ROI Calculation**: (Current Value - Initial Value) / Initial Value × 100
- **Performance Score**: Base score of 50, adjusted by ROI (max 100)
- **Risk-Adjusted Returns**: Performance metrics adjusted for risk levels

## 📊 Database Schema

The system includes SQL scripts for off-chain data storage and analytics:

### Tables
- `portfolio_managers`: Manager registration and verification data
- `investments`: Investment opportunities and details
- `performance_records`: Historical performance data
- `portfolio_metrics`: Portfolio-wide performance metrics
- `rebalancing_sessions`: Rebalancing history and status
- `risk_assessments`: Risk evaluation records

### Analytics Queries
The database enables complex analytics queries for:
- Portfolio performance analysis
- Risk trend analysis
- Manager performance comparison
- Investment category analysis

## 🚀 Roadmap

### Phase 1 (Current)
- ✅ Core contract development
- ✅ Comprehensive testing
- ✅ Basic risk assessment
- ✅ Performance tracking

### Phase 2 (Planned)
- 🔄 Web dashboard interface
- 🔄 Advanced analytics
- 🔄 Mobile application
- 🔄 API development

### Phase 3 (Future)
- 📋 Multi-chain support
- 📋 Advanced DeFi integrations
- 📋 Institutional features
- 📋 Regulatory compliance tools

## 🤝 Contributing

We welcome contributions! Please follow these steps:

1. **Fork the repository**
2. **Create a feature branch**
   \`\`\`bash
   git checkout -b feature/your-feature-name
   \`\`\`
3. **Make your changes**
4. **Add tests for new functionality**
5. **Run the test suite**
   \`\`\`bash
   npm test
   \`\`\`
6. **Submit a pull request**

### Development Guidelines
- Follow Clarity best practices
- Maintain test coverage above 90%
- Document all public functions
- Use descriptive commit messages
- Update README for significant changes

## 📄 License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## 🆘 Support

### Documentation
- [Clarity Language Reference](https://docs.stacks.co/clarity)
- [Stacks Blockchain Documentation](https://docs.stacks.co)

### Community
- [Discord](https://discord.gg/stacks)
- [GitHub Issues](https://github.com/your-repo/issues)
- [Stack Overflow](https://stackoverflow.com/questions/tagged/stacks)

### Professional Support
For enterprise support and custom development:
- Email: support@treasury-portfolio.com
- Website: https://treasury-portfolio.com

## 🏆 Acknowledgments

- Stacks Foundation for blockchain infrastructure
- Clarity language development team
- Open source contributors
- Treasury management industry experts

---

**Built with ❤️ for the decentralized finance ecosystem**
