# Research: U-2 Spyplane Informational Website

## Tailwind CSS for Responsive Static Websites

### Decision: Use Tailwind CSS via PostCSS/npm build

**Rationale**: Tailwind CSS provides excellent responsive design capabilities through its breakpoint system (`sm:`, `md:`, `lg:`, `xl:`, `2xl:`). For a static informational website, the PostCSS/npm build approach offers:

- Automatic purging of unused CSS for minimal file size
- Custom design token configuration
- Better performance than CDN in production
- Consistency with industry standards for modern web development

**Configuration Approach**:
```javascript
// tailwind.config.js
module.exports = {
  content: ['./src/**/*.html'],
  theme: {
    extend: {
      colors: {
        'u2-blue': '#1e3a5f',
        'u2-gray': '#f5f5f5',
      },
      fontFamily: {
        sans: ['Inter', 'system-ui', 'sans-serif'],
      },
    },
  },
  plugins: [],
}
```

**Responsive Image Classes**:
- `w-full h-auto` for fluid images
- `object-cover` for maintaining aspect ratio
- `lazy` loading for performance optimization
- `srcset` attribute for resolution switching

**Sources**:
- Tailwind CSS documentation (responsive design)
- Best practices for static site styling (2024)

---

## WEBP Image Optimization Workflow

### Decision: Pre-convert all source images to WEBP, create responsive srcset variants

**Rationale**: WEBP provides superior compression (25-35% smaller than JPEG) while maintaining quality. For an image-heavy website, this directly impacts:

- Page load time (target: under 3 seconds)
- Bandwidth consumption
- User experience on mobile devices
- Lighthouse performance score

**Image Processing Pipeline**:

| Stage | Tool | Output |
|-------|------|--------|
| Source acquisition | Manual download | PNG/JPEG originals |
| Conversion | cwebp or Squoosh | WEBP files |
| Thumbnail generation | ImageMagick or Sharp | 400px width versions |
| Responsive variants | Sharp or cwebp | Multiple resolutions (400w, 800w, 1200w) |

**Quality Settings**:
- Photos: WEBP quality 80-85%
- Screenshots with text: Quality 90%
- Thumbnails: Quality 75% (smaller file size)

**HTML Implementation**:
```html
<picture>
  <source srcset="image-400.webp 400w, image-800.webp 800w, image-1200.webp 1200w"
          sizes="(max-width: 640px) 400px, (max-width: 1024px) 800px, 1200px"
          type="image/webp">
  <img src="image-800.jpg"
       srcset="image-400.jpg 400w, image-800.jpg 800w, image-1200.jpg 1200w"
       sizes="(max-width: 640px) 400px, (max-width: 1024px) 800px, 1200px"
       alt="U-2 spyplane description"
       loading="lazy"
       class="w-full h-auto rounded-lg">
</picture>
```

**Sources**:
- WebP compression study (Google Developers)
- Responsive images implementation guide (MDN)

---

## Playwright Responsive Testing Patterns

### Decision: Use Playwright for automated responsive testing

**Rationale**: Playwright provides reliable cross-browser testing with viewport emulation. For validating responsive behavior across 50+ breakpoints and 4+ browsers:

**Test Coverage Areas**:

| Test Type | Viewports | Purpose |
|-----------|-----------|---------|
| Layout sanity | 320px, 768px, 1024px, 1920px | Verify core layout works |
| Navigation | All breakpoints | Test responsive menu behavior |
| Image loading | All breakpoints | Verify responsive images render |
| Performance | Desktop only | Measure Core Web Vitals |

**Playwright Configuration**:
```javascript
// playwright.config.js
module.exports = {
  projects: [
    { name: 'mobile', use: { ...devices['iPhone 12'] } },
    { name: 'tablet', use: { ...devices['iPad Air'] } },
    { name: 'desktop', use: { ...devices['Desktop Chrome'] } },
  ],
  reporter: 'html',
}
```

**Sample Test**:
```javascript
// tests/responsive.spec.js
test('gallery loads correctly on mobile', async ({ page }) => {
  await page.setViewportSize({ width: 390, height: 844 });
  await page.goto('/');
  await expect(page.locator('.gallery-grid')).toBeVisible();
  await expect(page.locator('.lightbox')).not.toBeVisible();
});
```

**Sources**:
- Playwright documentation (viewport testing)
- Responsive testing best practices (2024)

---

## HTML Linting Tools for Static Sites

### Decision: Use HTMLhint for HTML validation and Prettier for formatting

**Rationale**: For a static HTML website with Tailwind CSS, these tools ensure code quality:

**HTMLhint Rules** (`.htmlhintrc`):
```json
{
  "tag-pair": true,
  "tag-self-close": true,
  "attr-lowercase": true,
  "attr-value-double-quotes": true,
  "doctype-first": true,
  "id-unique": true,
  "src-not-empty": true,
  "alt-require": true,
  "label-require": true
}
```

**Prettier Configuration** (`.prettierrc`):
```json
{
  "printWidth": 100,
  "tabWidth": 2,
  "useTabs": false,
  "semi": true,
  "singleQuote": false,
  "bracketSpacing": true,
  "htmlWhitespaceSensitivity": "css"
}
```

**CI Integration**:
```yaml
# .github/workflows/lint.yml
- name: Lint HTML
  run: |
    npx htmlhint src/**/*.html
    npx prettier --check src/**/*.html
```

**Sources**:
- HTMLhint documentation
- Prettier documentation

---

## Lightbox Implementation Options

### Decision: Build custom lightweight lightbox (no external library)

**Rationale**: A custom lightbox solution provides:

- Minimal dependencies (only vanilla JavaScript)
- Full control over UX and styling
- Consistent design with Tailwind CSS
- No license concerns or bloat

**Required Features**:
- Keyboard navigation (Escape, Arrow keys)
- Touch swipe support for mobile
- Image caption display
- Previous/Next navigation
- Close on background click
- Smooth transition animations

**Implementation Approach**:
```javascript
// js/lightbox.js
class Lightbox {
  constructor() {
    this.currentIndex = 0;
    this.images = [];
    this.bindEvents();
  }
  
  open(index) {
    this.currentIndex = index;
    this.show();
  }
  
  bindEvents() {
    document.addEventListener('keydown', (e) => {
      if (e.key === 'Escape') this.close();
      if (e.key === 'ArrowLeft') this.prev();
      if (e.key === 'ArrowRight') this.next();
    });
  }
}
```

---

## Resolved Unknowns Summary

| Unknown | Resolution | Rationale |
|---------|------------|-----------|
| Tailwind CDN vs npm build | npm build for production | Better performance, purging, customization |
| Image gallery library | Custom lightbox | Lightweight, consistent styling, full control |
| Lightbox functionality | Keyboard + touch support | Accessibility and mobile support |
| Testing scope | Mobile/Tablet/Desktop per Playwright | Comprehensive coverage without over-testing |

---

## Browser Support Matrix

| Browser | Minimum Version | Support Rationale |
|---------|-----------------|-------------------|
| Chrome | 120+ | Latest stable release |
| Firefox | 120+ | Latest stable release |
| Safari | 16+ | Two major versions back |
| Edge | 120+ | Chromium-based, latest |

---

## Performance Targets

| Metric | Target | Measurement Method |
|--------|--------|-------------------|
| First Contentful Paint | <1.5s | Lighthouse |
| Largest Contentful Paint | <2.5s | Lighthouse |
| Time to Interactive | <3.0s | Lighthouse |
| Lighthouse Performance | 85+ | Lighthouse CI |
| Lighthouse Accessibility | 90+ | Lighthouse CI |
