# Tasks: Image WebP Optimization

**Input**: Design documents from `/specs/001-image-webp-optimization/`
**Prerequisites**: plan.md (required), spec.md (required for user stories), research.md, data-model.md, contracts/

**Tests**: Playwright E2E tests are included to validate performance metrics (page load time, CLS, bandwidth).

**Organization**: Tasks are grouped by user story to enable independent implementation and testing of each story.

## Format: `[ID] [P?] [Story] Description`

- **[P]**: Can run in parallel (different files, no dependencies)
- **[Story]**: Which user story this task belongs to (e.g., US1, US2, US3)
- Include exact file paths in descriptions

## Path Conventions

- **Scripts**: `scripts/` at repository root (image processing utilities)
- **Tests**: `tests/e2e/` (Playwright tests), `tests/unit/` (unit tests)
- **Images**: `src/assets/images/` (source images for 004-u2-spyplane-website)
- **HTML**: `src/` (HTML files for 004-u2-spyplane-website)

---

## Phase 1: Setup (Shared Infrastructure)

**Purpose**: Project initialization and dependencies

- [x] T001 Create scripts directory structure in scripts/
- [x] T002 Install npm dependencies: sharp (^0.33.0), cheerio (^1.0.0-rc.12), glob (^10.3.0), chalk (^5.3.0), playwright (^1.40.0)
- [x] T003 Initialize Playwright for E2E testing in tests/e2e/
- [x] T004 [P] Create package.json scripts section for easy script execution
- [x] T005 [P] Create .gitignore entry for test artifacts and backup files (\*.backup)

---

## Phase 2: Foundational (Blocking Prerequisites)

**Purpose**: Core infrastructure that MUST be complete before ANY user story can be implemented

**⚠️ CRITICAL**: No user story work can begin until this phase is complete

- [x] T006 Create shared utility functions in scripts/lib/utils.js (file operations, error handling, logging)
- [x] T007 Create shared image metadata extraction utility in scripts/lib/image-utils.js (using Sharp)
- [x] T008 [P] Create shared HTML parsing utilities in scripts/lib/html-utils.js (using Cheerio)
- [x] T008a [P] Unit test for utils.js public functions in tests/unit/utils.test.js (test file operations, error handling, logging)
- [x] T008b [P] Unit test for image-utils.js public functions in tests/unit/image-utils.test.js (test metadata extraction, format detection)
- [x] T008c [P] Unit test for html-utils.js public functions in tests/unit/html-utils.test.js (test HTML parsing, tag extraction)

**Checkpoint**: Foundation ready - user story implementation can now begin in parallel

---

## Phase 3: User Story 1 - WebP Image Conversion (Priority: P1) 🎯 MVP

**Goal**: Convert all non-SVG images (JPEG, PNG, GIF) to WebP format to improve page load performance and reduce bandwidth usage while maintaining visual quality.

**Independent Test**: Run `node scripts/convert-to-webp.js --source ./assets/images --dry-run` and verify all non-SVG images would be converted. Then run without dry-run and verify WebP files exist alongside originals with acceptable visual quality.

### Tests for User Story 1 ⚠️

> **NOTE: Write these tests FIRST, ensure they FAIL before implementation**

- [x] T009 [P] [US1] E2E test for WebP conversion in tests/e2e/webp-conversion.spec.js
- [x] T010 [P] [US1] E2E test for page load time improvement in tests/e2e/performance.spec.js
- [x] T011 [P] [US1] E2E test for bandwidth reduction in tests/e2e/performance.spec.js
- [x] T011a [US1] Verify WebP E2E tests (T009-T011) FAIL before implementation begins

### Implementation for User Story 1

- [x] T012 [US1] Create convert-to-webp.js CLI script in scripts/convert-to-webp.js (depends on T006, T007)
- [x] T013 [US1] Implement file scanning and filtering in scripts/convert-to-webp.js (find JPEG, PNG, GIF, WebP, SVG files)
- [x] T014 [US1] Implement WebP conversion using Sharp in scripts/convert-to-webp.js (quality control, transparency handling)
- [x] T015 [US1] Implement dry-run mode in scripts/convert-to-webp.js (preview without modifying)
- [x] T016 [US1] Implement statistics calculation in scripts/convert-to-webp.js (file counts, size reduction percentage)
- [x] T017 [US1] Add error handling for corrupt/unsupported files in scripts/convert-to-webp.js
- [x] T018 [US1] Add CLI argument parsing (--source, --quality, --skip-svg, --preserve-original, --dry-run, --verbose) in scripts/convert-to-webp.js
- [x] T019 [US1] Add colored terminal output using chalk in scripts/convert-to-webp.js

**Checkpoint**: At this point, User Story 1 should be fully functional and testable independently

---

## Phase 4: User Story 2 - Meaningful Alt-Text (Priority: P2)

**Goal**: Ensure all images have descriptive alt-text that provides meaningful information about image content for accessibility and screen reader users.

**Independent Test**: Run `node scripts/audit-alt-text.js --source ./frontend/src` and verify report identifies all missing/poor alt-text. Fix issues manually, re-run audit, and verify 0 errors remain.

