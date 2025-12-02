#!/bin/bash
# Script untuk memindahkan portfolio ke path tanpa Unicode (Linux/macOS)
# Usage: bash migrate.sh

echo ""
echo "============================================"
echo "Portfolio Project Migration Script"
echo "============================================"
echo ""
echo "This script will help move your project to a path without Unicode characters"
echo ""

read -p "Enter target path (e.g., ~/Projects/portfolio-main): " target

# Expand ~ to home directory
target="${target/#\~/$HOME}"

if [ -d "$target" ]; then
    echo "Error: Target directory already exists!"
    exit 1
fi

echo ""
echo "Creating target directory..."
mkdir -p "$target"

echo "Copying files..."
cp -r . "$target"

if [ $? -eq 0 ]; then
    echo ""
    echo "============================================"
    echo "Migration successful!"
    echo ""
    echo "Next steps:"
    echo "1. Navigate to: $target"
    echo "2. Run: npm install"
    echo "3. Run: npm run build"
    echo "4. Run: npm run dev"
    echo ""
    echo "Then you can delete the old folder"
    echo "============================================"
else
    echo "Error occurred during copy!"
    exit 1
fi
