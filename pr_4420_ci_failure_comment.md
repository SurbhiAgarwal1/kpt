## CI Failure Analysis

I've identified the root cause of the failing CI tests.

### Failing Test
`TestFnRender/testdata/fn-render/subpkg-resource-deletion` (and likely others)

### Error
```
test.go:89: failed when running test: actual diff doesn't match expected
```

### Root Cause
The test is comparing actual output from `set-namespace:latest` against expected output files that were generated with an older version. The outputs don't match, causing the test to fail.

### The Issue
When I changed `internal/kptops/functions.go` to use `:latest`, the E2E tests now run with the latest version, which produces slightly different output than what's stored in the `.expected/` directories.

### Solution Needed
I need to regenerate all expected output files by running:
```bash
KPT_E2E_UPDATE_EXPECTED=true make test-fn-render
```

This will:
1. Run all fn-render E2E tests with `:latest`
2. Capture the actual output
3. Update all `.expected/` directories with the new output

### My Blocker
I'm on Windows and the E2E tests require Unix commands (`cp`, `which`, etc.) that aren't available in PowerShell. I tried running the tests but they fail due to missing Unix utilities.

### Request for Help
@liamfallon Could you help me by either:
1. Running `KPT_E2E_UPDATE_EXPECTED=true make test-fn-render` locally and sharing the updated expected files, or
2. Providing guidance on how to properly set up the test environment on Windows (WSL configuration, etc.)?

I want to make sure all the expected files are correctly updated to match the `:latest` output.

Thank you!
