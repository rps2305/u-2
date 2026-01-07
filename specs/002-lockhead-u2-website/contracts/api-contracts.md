# API Contracts: Lockhead U-2 Website

**Purpose**: Defines the public API interface for the Lockhead U-2 informational website. Note: This is a static website with no backend services - these contracts represent the data structure and validation rules for frontend development.

## Data Access API

### Get Aircraft Information
```yaml
endpoint: /api/aircraft
method: GET
description: Retrieves aircraft information content for the website
parameters:
  - category: string (history|technical|mission|usage|specs)
  - limit: integer (optional, default: 50)
response:
  type: array
  items:
    - id: string
    - title: string
    - content: string (HTML)
    - category: string
    - display_order: integer
    - created_at: string (ISO 8601)
    - updated_at: string (ISO 8601)
```

### Get Gallery Images
```yaml
endpoint: /api/gallery
method: GET
description: Retrieves gallery images with metadata
parameters:
  - aircraft_type: string (optional, filter by aircraft type)
  - limit: integer (optional, default: 100)
response:
  type: array
  items:
    - id: string
    - filename: string
    - title: string
    - aircraft_type: string
    - description: string
    - source_url: string (optional)
    - local_path: string
    - file_size_bytes: integer
    - dimensions: string
    - format: string
    - created_at: string (ISO 8601)
```

### Get Site Configuration
```yaml
endpoint: /api/config
method: GET
description: Retrieves global website configuration
response:
  type: object
  properties:
    - site_title: string
    - site_description: string
    - owner_name: string
    - owner_email: string
    - owner_website: string
    - linkedin_url: string
    - logo_filename: string
    - theme_colors: string
    - google_analytics_enabled: boolean
    - matomo_enabled: boolean
```

### Get Navigation Menu
```yaml
endpoint: /api/navigation
method: GET
description: Retrieves website navigation structure
response:
  type: array
  items:
    - id: string
    - label: string
    - url: string
    - display_order: integer
    - parent_id: string (optional)
```

## File Structure API

### Get Static Assets
```yaml
endpoint: /api/assets/[filename]
method: GET
description: Serves optimized static files (images, css, js)
parameters:
  - filename: string (path relative to assets directory)
response:
  type: file
  content: binary
  headers:
    - content-type: string
    - cache-control: string
    - content-length: integer
```

## Data Schema

### Aircraft Information
```json
{
  "type": "object",
  "properties": {
    "id": {"type": "string", "pattern": "^[a-zA-Z0-9]{1,50}$"},
    "title": {"type": "string", "maxLength": 200},
    "content": {"type": "string", "format": "html"},
    "category": {"type": "string", "enum": ["history", "technical", "mission", "usage", "specs"]},
    "display_order": {"type": "integer", "minimum": 1},
    "created_at": {"type": "string", "format": "date-time"},
    "updated_at": {"type": "string", "format": "date-time"}
  },
  "required": ["id", "title", "content", "category", "display_order"]
}
```

### Gallery Image
```json
{
  "type": "object",
  "properties": {
    "id": {"type": "string", "pattern": "^[a-zA-Z0-9]{1,50}$"},
    "filename": {"type": "string", "maxLength": 255},
    "title": {"type": "string", "maxLength": 300},
    "aircraft_type": {"type": "string"},
    "description": {"type": "string", "maxLength": 1000},
    "source_url": {"type": "string", "format": "uri", "maxLength": 500},
    "local_path": {"type": "string", "maxLength": 255},
    "file_size_bytes": {"type": "integer", "minimum": 0},
    "dimensions": {"type": "string", "pattern": "^[0-9]{1,4}x[0-9]{1,4}$"},
    "format": {"type": "string", "enum": ["webp", "jpg", "png"]},
    "created_at": {"type": "string", "format": "date-time"}
  },
  "required": ["id", "filename", "title", "description", "local_path", "file_size_bytes", "dimensions", "format", "created_at"]
}
```

### Site Configuration
```json
{
  "type": "object",
  "properties": {
    "site_title": {"type": "string", "maxLength": 200},
    "site_description": {"type": "string", "maxLength": 500},
    "owner_name": {"type": "string", "maxLength": 100},
    "owner_email": {"type": "string", "format": "email", "maxLength": 255},
    "owner_website": {"type": "string", "format": "uri", "maxLength": 255},
    "linkedin_url": {"type": "string", "format": "uri", "maxLength": 255},
    "logo_filename": {"type": "string", "maxLength": 100},
    "theme_colors": {"type": "string", "maxLength": 100},
    "google_analytics_enabled": {"type": "boolean"},
    "matomo_enabled": {"type": "boolean"}
  },
  "required": ["site_title", "site_description", "owner_name", "owner_email", "owner_website", "linkedin_url"],
  "additionalProperties": {
    "logo_filename": {"type": "string", "maxLength": 100},
    "theme_colors": {"type": "string", "maxLength": 100}
  }
}
```

### Navigation Menu
```json
{
  "type": "array",
  "items": {
    "type": "object",
    "properties": {
      "id": {"type": "string", "pattern": "^[a-zA-Z0-9]{1,50}$"},
      "label": {"type": "string", "maxLength": 100},
      "url": {"type": "string", "format": "uri", "maxLength": 255},
      "display_order": {"type": "integer", "minimum": 1},
      "parent_id": {"type": "string", "pattern": "^[a-zA-Z0-9]{1,50}$"}
    },
    "required": ["id", "label", "url", "display_order"]
  }
}
```

## Integration Notes

- **Static Site**: No backend services required - all data is embedded in HTML files
- **Development**: Frontend application can consume these contracts during development for type safety
- **Testing**: Mock data should follow these schemas for consistent testing
- **Deployment**: Static hosting (Netlify, Vercel, etc.) serves these API endpoints as static files