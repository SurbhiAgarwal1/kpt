# Issue #4297 Implementation Plan

## Summary
Update E2E tests to use `:latest` versions of KRM functions instead of pinned old versions. This will help catch breaking changes early and ensure tests work with current function versions.

## Key Findings from Analysis

### Test Framework Understanding
- Tests are in `e2e/testdata/fn-eval/` and `e2e/testdata/fn-render/`
- Each test case has:
  - `resources.yaml` - Input Kubernetes resources
  - `.expected/config.yaml` - Expected test configuration (includes image version)
  - `.expected/diff.patch` - Expected changes to resources
- Test framework compares actual output with expected output
- Tests run with: `go test ./e2e/... -v -tags docker`

### Functions to Update (Priority Order)

1. **set-namespace** - 91 occurrences (v0.2.0 → latest)
2. **set-labels** - 85 occurrences (v0.1.5 → latest)  
3. **set-annotations** - 3 occurrences (v0.1.4 → latest)
4. **drop-comments** - 2 occurrences (v0.1 → latest)
5. **foo, bar** - 1 each (v0.1 → latest) - test utilities
6. **wasm/set-namespace** - 1 occurrence (v0.5.0 → ?) - needs investigation

### Files That Need Updates

For each function version change, we need to update:

1. **Kptfile** - Pipeline configuration with function image
2. **.expected/config.yaml** - Expected test config (has image version)
3. **.expected/diff.patch** - May contain version strings (rare)
4. **Go test files** - Some have embedded Kptfiles (e.g., `pkg/lib/kptops/fs_test.go`)

## Phase 1: set-namespace (START HERE)

### Step-by-Step Implementation

#### 1. Create branch
```bash
git checkout main
git pull upstream main
git checkout -b test/e2e-set-namespace-latest
```

#### 2. Find all files to update
```bash
# Find all Kptfiles with set-namespace:v0.2.0
grep -r "set-namespace:v0.2.0" e2e/testdata/ --include="Kptfile"

# Find all expected configs
grep -r "set-namespace:v0.2.0" e2e/testdata/ --include="*.yaml"

# Find Go test files
grep -r "set-namespace:v0.2.0" pkg/ --include="*_test.go"

# Find package examples
grep -r "set-namespace:v0.4" package-examples/
```

#### 3. Update all references using find/replace

**Pattern 1: Full image path**
```yaml
# OLD
- image: ghcr.io/kptdev/krm-functions-catalog/set-namespace:v0.2.0

# NEW
- image: ghcr.io/kptdev/krm-functions-catalog/set-namespace:latest
```

**Pattern 2: Short image path**
```yaml
# OLD
image: set-namespace:v0.2.0

# NEW
image: set-namespace:latest
```

**Pattern 3: In expected output strings**
```yaml
# OLD
stdErr: |
  [RUNNING] "ghcr.io/kptdev/krm-functions-catalog/set-namespace:v0.2.0"
  [PASS] "ghcr.io/kptdev/krm-functions-catalog/set-namespace:v0.2.0" in 0s

# NEW
stdErr: |
  [RUNNING] "ghcr.io/kptdev/krm-functions-catalog/set-namespace:latest"
  [PASS] "ghcr.io/kptdev/krm-functions-catalog/set-namespace:latest" in 0s
```

**Pattern 4: In results.yaml**
```yaml
# OLD
- image: ghcr.io/kptdev/krm-functions-catalog/set-namespace:v0.2.0

# NEW
- image: ghcr.io/kptdev/krm-functions-catalog/set-namespace:latest
```

#### 4. Run tests to identify issues
```bash
cd e2e
go test -v -tags docker -run TestFnEval 2>&1 | tee test-output.log
go test -v -tags docker -run TestFnRender 2>&1 | tee -a test-output.log
```

#### 5. Analyze failures

**Possible failure types:**

a) **Version string mismatch in expected output**
   - Expected: `set-namespace:v0.2.0`
   - Actual: `set-namespace:latest`
   - Fix: Update `.expected/config.yaml` files

b) **Different function behavior (breaking change)**
   - Function output changed
   - Fix: Update `.expected/diff.patch` or test expectations
   - Document the breaking change

c) **Function not found / image pull error**
   - `:latest` tag doesn't exist
   - Fix: Use specific newer version or investigate

d) **Test framework issues**
   - Hardcoded version checks
   - Fix: Update test code

#### 6. Fix test expectations

For each failing test:
1. Check actual vs expected output
2. If output is correct but different, update `.expected/` files
3. If function behavior changed, document it
4. Re-run test to verify fix

