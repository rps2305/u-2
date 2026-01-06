# SEO & Accessibility Audit Fixes

## Overview

This feature addresses critical SEO, performance, and accessibility issues identified in the Lockheed U-2 Spyplane website audit. The audit revealed significant gaps in metadata optimization, heading structure, security headers, and WCAG compliance that impact search engine rankings, user experience, and site security.

The website currently suffers from metadata exceeding recommended limits (title: 86 chars, description: 223 chars), an excessively flat heading hierarchy with 57 headings requiring consolidation, and several accessibility violations including non-descriptive link text and missing image attributes. Security concerns include an illegal character issue in the favicon data-URI and missing HSTS implementation.

These issues collectively impact the site's ability to rank effectively in search results, provide an inclusive experience for users with disabilities, and maintain secure connections. This specification defines the work required to achieve a compliant, accessible, and performant website.

## Clarifications

### Session 2026-01-05

- Q: WCAG compliance level target → A: WCAG 2.1 Level AA (recommended standard)
- Q: Expected page count for sitemap generation → A: 1 page (SPA with anchor sections)
- Q: Image optimization workflow preference → A: Build-time conversion with npm scripts during CI/CD pipeline
- Q: Security header delivery method → A: Meta tags in HTML head (note: HSTS requires hosting platform; meta tags support CSP, Referrer-Policy, and X-UA-Compatible only)
- Q: Render-blocking resource handling approach → A: Use preload for critical assets, defer non-critical CSS/JS

## User Scenarios

### Scenario 1: Search Engine Discovery

A potential visitor searches for "Lockheed U-2 spyplane history" on Google. The search engine should successfully crawl, index, and display the page with optimized metadata that accurately represents the content. The canonical URL must be properly defined to prevent duplicate content issues.

### Scenario 2: Screen Reader Navigation

A visually impaired user navigates the site using a screen reader. All images must have descriptive alt text, all interactive elements must be properly labeled, and heading hierarchy must provide a logical page structure that enables efficient navigation between sections.

### Scenario 3: Mobile Performance

A user on a mobile device with limited connectivity accesses the site. The page should load quickly with optimized images, no render-blocking resources, and proper aspect ratios preserved across all viewports to prevent layout shifts during loading.

### Scenario 4: Security Compliance

An enterprise user accesses the site over a corporate network. The site must enforce HTTPS connections, include proper security headers, and not trigger security warnings in the browser console that could indicate vulnerabilities.

### Scenario 5: Custom Error Handling

A user navigates to a non-existent page. The site should display a helpful 404 page with navigation options rather than a generic browser error, maintaining brand consistency while helping users find their intended destination.

## Success Criteria

The implementation must achieve the following measurable outcomes:

1. **Metadata Optimization**: Title tag must be between 20-60 characters (currently 86). Meta description must be between 150-220 characters (currently 223). Both must accurately summarize page content while incorporating target keywords.

2. **Heading Structure**: Reduce heading count from 57 to a logical hierarchy not exceeding 15-20 headings with proper H1-H6 progression. Each heading must accurately describe its section content.

3. **Image Compliance**: Zero empty src attributes on any img element. All images must have width and height attributes matching natural aspect ratios. All non-decorative images must have descriptive alt text.

4. **Link Accessibility**: All anchor elements must have descriptive, accessible text. Remove or relabel non-descriptive links like `a.text-white/70`.

5. **Security Headers**: Implement HSTS with appropriate max-age. Include X-Frame-Options, X-Content-Type-Options, and Referrer-Policy headers.

6. **Core Web Vitals**: PageSpeed score above 90 on mobile. Largest Contentful Paint under 2.5 seconds. Cumulative Layout Shift below 0.1. First Input Delay under 100 milliseconds.

7. **File Compliance**: Create robots.txt allowing crawling of content while blocking sensitive paths. Create sitemap.xml listing all public pages. Create custom 404.html with navigation assistance.

8. **Favicon Compliance**: Fix illegal characters in SVG favicon data-URI references. Ensure favicon loads without console errors.

## Functional Requirements

### Requirement 1: Metadata Optimization

The system must optimize page title and description for search engines.

**Acceptance Criteria:**

- Title tag is exactly 52 characters with primary keyword "U-2 Spyplane" included
- Meta description is exactly 215 characters with compelling call-to-action
- Title and description remain within Google search result character limits
- Metadata accurately reflects page content and target audience

### Requirement 2: Heading Hierarchy Restructure

The system must reorganize heading structure to follow logical hierarchy.

**Acceptance Criteria:**

- Single H1 per page that includes primary keyword
- Headings follow sequential H2-H3 pattern without skipping levels
- Total heading count reduced to 18 or fewer
- Each heading text is unique and descriptive of section content
- No empty or redundant headings exist in document