### Tests for User Story 2 ⚠️

> **NOTE: Write these tests FIRST, ensure they FAIL before implementation**

- [x] T020 [P] [US2] E2E test for alt-text accessibility in tests/e2e/accessibility.spec.js
- [x] T021 [P] [US2] E2E test for screen reader compatibility in tests/e2e/accessibility.spec.js
- [x] T021a [US2] Verify alt-text E2E tests (T020-T021) FAIL before implementation begins

**Test Implementation (tests/e2e/accessibility.spec.js):**

```javascript
// T020: Alt-text accessibility validation test
test("audit-alt-text.js identifies missing alt-text on images", async () => {
  const { exitCode, stdout } = await execAsync(
    "node scripts/audit-alt-text.js --source tests/fixtures/missing-alt-test.html",
  );
  expect(exitCode).toBe(0);
  const results = JSON.parse(stdout);
  expect(results.errors).toContainEqual(
    expect.objectContaining({ type: "missing-alt" }),
  );
});

// T021: Screen reader compatibility test
test("audit-alt-text.js validates alt-text length and quality", async () => {
  const { exitCode, stdout } = await execAsync(
    "node scripts/audit-alt-text.js --source tests/fixtures/poor-alt-test.html --check-length",
  );
  expect(exitCode).toBe(0);
  const results = JSON.parse(stdout);
  expect(results.warnings).toContainEqual(
    expect.objectContaining({ type: "alt-too-long" }),
  );
});
```

**Status**: ✅ COMPLETE - Tests written and verified to fail before implementation

### Implementation for User Story 2

- [x] T022 [US2] Create audit-alt-text.js CLI script in scripts/audit-alt-text.js (depends on T006, T008)
- [x] T023 [US2] Implement HTML file scanning in scripts/audit-alt-text.js (find .html, .htm files)
- [x] T024 [US2] Implement image tag extraction in scripts/audit-alt-text.js (extract src, alt attributes)
- [x] T025 [US2] Implement alt-text validation rules in scripts/audit-alt-text.js (missing, empty, filename, length, redundant phrases)
- [x] T026 [US2] Implement decorative image detection in scripts/audit-alt-text.js (empty alt, role="presentation")
- [x] T027 [US2] Implement severity assignment in scripts/audit-alt-text.js (error, warning, info)
- [x] T028 [US2] Implement JSON output generation in scripts/audit-alt-text.js (findings, summary, compliance rate)
- [x] T029 [US2] Add CLI argument parsing (--source, --extensions, --output, --exclude, --check-decorative, --check-length) in scripts/audit-alt-text.js
- [x] T030 [US2] Add colored terminal output using chalk in scripts/audit-alt-text.js
- [x] T031 [US2] Update frontend/src HTML files with alt-text (manual process guided by audit results)
- [x] T032 [US2] Verify alt-text quality with screen reader testing (manual QA)

**Checkpoint**: At this point, User Stories 1 AND 2 should both work independently

---

## Phase 5: User Story 3 - Image Dimension Attributes (Priority: P3)

**Goal**: Ensure all images include width/height attributes or aspect-ratio CSS to prevent layout shifts and improve Cumulative Layout Shift (CLS) metric.

**Independent Test**: Run `node scripts/extract-dimensions.js --source ./assets/images --html-dir ./frontend/src --dry-run` and verify dimensions would be added. Run without dry-run and verify HTML files have width/height or aspect-ratio attributes.

### Tests for User Story 3 ⚠️

- [x] T033 [P] [US3] E2E test for CLS score improvement in tests/e2e/performance.spec.js
- [x] T034 [P] [US3] E2E test for layout stability (no layout shifts) in tests/e2e/layout.spec.js
- [x] T034a [US3] Verify dimension E2E tests (T033-T034) FAIL before implementation begins

### Implementation for User Story 3

- [x] T035 [US3] Create extract-dimensions.js CLI script in scripts/extract-dimensions.js (depends on T006, T007, T008)
- [x] T036 [US3] Implement image metadata extraction in scripts/extract-dimensions.js (width, height, format, size)
- [x] T037 [US3] Implement aspect ratio calculation in scripts/extract-dimensions.js (GCD simplification)
- [x] T038 [US3] Implement HTML file scanning in scripts/extract-dimensions.js
- [x] T039 [US3] Implement image tag matching in scripts/extract-dimensions.js (match src to metadata, handle relative/absolute paths)
- [x] T040 [US3] Implement attribute addition logic in scripts/extract-dimensions.js (width-height, aspect-ratio, or both)
- [x] T041 [US3] Implement existing attribute handling in scripts/extract-dimensions.js (override mismatch, warn on significant differences)
- [x] T042 [US3] Implement HTML file modification in scripts/extract-dimensions.js (backup files, preserve encoding)
- [x] T043 [US3] Implement dry-run mode in scripts/extract-dimensions.js (preview without modifying)
- [x] T044 [US3] Add CLI argument parsing (--source, --html-dir, --attribute, --format, --output, --dry-run, --backup) in scripts/extract-dimensions.js
- [x] T045 [US3] Add colored terminal output using chalk in scripts/extract-dimensions.js

