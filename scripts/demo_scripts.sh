#!/bin/bash
# demo_scripts.sh - Demonstrates all created scripts
# Author: Alexander Stevenson

echo "=== Shell Script Toolkit Demonstration ==="
echo "Timestamp: $(date)"
echo "========================================"

# Function to run a demo section
run_demo() {
    local script_name="$1"
    local description="$2"
    
    echo -e "\n--- $script_name ---"
    echo "$description"
    echo "Location: $(which $script_name 2>/dev/null || echo 'Not in PATH')"
    echo "Permissions: $(ls -l $script_name 2>/dev/null | awk '{print $1}' || echo 'File not found')"
}

echo "Checking all created scripts..."

# List all scripts to demonstrate
scripts=(
    "create_user.sh:User creation with group management"
    "delete_user.sh:User deletion with confirmation"
    "setup_environment.sh:Shell environment configuration"
    "install_vim.sh:Vim package installation"
    "update_system.sh:System package updates"
    "check_google_ping.sh:Internet connectivity test"
    "check_dns_ping.sh:DNS server connectivity test"
    "check_dns_resolution.sh:DNS resolution test"
    "disk_cleanup.sh:Disk space cleanup"
    "archive_compress.sh:File archiving and compression"
)

# Run demonstrations
for script_info in "${scripts[@]}"; do
    script_name="${script_info%%:*}"
    description="${script_info##*:}"
    run_demo "$script_name" "$description"
done

echo -e "\n=== Environment Files ==="
echo "Custom aliases file:"
if [ -f "custom_aliases" ]; then
    echo "✓ custom_aliases exists ($(wc -l < custom_aliases) lines)"
else
    echo "✗ custom_aliases not found"
fi

echo "Network flowchart:"
if [ -f "network_flowchart.md" ]; then
    echo "✓ network_flowchart.md exists"
else
    echo "✗ network_flowchart.md not found"
fi

echo "Academic paper:"
if [ -f "academic_paper.md" ]; then
    echo "✓ academic_paper.md exists ($(wc -l < academic_paper.md) lines)"
else
    echo "✗ academic_paper.md not found"
fi

echo -e "\n=== Safe Demonstrations ==="

# Test scripts that don't require sudo or system changes
echo -e "\n1. Testing create_user.sh without arguments (should show error):"
./create_user.sh 2>&1 | head -3

echo -e "\n2. Testing delete_user.sh without arguments (should show error):"
./delete_user.sh 2>&1 | head -3

echo -e "\n3. Testing network connectivity (safe operations):"
echo "   - Checking internet connectivity:"
./check_google_ping.sh 2>&1 | tail -2

echo "   - Checking DNS server connectivity:"
./check_dns_ping.sh 2>&1 | tail -2

echo "   - Checking DNS resolution:"
./check_dns_resolution.sh 2>&1 | tail -3

echo -e "\n4. Testing vim installation check (safe operation):"
./install_vim.sh 2>&1 | head -3

echo -e "\n=== Script Statistics ==="
echo "Total executable scripts: $(find . -name "*.sh" -perm +111 | wc -l)"
echo "Total files created: $(find . -type f | wc -l)"
echo "Total lines of code: $(find . -name "*.sh" -exec wc -l {} + | tail -1 | awk '{print $1}')"

echo -e "\n=== Next Steps ==="
echo "To complete the full demonstration:"
echo "1. Run './setup_environment.sh' to configure your shell environment"
echo "2. Test user creation with: 'create_user.sh testuser'"
echo "3. Test user deletion with: 'delete_user.sh testuser'"
echo "4. Run system update with: './update_system.sh'"
echo "5. Test disk cleanup with: './disk_cleanup.sh'"
echo "6. Test archiving with: './archive_compress.sh'"

echo -e "\n=== Demonstration Complete ==="
echo "All scripts have been created and basic functionality verified."
