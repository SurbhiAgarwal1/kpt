@liamfallon I've investigated the CI failures and found something important:

**The `:latest` tag for `set-namespace` is pointing to `v0.2.0`, not `v0.4.5` or newer.**

### Evidence from Docker CI

Multiple tests are failing with this pattern:
```
wanted: "set-namespace:v0.4.5"
got:    "set-namespace:v0.2.0"
```

### Failing Tests
- `TestFnEval/testdata/fn-eval/save-fn/image`
- `TestFnEval/testdata/fn-eval/preserve-order-null-values`
- `TestFnEval/testdata/fn-eval/out-of-place-dir`
- `TestFnEval/testdata/fn-eval/out-of-place-fnchain-stdout`
- `TestFnEval/testdata/fn-eval/missing-fn-config` (behavior difference - v0.2.0 doesn't fail when config is missing, but v0.4.5 does)

### The Problem

When I changed `internal/kptops/functions.go` to use `:latest`, the tests now run with v0.2.0 (what `:latest` points to), but:
1. v0.2.0 is OLDER than v0.4.5
2. v0.2.0 has different behavior than v0.4.5
3. All expected test outputs are based on v0.4.5 behavior
4. Tests fail because actual (v0.2.0) ≠ expected (v0.4.5)

### Your Earlier Comment

You mentioned that "KRM function caching hard codes KRM function versions so we will probably refactor that soon. Frankly its very confusing at the moment."

This is exactly why - the `:latest` tag doesn't actually point to the latest version!

### Questions

1. Should I revert to using `v0.4.5` instead of `:latest`?
2. Is there a specific version tag I should use?
3. Should the `:latest` tag in the container registry be updated to point to the actual latest version?

What would you like me to do here?
