# Constitution Template

Copy this content to `.specify/memory/constitution.md` for similar static website projects.

```markdown
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

**Version**: 1.0.1 | **Ratified**: 2026-01-03 | **Last Amended**: 2026-01-06
```

---

# Specify Template

Copy this content to `.specify/templates/spec-template.md` for creating feature specifications.

````markdown
# Bug Fix Specification: [Feature Name]

**Feature Branch**: `[branch-name]`  
**Created**: `[YYYY-MM-DD]`  
**Updated**: `[YYYY-MM-DD]`  
**Status**: Draft | In Review | Complete  
**Input**: User description: "[Original user request]"

## User Scenarios & Testing _(mandatory)_

<!--
  IMPORTANT: User stories should be PRIORITIZED as user journeys ordered by importance.
  Each user story/journey must be INDEPENDENTLY TESTABLE - meaning if you implement just ONE of them,
  you should still have a viable MVP (Minimum Viable Product) that delivers value.

  Assign priorities (P1, P2, P3, etc.) to each story, where P1 is the most critical.
  Think of each story as a standalone slice of functionality that can be:
  - Developed independently
  - Tested independently
  - Deployed independently
  - Demonstrated to users independently
-->

### User Story 1 - [Title] (Priority: P1)

**As a** [user persona],  
**I want** [action/goal],  
**So that** [benefit/value].

**Why this priority**: [Rationale for priority level]

**Independent Test**: [How to verify this story works in isolation]

**Acceptance Scenarios**:

1. **Given** [precondition], **When** [action], **Then** [expected outcome]
2. **Given** [precondition], **When** [action], **Then** [expected outcome]
3. **Given** [precondition], **When** [action], **Then** [expected outcome]

---

### User Story 2 - [Title] (Priority: P2)

[Same structure as User Story 1]

---

### User Story N - [Title] (Priority: PN)

[Same structure as User Story 1]

---

### Edge Cases

- What happens if [condition A]?
- What happens if [condition B]?
- How should [unexpected scenario] be handled?
- What if [resource] is unavailable?

## HTML Reference Examples

### Component Name (Before Fix)

```html
<!-- BEFORE -->
<element class="problematic-classes">Content</element>
```
````

### Component Name (After Fix)

```html
<!-- AFTER -->
<element class="fixed-classes">Content</element>
```

## Technical Implementation _(mandatory)_

### Technical Approach

- **Technology Choice**: [e.g., Pure Tailwind CSS, React, etc.]
- **Justification**: [Why this approach was chosen]
- **Testing Approach**: [How this will be tested]

### Libraries/Dependencies

| Name  | Version   | Purpose        |
| ----- | --------- | -------------- |
| [lib] | [version] | [what it does] |

## Requirements _(mandatory)_

### Functional Requirements

- **FR-001**: [Requirement description]
- **FR-002**: [Requirement description]
- **FR-N**: [Requirement description]

### Key Entities

- **Entity Name**: Description and purpose
- **Entity Name**: Description and purpose

## Assumptions _(optional)_

- [Assumption 1]
- [Assumption 2]

## Success Criteria _(mandatory)_

### Measurable Outcomes

- **SC-001**: [Specific, measurable criterion]
- **SC-002**: [Specific, measurable criterion]
- **SC-N**: [Specific, measurable criterion]

---

# Plan Template

Copy this content to `.specify/templates/plan-template.md` for implementation planning.

````markdown
# Implementation Plan: [Feature Name]

**Branch**: `[branch]` | **Date**: `[YYYY-MM-DD]` | **Spec**: `[path to spec]`
**Input**: Feature specification from `[path to spec]`

## Summary

[Brief 2-3 sentence description of what this feature implements]

## Technical Context

**Language/Version**: [e.g., HTML5, CSS3, JavaScript ES2022]  
**Primary Dependencies**: [Main libraries/frameworks]  
**Storage**: [Database, localStorage, files, N/A]  
**Testing**: [Testing frameworks and approach]  
**Target Platform**: [Web browsers, mobile, desktop]  
**Performance Goals**: [e.g., <200ms response time]  
**Constraints**: [Technical and business constraints]  
**Scale/Scope**: [Size of changes, affected components]

