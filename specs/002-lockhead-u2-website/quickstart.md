# Quickstart Guide: Lockhead U-2 Website

**Purpose**: Rapid setup and development guide for the Lockhead U-2 informational website with optimized static architecture.

## Prerequisites

- Node.js 18+ for development tools
- Tailwind CSS CLI for build processing
- Modern web browser for testing
- Image optimization tools (SIPS, cwebp)
- Text editor (VS Code recommended)

## Project Setup

### 1. Clone Repository
```bash
git clone <repository-url>
cd lockhead-u2-website
```

### 2. Install Dependencies
```bash
npm install
npm install -D tailwindcss postcss autoprefixer lightbox2
npm install -D @types/node
```

### 3. Development Server
```bash
npm run dev  # Starts local development server with hot reload
```

### 4. Build Process
```bash
npm run build    # Production build with optimization
npm run serve    # Preview production build locally
```

## Directory Structure

```
lockhead-u2-website/
├── src/
│   ├── components/          # Reusable UI components
│   │   ├── hero-section.js
│   │   ├── navigation.js
│   │   ├── gallery.js
│   │   └── footer.js
│   ├── data/             # Static content data
│   │   ├── aircraft-info.json
│   │   ├── gallery-images.json
│   │   ├── site-config.json
│   │   └── navigation.json
│   ├── styles/            # CSS files
│   │   ├── main.css       # Tailwind output
│   │   └── components.css  # Component-specific styles
│   ├── assets/             # Static assets
│   │   ├── images/       # Optimized images
│   │   │   ├── gallery/
│   │   │   ├── aircraft-01.webp
│   │   │   └── ...
│   │   └── logo-u2.png
│   └── scripts/            # Build and utility scripts
│       ├── build.js
│       └── optimize-images.js
├── dist/                 # Production build output
│   ├── index.html
│   ├── assets/
│   │   ├── css/
│   │   ├── images/
│   │   └── js/
│   └── robots.txt
│   └── sitemap.xml
├── tests/                 # Test files
│   ├── visual/
│   ├── accessibility/
│   └── performance/
├── package.json
├── tailwind.config.js
├── postcss.config.js
└── netlify.toml           # Deployment configuration
```

## Image Optimization Workflow

### 1. Source Images
Place high-quality aircraft images in `src/assets/images/source/` with original format.

### 2. Optimize Images
```bash
# Run the optimization script
npm run optimize-images

# Manual optimization
npx cwebp -q 85 -o src/assets/images/gallery/aircraft-01.webp src/assets/images/source/aircraft-01.jpg
npx cwebp -q 85 -o src/assets/images/gallery/aircraft-01.webp src/assets/images/source/aircraft-01.jpg
```

### 3. Generate Responsive Images
```bash
# Generate multiple sizes for responsive design
npm run generate-responsive-images
```

## Development Commands

### Tailwind Development
```bash
# Watch for changes during development
npx tailwindcss -i ./src/styles/main.css -o ./dist/assets/css/main.css --watch

# Production build
npx tailwindcss -i ./src/styles/main.css -o ./dist/assets/css/main.css --minify
```

### PostCSS Processing
```bash
# Build with autoprefixing and optimization
npx postcss ./dist/assets/css/main.css -o ./dist/assets/css/main.css --use autoprefixer
```

## Content Management

### 1. Aircraft Information
Edit `src/data/aircraft-info.json`:
```json
{
  "history": [
    {
      "id": "u2-development",
      "title": "Lockhead U-2 Development History",
      "category": "history",
      "display_order": 1,
      "content": "<p>Lockhead U-2 development began in...</p>"
    }
  ]
}
```

### 2. Gallery Images
Edit `src/data/gallery-images.json`:
```json
{
  "images": [
    {
      "id": "aircraft-01",
      "filename": "aircraft-01.webp",
      "title": "Lockhead U-2 in Flight",
      "aircraft_type": "spy_plane",
      "description": "Side profile of Lockhead U-2 during test flight",
      "local_path": "src/assets/images/gallery/aircraft-01.webp",
      "dimensions": "1920x1080",
      "format": "webp",
      "created_at": "2026-01-07T12:00:00Z"
    }
  ]
}
```

### 3. Site Configuration
Edit `src/data/site-config.json`:
```json
{
  "site_title": "Lockhead U-2 Spyplane Information",
  "site_description": "Comprehensive information about the Lockhead U-2 reconnaissance aircraft, including history, technical specifications, mission profiles, and operational use.",
  "owner_name": "Ronald Punt",
  "owner_email": "ronald@ronaldpunt.nl",
  "owner_website": "www.ronaldpunt.nl",
  "linkedin_url": "https://www.linkedin.com/in/ronaldpunt/",
  "logo_filename": "image-u2.png",
  "theme_colors": "#1e40af, #3b82f6, #ffffff",
  "google_analytics_enabled": true,
  "matomo_enabled": false
}
```

