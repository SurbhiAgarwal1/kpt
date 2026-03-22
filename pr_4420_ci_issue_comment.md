Hi @efiacor,

I've completed the work to update the E2E tests for `set-namespace:latest` and all tests are passing locally in my WSL environment. However, I'm running into some CI failures that I need help understanding.

**What I did:**
1. Updated `internal/kptops/functions.go` to use `:latest` instead of `v0.4.5`
2. Set up WSL and built kpt from source using `make build`
3. Ran `KPT_E2E_UPDATE_EXPECTED=true make test-fn-render` - all set-namespace tests passed ✓
4. Ran `KPT_E2E_UPDATE_EXPECTED=true make test-fn-eval` - all set-namespace tests passed ✓
5. Committed and pushed all the regenerated expected output files

**Local test results:**
- All set-namespace related tests pass in my WSL environment
- Only 2 unrelated tests fail (image-pull-policy tests)

**CI issues:**
The CI is failing with errors that I don't see locally:
- File mode differences (100755 vs 100644) - I've tried to fix these
- Line ending issues (CRLF vs LF) - Added .gitattributes to normalize
- KinD tests failing with bash errors

I'm working on a Windows machine and using WSL for testing, which might be causing some environment differences. Since you mentioned the tests run fine on your end, could you help me understand:
1. Are these CI failures related to my set-namespace changes, or are they pre-existing issues?
2. Is there a better way to handle the Windows/Linux environment differences?
3. Should I try a different approach for this PR?

I want to make sure I'm contributing correctly and learning the right workflow for future contributions.
