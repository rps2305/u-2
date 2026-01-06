# Research Findings: SEO & Accessibility Audit Fixes

## Decision: Tailwind CSS Render-Blocking Optimization

**Problem**: Tailwind CSS via CDN blocks initial page render, impacting Core Web Vitals.

**Decision**: Extract critical CSS for inlining, defer full Tailwind build.

**Rationale**:

- Inlining critical CSS in `<head>` eliminates render-blocking for above-the-fold content
- Deferring full Tailwind CSS allows progressive enhancement
- This approach maintains development workflow while optimizing production performance
- Alternative (loading Tailwind from local build) requires build step but is cleaner

**Alternatives Considered**:

1. Build Tailwind locally and serve locally - Requires build step, more complex
2. Load Tailwind async with Filament Group's loadCSS - Adds dependency, more complex
3. Use Tailwind Play CDN with optimization - Still render-blocks, not production-ready

## Decision: HSTS Implementation for Static Sites

**Problem**: HSTS cannot be set via HTML meta tags; requires HTTP header.

**Decision**: Implement HSTS via hosting platform configuration (Netlify \_headers or Vercel headers).

**Rationale**:

- HSTS (Strict-Transport-Security) is an HTTP response header, not meta tag content
- Netlify supports `_headers` file at repository root for custom headers
- Vercel supports `vercel.json` for header configuration
- This is the standard approach for static site hosting platforms

**Implementation**:

```
Strict-Transport-Security: max-age=31536000; includeSubDomains; preload
```

**Alternatives Considered**:

1. Use meta http-equiv="refresh" - Does not set HSTS header
2. Server-side redirect - Requires backend, not available for static sites
3. CDN configuration - More complex than hosting platform native support

## Decision: SVG Favicon Data-URI Encoding

**Problem**: Illegal characters in SVG favicon data-URI cause console errors.

**Decision**: Use base64-encoded SVG with proper URL-safe encoding.

**Rationale**:

- SVG characters must be properly escaped in data-URI format
- Base64 encoding eliminates character encoding issues
- Works across all modern browsers
- Validates without console warnings

**Implementation**:

```html
<link
  rel="icon"
  type="image/svg+xml"
  href="data:image/svg+xml;base64,PHN2Zy..."
/>
```

**Escaping Rules**:

- `#` must be encoded as `%23` in unencoded SVG data-URIs
- Use base64 to avoid encoding complexity

## Decision: Lighthouse CI Integration

**Problem**: Need automated Lighthouse scoring in CI pipeline.

**Decision**: Use Google Chrome/Lighthouse CLI with GitHub Actions.

**Rationale**:

- Lighthouse CLI provides command-line access to Lighthouse audits
- GitHub Actions supports Chrome installation via setup-chrome action
- Results can be saved as artifacts and fail build on threshold violations
- Standard approach for static site CI/CD

**Implementation**:

```yaml
- name: Run Lighthouse CI
  run: |
    npm install -g @lhci/cli
    lhci autorun
```

**Configuration** (lhci.json):

```json
{
  "ci": {
    "collect": {
      "numberOfRuns": 3,
      "settings": {
        "staticDistDir": "./dist"
      }
    },
    "assert": {
      "assertions": {
        "categories:performance": ["error", { "minScore": 0.9 }],
        "categories:accessibility": ["error", { "minScore": 0.9 }],
        "categories:best-practices": ["error", { "minScore": 0.9 }],
        "categories:seo": ["error", { "minScore": 0.9 }]
      }
    }
  }
}
```

## Best Practices Summary

### Render-Blocking Resources

- Inline critical CSS (<14KB) in HTML head
- Use `<link rel="preload">` for critical assets
- Defer non-critical CSS with `media="print" onload="this.media='all'"`
- Add `defer` attribute to non-critical JavaScript

### Security Headers for Static Sites

- HSTS: Hosting platform configuration required
- X-Content-Type-Options: `nosniff` (via meta tag or hosting)
- X-Frame-Options: `SAMEORIGIN` (via meta tag or hosting)
- Referrer-Policy: `strict-origin-when-cross-origin` (via meta tag)
- CSP: Appropriate for static content (via meta tag)

### Image Optimization

- Convert to WebP/AVIF at build time
- Use `<picture>` element for format fallback
- Specify explicit width/height to prevent CLS
- Lazy load below-the-fold images

### Accessibility (WCAG 2.1 AA)

- All images need descriptive alt text
- Headings must follow logical hierarchy (no skipping levels)
- Links must have descriptive text (no "click here")
- Color contrast must meet 4.5:1 ratio
- Focus indicators must be visible

## Tooling Decisions

| Category              | Tool           | Justification                            |
| --------------------- | -------------- | ---------------------------------------- |
| Image Optimization    | Sharp CLI      | Node.js native, fast, supports WebP/AVIF |
| HTML Linting          | htmlhint       | Configurable, catches common issues      |
| CSS Formatting        | Prettier       | Industry standard, integrates well       |
| E2E Testing           | Playwright     | Multi-browser, good CI support           |
| Accessibility Testing | axe-core       | WCAG compliance, CLI available           |
| Performance Testing   | Lighthouse CLI | Google official, comprehensive           |
