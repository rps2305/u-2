# Implementation Tasks: SEO & Accessibility Audit Fixes

**Feature**: SEO & Accessibility Audit Fixes | **Branch**: `003-seo-accessibility-audit`
**Generated**: 2026-01-05 | **Spec**: [spec.md](spec.md) | **Plan**: [plan.md](plan.md)

## Dependencies

```
Phase 1 (Setup)
    │
    ├── T001-T003 (Setup tools)
    │
    ▼
Phase 2 (Foundational) ──────▶ Phase 3 (US1 - Metadata & Headings)
    │                                │
    ├── T004-T007 (Hosting config)   ├── T008-T012 (Metadata)
    │                                └── T013-T017 (Headings)
    │
    ▼
Phase 4 (US2 - Images & Links) ──── Parallel execution
    │
    ├── T018-T024 (Image compliance)
    └── T025-T028 (Link accessibility)
    │
    ▼
Phase 5 (US4 - Security) ──── Parallel with Phase 6
    │
    ├── T029-T033 (Security headers)
    └── T034-T036 (Favicon fix)
    │
    ▼
Phase 6 (US5 - Performance)
    │
    ├── T037-T041 (Render-blocking)
    └── T042-T047 (Image optimization)
    │
    ▼
Phase 7 (US6 - Files)
    │
    └── T048-T050 (Supporting files)
    │
    ▼
Phase 8 (Polish & Validation)
    │
    └── T051-T055 (Validation & cleanup)
```

## Phase 1: Setup

**Goal**: Verify development environment and install required tools

**Independent Test Criteria**:

- npm install completes without errors
- Playwright chromium browser installed
- Sharp CLI available for image optimization

### Tasks

- [ ] T001 Install project dependencies in /Users/ronald/Developer/www/u-2 using `npm install`
- [ ] T002 [P] Install Playwright chromium browser using `npx playwright install chromium`
- [ ] T003 [P] Verify Sharp CLI availability by running `npx sharp --version`

**Status**: ⏳ PENDING - Prerequisites must be completed before Phase 2.

## Phase 2: Foundational

**Goal**: Configure hosting platform for security headers (blocking for US4)

**Independent Test Criteria**:

- `_headers` file (Netlify) or `vercel.json` (Vercel) exists at project root
- Security headers configured per data-model.md specification

### Tasks

- [ ] T004 Detect hosting platform and create appropriate headers configuration file (\_headers for Netlify or vercel.json for Vercel) at /Users/ronald/Developer/www/u-2
- [ ] T005 Add HSTS header configuration: `max-age=31536000; includeSubDomains; preload` to hosting config file
- [ ] T006 Add X-Content-Type-Options and X-Frame-Options headers to hosting config file
- [ ] T007 Add Referrer-Policy header to hosting config file

## Phase 3: US1 - Metadata & Headings

**Goal**: Optimize SEO metadata and restructure heading hierarchy

**Independent Test Criteria**:

- Title tag is exactly 52 characters containing "U-2 Spyplane"
- Meta description is exactly 215 characters
- Single H1 per page, headings follow H1 → H2 → H3 pattern
- Heading count reduced to 18 or fewer

### Tasks

- [ ] T008 [US1] Analyze current metadata in src/index.html and document title/description character counts
- [ ] T009 [US1] Update title tag in src/index.html to exactly 52 characters including "U-2 Spyplane"
- [ ] T010 [US1] Update meta description tag in src/index.html to exactly 215 characters
- [ ] T011 [US1] Add canonical URL meta tag: `https://example.com/u-2-spyplane` in src/index.html head
- [ ] T012 [US1] Add Open Graph and Twitter Card meta tags per data-model.md PageMetadata entity in src/index.html
- [ ] T013 [US1] Audit all headings in src/index.html and count current headings (target: reduce from 57 to 18)
- [ ] T014 [US1] Identify and remove duplicate headings in src/index.html
- [ ] T015 [US1] Restructure headings to follow H1 → H2 → H3 pattern without skipping levels in src/index.html
- [ ] T016 [US1] Ensure only one H1 exists in src/index.html with primary keyword
- [ ] T017 [US1] Verify heading hierarchy using htmlhint or manual inspection in src/index.html

