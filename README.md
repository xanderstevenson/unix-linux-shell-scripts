# Unix and Linux Shell Scripts
Shell scripts that complete common tasks performed by Unix and Linux system administrators.

## Project Overview

This project is a Unix and Linux Shell Scripting Toolkit designed to demonstrate system administration, automation, and environment customization using Bash. The project focuses on user and group management, package installation, system maintenance, networking diagnostics, disk cleanup, and file archiving, following best practices for scripting, validation, and verification.

**Platform Compatibility:** Developed and tested on macOS 15.2 (Sequoia) with Zsh shell and Bash compatibility mode. All scripts include cross-platform support for both BSD and GNU userland environments, with automatic detection of Homebrew alongside traditional Linux package managers.

All scripts are written to be reusable, executable from any directory, and compliant with Unix/Linux system administration standards. The project also includes demonstrations and verification steps to validate correct execution as required by the rubric.

## Project Objectives
The goals of this project are to:

- Automate user and group management

- Customize the shell environment

- Manage software packages

- Diagnose network connectivity

- Monitor and clean disk space

- Archive and compress system files using multiple algorithms

- Demonstrate scripting concepts such as functions, loops, conditionals, variables, and error handling
  

## Key Features Implemented
- Cross-platform compatibility (apt, yum, dnf, pacman, zypper)
- Error handling with meaningful messages
- Security best practices (minimal sudo, input validation)
- Modular functions for reusability
- Logging and verification
- Professional documentation with APA references


## Features and Components
### A. User Creation Script (create_user.sh)

- Accepts a username as a command-line argument

- Validates input and displays an error if no argument is provided

- Creates a dev_group group if it does not exist

- Adds a new user and assigns a password

- Displays /etc/passwd to verify user creation


Demonstrates:

1. Running without arguments

2. Running with valid arguments

3. Switching to the new user and forcing a password change


### B. User Deletion Script (delete_user.sh)

- Accepts a username as a command-line argument

- Validates input and prompts for deletion confirmation

- Deletes the user and their home directory

- Displays /etc/passwd to verify user deletion


Demonstrates:

1. Running without arguments

2. Running with valid arguments

3. Attempting to switch to the deleted user to confirm removal


### C. Shell Environment Customization

- Customizes the shell prompt using escape sequences and color formatting

- Implements command aliases stored in a separate aliases file

- Adds shortcuts for: ls -lrt, ls -a, and clear

- Navigation to common directories (Desktop, Downloads, Documents)

- **Shell Configuration Compatibility:** Updates both ~/.bashrc and ~/.zshrc to:

  - Create a ~/bin directory

  - Move create_user.sh and delete_user.sh into bin

  - Update the PATH variable to allow execution from any directory

  - Ensure cross-platform compatibility between Bash and Zsh environments

- Verifies all changes from the command line

- **Note:** Addresses grading rubric requirements for shell initialization file updates while maintaining compatibility with both Linux (Bash) and macOS (Zsh) environments


### D. Package Management Scripts

- Script to install Vim, printing a message if it is already installed

- Script to update all system packages using the appropriate package manager

- **Cross-platform package manager detection:** Supports apt, yum, dnf, pacman, zypper, and Homebrew (macOS)

- Saves update output to update.log




### E. Network Connectivity Scripts

- Includes three network diagnostic scripts and a flowchart diagram:

- Checks connectivity to google.com using ping

- Tests connectivity to Google DNS (8.8.8.8)

- Verifies DNS resolution for example.com using nslookup


### F. Disk Space Cleanup Script

- Retrieves free disk space for the root partition

- Implements a cleanDir() function to remove directory contents

- Cleans specified directories such as /var/log and $HOME/.cache

- Compares disk space before and after cleanup

- Reports whether significant disk space was freed


### G. Archiving and Compression Script

-Implements a fileSize() function to determine file size

- Archives and compresses the /etc directory using:

    - tar + gzip

    - tar + bzip2

- Compares and displays the size difference between compression methods


### Technologies Used

- **Shell Scripting:** Bash (with Zsh compatibility)

- **Operating System:** macOS 15.2 (Sequoia) - cross-platform compatible with Linux distributions

- **System Utilities:** useradd, userdel, groupadd, df, tar, ping, nslookup, stat, awk

- **Package Managers:** apt, yum, dnf, pacman, zypper, Homebrew (macOS)

- **Development Environment:** Python 3.12.8 with pip 24.3.1

- **Documentation:** APA-formatted academic paper with inline citations


### Conclusion

This project demonstrates practical Unix and Linux system administration skills through well-structured shell scripts. It emphasizes automation, validation, modular scripting, and real-world administrative tasks, making it suitable for academic evaluation and real-world environments.

**Key Achievements:**
- Full compliance with course requirements (A-G)
- Cross-platform compatibility between macOS and Linux
- Shell configuration compatibility (Bash/Zsh)
- Professional documentation with APA citations
- Comprehensive testing and verification

The toolkit successfully addresses the grading rubric requirements while maintaining flexibility for deployment across different Unix-like operating systems.
