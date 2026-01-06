# Quick Start Guide: Image WebP Optimization

**Feature**: 001-image-webp-optimization
**Date**: 2026-01-05

## Overview

This guide provides step-by-step instructions for optimizing images in the U-2 spy plane website. The optimization process involves three main steps:

1. **Convert images to WebP format** (improves load time, reduces bandwidth)
2. **Add meaningful alt-text** (accessibility compliance)
3. **Add dimension attributes** (prevents layout shifts, improves CLS)

## Prerequisites

- Node.js 18+ installed
- Project dependencies installed: `npm install`
- Images located in `assets/images/` directory
- HTML files located in `frontend/src/` directory

## Quick Start (5 Minutes)

### Step 1: Convert Images to WebP

```bash
# Preview what will be converted (dry run)
node scripts/convert-to-webp.js --source ./assets/images --dry-run --verbose

# Actually convert images
node scripts/convert-to-webp.js --source ./assets/images --quality 85
```

**Expected Output**:

- Creates `.webp` files alongside originals
- Reports conversion statistics (files converted, size reduction)
- Typical size reduction: 25-35%

### Step 2: Audit Alt-Text

```bash
# Run alt-text audit
node scripts/audit-alt-text.js --source ./frontend/src

# View audit results
cat alt-text-audit.json
```

**Expected Output**:

- Scans all HTML files for `<img>` tags
- Identifies missing alt-text (errors)
- Flags problematic alt-text (warnings)
- Identifies decorative images (info)

### Step 3: Add Image Dimensions

```bash
# Preview what will be added (dry run)
node scripts/extract-dimensions.js --source ./assets/images --html-dir ./frontend/src --dry-run

# Add dimensions to HTML files
node scripts/extract-dimensions.js --source ./assets/images --html-dir ./frontend/src --attribute both
```

**Expected Output**:

- Extracts width/height from image metadata
- Adds width, height, and aspect-ratio attributes to `<img>` tags
- Creates backup files (.html.backup)
- Reports number of files updated

## Detailed Workflow

### Phase 1: Image Conversion

**Purpose**: Reduce file size and improve load times

```bash
# Full conversion with custom settings
node scripts/convert-to-webp.js \
  --source ./assets/images \
  --quality 85 \
  --skip-svg \
  --preserve-original \
  --verbose
```

**Parameters**:

- `--source`: Directory with original images
- `--quality`: WebP quality (0-100, default: 80, higher = better quality but larger files)
- `--skip-svg`: Keep SVG files unchanged (recommended)
- `--preserve-original`: Keep original files alongside WebP versions
- `--verbose`: Detailed output for debugging

**After Conversion**:

- Original files: `photo.jpg`, `image.png`, `logo.gif`
- WebP files: `photo.webp`, `image.webp`, `logo.webp`
- SVG files: `icon.svg` (unchanged)

**Verification**:

```bash
# Check that WebP files exist
ls -la assets/images/*.webp

# Compare file sizes
ls -lh assets/images/photo.jpg assets/images/photo.webp
```

### Phase 2: Alt-Text Assignment

**Purpose**: Ensure accessibility compliance

**2a. Run Audit**

```bash
# Initial audit
node scripts/audit-alt-text.js --source ./frontend/src
```

**2b. Review Findings**

Open `alt-text-audit.json` to review findings:

- **Errors**: Missing alt-text (must fix)
- **Warnings**: Poor alt-text (should fix)
- **Info**: Decorative images (review and confirm)

**2c. Fix Issues Manually**

Open each HTML file and add/fix alt-text:

```html
<!-- Before -->
<img src="/assets/images/hero.jpg" />

<!-- After -->
<img
  src="/assets/images/hero.jpg"
  alt="U-2 spy plane in flight over desert landscape at sunset"
  width="1920"
  height="1080"
/>
```

**Alt-Text Best Practices**:

- Be descriptive: "U-2 spy plane in flight" ✓
- Not a filename: "photo1.jpg" ✗
- Not redundant: "Image of a spy plane" ✗
- Decorative images: Use alt=""
- Include all visible text in image

**2d. Re-run Audit**

```bash
# Verify all issues are fixed
node scripts/audit-alt-text.js --source ./frontend/src

# Target: 0 errors, 0 warnings
```

### Phase 3: Dimension Attributes

**Purpose**: Prevent layout shifts, improve CLS score

```bash
# Extract dimensions and add to HTML
node scripts/extract-dimensions.js \
  --source ./assets/images \
  --html-dir ./frontend/src \
  --attribute both
```

**Parameters**:

- `--source`: Directory with images
- `--html-dir`: Directory with HTML files
- `--attribute`: Type to add
  - `width-height`: Add width="800" height="600"
  - `aspect-ratio`: Add style="aspect-ratio: 4/3;"
  - `both`: Add both (recommended)
- `--backup`: Create backup files (default: true)

**What Gets Added**:

```html
<!-- Before -->
<img src="/assets/images/hero.jpg" alt="U-2 spy plane in flight" />

<!-- After -->
<img
  src="/assets/images/hero.jpg"
  alt="U-2 spy plane in flight"
  width="1920"
  height="1080"
  style="aspect-ratio: 16/9;"
/>
```

**Verification**:

