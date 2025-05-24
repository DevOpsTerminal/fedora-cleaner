#!/bin/bash

# Fedora Interactive Cleanup and GPG Fix Script
# Detailed plan with step-by-step confirmation
# Author: Tom Sapletta
# Version: 3.0

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m' # No Color

# Function to print colored output
print_title() {
    echo -e "\n${BOLD}${CYAN}=== $1 ===${NC}"
}

print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

print_details() {
    echo -e "${CYAN}  → $1${NC}"
}

# Function to ask for confirmation
ask_confirmation() {
    local message="$1"
    local default="${2:-n}"
    
    if [ "$default" = "y" ]; then
        echo -e "${YELLOW}$message [Y/n]:${NC} "
    else
        echo -e "${YELLOW}$message [y/N]:${NC} "
    fi
    
    read -r response
    case "$response" in
        [yY][eE][sS]|[yY]) return 0 ;;
        [nN][oO]|[nN]) return 1 ;;
        "") [ "$default" = "y" ] && return 0 || return 1 ;;
        *) echo "Please answer yes or no."; ask_confirmation "$message" "$default" ;;
    esac
}

# Function to calculate directory size
calculate_size() {
    local path="$1"
    if [ -d "$path" ]; then
        du -sh "$path" 2>/dev/null | cut -f1 || echo "0B"
    elif [ -f "$path" ]; then
        du -sh "$path" 2>/dev/null | cut -f1 || echo "0B"
    else
        echo "0B"
    fi
}

# Function to count files in directory
count_files() {
    local path="$1"
    local pattern="${2:-*}"
    if [ -d "$path" ]; then
        find "$path" -name "$pattern" -type f 2>/dev/null | wc -l
    else
        echo "0"
    fi
}

