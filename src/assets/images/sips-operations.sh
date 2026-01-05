#!/bin/bash
# U-2 Spyplane Website - sips Image Operations
# Uses sips (built-in macOS) for basic image operations
# Reference: https://www.gumlet.com/learn/how-to-batch-convert-images-using-macos-terminal/

set -e

echo "🛩️  U-2 Image Operations with sips"
echo "=================================="
echo ""

# Create directories
mkdir -p resized converted

# === BATCH OPERATIONS USING sips ===

# 1. Resize all images to max 1200px width (maintains aspect ratio)
echo "📐 Resizing images to max 1200px width..."
echo "   Command: for i in *.jpg; do sips -Z 1200 \$i --out resized/\$i; done"
for img in hero/*.jpg gallery/*.jpg 2>/dev/null; do
    if [ -f "$img" ]; then
        filename=$(basename "$img")
        echo "  Resizing: $img → resized/$filename"
        sips -Z 1200 "$img" --out "resized/$filename"
    fi
done

# 2. Convert to different format
echo ""
echo "🔄 Converting to PNG format..."
echo "   Command: for i in *.jpg; do sips -s format png \$i --out converted/\$i.png; done"
for img in resized/*.jpg 2>/dev/null; do
    if [ -f "$img" ]; then
        filename=$(basename "$img" | sed 's/\.[^.]*$//')
        echo "  Converting: $img → converted/${filename}.png"
        sips -s format png "$img" --out "converted/${filename}.png"
    fi
done

# 3. Get image info
echo ""
echo "📊 Image information:"
for img in hero/*.jpg gallery/*.jpg 2>/dev/null | head -3; do
    if [ -f "$img" ]; then
        echo "  $(basename $img):"
        sips -g pixelHeight -g pixelWidth "$img" 2>/dev/null | sed 's/^/    /'
    fi
done

echo ""
echo "✅ sips operations complete!"
echo ""
echo "Alternative sips commands:"
echo "  # Resize height to 800px:"
echo "  sips -z 800 0 image.jpg"
echo ""
echo "  # Rotate image 90 degrees clockwise:"
echo "sips -r 90 image.jpg"
echo ""
echo "  # Flip horizontally:"
echo "sips -f h image.jpg"
echo ""
echo "  # Convert to JPEG at 80% quality:"
echo "sips -s format jpeg -s formatOptions 80 image.png --out image.jpg"
