#!/bin/bash
# disk_cleanup.sh - Assesses and cleans up disk space
# Author: Alexander Stevenson

echo "=== Disk Space Cleanup Script ==="
echo "Timestamp: $(date)"

# Function to convert KB to MB for better readability
kb_to_mb() {
    echo "scale=2; $1 / 1024" | bc
}

# Function to clean directory contents
cleanDir() {
    local target_dir="$1"
    
    if [ ! -d "$target_dir" ]; then
        echo "Warning: Directory '$target_dir' does not exist. Skipping."
        return 1
    fi
    
    echo "Cleaning directory: $target_dir"
    
    # Check if directory is empty
    if [ -z "$(ls -A "$target_dir" 2>/dev/null)" ]; then
        echo "Directory is already empty."
        return 0
    fi
    
    # Get size before cleaning
    size_before=$(du -sk "$target_dir" 2>/dev/null | cut -f1)
    
    # Remove all files and subdirectories (except the directory itself)
    find "$target_dir" -mindepth 1 -delete 2>/dev/null
    
    # Get size after cleaning
    size_after=$(du -sk "$target_dir" 2>/dev/null | cut -f1)
    
    # Calculate freed space
    if [ -n "$size_before" ] && [ -n "$size_after" ]; then
        freed=$((size_before - size_after))
        freed_mb=$(kb_to_mb $freed)
        echo "✓ Cleaned $target_dir - Freed: ${freed_mb} MB"
    else
        echo "✓ Cleaned $target_dir"
    fi
}

# Get initial disk space for root partition
echo "Assessing initial disk space..."
initial_space=$(df / | awk 'NR==2 {print $4}')
initial_kb=$(df -k / | awk 'NR==2 {print $4}')
initial_mb=$(kb_to_mb $initial_kb)

echo "Initial free space: ${initial_mb} MB ($initial_space KB)"

# Define directories to clean
directories_to_clean=(
    "/var/log"
    "$HOME/.cache"
    "/tmp"
    "$HOME/.local/share/Trash/files"
)

echo -e "\n=== Cleaning Directories ==="

# Clean each directory
for dir in "${directories_to_clean[@]}"; do
    # Handle directories that might require sudo
    if [[ "$dir" == "/var/log" || "$dir" == "/tmp" ]]; then
        echo "Note: Cleaning $dir may require sudo privileges"
        # For safety, we'll only clean user-writable contents in system directories
        if [ -w "$dir" ]; then
            cleanDir "$dir"
        else
            echo "Skipping $dir - insufficient permissions"
        fi
    else
        cleanDir "$dir"
    fi
done

# Get final disk space for root partition
echo -e "\n=== Final Assessment ==="
echo "Assessing final disk space..."
final_space=$(df / | awk 'NR==2 {print $4}')
final_kb=$(df -k / | awk 'NR==2 {print $4}')
final_mb=$(kb_to_mb $final_kb)

echo "Final free space: ${final_mb} MB ($final_space KB)"

# Calculate space difference
space_diff=$((final_kb - initial_kb))
space_diff_mb=$(kb_to_mb $space_diff)

echo -e "\n=== Cleanup Results ==="
echo "Space freed: ${space_diff_mb} MB"

if [ "$space_diff" -gt 0 ]; then
    echo "✓ Significant disk space was freed: ${space_diff_mb} MB"
elif [ "$space_diff" -eq 0 ]; then
    echo "No significant disk space was freed"
else
    echo "⚠ Disk space decreased by: ${space_diff_mb} MB (this is unusual)"
fi

echo -e "\nCleanup completed at $(date)"
