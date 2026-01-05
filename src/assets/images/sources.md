# Image Sources - U-2 Spyplane Website

## Downloaded Images (Complete)

Images were downloaded from multiple sources including Wikimedia Commons, Smithsonian National Air and Space Museum, and DVIDS.

| #   | Filename      | Original Size | WEBP   | Thumb  | Category     | Source                                 |
| --- | ------------- | ------------- | ------ | ------ | ------------ | -------------------------------------- |
| 1   | u2-hero-01    | 1.6 MB        | 435 KB | 17 KB  | hero         | Wikimedia Commons (Christopher Michel) |
| 2   | u2-hero-02    | 531 KB        | 149 KB | 3.8 KB | hero         | U.S. Air Force (Public Domain)         |
| 3   | u2-arch-01    | 206 KB        | 80 KB  | 46 KB  | architecture | Original                               |
| 4   | u2-arch-02    | 2.0 MB        | 525 KB | 26 KB  | architecture | Original                               |
| 5   | u2-cockpit-01 | 837 KB        | 357 KB | 14 KB  | cockpit      | Wikimedia Commons (USAF)               |
| 6   | u2-flight-01  | 1.5 MB        | 396 KB | 4.2 KB | flight       | Smithsonian NASM                       |
| 7   | u2-flight-02  | 2.5 MB        | 72 KB  | 7.4 KB | flight       | Smithsonian NASM                       |
| 8   | u2-history-01 | 531 KB        | 94 KB  | 3.7 KB | history      | U.S. Air Force (Public Domain)         |
| 9   | u2-history-02 | 22 MB         | 2.7 MB | 8.7 KB | history      | Staff Sgt. Robert Trujillo (USAF)      |
| 10  | u2-museum-01  | 28 MB         | 1.3 MB | 7.0 KB | museum       | Smithsonian NASM                       |
| 11  | u2-museum-02  | 36 MB         | 1.6 MB | 7.2 KB | museum       | Smithsonian NASM                       |
| 12  | u2-specs-01   | 1.6 MB        | 352 KB | 17 KB  | specs        | U.S. Air Force (Public Domain)         |
| 13  | u2-specs-02   | 2.9 MB        | 426 KB | 11 KB  | specs        | U.S. Air Force (Public Domain)         |

## Sources

- **Wikimedia Commons**: Public domain and CC-licensed images from the U.S. Air Force and contributors
- **Smithsonian National Air and Space Museum**: High-resolution images from the museum's collection (ids.si.edu)
- **DVIDS**: Defense Visual Information Distribution Service (U.S. military imagery)

## File Locations

```
src/assets/images/
├── hero/
│   ├── u2-hero-01.jpg (original)
│   ├── u2-hero-02.jpg (original)
│   └── webp/
│       ├── u2-hero-01.webp
│       └── u2-hero-02.webp
├── gallery/
│   ├── u2-arch-01.jpg
│   ├── u2-arch-02.jpg
│   ├── u2-cockpit-01.jpg
│   ├── u2-flight-01.jpg
│   ├── u2-flight-02.jpg
│   ├── u2-history-01.jpg
│   ├── u2-history-02.jpg
│   ├── u2-museum-01.jpg
│   ├── u2-museum-02.jpg
│   ├── u2-museum-03.jpg
│   ├── u2-specs-01.jpg
│   ├── u2-specs-02.jpg
│   └── webp/
│       ├── u2-arch-01.webp
│       ├── u2-arch-02.webp
│       ├── u2-cockpit-01.webp
│       ├── u2-flight-01.webp
│       ├── u2-flight-02.webp
│       ├── u2-history-01.webp
│       ├── u2-history-02.webp
│       ├── u2-museum-01.webp
│       ├── u2-museum-02.webp
│       ├── u2-museum-03.webp
│       ├── u2-specs-01.webp
│       └── u2-specs-02.webp
└── thumb/
    ├── u2-arch-01-thumb.webp
    ├── u2-arch-02-thumb.webp
    ├── u2-cockpit-01-thumb.webp
    ├── u2-flight-01-thumb.webp
    ├── u2-flight-02-thumb.webp
    ├── u2-hero-01-thumb.webp
    ├── u2-hero-02-thumb.webp
    ├── u2-history-01-thumb.webp
    ├── u2-history-02-thumb.webp
    ├── u2-museum-01-thumb.webp
    ├── u2-museum-02-thumb.webp
    ├── u2-museum-03-thumb.webp
    ├── u2-specs-01-thumb.webp
    └── u2-specs-02-thumb.webp
```

## Image Credits

| Image         | Credit                                      |
| ------------- | ------------------------------------------- |
| u2-hero-01    | Christopher Michel (CC BY-SA 3.0)           |
| u2-hero-02    | U.S. Air Force (Public Domain)              |
| u2-cockpit-01 | U.S. Air Force (Public Domain)              |
| u2-history-01 | U.S. Air Force (Public Domain)              |
| u2-history-02 | Staff Sgt. Robert Trujillo (U.S. Air Force) |
| u2-specs-01   | U.S. Air Force (Public Domain)              |
| u2-specs-02   | U.S. Air Force (Public Domain)              |
| u2-flight-01  | Smithsonian National Air and Space Museum   |
| u2-flight-02  | Smithsonian National Air and Space Museum   |
| u2-museum-01  | Smithsonian National Air and Space Museum   |
| u2-museum-02  | Smithsonian National Air and Space Museum   |
| u2-museum-03  | Smithsonian National Air and Space Museum   |

## WEBP Conversion Settings

| Image Type | Quality    | Purpose            |
| ---------- | ---------- | ------------------ |
| Hero       | 85%        | Full-width display |
| Gallery    | 80%        | Thumbnail grid     |
| Thumbnails | 75%, 400px | Fast loading       |

## Commands Used

```bash
# Download with Python requests
python3 -c "
import requests
headers = {'User-Agent': 'U-2-Spyplane-Website/1.0'}
# ... API calls to Wikimedia Commons
"

# Convert to WEBP (per Gumlet/sips guide)
cwebp -q 85 image.jpg -o image.webp

# Generate thumbnails
cwebp -q 75 -resize 400 0 image.webp -o image-thumb.webp
```

## Next Steps

- [x] Download 14 images from multiple sources
- [x] Convert all to WEBP format
- [x] Generate thumbnails
- [ ] Update `src/index.html` to use local WEBP images
- [ ] Download more images (target: 50+)
- [ ] Add image alt text to HTML

## Progress: 14 Images Downloaded

Current: 14 images
Remaining: 36+ images needed to reach 50+ target

To download more images, sources include:

- Wikimedia Commons (commons.wikimedia.org)
- Smithsonian National Air and Space Museum (airandspace.si.edu)
- National Museum of the USAF (nationalmuseum.af.mil)
- DVIDS (dvidshub.net)
