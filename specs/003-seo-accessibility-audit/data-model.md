# Data Model: SEO & Accessibility Audit Fixes

## Overview

This document defines the data structures and entities for the SEO and accessibility optimization feature. As a static site, data models represent configuration, metadata, and optimization parameters rather than runtime data entities.

## Core Entities

### PageMetadata

Represents SEO metadata for the single-page website.

```typescript
interface PageMetadata {
  /** Page title (20-60 characters for SEO) */
  title: string;

  /** Meta description (150-220 characters for SEO) */
  description: string;

  /** Primary URL for canonical reference */
  canonicalUrl: string;

  /** Open Graph type (default: "website") */
  ogType: "website" | "article";

  /** Twitter card type (default: "summary_large_image") */
  twitterCard: "summary" | "summary_large_image";

  /** Open Graph image URL for social sharing */
  ogImage?: string;

  /** Page language (default: "en") */
  lang: string;

  /** Meta robots directive (default: "index, follow") */
  robots: string;
}
```

**Validation Rules**:

- title: 20-60 characters, must include "U-2 Spyplane"
- description: 150-220 characters, unique, compelling
- canonicalUrl: valid URL format, HTTPS required
- lang: ISO 639-1 language code

**Default Values**:

```json
{
  "ogType": "website",
  "twitterCard": "summary_large_image",
  "lang": "en",
  "robots": "index, follow"
}
```

### Heading

Represents document heading structure for accessibility and SEO.

```typescript
interface Heading {
  /** Heading level (1-6, H1-H6) */
  level: 1 | 2 | 3 | 4 | 5 | 6;

  /** Heading text content */
  text: string;

  /** Unique ID for anchor linking (auto-generated from text) */
  id: string;

  /** Parent heading (null for H1) */
  parent: Heading | null;

  /** Child headings */
  children: Heading[];

  /** Character count for validation */
  charCount: number;

  /** Whether heading is unique on page */
  isUnique: boolean;
}
```

**Validation Rules**:

- Single H1 per page (level 1)
- No skipped levels (must follow H1 → H2 → H3 pattern)
- Each heading text must be unique on page
- H1: 20-60 characters
- H2-H3: 30-80 characters
- H4-H6: 20-60 characters

### ImageEntity

Represents optimized image asset for the website.

```typescript
interface ImageEntity {
  /** Source URL (relative path) */
  src: string;

  /** Descriptive alt text for accessibility */
  alt: string;

  /** Display width in pixels */
  width: number;

  /** Display height in pixels */
  height: number;

  /** Image format (WebP, AVIF, or JPEG) */
  format: "webp" | "avif" | "jpeg" | "png";

  /** Responsive sizes attribute */
  sizes?: string;

  /** Whether image is decorative (empty alt allowed) */
  isDecorative: boolean;

  /** Loading strategy */
  loading: "eager" | "lazy";

  /** Original file size in bytes */
  originalSize: number;

  /** Optimized file size in bytes */
  optimizedSize: number;
}
```

**Validation Rules**:

- alt: Required for non-decorative images, max 125 characters
- width/height: Must match natural aspect ratio
- format: WebP preferred, AVIF for modern browsers, JPEG fallback
- loading: 'lazy' for below-fold, 'eager' for above-fold (LCP)
- isDecorative: true → alt="" required, false → descriptive alt required

### SecurityHeader

Represents HTTP security header configuration.

```typescript
interface SecurityHeader {
  /** Header name */
  name: string;

  /** Header value */
  value: string;

  /** Whether header is mandatory */
  required: boolean;

  /** Delivery method */
  delivery: "meta" | "hosting" | "both";

  /** Header category */
  category: "transport" | "content" | "referrer" | "permissions";
}
```

**Configuration**:

```typescript
const SECURITY_HEADERS: SecurityHeader[] = [
  {
    name: "Strict-Transport-Security",
    value: "max-age=31536000; includeSubDomains; preload",
    required: true,
    delivery: "hosting",
    category: "transport",
  },
  {
    name: "X-Content-Type-Options",
    value: "nosniff",
    required: true,
    delivery: "both",
    category: "content",
  },
  {
    name: "X-Frame-Options",
    value: "SAMEORIGIN",
    required: true,
    delivery: "both",
    category: "content",
  },
  {
    name: "Referrer-Policy",
    value: "strict-origin-when-cross-origin",
    required: true,
    delivery: "meta",
    category: "referrer",
  },
  {
    name: "Content-Security-Policy",
    value:
      "default-src 'self'; img-src 'self' data: https:; script-src 'self' 'unsafe-inline'; style-src 'self' 'unsafe-inline'",
    required: false,
    delivery: "meta",
    category: "permissions",
  },
];
```

### ImageConversionWorkflow

Represents build-time image optimization pipeline configuration.

```typescript
interface ImageConversionWorkflow {
  /** CI/CD trigger type */
  trigger: "build" | "manual" | "pre-commit";

  /** Source formats to convert from */
  inputFormats: ("jpeg" | "png" | "gif")[];

  /** Target formats to convert to */
  outputFormats: ("webp" | "avif")[];

  /** Compression quality (1-100) */
  quality: number;

  /** Target size reduction percentage (0.7 = 70%) */
  sizeReduction: number;

  /** Resize configuration */
  resize?: {
    maxWidth: number;
    maxHeight: number;
    fit: "cover" | "contain" | "fill" | "inside" | "outside";
  };

  /** Output directory relative to source */
  outputDir: string;
}
```

**Default Configuration**:

```typescript
const IMAGE_WORKFLOW: ImageConversionWorkflow = {
  trigger: "build",
  inputFormats: ["jpeg", "png"],
  outputFormats: ["webp", "avif"],
  quality: 80,
  sizeReduction: 0.7,
  resize: {
    maxWidth: 1920,
    maxHeight: 1080,
    fit: "inside",
  },
  outputDir: "webp",
};
```

### LinkEntity

Represents anchor element for accessibility validation.

```typescript
interface LinkEntity {
  /** DOM element or selector */
  selector: string;

  /** Visible link text */
  text: string;

  /** Destination URL */
  href: string;

  /** ARIA label (if present) */
  ariaLabel?: string;

  /** Whether link is descriptive */
  isDescriptive: boolean;

  /** Suggested improvement if not descriptive */
  suggestedText?: string;
}
```

**Validation Rules**:

- text: Must not be empty, must describe destination
- href: Valid URL format, absolute or relative
- ariaLabel: Only when visible text insufficient
- isDescriptive: false for links like "click here", "read more", class names

## Configuration Files

### robots.txt

```
User-agent: *
Allow: /

# Disallow sensitive paths if any
Disallow: /private/
Disallow: /internal/

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

## Relationship Diagram

```
PageMetadata (1) ←── used by ──→ index.html
Heading (1) ── parent/child ──→ Heading (multiple)
ImageEntity (N) ←── referenced by ──→ index.html
SecurityHeader (N) ── configured in ──→ hosting/meta
ImageConversionWorkflow (1) ── processes ──→ ImageEntity (N)
LinkEntity (N) ←── extracted from ──→ index.html
```
