# Research: Image WebP Optimization

**Feature**: 001-image-webp-optimization
**Date**: 2026-01-05

## Research Objectives

Resolve technical unknowns from Technical Context:

1. Testing approach for static website with HTML/CSS/JS
2. Image processing tool selection for WebP conversion
3. Dimension extraction approach
4. Alt-text assignment approach (manual vs automated)

## Research Findings

### R1: Testing Approach for Static Website

**Decision**: Playwright for end-to-end testing + manual accessibility audit

**Rationale**:

- Playwright provides cross-browser testing for static websites
- Can verify WebP images are loaded correctly
- Can measure actual page load times and CLS metrics
- Accessibility testing: Manual review + automated tools (axe DevTools or WAVE) for alt-text validation
- Unit testing not critical for static HTML/CSS changes; focus on integration/e2e

**Alternatives Considered**:

- Jest + Testing Library: Good for component testing but overkill for static HTML
- Cypress: Similar to Playwright but Playwright has better cross-browser support and is faster
- Manual testing only: Insufficient for validating performance metrics across browsers

**Implementation Notes**:

- Write Playwright tests to verify:
  - WebP images load on supported browsers
  - Alt-text is present and non-empty for non-decorative images
  - Images have width/height attributes or aspect-ratio CSS
  - Page load time meets 20% improvement target
  - CLS score meets <0.1 target
- Use axe DevTools or WAVE for automated accessibility audits
- Manual review for alt-text quality (meaningful descriptions)

### R2: Image Processing Tool for WebP Conversion

**Decision**: Sharp (Node.js library)

**Rationale**:

- Sharp is the fastest and most efficient image processing library for Node.js
- Direct WebP conversion with quality control
- Can read image metadata (dimensions) for dimension extraction
- Well-maintained, widely used, excellent performance
- Simple API suitable for batch processing

**Alternatives Considered**:

- imagemin: Good but adds plugin complexity; Sharp is more direct
- ImageMagick: Powerful but slower; overkill for simple WebP conversion
- CLI tools (cwebp): Requires separate installation; harder to integrate into build process

**Implementation Notes**:

- Create a Node.js script using Sharp to:
  - Scan project for image files (JPEG, PNG, GIF)
  - Convert each to WebP with quality setting (default 80)
  - Preserve original files alongside WebP versions
  - Skip SVG files (preserve as-is)
- Use Sharp's `metadata()` to extract dimensions
- Handle errors gracefully (unsupported formats, corrupted files)

### R3: Dimension Extraction Approach

**Decision**: Sharp metadata extraction + script automation

**Rationale**:

- Sharp can read image metadata directly from file headers
- Fast and reliable batch processing
- Can generate HTML attributes or CSS automatically

**Alternatives Considered**:

- Manual extraction: Too time-consuming for 50+ images
- Build-time tools (Vite plugins): Possible but adds complexity
- Server-side processing: Overkill for static site

**Implementation Notes**:

- Create script that:
  - Reads all image files (including WebP versions)
  - Extracts width and height using Sharp's `metadata()`
  - Calculates aspect ratio
  - Updates HTML `<img>` tags with width/height attributes
  - Optionally adds aspect-ratio CSS class
- Handle cases where dimensions are not available (rare but possible)

### R4: Alt-Text Assignment Approach

**Decision**: Manual assignment with script-assisted audit

**Rationale**:

- Automated alt-text generation (AI) is not yet reliable for production use
- Alt-text requires human judgment about image context and purpose
- Can automate detection of missing alt-text and flag for review
- Decorative images can be identified and flagged

**Alternatives Considered**:

- AI/ML generation (AltText.ai, etc.): Still experimental, may produce inaccurate descriptions
- Placeholder alt-text ("image", "photo"): Violates accessibility standards
- Skip alt-text entirely: Non-compliant with WCAG 2.1

**Implementation Notes**:

- Create audit script that:
  - Scans all HTML files for `<img>` tags
  - Identifies images with missing or empty alt attributes
  - Generates report with file locations
  - Flags potential decorative images (need manual review)
- Manual process:
  - Review each image in context
  - Write meaningful alt-text describing content and purpose
  - Mark decorative images with alt=""
  - Test with screen reader to verify accessibility

## Summary of Decisions

| Unknown              | Decision                                    | Impact                                  |
| -------------------- | ------------------------------------------- | --------------------------------------- |
| Testing approach     | Playwright E2E + manual accessibility audit | Validates performance and accessibility |
| WebP conversion tool | Sharp (Node.js)                             | Fast, efficient batch conversion        |
| Dimension extraction | Sharp metadata + automation                 | Ensures layout stability                |
| Alt-text assignment  | Manual with script-assisted audit           | Ensures accessibility compliance        |

## Next Steps

1. Create data-model.md to document image metadata structure
2. Define contracts for image processing scripts
3. Update agent context with new dependencies (Sharp, Playwright)
4. Create quickstart guide for running image conversion
