# Sync Impact Report:
# Version change: 2.1.0 → 2.2.0 (MINOR - added platform tooling and browser support principles)
# Modified principles: Added IV.B. Platform Tooling Requirements and expanded browser support
# Added sections: Platform-specific development and testing guidelines
# Templates requiring updates: ✅ plan-template.md (already aligned), ✅ spec-template.md (already aligned), ✅ tasks-template.md (already aligned)
# Follow-up TODOs: None

# Specify Agent Constitution

## Core Principles

### I. Code Quality Excellence

All code MUST meet the following quality standards:

- Code MUST be self-documenting with clear, descriptive names for variables, functions, and types.
- Functions MUST have a single responsibility and remain under 50 lines where practical.
- Code MUST follow the project's established style guide and pass all linting checks before merge.
- Complex logic MUST include inline comments explaining "why" not "what".
- Dead code and unused dependencies MUST be removed promptly.

Rationale: High code quality reduces maintenance burden, improves onboarding, and prevents bugs. Self-documenting code reduces knowledge silos and enables faster iteration.

### II. Testing Standards

All features MUST satisfy these testing requirements:

- Unit tests MUST cover all public API functions with meaningful assertions.
- Integration tests MUST verify system behavior across component boundaries.
- Tests MUST be independent, repeatable, and fast (under 100ms per test).
- Test coverage MUST exceed 80% for new features in critical paths.
- Failing tests MUST block merges and MUST be fixed within 24 hours.

Rationale: Comprehensive testing enables safe refactoring, catches regressions early, and serves as living documentation of expected behavior. Fast, independent tests support rapid development cycles.

### II.A. File Path Validation

All CSS and JavaScript file paths MUST be validated:

- CSS files MUST use correct relative or absolute paths with proper extensions (.css).
- JavaScript files MUST use correct relative or absolute paths with proper extensions (.js, .mjs).
- All referenced asset files MUST exist and be accessible from their declared paths.
- Build output directories MUST be validated before deployment.
- File path dependencies MUST be checked during development and CI processes.

Rationale: Validating file paths prevents runtime errors, broken resources, and deployment failures. Ensures all assets are properly linked and accessible.

### III. User Experience Consistency

All user-facing interfaces MUST maintain consistent experience:

- Interactions MUST follow platform conventions (iOS HIG, Material Design, or web standards).
- Error messages MUST be human-readable, actionable, and consistent in tone.
- Visual design tokens MUST be shared across all UI components.
- Response times for user actions MUST remain under 200ms for perceived responsiveness.
- Accessibility standards (WCAG 2.1 AA) MUST be met for all user interfaces.

Rationale: Consistent UX reduces cognitive load for users, improves accessibility, and creates professional, trustworthy interactions. Predictable behavior increases user confidence and satisfaction.

### III.A. Asset Management

All CSS and JavaScript assets MUST be properly managed:

- All CSS files MUST be properly referenced and loaded in correct order.
- All JavaScript files MUST be properly referenced with correct dependencies.
- Asset file paths MUST be validated for existence and accessibility.
- Production assets MUST be minified and optimized for performance.
- Development assets MUST include source maps for debugging.
- All resource loading MUST handle failures gracefully with user feedback.

Rationale: Proper asset management prevents runtime errors, ensures reliable loading, and maintains performance standards throughout development and production environments.

### IV. Performance Requirements

All implementations MUST meet these performance standards:

- Resource usage MUST be proportional to work performed with no memory leaks.
- Network requests MUST batch where possible and include proper caching headers.
- Database queries MUST use indexes and avoid N+1 patterns.
- Background operations MUST not block user-facing interactions.
- Performance MUST be measurable with benchmarks for critical paths.
- Web browsers MUST support all modern browsers (Chrome, Firefox, Edge); Safari testing is NOT required for development.

### IV.A. Resource Loading Optimization

All resource loading MUST be optimized for performance:

- Critical CSS MUST be inlined or preloaded to prevent render-blocking.
- JavaScript MUST use async/defer attributes to prevent render-blocking.
- Images MUST use appropriate formats (WebP, AVIF) with responsive srcset attributes.
- Fonts MUST be properly preloaded and fallback mechanisms implemented.
- Resource hints (preload, prefetch, preconnect) MUST be used strategically.
- All resources MUST include proper caching headers and version control.

Rationale: Optimized resource loading directly impacts Core Web Vitals metrics and user experience. Strategic resource management reduces page load times and improves perceived performance.

### IV.B. Platform Tooling Requirements

All platform-specific tooling MUST be properly configured:

- macOS: MUST use SIPS for image processing and cwebp for WebP conversion.
- Production: MUST NOT use Tailwind CSS from CDN - local build configuration required.
- Development: MUST NOT rely on Safari HTTP server due to CORS and security limitations.
- Cross-platform: MUST ensure build scripts work on macOS, Linux, and Windows environments.
- Package managers: MUST support both npm and yarn for dependency management.
- Local development: MUST avoid localhost file:// protocol issues with CORS headers.

Rationale: Platform-specific tooling requirements ensure consistent development environments and prevent deployment issues caused by platform-specific limitations or tooling differences.

### V. Technology Stack

- New dependencies MUST be evaluated for maintenance status, security posture, and community support.
- Major framework upgrades MUST have a migration plan and backward compatibility strategy.
- Polyglot services MUST isolate language-specific tooling to enable independent updates.
- Local Tailwind CSS MUST be used with PostCSS - CDN usage prohibited.
- Image processing MUST use SIPS on macOS and cwebp for WebP conversion.
- Development servers MUST avoid Safari due to CORS and HTTP server limitations.

### VI. Security Standards

- All inputs MUST be validated and sanitized to prevent injection attacks.
- Secrets MUST never be committed to version control; use environment variables or secret management services.
- Dependencies MUST be audited for vulnerabilities before addition and regularly thereafter.
- Authentication and authorization MUST be implemented at service boundaries, not just UI layer.

### V.A. Browser Support Standards

All implementations MUST support modern web browsers comprehensively:

- Web browsers MUST support all modern browsers (Chrome, Firefox, Edge, Safari, Brave, Opera).
- Safari testing is NOT required for development due to HTTP server limitations and CORS issues.
- Progressive enhancement MUST ensure functionality degrades gracefully on older browsers.
- Feature detection MUST be used instead of user agent string parsing.
- Performance MUST be tested on at least Chrome, Firefox, and Edge.

Rationale: Comprehensive browser support ensures accessibility for all users while allowing efficient development focused on modern standards. Safari development constraints prevent HTTP server and CORS issues.

## Development Workflow

### Code Review Requirements

- All changes MUST receive at least one approval from a qualified reviewer.
- Reviews MUST verify constitution compliance, not just code correctness.
- Large changes (over 400 lines) MUST be broken into logical, reviewable chunks.
- Automated checks MUST pass before human review begins.

### Quality Gates

- CI pipeline MUST run lint, type checks, and all tests before merge.
- Performance benchmarks MUST not regress by more than 10% without justification.
- Security scans MUST pass with no critical or high-severity findings.

## Governance

This constitution supersedes all other development practices and guides. Amendments require:

1. Documentation of the proposed change with rationale.
2. Review by at least two project maintainers.
3. Migration plan for any affected existing implementations.
4. Update to this document with incremented version number.

Compliance with these principles MUST be verified during code review and CI checks. Violations require documented justification or correction before merge.

**Version**: 2.2.0 | **Ratified**: 2026-01-03 | **Last Amended**: 2026-01-07