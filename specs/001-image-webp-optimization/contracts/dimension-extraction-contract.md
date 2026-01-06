# Dimension Extraction Script Interface

**Feature**: 001-image-webp-optimization
**Date**: 2026-01-05

## Overview

Defines the interface and contract for the dimension extraction script that reads image metadata and updates HTML files with width/height attributes or aspect-ratio CSS.

## Script Interface

### Command-Line Interface

```bash
node scripts/extract-dimensions.js [options]
```

### Options

| Option        | Type    | Default           | Description                                            |
| ------------- | ------- | ----------------- | ------------------------------------------------------ |
| `--source`    | string  | "./assets/images" | Source directory with images                           |
| `--html-dir`  | string  | "./frontend/src"  | HTML directory to update                               |
| `--attribute` | string  | "both"            | Attribute type: "width-height", "aspect-ratio", "both" |
| `--format`    | string  | "json"            | Output format: "json", "csv"                           |
| `--output`    | string  | "dimensions.json" | Output file for extracted dimensions                   |
| `--dry-run`   | boolean | false             | Show what would be done without modifying              |
| `--backup`    | boolean | true              | Backup HTML files before modification                  |

### Exit Codes

| Code | Meaning                    |
| ---- | -------------------------- |
| 0    | Success                    |
| 1    | General error              |
| 2    | Invalid options            |
| 3    | Source directory not found |
| 4    | No images found            |
| 5    | HTML directory not found   |
| 6    | No HTML files found        |

## Function Contract

### `extractDimensions(config: DimensionConfig): Promise<DimensionResult>`

**Input Parameters**:

```typescript
interface DimensionConfig {
  imageDir: string; // Directory containing images
  htmlDir: string; // Directory with HTML files to update
  attributeType: "width-height" | "aspect-ratio" | "both"; // Attribute type to add
  outputFile?: string; // Output file for results
  outputFormat?: "json" | "csv"; // Output format (default: json)
  dryRun?: boolean; // Preview mode (default: false)
  backup?: boolean; // Backup HTML files (default: true)
}
```

**Output**:

```typescript
interface DimensionResult {
  success: boolean;
  stats: {
    totalImages: number; // Total images processed
    extracted: number; // Images with dimensions extracted
    failed: number; // Images where extraction failed
    totalHtmlFiles: number; // Total HTML files processed
    htmlFilesUpdated: number; // HTML files modified
    imagesWithDimensions: number; // Images that got dimensions
    dimensionsAdded: number; // Total dimension attributes added
  };
  imageDimensions: ImageDimension[];
  htmlUpdates: HtmlUpdate[];
  errors: ExtractionError[];
}

interface ImageDimension {
  path: string; // Image file path
  width: number; // Pixel width
  height: number; // Pixel height
  aspectRatio: number; // Width/height (e.g., 1.333)
  aspectRatioString: string; // Simplified ratio (e.g., "4:3")
  format: string; // File format
  size: number; // File size in bytes
}

interface HtmlUpdate {
  file: string; // HTML file path
  line: number; // Line number
  imagePath: string; // Image src attribute
  previousAttributes?: {
    // Previous attributes (if any)
    width?: string;
    height?: string;
    aspectRatio?: string;
  };
  newAttributes: {
    // New attributes added
    width?: string;
    height?: string;
    aspectRatio?: string;
  };
  modified: boolean; // Whether file was modified
}
```

## Behavior Specification

### 1. Image Scanning

**Given** an image directory,
**When** scanning for images,
**Then**:

- Recursively scan all subdirectories
- Find all image files (.jpg, .jpeg, .png, .gif, .webp, .svg)
- Skip hidden files and system directories
- Store file paths relative to image directory

### 2. Dimension Extraction

**Given** an image file,
**When** extracting dimensions,
**Then**:

- Use Sharp library to read image metadata
- Extract width and height in pixels
- Calculate aspect ratio: width / height
- Simplify aspect ratio to common fractions (e.g., 4:3, 16:9, 1:1)
- Handle errors gracefully (corrupt files, unsupported formats)

### 3. Aspect Ratio Simplification

**Given** width and height,
**When** calculating aspect ratio string,
**Then**:

- Calculate GCD (greatest common divisor)
- Simplify: width/gcd : height/gcd
- Round to nearest whole number
- Handle very large ratios (>10) as custom format
- Examples:
  - 800x600 → 4:3
  - 1920x1080 → 16:9
  - 500x500 → 1:1
  - 1200x800 → 3:2

### 4. HTML File Scanning

**Given** an HTML directory,
**When** scanning for HTML files,
**Then**:

- Recursively scan all subdirectories
- Find all files with .html, .htm extensions
- Skip excluded patterns (node_modules, build/, etc.)
- Store file paths relative to HTML directory

### 5. Image Tag Matching

**Given** HTML file content and image dimensions,
**When** matching images to tags,
**Then**:

- Find all `<img>` tags in HTML
- Extract src attribute
- Match src to image dimensions by path
- Handle relative paths (../, ./)
- Handle absolute paths (/assets/images/...)
- Handle query strings (?v=1)
- Handle multiple references to same image

