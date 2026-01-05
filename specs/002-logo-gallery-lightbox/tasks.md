---
description: "Task list for Logo and Gallery Lightbox feature implementation"
---

# Tasks: Logo and Gallery Lightbox

**Input**: Design documents from `/specs/002-logo-gallery-lightbox/`
**Prerequisites**: plan.md (required), spec.md (required for user stories), research.md, data-model.md, contracts/
**Tests**: Playwright viewport tests included per constitution requirements

**Organization**: Tasks are grouped by user story to enable independent implementation and testing of each story.

## Format: `[ID] [P?] [Story] Description`

- **[P]**: Can run in parallel (different files, no dependencies on incomplete tasks)
- **[Story]**: Which user story this task belongs to (e.g., US1, US2, US3, US4)
- Include exact file paths in descriptions

## Path Conventions

- **Single project**: `src/`, `tests/` at repository root
- Paths shown below assume single project structure per plan.md

---

## Phase 1: Setup (Shared Infrastructure)

**Purpose**: Project initialization and basic structure

- [X] T001 Download U-2 logo image from https://www.vhv.rs/dpng/d/470-4701987_u-2-spy-plane-clipart-black-and-white.png to src/assets/images/logo/
- [X] T002 [P] Convert logo PNG to WEBP format using cwebp at 85% quality in src/assets/images/logo/u2-logo.webp
- [X] T003 [P] Generate favicon-size logo version at 100px width in src/assets/images/logo/u2-logo-favicon.webp

**Checkpoint**: Logo assets ready for implementation

---

## Phase 2: Foundational (Blocking Prerequisites)

**Purpose**: Core infrastructure that MUST be complete before ANY user story can be implemented

**CRITICAL**: No user story work can begin until this phase is complete

- [X] T004 Add lightbox HTML structure to src/index.html following contracts/html.md specification
- [X] T005 [P] Create Lightbox class in src/js/main.js with open(), close(), prev(), next() methods
- [X] T006 [P] Implement lightbox state management (isOpen, currentIndex, isLoading) in src/js/main.js

**Checkpoint**: Foundation ready - user story implementation can now begin in parallel

---

## Phase 3: User Story 1 - Display U-2 Logo in Website Header (Priority: P1) 🎯 MVP

**Goal**: Add U-2 spy plane logo to website header with link to homepage

**Independent Test**: Can be tested by loading website and verifying logo appears in header, is visible on all pages, and clicking returns to homepage

### Implementation for User Story 1

- [X] T007 [US1] Add logo to header section in src/index.html with anchor link to #hero
- [X] T008 [US1] Style logo in src/index.html to maintain visibility on mobile without overlapping header elements
- [X] T009 [US1] Add logo SVG icon to header navigation for consistent display across viewports
- [X] T009b [US1] Verify logo link navigates to #hero section and handles hash routing correctly

**Checkpoint**: User Story 1 should be fully functional and testable independently with logo displaying correctly

---

## Phase 4: User Story 2 - Open Full-Size Images in Lightbox (Priority: P1)

**Goal**: Allow users to click thumbnails and view full-size images in responsive overlay

**Independent Test**: Can be tested by clicking any gallery thumbnail and verifying full-size image opens in responsive overlay

### Implementation for User Story 2

- [X] T010 [US2] Update gallery items in src/index.html to include data-full attribute pointing to full-size images
- [X] T011 [US2] Implement click handler in src/js/main.js to open lightbox on thumbnail click
- [X] T012 [US2] Implement lightbox image loading with loading indicator in src/js/main.js
- [X] T012b [US2] Design and implement loading indicator UI component (spinner or skeleton loader) in src/index.html for lightbox loading state
- [X] T012c [US2] Add loading state timeout handler in src/js/main.js to show error if image fails to load within 10 seconds
- [X] T013 [US2] Add close button functionality in src/js/main.js to close lightbox on click
- [X] T014 [US2] Add overlay click handler in src/js/main.js to close lightbox when clicking outside image
- [X] T015 [US2] Ensure lightbox displays images responsively within viewport per contracts/html.md

