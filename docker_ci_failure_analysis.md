# Docker CI Failure Analysis - CRITICAL FINDING

## The Real Problem

The tests are expecting `v0.4.5` but getting `v0.2.0` instead!

### Key Evidence

**Test: `TestFnEval/testdata/fn-eval/save-fn/image`**
```
wanted: "set-namespace:v0.4.5"
got:    "set-namespace:v0.2.0"
```

**Test: `TestFnEval/testdata/fn-eval/preserve-order-null-values`**
```
wanted: "set-namespace:v0.4.5"
got:    "set-namespace:v0.2.0"
```

**Test: `TestFnEval/testdata/fn-eval/out-of-place-dir`**
```
wanted: "set-namespace:v0.4.5"
got:    "set-namespace:v0.2.0"
```

## Root Cause Identified

You changed `internal/kptops/functions.go` to use `:latest`, but:

**The `:latest` tag is actually pointing to `v0.2.0`, NOT `v0.4.5`!**

This means:
1. ✅ You updated the code to use `:latest`
2. ❌ The `:latest` tag in the registry points to an OLD version (v0.2.0)
3. ❌ Tests expect v0.4.5 output
4. ❌ Tests get v0.2.0 output
5. ❌ Tests fail

## Why This Is Happening

The `ghcr.io/kptdev/krm-functions-catalog/set-namespace:latest` tag is pointing to v0.2.0, which is OLDER than v0.4.5.

This is a problem with the container registry tagging, not your code!

## The Maintainer's Concern

Remember what @liamfallon said:
> "KRM function caching hard codes KRM function versions so we will probably refactor that soon. Frankly its very confusing at the moment."

**This is exactly why!** The `:latest` tag doesn't actually point to the latest version.

## Additional Issue

**Test: `TestFnEval/testdata/fn-eval/missing-fn-config`**
```
failed when running test: actual exit code 0 doesn't match expected 1
```

This test expects the function to FAIL (exit code 1) when config is missing, but with v0.2.0 it succeeds (exit code 0). This suggests v0.2.0 has different behavior than v0.4.5.

## What This Means

Using `:latest` is problematic because:
1. `:latest` points to v0.2.0 (old version)
2. v0.2.0 has different behavior than v0.4.5
3. Tests were written for v0.4.5 behavior
4. Everything breaks

## The Fix Options

### Option 1: Don't use `:latest` (RECOMMENDED)
Keep using `v0.4.5` or use a specific newer version tag. The `:latest` tag is unreliable.

### Option 2: Fix the `:latest` tag in the registry
Someone needs to update the container registry so `:latest` points to the actual latest version (v0.4.5 or newer).

### Option 3: Update all tests for v0.2.0 behavior
Regenerate all expected files with v0.2.0 output, but this is going BACKWARDS in versions.

## Recommendation

**You should NOT use `:latest` for this function.** 

The maintainer's comment about refactoring suggests they know the versioning is messy. Using `:latest` makes it worse because it points to an old version.

**Suggested approach:**
1. Revert to using `v0.4.5` (or find the actual latest version tag)
2. Comment on the PR explaining what you found
3. Ask the maintainer what version they want to use

## Comment to Post

```markdown
@liamfallon I've investigated the CI failures and found something important:

The `:latest` tag for `set-namespace` is pointing to `v0.2.0`, not `v0.4.5` or newer. This causes multiple test failures:

**Evidence from Docker CI:**
```
wanted: "set-namespace:v0.4.5"
got:    "set-namespace:v0.2.0"
```

**Tests failing:**
- `TestFnEval/testdata/fn-eval/save-fn/image`
- `TestFnEval/testdata/fn-eval/preserve-order-null-values`
- `TestFnEval/testdata/fn-eval/out-of-place-dir`
- `TestFnEval/testdata/fn-eval/missing-fn-config` (behavior difference)

**The issue:** v0.2.0 has different behavior than v0.4.5 (e.g., different error handling for missing configs).

Given your earlier comment about KRM function versioning being "very confusing," I think using `:latest` might not be the right approach here since it points to an older version.

**Questions:**
1. Should I revert to `v0.4.5`?
2. Is there a specific version tag I should use instead of `:latest`?
3. Should the `:latest` tag in the registry be updated to point to v0.4.5 or newer?

What would you like me to do?
```
