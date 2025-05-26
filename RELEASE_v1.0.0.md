# Fedora Cleaner v1.0.0 Release Notes

## 🚀 New Features

- **Cross-Distribution Support**: Now works on Fedora, RHEL, CentOS, Debian, Ubuntu, and other Linux distributions
- **Comprehensive Build System**: Added Makefile with installation targets for different distributions
- **GitHub Pages**: Set up a beautiful documentation site
- **CI/CD Pipeline**: Automated testing across multiple Linux distributions
- **Man Page**: Added proper documentation with `man fedora-cleaner` support

## 🛠️ Build & Installation

### Prerequisites
- Bash 4.0 or higher
- Root or sudo access

### Quick Install
```bash
# Download and run
curl -L https://raw.githubusercontent.com/DevOpsTerminal/fedora-cleaner/main/fedora-cleaner.sh -o fedora-cleaner.sh
chmod +x fedora-cleaner.sh
sudo ./fedora-cleaner.sh
```

### From Source
```bash
git clone https://github.com/DevOpsTerminal/fedora-cleaner.git
cd fedora-cleaner
sudo make install
```

## 📦 What's Included

- `fedora-cleaner.sh`: Main script
- `fedora-cleaner.1`: Man page
- `Makefile`: Build and installation
- GitHub Actions workflows for CI/CD
- Documentation in `_pages/`

## 📜 License

Apache License 2.0 - See [LICENSE](LICENSE) for details.

## 🤝 Contributing

Contributions are welcome! Please read our [Contributing Guidelines](CONTRIBUTING.md) to get started.

## 💖 Support

If you find this project useful, please consider supporting its development:
- [GitHub Sponsors](https://github.com/sponsors/DevOpsTerminal)
- [Report Issues](https://github.com/DevOpsTerminal/fedora-cleaner/issues)
