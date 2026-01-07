<!--
Sync Impact Report:
- Version change: 1.0.1 → 2.0.0 (MAJOR - complete restructuring with new principles)
- Modified principles: All principles replaced with user-specified content
- Added sections: Code Quality Excellence, Testing Standards, User Experience Consistency, Performance Requirements, Additional Constraints, Development Workflow
- Templates requiring updates: ✅ plan-template.md (already aligned), ✅ spec-template.md (already aligned), ✅ tasks-template.md (already aligned)
- Follow-up TODOs: None
-->

# Specify Agent Constitution

## Core Principles

### I. Code Quality Excellence

All code MUST meet the following quality standards:

- Code MUST be self-documenting with clear, descriptive names for variables, functions, and types.
- Functions MUST have a single responsibility and remain under 50 lines where practical.
- Code MUST follow the project's established style guide and pass all linting checks before merge.
- Complex logic MUST include inline comments explaining the "why" not the "what".
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

### III. User Experience Consistency

All user-facing interfaces MUST maintain consistent experience:

- Interactions MUST follow platform conventions (iOS HIG, Material Design, or web standards).
- Error messages MUST be human-readable, actionable, and consistent in tone.
- Visual design tokens MUST be shared across all UI components.
- Response times for user actions MUST remain under 200ms for perceived responsiveness.
- Accessibility standards (WCAG 2.1 AA) MUST be met for all user interfaces.

Rationale: Consistent UX reduces cognitive load for users, improves accessibility, and creates professional, trustworthy interactions. Predictable behavior increases user confidence and satisfaction.

### IV. Performance Requirements

All implementations MUST meet these performance standards:

- Resource usage MUST be proportional to work performed with no memory leaks.
- Network requests MUST batch where possible and include proper caching headers.
- Database queries MUST use indexes and avoid N+1 patterns.
- Background operations MUST not block user-facing interactions.
- Performance MUST be measurable with benchmarks for critical paths.
- Web browsers MUST support all modern browsers (Chrome, Firefox, Edge); Safari testing is NOT required for development.

Rationale: Performance directly impacts user experience and operational costs. Efficient resource usage scales better, reduces infrastructure costs, and maintains responsiveness under load.

## Additional Constraints

### Technology Stack

- New dependencies MUST be evaluated for maintenance status, security posture, and community support.
- Major framework upgrades MUST have a migration plan and backward compatibility strategy.
- Polyglot services MUST isolate language-specific tooling to enable independent updates.

### Security Standards

- All inputs MUST be validated and sanitized to prevent injection attacks.
- Secrets MUST never be committed to version control; use environment variables or secret management services.
- Dependencies MUST be audited for vulnerabilities before addition and regularly thereafter.
- Authentication and authorization MUST be implemented at service boundaries, not just UI layer.

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

**Version**: 2.0.0 | **Ratified**: 2026-01-03 | **Last Amended**: 2026-01-07