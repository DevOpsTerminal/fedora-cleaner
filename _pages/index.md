---
layout: default
title: Fedora Cleaner
---

# Fedora Cleaner

**Interactive system cleanup and GPG fix tool for Linux distributions**

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
[![CI](https://github.com/DevOpsTerminal/fedora-cleaner/actions/workflows/ci.yml/badge.svg)](https://github.com/DevOpsTerminal/fedora-cleaner/actions)
[![GitHub release](https://img.shields.io/github/release/DevOpsTerminal/fedora-cleaner.svg)](https://github.com/DevOpsTerminal/fedora-cleaner/releases)

## 📖 Overview

Fedora Cleaner is a comprehensive, interactive bash script designed to clean up your Linux system and fix common GPG signature issues. It provides detailed analysis, step-by-step cleanup plans, and full user control over what gets cleaned.

## ✨ Features

- 🔍 **Detailed System Analysis** - Comprehensive scan of cache sizes, log files, and potential cleanup targets
- 🎛️ **Interactive Menu** - Choose exactly what you want to clean
- 📊 **Before/After Reports** - See exactly how much space was freed
- 🔑 **GPG Fix** - Resolves package signature verification issues
- 🐧 **Multi-Distro Support** - Works on Fedora, RHEL, CentOS, Debian, Ubuntu, and more
- ⚡ **Safe & Reliable** - Careful handling of system files with confirmation prompts

## 🚀 Quick Start

### Prerequisites

- Bash 4.0 or higher
- Root or sudo access
- Basic Linux command line knowledge

### Installation

```bash
# Download the script
curl -L https://raw.githubusercontent.com/DevOpsTerminal/fedora-cleaner/main/fedora-cleaner.sh -o fedora-cleaner.sh

# Make it executable
chmod +x fedora-cleaner.sh

# Run it (requires root)
sudo ./fedora-cleaner.sh
```

Or install using your package manager:

```bash
# For Fedora/RHEL/CentOS
sudo dnf install fedora-cleaner

# For Debian/Ubuntu
sudo apt install fedora-cleaner

# For Arch Linux
yay -S fedora-cleaner  # or use your preferred AUR helper
```

## 📚 Documentation

For detailed documentation, please visit the [GitHub repository](https://github.com/DevOpsTerminal/fedora-cleaner).

## 💖 Support

If you find this project useful, please consider supporting its development:

- [GitHub Sponsors](https://github.com/sponsors/DevOpsTerminal)
- [Report Issues](https://github.com/DevOpsTerminal/fedora-cleaner/issues)
- [Contribute](https://github.com/DevOpsTerminal/fedora-cleaner/pulls)

## 📄 License

This project is licensed under the Apache License 2.0 - see the [LICENSE](LICENSE) file for details.

## 👥 Authors

- **Tom Sapletta** - [tom.sapletta.com](https://tom.sapletta.com)

## 🤝 Contributing

Contributions are welcome! Please read our [contributing guidelines](CONTRIBUTING.md) to get started.
