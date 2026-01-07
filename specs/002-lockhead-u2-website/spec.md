# Feature Specification: Static Responsive HTML Website

**Date**: 2026-01-07  
**Requested Features**: 
- Static responsive HTML website
- SEO optimized
- Tailwind CSS (not on CDN) with PostCSS
- Local images downloaded, converted to WebP with SIPS and CWEBP
- Responsive images with srcset
- LightBox library for gallery
- Smooth scrolling
- robots.txt and sitemap.xml
- Matomo script integration (when needed)

## Requirements

### Technical Requirements
- HTML5 + CSS3 + JavaScript ES2022
- Tailwind CSS with PostCSS processing (local, not CDN)
- Image optimization: WebP format, multiple sizes (320px, 768px, 1024px, 1920px), srcset attributes
- LightBox gallery implementation
- Smooth scrolling navigation
- SEO optimization (meta tags, semantic HTML)
- robots.txt and sitemap.xml generation
- Responsive breakpoints: 320px (mobile), 768px (tablet), 1024px (desktop), 1920px (wide)

### Performance Requirements
- Responsive design for all screen sizes: 320px (mobile), 768px (tablet), 1024px (desktop), 1920px (wide)
- Optimized image loading with proper sizing using srcset attributes
- Page load performance targets: LCP < 2.5s, FID < 100ms, CLS < 0.1
- Mobile-first approach with progressive enhancement
- Lighthouse performance score >90, accessibility >95, SEO >90

### Content Requirements
- Gallery with lightbox functionality
- Smooth scrolling between sections
- SEO-friendly structure
- Matomo analytics integration capability:
  - Script placeholder ready for site ID configuration
  - Event tracking for gallery interactions and navigation
  - Privacy-compliant implementation with cookie consent

## Success Criteria
1. Fully responsive website that works on all devices
2. All images optimized and converted to WebP format
3. LightBox gallery functions properly
4. Smooth scrolling implemented
5. SEO optimized with proper meta tags and structure
6. robots.txt and sitemap.xml present and valid
7. Matomo script can be easily integrated when needed

## Constraints
- Must use Tailwind CSS locally (not CDN)
- Must use PostCSS for processing
- All images must be local and WebP format
- Must follow web standards and best practices