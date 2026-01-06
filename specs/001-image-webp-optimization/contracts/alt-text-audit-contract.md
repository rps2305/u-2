# Alt-Text Audit Script Interface

**Feature**: 001-image-webp-optimization
**Date**: 2026-01-05

## Overview

Defines the interface and contract for the alt-text audit script that scans HTML files for missing or problematic alt-text attributes.

## Script Interface

### Command-Line Interface

```bash
node scripts/audit-alt-text.js [options]
```

### Options

| Option               | Type    | Default               | Description                                      |
| -------------------- | ------- | --------------------- | ------------------------------------------------ |
| `--source`           | string  | "./frontend/src"      | Source directory to scan                         |
| `--extensions`       | string  | "html,htm"            | File extensions to scan (comma-separated)        |
| `--output`           | string  | "alt-text-audit.json" | Output file for audit results                    |
| `--exclude`          | string  | ""                    | Patterns to exclude (comma-separated)            |
| `--check-decorative` | boolean | true                  | Identify potential decorative images             |
| `--check-length`     | boolean | true                  | Check alt-text length (10-125 chars recommended) |

### Exit Codes

| Code | Meaning                    |
| ---- | -------------------------- |
| 0    | Success (with findings)    |
| 1    | General error              |
| 2    | Invalid options            |
| 3    | Source directory not found |
| 4    | No HTML files found        |

## Function Contract

### `auditAltText(config: AuditConfig): Promise<AuditResult>`

**Input Parameters**:

```typescript
interface AuditConfig {
  sourceDir: string; // Source directory path
  extensions?: string[]; // File extensions (default: ['html', 'htm'])
  outputFile?: string; // Output file for results (default: alt-text-audit.json)
  excludePatterns?: string[]; // Patterns to exclude
  checkDecorative?: boolean; // Identify decorative images (default: true)
  checkLength?: boolean; // Check alt-text length (default: true)
}
```

**Output**:

```typescript
interface AuditResult {
  success: boolean;
  stats: {
    totalFiles: number; // Total HTML files scanned
    totalImages: number; // Total <img> tags found
    imagesWithAlt: number; // Images with alt attribute
    imagesWithoutAlt: number; // Images missing alt attribute
    decorativeImages: number; // Images with empty alt (decorative)
    needsReview: number; // Images needing manual review
    complianceRate: number; // Compliance percentage
  };
  findings: AuditFinding[];
  summary: AuditSummary;
}

interface AuditFinding {
  file: string; // HTML file path
  line: number; // Line number
  imagePath: string; // Image src attribute
  hasAlt: boolean; // Whether alt attribute exists
  altText?: string; // Alt-text content (if present)
  issues: string[]; // List of issues found
  severity: "error" | "warning" | "info";
  suggestions?: string[]; // Suggested alt-text (if applicable)
}

interface AuditSummary {
  errors: AuditFinding[];
  warnings: AuditFinding[];
  info: AuditFinding[];
  byFile: {
    [filePath: string]: AuditFinding[];
  };
}
```

## Behavior Specification

### 1. File Scanning

**Given** a source directory,
**When** scanning for HTML files,
**Then**:

- Recursively scan all subdirectories
- Find all files with specified extensions (.html, .htm by default)
- Skip excluded patterns (e.g., node_modules, .git, build/)
- Skip hidden files

### 2. Image Tag Extraction

**Given** an HTML file,
**When** extracting image tags,
**Then**:

- Find all `<img>` tags
- Extract src, alt, width, height attributes
- Record line number and context
- Handle self-closing tags
- Handle comments (ignore images in comments)

### 3. Alt-Text Validation

**Given** an `<img>` tag,
**When** checking alt attribute,
**Then**:

- Check if alt attribute exists
- Check if alt is empty (decorative candidate)
- Check if alt contains file name (e.g., "photo1.jpg")
- Check if alt is too short (<10 chars)
- Check if alt is too long (>125 chars)
- Check for redundant phrases ("Image of...", "A picture showing...")
- Check if alt matches image filename pattern

### 4. Decorative Image Detection

