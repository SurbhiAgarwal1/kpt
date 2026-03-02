Hi @liamfallon,

Thanks for the detailed explanation! That makes perfect sense - using `:latest` is the right approach since we want tests to catch breaking changes early.

I've done a deep analysis of the codebase. There are **107 E2E test cases** total (49 fn-eval + 58 fn-render), and here's what I found:

## Current State

| Function | Version | Occurrences |
|----------|---------|-------------|
| set-namespace | v0.2.0 | 91 |
| set-namespace | v0.4.1 | 1 |
| set-labels | v0.1.5 | 85 |
| set-annotations | v0.1.4 | 3 |
| drop-comments | v0.1 | 2 |
| foo, bar | v0.1 | 1 each |

## My Plan

I'll start with `set-namespace` since it's the most widely used. For this function alone, I'll need to update:
- ~70 Kptfile configurations (in fn-render and fn-eval tests)
- ~70 `.expected/config.yaml` files (version strings in stderr/stdout)
- ~10 `.expected/results.yaml` files
- 1 package example
- 1 Go test file with embedded Kptfile

**Approach:**
1. Update all `set-namespace:v0.2.0` → `set-namespace:latest`
2. Run E2E tests: `go test ./e2e/... -v -tags docker`
3. Identify any breaking changes or test failures
4. Fix test expectations if needed
5. Document any breaking changes found
6. Submit PR for review

Then I'll repeat the same process for `set-labels`, `set-annotations`, and the others in separate PRs.

**Estimated effort:** ~2-3 hours per function (mostly running tests and fixing expectations)

Starting work on `set-namespace` now. I'll create a PR once tests pass!