**Checkpoint**: User Stories 1 AND 2 should both work independently with basic lightbox functionality

---

## Phase 5: User Story 3 - Navigate Between Images (Priority: P1)

**Goal**: Enable prev/next navigation within lightbox to browse all gallery images

**Independent Test**: Can be tested by opening lightbox, using prev/next controls, and verifying navigation cycles through all images

### Implementation for User Story 3

- [X] T016 [US3] Add prev/next buttons to lightbox HTML in src/index.html
- [X] T017 [US3] Implement prevImage() method in src/js/main.js with wrap-around to last image
- [X] T018 [US3] Implement nextImage() method in src/js/main.js with wrap-around to first image
- [X] T019 [US3] Style prev/next buttons to be visible on desktop viewports in src/index.html
- [X] T020 [US3] Connect prev/next button click handlers to navigation methods in src/js/main.js

**Checkpoint**: User Stories 1, 2, AND 3 should all work independently with full navigation

---

## Phase 6: User Story 4 - Keyboard and Touch Navigation (Priority: P2)

**Goal**: Support keyboard shortcuts and touch swipe gestures for lightbox navigation

**Independent Test**: Can be tested by opening lightbox and verifying escape key closes, arrow keys navigate, and touch swipe works on mobile

### Implementation for User Story 4

- [X] T021 [US4] Implement keyboard event listener in src/js/main.js for Escape key to close lightbox
- [X] T022 [US4] Implement keyboard event listener in src/js/main.js for ArrowLeft to show previous image
- [X] T023 [US4] Implement keyboard event listener in src/js/main.js for ArrowRight to show next image
- [X] T024 [US4] Implement touch event handlers in src/js/main.js using Touch Events API for swipe detection
- [X] T025 [US4] Implement swipe left handler in src/js/main.js to show next image
- [X] T026 [US4] Implement swipe right handler in src/js/main.js to show previous image
- [X] T027 [US4] Add swipe threshold detection (50px) in src/js/main.js to distinguish from taps
- [X] T028 [US4] Prevent default browser behavior for arrow keys to avoid page scroll during navigation

### Error Handling for Edge Cases

- [X] T028b [US4] Implement network error handler in src/js/main.js to display error message when full-size image fails to load
- [X] T028c [US4] Add click debouncing in src/js/main.js to prevent rapid successive clicks from causing issues
- [X] T028d [US4] Implement graceful degradation for very large images using CSS max-width/max-height with object-fit

**Checkpoint**: All user stories should be fully functional with keyboard and touch support

---

## Phase 7: Polish & Cross-Cutting Concerns

**Purpose**: Improvements that affect multiple user stories

- [X] T029 [P] Run HTMLhint on src/index.html and fix any errors
- [X] T030 [P] Run Prettier on src/index.html to format code
- [X] T031 [P] Run Prettier on src/js/main.js to format code
- [X] T032 [P] Verify Lighthouse accessibility score meets 90+ target
- [X] T033 [P] Verify Lighthouse performance score meets 85+ target
- [X] T034 [P] Add ARIA labels to all lightbox interactive elements for accessibility
- [X] T034b [P] Verify close button is keyboard accessible (Tab, Enter, Space) and has visible focus indicator in src/index.html
- [X] T035 [P] Implement focus trap to keep keyboard focus within lightbox when open
- [X] T036 [P] Test lightbox on all viewport sizes from 320px to 3840px
- [X] T037 [P] Verify zero horizontal scrolling when lightbox is open on mobile devices
- [X] T037b [P] Verify no horizontal scrolling occurs when lightbox is open at 320px, 375px, and 414px mobile viewports
- [X] T038 [P] Display image captions in lightbox when available; show placeholder text "No caption available" when caption data attribute is missing or empty

### Testing Requirements

