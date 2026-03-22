# CI Failure Analysis: test-docker (podman)

## A. What This Current Log Actually Proves

The visible output shows:
- ✅ All unit tests passed (coverage reports for multiple packages)
- ❌ `make test-docker` exited with code 1
- ❌ GitHub Actions wrapper exited with code 2

**Critical insight:** The failure is NOT in the unit tests shown. The actual failure happened in docker-tagged tests that ran BEFORE these coverage reports, but the output was truncated or scrolled past.

## B. Most Likely Root Causes (Ranked)

### 1. **E2E test assertion failure with :latest tag** (90% probability)
- Your PR changes `set-namespace:v0.4.5` → `set-namespace:latest`
- Expected output files still reference old version output
- Tests compare actual vs expected and fail on mismatch

### 2. **Image pull/resolution issue with :latest** (5% probability)
- Podman may resolve `:latest` differently than Docker
- Network timeout pulling latest image
- Image doesn't exist or is corrupted

### 3. **Docker vs Podman behavior difference** (3% probability)
- Podman CLI compatibility issue
- Different default image pull policies

### 4. **Unrelated flaky CI issue** (2% probability)
- Less likely given your PR specifically changes set-namespace versions

## C. Exact Things to Search in Earlier Logs

Search for these patterns **in order** (scroll UP from the visible output):

1. **`FAIL`** - Find the first occurrence
2. **`--- FAIL: Test`** - Identifies exact failing test name
3. **`set-namespace`** - Your PR's focus area
4. **`expected`** vs **`actual`** or **`got`** vs **`want`**
5. **`Error:`** or **`error:`** - First error message
6. **`github.com/kptdev/kpt/e2e`** - E2E test package failures
7. **`TestFnRender`** or **`TestFnEval`** - Specific test functions

**Critical:** The log you pasted is the END. Scroll UP to find where tests actually failed.

## D. Commands to Run Locally

### Option 1: Run specific E2E tests (if you have Docker/Podman)

```bash
# Build kpt first
make build

# Run all docker-tagged tests (reproduces CI exactly)
make test-docker

# Run specific fn-render tests
make test-fn-render T="set-namespace"

# Run with verbose output to see failures
PATH="$(GOBIN):$(PATH)" go test -v --tags=docker --run=TestFnRender ./e2e/

# Run specific test case
PATH="$(GOBIN):$(PATH)" go test -v --tags=docker --run=TestFnRender/testdata/fn-render/short-image-path ./e2e/
```

### Option 2: Check what changed

```bash
# See what files reference set-namespace versions
git diff origin/main -- e2e/testdata/

# Check internal/kptops/functions.go
git diff origin/main -- internal/kptops/functions.go
```

## E. What Log Block You Should Paste Next

**Scroll UP in the CI logs and find the section that contains:**

```
=== RUN   TestFnRender
=== RUN   TestFnRender/testdata/fn-render/...
--- FAIL: TestFnRender/testdata/fn-render/... (X.XXs)
```

**Paste approximately 50-100 lines** that include:
- The first `FAIL` message
- The test name that failed
- Any error messages about "expected" vs "actual"
- Any messages about set-namespace
- The context around the failure

**Look for patterns like:**
```
expected: set-namespace:v0.4.5
got: set-namespace:latest
```

or

```
failed to pull image: set-namespace:latest
```

## F. Likely Fix Directions

### If it's assertion mismatch (most likely):

**Problem:** Expected output files still reference old version strings

**Fix:**
1. Update all `.expected/` files that reference `set-namespace:v0.4.5` to use `:latest`
2. OR run tests locally with `KPT_E2E_UPDATE_EXPECTED=true` to regenerate expected files
3. Commit the updated expected files

**Files to check:**
```bash
grep -r "set-namespace:v0.4" e2e/testdata/
```

### If it's image pull issue:

**Problem:** `:latest` tag doesn't exist or can't be pulled

**Fix:**
1. Verify the image exists: `docker pull ghcr.io/kptdev/krm-functions-catalog/set-namespace:latest`
2. Check if CI has network/registry access issues
3. Consider using a specific version tag instead of `:latest`

### If it's Docker vs Podman:

**Problem:** Podman handles `:latest` differently

**Fix:**
1. Check if test needs Podman-specific configuration
2. Add explicit image pull before test
3. Pin to specific version instead of `:latest`

## G. Immediate Next Steps

1. **Scroll UP in the GitHub Actions log** to find the actual failure
2. **Paste the failure block** (50-100 lines around first FAIL)
3. I'll identify:
   - Exact failing test name
   - Exact file causing the issue
   - Exact fix needed

**Don't paste more unit test coverage reports - we need the FAIL section!**
