# Static File Contracts

This document defines the contract for static file serving and optimization for the SEO & Accessibility audit feature.

## File Structure Contract

```
src/
├── index.html          # Main page (required)
├── css/
│   └── styles.css      # Critical CSS (required)
├── js/
│   └── main.js         # Defer JS (required)
└── assets/
    └── images/
        ├── hero/       # Hero images
        ├── gallery/    # Gallery images
        ├── logo/       # Logo assets
        └── webp/       # Generated WebP images (build output)
```

## HTML Document Contract

### Required Elements

```html
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />

    <!-- SEO Metadata -->
    <title>U-2 Spyplane | Complete History & Specifications (52 chars)</title>
    <meta name="description" content="..." />
    <!-- 215 chars max -->
    <link rel="canonical" href="https://example.com/u-2-spyplane" />

    <!-- Open Graph -->
    <meta property="og:type" content="website" />
    <meta property="og:title" content="..." />
    <meta property="og:description" content="..." />
    <meta property="og:image" content="..." />
    <meta property="og:url" content="https://example.com/u-2-spyplane" />

    <!-- Twitter Card -->
    <meta name="twitter:card" content="summary_large_image" />
    <meta name="twitter:title" content="..." />
    <meta name="twitter:description" content="..." />
    <meta name="twitter:image" content="..." />

    <!-- Security Headers (via meta tags where supported) -->
    <meta http-equiv="X-Content-Type-Options" content="nosniff" />
    <meta http-equiv="X-Frame-Options" content="SAMEORIGIN" />
    <meta
      http-equiv="Referrer-Policy"
      content="strict-origin-when-cross-origin"
    />

    <!-- Preload Critical Assets -->
    <link rel="preload" href="css/styles.css" as="style" />
    <link rel="preload" href="assets/images/hero/u2-hero-01.webp" as="image" />

    <!-- Critical CSS (inlined) -->
    <style>
      /* Critical CSS here */
    </style>

    <!-- Favicon -->
    <link
      rel="icon"
      type="image/svg+xml"
      href="data:image/svg+xml;base64,..."
    />
    <link
      rel="apple-touch-icon"
      href="assets/images/logo/u2-logo-favicon.webp"
    />
  </head>
  <body>
    <!-- Content -->

    <!-- Defer Non-Critical JS -->
    <script src="js/main.js" defer></script>
  </body>
</html>
```

## Image Contract

### Required Attributes

```html
<!-- Non-decorative image -->
<img
  src="assets/images/hero/u2-hero-01.webp"
  srcset="
    assets/images/hero/u2-hero-01.webp    1x,
    assets/images/hero/u2-hero-01-2x.webp 2x
  "
  sizes="(max-width: 768px) 100vw, 50vw"
  alt="Lockheed U-2 Spyplane in flight over desert terrain"
  width="1920"
  height="1080"
  loading="eager"
  decoding="async"
/>

<!-- Decorative image -->
<img
  src="assets/images/logo/u2-logo-transparent.webp"
  alt=""
  width="200"
  height="94"
  loading="lazy"
  decoding="async"
/>

<!-- Picture element for format fallback -->
<picture>
  <source srcset="assets/images/hero/u2-hero-01.avif" type="image/avif" />
  <source srcset="assets/images/hero/u2-hero-01.webp" type="image/webp" />
  <img
    src="assets/images/hero/u2-hero-01.jpg"
    alt="Lockheed U-2 Spyplane in flight"
    width="1920"
    height="1080"
    loading="eager"
  />
</picture>
```

### Image Naming Convention

```
{u2-hero-NN}.jpg        # Original JPEG
{u2-hero-NN}.webp       # WebP version
{u2-hero-NN}.avif       # AVIF version (if supported)
{u2-hero-NN}-{width}w.webp  # Responsive variant
```

## Link Contract

### Required Pattern

```html
<!-- Descriptive link text -->
<a href="#history" aria-label="Learn about U-2 history">View History</a>

<!-- Descriptive icon link -->
<a href="/downloads" aria-label="Download U-2 specifications PDF">
  <svg>...</svg>
  <span>Download Specs</span>
</a>

<!-- Navigation link -->
<nav aria-label="Main navigation">
  <a href="#hero">Home</a>
  <a href="#history">History</a>
  <a href="#specs">Specifications</a>
  <a href="#gallery">Gallery</a>
</nav>
```