#### 7. Verify all tests pass
```bash
# Run full E2E test suite
go test ./e2e/... -v -tags docker

# Run specific tests if needed
go test ./e2e/... -v -tags docker -run "TestFnEval/simple-function"
```

#### 8. Check for other affected files
```bash
# Check if any other tests reference set-namespace
grep -r "set-namespace" . --include="*.go" --include="*.yaml" --include="Kptfile" | grep -v ".git" | grep -v "e2e/testdata"
```

#### 9. Create commit
```bash
git add .
git commit -s -m "test: Update set-namespace E2E tests to use :latest version

Updates all E2E tests to use set-namespace:latest instead of pinned
versions (v0.2.0, v0.4.1). This ensures tests catch breaking changes
early and work with current function versions.

Changes:
- Updated ~40 Kptfile configurations in fn-render tests
- Updated ~30 Kptfile configurations in fn-eval tests  
- Updated ~70 .expected/config.yaml files with new version strings
- Updated ~10 .expected/results.yaml files
- Updated 1 package example
- Updated 1 Go test file with embedded Kptfile

Breaking changes found: [NONE/LIST THEM]

Fixes #4297"
```

#### 10. Push and create PR
```bash
git push origin test/e2e-set-namespace-latest
```

Then create PR on GitHub with:
- Title: `test: Update set-namespace E2E tests to use :latest version`
- Link to issue #4297
- Mention @liamfallon for review
- Document any breaking changes found

### Expected Files to Modify (~150 files)

**Kptfiles** (~70 files):
- e2e/testdata/fn-render/*/Kptfile
- e2e/testdata/fn-eval/*/Kptfile
- package-examples/guestbook/Kptfile

**Expected configs** (~70 files):
- e2e/testdata/fn-render/*/.expected/config.yaml
- e2e/testdata/fn-eval/*/.expected/config.yaml

**Expected results** (~10 files):
- e2e/testdata/fn-render/*/.expected/results.yaml
- e2e/testdata/fn-eval/*/.expected/results.yaml

**Go tests** (~1 file):
- pkg/lib/kptops/fs_test.go

**Diff patches** (~5 files):
- e2e/testdata/fn-render/*/.expected/diff.patch (if they contain version strings)

## Phase 2-5: Other Functions

Repeat the same process for:
- Phase 2: set-labels (85 files)
- Phase 3: set-annotations (3 files)
- Phase 4: drop-comments, foo, bar (4 files)
- Phase 5: wasm/set-namespace (investigate first)

## Automation Opportunity

We could create a script to automate the find/replace:

```bash
#!/bin/bash
# update-function-version.sh

FUNCTION=$1  # e.g., "set-namespace"
OLD_VERSION=$2  # e.g., "v0.2.0"
NEW_VERSION=$3  # e.g., "latest"

# Update Kptfiles
find e2e/testdata -name "Kptfile" -exec sed -i "s|${FUNCTION}:${OLD_VERSION}|${FUNCTION}:${NEW_VERSION}|g" {} +

# Update expected configs
find e2e/testdata -name "*.yaml" -exec sed -i "s|${FUNCTION}:${OLD_VERSION}|${FUNCTION}:${NEW_VERSION}|g" {} +

# Update package examples
find package-examples -name "Kptfile" -exec sed -i "s|${FUNCTION}:${OLD_VERSION}|${FUNCTION}:${NEW_VERSION}|g" {} +

echo "Updated ${FUNCTION} from ${OLD_VERSION} to ${NEW_VERSION}"
```

## Risk Mitigation

1. **Test incrementally** - Update one function at a time
2. **Document breaking changes** - Keep track of any behavior changes
3. **Separate PRs** - Easier to review and revert if needed
4. **Run full test suite** - Ensure no regressions
5. **Ask for help** - Tag @liamfallon if stuck

## Success Metrics

- ✅ All E2E tests pass with `:latest` versions
- ✅ Breaking changes documented (if any)
- ✅ PRs merged for all functions
- ✅ Future tests will catch breaking changes early

## Timeline Estimate

- Phase 1 (set-namespace): 2-3 hours
- Phase 2 (set-labels): 2 hours
- Phase 3 (set-annotations): 30 min
- Phase 4 (others): 1 hour
- **Total**: ~6 hours across multiple PRs over 1-2 weeks

## Next Action

Start with Phase 1: set-namespace
1. Post reply to issue #4297
2. Create branch
3. Update files
4. Run tests
5. Fix issues
6. Create PR
