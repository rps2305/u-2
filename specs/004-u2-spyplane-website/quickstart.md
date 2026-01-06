# Quickstart Guide: U-2 Spyplane Informational Website

## Prerequisites

- Node.js 18+ and npm 9+
- Git
- Web browser (Chrome, Firefox, or Safari for testing)
- Image processing tools (ImageMagick, Squoosh, or similar for WEBP conversion)

## Installation

1. **Clone the repository and checkout the feature branch**:
   ```bash
   git checkout 001-u2-spyplane-website
   ```

2. **Navigate to the project directory**:
   ```bash
   cd src/
   ```

3. **Initialize npm and install dependencies**:
   ```bash
   npm init -y
   npm install -D tailwindcss postcss autoprefixer
   npm install -D htmlhint prettier
   npm install -D @playwright/test
   npx tailwindcss init
   ```

4. **Install Playwright browsers**:
   ```bash
   npx playwright install
   ```

## Development Workflow

### 1. Start Development Server

For live reloading during development (using Tailwind CDN for simplicity):

```bash
# Option A: Using a simple HTTP server with live reload
npx http-server -p 8080 -c-1

# Option B: Using VS Code Live Server extension
# Open src/index.html and click "Go Live"
```

### 2. Build for Production

When ready to test production build:

```bash
# Initialize Tailwind CSS
npx tailwindcss -i ./css/styles.css -o ../public/styles.css --watch

# Build all assets
npm run build
```

### 3. Run Linting

```bash
# Lint HTML files
npx htmlhint src/**/*.html

# Check formatting
npx prettier --check src/**/*.html
```

### 4. Run Tests

```bash
# Run Playwright tests
npx playwright test

# Generate test report
npx playwright show-report
```

### 5. Image Processing

Convert images to WEBP format:

```bash
# Convert single image (using cwebp from libwebp package)
cwebp -q 80 input.png -o output.webp

# Convert all PNG/JPG to WEBP
for img in src/assets/images/*.{png,jpg,jpeg}; do
  cwebp -q 80 "$img" -o "${img%.*}.webp"
done

# Generate thumbnails (400px width)
for img in src/assets/images/*.webp; do
  convert -resize 400x "${img}" "${img%.*}-thumb.webp"
done
```

## Project Structure

```
src/
├── index.html              # Main HTML file
├── css/
│   └── styles.css          # Custom CSS (imports Tailwind)
├── js/
│   ├── main.js             # Gallery and lightbox logic
│   └── navigation.js       # Mobile menu logic
└── assets/
    └── images/
        ├── hero/           # Hero section images (WEBP)
        ├── gallery/        # Gallery images (WEBP)
        └── thumb/          # Thumbnail versions (WEBP)

tests/
├── e2e/
│   └── responsive.spec.js  # Playwright tests
└── lint/
    ├── .htmlhintrc         # HTMLhint configuration
    └── .prettierrc         # Prettier configuration

public/                     # Production build output
```

## Tailwind Configuration

Edit `tailwind.config.js` to customize the design:

```javascript
module.exports = {
  content: ['./src/**/*.html'],
  theme: {
    extend: {
      colors: {
        'u2-blue': '#1e3a5f',
        'u2-gray': '#f5f5f5',
        'u2-dark': '#0a1628',
      },
      fontFamily: {
        sans: ['Inter', 'system-ui', 'sans-serif'],
      },
      spacing: {
        '128': '32rem',
      },
    },
  },
  plugins: [
    require('@tailwindcss/typography'),
  ],
}
```

## Testing Commands

| Command | Purpose |
|---------|---------|
| `npx playwright test --project=mobile` | Test mobile viewport |
| `npx playwright test --project=tablet` | Test tablet viewport |
| `npx playwright test --project=desktop` | Test desktop viewport |
| `npx playwright test --reporter=list` | Verbose test output |
| `npx playwright test --reporter=html` | HTML test report |

## Common Tasks

### Adding a New Image

1. Save image to `src/assets/images/gallery/`
2. Convert to WEBP: `cwebp -q 80 image.jpg -o image.webp`
3. Generate thumbnail: `convert -resize 400x image.webp image-thumb.webp`
4. Add image data to data model (if using JS array)
5. Add to HTML gallery grid with proper alt text

### Adding a New Section

1. Create section in `index.html` with proper id
2. Add navigation link in header
3. Verify responsive behavior
4. Add tests for new section if needed

### Debugging Responsive Issues

1. Open browser DevTools (F12)
2. Toggle device toolbar (Ctrl+Shift+M / Cmd+Shift+M)
3. Test at breakpoints: 320px, 768px, 1024px, 1280px, 1920px

## Performance Checklist

- [ ] All images in WEBP format
- [ ] Thumbnails generated for gallery
- [ ] Lazy loading on below-fold images
- [ ] Tailwind CSS purged in production
- [ ] No unused JavaScript
- [ ] Minified CSS and JS in build

## Accessibility Checklist

- [ ] All images have descriptive alt text
- [ ] Navigation keyboard accessible
- [ ] Lightbox supports keyboard (Escape, arrows)
- [ ] Color contrast meets WCAG AA
- [ ] Focus indicators visible
- [ ] ARIA labels where needed

## Next Steps

1. Run `/speckit.tasks` to generate implementation task list
2. Execute tasks in order
3. Test responsive behavior across viewports
4. Verify Lighthouse score meets targets