```bash
# Check that dimensions were added
grep -r 'width=.*height=' frontend/src/

# Review backup files if needed
diff frontend/src/index.html frontend/src/index.html.backup
```

## Testing

### Manual Testing

1. **Open website in browser** and verify:
   - Images load correctly
   - No visible quality loss in WebP images
   - Alt-text appears when hovering (or use browser inspector)
   - Layout doesn't shift as images load

2. **Test with screen reader** (NVDA, JAWS, VoiceOver):
   - Navigate through page
   - Verify all images have descriptions
   - Verify decorative images are skipped

3. **Check WebP browser support**:
   - Test in Chrome, Firefox, Safari, Edge
   - Older browsers may need fallback to original formats

### Automated Testing

```bash
# Run Playwright E2E tests
npm test

# Verify performance metrics
# - Page load time decreased by 20%+
# - CLS score <0.1
# - Bandwidth usage decreased by 25%+
```

## Troubleshooting

### Issue: "No images found"

**Solution**: Check that `--source` path is correct and contains image files

```bash
ls -la ./assets/images
```

### Issue: "Conversion failed for file X"

**Solution**: The file may be corrupted or in an unsupported format. Skip it manually:

```bash
# Check if file is valid
file assets/images/problem-file.jpg

# View conversion errors with verbose mode
node scripts/convert-to-webp.js --verbose
```

### Issue: "Dimensions not extracted"

**Solution**: Image may be corrupted or metadata missing:

```bash
# Check image with Sharp
node -e "const sharp = require('sharp'); sharp('assets/images/problem.webp').metadata().then(console.log).catch(console.error)"
```

### Issue: "Backup file created but changes not applied"

**Solution**: Check file permissions and disk space:

```bash
# Check file permissions
ls -la frontend/src/index.html

# Check disk space
df -h
```

### Issue: "WebP images not loading"

**Solution**: Update HTML to use `<picture>` tag with fallback:

```html
<picture>
  <source srcset="assets/images/photo.webp" type="image/webp" />
  <img
    src="assets/images/photo.jpg"
    alt="Description"
    width="800"
    height="600"
  />
</picture>
```

## Performance Verification

After completing all optimization steps, verify improvements:

### 1. Measure Page Load Time

Use browser DevTools (Network tab):

1. Reload page with empty cache
2. Measure total load time before and after
3. Target: 20%+ improvement

### 2. Measure Bandwidth

Use Network tab:

1. Note total transferred size before and after
2. Target: 25%+ reduction

### 3. Measure CLS Score

Use Lighthouse or Chrome DevTools (Performance tab):

1. Run audit before and after
2. Target: CLS < 0.1

### 4. Accessibility Audit

Use axe DevTools or WAVE:

1. Run accessibility audit
2. Target: 0 alt-text errors

## Script Reference

### convert-to-webp.js

Converts JPEG, PNG, GIF images to WebP format.

**Options**:

- `--source <path>`: Source directory (default: ./assets/images)
- `--quality <number>`: WebP quality 0-100 (default: 80)
- `--skip-svg`: Skip SVG files (default: true)
- `--preserve-original`: Keep originals (default: true)
- `--dry-run`: Preview without converting
- `--verbose`: Detailed output

**Example**:

```bash
node scripts/convert-to-webp.js --source ./assets/images --quality 85
```

### audit-alt-text.js

Scans HTML files for alt-text issues.

**Options**:

- `--source <path>`: Source directory (default: ./frontend/src)
- `--extensions <list>`: File extensions (default: html,htm)
- `--output <file>`: Output file (default: alt-text-audit.json)
- `--check-decorative`: Identify decorative images (default: true)
- `--check-length`: Check alt-text length (default: true)

**Example**:

```bash
node scripts/audit-alt-text.js --source ./frontend/src
```

### extract-dimensions.js

Extracts image dimensions and adds to HTML.

**Options**:

- `--source <path>`: Image directory (default: ./assets/images)
- `--html-dir <path>`: HTML directory (default: ./frontend/src)
- `--attribute <type>`: Type: width-height, aspect-ratio, both (default: both)
- `--dry-run`: Preview without modifying
- `--backup`: Create backups (default: true)

**Example**:

```bash
node scripts/extract-dimensions.js --source ./assets/images --html-dir ./frontend/src --attribute both
```

## Next Steps

After completing image optimization:

1. **Commit changes**:

   ```bash
   git add .
   git commit -m "Optimize images: WebP conversion, alt-text, dimensions"
   ```

2. **Run tests**:

   ```bash
   npm test
   ```

3. **Build and deploy**:

   ```bash
   npm run build
   ```

4. **Monitor performance**:
   - Use analytics to track load times
   - Monitor bandwidth usage
   - Check Core Web Vitals metrics (CLS, LCP, FID)

## Additional Resources

- [WebP format documentation](https://developers.google.com/speed/webp)
- [WCAG 2.1 alt-text guidelines](https://www.w3.org/WAI/WCAG21/Understanding/images.html)
- [Cumulative Layout Shift (CLS)](https://web.dev/cls/)
- [Sharp library documentation](https://sharp.pixelplumbing.com/)

## Support

For issues or questions:

1. Check the troubleshooting section above
2. Review the contracts in `/specs/001-image-webp-optimization/contracts/`
3. Consult the feature specification in `/specs/001-image-webp-optimization/spec.md`
