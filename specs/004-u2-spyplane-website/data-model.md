# Data Model: U-2 Spyplane Informational Website

## Content Structure

### Website Sections

| Section | ID | Description | Components |
|---------|-----|-------------|------------|
| Header | `header` | Main navigation and branding | Logo, nav links, mobile menu |
| Hero | `hero` | Landing area with hero image | Title, subtitle, CTA button |
| History | `history` | Timeline of U-2 development | Timeline items, dates, descriptions |
| Specifications | `specs` | Technical data table | Specifications grid, performance data |
| Operations | `operations` | Mission and capability info | Mission types, deployments, achievements |
| Gallery | `gallery` | Image collection | Thumbnail grid, lightbox, filters |
| Footer | `footer` | Site footer | Copyright, credits, links |

### Section Relationships

```
Website
├── Header
├── Hero
├── History
├── Specifications
├── Operations
├── Gallery
└── Footer
```

---

## Image Entity

### Image Schema

| Attribute | Type | Required | Description |
|-----------|------|----------|-------------|
| `id` | string | Yes | Unique identifier (e.g., `img-001`) |
| `filename` | string | Yes | WEBP filename (e.g., `u2-hero-1.webp`) |
| `alt` | string | Yes | Descriptive alt text for accessibility |
| `caption` | string | No | Lightbox caption text |
| `category` | enum | Yes | One of: hero, history, specs, operations, gallery |
| `date` | string | No | Date the photo was taken |
| `orientation` | enum | Yes | landscape or portrait |
| `width` | number | Yes | Original image width in pixels |
| `height` | number | Yes | Original image height in pixels |
| `thumbnail` | string | Yes | Thumbnail filename (400px width) |
| `srcset` | array | Yes | Array of responsive variants |

### Image Categories

| Category | Count | Aspect Ratio | Usage |
|----------|-------|--------------|-------|
| hero | 5-7 | 16:9 or 21:9 | Full-width section backgrounds |
| history | 10-15 | 4:3 or 3:2 | Timeline and historical context |
| specs | 5-10 | 1:1 or 3:2 | Technical detail shots |
| operations | 15-20 | 4:3 | Mission and deployment photos |
| gallery | 20-30 | Mixed | Additional collection items |

### Image Variants

| Variant | Width | Quality | Purpose |
|---------|-------|---------|---------|
| thumbnail | 400px | 75% | Gallery grid display |
| small | 800px | 80% | Lightbox on mobile |
| medium | 1200px | 82% | Lightbox on tablet |
| large | 1600px | 85% | Lightbox on desktop |

---

## Section Entity

### Section Schema

| Attribute | Type | Required | Description |
|-----------|------|----------|-------------|
| `id` | string | Yes | HTML id attribute (e.g., `history`) |
| `title` | string | Yes | Section heading text |
| `order` | number | Yes | Display order (1-7) |
| `content_type` | enum | Yes | text, timeline, gallery, specs |
| `theme` | enum | No | light or dark background |

### Section Content Types

| Content Type | Components | Tailwind Classes |
|--------------|------------|------------------|
| text | Paragraphs, headings, lists | `prose prose-lg max-w-4xl` |
| timeline | Date markers, event descriptions | `border-l-4 border-u2-blue pl-6` |
| specs | Data table, specifications grid | `grid grid-cols-1 md:grid-cols-2 gap-4` |
| gallery | Image grid, lightbox trigger | `grid grid-cols-2 md:grid-cols-4 gap-4` |

---

## Navigation Entity

### Navigation Schema

| Attribute | Type | Required | Description |
|-----------|------|----------|-------------|
| `id` | string | Yes | Unique link identifier |
| `label` | string | Yes | Display text |
| `href` | string | Yes | Target section id (e.g., `#history`) |
| `order` | number | Yes | Display order |

### Navigation Items

| Order | Label | Target | Visible On |
|-------|-------|--------|------------|
| 1 | Home | `#hero` | All |
| 2 | History | `#history` | All |
| 3 | Specifications | `#specs` | All |
| 4 | Operations | `#operations` | All |
| 5 | Gallery | `#gallery` | All |

---

## Validation Rules

### Image Validation

- All images MUST be in WEBP format
- Alt text MUST be descriptive and unique
- File sizes MUST be under 500KB for gallery images
- Thumbnails MUST be exactly 400px width
- Aspect ratios MUST match category specifications

### Content Validation

- Section IDs MUST match navigation hrefs
- All external links MUST have `target="_blank"` and `rel="noopener"`
- Email links MUST use `mailto:` scheme
- All images MUST have width and height attributes

---

## State Management

### Static Site States

| State | Description | Triggers |
|-------|-------------|----------|
| Initial | All content loaded, no interactions | Page load complete |
| Lightbox Open | Full-size image displayed | Click on thumbnail |
| Menu Open | Mobile navigation expanded | Click on hamburger |
| Filter Active | Gallery filtered by category | Click on filter button |

### State Transitions

```
Initial → Lightbox Open (click thumbnail)
Initial → Menu Open (click hamburger)
Initial → Filter Active (click filter)
Lightbox Open → Initial (click close/Escape)
Menu Open → Initial (click close/click outside)
Filter Active → Initial (clear filter)
```

---

## Component Hierarchy

```
Root
├── Header
│   ├── Logo (text: "U-2 Spyplane")
│   └── Nav (desktop + mobile)
├── Hero
│   ├── Background Image
│   ├── Title (text: "Lockheed U-2")
│   └── CTA Button
├── History
│   └── Timeline (list of events)
├── Specifications
│   └── DataGrid (key-value pairs)
├── Operations
│   ├── Mission Cards
│   └── Deployment Info
├── Gallery
│   ├── FilterBar
│   └── ImageGrid
│       └── Thumbnail
└── Footer
    ├── Copyright
    └── Credits
```

---

## Sample Image Records

```json
{
  "id": "img-001",
  "filename": "u2-hero-1.webp",
  "alt": "Lockheed U-2 Dragon Lady in flight",
  "caption": "U-2 aircraft in flight showing distinctive high wings",
  "category": "hero",
  "date": "1956-08-01",
  "orientation": "landscape",
  "width": 2400,
  "height": 1350,
  "thumbnail": "u2-hero-1-thumb.webp",
  "srcset": [
    {"url": "u2-hero-1-400.webp", "width": 400},
    {"url": "u2-hero-1-800.webp", "width": 800},
    {"url": "u2-hero-1-1200.webp", "width": 1200},
    {"url": "u2-hero-1-1600.webp", "width": 1600}
  ]
}
```