# Function to show detailed analysis
show_detailed_analysis() {
    print_title "DETAILED SYSTEM ANALYSIS"
    
    echo -e "${BOLD}📊 Current Disk Usage:${NC}"
    df -h | grep -E '^/dev' | while read line; do
        echo "  $line"
    done
    echo
    
    echo -e "${BOLD}📦 Package Cache Analysis:${NC}"
    local dnf_size=$(calculate_size "/var/cache/dnf")
    local dnf_rpms=$(count_files "/var/cache/dnf" "*.rpm")
    print_details "DNF cache: $dnf_size ($dnf_rpms RPM files)"
    
    local pk_size=$(calculate_size "/var/cache/PackageKit")
    local pk_rpms=$(count_files "/var/cache/PackageKit" "*.rpm")
    print_details "PackageKit cache: $pk_size ($pk_rpms RPM files)"
    
    local libdnf5_size=$(calculate_size "/var/cache/libdnf5")
    print_details "LibDNF5 cache: $libdnf5_size"
    
    if [ -d "/var/cache/yum" ]; then
        local yum_size=$(calculate_size "/var/cache/yum")
        print_details "YUM cache: $yum_size"
    fi
    echo
    
    echo -e "${BOLD}🗂️  Temporary Files Analysis:${NC}"
    local tmp_size=$(calculate_size "/tmp")
    local tmp_files=$(count_files "/tmp")
    print_details "System /tmp: $tmp_size ($tmp_files files)"
    
    local var_tmp_size=$(calculate_size "/var/tmp")
    local var_tmp_files=$(count_files "/var/tmp")
    print_details "System /var/tmp: $var_tmp_size ($var_tmp_files files)"
    
    local user_cache_size=$(calculate_size "$HOME/.cache")
    print_details "User cache total: $user_cache_size"
    
    # Browser caches
    local browser_caches=(
        "thumbnails:$HOME/.cache/thumbnails"
        "Firefox:$HOME/.cache/mozilla"
        "Chrome:$HOME/.cache/google-chrome"
        "Chromium:$HOME/.cache/chromium"
    )
    
    for cache_info in "${browser_caches[@]}"; do
        local cache_name="${cache_info%%:*}"
        local cache_path="${cache_info##*:}"
        if [ -d "$cache_path" ]; then
            local cache_size=$(calculate_size "$cache_path")
            print_details "$cache_name cache: $cache_size"
        fi
    done
    echo
    
    echo -e "${BOLD}📰 Log Files Analysis:${NC}"
    local log_size=$(calculate_size "/var/log")
    print_details "Total log directory: $log_size"
    
    # Journal analysis
    local journal_info=$(sudo journalctl --disk-usage 2>/dev/null | grep "Archived and active journals take up" | cut -d' ' -f6-7 || echo "unknown size")
    print_details "Systemd journal: $journal_info"
    
    # Old log files
    local old_logs=$(sudo find /var/log -name "*.log.*" -o -name "*.gz" -o -name "*.bz2" -o -name "*.xz" -type f -mtime +30 2>/dev/null | wc -l)
    print_details "Old compressed logs (>30 days): $old_logs files"
    echo
    
    echo -e "${BOLD}📱 Flatpak Analysis:${NC}"
    if command -v flatpak >/dev/null 2>&1; then
        local flatpak_user_size=$(calculate_size "$HOME/.var/app")
        print_details "Flatpak user data: $flatpak_user_size"
        
        local flatpak_system_size=$(calculate_size "/var/lib/flatpak")
        print_details "Flatpak system data: $flatpak_system_size"
        
        # Count Flatpak apps
        local user_apps=$(flatpak list --user 2>/dev/null | wc -l || echo "0")
        local system_apps=$(flatpak list --system 2>/dev/null | wc -l || echo "0")
        print_details "Installed apps: $user_apps user, $system_apps system"
        
        # Check for unused apps
        local unused_apps=$(flatpak uninstall --unused --assumeyes --dry-run 2>/dev/null | grep -c "^[[:space:]]*[0-9]" || echo "0")
        if [ "$unused_apps" -gt 0 ]; then
            print_details "Unused apps found: $unused_apps (can be removed)"
        fi
    else
        print_details "Flatpak not installed"
    fi
    echo
    
    echo -e "${BOLD}🔧 Kernel Analysis:${NC}"
    local kernel_count=$(rpm -qa kernel | wc -l)
    print_details "Installed kernels: $kernel_count"
    
    if [ "$kernel_count" -gt 0 ]; then
        echo "  Currently installed kernels:"
        rpm -qa kernel --queryformat "    %{NAME}-%{VERSION}-%{RELEASE}.%{ARCH} (%{INSTALLTIME:date})\n" | sort -V
        
        if [ "$kernel_count" -gt 2 ]; then
            local old_kernels=$((kernel_count - 2))
            print_details "Old kernels to remove: $old_kernels (keeping latest 2)"
        fi
    fi
    echo
    
    echo -e "${BOLD}🔑 GPG Keys Analysis:${NC}"
    local gpg_keys=$(rpm -qa gpg-pubkey | wc -l)
    print_details "Installed GPG keys: $gpg_keys"
    
    # Check for problematic repositories
    print_details "Checking repository status..."
    local failed_repos=$(sudo dnf repolist --disabled 2>/dev/null | grep -c "disabled" || echo "0")
    print_details "Disabled repositories: $failed_repos"
    echo
}

