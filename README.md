# 🚀 Fedora Cleaner

**Interactive system cleanup and GPG fix tool for Fedora Linux**

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
[![Bash](https://img.shields.io/badge/Language-Bash-green.svg)](https://www.gnu.org/software/bash/)
[![Fedora](https://img.shields.io/badge/OS-Fedora-blue.svg)](https://getfedora.org/)
[![GitHub Sponsors](https://img.shields.io/badge/Support%20via-GitHub%20Sponsors-ea4aaa.svg)](https://github.com/sponsors/tom-sapletta-com)

## 💖 Support

If you find this project useful, please consider supporting its development. Your support helps ensure the project's continued maintenance and improvement.

### Sponsorship

You can support this project through [GitHub Sponsors](https://github.com/sponsors/tom-sapletta-com). Any level of support is greatly appreciated!

### Other Ways to Contribute

- ⭐ Star the repository
- 🐛 Report bugs by opening an issue
- 💡 Suggest new features or improvements
- 📝 Improve the documentation
- 🔄 Share the project with others

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
=== CLEANUP PLAN GENERATOR ===
Based on the analysis, here's what can be cleaned:

📋 CLEANUP PLAN:

1. [high] Clean package caches
   💾 Space: 99M + 120M + 86M

2. [medium] Clean browser caches
   💾 Space: thumbnails

3. [medium] Clean old log files
   💾 Space: 3.9G potential

4. [medium] Clean Flatpak (0
0 unused apps)
   💾 Space: 8.5G

5. [high] Remove old kernels (1)
   💾 Space: ~200MB each

6. [low] Clean temporary files
   💾 Space: 1.7G + 4.0K

7. [critical] Fix GPG signature issues
   💾 Space: No space saved


=== INTERACTIVE CLEANUP MENU ===
Choose what you want to do:

1. 🔑 Fix GPG signature issues (RECOMMENDED FIRST)
2. 📦 Clean package caches
3. 🌐 Clean browser caches
4. 📰 Clean log files
5. 📱 Clean Flatpak
6. 🗑️  Remove old kernels
7. 🗂️  Clean temporary files
8. 🚀 Execute ALL cleanup steps
9. 📊 Show disk usage summary
0. ❌ Exit

Enter your choice [1-9, 0 to exit]: 8
Execute ALL cleanup steps? [y/N]: 
y

=== EXECUTING: Fix GPG signature issues ===
[INFO] Fixing GPG signature issues...
  → Removing old GPG keys...
  → Importing Google Chrome GPG key...
  → Importing Fedora GPG keys...
  → Refreshing repository metadata...
[SUCCESS] Step completed: Fix GPG signature issues

=== EXECUTING: Clean package caches ===
[INFO] Cleaning package caches...
  → DNF cache before: 99M
  → PackageKit cache before: 120M
  → Cleaning DNF cache...
  → Cleaning PackageKit cache...
  → Cleaning libdnf5 cache...
[SUCCESS] DNF cache after: 99M
[SUCCESS] PackageKit cache after: 0
[SUCCESS] Step completed: Clean package caches

=== EXECUTING: Clean browser caches ===
[INFO] Cleaning browser caches...
  → Cleaning thumbnails cache (24M)...
  → Cleaning Mozilla cache (368M)...
  → Cleaning Chromium cache (49M)...
[SUCCESS] Step completed: Clean browser caches

=== EXECUTING: Clean log files ===
[INFO] Cleaning log files...
  → Journal size before: 
  → Cleaning journal logs (keeping 30 days)...
  → Journal size after: 
  → Removing 29 old compressed log files...
[SUCCESS] Step completed: Clean log files

=== EXECUTING: Clean Flatpak ===
[INFO] Cleaning Flatpak...
./fedora-cleaner.sh: line 401: [: 0
0: integer expression expected
  → Cleaning Flatpak caches...
  → Repairing Flatpak installation...
[SUCCESS] Step completed: Clean Flatpak

=== EXECUTING: Remove old kernels ===
[INFO] Removing old kernels...
  → Current kernels:
  kernel-6.14.4-300.fc42.x86_64
  kernel-6.14.5-300.fc42.x86_64
  kernel-6.14.6-300.fc42.x86_64
  → Removing old kernels (keeping latest 2)...
[SUCCESS] Kernels remaining: 2
[SUCCESS] Step completed: Remove old kernels

=== EXECUTING: Clean temporary files ===
[INFO] Cleaning temporary files...
  → Cleaning /tmp (files older than 7 days)...
  → Cleaning /var/tmp (files older than 7 days)...
  → Removing 1 old files from /var/tmp...
[SUCCESS] Step completed: Clean temporary files
[SUCCESS] 🎉 All cleanup steps completed!

Press Enter to continue...


=== INTERACTIVE CLEANUP MENU ===
Choose what you want to do:

1. 🔑 Fix GPG signature issues (RECOMMENDED FIRST)
2. 📦 Clean package caches
3. 🌐 Clean browser caches
4. 📰 Clean log files
5. 📱 Clean Flatpak
6. 🗑️  Remove old kernels
7. 🗂️  Clean temporary files
8. 🚀 Execute ALL cleanup steps
9. 📊 Show disk usage summary
0. ❌ Exit

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
