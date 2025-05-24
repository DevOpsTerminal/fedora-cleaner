# 🚀 Fedora Cleaner

**Interactive system cleanup and GPG fix tool for Fedora Linux**

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Bash](https://img.shields.io/badge/Language-Bash-green.svg)](https://www.gnu.org/software/bash/)
[![Fedora](https://img.shields.io/badge/OS-Fedora-blue.svg)](https://getfedora.org/)

## 📖 Overview

Fedora Cleaner is a comprehensive, interactive bash script designed to clean up your Fedora system and fix common GPG signature issues. It provides detailed analysis, step-by-step cleanup plans, and full user control over what gets cleaned.

### ✨ Key Features

- 🔍 **Detailed System Analysis** - Comprehensive scan of cache sizes, log files, and potential cleanup targets
- 🎛️ **Interactive Menu** - Choose exactly what you want to clean
- 📊 **Before/After Reports** - See exactly how much space was freed
- 🔑 **GPG Fix** - Resolves package signature verification issues
- ⚡ **Safe & Reliable** - Careful handling of system files with confirmation prompts
- 📋 **Cleanup Plan** - Prioritized list of cleanup actions with space estimates

## 🎯 What It Cleans

| Category | Description | Typical Space Saved |
|----------|-------------|-------------------|
| **🔑 GPG Issues** | Fixes package signature problems | N/A (Critical) |
| **📦 Package Caches** | DNF, PackageKit, libdnf5 caches | 500MB - 8GB |
| **🌐 Browser Caches** | Firefox, Chrome, Chromium thumbnails | 200MB - 3GB |
| **📰 Log Files** | Old system logs and journal cleanup | 100MB - 1GB |
| **📱 Flatpak** | Unused apps and cache cleanup | 100MB - 2GB |
| **🗑️ Old Kernels** | Removes old kernel versions (keeps 2 latest) | 200MB - 1GB per kernel |
| **🗂️ Temp Files** | Old temporary files from /tmp and /var/tmp | 50MB - 500MB |

## 🚀 Quick Start

### Method 1: Direct Download & Run
```bash
# Download the script
wget https://raw.githubusercontent.com/DevOpsTerminal/fedora-cleaner/main/fedora-cleaner.sh

# Make it executable
chmod +x fedora-cleaner.sh

# Run it
./fedora-cleaner.sh
```

### Method 2: Clone Repository
```bash
# Clone the repository
git clone https://github.com/DevOpsTerminal/fedora-cleaner.git

# Navigate to directory
cd fedora-cleaner

# Make script executable
chmod +x fedora-cleaner.sh

# Run the script
./fedora-cleaner.sh
```

### Method 3: One-liner
```bash
curl -fsSL https://raw.githubusercontent.com/DevOpsTerminal/fedora-cleaner/main/fedora-cleaner.sh | bash
```

## 📊 Sample Output

```
==================================================
  🚀 Fedora Interactive Cleanup & GPG Fix v3.0
==================================================

🔐 Checking sudo access...
✅ Sudo access confirmed

=== DETAILED SYSTEM ANALYSIS ===

📊 Current Disk Usage:
  /dev/nvme0n1p7  147G  144G  2.6G  99% /

📦 Package Cache Analysis:
  → DNF cache: 1.2G (1,847 RPM files)
  → PackageKit cache: 7.2G (3,291 RPM files)
  → LibDNF5 cache: 44K

🗂️ Temporary Files Analysis:
  → System /tmp: 52K (12 files)
  → User cache total: 5.6G
  → Firefox cache: 2.1G
  → Chrome cache: 800M

📋 CLEANUP PLAN:

1. [critical] Fix GPG signature issues
   💾 Space: No space saved

2. [high] Clean package caches
   💾 Space: 1.2G + 7.2G + 44K

3. [medium] Clean browser caches
   💾 Space: firefox:2.1G chrome:800M

=== INTERACTIVE CLEANUP MENU ===
Choose what you want to do:

1. 🔑 Fix GPG signature issues (RECOMMENDED FIRST)
2. 📦 Clean package caches
3. 🌐 Clean browser caches
...
```

## 🔧 Usage Examples

### Fix GPG Issues Only
If you're having package installation problems:
```bash
./fedora-cleaner.sh
# Choose option 1: Fix GPG signature issues
```

### Full System Cleanup
For maximum space recovery:
```bash
./fedora-cleaner.sh
# Choose option 8: Execute ALL cleanup steps
```

### Custom Cleanup
Pick and choose what to clean:
```bash
./fedora-cleaner.sh
# Use menu options 1-7 to select specific cleanup tasks
```

## 🛡️ Safety Features

- **✅ Sudo Verification** - Checks for proper permissions upfront
- **✅ Confirmation Prompts** - Asks before potentially destructive operations
- **✅ Detailed Analysis** - Shows exactly what will be cleaned before acting
- **✅ Kernel Protection** - Always keeps the 2 most recent kernels
- **✅ User Data Safety** - Only cleans cache files, never personal data
- **✅ Graceful Errors** - Continues operation even if individual steps fail

## 📋 Requirements

- **OS**: Fedora Linux (any recent version)
- **Shell**: Bash 4.0+
- **Permissions**: Sudo access required
- **Dependencies**: Standard Fedora utilities (dnf, rpm, find, du)

## 🐛 Troubleshooting

### Common Issues

**Script hangs during repository refresh:**
```bash
# The script includes timeouts and will automatically recover
# If stuck, press Ctrl+C and try running individual steps
```

**Permission denied errors:**
```bash
# Ensure you have sudo access
sudo -v

# Make sure script is executable
chmod +x fedora-cleaner.sh
```

**GPG signature still failing after fix:**
```bash
# Try manual Chrome installation
wget https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm
sudo dnf install ./google-chrome-stable_current_x86_64.rpm
```

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

### Development Setup
```bash
git clone https://github.com/DevOpsTerminal/fedora-cleaner.git
cd fedora-cleaner
```

### Adding New Features
- Follow the existing code style
- Add appropriate error handling
- Include user confirmations for potentially destructive operations
- Update the README with new features

## 📜 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Fedora community for the excellent documentation
- Contributors who helped test and improve the script
- Users who reported issues and suggested improvements

## 📞 Support

- 🐛 **Bug Reports**: [GitHub Issues](https://github.com/DevOpsTerminal/fedora-cleaner/issues)
- 💡 **Feature Requests**: [GitHub Discussions](https://github.com/DevOpsTerminal/fedora-cleaner/discussions)
- 📧 **Questions**: Open an issue with the "question" label

## 🎯 Roadmap

- [ ] Support for other RPM-based distributions (RHEL, CentOS)
- [ ] Configuration file support
- [ ] Automated scheduling options
- [ ] Web-based interface
- [ ] Plugin system for custom cleanup modules

---

**⭐ If this tool helped you, please give it a star on GitHub!**

Made with ❤️ for the Fedora community