### Requirement 3: Image Attribute Compliance

The system must ensure all images have proper attributes.

**Acceptance Criteria:**

- img#lightbox-image has valid src attribute (not empty)
- All images have explicit width and height attributes
- Width and height match natural image aspect ratio
- All non-decorative images have descriptive alt text
- Decorative images have empty alt="" attribute

### Requirement 4: Link Text Accessibility

The system must ensure all links are accessible.

**Acceptance Criteria:**

- All anchor elements have visible text content
- Link text describes destination or purpose
- No links with purely presentational classes as text
- aria-label used only when visible text insufficient

### Requirement 5: Security Header Implementation

The system must implement required security headers.

**Acceptance Criteria:**

- Strict-Transport-Security header implemented via hosting platform (meta tags cannot set HSTS)
- X-Content-Type-Options set to "nosniff" (via meta tag or hosting platform)
- X-Frame-Options set to "SAMEORIGIN" (via meta tag or hosting platform)
- Referrer-Policy set to "strict-origin-when-cross-origin" (via meta tag)
- Content-Security-Policy appropriate for static site (via meta tag)

### Requirement 6: Supporting File Creation

The system must create missing supporting files.

**Acceptance Criteria:**

- robots.txt exists at root with appropriate crawl directives
- sitemap.xml exists at root listing all public URLs
- 404.html exists at root with site navigation and search functionality
- All files follow project design system and styling conventions

### Requirement 7: Favicon Data-URI Fix

The system must fix favicon references.

**Acceptance Criteria:**

- SVG favicon data-URI contains no illegal characters
- Favicon loads without console errors in all supported browsers
- Favicon displays correctly in browser tabs and mobile home screens

### Requirement 8: Render-Blocking Resource Elimination

The system must eliminate render-blocking resources.

**Acceptance Criteria:**

- Critical CSS and JavaScript preloaded via `<link rel="preload">`
- Non-critical CSS loaded with `media="print" onload="this.media='all'"` or deferred
- Non-critical JavaScript loaded with `defer` attribute
- Third-party scripts loaded with `defer` or `async` attributes
- No render-blocking resources detected by Lighthouse

### Requirement 9: Modern Image Format Support

The system must support modern image formats for improved performance.

**Acceptance Criteria:**

- All images served in WebP or AVIF format with JPEG fallback
- Picture elements used for format selection where appropriate
- Image optimization achieves 70% size reduction from original

**Dependency**: This requirement defers to `001-image-webp-optimization` feature for image conversion pipeline. The 003-seo-audit feature verifies that converted images are correctly referenced in HTML.

**Implementation Note**: Run `node scripts/convert-to-webp.js --source ./src/assets/images` from the 001-image-webp-optimization feature before validating this requirement.

## Key Entities

### PageMetadata Entity

Represents SEO metadata for a page.

| Field        | Type   | Description                                         |
| ------------ | ------ | --------------------------------------------------- |
| title        | string | Page title (20-60 characters)                       |
| description  | string | Meta description (150-220 characters)               |
| canonicalUrl | URL    | Primary URL for canonical reference                 |
| ogType       | string | Open Graph type (typically "website")               |
| twitterCard  | string | Twitter card type (typically "summary_large_image") |

### Heading Entity

Represents document heading structure.

| Field    | Type      | Description                  |
| -------- | --------- | ---------------------------- |
| level    | integer   | Heading level (1-6)          |
| text     | string    | Heading text content         |
| parent   | Heading   | Parent heading for hierarchy |
| children | Heading[] | Child headings               |

### SecurityHeader Entity

Represents HTTP security headers.

| Field    | Type    | Description                 |
| -------- | ------- | --------------------------- |
| name     | string  | Header name                 |
| value    | string  | Header value                |
| required | boolean | Whether header is mandatory |

### ImageEntity

Represents optimized image asset.

| Field  | Type    | Description                     |
| ------ | ------- | ------------------------------- |
| src    | string  | Image source URL                |
| alt    | string  | Descriptive alt text            |
| width  | integer | Display width in pixels         |
| height | integer | Display height in pixels        |
| format | string  | Image format (WebP, AVIF, JPEG) |
| sizes  | string  | Responsive sizes attribute      |

### ImageConversionWorkflow

Represents build-time image optimization pipeline.

| Field         | Type     | Description                             |
| ------------- | -------- | --------------------------------------- |
| trigger       | string   | CI/CD pipeline execution                |
| inputFormats  | string[] | Source formats (JPEG, PNG)              |
| outputFormats | string[] | Target formats (WebP, AVIF)             |
| quality       | integer  | Compression quality (1-100)             |
| sizeReduction | number   | Target reduction percentage (0.7 = 70%) |

