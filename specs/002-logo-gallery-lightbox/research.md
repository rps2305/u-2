# Research: Logo and Gallery Lightbox Implementation

## Decision: Custom Lightbox Implementation

**Choice**: Build custom lightbox component using vanilla JavaScript and Tailwind CSS

**Rationale**:
- Existing website uses vanilla JavaScript and Tailwind CSS
- Lightbox requirements are straightforward (display image, prev/next, keyboard, swipe)
- No external dependencies reduces maintenance and improves performance
- Full control over styling matches website design system
- Lightweight solution keeps page load fast

**Alternatives Considered**:
1. **Colorbox**: jQuery plugin, requires jQuery dependency, adds ~30KB
2. **Lightbox2**: Vanilla JS alternative, but lacks modern touch swipe support
3. **Fancybox**: Feature-rich but overkill, adds ~100KB bundle
4. **PhotoSwipe**: Excellent mobile support, but complex API for simple needs

---

## Decision: Local Logo Storage

**Choice**: Download logo image and store locally in `src/assets/images/logo/`

**Rationale**:
- Eliminates external dependency on vhv.rs domain
- Ensures logo always loads even if source site is down
- Enables optimization and format conversion if needed
- Follows existing pattern for other images in the project

**Implementation**:
- Download PNG from provided URL
- Convert to WEBP format for consistency with gallery images
- Store at `src/assets/images/logo/u2-logo.webp`
- Generate thumbnail at 100px width for favicon/app icon use

---

## Decision: Touch Swipe Implementation

**Choice**: Implement touch swipe using native Touch Events API

**Rationale**:
- Native API requires no external dependencies
- Simple threshold-based detection (swipe > 50px triggers navigation)
- Works alongside click events without conflict
- Minimal code footprint (~20 lines)

**Implementation**:
```javascript
touchStartX = null
touchEndX = null

element.addEventListener('touchstart', (e) => {
  touchStartX = e.changedTouches[0].screenX
})

element.addEventListener('touchend', (e) => {
  touchEndX = e.changedTouches[0].screenX
  handleSwipe()
})
```

---

## Decision: Keyboard Navigation

**Choice**: Use native keyboard event listeners

**Rationale**:
- Universal browser support for keydown events
- Standard keys (Escape, ArrowLeft, ArrowRight) are well-documented
- No accessibility library needed for basic support

**Implementation**:
- Escape: Close lightbox
- ArrowLeft: Previous image
- ArrowRight: Next image
- Prevent default behavior for arrow keys to avoid page scroll

---

## Performance Considerations

1. **Lazy loading**: Gallery thumbnails already use `loading="lazy"`
2. **Image optimization**: Logo converted to WEBP format
3. **Event delegation**: Single event listener on lightbox container
4. **Preloading**: Preload next image when lightbox opens

---

## Responsive Breakpoints

| Viewport | Lightbox Behavior |
|----------|-------------------|
| 320px - 639px | Full-width image, swipe navigation |
| 640px - 1023px | Max-width 90vw, touch-friendly buttons |
| 1024px+ | Max-width 80vw, visible prev/next buttons |

---

## Accessibility Features

1. **ARIA labels**: All interactive elements have descriptive labels
2. **Keyboard focus trap**: Focus managed within lightbox when open
3. **Escape key**: Closes lightbox (WCAG 2.1.4 shortcut)
4. **Screen reader**: Image alt text read when lightbox opens
