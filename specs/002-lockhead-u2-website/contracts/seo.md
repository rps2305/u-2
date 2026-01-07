# SEO Optimization Contracts

## robots.txt Contract
```txt
# robots.txt for Lockhead U-2 Website
# Allow all search engines to crawl the site

User-agent: *
Allow: /

# Block access to build files and utilities
Disallow: /node_modules/
Disallow: /src/css/input.css
Disallow: /package*.json
Disallow: /tailwind.config.js
Disallow: /postcss.config.js

# Sitemap location
Sitemap: https://www.ronaldpunt.nl/sitemap.xml
```

## sitemap.xml Contract
```xml
<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
  <url>
    <loc>https://www.ronaldpunt.nl/</loc>
    <lastmod>2026-01-07</lastmod>
    <changefreq>monthly</changefreq>
    <priority>1.0</priority>
  </url>
</urlset>
```

## SEO Meta Tags Contract
```html
<!-- Essential Meta Tags -->
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="[COMPREHENSIVE_DESCRIPTION_OF_U2_AIRCRAFT]">
<meta name="keywords" content="Lockheed U-2, U-2 spy plane, reconnaissance aircraft, aviation history, military aircraft">
<meta name="author" content="Ronald Punt">
<meta name="robots" content="index, follow">

<!-- Open Graph / Facebook -->
<meta property="og:type" content="website">
<meta property="og:url" content="https://www.ronaldpunt.nl/">
<meta property="og:title" content="[SITE_TITLE]">
<meta property="og:description" content="[COMPREHENSIVE_DESCRIPTION_OF_U2_AIRCRAFT]">
<meta property="og:image" content="https://www.ronaldpunt.nl/images/og-image.jpg">

<!-- Twitter -->
<meta property="twitter:card" content="summary_large_image">
<meta property="twitter:url" content="https://www.ronaldpunt.nl/">
<meta property="twitter:title" content="[SITE_TITLE]">
<meta property="twitter:description" content="[COMPREHENSIVE_DESCRIPTION_OF_U2_AIRCRAFT]">
<meta property="twitter:image" content="https://www.ronaldpunt.nl/images/twitter-image.jpg">

<!-- Technical SEO -->
<link rel="canonical" href="https://www.ronaldpunt.nl/">
<link rel="icon" type="image/x-icon" href="/favicon.ico">
<link rel="apple-touch-icon" sizes="180x180" href="/apple-touch-icon.png">
<link rel="icon" type="image/png" sizes="32x32" href="/favicon-32x32.png">
<link rel="icon" type="image/png" sizes="16x16" href="/favicon-16x16.png">

<!-- Preconnect to external domains -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://www.ronaldpunt.nl">
```

## Structured Data Contract
```html
<!-- Website Schema -->
<script type="application/ld+json">
{
  "@context": "https://schema.org",
  "@type": "Website",
  "name": "[SITE_TITLE]",
  "description": "[COMPREHENSIVE_DESCRIPTION_OF_U2_AIRCRAFT]",
  "url": "https://www.ronaldpunt.nl/",
  "author": {
    "@type": "Person",
    "name": "Ronald Punt",
    "email": "ronald@ronaldpunt.nl",
    "url": "https://www.ronaldpunt.nl"
  },
  "publisher": {
    "@type": "Organization",
    "name": "Ronald Punt",
    "url": "https://www.ronaldpunt.nl"
  }
}
</script>

<!-- Article Schema for Aircraft Content -->
<script type="application/ld+json">
{
  "@context": "https://schema.org",
  "@type": "Article",
  "headline": "Lockheed U-2 Spy Aircraft - History and Technical Specifications",
  "description": "Comprehensive information about the Lockheed U-2 reconnaissance aircraft, including its history, technical specifications, missions, and operational use.",
  "author": {
    "@type": "Person",
    "name": "Ronald Punt"
  },
  "publisher": {
    "@type": "Organization",
    "name": "Ronald Punt"
  },
  "datePublished": "2026-01-07",
  "dateModified": "2026-01-07",
  "mainEntityOfPage": {
    "@type": "WebPage",
    "@id": "https://www.ronaldpunt.nl/"
  }
}
</script>

<!-- Image Object Schema for Gallery -->
<script type="application/ld+json">
{
  "@context": "https://schema.org",
  "@type": "ImageObject",
  "name": "Lockheed U-2 Aircraft Gallery",
  "description": "High-quality images of the Lockheed U-2 reconnaissance aircraft in various operational configurations.",
  "url": "https://www.ronaldpunt.nl/images/gallery/",
  "author": {
    "@type": "Person",
    "name": "Ronald Punt"
  }
}
</script>
```

## Content SEO Requirements

### Heading Structure
```html
<h1>Lockheed U-2 Spy Aircraft - Comprehensive Guide</h1>

<h2>History of the U-2</h2>
<h3>Development and Design</h3>
<h3>Cold War Operations</h3>

<h2>Technical Specifications</h2>
<h3>Performance Characteristics</h3>
<h3>Avionics and Sensors</h3>

<h2>Mission Capabilities</h2>
<h3>Reconnaissance Operations</h3>
<h3>Intelligence Gathering</h3>

<h2>Operational History</h2>
<h3>Notable Missions</h3>
<h3>Modern Applications</h3>

<h2>Detailed Specifications</h2>
<h3>Dimensions and Weight</h3>
<h3>Engine and Performance</h3>
<h3>Equipment and Systems</h3>
```

### Image SEO Requirements
- All images must have alt attributes
- Descriptive file names (u2-aircraft-side-view.webp)
- Structured data for image objects
- Lazy loading for below-the-fold images
- WebP format with fallbacks

### Internal Linking Strategy
- Navigation menu links to all major sections
- Cross-links between related content sections
- Image gallery links from relevant content sections
- Contact section accessible from all pages

### Performance Requirements for SEO
- Page load time < 2 seconds
- Mobile-first responsive design
- Core Web Vitals compliance
- Minified CSS and JavaScript
- Optimized images with proper sizing