### 6. Attribute Addition Logic

**Given** an `<img>` tag and image dimensions,
**When** adding attributes based on attributeType,
**Then**:

**If attributeType = 'width-height'**:

- Add width="[width]"
- Add height="[height]"
- Example: width="800" height="600"

**If attributeType = 'aspect-ratio'**:

- Add style="aspect-ratio: [width]/[height];"
- Example: style="aspect-ratio: 4/3;"

**If attributeType = 'both'**:

- Add width="[width]" height="[height]"
- Add style="aspect-ratio: [width]/[height];"
- Example: width="800" height="600" style="aspect-ratio: 4/3;"

### 7. Existing Attribute Handling

**Given** an `<img>` tag with existing width/height,
**When** processing,
**Then**:

- Check if existing values match extracted dimensions
- If match: Skip (no change needed)
- If mismatch: Update to correct dimensions (override)
- Log warning if values differ significantly (>10px)

### 8. File Modification

**Given** HTML file and updates,
**When** modifying files,
**Then**:

- Create backup file (if backup=true): filename.html.backup
- Apply updates to HTML content
- Write modified content back to file
- Record what was changed
- Preserve file encoding and line endings

### 9. Dry Run Mode

**Given** dryRun=true,
**When** processing,
**Then**:

- Extract dimensions as normal
- Calculate what would be updated
- Report statistics and updates
- Do not modify any files
- Do not create backups

## Validation Rules

### Dimension Accuracy

1. **Exact Values**: Width and height MUST match actual image dimensions exactly
2. **No Rounding**: Do not round or estimate dimensions
3. **Pixel Values**: Always use pixel values for width/height attributes
4. **SVG Handling**: SVG dimensions from viewBox attribute if available

### Attribute Type Selection

1. **Width-Height**: Best for layout stability, CLS reduction
2. **Aspect-Ratio**: Good for responsive images with fluid width
3. **Both**: Most robust (recommended for all cases)

### Error Handling

1. **Missing Files**: Log warning, continue processing
2. **Corrupt Images**: Log error, skip image
3. **Invalid HTML**: Log error, skip file
4. **No Dimensions Available**: Log warning, skip image

## Acceptance Criteria

1. **Given** a 800x600 image, **When** dimensions extracted, **Then** width=800, height=600
2. **Given** HTML with <img src="photo.jpg">, **When** script runs, **Then** adds width/height attributes
3. **Given** dryRun=true, **When** script runs, **Then** no files are modified
4. **Given** existing width="1000" height="600" on 800x600 image, **When** script runs, **Then** updates to width="800" height="600"
5. **Given** 1920x1080 image, **When** script runs, **Then** aspect-ratio="16/9" (if aspect-ratio selected)
6. **Given** backup=true, **When** script runs, **Then** creates .backup files for all modified HTML
7. **Given** SVG file, **When** processing, **Then** extracts dimensions from viewBox if available

## Example Output

```json
{
  "success": true,
  "stats": {
    "totalImages": 50,
    "extracted": 48,
    "failed": 2,
    "totalHtmlFiles": 10,
    "htmlFilesUpdated": 8,
    "imagesWithDimensions": 45,
    "dimensionsAdded": 90
  },
  "imageDimensions": [
    {
      "path": "assets/images/hero.jpg",
      "width": 1920,
      "height": 1080,
      "aspectRatio": 1.777,
      "aspectRatioString": "16/9",
      "format": "jpeg",
      "size": 524288
    }
  ],
  "htmlUpdates": [
    {
      "file": "frontend/src/pages/index.html",
      "line": 25,
      "imagePath": "/assets/images/hero.jpg",
      "previousAttributes": {},
      "newAttributes": {
        "width": "1920",
        "height": "1080",
        "aspectRatio": "16/9"
      },
      "modified": true
    }
  ]
}
```

## Example Usage

### Basic Usage (Add Both Attributes)

```bash
node scripts/extract-dimensions.js --source ./assets/images --html-dir ./frontend/src
```

### Add Only Width/Height

```bash
node scripts/extract-dimensions.js --source ./assets/images --html-dir ./frontend/src --attribute width-height
```

### Dry Run (Preview Changes)

```bash
node scripts/extract-dimensions.js --source ./assets/images --html-dir ./frontend/src --dry-run
```

### Custom Output File

```bash
node scripts/extract-dimensions.js --source ./assets/images --html-dir ./frontend/src --output image-dimensions.json
```

## Dependencies

- `sharp`: ^0.33.0 (image metadata extraction)
- `cheerio`: ^1.0.0-rc.12 (HTML parsing and manipulation)
- `glob`: ^10.3.0 (file pattern matching)
- `chalk`: ^5.3.0 (colored terminal output)

## Notes

- SVG dimensions require viewBox attribute parsing
- Aspect-ratio CSS requires browser support (modern browsers)
- Width/height attributes have broader browser support
- Using both attributes provides maximum compatibility
- Backup files use .backup extension
- Original files are never deleted
- Script can be run multiple times (idempotent)
