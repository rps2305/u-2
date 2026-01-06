# Implementation Plan: SEO & Accessibility Audit Fixes

**Branch**: `003-seo-accessibility-audit` | **Date**: 2026-01-05 | **Spec**: [spec.md](spec.md)
**Input**: Feature specification from `/specs/003-seo-accessibility-audit/spec.md`

## Summary

This feature addresses critical SEO, performance, and accessibility issues identified in the Lockheed U-2 Spyplane website audit. The website requires metadata optimization (title: 52 chars, description: 215 chars), heading hierarchy consolidation (57 → 18 headings), image attribute compliance, link text accessibility improvements, security header implementation, and supporting file creation (robots.txt, sitemap.xml, 404.html). All changes target static HTML deployment with build-time image optimization.

## Technical Context

**Language/Version**: HTML5, CSS3, JavaScript ES2022 (no build step for HTML/CSS)  
**Primary Dependencies**: Tailwind CSS (CDN for dev, local for production), Sharp CLI (image optimization), Playwright (testing)  
**Storage**: N/A (static site - files served directly)  
**Testing**: Playwright E2E tests, htmlhint, Lighthouse (CI integration via CLI)  
**Target Platform**: Modern browsers (Chrome, Firefox, Safari, Edge), mobile browsers  
**Project Type**: Static single-page website  
**Performance Goals**: Lighthouse Performance score > 90, Core Web Vitals: LCP < 2.5s, CLS < 0.1, FID < 100ms  
**Constraints**: No server-side rendering, security headers via meta tags and hosting platform, render-blocking CSS from Tailwind CDN  
**Scale/Scope**: Single page with 10 sections, ~50 images, no database or API

## Constitution Check

_GATE: Must pass before Phase 0 research. Re-check after Phase 1 design._

| Principle                | Requirement                    | Status  | Notes                            |
| ------------------------ | ------------------------------ | ------- | -------------------------------- |
| Code Quality Excellence  | Self-documenting, lint passing | ✅ PASS | htmlhint and Prettier configured |
| Testing Standards        | Unit/integration coverage      | ✅ PASS | Playwright E2E tests existing    |
| UX Consistency           | WCAG 2.1 AA compliance         | ✅ PASS | Requirement 2 from spec          |
| Performance Requirements | Core Web Vitals targets        | ✅ PASS | Requirement 6 from spec          |
| Security Standards       | Input validation, CSP          | ✅ PASS | Requirement 5 from spec          |
| CI Pipeline              | Lint, type checks, tests       | ✅ PASS | npm scripts configured           |

**GATE STATUS**: ✅ ALL PASS - Proceed to Phase 0

## Project Structure

### Documentation (this feature)

```text
specs/003-seo-accessibility-audit/
├── plan.md              # This file
├── research.md          # Phase 0 output
├── data-model.md        # Phase 1 output
├── quickstart.md        # Phase 1 output
├── contracts/           # Phase 1 output
└── tasks.md             # Phase 2 output (/speckit.tasks - NOT created by /speckit.plan)
```

### Source Code (repository root)

```text
src/
├── index.html           # Main page (SEO/a11y fixes target)
├── css/
│   └── styles.css       # Critical CSS (to be inlined)
├── js/
│   └── main.js          # Defer non-critical JS
└── assets/
    └── images/          # WebP/AVIF conversion target

specs/                   # Feature documentation
```

**Structure Decision**: Single static website project using existing structure. No changes to project layout required. All fixes applied to existing files.

## Phase 0: Research & Analysis

**Status**: ✅ COMPLETE

All unknowns resolved. See [research.md](research.md) for findings.

### Research Results

| Unknown                       | Resolution                                                        | Source   |
| ----------------------------- | ----------------------------------------------------------------- | -------- |
| Tailwind CDN render-blocking  | Inline critical CSS, defer full Tailwind                          | Research |
| HSTS meta tag support         | Hosting platform required (Netlify \_headers, Vercel vercel.json) | Research |
| SVG favicon data-URI encoding | Use base64-encoded SVG to avoid illegal characters                | Research |
| Lighthouse CI integration     | Use @lhci/cli with GitHub Actions                                 | Research |

