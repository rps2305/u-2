#!/bin/bash
# U-2 Spyplane Website - Batch Image Conversion Script
# Uses sips (built-in macOS) and cwebp (Homebrew)
# Based on: https://www.gumlet.com/learn/how-to-batch-convert-images-using-macos-terminal/

set -e

echo "🛩️  U-2 Image Conversion Script"
echo "================================"
echo ""

# Check dependencies
if ! command -v cwebp &> /dev/null; then
    echo "❌ cwebp not found. Install with: brew install webp"
    exit 1
fi

# Create output directories
mkdir -p hero/webp gallery/webp thumb

# Convert hero images
echo "📁 Converting hero images..."
for img in hero/*.jpg hero/*.jpeg hero/*.png hero/*.JPG hero/*.JPEG; do
    if [ -f "$img" ]; then
        filename=$(basename "$img" | sed 's/\.[^.]*$//')
        echo "  Converting: $img → hero/webp/${filename}.webp"
        cwebp -q 85 "$img" -o "hero/webp/${filename}.webp"
    fi
done

# Convert gallery images  
echo ""
echo "📁 Converting gallery images..."
for img in gallery/*.jpg gallery/*.jpeg gallery/*.png gallery/*.JPG gallery/*.JPEG; do
    if [ -f "$img" ]; then
        filename=$(basename "$img" | sed 's/\.[^.]*$//')
        echo "  Converting: $img → gallery/webp/${filename}.webp"
        cwebp -q 80 "$img" -o "gallery/webp/${filename}.webp"
    fi
done

# Generate thumbnails (400px width)
echo ""
echo "📁 Generating thumbnails (400px)..."
for img in hero/*.webp gallery/*.webp; do
    if [ -f "$img" ]; then
        filename=$(basename "$img" | sed 's/\.[^.]*$//')
        echo "  Creating: thumb/${filename}-thumb.webp"
        cwebp -q 75 -resize 400 0 "$img" -o "thumb/${filename}-thumb.webp"
    fi
done

echo ""
echo "✅ Conversion complete!"
echo ""
echo "Summary:"
ls -lh hero/webp/ 2>/dev/null | tail -5 || echo "  No hero images"
ls -lh gallery/webp/ 2>/dev/null | tail -5 || echo "  No gallery images"
ls -lh thumb/ 2>/dev/null | tail -5 || echo "  No thumbnails"
