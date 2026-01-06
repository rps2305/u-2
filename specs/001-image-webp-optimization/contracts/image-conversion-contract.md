# Image Conversion Script Interface

**Feature**: 001-image-webp-optimization
**Date**: 2026-01-05

## Overview

Defines the interface and contract for the image conversion script that converts non-SVG images to WebP format.

## Script Interface

### Command-Line Interface

```bash
node scripts/convert-to-webp.js [options]
```

### Options

| Option                | Type    | Default           | Description                                |
| --------------------- | ------- | ----------------- | ------------------------------------------ |
| `--source`            | string  | "./assets/images" | Source directory containing images         |
| `--output`            | string  | same as source    | Output directory for WebP files            |
| `--quality`           | number  | 80                | WebP compression quality (0-100)           |
| `--format`            | string  | "webp"            | Output format (only webp supported)        |
| `--skip-svg`          | boolean | true              | Skip SVG files (default: true)             |
| `--preserve-original` | boolean | true              | Keep original files (default: true)        |
| `--dry-run`           | boolean | false             | Show what would be done without converting |
| `--verbose`           | boolean | false             | Detailed output                            |

### Exit Codes

| Code | Meaning                    |
| ---- | -------------------------- |
| 0    | Success                    |
| 1    | General error              |
| 2    | Invalid options            |
| 3    | Source directory not found |
| 4    | No valid images found      |

## Function Contract

### `convertToWebP(config: ConversionConfig): Promise<ConversionResult>`

**Input Parameters**:

```typescript
interface ConversionConfig {
  sourceDir: string; // Source directory path
  outputDir?: string; // Output directory (default: same as source)
  quality?: number; // WebP quality (0-100, default: 80)
  skipSvg?: boolean; // Skip SVG files (default: true)
  preserveOriginal?: boolean; // Keep original files (default: true)
  dryRun?: boolean; // Preview mode (default: false)
  verbose?: boolean; // Verbose logging (default: false)
}
```

**Output**:

```typescript
interface ConversionResult {
  success: boolean;
  stats: {
    totalFiles: number; // Total images found
    converted: number; // Images converted to WebP
    skipped: number; // Images skipped (SVG, already WebP, etc.)
    errors: number; // Files with conversion errors
    originalTotalSize: number; // Original total size in bytes
    webpTotalSize: number; // WebP total size in bytes
    sizeReduction: number; // Size reduction percentage
  };
  convertedFiles: ConvertedFile[];
  skippedFiles: SkippedFile[];
  errors: ConversionError[];
}

interface ConvertedFile {
  sourcePath: string;
  outputPath: string;
  originalSize: number;
  webpSize: number;
  sizeReduction: number;
  format: string;
  quality: number;
}

interface SkippedFile {
  path: string;
  reason: "svg" | "already-webp" | "unsupported-format";
}

interface ConversionError {
  path: string;
  error: string;
}
```

## Behavior Specification

### 1. Directory Scanning

**Given** a source directory path,
**When** scanning for images,
**Then**:

- Recursively scan all subdirectories
- Find all files with extensions: .jpg, .jpeg, .png, .gif, .webp, .svg
- Skip hidden files (starting with .)
- Skip files in node_modules, .git, .specify directories

### 2. File Filtering

**Given** a list of image files,
**When** determining which to convert,
**Then**:

- Skip SVG files (when skipSvg=true)
- Skip files already in WebP format
- Skip files with unsupported formats
- Flag for conversion: JPEG, PNG, GIF (non-animated)

### 3. Image Conversion

**Given** a JPEG, PNG, or GIF file,
**When** converting to WebP,
**Then**:

- Use Sharp library for conversion
- Apply specified quality setting (default: 80)
- Preserve exact original dimensions
- Handle transparency (for PNG/GIF)
- Preserve color space when possible
- Create output file in specified directory
- Keep original filename with .webp extension

### 4. Error Handling

**Given** a file conversion error,
**When** processing,
**Then**:

- Log error message (when verbose=true)
- Continue processing other files
- Record error in result.errors array
- Do not exit with error unless all files fail

### 5. Dry Run Mode

**Given** dryRun=true,
**When** processing,
**Then**:

- Scan and filter files as normal
- Calculate what would be converted
- Report statistics in results
- Do not create any WebP files

### 6. File Size Calculation

**Given** original and WebP file sizes,
**When** calculating statistics,
**Then**:

- Sum original sizes for all converted files
- Sum WebP sizes for all converted files
- Calculate percentage reduction: (1 - webpTotalSize/originalTotalSize) \* 100

## Acceptance Criteria

1. **Given** a directory with mixed image formats, **When** the script runs, **Then** all non-SVG images have WebP counterparts
2. **Given** a 1MB JPEG image, **When** converted, **Then** WebP file is ≤750KB (25%+ reduction)
3. **Given** an SVG file, **When** script runs, **Then** SVG remains unchanged
4. **Given** dryRun=true, **When** script runs, **Then** no files are modified
5. **Given** a corrupted image file, **When** script runs, **Then** error is logged but processing continues
6. **Given** preserveOriginal=true, **When** script runs, **Then** original files are retained
7. **Given** a PNG with transparency, **When** converted, **Then** WebP preserves transparency

## Example Usage

### Basic Conversion

```bash
node scripts/convert-to-webp.js --source ./assets/images --quality 85
```

### Dry Run

```bash
node scripts/convert-to-webp.js --source ./assets/images --dry-run --verbose
```

### Custom Output Directory

```bash
node scripts/convert-to-webp.js --source ./assets/images --output ./assets/webp
```

## Dependencies

- `sharp`: ^0.33.0 (image processing)
- `chalk`: ^5.3.0 (colored terminal output)
- `glob`: ^10.3.0 (file pattern matching)

## Notes

- Script runs synchronously for batch processing
- Large numbers of files may take significant time
- Quality setting balances file size vs visual quality
- 80 is a good default for most web use cases