**Checkpoint**: All user stories should now be independently functional

---

## Phase 6: Polish & Cross-Cutting Concerns

**Purpose**: Improvements that affect multiple user stories

- [x] T046 [P] Update AGENTS.md with script usage examples in AGENTS.md
- [x] T047 [P] Create README for scripts directory in scripts/README.md (usage examples, troubleshooting)
- [x] T048 Run all Playwright E2E tests and verify performance targets met
- [x] T049 Validate quickstart.md guide against actual script behavior
- [x] T050 Code cleanup: Add inline comments explaining complex logic in all scripts
- [x] T051 Add error recovery: Handle edge cases (missing directories, permission errors, disk space)
- [x] T052 Add progress indicators for long-running operations in all scripts
- [x] T053 [P] Create validation script in scripts/validate-optimization.js (checks: 100% WebP, 100% alt-text, 100% dimensions)

---

## Dependencies & Execution Order

### Phase Dependencies

- **Setup (Phase 1)**: No dependencies - can start immediately
- **Foundational (Phase 2)**: Depends on Setup completion - BLOCKS all user stories
- **User Stories (Phase 3-5)**: All depend on Foundational phase completion
  - User stories can then proceed in parallel (if staffed)
  - Or sequentially in priority order (P1 → P2 → P3)
- **Polish (Phase 6)**: Depends on all desired user stories being complete

### User Story Dependencies

- **User Story 1 (P1)**: Can start after Foundational (Phase 2) - No dependencies on other stories
- **User Story 2 (P2)**: Can start after Foundational (Phase 2) - Independent of US1 and US3
- **User Story 3 (P3)**: Can start after Foundational (Phase 2) - Independent of US1 and US2, but should run after alt-text is added to avoid re-adding dimensions if HTML is modified

### Within Each User Story

- Tests MUST be written and FAIL before implementation
- Tests for each story can run in parallel (different files)
- Core script implementation before error handling/CLI args
- Script complete before moving to next priority

### Parallel Opportunities

- All Setup tasks marked [P] can run in parallel (T004, T005)
- All Foundational tasks marked [P] can run in parallel (T008)
- Once Foundational phase completes, all user stories can start in parallel (if team capacity allows)
- All tests for a user story marked [P] can run in parallel (T009-T011, T020-T021, T033-T034)
- Polish tasks marked [P] can run in parallel (T046, T047)
- Different user stories can be worked on in parallel by different team members

---

## Parallel Example: User Story 1

```bash
# Launch all tests for User Story 1 together:
Task: "E2E test for WebP conversion in tests/e2e/webp-conversion.spec.js"
Task: "E2E test for page load time improvement in tests/e2e/performance.spec.js"
Task: "E2E test for bandwidth reduction in tests/e2e/performance.spec.js"

# After tests fail as expected, implement script sequentially:
Task: "Create convert-to-webp.js CLI script in scripts/convert-to-webp.js"
Task: "Implement file scanning and filtering in scripts/convert-to-webp.js"
Task: "Implement WebP conversion using Sharp in scripts/convert-to-webp.js"
# ... continue with remaining T014-T019
```

---

## Implementation Strategy

### MVP First (User Story 1 Only)

1. Complete Phase 1: Setup
2. Complete Phase 2: Foundational (CRITICAL - blocks all stories)
3. Complete Phase 3: User Story 1 (WebP conversion)
4. **STOP and VALIDATE**: Test User Story 1 independently
   - Run conversion script: `node scripts/convert-to-webp.js --source ./assets/images`
   - Verify WebP files exist
   - Verify visual quality
   - Run E2E tests: measure page load time and bandwidth reduction
5. Deploy if performance targets met (20% faster, 25% bandwidth reduction)

### Incremental Delivery

1. Complete Setup + Foundational → Foundation ready
2. Add User Story 1 → Test independently → Deploy/Demo (MVP!)
3. Add User Story 2 → Test independently → Deploy/Demo
4. Add User Story 3 → Test independently → Deploy/Demo
5. Each story adds value without breaking previous stories

### Parallel Team Strategy

With multiple developers:

1. Team completes Setup + Foundational together
2. Once Foundational is done:
   - Developer A: User Story 1 (WebP conversion)
   - Developer B: User Story 2 (Alt-text audit and manual fixes)
   - Developer C: User Story 3 (Dimension extraction)
3. Stories complete and integrate independently

---

## Notes

- [P] tasks = different files, no dependencies
- [Story] label maps task to specific user story for traceability
- Each user story should be independently completable and testable
- Verify tests fail before implementing
- Commit after each task or logical group
- Stop at any checkpoint to validate story independently
- Alt-text assignment is MANUAL after audit script runs (not automated)
- Dimension extraction should run AFTER alt-text is added to avoid re-processing if HTML is modified
- Backup files (\*.backup) are created automatically, can be deleted after validation
