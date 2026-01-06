# Image Optimization Scripts

This directory contains utilities for optimizing website images.

## Scripts

### convert-to-webp.js

Converts JPEG, PNG, GIF images to WebP format.

**Usage**:

```bash
node scripts/convert-to-webp.js --source ./assets/images
```

**Options**:

- `--source`: Source directory (default: ./assets/images)
- `--output`: Output directory (default: same as source)
- `--quality`: WebP quality 0-100 (default: 80)
- `--skip-svg`: Skip SVG files (default: true)
- `--preserve-original`: Keep original files (default: true)
- `--dry-run`: Preview changes without converting
- `--verbose`: Detailed output
- `--help`: Show help message

**Examples**:

```bash
# Basic conversion
node scripts/convert-to-webp.js

# Dry run to preview
node scripts/convert-to-webp.js --dry-run --verbose

# Custom quality
node scripts/convert-to-webp.js --quality 90

# Dry run with custom output
node scripts/convert-to-webp.js --dry-run --source ./assets/images --output ./assets/webp
```

### audit-alt-text.js

Scans HTML files for missing or problematic alt-text attributes.

**Usage**:

```bash
node scripts/audit-alt-text.js --source ./frontend/src
```

**Options**:

- `--source`: Source directory (default: ./frontend/src)
- `--extensions`: File extensions (default: html,htm)
- `--output`: Output file (default: alt-text-audit.json)
- `--exclude`: Comma-separated patterns to exclude
- `--check-decorative`: Identify decorative images (default: true)
- `--check-length`: Check alt-text length (default: true)
- `--help`: Show help message

**Examples**:

```bash
# Basic audit
node scripts/audit-alt-text.js --source ./frontend/src

# Custom output file
node scripts/audit-alt-text.js --source ./frontend/src --output audit-results.json

# Exclude directories
node scripts/audit-alt-text.js --exclude "node_modules,dist,build"
```

### extract-dimensions.js

Extracts image metadata and updates HTML files with dimension attributes.

**Usage**:

```bash
node scripts/extract-dimensions.js --source ./assets/images --html-dir ./frontend/src
```

**Options**:

- `--source`: Image directory (default: ./assets/images)
- `--html-dir`: HTML directory (default: ./frontend/src)
- `--attribute`: Attribute type - width-height, aspect-ratio, or both (default: both)
- `--format`: Output format - json or csv (default: json)
- `--output`: Output file (default: dimensions.json)
- `--dry-run`: Preview changes without modifying
- `--no-backup`: Skip creating backup files
- `--help`: Show help message

**Examples**:

```bash
# Basic usage
node scripts/extract-dimensions.js

# Add only width/height
node scripts/extract-dimensions.js --attribute width-height

# Dry run
node scripts/extract-dimensions.js --dry-run --verbose

# Custom output file
node scripts/extract-dimensions.js --format csv --output dims.csv
```

### validate-optimization.js

Validates that all success criteria are met.

**Usage**:

```bash
node scripts/validate-optimization.js
```

**Checks Performed**:

- SC-001: 100% WebP conversion rate
- SC-002: 100% alt-text compliance
- SC-003: Page load time decreased by 20%
- SC-004: CLS score < 0.1
- SC-005: Bandwidth decreased by 25%
- SC-006: 0 accessibility errors

## Common Patterns

### Running Scripts Sequentially

For a complete optimization workflow:

```bash
# 1. Convert images to WebP
npm run img:convert

# 2. Audit alt-text
npm run img:audit

# 3. Manually fix alt-text issues (edit HTML files)

# 4. Extract and add dimensions
npm run img:dimensions

# 5. Validate all criteria
npm run img:validate
```

### Troubleshooting

#### Issue: "Cannot use import statement outside a module"

**Cause**: Scripts use ES2022 module syntax but Node.js requires ESM configuration or different file extension (.mjs)

**Solution**:

1. Add `"type": "module"` to package.json
2. Or rename scripts to .mjs extension
3. Or use a transpiler (Babel, swc)

**Current Status**: Scripts use `#!/usr/bin/env node` shebang which handles module syntax

#### Issue: "Sharp is not a function"

**Cause**: Sharp module is not installed or not imported correctly

**Solution**:

```bash
# Reinstall dependencies
npm install

# Verify sharp is installed
npm list sharp
```

#### Issue: "No images found"

**Cause**: Source directory is empty or path is incorrect

**Solution**:

```bash
# Verify directory exists
ls -la ./assets/images

# List all image files
find ./assets/images -type f \( -name "*.jpg" -o -name "*.png" -o -name "*.gif" \)
```

## Tips

### Dry Run First

Always use `--dry-run` flag to preview changes before actually modifying files:

```bash
node scripts/convert-to-webp.js --dry-run --verbose
node scripts/extract-dimensions.js --dry-run --verbose
```

### Check Backups

Scripts automatically create `.backup` files before modifying. After validation, you can safely delete them:

```bash
# Remove all backup files
find . -name "*.backup" -delete

# Or specific backups
rm filename.html.backup
```

### Performance Verification

Use browser DevTools to measure performance before and after optimization:

1. Open DevTools (F12 or Cmd+Shift+I)
2. Go to Performance tab
3. Measure page load time (LCP, FCP, etc.)
4. Check CLS score in Core Web Vitals
5. Compare results with original baseline

## Support

For issues or questions:

1. Check error messages and log output
2. Review this README for examples
3. Consult the feature specification: `../specs/001-image-webp-optimization/spec.md`
4. Review the implementation plan: `../specs/001-image-webp-optimization/plan.md`
