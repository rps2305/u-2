# HTML Page Contracts

## index.html - Main Landing Page

### Structure Contract
```html
<!DOCTYPE html>
<html lang="en">
<head>
  <!-- Meta tags for SEO -->
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="description" content="[SITE_DESCRIPTION]">
  <meta name="author" content="Ronald Punt">
  <title>[SITE_TITLE]</title>
  
  <!-- Preload critical resources -->
  <link rel="preload" href="css/output.css" as="style">
  <link rel="preload" href="js/main.js" as="script">
  
  <!-- Stylesheets -->
  <link href="css/output.css" rel="stylesheet">
  
  <!-- Matomo Analytics (if enabled) -->
  <!-- Matomo script placeholder -->
</head>
<body class="bg-gray-50 text-gray-900">
  <!-- Navigation -->
  <nav id="navbar" class="fixed top-0 w-full bg-white shadow-md z-50">
    <!-- Navigation menu items from Navigation Menu entity -->
  </nav>
  
  <!-- Hero Section -->
  <section id="hero" class="min-h-screen flex items-center justify-center bg-gradient-to-b from-blue-50 to-white">
    <!-- Hero content with site title and main image -->
  </section>
  
  <!-- Aircraft Information Sections -->
  <section id="history" class="py-20">
    <!-- History content from Aircraft Information entity (category: history) -->
  </section>
  
  <section id="technical" class="py-20 bg-gray-100">
    <!-- Technical specifications from Aircraft Information entity (category: technical) -->
  </section>
  
  <section id="mission" class="py-20">
    <!-- Mission details from Aircraft Information entity (category: mission) -->
  </section>
  
  <section id="usage" class="py-20 bg-gray-100">
    <!-- Usage information from Aircraft Information entity (category: usage) -->
  </section>
  
  <section id="specs" class="py-20">
    <!-- Detailed specifications from Aircraft Information entity (category: specs) -->
  </section>
  
  <!-- Gallery Section -->
  <section id="gallery" class="py-20 bg-gray-100">
    <div class="container mx-auto px-4">
      <h2 class="text-4xl font-bold text-center mb-12">U-2 Gallery</h2>
      <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
        <!-- Gallery items from Gallery Image entity -->
        <!-- Each item includes responsive srcset for WebP images -->
        <!-- LightBox integration for click events -->
      </div>
    </div>
  </section>
  
  <!-- Contact/Author Section -->
  <section id="contact" class="py-20 bg-gray-900 text-white">
    <!-- Contact information from Site Configuration entity -->
  </section>
  
  <!-- Footer -->
  <footer class="bg-gray-800 text-white py-8">
    <!-- Footer with navigation and author info -->
  </footer>
  
  <!-- Scripts -->
  <script src="js/main.js"></script>
  <script src="js/lightbox.js"></script>
</body>
</html>
```

### Data Requirements
- **Site Configuration**: All meta tags, titles, descriptions
- **Navigation Menu**: All navigation items with correct ordering
- **Aircraft Information**: Content for all sections (history, technical, mission, usage, specs)
- **Gallery Images**: All gallery images with responsive srcset attributes

### Performance Requirements
- Critical CSS inline or preloaded
- Images use srcset with multiple sizes (320px, 768px, 1024px, 1920px)
- JavaScript files deferred or async
- Minimal external dependencies

### SEO Requirements
- Semantic HTML5 structure
- Proper heading hierarchy (h1, h2, h3)
- Meta description and title tags
- Open Graph tags for social sharing
- Structured data markup