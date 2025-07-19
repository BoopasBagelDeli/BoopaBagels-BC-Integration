# 🥯 Boopa Bagels Error Intelligence Extension

## Overview
This AL extension provides comprehensive error intelligence capabilities for Business Central, specifically designed for bakery operations. It includes pattern recognition, auto-resolution, and advanced API testing features.

## Features

### 🔍 Error Intelligence System
- **Smart Error Logging**: Comprehensive error tracking with 20+ fields
- **Pattern Recognition**: Automatically identifies recurring error patterns
- **Auto-Resolution**: Implements known solutions for common issues
- **Success Rate Tracking**: Monitors resolution effectiveness
- **Learning Feedback Loop**: Improves over time through usage data

### 🚀 API Testing Console
- **Real-time API Testing**: Test REST endpoints directly from Business Central
- **Load Testing**: Performance monitoring and stress testing
- **Multi-HTTP Methods**: Support for GET, POST, PUT, DELETE, PATCH
- **Authentication Testing**: OAuth 2.0 and basic authentication support
- **Performance Metrics**: Response times, success rates, error analysis

### 📊 Customer Integration
- **Enhanced Customer Card**: Added Boopa Bagels specific functionality
- **Quick Actions**: Direct access to error intelligence console
- **Hello World Demo**: Simple demonstration of extension capabilities

## Object Range
- **Tables**: 50001-50010
- **Pages**: 50001-50010  
- **Codeunits**: 50001-50010
- **Enums**: 50001-50010
- **Page Extensions**: 50001-50010

## Installation

### Prerequisites
- Business Central 18.0 or later
- AL Development Environment
- AL-Go for GitHub (for automated CI/CD)

### Development Setup
1. Clone this repository
2. Open in VS Code with AL Language extension
3. Configure launch.json for your Business Central environment
4. Build and deploy using AL-Go workflows

### Manual Installation
1. Download the .app file from releases
2. Install via Business Central Extension Management
3. Enable the extension for your tenant

## Usage

### Error Intelligence Console
1. Search for "API Test Console" in Business Central
2. Use the console to test API endpoints
3. View error patterns and resolutions
4. Monitor performance metrics

### Customer Card Integration
1. Open any Customer Card
2. Navigate to the "Boopa Bagels" action group
3. Test Hello World functionality
4. Access Error Intelligence Console directly

## Development

### Building
```powershell
# Using AL-Go (recommended)
git push origin main  # Triggers automated build

# Manual build
Al: Package (Ctrl+Shift+P)
```

### Testing
- Unit tests are included in the test folders
- Use AL Test Tool for automated testing
- Load testing available through API Console

### Contributing
1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Submit a pull request
5. AL-Go will automatically test your changes

## Architecture

### Tables
- **Boopa Bagels Error Log (50001)**: Main error tracking table with comprehensive fields

### Codeunits  
- **Error Intelligence (50001)**: Core error processing and pattern recognition
- **Hello World (50002)**: Simple demonstration codeunit

### Pages
- **API Test Console (50001)**: Main testing interface
- **Error Log List (50002)**: Error management interface

### Page Extensions
- **Customer Card Extension (50001)**: Enhanced customer functionality

## AL-Go Integration

This extension is fully integrated with AL-Go for GitHub, providing:
- ✅ Automated builds on every commit
- ✅ Continuous integration testing
- ✅ Multi-environment deployment
- ✅ Code quality analysis
- ✅ Automated release management

## Support

- **Documentation**: Available in this repository
- **Issues**: Report via GitHub Issues
- **Discussions**: Use GitHub Discussions for questions
- **Wiki**: Additional documentation in the repository wiki

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgments

- Built with AL-Go for GitHub
- Powered by Business Central 18.0
- Designed for modern bakery operations

---

**Made with ❤️ by Boopa Bagels Inc** 🥯
