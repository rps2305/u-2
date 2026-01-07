# JavaScript Module Contracts

## main.js - Core Functionality

### Smooth Scrolling Module
```javascript
/**
 * Smooth scrolling implementation for navigation links
 * Requirements: Animate scroll to target sections with offset for fixed navbar
 */

const smoothScroll = {
  // Initialize smooth scrolling for all anchor links
  init() {
    document.querySelectorAll('a[href^="#"]').forEach(link => {
      link.addEventListener('click', this.handleClick.bind(this));
    });
  },
  
  // Handle click events on navigation links
  handleClick(event) {
    event.preventDefault();
    const targetId = event.target.getAttribute('href').substring(1);
    const targetElement = document.getElementById(targetId);
    
    if (targetElement) {
      const navbarHeight = document.getElementById('navbar').offsetHeight;
      const targetPosition = targetElement.offsetTop - navbarHeight;
      
      window.scrollTo({
        top: targetPosition,
        behavior: 'smooth'
      });
      
      // Update URL hash without scrolling
      history.pushState(null, null, `#${targetId}`);
    }
  }
};
```

### Mobile Menu Module
```javascript
/**
 * Mobile navigation menu toggle functionality
 * Requirements: Responsive hamburger menu for mobile devices
 */

const mobileMenu = {
  // Initialize mobile menu functionality
  init() {
    const menuButton = document.getElementById('mobile-menu-button');
    const mobileMenu = document.getElementById('mobile-menu');
    
    if (menuButton && mobileMenu) {
      menuButton.addEventListener('click', this.toggleMenu.bind(this));
      
      // Close menu when clicking outside
      document.addEventListener('click', (e) => {
        if (!menuButton.contains(e.target) && !mobileMenu.contains(e.target)) {
          this.closeMenu();
        }
      });
    }
  },
  
  // Toggle mobile menu visibility
  toggleMenu() {
    const mobileMenu = document.getElementById('mobile-menu');
    mobileMenu.classList.toggle('hidden');
  },
  
  // Close mobile menu
  closeMenu() {
    const mobileMenu = document.getElementById('mobile-menu');
    mobileMenu.classList.add('hidden');
  }
};
```

### Scroll Spy Module
```javascript
/**
 * Scroll spy functionality for active navigation highlighting
 * Requirements: Highlight current section in navigation as user scrolls
 */

const scrollSpy = {
  // Initialize scroll spy functionality
  init() {
    window.addEventListener('scroll', this.handleScroll.bind(this));
  },
  
  // Handle scroll events and update active navigation
  handleScroll() {
    const sections = document.querySelectorAll('section[id]');
    const navbarHeight = document.getElementById('navbar').offsetHeight;
    const scrollPosition = window.scrollY + navbarHeight + 100;
    
    sections.forEach(section => {
      const sectionTop = section.offsetTop;
      const sectionHeight = section.offsetHeight;
      const sectionId = section.getAttribute('id');
      
      if (scrollPosition >= sectionTop && scrollPosition < sectionTop + sectionHeight) {
        this.updateActiveNavigation(sectionId);
      }
    });
  },
  
  // Update active navigation item
  updateActiveNavigation(activeId) {
    document.querySelectorAll('.nav-link').forEach(link => {
      link.classList.remove('text-blue-600', 'font-bold');
      link.classList.add('text-gray-600');
    });
    
    const activeLink = document.querySelector(`.nav-link[href="#${activeId}"]`);
    if (activeLink) {
      activeLink.classList.remove('text-gray-600');
      activeLink.classList.add('text-blue-600', 'font-bold');
    }
  }
};
```

### Initialization
```javascript
/**
 * Main application initialization
 */

document.addEventListener('DOMContentLoaded', () => {
  smoothScroll.init();
  mobileMenu.init();
  scrollSpy.init();
  
  // Performance optimization: preload images above fold
  preloadCriticalImages();
});

/**
 * Preload critical images for performance
 */
function preloadCriticalImages() {
  const criticalImages = document.querySelectorAll('img[data-critical="true"]');
  criticalImages.forEach(img => {
    const src = img.getAttribute('data-src');
    if (src) {
      img.src = src;
      img.onload = () => {
        img.classList.add('loaded');
      };
    }
  });
}
```

## lightbox.js - Gallery LightBox Integration

### LightBox Module Contract
```javascript
/**
 * LightBox integration for gallery images
 * Requirements: 
 * - Full-screen image viewing
 * - Keyboard navigation (arrow keys, ESC)
 * - Touch/swipe support for mobile
 * - Image captions and metadata display
 */

const lightbox = {
  // Initialize LightBox for gallery images
  init() {
    const galleryImages = document.querySelectorAll('.gallery-image');
    galleryImages.forEach((img, index) => {
      img.addEventListener('click', () => this.openLightbox(index));
    });
    
    // Close lightbox on background click
    document.getElementById('lightbox-overlay').addEventListener('click', (e) => {
      if (e.target.id === 'lightbox-overlay') {
        this.closeLightbox();
      }
    });
    
    // Keyboard navigation
    document.addEventListener('keydown', this.handleKeydown.bind(this));
  },
  
  // Open lightbox with specific image
  openLightbox(index) {
    const images = this.getGalleryImages();
    const image = images[index];
    
    this.updateLightboxContent(image);
    this.showLightbox();
    this.currentIndex = index;
    
    // Prevent body scroll
    document.body.style.overflow = 'hidden';
  },
  
  // Close lightbox
  closeLightbox() {
    this.hideLightbox();
    document.body.style.overflow = '';
  },
  
  // Handle keyboard navigation
  handleKeydown(event) {
    if (!this.isLightboxVisible()) return;
    
    switch (event.key) {
      case 'Escape':
        this.closeLightbox();
        break;
      case 'ArrowLeft':
        this.navigatePrevious();
        break;
      case 'ArrowRight':
        this.navigateNext();
        break;
    }
  },
  
  // Navigate to previous image
  navigatePrevious() {
    this.currentIndex = (this.currentIndex - 1 + this.getGalleryImages().length) % this.getGalleryImages().length;
    this.updateLightboxContent(this.getGalleryImages()[this.currentIndex]);
  },
  
  // Navigate to next image
  navigateNext() {
    this.currentIndex = (this.currentIndex + 1) % this.getGalleryImages().length;
    this.updateLightboxContent(this.getGalleryImages()[this.currentIndex]);
  }
};
```

## Performance Requirements

### Code Requirements
- Minified JavaScript in production
- Async/defer loading of non-critical scripts
- Event delegation for better performance
- Debounced scroll events
- Lazy loading for below-the-fold images

### Browser Compatibility
- Modern browsers (ES2022 features)
- Graceful degradation for older browsers
- Progressive enhancement approach

### Accessibility Requirements
- Keyboard navigation support
- Screen reader compatibility
- Focus management in LightBox
- ARIA labels and roles