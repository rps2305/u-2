# Quickstart: SEO & Accessibility Audit Fixes

## Prerequisites

| Tool          | Version | Purpose                        |
| ------------- | ------- | ------------------------------ |
| Node.js       | 18+     | Package management, Playwright |
| npm           | 9+      | Dependency installation        |
| Python        | 3.8+    | Local dev server               |
| Google Chrome | Latest  | Playwright browser             |
| Sharp CLI     | Latest  | Image optimization             |

## Installation

```bash
# Clone repository
git clone https://github.com/your-org/u-2-spyplane.git
cd u-2-spyplane

# Install dependencies
npm install

# Install Playwright browsers
npx playwright install chromium
```

## Development Workflow

### 1. Start Development Server

```bash
# Start Python HTTP server on port 8080
python3 -m http.server 8080

# OR use npm script if available
npm run dev
```

Access at: `http://localhost:8080/src/index.html`

### 2. Run Linting

```bash
# Check HTML hints and Prettier formatting
npm run test:lint

# Auto-fix formatting
npx prettier --write src/
```

### 3. Run Tests

```bash
# Run all Playwright tests
npm test

# Run specific test file
npx playwright test tests/e2e/accessibility.spec.js

# Run with UI
npx playwright test --project=chromium --reporter=list
```

### 4. Accessibility Testing

```bash
# Run axe-core accessibility tests
npm run test:a11y

# Or manually in browser:
# Open DevTools → More tools → Layers → Accessibility
```

### 5. Performance Testing

```bash
# Install Lighthouse CLI
npm install -g @lhci/cli

# Run Lighthouse audit
lhci autorun

# Or use Chrome DevTools:
# Lighthouse tab → Analyze page load
```

## Build & Optimization

### Image Optimization

```bash
# Convert all images to WebP
npm run images:webp

# Convert all images to AVIF
npm run images:avif

# Optimize with quality 80
npm run images:optimize -- --quality=80
```

### Critical CSS Extraction

```bash
# Extract critical CSS for inlining
npm run css:critical
```

### Production Build

```bash
# Build all optimized assets
npm run build

# Preview production build
npm run preview
```

## Configuration Files

| File                   | Purpose                     |
| ---------------------- | --------------------------- |
| `.htmlhintrc`          | HTML linting rules          |
| `prettier.config.js`   | Code formatting rules       |
| `playwright.config.js` | Test configuration          |
| `lhci.json`            | Lighthouse CI configuration |

## Testing Checklist

Before submitting changes:

- [ ] `npm run test:lint` passes
- [ ] `npm test` passes (all E2E tests)
- [ ] Lighthouse Performance ≥ 90
- [ ] Lighthouse Accessibility ≥ 90
- [ ] Lighthouse SEO ≥ 90
- [ ] Zero console errors in Chrome
- [ ] Zero console errors in Firefox
- [ ] Images have explicit width/height
- [ ] Alt text on all non-decorative images
- [ ] Headings follow logical hierarchy

## Common Issues

### Console Errors

```bash
# Check for console errors
node check-console.js
```

### Lighthouse Score Low

1. Check if images are optimized (WebP/AVIF)
2. Verify critical CSS is inlined
3. Check for render-blocking resources
4. Ensure proper caching headers

### Accessibility Failures

1. Run axe-core: `npx playwright test --project=chromium --reporter=list`
2. Check all images have alt text
3. Verify link text describes destination
4. Ensure heading hierarchy is logical

### Security Headers Missing

1. Verify hosting platform supports custom headers
2. Check `_headers` file (Netlify) or `vercel.json` (Vercel)
3. HSTS requires hosting platform config (not meta tags)

## Deployment

### Netlify

```bash
# Headers file at root
cat > _headers << EOF
/*
  Strict-Transport-Security: max-age=31536000; includeSubDomains; preload
  X-Content-Type-Options: nosniff
  X-Frame-Options: SAMEORIGIN
  Referrer-Policy: strict-origin-when-cross-origin
EOF

# Deploy
netlify deploy --prod
```

### Vercel

```bash
# vercel.json configuration
cat > vercel.json << EOF
{
  "headers": [
    {
      "source": "/(.*)",
      "headers": [
        { "key": "Strict-Transport-Security", "value": "max-age=31536000; includeSubDomains; preload" },
        { "key": "X-Content-Type-Options", "value": "nosniff" },
        { "key": "X-Frame-Options", "value": "SAMEORIGIN" },
        { "key": "Referrer-Policy", "value": "strict-origin-when-cross-origin" }
      ]
    }
  ]
}
EOF

# Deploy
vercel --prod
```

## CI/CD Pipeline

### GitHub Actions Example

```yaml
name: SEO & Accessibility

on:
  push:
    branches: [main]

jobs:
  audit:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: actions/setup-node@v3
        with:
          node-version: 18
      - run: npm ci
      - run: npm run test:lint
      - run: npm test
      - name: Lighthouse CI
        run: |
          npm install -g @lhci/cli
          lhci autorun
```

## File Locations

| Path                                 | Description                     |
| ------------------------------------ | ------------------------------- |
| `src/index.html`                     | Main HTML file (SEO/a11y fixes) |
| `src/css/styles.css`                 | CSS (critical CSS to inline)    |
| `src/js/main.js`                     | JavaScript (defer)              |
| `src/assets/images/`                 | Image source files              |
| `specs/003-seo-accessibility-audit/` | Feature documentation           |

## Next Steps

1. Review `spec.md` for full requirements
2. Review `plan.md` for implementation approach
3. Review `research.md` for technical decisions
4. Run `/speckit.tasks` to generate implementation tasks
5. Execute tasks in order listed in `tasks.md`