## Component Development

### 1. Hero Section
```javascript
// src/components/hero-section.js
class HeroSection {
  constructor(data) {
    this.data = data;
  }
  
  render() {
    return `
      <header class="relative bg-gradient-to-r from-blue-900 to-indigo-900 text-white">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div class="pt-16 pb-20 text-center">
            <h1 class="text-4xl font-bold tracking-tight">${this.data.site_title}</h1>
            <p class="mt-4 max-w-3xl mx-auto text-lg text-gray-600">
              ${this.data.site_description}
            </p>
          </div>
        </div>
      </header>
    `;
  }
}

export default HeroSection;
```

### 2. Navigation Component
```javascript
// src/components/navigation.js
class Navigation {
  constructor(data) {
    this.data = data;
  }
  
  render() {
    const navItems = this.data.sort((a, b) => a.display_order - b.display_order);
    
    return `
      <nav class="bg-gray-800 text-white sticky top-0 z-50">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div class="flex items-center justify-between h-16">
            <div class="flex items-center">
              <a href="index.html" class="text-xl font-bold text-white hover:text-gray-300 px-3 py-2">
                ${this.data.site_title}
              </a>
            </div>
            <ul class="flex space-x-8">
              ${navItems.map(item => `
                <li>
                  <a href="${item.url}" class="text-gray-300 hover:text-white px-3 py-2">
                    ${item.label}
                  </a>
                </li>
              `).join('')}
            </ul>
          </div>
        </div>
      </nav>
    `;
  }
}

export default Navigation;
```

## SEO Configuration

### 1. Robots.txt
```bash
# Generate robots.txt
echo "User-agent: *\nAllow: /" > dist/robots.txt
```

### 2. Sitemap.xml
```javascript
// scripts/generate-sitemap.js
const fs = require('fs');

function generateSitemap() {
  const siteData = JSON.parse(fs.readFileSync('src/data/site-config.json'));
  const aircraftData = JSON.parse(fs.readFileSync('src/data/aircraft-info.json'));
  const galleryData = JSON.parse(fs.readFileSync('src/data/gallery-images.json'));
  
  const urls = [
    { url: '', lastmod: new Date().toISOString() },
    { url: '#history', lastmod: new Date().toISOString() },
    { url: '#technical', lastmod: new Date().toISOString() },
    { url: '#mission', lastmod: new Date().toISOString() },
    { url: '#gallery', lastmod: new Date().toISOString() },
    ...aircraftData.history.map(item => ({
      url: `#${item.id}`, lastmod: new Date().toISOString()
    })),
    ...galleryData.images.map(item => ({
      url: `#gallery-${item.id}`, lastmod: new Date().toISOString()
    }))
  ];
  
  const sitemap = `<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
${urls.map(url => `
  <url>
    <loc>${siteData.owner_website}${url.url === '' ? '' : url.url}</loc>
    <lastmod>${url.lastmod}</lastmod>
    <changefreq>monthly</changefreq>
    <priority>0.8</priority>
  </url>
`).join('')}
</urlset>`;
  
  fs.writeFileSync('dist/sitemap.xml', sitemap);
  console.log('Sitemap generated successfully');
}

generateSitemap();
```

## Deployment

### Netlify Configuration
```toml
# netlify.toml
[build]
  publish = "dist"
  
[build.environment]
  NODE_VERSION = "18"

[[headers]]
  for = "/assets/images/*"
  [headers.values]
    Cache-Control = "public, max-age=31536000, immutable"
    X-Content-Type-Options = "nosniff"
```

## Testing Strategy

### 1. Performance Testing
```bash
# Run Lighthouse audit
npm run lighthouse

# Performance budgets
npm run test-performance
```

### 2. Accessibility Testing
```bash
# Automated accessibility tests
npm run test-a11y

# Manual testing checklist
npm run test-manual
```

## Development Workflow

1. **Daily Development**: Use `npm run dev` for live development
2. **Component First**: Build each component independently
3. **Mobile First**: Test on mobile devices during development
4. **Performance Budget**: Monitor bundle size and load times
5. **SEO Validation**: Test meta tags and structured data
6. **Cross-browser Testing**: Verify Chrome, Firefox, Edge compatibility