# Function to create cleanup plan
create_cleanup_plan() {
    print_title "CLEANUP PLAN GENERATOR"
    
    echo -e "${BOLD}Based on the analysis, here's what can be cleaned:${NC}\n"
    
    # Calculate potential savings
    local total_savings=0
    local cleanup_items=()
    
    # Package caches
    local cache_size=$(calculate_size "/var/cache/dnf")
    cache_size+=" + "$(calculate_size "/var/cache/PackageKit")
    cache_size+=" + "$(calculate_size "/var/cache/libdnf5")
    cleanup_items+=("PACKAGE_CACHES:Clean package caches:$cache_size:high")
    
    # Browser caches
    local browser_total=0
    local browser_caches=(
        "$HOME/.cache/thumbnails"
        "$HOME/.cache/mozilla"
        "$HOME/.cache/google-chrome"
        "$HOME/.cache/chromium"
    )
    local browser_size_info=""
    for cache_dir in "${browser_caches[@]}"; do
        if [ -d "$cache_dir" ]; then
            local size=$(calculate_size "$cache_dir")
            browser_size_info+="$(basename "$cache_dir"):$size "
        fi
    done
    cleanup_items+=("BROWSER_CACHES:Clean browser caches:$browser_size_info:medium")
    
    # Log files
    local log_size=$(calculate_size "/var/log")
    cleanup_items+=("LOG_FILES:Clean old log files:$log_size potential:medium")
    
    # Flatpak
    if command -v flatpak >/dev/null 2>&1; then
        local flatpak_size=$(calculate_size "$HOME/.var/app")
        local unused_apps=$(flatpak uninstall --unused --assumeyes --dry-run 2>/dev/null | grep -c "^[[:space:]]*[0-9]" || echo "0")
        cleanup_items+=("FLATPAK:Clean Flatpak ($unused_apps unused apps):$flatpak_size:medium")
    fi
    
    # Old kernels
    local kernel_count=$(rpm -qa kernel | wc -l)
    if [ "$kernel_count" -gt 2 ]; then
        local old_kernels=$((kernel_count - 2))
        cleanup_items+=("OLD_KERNELS:Remove old kernels ($old_kernels):~200MB each:high")
    fi
    
    # Temporary files
    local tmp_size=$(calculate_size "/tmp")
    tmp_size+=" + "$(calculate_size "/var/tmp")
    cleanup_items+=("TEMP_FILES:Clean temporary files:$tmp_size:low")
    
    # GPG fix
    cleanup_items+=("GPG_FIX:Fix GPG signature issues:No space saved:critical")
    
    # Display plan
    echo -e "${BOLD}📋 CLEANUP PLAN:${NC}\n"
    local item_num=1
    for item in "${cleanup_items[@]}"; do
        local id="${item%%:*}"
        local rest="${item#*:}"
        local description="${rest%%:*}"
        local rest2="${rest#*:}"
        local size="${rest2%%:*}"
        local priority="${rest2##*:}"
        
        local priority_color=""
        case "$priority" in
            critical) priority_color="${RED}" ;;
            high) priority_color="${YELLOW}" ;;
            medium) priority_color="${CYAN}" ;;
            low) priority_color="${NC}" ;;
        esac
        
        echo -e "$item_num. ${priority_color}[$priority]${NC} $description"
        echo -e "   💾 Space: $size"
        echo
        ((item_num++))
    done
    
    # Store plan for later use
    printf '%s\n' "${cleanup_items[@]}" > /tmp/cleanup_plan.txt
}

