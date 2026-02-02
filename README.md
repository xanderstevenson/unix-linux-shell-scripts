# unix-linux-shell-scripts
Complex and robust shell scripts that complete common tasks performed by Unix and Linux system administrators.

## Project Overview

This project is a comprehensive Linux Shell Scripting Toolkit designed to demonstrate system administration, automation, and environment customization using Bash. The project focuses on user and group management, package installation, system maintenance, networking diagnostics, disk cleanup, and file archiving, following best practices for scripting, validation, and verification.

All scripts are written to be reusable, executable from any directory, and compliant with Linux system administration standards. The project also includes demonstrations and verification steps to validate correct execution as required by the rubric.

## Project Objectives
The goals of this project are to:

- Automate user and group management

- Customize the shell environment

- Manage software packages

- Diagnose network connectivity

- Monitor and clean disk space

- Archive and compress system files using multiple algorithms

- Demonstrate scripting concepts such as functions, loops, conditionals, variables, and error handling

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

3.Switching to the new user and forcing a password change


### B. User Deletion Script (delete_user.sh)

- Accepts a username as a command-line argument

- Validates input and prompts for deletion confirmation

- Deletes the user and their home directory

-Displays /etc/passwd to verify user deletion


Demonstrates:

1. Running without arguments

2. Running with valid arguments

3.Attempting to switch to the deleted user to confirm removal


### C. Shell Environment Customization

- Customizes the shell prompt using escape sequences and color formatting

- Implements command aliases stored in a separate aliases file

- Adds shortcuts for: ls -lrt, ls -a, and clear

- Navigation to common directories (Desktop, Downloads, Documents)

- Updates ~/.bashrc to:

    - Create a ~/bin directory

    - Move create_user.sh and delete_user.sh into bin

    - Update the PATH variable to allow execution from any directory

- Verifies all changes from the command line


### D. Package Management Scripts

- Script to install Vim, printing a message if it is already installed

- Script to update all system packages using the Linux package manager

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

- Bash (Shell Scripting)

- Linux system utilities (useradd, userdel, groupadd, df, tar, ping, nslookup)

-Package managers (apt, yum, or equivalent)


### Conclusion

This project demonstrates practical Linux system administration skills through well-structured shell scripts. It emphasizes automation, validation, modular scripting, and real-world administrative tasks, making it suitable for academic evaluation and real-world Linux environments.