## Phase 1: Design & Contracts

**Status**: ✅ COMPLETE

### Artifacts Generated

| Artifact                  | Status      | Location                          |
| ------------------------- | ----------- | --------------------------------- |
| data-model.md             | ✅ Complete | [Link](data-model.md)             |
| quickstart.md             | ✅ Complete | [Link](quickstart.md)             |
| contracts/static-files.md | ✅ Complete | [Link](contracts/static-files.md) |

### Constitution Check (Post-Design)

| Principle                | Requirement                    | Status  | Notes                                    |
| ------------------------ | ------------------------------ | ------- | ---------------------------------------- |
| Code Quality Excellence  | Self-documenting, lint passing | ✅ PASS | htmlhint and Prettier configured         |
| Testing Standards        | Unit/integration coverage      | ✅ PASS | Playwright E2E tests existing            |
| UX Consistency           | WCAG 2.1 AA compliance         | ✅ PASS | All entities designed with a11y in mind  |
| Performance Requirements | Core Web Vitals targets        | ✅ PASS | Research confirms preload/defer approach |
| Security Standards       | Input validation, CSP          | ✅ PASS | SecurityHeader entity defined            |
| CI Pipeline              | Lint, type checks, tests       | ✅ PASS | Lighthouse CI integration documented     |

**GATE STATUS**: ✅ ALL PASS - Ready for Phase 2

## Phase 2: Implementation Tasks

_Generated in tasks.md by /speckit.tasks command_

1. Optimize metadata (title, description, canonical)
2. Consolidate heading hierarchy (57 → 18)
3. Fix image attributes (width, height, alt, src)
4. Fix link text accessibility
5. Implement security headers (meta tags + hosting config)
6. Create robots.txt
7. Create sitemap.xml
8. Create 404.html
9. Fix favicon data-URI encoding
10. Eliminate render-blocking resources (preload/defer)
11. Convert images to WebP/AVIF
12. Run Lighthouse audit validation
13. Run accessibility audit validation
14. Update tests for new structure

## Complexity Tracking

> **Fill ONLY if Constitution Check has violations that must be justified**

| Violation | Why Needed | Simpler Alternative Rejected Because |
| --------- | ---------- | ------------------------------------ |
| None      | -          | -                                    |

## Phase 2: Implementation Tasks

_Generated in tasks.md by /speckit.tasks command_

1. Optimize metadata (title, description, canonical)
2. Consolidate heading hierarchy (57 → 18)
3. Fix image attributes (width, height, alt, src)
4. Fix link text accessibility
5. Implement security headers (meta tags + hosting config)
6. Create robots.txt
7. Create sitemap.xml
8. Create 404.html
9. Fix favicon data-URI encoding
10. Eliminate render-blocking resources (preload/defer)
11. Convert images to WebP/AVIF
12. Run Lighthouse audit validation
13. Run accessibility audit validation
14. Update tests for new structure

## Validation Gates

| Gate             | Criteria                                       | Method                |
| ---------------- | ---------------------------------------------- | --------------------- |
| Lighthouse Score | Performance > 90, SEO > 90, Accessibility > 90 | Lighthouse CLI        |
| WCAG Compliance  | Zero axe-core violations at Level AA           | axe-core CLI          |
| Security Headers | securityheaders.com score A or above           | Security headers scan |
| Console Errors   | Zero errors in Chrome/Firefox/Safari           | Playwright test       |
| HTML Validation  | htmlhint passes, Prettier formatted            | npm run test:lint     |

## Notes

- All clarifications from spec already resolved during `/speckit.clarify` session
- Tailwind CDN is the primary render-blocking concern; build-time CSS extraction required
- HSTS requires hosting platform configuration (not possible via HTML meta tags alone)
- Single-page application means simplified sitemap.xml with one URL