# Function to execute cleanup step
execute_cleanup_step() {
    local step_id="$1"
    local description="$2"
    
    print_title "EXECUTING: $description"
    
    case "$step_id" in
        "GPG_FIX")
            print_status "Fixing GPG signature issues..."
            
            print_details "Removing old GPG keys..."
            sudo rpm -e gpg-pubkey --allmatches 2>/dev/null || true
            
            print_details "Importing Google Chrome GPG key..."
            if ! sudo rpm --import https://dl.google.com/linux/linux_signing_key.pub 2>/dev/null; then
                print_warning "HTTPS failed, trying HTTP..."
                sudo rpm --import http://dl.google.com/linux/linux_signing_key.pub 2>/dev/null || true
            fi
            
            print_details "Importing Fedora GPG keys..."
            sudo rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-fedora-* 2>/dev/null || true
            
            print_details "Refreshing repository metadata..."
            sudo dnf clean metadata >/dev/null 2>&1
            sudo dnf makecache --refresh >/dev/null 2>&1 || {
                print_warning "Full refresh failed, trying basic update..."
                sudo dnf check-update >/dev/null 2>&1 || true
            }
            ;;
            
        "PACKAGE_CACHES")
            print_status "Cleaning package caches..."
            
            local dnf_before=$(calculate_size "/var/cache/dnf")
            local pk_before=$(calculate_size "/var/cache/PackageKit")
            
            print_details "DNF cache before: $dnf_before"
            print_details "PackageKit cache before: $pk_before"
            
            print_details "Cleaning DNF cache..."
            sudo dnf clean all >/dev/null 2>&1
            
            print_details "Cleaning PackageKit cache..."
            sudo rm -rf /var/cache/PackageKit/* 2>/dev/null || true
            
            print_details "Cleaning libdnf5 cache..."
            sudo rm -rf /var/cache/libdnf5/* 2>/dev/null || true
            
            if [ -d "/var/cache/yum" ]; then
                print_details "Cleaning YUM cache..."
                sudo rm -rf /var/cache/yum/* 2>/dev/null || true
            fi
            
            local dnf_after=$(calculate_size "/var/cache/dnf")
            local pk_after=$(calculate_size "/var/cache/PackageKit")
            print_success "DNF cache after: $dnf_after"
            print_success "PackageKit cache after: $pk_after"
            ;;
            
        "BROWSER_CACHES")
            print_status "Cleaning browser caches..."
            
            local browser_caches=(
                "thumbnails:$HOME/.cache/thumbnails"
                "Mozilla:$HOME/.cache/mozilla"
                "Chrome:$HOME/.cache/google-chrome"
                "Chromium:$HOME/.cache/chromium"
                "Firefox:$HOME/.cache/firefox"
            )
            
            for cache_info in "${browser_caches[@]}"; do
                local cache_name="${cache_info%%:*}"
                local cache_path="${cache_info##*:}"
                if [ -d "$cache_path" ]; then
                    local cache_size=$(calculate_size "$cache_path")
                    print_details "Cleaning $cache_name cache ($cache_size)..."
                    rm -rf "$cache_path" 2>/dev/null || true
                fi
            done
            ;;
            
        "LOG_FILES")
            print_status "Cleaning log files..."
            
            local journal_before=$(sudo journalctl --disk-usage 2>/dev/null | grep -o '[0-9.]*[KMGT]B' | tail -1 || echo "unknown")
            print_details "Journal size before: $journal_before"
            
            print_details "Cleaning journal logs (keeping 30 days)..."
            sudo journalctl --vacuum-time=30d >/dev/null 2>&1 || true
            
            local journal_after=$(sudo journalctl --disk-usage 2>/dev/null | grep -o '[0-9.]*[KMGT]B' | tail -1 || echo "unknown")
            print_details "Journal size after: $journal_after"
            
            local old_logs=$(sudo find /var/log -name "*.log.*" -o -name "*.gz" -o -name "*.bz2" -o -name "*.xz" -type f -mtime +30 2>/dev/null | wc -l)
            if [ "$old_logs" -gt 0 ]; then
                print_details "Removing $old_logs old compressed log files..."
                sudo find /var/log -name "*.log.*" -o -name "*.gz" -o -name "*.bz2" -o -name "*.xz" -type f -mtime +30 -delete 2>/dev/null || true
            fi
            ;;
            
        "FLATPAK")
            if command -v flatpak >/dev/null 2>&1; then
                print_status "Cleaning Flatpak..."
                
                local unused_apps=$(flatpak uninstall --unused --assumeyes --dry-run 2>/dev/null | grep -c "^[[:space:]]*[0-9]" || echo "0")
                if [ "$unused_apps" -gt 0 ]; then
                    print_details "Removing $unused_apps unused Flatpak applications..."
                    flatpak uninstall --unused -y >/dev/null 2>&1 || true
                fi
                
                print_details "Cleaning Flatpak caches..."
                find "$HOME/.var/app" -name cache -type d -exec rm -rf {} + 2>/dev/null || true
                
                print_details "Repairing Flatpak installation..."
                sudo flatpak repair --system >/dev/null 2>&1 || true
            fi
            ;;
            
        "OLD_KERNELS")
            print_status "Removing old kernels..."
            
            local kernel_count=$(rpm -qa kernel | wc -l)
            if [ "$kernel_count" -gt 2 ]; then
                print_details "Current kernels:"
                rpm -qa kernel --queryformat "  %{NAME}-%{VERSION}-%{RELEASE}.%{ARCH}\n" | sort -V
                
                print_details "Removing old kernels (keeping latest 2)..."
                sudo dnf remove -y $(dnf repoquery --installonly --latest-limit=-2 -q) >/dev/null 2>&1 || true
                
                local remaining=$(rpm -qa kernel | wc -l)
                print_success "Kernels remaining: $remaining"
            fi
            ;;
            
        "TEMP_FILES")
            print_status "Cleaning temporary files..."
            
            print_details "Cleaning /tmp (files older than 7 days)..."
            local tmp_files=$(sudo find /tmp -type f -atime +7 2>/dev/null | wc -l)
            if [ "$tmp_files" -gt 0 ]; then
                print_details "Removing $tmp_files old files from /tmp..."
                sudo find /tmp -type f -atime +7 -delete 2>/dev/null || true
            fi
            
            print_details "Cleaning /var/tmp (files older than 7 days)..."
            local var_tmp_files=$(sudo find /var/tmp -type f -atime +7 2>/dev/null | wc -l)
            if [ "$var_tmp_files" -gt 0 ]; then
                print_details "Removing $var_tmp_files old files from /var/tmp..."
                sudo find /var/tmp -type f -atime +7 -delete 2>/dev/null || true
            fi
            ;;
    esac
    
    print_success "Step completed: $description"
}

# Main interactive menu
main() {
    echo "=================================================="
    echo "  🚀 Fedora Interactive Cleanup & GPG Fix v3.0"
    echo "=================================================="
    echo
    
    # Check sudo access
    print_status "🔐 Checking sudo access..."
    if ! sudo -n true 2>/dev/null; then
        print_status "Please enter your password:"
        sudo -v
        if [ $? -ne 0 ]; then
            print_error "Sudo access required. Exiting."
            exit 1
        fi
    fi
    print_success "Sudo access confirmed"
    echo
    
    # Show analysis
    show_detailed_analysis
    
    # Create cleanup plan
    create_cleanup_plan
    
    # Interactive menu
    while true; do
        print_title "INTERACTIVE CLEANUP MENU"
        echo "Choose what you want to do:"
        echo
        echo "1. 🔑 Fix GPG signature issues (RECOMMENDED FIRST)"
        echo "2. 📦 Clean package caches"
        echo "3. 🌐 Clean browser caches"
        echo "4. 📰 Clean log files"
        echo "5. 📱 Clean Flatpak"
        echo "6. 🗑️  Remove old kernels"
        echo "7. 🗂️  Clean temporary files"
        echo "8. 🚀 Execute ALL cleanup steps"
        echo "9. 📊 Show disk usage summary"
        echo "0. ❌ Exit"
        echo
        echo -n "Enter your choice [1-9, 0 to exit]: "
        read -r choice
        
        case $choice in
            1) execute_cleanup_step "GPG_FIX" "Fix GPG signature issues" ;;
            2) execute_cleanup_step "PACKAGE_CACHES" "Clean package caches" ;;
            3) execute_cleanup_step "BROWSER_CACHES" "Clean browser caches" ;;
            4) execute_cleanup_step "LOG_FILES" "Clean log files" ;;
            5) execute_cleanup_step "FLATPAK" "Clean Flatpak" ;;
            6) execute_cleanup_step "OLD_KERNELS" "Remove old kernels" ;;
            7) execute_cleanup_step "TEMP_FILES" "Clean temporary files" ;;
            8) 
                if ask_confirmation "Execute ALL cleanup steps?" "n"; then
                    execute_cleanup_step "GPG_FIX" "Fix GPG signature issues"
                    execute_cleanup_step "PACKAGE_CACHES" "Clean package caches"
                    execute_cleanup_step "BROWSER_CACHES" "Clean browser caches"
                    execute_cleanup_step "LOG_FILES" "Clean log files"
                    execute_cleanup_step "FLATPAK" "Clean Flatpak"
                    execute_cleanup_step "OLD_KERNELS" "Remove old kernels"
                    execute_cleanup_step "TEMP_FILES" "Clean temporary files"
                    print_success "🎉 All cleanup steps completed!"
                fi
                ;;
            9)
                print_title "CURRENT DISK USAGE"
                df -h | grep -E '^/dev'
                ;;
            0)
                print_status "👋 Goodbye!"
                exit 0
                ;;
            *)
                print_error "Invalid choice. Please try again."
                ;;
        esac
        
        echo
        echo "Press Enter to continue..."
        read -r
    done
}

# Run main function
main "$@"
