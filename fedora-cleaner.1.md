% FEDORA-CLEANER(1) | Fedora Cleaner Manual
% Tom Sapletta <tom@sapletta.com>
% $(date +'%Y-%m-%d')

# NAME

fedora-cleaner - Interactive system cleanup and GPG fix tool for Linux distributions

# SYNOPSIS

**fedora-cleaner** [*OPTIONS*]

# DESCRIPTION

**fedora-cleaner** is a comprehensive, interactive bash script designed to clean up your Linux system and fix common GPG signature issues. It provides detailed analysis, step-by-step cleanup plans, and full user control over what gets cleaned.

# OPTIONS

`-h, --help`
:   Show this help message and exit

`-v, --version`
:   Show version information and exit

`--auto`
:   Run in non-interactive mode (use with caution)

`--dry-run`
:   Show what would be done without making changes

`--fix-gpg`
:   Only fix GPG key issues

`--clean-cache`
:   Only clean package cache

# EXAMPLES

Run interactively:

    fedora-cleaner

Fix only GPG issues:

    fedora-cleaner --fix-gpg

Run in non-interactive mode (use with caution):

    fedora-cleaner --auto

# FILES

*/var/log/fedora-cleaner.log*
:   Log file containing operation details

# BUGS

Report bugs at https://github.com/DevOpsTerminal/fedora-cleaner/issues

# AUTHOR

Tom Sapletta <tom@sapletta.com>

# SEE ALSO

**dnf**(8), **apt**(8), **yum**(8), **zypper**(8)