## Constitution Check

_GATE: Must pass before Phase 0 research. Re-check after Phase 1 design._

### Code Quality Excellence ✅ PASS | ⚠️ NEEDS REVIEW | ❌ FAIL

- [x] Code follows established patterns (verified in design)
- [x] Changes are minimal and targeted
- [x] Self-documenting code, no complex logic requiring comments
- [x] Data model and contracts provide clear implementation guidance

### Testing Standards ✅ PASS | ⚠️ NEEDS REVIEW | ❌ FAIL

- [x] Testing approach designed: [e.g., Playwright visual regression + unit tests]
- [x] [Coverage %] test coverage achieved
- [x] Comprehensive test contracts created
- [x] Constitution requirements satisfied through measurable testing

### User Experience Consistency ✅ PASS | ⚠️ NEEDS REVIEW | ❌ FAIL

- [x] Follows existing platform conventions
- [x] Uses existing design tokens and patterns
- [x] Response time target achievable
- [x] Accessibility compliance designed in
- [x] Focus states and accessibility preserved

### Performance Requirements ✅ PASS | ⚠️ NEEDS REVIEW | ❌ FAIL

- [x] Zero memory usage changes
- [x] No network request modifications
- [x] Performance contracts ensure zero bundle impact

### Additional Requirements ✅ PASS | ⚠️ NEEDS REVIEW | ❌ FAIL

- [x] Agent context updated with technologies
- [x] Browser support clarified
- [x] Security standards maintained
- [x] Code review requirements satisfied

### Overall Status: ✅ PASS - PRE-DESIGN VERIFICATION

[Summary of why this can proceed]

---

## Project Structure

### Documentation (this feature)

```text
specs/[###-feature]/
├── plan.md              # This file (/speckit.plan command output)
├── research.md          # Phase 0 output (/speckit.plan command)
├── data-model.md        # Phase 1 output (/speckit.plan command)
├── quickstart.md        # Phase 1 output (/speckit.plan command)
├── contracts/           # Phase 1 output (/speckit.plan command)
└── tasks.md             # Phase 2 output (/speckit.tasks command)
```
````

### Source Code (repository root)

```text
src/
├── [source files]
tests/
├── [test files]
public/
└── [built assets]
```

**Structure Decision**: [Why this structure was chosen]

## Complexity Tracking

> **Fill ONLY if Constitution Check has violations that must be justified**

| Violation   | Why Needed     | Simpler Alternative Rejected Because |
| ----------- | -------------- | ------------------------------------ |
| [violation] | [current need] | [why simpler approach insufficient]  |

---

# Tasks Template

Copy this content to `.specify/templates/tasks-template.md` for task generation.

