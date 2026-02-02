#!/bin/bash
# create_user.sh - Creates a new user with dev_group assignment
# Author: Alexander Stevenson

# Function to display usage information
usage() {
    echo "Usage: $0 <username>"
    echo "Creates a new user and assigns them to the dev_group"
    exit 1
}

# Check if username argument is provided
if [ $# -eq 0 ]; then
    echo "Error: No username provided."
    usage
fi

USERNAME=$1

# Check if user already exists
if id "$USERNAME" &>/dev/null; then
    echo "Error: User '$USERNAME' already exists."
    exit 1
fi

# Create dev_group if it doesn't exist
if ! getent group dev_group &>/dev/null; then
    echo "Creating dev_group..."
    sudo groupadd dev_group
    if [ $? -eq 0 ]; then
        echo "dev_group created successfully."
    else
        echo "Error: Failed to create dev_group."
        exit 1
    fi
else
    echo "dev_group already exists."
fi

# Create the user and assign to dev_group
echo "Creating user '$USERNAME'..."
sudo useradd -m -g dev_group -s /bin/bash "$USERNAME"

if [ $? -eq 0 ]; then
    echo "User '$USERNAME' created successfully."
    
    # Set a default password and force change on first login
    echo "Setting password for '$USERNAME'..."
    echo "$USERNAME:TempPass123!" | sudo chpasswd
    
    # Force password change on first login
    sudo chage -d 0 "$USERNAME"
    
    echo "Password set. User will be required to change password on first login."
    
    # Display user information
    echo -e "\n=== User Creation Verification ==="
    echo "Displaying /etc/passwd entry for '$USERNAME':"
    grep "^$USERNAME:" /etc/passwd || echo "User not found in /etc/passwd"
    
    echo -e "\nDisplaying group information:"
    groups "$USERNAME" 2>/dev/null || echo "Could not retrieve group information"
    
    echo -e "\nUser creation completed successfully!"
    echo "Login credentials:"
    echo "  Username: $USERNAME"
    echo "  Temporary Password: TempPass123!"
    echo "  Note: User must change password on first login"
    
else
    echo "Error: Failed to create user '$USERNAME'."
    exit 1
fi
