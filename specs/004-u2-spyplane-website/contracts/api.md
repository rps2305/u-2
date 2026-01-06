# API Contracts: U-2 Spyplane Informational Website

## Overview

This is a **static website** with no backend API. All content is pre-rendered HTML with client-side JavaScript for interactivity.

## No API Required

The website operates entirely client-side:

- **Static HTML**: All content is in `src/index.html`
- **Local Images**: All images are in `src/assets/images/`
- **Client JavaScript**: Gallery and lightbox in `src/js/main.js`
- **Static CSS**: Tailwind CSS compiled to `public/styles.css`

## Static Asset Contracts

### Image Assets

| Path Pattern | Type | Description |
|--------------|------|-------------|
| `src/assets/images/hero/*.webp` | image/webp | Hero section background images |
| `src/assets/images/gallery/*.webp` | image/webp | Gallery thumbnail images |
| `src/assets/images/thumb/*.webp` | image/webp | Optimized thumbnail variants |

### JavaScript Contracts

| File | Purpose | Exports |
|------|---------|---------|
| `src/js/main.js` | Main application logic | `initGallery()`, `initLightbox()` |
| `src/js/navigation.js` | Responsive navigation | `initMobileMenu()` |

### CSS Contracts

| File | Purpose | Dependencies |
|------|---------|--------------|
| `src/css/styles.css` | Custom styles | Tailwind CSS |
| `tailwind.config.js` | Tailwind configuration | PostCSS |

## Third-Party Services

### CDN Dependencies (Development)

| Service | Purpose | URL |
|---------|---------|-----|
| Tailwind CSS | Utility-first CSS framework | https://cdn.tailwindcss.com |

### Local Dependencies (Production)

| Package | Purpose | Version |
|---------|---------|---------|
| tailwindcss | CSS framework | ^3.4.0 |
| postcss | CSS transformation | ^8.4.0 |
| autoprefixer | Vendor prefixing | ^10.4.0 |

## Build Output Contract

When built for production, the following files are generated in `public/`:

| Output File | Source | Description |
|-------------|--------|-------------|
| `index.html` | `src/index.html` | Optimized HTML |
| `styles.css` | `src/css/styles.css` | Purged CSS |
| `main.js` | `src/js/main.js` | Bundled JavaScript |
| `assets/images/*.webp` | `src/assets/images/` | Copied images |

## No Backend Integration

This website does not require:
- Database
- Authentication service
- Content management system
- Analytics backend
- Image transformation API

All functionality is provided by static assets and client-side JavaScript.