```markdown
---
description: "Task list for [feature name] implementation"
---

# Tasks: [Feature Name]

**Input**: Design documents from `/specs/[feature]/`
**Prerequisites**: plan.md (required), spec.md (required for user stories), research.md, data-model.md, contracts/

**Tests**: [What types of tests are included]

**Organization**: Tasks are grouped by user story to enable independent implementation and testing of each story.

## Format: `[ID] [P?] [Story] Description`

- **[P]**: Can run in parallel (different files, no dependencies)
- **[Story]**: Which user story this task belongs to (e.g., US1, US2, US3)
- Include exact file paths in descriptions

## Path Conventions

- **Static website**: `src/`, `tests/` at repository root
- **Paths below follow single project structure from plan.md**

---

## Phase 1: Setup (Shared Infrastructure)

**Purpose**: Project initialization and verify existing configuration

- [ ] T001 Verify [configuration] in [file]
- [ ] T002 [P] Confirm [entity] definitions exist in [file]
- [ ] T003 [P] Verify existing [component] structure in [path]
- [ ] T004 [P] Check current [resource] file exists at [path]

---

## Phase 2: Foundational (Testing Infrastructure)

**Purpose**: Test framework setup for [feature type]

**⚠️ CRITICAL**: Tests must be set up before implementation to satisfy Constitution coverage requirements

- [ ] T005 Create [test type] test structure in [path]
- [ ] T006 [P] Create [test type] test structure in [path]
- [ ] T007 [P] Create [test type] test structure in [path]
- [ ] T008 [P] Configure [testing framework] for [specific requirements]

**Checkpoint**: Testing infrastructure ready - implementation can now begin

---

## Phase 3: User Story 1 - [Story Title] (Priority: P1) 🎯 MVP

**Goal**: [What this story accomplishes]

**Independent Test**: [How to verify this story independently]

### Tests for User Story 1

> **NOTE: Tests should be written and FAIL before implementation**

- [ ] T010 [P] [US1] Create [test type] test for [component] in [path]
- [ ] T011 [P] [US1] Create [test type] test for [component] in [path]

### Implementation for User Story 1

- [ ] T013 [US1] Locate [element] with [classes/attributes] in [path]
- [ ] T014 [US1] [Action] [classes/attributes] in [path]
- [ ] T015 [US1] Verify [remaining properties] are preserved in [path]
- [ ] T016 [US1] Run [test] to confirm [expected behavior] in [path]
- [ ] T017 [US1] Run [test] to verify [accessibility/functionality] in [path]

**Checkpoint**: User Story 1 should be fully functional and testable independently

---

## Phase N: User Story N - [Story Title] (Priority: PN)

**Goal**: [What this story accomplishes]

**Independent Test**: [How to verify this story independently]

### Tests for User Story N

- [ ] TN01 [P] [USN] Create [test type] test for [component] in [path]

### Implementation for User Story N

- [ ] TN03 [USN] Locate [element] with [classes/attributes] in [path]
- [ ] TN04 [USN] [Action] [classes/attributes] in [path]
- [ ] TN05 [USN] Verify [remaining properties] are preserved in [path]
- [ ] TN06 [USN] Run [test] to confirm [expected behavior] in [path]

**Checkpoint**: User Story N should be fully functional

---

## Phase N+1: Polish & Cross-Cutting Concerns

**Purpose**: Final validation and integration testing

- [ ] TN+1 [P] Run complete [test suite] for all user stories
- [ ] TN+2 [P] Run [test type] tests for [requirement]
- [ ] TN+3 [P] Run linting checks per technical implementation requirements
- [ ] TN+4 [P] Run performance validation
- [ ] TN+5 Update [documentation] with implementation notes
- [ ] TN+6 [P] Manual testing validation in [browsers]
- [ ] TN+7 Verify success criteria from specification

---

## Dependencies & Execution Order

### Phase Dependencies

- **Setup (Phase 1)**: No dependencies - can start immediately
- **Foundational (Phase 2)**: Depends on Setup completion - BLOCKS all user stories
- **User Stories (Phase 3-N)**: All depend on Foundational phase completion
  - User stories can then proceed in parallel (if staffed)
  - Or sequentially in priority order
- **Polish (Phase N+1)**: Depends on all desired user stories being complete

### User Story Dependencies

- **User Story 1**: Can start after Foundational - No dependencies on other stories
- **User Story 2**: Can start after Foundational - No dependencies on other stories
- **User Story N**: Can start after Foundational - No dependencies on other stories

### Within Each User Story

- Tests MUST be written and FAIL before implementation
- Implementation follows test creation
- Visual validation after each story completion

### Parallel Opportunities

- All Setup tasks can run in parallel
- All Foundational tasks can run in parallel
- Once Foundational phase completes, all user stories can start in parallel
- All tests for each user story marked [P] can run in parallel
- All Polish tasks can run in parallel

---

## Implementation Strategy

### MVP First (User Story 1 Only)

1. Complete Phase 1: Setup
2. Complete Phase 2: Foundational (CRITICAL - blocks all stories)
3. Complete Phase 3: User Story 1
4. **STOP and VALIDATE**: Test User Story 1 independently
5. Deploy/demo if ready

### Incremental Delivery

1. Complete Setup + Foundational → Foundation ready
2. Add User Story 1 → Test independently → Deploy/Demo (MVP!)
3. Add User Story 2 → Test independently → Deploy/Demo
4. Add User Story N → Test independently → Deploy/Demo
5. Each story adds value without breaking previous stories

### Parallel Team Strategy

With multiple developers:

1. Team completes Setup + Foundational together
2. Once Foundational is done:
   - Developer A: User Story 1
   - Developer B: User Story 2
   - Developer C: User Story N
3. Stories complete and integrate independently
4. Team completes Polish phase together

---

## Notes

- [P] tasks = different files, no dependencies
- [Story] label maps task to specific user story for traceability
- Each user story should be independently completable and testable
- Tests must fail before implementing (TDD approach)
- Commit after each task or logical group
- Stop at any checkpoint to validate story independently
```