## Phase 4: US2 - Images & Links

**Goal**: Fix image attributes and link text accessibility (parallelizable)

**Independent Test Criteria**:

- Zero empty src attributes on img elements
- All images have explicit width/height matching natural aspect ratio
- All non-decorative images have descriptive alt text
- All anchor elements have descriptive text

### Tasks

- [ ] T018 [US2] Audit all img elements in src/index.html for missing src, width, height attributes
- [ ] T019 [US2] Fix img#lightbox-image src attribute (currently empty) in src/index.html
- [ ] T020 [US2] Add explicit width and height attributes to all images in src/index.html matching natural aspect ratio
- [ ] T021 [US2] Audit all img elements for missing alt attributes in src/index.html
- [ ] T022 [US2] Add descriptive alt text to all non-decorative images (max 125 characters) in src/index.html
- [ ] T023 [US2] Add empty alt="" to decorative images in src/index.html
- [ ] T024 [US2] Verify image aspect ratios match width/height attributes in src/index.html
- [ ] T025 [US3] Audit all anchor elements in src/index.html for non-descriptive link text
- [ ] T026 [US3] Replace non-descriptive links like `a.text-white/70` with descriptive text in src/index.html
- [ ] T027 [US3] Add aria-label to icon-only links where visible text is insufficient in src/index.html
- [ ] T028 [US3] Verify all links describe destination or purpose in src/index.html

## Phase 5: US4 - Security

**Goal**: Implement security headers via meta tags (HSTS requires hosting platform from Phase 2)

**Independent Test Criteria**:

- X-Content-Type-Options meta tag present
- X-Frame-Options meta tag present
- Referrer-Policy meta tag present
- Content-Security-Policy meta tag appropriate for static site
- Favicon loads without console errors

### Tasks

- [ ] T029 [US4] Add X-Content-Type-Options: nosniff meta tag in src/index.html head
- [ ] T030 [US4] Add X-Frame-Options: SAMEORIGIN meta tag in src/index.html head
- [ ] T031 [US4] Add Referrer-Policy: strict-origin-when-cross-origin meta tag in src/index.html head
- [ ] T032 [US4] Add Content-Security-Policy meta tag appropriate for static site in src/index.html head
- [ ] T033 [US4] Verify all security meta tags are correctly formatted in src/index.html
- [ ] T034 [US4] Identify illegal characters in SVG favicon data-URI reference in src/index.html
- [ ] T035 [US4] Fix favicon data-URI encoding using base64-encoded SVG per research.md
- [ ] T036 [US4] Test favicon loads without console errors in Chrome, Firefox, Safari

## Phase 6: US5 - Performance

**Goal**: Eliminate render-blocking resources and optimize images to WebP/AVIF

**Independent Test Criteria**:

- No render-blocking resources detected by Lighthouse
- All images served in WebP or AVIF format
- Image optimization achieves 70% size reduction
- Core Web Vitals: LCP < 2.5s, CLS < 0.1, FID < 100ms

### Tasks

- [ ] T037 [US5] Analyze render-blocking resources in src/index.html using Lighthouse
- [ ] T038 [US5] Add preload link for critical CSS in src/index.html head
- [ ] T039 [US5] Defer Tailwind CSS loading using `media="print" onload="this.media='all'"` in src/index.html
- [ ] T040 [US5] Add defer attribute to non-critical JavaScript in src/index.html
- [ ] T041 [US5] Verify no render-blocking resources using Lighthouse audit on src/index.html
- [ ] T042 [US5] Create npm script for image WebP conversion in package.json using Sharp CLI
- [ ] T043 [US5] Create npm script for image AVIF conversion in package.json using Sharp CLI
- [ ] T044 [US5] Convert hero images to WebP format in src/assets/images/hero/ using Sharp CLI
- [ ] T045 [US5] Convert gallery images to WebP format in src/assets/images/gallery/ using Sharp CLI
- [ ] T046 [US5] Update src/index.html img src attributes to reference WebP versions with JPEG fallback
- [ ] T047 [US5] Add picture elements with source sets for format selection in src/index.html

