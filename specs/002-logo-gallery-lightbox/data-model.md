# Data Model: Logo and Gallery Lightbox

## Entities

### Logo

**Purpose**: Brand identity element displayed in website header

| Attribute | Type | Description |
|-----------|------|-------------|
| id | string | "u2-logo" (unique identifier) |
| src | string | Path to logo image file |
| alt | string | "U-2 Spyplane Logo" (accessibility text) |
| width | number | Display width in pixels (e.g., 40 for header) |
| height | number | Display height in pixels (maintains aspect ratio) |
| href | string | Anchor link to homepage (#hero) |

---

### GalleryImage

**Purpose**: Thumbnail and full-size image pair for gallery display

| Attribute | Type | Description |
|-----------|------|-------------|
| id | string | Unique identifier (e.g., "u2-arch-01") |
| category | string | Filter category (hero, history, specs, operations, architecture, museum) |
| thumbnailSrc | string | Path to 400px thumbnail WEBP |
| fullSrc | string | Path to full-size WEBP image |
| alt | string | Descriptive alt text for accessibility |
| caption | string \| null | Optional caption displayed in lightbox |

---

### LightboxState

**Purpose**: Runtime state for lightbox component

| Attribute | Type | Description |
|-----------|------|-------------|
| isOpen | boolean | Whether lightbox is currently visible |
| currentIndex | number | Index of currently displayed image in gallery array |
| images | GalleryImage[] | Reference to all gallery images for navigation |
| isLoading | boolean | Whether current image is still loading |

---

## Relationships

```
Header
  └── Logo (1:1)

GallerySection
  └── GalleryImage[] (1:N)
         │
         └── Lightbox displays (1:1 at runtime)

Lightbox
  ├── GalleryImage (current) (1:1)
  └── GalleryImage[] (reference for prev/next) (1:N)
```

---

## Validation Rules

1. Logo src must reference existing file in `src/assets/images/logo/`
2. Gallery images must exist in `src/assets/images/gallery/webp/`
3. Thumbnails must exist in `src/assets/images/thumb/`
4. All images must have non-empty alt text
5. Lightbox currentIndex must be within bounds of images array

---

## State Transitions (Lightbox)

```
CLOSED ──click thumbnail──► OPEN (at index N)
   ▲                            │
   │                            │
   │◄──────click close/ESC──────┘
   │
   │◄──────click overlay────────┘
   │
OPEN ──click prev──► OPEN (at index N-1, wraps to last)
   │
   ├──click next──► OPEN (at index N+1, wraps to first)
   │
   └──swipe left──► OPEN (at index N+1, wraps to first)

LOADING ──load complete──► OPEN
```

---

## File Paths (Source of Truth)

| Entity | Path Pattern |
|--------|--------------|
| Logo | `src/assets/images/logo/u2-logo.webp` |
| Gallery Full | `src/assets/images/gallery/webp/{id}.webp` |
| Gallery Thumb | `src/assets/images/thumb/{id}-thumb.webp` |
