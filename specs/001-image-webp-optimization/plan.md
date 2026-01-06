# Implementation Plan: Image WebP Optimization

**Branch**: `001-image-webp-optimization` | **Date**: 2026-01-05 | **Spec**: [link](spec.md)
**Input**: Feature specification from `/specs/001-image-webp-optimization/spec.md`

## Summary

Build a Node.js CLI tool for converting images to WebP format, auditing alt-text, and extracting image dimensions. The tool provides three main utilities: `convert-to-webp.js` for image conversion, `audit-alt-text.js` for accessibility validation, and `extract-dimensions.js` for layout stability. All scripts run independently and support dry-run mode for safe preview.

## Technical Context

**Language/Version**: JavaScript ES2022 (Node.js 18+)  
**Primary Dependencies**: Sharp (^0.33.0) for image processing, Cheerio (^1.0.0-rc.12) for HTML parsing, Glob (^10.3.0) for file matching, Chalk (^5.3.0) for colored output, Playwright (^1.40.0) for E2E testing  
**Storage**: N/A (file-based processing, scripts/ output)  
**Testing**: Playwright for E2E, Jest-style unit tests for utilities  
**Target Platform**: Node.js CLI (development tool, cross-platform)  
**Project Type**: CLI utility (scripts at repository root)  
**Performance Goals**: Process 100+ images under 30 seconds, 25-35% size reduction typical  
**Constraints**: Must preserve SVG files, SSIM quality score >= 0.95, run on Node.js 18+  
**Scale/Scope**: 50+ images in project, 3 CLI scripts, supporting utilities

## Constitution Check

_GATE: Must pass before Phase 0 research. Re-check after Phase 1 design._

| Principle                | Requirement                                        | Compliance Status                                       |
| ------------------------ | -------------------------------------------------- | ------------------------------------------------------- |
| Code Quality Excellence  | Self-documenting code, single responsibility       | ✅ PASS: Utility modules separated by concern           |
| Testing Standards        | Unit tests for public functions, E2E for workflows | ✅ PASS: Unit tests for utils, image-utils, html-utils  |
| Performance Requirements | No memory leaks, measurable benchmarks             | ✅ PASS: Dry-run mode, statistics reporting             |
| Security Standards       | Input validation, no code execution                | ✅ PASS: File path validation, read-only dry-run option |

## Project Structure

### Documentation (this feature)

```text
specs/001-image-webp-optimization/
├── plan.md              # This file (/speckit.plan command output)
├── spec.md              # Feature specification
├── research.md          # Phase 0 output
├── data-model.md        # Phase 1 output
├── quickstart.md        # Phase 1 output
├── contracts/           # Phase 1 output
└── tasks.md             # Phase 2 output (/speckit.tasks command)
```

### Source Code (repository root)

```text
scripts/
├── convert-to-webp.js   # Main conversion script
├── audit-alt-text.js    # Alt-text accessibility audit
├── extract-dimensions.js # Image dimension extraction
└── lib/
    ├── utils.js         # Shared utilities
    ├── image-utils.js   # Image metadata and processing
    └── html-utils.js    # HTML parsing utilities

tests/
├── unit/                # Unit tests for lib modules
│   ├── utils.test.js
│   ├── image-utils.test.js
│   └── html-utils.test.js
└── e2e/                 # End-to-end tests
    ├── webp-conversion.spec.js
    ├── performance.spec.js
    ├── accessibility.spec.js
    └── layout.spec.js
```

**Structure Decision**: CLI tool with centralized script directory. Utilities isolated in lib/ for testability. Tests mirror source structure for clarity.

## Complexity Tracking

> **Fill ONLY if Constitution Check has violations that must be justified**

No constitutional violations identified. The CLI tool approach with modular utilities satisfies all quality requirements.

---

## Phase 0: Research

**Status**: ✅ COMPLETE

### Research Tasks

1. **Sharp WebP conversion**: Quality settings, transparency handling, SSIM validation
2. **Cheerio HTML parsing**: img tag extraction, attribute validation, alt-text auditing
3. **Playwright E2E testing**: Performance metrics (LCP, CLS, bandwidth), viewport testing
4. **CLI argument parsing**: Commander.js vs yargs vs minimal native parsing

### Unknowns Resolved

| Unknown               | Resolution                                        | Status      |
| --------------------- | ------------------------------------------------- | ----------- |
| Image quality metrics | SSIM score >= 0.95 or visual inspection checklist | ✅ RESOLVED |
| HTML parsing library  | Cheerio (lightweight, familiar)                   | ✅ RESOLVED |
| CLI argument parsing  | Native minimal parsing (no new dependency)        | ✅ RESOLVED |
| Test framework        | Playwright E2E, manual assertions for unit tests  | ✅ RESOLVED |

---

## Phase 1: Design

**Status**: ✅ COMPLETE (All outputs generated)

1. `research.md` - Consolidated research findings
2. `data-model.md` - Image entities, validation rules
3. `quickstart.md` - Development setup instructions
4. `contracts/` - HTML contract specifications

---

## Phase 2: Implementation Tasks

_Generated in tasks.md by /speckit.tasks command_

1. Setup project structure and dependencies
2. Create shared utility libraries
3. Implement WebP conversion script (T012-T019)
4. Implement alt-text audit script (T022-T030)
5. Implement dimension extraction script (T035-T045)
6. Polish, documentation, and validation

---

## Notes

- All scripts support `--dry-run` for safe preview
- Three independent scripts enable parallel development
- Unit tests verify utility functions; E2E tests verify end-to-end workflows
