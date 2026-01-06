# Implementation Plan: Add Logo and Improve Gallery Lightbox

**Branch**: `002-logo-gallery-lightbox` | **Date**: 2026-01-03 | **Spec**: [spec.md](spec.md)
**Input**: Feature specification from `/specs/002-logo-gallery-lightbox/spec.md`

## Summary

Add U-2 spy plane logo to website header and implement a responsive lightbox gallery with prev/next navigation, keyboard shortcuts, and touch swipe support. The logo will be downloaded locally from the provided URL and displayed in the header with a link to the homepage. The lightbox will enhance the existing gallery by allowing users to view full-size images in an overlay with intuitive navigation controls.

## Technical Context

**Language/Version**: JavaScript ES2022, HTML5, CSS3 (existing stack)
**Primary Dependencies**: Tailwind CSS (existing), no external lightbox library needed - custom implementation
**Storage**: N/A (static website, images are local files)
**Testing**: Playwright (existing), HTMLhint, Prettier
**Target Platform**: Web browser - desktop and mobile
**Project Type**: Single project (existing u-2 website at `src/`)
**Performance Goals**: Lightbox opens within 500ms of thumbnail click
**Constraints**: Responsive design for viewports 320px to 3840px, zero horizontal scrolling on mobile
**Scale/Scope**: 9 gallery images, single page application

## Constitution Check

_GATE: Must pass before Phase 0 research. Re-check after Phase 1 design._

| Principle                | Requirement                                  | Status | Verification Method                                                 |
| ------------------------ | -------------------------------------------- | ------ | ------------------------------------------------------------------- |
| Code Quality Excellence  | Self-documenting code, single responsibility | PASS   | Custom Lightbox class with clear methods (open, close, prev, next)  |
| Testing Standards        | Tests for viewport compatibility             | PASS   | Playwright viewport tests for 320px-3840px responsive behavior      |
| UX Consistency           | Platform conventions, <200ms response        | PASS   | Keyboard (Escape, Arrow keys) and touch swipe follow web standards  |
| Performance Requirements | No memory leaks, measurable benchmarks       | PASS   | Lightbox opens within 500ms target; state management prevents leaks |

## Project Structure

### Documentation (this feature)

```text
specs/002-logo-gallery-lightbox/
├── plan.md              # This file (/speckit.plan command output)
├── spec.md              # Feature specification
├── research.md          # Phase 0 output
├── data-model.md        # Phase 1 output
├── quickstart.md        # Phase 1 output
└── checklists/
    └── requirements.md  # Quality checklist
```

### Source Code (repository root)

```text
src/
├── index.html           # Main HTML with gallery and header
├── css/styles.css       # Tailwind CSS (existing)
├── js/main.js           # JavaScript for lightbox logic
└── assets/images/
    ├── logo/            # NEW: Logo image directory
    ├── hero/            # Existing hero images
    ├── gallery/         # Existing gallery WEBP images
    └── thumb/           # Existing thumbnails

tests/
├── e2e/responsive.spec.js  # Playwright viewport tests (existing)
└── lint/                    # Linting configuration

public/
└── styles.css           # Compiled CSS (existing)
```

**Structure Decision**: Single project at repository root. The lightbox enhancement integrates with existing `src/index.html` and `src/js/main.js`. Logo will be stored in new `src/assets/images/logo/` directory.

## Complexity Tracking

No constitutional violations identified. The custom vanilla JavaScript lightbox implementation satisfies all quality requirements defined in `.specify/memory/constitution.md` without requiring additional justification.
