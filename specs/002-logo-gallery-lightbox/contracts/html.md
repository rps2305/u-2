# Lightbox HTML Contract

## Required HTML Structure

The JavaScript lightbox component expects the following HTML structure:

```html
<!-- Lightbox Overlay (hidden by default) -->
<div id="lightbox" class="fixed inset-0 z-[100] bg-black/95 hidden" role="dialog" aria-modal="true">
  <!-- Close Button -->
  <button id="lightbox-close" class="absolute top-4 right-4 text-white" aria-label="Close lightbox">
    <svg>...</svg>
  </button>

  <!-- Previous Button -->
  <button id="lightbox-prev" class="absolute left-4 text-white" aria-label="Previous image">
    <svg>...</svg>
  </button>

  <!-- Image Container -->
  <div class="flex items-center justify-center h-full p-4">
    <img id="lightbox-image" src="" alt="" class="max-w-[90vw] max-h-[80vh] object-contain" />
  </div>

  <!-- Caption (optional) -->
  <div id="lightbox-caption" class="absolute bottom-4 left-0 right-0 text-center text-white"></div>
</div>
```

## Gallery Item Requirements

Each gallery item must have:
- `data-category` attribute for filtering
- Nested `<img>` with `src` pointing to thumbnail
- The full-size image path must be derivable from the thumbnail path

```html
<div class="gallery-item" data-category="specs">
  <img
    src="thumb/u2-specs-01-thumb.webp"
    data-full="gallery/webp/u2-specs-01.webp"
    alt="U-2 technical specifications"
    loading="lazy"
  />
</div>
```

## CSS Classes Required

| Class | Purpose |
|-------|---------|
| `.fixed inset-0` | Full viewport coverage |
| `.z-[100]` | Above all other content |
| `.bg-black/95` | Semi-transparent dark background |
| `.hidden` | Initially hidden (toggled via JS) |
| `.max-w-[90vw] max-h-[80vh]` | Responsive image sizing |

## Event Contracts

### Events Dispatched

| Event | Payload | Description |
|-------|---------|-------------|
| `lightbox:open` | `{ index, image }` | When lightbox opens |
| `lightbox:close` | `{}` | When lightbox closes |
| `lightbox:change` | `{ index, image }` | When navigating images |

### Events Listened To

| Event | Handler | Action |
|-------|---------|--------|
| `click` on `.gallery-item` | `openLightbox(index)` | Open and show image |
| `click` on `#lightbox-close` | `closeLightbox()` | Close overlay |
| `click` on `#lightbox-prev` | `prevImage()` | Show previous |
| `click` on `#lightbox-next` | `nextImage()` | Show next |
| `keydown` (Escape) | `closeLightbox()` | Close on escape |
| `keydown` (ArrowLeft) | `prevImage()` | Navigate left |
| `keydown` (ArrowRight) | `nextImage()` | Navigate right |
| `touchstart/touchend` | `handleSwipe()` | Touch navigation |