---

# Quick Reference: Project Commands

## Setup Commands

```bash
# Check prerequisites
.specify/scripts/bash/check-prerequisites.sh --json --require-tasks --include-tasks

# Setup plan
.specify/scripts/bash/setup-plan.sh --json

# Run tests
npm test

# Build CSS
npm run build

# Update snapshots
npx playwright test --update-snapshots
```

## File Locations for U-2 Project

```
.specify/
├── memory/
│   └── constitution.md          # Quality standards and rules
├── scripts/
│   ├── bash/
│   │   ├── check-prerequisites.sh
│   │   └── setup-plan.sh
│   └── [other scripts]
├── templates/
│   ├── spec-template.md
│   ├── plan-template.md
│   ├── tasks-template.md
│   └── [other templates]

specs/
├── 001-[feature]/
│   ├── spec.md                  # User stories & requirements
│   ├── plan.md                  # Architecture & tech stack
│   ├── research.md              # Technical decisions
│   ├── data-model.md            # Entities & relationships
│   ├── quickstart.md            # Implementation guide
│   ├── contracts/               # API/test contracts
│   ├── tasks.md                 # Task breakdown
│   └── checklists/
│       └── requirements.md      # Quality checklist

src/
├── index.html                   # Main HTML
├── css/
│   └── styles.css               # Tailwind source
└── assets/

public/
├── index.html                   # Built HTML
└── styles.css                   # Compiled CSS

tests/
├── visual/
│   └── css-fixes.spec.ts        # Visual regression tests
├── accessibility/
│   └── a11y-critical.spec.ts    # WCAG compliance tests
└── responsive/
    └── responsive-behavior.spec.ts
```

---

# Lessons Learned

## What Worked Well

1. **Visual Regression Testing**: Playwright screenshot comparison effectively caught unintended UI changes
2. **Component Contracts**: Clear before/after HTML examples made implementation straightforward
3. **User Story Organization**: Independent testable stories enabled incremental delivery
4. **Constitution Validation**: Pre-design checks prevented architectural mistakes

## What Could Improve

1. **Hero Section Overlays**: Adding wrapper divs with z-index changed stacking context unexpectedly. Better to work within existing structure.
2. **Test Selector Specificity**: Generic selectors like `h1` and `.hero-image-container` matched duplicate elements. Use unique IDs or more specific classes.
3. **SVG vs Raster Images**: `object-cover` behaves differently on SVG vs raster images. Tailor class to image type.
4. **Shared State Between Specs**: Multiple `002-*` branches caused conflicts. Ensure single feature branch active at a time.

## Recommendations for Future Projects

1. **Start with tests**: Write failing tests before implementation (TDD)
2. **Use unique IDs**: Every major component should have a unique ID
3. **Incremental changes**: Make small, verifiable changes one at a time
4. **Document decisions**: Record why each technical choice was made
5. **Validate early**: Test in browser before assuming implementation complete