## Phase 7: US6 - Supporting Files

**Goal**: Create robots.txt, sitemap.xml, and 404.html

**Independent Test Criteria**:

- robots.txt exists at project root with appropriate crawl directives
- sitemap.xml exists at project root listing all public URLs
- 404.html exists at project root with navigation and search functionality

### Tasks

- [ ] T048 [US6] Create robots.txt at /Users/ronald/Developer/www/u-2 with User-agent: \* Allow: / directive
- [ ] T049 [US6] Create sitemap.xml at /Users/ronald/Developer/www/u-2 with single page URL and priority 1.0
- [ ] T050 [US6] Create 404.html at /Users/ronald/Developer/www/u-2 with branded design and navigation links

## Phase 8: Polish & Validation

**Goal**: Run all validation checks and ensure feature completeness

**Independent Test Criteria**:

- Lighthouse Performance, SEO, Accessibility scores all >= 90
- Zero WCAG 2.1 Level AA violations (axe-core)
- Zero console errors in Chrome, Firefox, Safari
- htmlhint passes, Prettier formatted

### Tasks

- [ ] T051 Run htmlhint validation on src/index.html using `npm run test:lint`
- [ ] T052 Run Prettier formatting check on src/ directory using `npx prettier --check src/`
- [ ] T053 Run Lighthouse audit and verify Performance, SEO, Accessibility scores >= 90
- [ ] T054 Run Playwright tests to verify zero console errors in browser
- [ ] T055 Update existing tests in tests/e2e/ to match new structure (image attributes, link text)

## Summary

| Phase   | User Story                | Tasks     | Parallel       |
| ------- | ------------------------- | --------- | -------------- |
| Phase 1 | Setup                     | T001-T003 | Yes            |
| Phase 2 | Foundational              | T004-T007 | No             |
| Phase 3 | US1 (Metadata & Headings) | T008-T017 | No             |
| Phase 4 | US2 (Images)              | T018-T024 | Yes            |
| Phase 4 | US3 (Links)               | T025-T028 | Yes (with US2) |
| Phase 5 | US4 (Security)            | T029-T036 | No             |
| Phase 6 | US5 (Performance)         | T037-T047 | Yes            |
| Phase 7 | US6 (Files)               | T048-T050 | No             |
| Phase 8 | Validation                | T051-T055 | Yes            |

**Total Tasks**: 55

**MVP Scope (Phase 3-5)**: Tasks T008-T036 cover the core SEO, accessibility, and security requirements. Phase 6 (Performance) and Phase 7 (Files) are enhancement tasks.

**Parallel Execution Opportunities**:

- Phase 1 tasks are parallelizable (T001, T002, T003)
- Phase 4 tasks within image/link audits are parallelizable (T018-T028)
- Phase 5 favicon fix (T034-T036) can run after security headers
- Phase 6 image conversion tasks are parallelizable (T042-T046)
- Phase 8 validation tasks are parallelizable (T051-T055)

## Independent Test Criteria per User Story

| User Story                | Test Criteria                                                                       |
| ------------------------- | ----------------------------------------------------------------------------------- |
| US1 (Metadata & Headings) | Title=52 chars, Description=215 chars, H1 unique, H2/H3 sequential, 18 headings max |
| US2 (Images)              | Zero empty src, width/height match aspect ratio, alt text present                   |
| US3 (Links)               | All links have descriptive text, no empty or class-based link text                  |
| US4 (Security)            | All security headers present, favicon loads without errors                          |
| US5 (Performance)         | Lighthouse >= 90, WebP images served, no render-blocking                            |
| US6 (Files)               | robots.txt, sitemap.xml, 404.html exist and are valid                               |
