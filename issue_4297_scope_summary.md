# Issue #4297: Scope Summary

## Total E2E Tests
- **107 total test cases** (from issue description)
  - 49 fn-eval tests
  - 58 fn-render tests

## Tests Affected by set-namespace Update

Based on grep search, approximately **30-40 test directories** use `set-namespace:v0.2.0`, including:

### fn-render tests (~25 test cases):
1. subpkg-resource-deletion (+ db subpkg)
2. subpkgs-with-krmignore (+ db subpkg)
3. success-stdout
4. subpkgs (+ db subpkg)
5. subpkg-has-samename-subdir/pkg-a
6. subpkg-fn-failure (+ db subpkg)
7. subpkg-has-invalid-kptfile (+ db subpkg)
8. selectors/selectors-with-exclude
9. selectors/generator (+ db subpkg)
10. short-image-path
11. selectors/exclude
12. selectors/basicpipeline
13. save-on-render-failure/no-save-on-render-failure
14. save-on-render-failure/dfs-subpkg-validator-fails/subpkg
15. save-on-render-failure/dfs-subpkg-mutator-fails/subpkg
16. save-on-render-failure/dfs-parent-validator-fails/subpkg
17. save-on-render-failure/dfs-parent-mutator-fails/subpkg
18. save-on-render-failure/dfs-basicpipeline
19. save-on-render-failure/bfs-subpkg-validator-fails/subpkg
20. save-on-render-failure/bfs-subpkg-mutator-fails/subpkg
21. save-on-render-failure/bfs-parent-validator-fails/subpkg
22. save-on-render-failure/bfs-parent-mutator-fails/subpkg
23. save-on-render-failure/bfs-basicpipeline
24. resource-deletion
25. preserve-order-null-values
26. out-of-place-unwrap
27. out-of-place-stdout
28. out-of-place-fnchain-unwrap
29. out-of-place-fnchain-stdout-results
30. out-of-place-fnchain-stdout
31. out-of-place-dir-exists-error
32. out-of-place-dir
33. non-krm-resource
34. generator
35. basicpipeline-symlink
36. basicpipeline

### fn-eval tests (~15 test cases):
1. simple-function
2. simple-function-symlink
3. short-image-path
4. selectors/out-of-place-fnchain-unwrap
5. selectors/exclude
6. selectors/basicpipeline
7. save-fn/validator-type
8. save-fn/override-fn
9. subpkgs-with-krmignore
10. subpkgs
11. subpkg-include-meta-resources
12. subpkg-has-samename-subdir
13. subpkg-exclude-fn-config-by-default
14. preserve-order-include-meta-resources
15. out-of-place-fnchain-unwrap
16. out-of-place-dir-exists-error
17. out-of-place-dir
18. non-krm-resource

### Other files:
- package-examples/guestbook/Kptfile
- pkg/lib/kptops/fs_test.go (Go test with embedded Kptfile)

## Files to Update Per Test Case

For each test case, we typically need to update:

1. **Kptfile** (if exists) - The pipeline configuration
2. **.expected/config.yaml** - Expected test output (contains version strings)
3. **.expected/results.yaml** (if exists) - Expected function results
4. **.expected/diff.patch** (if exists) - Expected resource changes

## Estimated File Count

- **Kptfiles**: ~50 files (including subpackages)
- **.expected/config.yaml**: ~40 files
- **.expected/results.yaml**: ~10 files
- **.expected/diff.patch**: ~5 files
- **Other**: 2 files (package example + Go test)

**Total**: ~107 files for set-namespace alone

## Similar Scope for Other Functions

- **set-labels**: Similar scope (~85 occurrences, ~100 files)
- **set-annotations**: Much smaller (~3 occurrences, ~10 files)
- **drop-comments, foo, bar**: Very small (~1-2 each, ~5 files total)

## Implementation Approach

### Phase 1: set-namespace
1. Update all Kptfiles: `v0.2.0` → `latest`
2. Update all .expected files with version strings
3. Run tests: `go test ./e2e/... -v -tags docker`
4. Fix any failures (likely just version string mismatches)
5. Create PR

### Phase 2-4: Other functions
Repeat same process for set-labels, set-annotations, etc.

## Key Insight

Out of 107 total E2E tests:
- **~40 tests** use set-namespace (37% of all tests)
- **~40 tests** use set-labels (37% of all tests)
- **~67 tests** don't use versioned functions (already use :latest or no functions)

This means the work is focused on a specific subset of tests, not all 107.