- [X] T039 [P] Write unit tests for Lightbox class methods (open, close, prev, next) in tests/unit/lightbox.test.js
- [X] T040 [P] Write unit tests for keyboard event handlers in tests/unit/keyboard.test.js
- [X] T041 [P] Write unit tests for touch swipe handlers in tests/unit/touch.test.js
- [X] T042 [P] Verify test coverage meets 80% threshold using npm run test:coverage

---

## Dependencies & Execution Order

### Phase Dependencies

- **Setup (Phase 1)**: No dependencies - can start immediately
- **Foundational (Phase 2)**: Depends on Setup completion - BLOCKS all user stories
- **User Stories (Phase 3-6)**: All depend on Foundational phase completion
  - User stories can proceed in parallel (if staffed)
  - Or sequentially in priority order (P1 → P2)
- **Polish (Phase 7)**: Depends on all desired user stories being complete

### User Story Dependencies

- **User Story 1 (P1)**: Can start after Foundational (Phase 2) - No dependencies on other stories - MVP deliverable
- **User Story 2 (P1)**: Can start after Foundational (Phase 2) - Independently testable, core to gallery functionality
- **User Story 3 (P1)**: Can start after Foundational (Phase 2) - Enhances UX but not core deliverable
- **User Story 4 (P2)**: Can start after Foundational (Phase 2) - Required per spec, constitutional accessibility requirement

### Within Each User Story

- Core HTML structure before JavaScript enhancements
- Lightbox navigation after basic lightbox implemented
- Story complete before moving to Polish phase

### Parallel Opportunities

- All Setup tasks marked [P] can run in parallel (T001-T003)
- All Foundational tasks marked [P] can run in parallel (T005-T006)
- Once Foundational phase completes, User Stories 1-4 can start in parallel:
  - Developer A: User Story 1 (logo implementation)
  - Developer B: User Story 2 (lightbox open/close)
  - Developer C: User Stories 3-4 (navigation and input methods)
- Polish phase tasks marked [P] can run in parallel

---

## Parallel Execution Examples

### Setup Phase
```bash
Task: T001 - Download logo image
Task: T002 - Convert logo to WEBP
Task: T003 - Generate favicon version
```

### Foundational Phase
```bash
Task: T004 - Add lightbox HTML structure
Task: T005 - Create Lightbox class
Task: T006 - Implement state management
```

### Polish Phase Linting
```bash
Task: T029 - Run HTMLhint on index.html
Task: T030 - Run Prettier on index.html
Task: T031 - Run Prettier on main.js
```

---

## Implementation Strategy

### MVP First (User Story 1 Only)

1. Complete Phase 1: Setup
2. Complete Phase 2: Foundational
3. Complete Phase 3: User Story 1 (logo only)
4. **STOP and VALIDATE**: Test User Story 1 independently
5. Deploy/demo MVP with logo only

### Incremental Delivery

1. Complete Setup + Foundational → Foundation ready
2. Add User Story 1 → Test independently → Deploy/Demo (Logo!)
3. Add User Story 2 → Test independently → Deploy/Demo (Basic lightbox!)
4. Add User Story 3 → Test independently → Deploy/Demo (Navigation!)
5. Add User Story 4 → Test independently → Deploy/Demo (Accessibility!)
6. Polish phase → Final production build

### Parallel Team Strategy

With multiple developers:

1. Team completes Setup + Foundational together
2. Once Foundational is done:
   - Developer A: User Story 1 (logo display)
   - Developer B: User Story 2 (lightbox open/close)
   - Developer C: User Stories 3-4 (navigation + input methods)
3. Stories complete and integrate independently

---

## Notes

- [P] tasks = different files, no dependencies on incomplete tasks
- [Story] label maps task to specific user story for traceability
- Each user story should be independently completable and testable
- Verify tests fail before implementing (TDD approach for constitution compliance)
- Commit after each task or logical group
- Stop at any checkpoint to validate story independently
- Avoid: vague tasks, same file conflicts, cross-story dependencies that break independence
