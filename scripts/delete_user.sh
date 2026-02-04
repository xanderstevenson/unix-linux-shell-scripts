#!/bin/bash
# delete_user.sh - Deletes a user and their home directory
# Author: Alexander Stevenson

# Function to display usage information
usage() {
    echo "Usage: $0 <username>"
    echo "Deletes a user and their home directory"
    exit 1
}

# Check if username argument is provided
if [ $# -eq 0 ]; then
    echo "Error: No username provided."
    usage
fi

USERNAME=$1

# Check if user exists
if ! id "$USERNAME" &>/dev/null; then
    echo "Error: User '$USERNAME' does not exist."
    exit 1
fi

# Display user information before deletion
echo -e "\n=== User Information Before Deletion ==="
echo "Displaying /etc/passwd entry for '$USERNAME':"
grep "^$USERNAME:" /etc/passwd || echo "User not found in /etc/passwd"

echo -e "\nHome directory:"
eval echo "~$USERNAME" 2>/dev/null || echo "Home directory not found"

# Ask for confirmation
echo -e "\n=== Confirmation Required ==="
echo "You are about to delete user '$USERNAME' and their home directory."
echo "This action cannot be undone."
read -p "Are you sure you want to continue? (yes/no): " confirm

if [[ "$confirm" != "yes" ]]; then
    echo "User deletion cancelled."
    exit 0
fi

# Delete the user and home directory
echo "Deleting user '$USERNAME' and home directory..."
sudo userdel -r "$USERNAME"

if [ $? -eq 0 ]; then
    echo "User '$USERNAME' deleted successfully."
    
    # Verify deletion
    echo -e "\n=== User Deletion Verification ==="
    echo "Displaying /etc/passwd to verify user deletion:"
    if grep "^$USERNAME:" /etc/passwd &>/dev/null; then
        echo "Warning: User still found in /etc/passwd"
    else
        echo "User '$USERNAME' successfully removed from /etc/passwd"
    fi
    
    echo -e "\nAttempting to switch to deleted user (should fail):"
    if su - "$USERNAME" -c "whoami" 2>/dev/null; then
        echo "Warning: User account still accessible"
    else
        echo "Confirmation: User '$USERNAME' is no longer accessible"
    fi
    
    echo -e "\nUser deletion completed successfully!"
    
else
    echo "Error: Failed to delete user '$USERNAME'."
    exit 1
fi
