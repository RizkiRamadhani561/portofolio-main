#!/bin/bash
# Quick deployment checklist runner

echo "========================================"
echo "Portfolio Deployment Quick Check"
echo "========================================"
echo ""

# Check if we're in the right directory
if [ ! -f "package.json" ]; then
    echo "❌ Error: package.json not found!"
    echo "Make sure you're in the portfolio root directory"
    exit 1
fi

echo "✓ Found package.json"

# Check Node version
node_version=$(node -v)
echo "✓ Node.js version: $node_version"

# Check npm
npm_version=$(npm -v)
echo "✓ npm version: $npm_version"

# Check required files
echo ""
echo "Checking configuration files..."

files=(
    "next.config.ts"
    "tsconfig.json"
    "tailwind.config.js"
    ".env.production"
    ".vercelignore"
)

for file in "${files[@]}"; do
    if [ -f "$file" ]; then
        echo "  ✓ $file"
    else
        echo "  ❌ $file MISSING"
    fi
done

echo ""
echo "Quick Build Test..."
echo "Running: npm run build"
echo ""

if npm run build > /dev/null 2>&1; then
    echo "✅ Build successful!"
    
    # Show build info
    build_size=$(du -sh .next 2>/dev/null | cut -f1)
    echo "  Build size: $build_size"
else
    echo "❌ Build failed!"
    echo "Run 'npm run build' to see detailed errors"
    exit 1
fi

echo ""
echo "========================================"
echo "✅ Project is ready for deployment!"
echo "========================================"
echo ""
echo "Next steps:"
echo "1. Verify path does NOT contain Unicode characters"
echo "2. Run: npm run build (full build test)"
echo "3. Run: npm start (test production server)"
echo "4. Deploy to Vercel: https://vercel.com"
echo ""
