#!/bin/bash
# setup_environment.sh - Configures shell environment customization
# Author: Alexander Stevenson

echo "=== Shell Environment Setup ==="

# Create ~/bin directory if it doesn't exist
if [ ! -d "$HOME/bin" ]; then
    echo "Creating ~/bin directory..."
    mkdir -p "$HOME/bin"
    echo "✓ ~/bin directory created"
else
    echo "✓ ~/bin directory already exists"
fi

# Move scripts to ~/bin directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
echo "Moving scripts to ~/bin directory..."

if [ -f "$SCRIPT_DIR/create_user.sh" ]; then
    cp "$SCRIPT_DIR/create_user.sh" "$HOME/bin/"
    echo "✓ create_user.sh moved to ~/bin"
else
    echo "⚠ create_user.sh not found"
fi

if [ -f "$SCRIPT_DIR/delete_user.sh" ]; then
    cp "$SCRIPT_DIR/delete_user.sh" "$HOME/bin/"
    echo "✓ delete_user.sh moved to ~/bin"
else
    echo "⚠ delete_user.sh not found"
fi

if [ -f "$SCRIPT_DIR/../custom_aliases" ]; then
    cp "$SCRIPT_DIR/../custom_aliases" "$HOME/bin/"
    echo "✓ custom_aliases moved to ~/bin"
else
    echo "⚠ custom_aliases not found"
fi

# Detect current shell and set appropriate config files
CURRENT_SHELL=$(basename "$SHELL")
BASHRC_FILE="$HOME/.bashrc"
ZSHRC_FILE="$HOME/.zshrc"

echo "Current shell: $CURRENT_SHELL"

# Function to update shell config file
update_shell_config() {
    local config_file="$1"
    local shell_name="$2"
    
    if [ -f "$config_file" ]; then
        cp "$config_file" "$config_file.backup.$(date +%Y%m%d_%H%M%S)"
        echo "✓ Backup of $config_file created"
    fi
    
    # Add custom configuration to shell config
    echo "Adding custom configuration to $config_file..."
    cat >> "$config_file" << 'EOF'

# Custom Shell Environment Configuration
# Added by setup_environment.sh

# Custom prompt with colors
export PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

# Add ~/bin to PATH if not already present
if [[ ":$PATH:" != *":$HOME/bin:"* ]]; then
    export PATH="$HOME/bin:$PATH"
fi

# Source custom aliases if file exists
if [ -f "$HOME/custom_aliases" ]; then
    source "$HOME/custom_aliases"
fi

EOF
    echo "✓ Custom configuration added to $config_file"
}

# Update both .bashrc and .zshrc for compatibility
update_shell_config "$BASHRC_FILE" "bash"
update_shell_config "$ZSHRC_FILE" "zsh"

# Make scripts in ~/bin executable
chmod +x "$HOME/bin/create_user.sh" 2>/dev/null
chmod +x "$HOME/bin/delete_user.sh" 2>/dev/null
echo "✓ Scripts in ~/bin made executable"

echo -e "\n=== Environment Setup Complete ==="
echo "To apply changes:"
if [ "$CURRENT_SHELL" = "zsh" ]; then
    echo "1. Run: source ~/.zshrc"
    echo "2. Or restart your terminal"
else
    echo "1. Run: source ~/.bashrc"
    echo "2. Or restart your terminal"
fi
echo ""
echo "✓ Both ~/.bashrc and ~/.zshrc have been updated for compatibility"
echo "✓ Scripts are now accessible from any directory via ~/bin/"
echo ""
echo "Features added:"
echo "• Custom colored prompt"
echo "• ~/bin added to PATH"
echo "• Command aliases loaded"
echo "• Scripts accessible from any directory"
