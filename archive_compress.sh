#!/bin/bash
# archive_compress.sh - Archives and compresses files with size comparison
# Author: Alexander Stevenson

echo "=== Archive and Compression Script ==="
echo "Timestamp: $(date)"

# Function to get file size in bytes
fileSize() {
    local file_path="$1"
    
    if [ ! -f "$file_path" ]; then
        echo "Error: File '$file_path' does not exist."
        return 1
    fi
    
    # Get file size in bytes
    size_bytes=$(stat -f%z "$file_path" 2>/dev/null || stat -c%s "$file_path" 2>/dev/null)
    
    if [ $? -eq 0 ] && [ -n "$size_bytes" ]; then
        echo "$size_bytes"
        return 0
    else
        echo "Error: Could not determine file size for '$file_path'."
        return 1
    fi
}

# Function to convert bytes to human readable format
bytes_to_human() {
    local bytes=$1
    local units=("B" "KB" "MB" "GB" "TB")
    local unit=0
    
    while [ $bytes -ge 1024 ] && [ $unit -lt 4 ]; do
        bytes=$((bytes / 1024))
        unit=$((unit + 1))
    done
    
    echo "${bytes}${units[$unit]}"
}

# Check if running with appropriate permissions
if [ "$EUID" -ne 0 ]; then
    echo "Warning: This script may require sudo permissions to access /etc directory."
    echo "Some operations might fail without proper permissions."
fi

# Define source directory and output files
SOURCE_DIR="/etc"
GZIP_ARCHIVE="etc_backup.tar.gz"
BZIP2_ARCHIVE="etc_backup.tar.bz2"

echo "Source directory: $SOURCE_DIR"
echo "Output files: $GZIP_ARCHIVE, $BZIP2_ARCHIVE"

# Check if source directory exists
if [ ! -d "$SOURCE_DIR" ]; then
    echo "Error: Source directory '$SOURCE_DIR' does not exist."
    exit 1
fi

echo -e "\n=== Creating Archives ==="

# Create gzip archive
echo "Creating gzip archive: $GZIP_ARCHIVE"
if tar -czf "$GZIP_ARCHIVE" -C "$SOURCE_DIR" . 2>/dev/null; then
    echo "✓ Gzip archive created successfully"
else
    echo "✗ Failed to create gzip archive"
    exit 1
fi

# Create bzip2 archive
echo "Creating bzip2 archive: $BZIP2_ARCHIVE"
if tar -cjf "$BZIP2_ARCHIVE" -C "$SOURCE_DIR" . 2>/dev/null; then
    echo "✓ Bzip2 archive created successfully"
else
    echo "✗ Failed to create bzip2 archive"
    exit 1
fi

echo -e "\n=== Analyzing File Sizes ==="

# Get sizes using fileSize function
gzip_size=$(fileSize "$GZIP_ARCHIVE")
bzip2_size=$(fileSize "$BZIP2_ARCHIVE")

if [ $? -eq 0 ] && [ -n "$gzip_size" ] && [ -n "$bzip2_size" ]; then
    echo "Gzip archive size: $(bytes_to_human $gzip_size) ($gzip_size bytes)"
    echo "Bzip2 archive size: $(bytes_to_human $bzip2_size) ($bzip2_size bytes)"
    
    # Calculate size difference
    if [ "$gzip_size" -gt "$bzip2_size" ]; then
        difference=$((gzip_size - bzip2_size))
        percentage=$(echo "scale=2; ($difference * 100) / $gzip_size" | bc 2>/dev/null || echo "N/A")
        echo -e "\n=== Compression Comparison ==="
        echo "Bzip2 is smaller by: $(bytes_to_human $difference) ($difference bytes)"
        echo "Bzip2 compression improvement: ${percentage}%"
        echo "Winner: Bzip2 (better compression)"
    elif [ "$bzip2_size" -gt "$gzip_size" ]; then
        difference=$((bzip2_size - gzip_size))
        percentage=$(echo "scale=2; ($difference * 100) / $bzip2_size" | bc 2>/dev/null || echo "N/A")
        echo -e "\n=== Compression Comparison ==="
        echo "Gzip is smaller by: $(bytes_to_human $difference) ($difference bytes)"
        echo "Gzip compression improvement: ${percentage}%"
        echo "Winner: Gzip (better compression)"
    else
        echo -e "\n=== Compression Comparison ==="
        echo "Both archives have the same size."
        echo "Winner: Tie"
    fi
else
    echo "Error: Could not retrieve file sizes for comparison."
    exit 1
fi

echo -e "\n=== Archive Information ==="
echo "Files created:"
ls -lh "$GZIP_ARCHIVE" "$BZIP2_ARCHIVE" 2>/dev/null

echo -e "\n=== Cleanup Recommendation ==="
echo "Consider keeping the smaller archive for storage efficiency."
echo "Both archives contain identical content from $SOURCE_DIR"

echo -e "\nArchive and compression completed at $(date)"
