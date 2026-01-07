# Data Model: Lockhead U-2 Website

**Purpose**: Defines the core data entities and their relationships for the Lockhead U-2 informational website.

## Core Entities

### Aircraft Information
- **Description**: Content covering U-2's history, technical specifications, mission details, and operational use cases
- **Fields**:
  - `id`: Unique identifier (string)
  - `title`: Headline or section title (string)
  - `content`: Full text content (HTML)
  - `category`: Information type (history|technical|mission|usage|specs)
  - `display_order`: Sort order for presentation (integer)
  - `created_at`: Timestamp when content was added
  - `updated_at`: Timestamp when content was last modified

### Gallery Image
- **Description**: Individual aircraft images with metadata and responsive variants
- **Fields**:
  - `id`: Unique identifier (string)
  - `filename`: Original image filename (string)
  - `title`: Image title or description (string)
  - `aircraft_type`: Type of aircraft depicted (string)
  - `description`: Detailed image description (string)
  - `source_url`: Original source location (string, optional)
  - `local_path`: Local optimized path (string)
  - `file_size_bytes`: Optimized file size (integer)
  - `dimensions`: Width x Height in pixels (string)
  - `format`: File format (webp|jpg|png)
  - `created_at`: Timestamp when added to gallery

### Site Configuration
- **Description**: Global website settings and metadata
- **Fields**:
  - `id`: Unique identifier (string)
  - `site_title`: Main website title (string)
  - `site_description`: Meta description for SEO (string)
  - `owner_name`: Ronald Punt (string)
  - `owner_email`: ronald@ronaldpunt.nl (string)
  - `owner_website`: www.ronaldpunt.nl (string)
  - `linkedin_url`: https://www.linkedin.com/in/ronaldpunt/ (string)
  - `logo_filename`: image-u2.png (string)
  - `theme_colors`: Primary color scheme (string)
  - `google_analytics_enabled`: Boolean for tracking (boolean)
  - `matomo_enabled`: Boolean for analytics (boolean)

### Navigation Menu
- **Description**: Website navigation structure
- **Fields**:
  - `id`: Unique identifier (string)
  - `label`: Display text for menu item (string)
  - `url`: Internal anchor link (string)
  - `display_order`: Sort order for navigation (integer)
  - `parent_id`: Reference to parent menu item (string, optional)

## Entity Relationships

### Aircraft Information Categories
- Each `Aircraft Information` belongs to exactly one `category` (history|technical|mission|usage|specs)
- Content within each category is sorted by `display_order` ascending

### Gallery Organization
- Each `Gallery Image` can belong to multiple `aircraft_type` values
- Images are displayed in responsive grid layout sorted by creation date
- Clicking image opens detailed view with full metadata

### Site Structure
- One `Site Configuration` record serves as global settings
- `Navigation Menu` items provide hierarchical site structure
- Menu items support nested organization with parent-child relationships

## Validation Rules

### Aircraft Information
- `id` must be unique within category
- `display_order` must be positive integer
- `content` must be valid HTML
- `category` must be one of: history, technical, mission, usage, specs

### Gallery Image
- `filename` must be unique across all images
- `file_size_bytes` must be positive integer
- `dimensions` format: "WIDTHxHEIGHT" (e.g., "1920x1080")
- `format` must be one of: webp, jpg, png

### Site Configuration
- `owner_email` must be valid email format
- `google_analytics_enabled` and `matomo_enabled` cannot both be true (choose one analytics method)

### Navigation Menu
- `url` must be valid anchor link (#section-name or /page-path)
- `display_order` must be positive integer
- `parent_id` must reference existing menu item `id` if provided