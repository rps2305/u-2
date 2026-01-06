# Implementation Plan: U-2 Spyplane Informational Website

**Branch**: `004-u2-spyplane-website` | **Date**: 2026-01-03 | **Spec**: [link](spec.md)
**Input**: Feature specification from `/specs/004-u2-spyplane-website/spec.md`

## Summary

Build a responsive informational website about the U-2 spyplane featuring 50+ images in WEBP format, styled with Tailwind CSS, and validated through testing and linting. The website will be a static single-page application with multiple sections covering history, technical specifications, operational missions, and an image gallery with lightbox functionality.

## Technical Context

**Language/Version**: HTML5, CSS3, JavaScript (ES2022)  
**Primary Dependencies**: Tailwind CSS (via CDN for development, npm for production), WEBP images (50+)  
**Storage**: N/A (static website, assets stored in `src/assets/images/`)  
**Testing**: Playwright for end-to-end testing, HTMLhint/Prettier for linting  
**Target Platform**: Web browsers (Chrome 120+, Firefox 120+, Safari 16+, Edge 120+)  
**Project Type**: single (static website)  
**Performance Goals**: Primary content loads under 3 seconds, Lighthouse performance score 85+  
**Constraints**: Must use responsive design (320px-3840px), WEBP format for all images, pass linting without errors  
**Scale/Scope**: 50+ images, single-page with 5-7 content sections, image gallery with lightbox

## Constitution Check

_GATE: Must pass before Phase 0 research. Re-check after Phase 1 design._

| Principle                | Requirement                                             | Compliance Status | Verification Method                                                                              |
| ------------------------ | ------------------------------------------------------- | ----------------- | ------------------------------------------------------------------------------------------------ |
| Code Quality Excellence  | HTML MUST follow semantic structure, pass linting       | ✅ COMPLIANT      | HTMLhint configured in tests/lint/.htmlhintrc, semantic tags used (header, nav, section, footer) |
| Testing Standards        | Tests MUST verify responsive behavior and image loading | ✅ COMPLIANT      | Playwright viewport tests configured in tests/e2e/responsive.spec.js for 320px-3840px            |
| UX Consistency           | Responsive design MUST follow mobile-first approach     | ✅ COMPLIANT      | Tailwind breakpoints (sm:, md:, lg:, xl:, 2xl:) used consistently, hamburger menu for mobile     |
| Performance Requirements | Images MUST use WEBP format for optimization            | ✅ COMPLIANT      | WEBP workflow defined, responsive srcset and lazy loading implemented                            |

**Post-Design Verification**: All constitutional requirements satisfied. Verification evidence documented above.

## Project Structure

### Documentation (this feature)

```text
specs/004-u2-spyplane-website/
├── plan.md              # This file (/speckit.plan command output)
├── research.md          # Phase 0 output (/speckit.plan command)
├── data-model.md        # Phase 1 output (/speckit.plan command)
├── quickstart.md        # Phase 1 output (/speckit.plan command)
├── contracts/           # Phase 1 output (/speckit.plan command)
└── tasks.md             # Phase 2 output (/speckit.tasks command - NOT created by /speckit.plan)
```

### Source Code (repository root)

```text
# Single project (static website)
src/
├── index.html          # Main HTML file
├── css/
│   └── styles.css      # Custom styles (if needed beyond Tailwind)
├── js/
│   └── main.js         # JavaScript for gallery and interactions
└── assets/
    └── images/
        ├── hero/       # Hero section images
        ├── gallery/    # Gallery images (50+ WEBP files)
        └── thumb/      # Thumbnail versions

tests/
├── e2e/                # Playwright end-to-end tests
│   └── responsive.spec.js
└── lint/               # Linting configuration
    ├── .htmlhintrc
    └── .prettierrc

public/                 # Build output (if using npm build)
```

**Structure Decision**: Single static website project with source in `src/` and compiled output in `public/`. Images stored in optimized WEBP format with thumbnails for gallery performance.

## Complexity Tracking

No constitutional violations identified. The static website approach with Tailwind CSS satisfies all quality requirements defined in `.specify/memory/constitution.md`.

---

## Phase 0: Research

**Status**: ✅ COMPLETE

### Research Tasks

1. **Tailwind CSS responsive image best practices**: Research optimal approach for responsive images with Tailwind CSS including lazy loading, srcset, and picture elements.
2. **WEBP image optimization workflow**: Research tools and processes for converting and optimizing images to WEBP format while maintaining quality.
3. **Playwright responsive testing patterns**: Research best practices for testing responsive layouts with Playwright including viewport testing and visual regression.
4. **HTML linting tools for static sites**: Research HTMLhint, Prettier, and other linting tools suitable for static HTML with Tailwind CSS.

### Unknowns to Resolve

| Unknown                   | Research Question                                                            | Status                                                               |
| ------------------------- | ---------------------------------------------------------------------------- | -------------------------------------------------------------------- |
| Tailwind CDN vs npm build | Should we use Tailwind via CDN for simplicity or npm build for optimization? | ✅ RESOLVED: CDN for development, npm build for production           |
| Image gallery library     | Should we use a lightweight custom solution or established library?          | ✅ RESOLVED: Custom lightbox (vanilla JS)                            |
| Lightbox functionality    | What features are needed for image lightbox (zoom, caption, keyboard nav)?   | ✅ RESOLVED: Keyboard nav, touch swipe, captions, smooth transitions |
| Testing scope             | What browser Matrix should we test against?                                  | ✅ RESOLVED: Mobile/Tablet/Desktop per Playwright devices            |

---

## Phase 1: Design

**Status**: ✅ COMPLETE (All outputs generated)

1. `research.md` - Consolidated research findings
2. `data-model.md` - Content structure and image organization
3. `contracts/` - No API contracts needed (static site)
4. `quickstart.md` - Development setup instructions
5. Agent context update

### Content Structure

The single-page website will contain the following sections:

1. **Header/Navigation**: Logo, main navigation links, responsive hamburger menu
2. **Hero Section**: Large hero image, title, subtitle, call-to-action
3. **History Section**: Timeline of U-2 development and service history
4. **Technical Specifications**: Data table of aircraft specifications
5. **Operations Section**: Information about missions and capabilities
6. **Image Gallery**: Grid of 50+ thumbnails with lightbox viewer
7. **Footer**: Copyright, links, credits

### Image Organization

| Category           | Count | Purpose                         |
| ------------------ | ----- | ------------------------------- |
| Hero images        | 5-7   | Header and section backgrounds  |
| History timeline   | 10-15 | Historical photos and documents |
| Technical specs    | 5-10  | Aircraft detail shots           |
| Operations         | 15-20 | Mission and deployment photos   |
| Gallery collection | 20-30 | Additional high-quality images  |

---

## Phase 2: Implementation Planning

### Key Implementation Tasks (preview)

- Setup project structure and initialize npm
- Configure Tailwind CSS with custom design tokens
- Create HTML structure with semantic markup
- Download and convert 50+ images to WEBP format
- Implement responsive layout with Tailwind breakpoints
- Build image gallery with thumbnail grid
- Implement lightbox functionality with JavaScript
- Configure HTML linting with HTMLhint
- Configure Playwright for responsive testing
- Run tests and fix any issues
- Verify Lighthouse performance score

### Next Steps

After Phase 1 design is complete:

1. Run `/speckit.tasks` to generate implementation task list
2. Execute tasks in order (Setup → Implementation → Testing → Polish)
3. Validate against success criteria from spec
