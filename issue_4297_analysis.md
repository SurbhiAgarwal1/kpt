# Issue #4297: E2E Tests with Latest Function Versions - Deep Analysis

## Problem Statement
E2E tests are pinned to old KRM function versions. When tests fail on newer versions, we don't know if it's a test issue or a breaking change in the function. Tests should use `:latest` to catch breaking changes early.

## Current State Analysis

### Function Versions Found in E2E Tests

| Function | Current Version | Occurrences | Status |
|----------|----------------|-------------|---------|
| `set-namespace` | v0.2.0 | 91 | ⚠️ Very old |
| `set-namespace` | v0.4.1 | 1 | ⚠️ Old |
| `set-labels` | v0.1.5 | 85 | ⚠️ Very old |
| `set-annotations` | v0.1.4 | 3 | ⚠️ Old |
| `drop-comments` | v0.1 | 2 | ⚠️ Very old |
| `foo` | v0.1 | 1 | ⚠️ Test function |
| `bar` | v0.1 | 1 | ⚠️ Test function |
| `wasm/set-namespace` | v0.5.0 | 1 | ⚠️ WASM version |
| `starlark` | latest | Many | ✅ Already using latest |

### Test File Locations

**Kptfile configurations** (where versions are defined):
- `e2e/testdata/fn-render/*/Kptfile` - ~40+ files
- `e2e/testdata/fn-eval/*/Kptfile` - ~30+ files
- `package-examples/guestbook/Kptfile` - 1 file
- `krm-functions-catalog/archived/functions/go/fix/testdata/` - archived tests

**Expected output files** (need updating after version change):
- `e2e/testdata/*//.expected/config.yaml` - Contains expected stderr/stdout with version strings
- `e2e/testdata/*//.expected/results.yaml` - Contains expected function results with versions
- `e2e/testdata/*//.expected/diff.patch` - Contains expected diffs with version strings

### Test Categories

1. **fn-render tests** (~40 test cases)
   - Basic pipeline execution
   - Subpackage handling
   - Selectors and exclusions
   - Out-of-place rendering
   - Error handling

2. **fn-eval tests** (~30 test cases)
   - Simple function execution
   - Subpackage evaluation
   - Selector behavior
   - Save function behavior

3. **Other tests**
   - Package examples
   - Archived/legacy tests (can skip)

## Liam's Guidance

From his response:
1. ✅ Use `:latest` tag (not pinned versions)
2. ✅ Do multiple PRs by function (easier to review)
3. ✅ No known breaking changes (but we should verify)
4. ✅ Tests should catch breaking changes early

## Implementation Strategy

### Phase 1: set-namespace (HIGHEST PRIORITY)
- **Why first**: Most used (91 occurrences), core functionality
- **Files to update**:
  - ~40 Kptfile configs in `e2e/testdata/fn-render/`
  - ~30 Kptfile configs in `e2e/testdata/fn-eval/`
  - ~70 `.expected/config.yaml` files (update version strings in stderr/stdout)
  - ~10 `.expected/results.yaml` files (update image versions)
  - ~5 `.expected/diff.patch` files (update version strings)
  - 1 file in `package-examples/guestbook/Kptfile`
  - 1 file in `pkg/lib/kptops/fs_test.go` (Go test with embedded Kptfile)

### Phase 2: set-labels
- **Why second**: Second most used (85 occurrences)
- **Similar scope** to set-namespace

### Phase 3: set-annotations
- **Why third**: Less used (3 occurrences), simpler
- **Quick win**

### Phase 4: drop-comments, foo, bar
- **Why last**: Test utilities, minimal usage
- **Low priority**

### Phase 5: wasm/set-namespace (SPECIAL CASE)
- **Note**: This is a WASM version, may need different handling
- **File**: `e2e/testdata/fn-eval/wasm-function/`
- **Decision needed**: Should WASM functions also use `:latest`?

## Detailed Plan for Phase 1 (set-namespace)

### Step 1: Update Kptfile configurations
Replace all instances of:
```yaml
- image: ghcr.io/kptdev/krm-functions-catalog/set-namespace:v0.2.0
```
With:
```yaml
- image: ghcr.io/kptdev/krm-functions-catalog/set-namespace:latest
```

Also update:
```yaml
- image: set-namespace:v0.2.0  # Short form
```
To:
```yaml
- image: set-namespace:latest
```

### Step 2: Run tests to generate new expected outputs
```bash
cd e2e
go test -v -run TestFnRender
go test -v -run TestFnEval
```

### Step 3: Identify breaking changes
- Compare test failures
- Document any API changes
- Update test expectations if needed
- Fix any legitimate test issues

### Step 4: Update expected output files
The test framework should auto-generate new expected outputs, but we need to verify:
- `.expected/config.yaml` - stderr/stdout with new version strings
- `.expected/results.yaml` - function results with new versions
- `.expected/diff.patch` - diffs with new version strings

### Step 5: Verify all tests pass
```bash
go test ./e2e/... -v
```

### Step 6: Create PR
- Title: "test: Update set-namespace E2E tests to use :latest version"
- Description: Document any breaking changes found
- Link to issue #4297

## Potential Challenges

1. **Breaking changes in latest versions**
   - Function behavior may have changed
   - Output format may be different
   - Need to document and fix test expectations

2. **Test framework expectations**
   - Some tests may have hardcoded version checks
   - Need to update version-specific assertions

3. **WASM functions**
   - May need separate handling
   - Check if `:latest` tag exists for WASM variants

4. **Archived tests**
   - Skip `krm-functions-catalog/archived/` tests
   - These are legacy and not actively maintained

## Success Criteria

- ✅ All set-namespace references use `:latest`
- ✅ All E2E tests pass
- ✅ Breaking changes documented (if any)
- ✅ PR approved and merged
- ✅ Repeat for other functions

## Estimated Effort

- **Phase 1 (set-namespace)**: 2-3 hours
  - 30 min: Update Kptfiles
  - 1 hour: Run tests and identify issues
  - 1 hour: Fix test expectations
  - 30 min: Create PR and documentation

- **Phase 2 (set-labels)**: 2 hours (similar to Phase 1)
- **Phase 3 (set-annotations)**: 30 min (only 3 files)
- **Phase 4 (others)**: 1 hour total

**Total**: ~6 hours across multiple PRs

## Next Steps

1. Post reply to issue #4297 with this plan
2. Start with Phase 1: set-namespace
3. Create branch: `test/e2e-set-namespace-latest`
4. Update all set-namespace references
5. Run tests and fix issues
6. Create PR
7. Repeat for other functions