**Given** an image with empty alt,
**When** checking if decorative,
**Then**:

- Flag as potential decorative image
- Check for context clues (role="presentation", aria-hidden="true")
- Suggest manual review for confirmation
- Note: Final determination requires human judgment

### 5. Issue Severity Assignment

**Given** an alt-text issue,
**When** assigning severity,
**Then**:

- **Error**: Missing alt attribute on non-decorative image
- **Warning**: Alt is filename, too short, too long, or redundant
- **Info**: Potential decorative image (needs manual review)

### 6. Suggestions Generation

**Given** an image missing alt-text,
**When** generating suggestions,
**Then**:

- Extract filename (remove extension)
- Suggest context-based descriptions (e.g., "decorative icon" for icons)
- Note: Actual alt-text requires manual assignment

### 7. Output Generation

**Given** audit findings,
**When** generating output,
**Then**:

- Write JSON file with all findings
- Print summary to console
- Group findings by severity
- List files with most issues first
- Provide compliance rate

## Validation Rules

### Alt-Text Requirements

1. **Presence**: All non-decorative images MUST have alt attribute
2. **Content**: Alt text MUST NOT be empty for non-decorative images
3. **Description**: Alt text MUST describe image content accurately
4. **Length**: Recommended 10-125 characters (not enforced, just flagged)
5. **No Filenames**: Alt text MUST NOT be filename (e.g., "photo1.jpg")
6. **No Redundancy**: Alt text SHOULD NOT use redundant phrases

### Decorative Images

1. **Empty Alt**: Decorative images MUST use alt=""
2. **Role**: SHOULD include role="presentation"
3. **Context**: Determined by usage (e.g., decorative icons, spacers)

## Acceptance Criteria

1. **Given** an HTML file with 10 images, 5 missing alt, **When** script runs, **Then** reports 5 errors
2. **Given** an image with alt="photo1.jpg", **When** script runs, **Then** flags as warning
3. **Given** a decorative image with alt="", **When** script runs, **Then** reports as info
4. **Given** an image with 5-character alt, **When** script runs, **Then** flags as warning (too short)
5. **Given** script runs on project, **When** complete, **Then** generates JSON report with all findings
6. **Given** no HTML files found, **When** script runs, **Then** exits with code 4
7. **Given** invalid source directory, **When** script runs, **Then** exits with code 3

## Example Output

```json
{
  "success": true,
  "stats": {
    "totalFiles": 10,
    "totalImages": 45,
    "imagesWithAlt": 38,
    "imagesWithoutAlt": 7,
    "decorativeImages": 3,
    "needsReview": 12,
    "complianceRate": 84.4
  },
  "findings": [
    {
      "file": "frontend/src/pages/index.html",
      "line": 25,
      "imagePath": "/assets/images/hero.jpg",
      "hasAlt": false,
      "issues": ["Missing alt attribute"],
      "severity": "error",
      "suggestions": ["U-2 spy plane in flight over mountains"]
    },
    {
      "file": "frontend/src/pages/index.html",
      "line": 45,
      "imagePath": "/assets/images/logo.png",
      "hasAlt": true,
      "altText": "logo.png",
      "issues": ["Alt text is filename", "Too short"],
      "severity": "warning"
    }
  ]
}
```

## Example Usage

### Basic Audit

```bash
node scripts/audit-alt-text.js --source ./frontend/src
```

### Custom Extensions and Output

```bash
node scripts/audit-alt-text.js --source ./frontend/src --extensions html,htm --output audit-results.json
```

### Exclude Directories

```bash
node scripts/audit-alt-text.js --source ./frontend/src --exclude "node_modules,dist,build"
```

## Dependencies

- `cheerio`: ^1.0.0-rc.12 (HTML parsing)
- `glob`: ^10.3.0 (file pattern matching)
- `chalk`: ^5.3.0 (colored terminal output)

## Notes

- Script identifies issues but does not fix them automatically
- Alt-text assignment requires human judgment
- Decorative image detection is heuristic-based
- Manual review is required for all flagged images
- Compliance rate = (imagesWithAlt / totalImages) \* 100