## Assumptions

The following assumptions were made based on the feature description and common industry practices:

1. The site is a static HTML site without server-side rendering capability, so security headers must be implemented via the hosting platform or meta tags where applicable.

2. Image optimization tools (Sharp, ImageMagick) are already available in the project for WebP/AVIF conversion.

3. The hosting platform supports custom 404 pages and .htaccess or equivalent configuration for security headers.

4. The project uses Tailwind CSS via CDN for development, which may contribute to render-blocking concerns to be addressed.

5. All existing content (U-2 specifications, history, etc.) is accurate and only needs structural optimization rather than content changes.

6. The canonical URL follows the pattern https://example.com/u-2-spyplane based on existing metadata references.

7. Third-party analytics or tracking scripts are not in scope for this audit and may require separate optimization.

## Out of Scope

The following items are explicitly excluded from this feature:

- Content writing or content accuracy verification (beyond structural changes)
- JavaScript functionality changes beyond accessibility fixes
- Backend or database changes
- User authentication or authorization features
- Payment processing or e-commerce functionality
- Social media integration beyond existing metadata
- Email subscription or newsletter functionality
- Analytics implementation or tracking
- Internationalization or localization
- Accelerated Mobile Pages (AMP) implementation

## Dependencies

This feature depends on the following external factors:

- Access to hosting platform configuration for security headers
- Image processing tools available for format conversion
- Existing development workflow for CSS/JS asset building
- Domain configuration for canonical URL verification

## Acceptance Scenarios

### Scenario 1: Google Search Results Display

**Given** the user searches for "U-2 spyplane specifications"  
**When** Google displays search results  
**Then** the page title shows "Lockheed U-2 Spyplane | Specs & History" (52 chars)  
**And** the meta description shows optimized 215-character summary  
**And** the URL displays the canonical URL without query parameters

### Scenario 2: Voice Navigation with Screen Reader

**Given** a user with visual impairment navigates using VoiceOver  
**When** the user tabs through page content  
**Then** each image announces its descriptive alt text  
**And** headings provide logical document outline  
**And** all links announce their destination clearly  
**And** no empty or confusing link text is encountered

### Scenario 3: Mobile Page Load Performance

**Given** a mobile user on 3G connection  
**When** the user navigates to the page  
**Then** first contentful paint occurs within 1.8 seconds  
**And** no layout shifts occur after initial render  
**And** page becomes interactive within 3 seconds

### Scenario 4: Security Audit Passes

**Given** a security auditor runs automated scanning tools  
**When** the site is analyzed  
**Then** no mixed content warnings appear  
**And** HSTS header is present with one-year max-age  
**And** favicon loads without illegal character errors  
**And** all security headers meet baseline requirements

### Scenario 5: Broken Link Navigation

**Given** a user visits /nonexistent-page  
**When** the page loads  
**Then** a branded 404 page displays with search functionality  
**And** main navigation links remain accessible  
**And** user can easily return to valid content

## URL Strategy

### Primary Canonical URL

The primary canonical URL is defined as:

```
https://example.com/u-2-spyplane
```

**Rationale:** This URL pattern follows the existing metadata conventions in the codebase and provides a clean, descriptive path that includes the primary target keyword "U-2-spyplane" for SEO purposes.

### URL Structure Rules

1. All internal links must use relative paths or the canonical URL pattern
2. Query parameters and tracking codes must not appear in canonical URLs
3. HTTP requests must redirect to HTTPS
4. www and non-www variants must redirect to preferred version
5. Trailing slashes must be consistent across all URLs

### Sitemap Requirements

The sitemap.xml must include:

- Single page URL (index.html)
- No sub-pages as this is a single-page application
- Priority (1.0 for homepage)

## Notes

The technical innovations section currently references the Pratt & Whitney J57 engine but provides modern F118 thrust specifications, creating a factual inconsistency that should be corrected during implementation. Similarly, the Tony LeVier birth year is listed as 1923 but should be 1913 based on verification notes.

These factual corrections should be made alongside the SEO and accessibility fixes to ensure the site provides accurate information.

## Definition of Done

The feature is complete when:

1. All acceptance criteria for Requirements 1-9 are verified passing
2. Automated accessibility scan (axe-core) reports zero WCAG 2.1 Level AA violations
3. Automated SEO audit (Lighthouse) scores above 90 in all categories
4. Manual testing confirms all user scenarios function correctly
5. All created files (robots.txt, sitemap.xml, 404.html) are validated
6. Security headers verified via securityheaders.com scoring A or above
7. Code review completed with no critical or major findings
8. Documentation updated to reflect any configuration changes
9. No console errors appear in Chrome, Firefox, and Safari developer tools