### Invalid Patterns (Must Fix)

```html
<!-- INVALID: Non-descriptive text -->
<a href="#history" class="text-white/70">→</a>
<a href="#gallery" class="hover:text-u2-blue">Read More</a>

<!-- INVALID: Empty link -->
<a href="#"></a>

<!-- INVALID: Missing href -->
<a class="nav-link">Home</a>
```

## Security Headers Contract

### Meta Tags (Limited Support)

```html
<meta http-equiv="X-Content-Type-Options" content="nosniff" />
<meta http-equiv="X-Frame-Options" content="SAMEORIGIN" />
<meta http-equiv="Referrer-Policy" content="strict-origin-when-cross-origin" />
<meta
  http-equiv="Content-Security-Policy"
  content="default-src 'self'; img-src 'self' data: https:;"
/>
```

### Hosting Platform Headers (Full Support)

**Netlify `_headers` file**:

```
/*
  Strict-Transport-Security: max-age=31536000; includeSubDomains; preload
  X-Content-Type-Options: nosniff
  X-Frame-Options: SAMEORIGIN
  Referrer-Policy: strict-origin-when-cross-origin
  Content-Security-Policy: default-src 'self'; img-src 'self' data: https:; script-src 'self' 'unsafe-inline'; style-src 'self' 'unsafe-inline'
```

**Vercel `vercel.json`**:

```json
{
  "headers": [
    {
      "source": "/(.*)",
      "headers": [
        {
          "key": "Strict-Transport-Security",
          "value": "max-age=31536000; includeSubDomains; preload"
        },
        { "key": "X-Content-Type-Options", "value": "nosniff" },
        { "key": "X-Frame-Options", "value": "SAMEORIGIN" },
        {
          "key": "Referrer-Policy",
          "value": "strict-origin-when-cross-origin"
        },
        {
          "key": "Content-Security-Policy",
          "value": "default-src 'self'; img-src 'self' data: https:; script-src 'self' 'unsafe-inline'; style-src 'self' 'unsafe-inline'"
        }
      ]
    }
  ]
}
```

## Supporting Files Contract

### robots.txt

```
User-agent: *
Allow: /

# Sitemap location
Sitemap: https://example.com/u-2-spyplane/sitemap.xml
```

### sitemap.xml

```xml
<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
  <url>
    <loc>https://example.com/u-2-spyplane</loc>
    <changefreq>monthly</changefreq>
    <priority>1.0</priority>
  </url>
</urlset>
```

### 404.html

```html
<!DOCTYPE html>
<html lang="en">
  <head>
    <title>Page Not Found | U-2 Spyplane</title>
    <meta name="robots" content="noindex" />
  </head>
  <body>
    <main>
      <h1>404 - Page Not Found</h1>
      <p>The page you're looking for doesn't exist.</p>
      <nav>
        <a href="/">Return to Home</a>
        <a href="#history">History</a>
        <a href="#specs">Specifications</a>
        <a href="#gallery">Gallery</a>
      </nav>
    </main>
  </body>
</html>
```

## Validation Contract

### HTML Validation (htmlhint)

```json
{
  "tag-pair": true,
  "id-unique": true,
  "src-not-empty": true,
  "alt-require": true,
  "doctype-first": true,
  "charset-require": true,
  "viewport-fit": true
}
```

### Accessibility Validation (axe-core)

```javascript
{
  runOnly: {
    type: 'tag',
    values: ['wcag2a', 'wcag2aa', 'wcag21a', 'wcag21aa']
  }
}
```

### Performance Validation (Lighthouse)

```json
{
  "categories:performance": ["error", { "minScore": 0.9 }],
  "categories:accessibility": ["error", { "minScore": 0.9 }],
  "categories:best-practices": ["error", { "minScore": 0.9 }],
  "categories:seo": ["error", { "minScore": 0.9 }]
}
```
