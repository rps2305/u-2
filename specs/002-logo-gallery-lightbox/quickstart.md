# Quickstart: Logo and Gallery Lightbox

## Prerequisites

- Node.js 18+ with npm
- Playwright for testing
- WEBP conversion tools (`cwebp` from `webp` package)

## Setup

1. **Install dependencies** (if not already done):
   ```bash
   npm install
   ```

2. **Download and convert logo**:
   ```bash
   # Download logo from provided URL
   curl -L "https://www.vhv.rs/dpng/d/470-4701987_u-2-spy-plane-clipart-black-and-white.png" \
     -o src/assets/images/logo/u2-logo.png

   # Convert to WEBP for consistency
   cwebp -q 85 src/assets/images/logo/u2-logo.png \
     -o src/assets/images/logo/u2-logo.webp

   # Create favicon-size version
   cwebp -q 80 src/assets/images/logo/u2-logo.png \
     -o src/assets/images/logo/u2-logo-favicon.webp
   ```

3. **Build CSS**:
   ```bash
   npm run build
   ```

## Development

### Run development server

```bash
cd src && python3 -m http.server 8080
```

Then open http://localhost:8080 in your browser.

### Watch mode (if using Tailwind CSS)

```bash
npm run watch
```

## Testing

### Run all tests

```bash
npm test
```

### Run linting

```bash
npm run lint
```

### Run specific viewport tests

```bash
npx playwright test --project=mobile
npx playwright test --project=tablet
npx playwright test --project=desktop
```

## File Changes

| File | Action | Description |
|------|--------|-------------|
| `src/index.html` | Modify | Add logo to header, update gallery markup |
| `src/js/main.js` | Modify | Add lightbox class with navigation logic |
| `src/assets/images/logo/` | Create | Store logo files |
| `tests/e2e/responsive.spec.js` | Modify | Add lightbox tests |

## Key Code Locations

| Feature | File | Key Functions/Classes |
|---------|------|----------------------|
| Logo | `src/index.html` | Header section, `<a>` wrapping `<img>` |
| Lightbox | `src/js/main.js` | `Lightbox` class, `open()`, `close()`, `prev()`, `next()` |
| Touch | `src/js/main.js` | `handleTouchStart()`, `handleTouchEnd()` |
| Keyboard | `src/js/main.js` | `handleKeyDown()` event listener |

## Browser Support

- Chrome 80+
- Firefox 75+
- Safari 13+
- Edge 80+
- iOS Safari 13+
- Chrome for Android 80+

## Performance Budget

- Lightbox open: < 500ms
- Image navigation: < 200ms
- Memory: No more than 10MB additional
- Bundle size: < 5KB gzipped for lightbox JS
