# Boopa Bagels Business Central Integration 🥯

[![Error Intelligence CI/CD](https://github.com/BoopasBagelDeli/BoopaBagels-BC-Integration/actions/workflows/error-intelligence-cicd.yml/badge.svg)](https://github.com/BoopasBagelDeli/BoopaBagels-BC-Integration/actions/workflows/error-intelligence-cicd.yml)
[![AL-Go CI/CD](https://github.com/BoopasBagelDeli/BoopaBagels-BC-Integration/actions/workflows/CICD.yaml/badge.svg)](https://github.com/BoopasBagelDeli/BoopaBagels-BC-Integration/actions/workflows/CICD.yaml)

Advanced Business Central integration with comprehensive error intelligence, pattern recognition, and automated resolution capabilities.

## 🚀 Features

### Error Intelligence System
- **Pattern Recognition**: Automatically detects recurring error patterns
- **Auto-Resolution**: Applies proven solutions based on historical data
- **Success Rate Tracking**: Monitors resolution effectiveness over time
- **Learning Feedback Loop**: Improves suggestions based on outcomes

### API Testing & Monitoring
- **Comprehensive Test Console**: Real-time API testing with multiple HTTP methods
- **Load Testing**: Configurable concurrent request testing
- **Performance Monitoring**: Response time tracking and analysis
- **Health Dashboards**: Real-time metrics and resolution rates

### Development Workflow
- **AL-Go Integration**: Automated CI/CD with GitHub Actions
- **Code Quality**: Multiple code analyzers (CodeCop, UICop, AppSourceCop)
- **Automated Testing**: Unit tests and performance validation
- **Multi-Environment Support**: Development, staging, and production pipelines

## 📋 Prerequisites

- Business Central 2023 Wave 2 (Platform 23.0+)
- Docker Desktop for local development
- PowerShell 5.1+ with bcContainerHelper module
- GitHub account with Actions enabled
- Azure AD tenant for OAuth 2.0 authentication

## 🛠️ Quick Start

### 1. Clone and Setup
\\\ash
git clone https://github.com/BoopasBagelDeli/BoopaBagels-BC-Integration.git
cd BoopaBagels-BC-Integration
\\\

### 2. Local Development Environment
\\\powershell
# Run the AL-Go local development setup
.\.AL-Go\localDevEnv.ps1

# Or use custom bcContainerHelper setup (from original project)
# Copy from: BoopaBagels-MasterProject\src\BcContainerHelper\BcDevEnvironment.ps1
\\\

### 3. Build and Deploy
\\\powershell
# Manual build using AL-Go scripts
.\.AL-Go\localDevEnv.ps1 -buildAL

# Or trigger GitHub Actions workflow
gh workflow run "Error Intelligence CI/CD" --field runTests=true
\\\

## 🎯 Core Components

### Error Management Tables
- **BoopaBagels Error Log** (Table 50001): Comprehensive error tracking
- **Error Categories** (Enum 50001): 15+ predefined categories including bakery-specific operations

### Intelligence Engine
- **Error Intelligence Codeunit** (50001): Pattern analysis and auto-resolution logic
- **Pattern Detection**: Groups similar errors occurring within configurable timeframes
- **Success Rate Calculation**: Tracks resolution effectiveness by category and operation

### User Interfaces
- **API Test Console** (Page 50001): Real-time API testing and monitoring
- **Error Log List** (Page 50002): Comprehensive error management interface
- **Error Details FactBox**: Contextual error information

### Error Categories
- Authentication & Authorization
- API Errors & Network Timeouts  
- Rate Limiting & Throttling
- Configuration & Validation
- Business Logic & Integration
- **Bakery-Specific**: Production, Inventory, Orders, Recipes

## 🔄 GitHub Actions Workflows

### Standard AL-Go Workflows
- **CICD.yaml**: Main build and deployment pipeline
- **CreateRelease.yaml**: Automated release management
- **IncrementVersionNumber.yaml**: Semantic versioning
- **PullRequestHandler.yaml**: PR validation and testing

### Custom Error Intelligence Workflow
- **error-intelligence-cicd.yml**: Specialized testing for error intelligence features
- Validates pattern recognition algorithms
- Tests auto-resolution capabilities
- Verifies API testing components

## 📊 Monitoring & Analytics

### Real-Time Dashboard Metrics
- Total errors by period
- Auto-resolution success rates
- Pattern detection statistics
- Performance metrics and trends

### Export Capabilities
- JSON format for external monitoring systems
- Power BI integration ready
- Azure Application Insights compatible
- Custom telemetry endpoints

## 🔧 Configuration

### Environment Variables
\\\ash
# For .NET API integration
BC_TENANT=your-tenant-id
BC_CLIENT_ID=your-client-id
BC_CLIENT_SECRET=your-client-secret
BC_ENVIRONMENT=https://your-bc-instance.api.businesscentral.dynamics.com
\\\

### AL-Go Settings
Key settings in \.AL-Go/settings.json\:
- Code analysis rules enabled
- Performance toolkit included
- Symbol loading optimized
- Multi-environment support configured

## 🏗️ Architecture

\\\
┌─────────────────┐    ┌──────────────────┐    ┌─────────────────┐
│   GitHub        │    │   Business       │    │   External      │
│   Actions       │◄──►│   Central        │◄──►│   Systems       │
│   (AL-Go)       │    │   Extension      │    │   (REST API)    │
└─────────────────┘    └──────────────────┘    └─────────────────┘
         │                        │                        │
         ▼                        ▼                        ▼
┌─────────────────┐    ┌──────────────────┐    ┌─────────────────┐
│   Code Quality  │    │   Error Intel    │    │   Monitoring    │
│   Analysis      │    │   Engine         │    │   & Analytics   │
└─────────────────┘    └──────────────────┘    └─────────────────┘
\\\

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (\git checkout -b feature/amazing-feature\)
3. Commit your changes (\git commit -m 'Add amazing feature'\)
4. Push to the branch (\git push origin feature/amazing-feature\)
5. Open a Pull Request

### Development Guidelines
- Follow AL coding standards and best practices
- Include unit tests for new features
- Update documentation for API changes
- Ensure all code analyzers pass
- Test error intelligence scenarios

## 📚 Documentation

- [Error Intelligence Guide](docs/ErrorIntelligence-Guide.md)
- [API Testing Manual](docs/API-Testing-Guide.md)
- [Deployment Instructions](docs/Deployment-Guide.md)
- [Troubleshooting Guide](docs/Troubleshooting.md)

## 🔐 Security

This project implements security best practices:
- OAuth 2.0 with Azure AD integration
- Secure credential management
- API rate limiting awareness
- Comprehensive audit logging
- Privacy-compliant error tracking

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🆘 Support

- 📧 Email: support@boopasbageldeli.com
- 🐛 Issues: [GitHub Issues](https://github.com/BoopasBagelDeli/BoopaBagels-BC-Integration/issues)
- 💬 Discussions: [GitHub Discussions](https://github.com/BoopasBagelDeli/BoopaBagels-BC-Integration/discussions)

## 🎯 Roadmap

- [ ] Machine learning integration for predictive error analysis
- [ ] Power BI dashboard templates
- [ ] Azure Application Insights integration
- [ ] Multi-tenant deployment automation
- [ ] Advanced performance analytics
- [ ] Custom alerting and notifications

---

**Built with ❤️ by the Boopa Bagels team using Microsoft AL-Go for GitHub**
