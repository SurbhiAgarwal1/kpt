Hi @efiacor,

I've completed the work to update the E2E tests for set-namespace:latest. Here's what I did:

1. Updated `internal/kptops/functions.go` to use `:latest` instead of `v0.4.5`
2. Ran `KPT_E2E_UPDATE_EXPECTED=true make test-fn-render` to regenerate expected outputs
3. Ran `KPT_E2E_UPDATE_EXPECTED=true make test-fn-eval` to regenerate expected outputs
4. Committed all changes to branch `test/e2e-set-namespace-v0.4.5-final` on my fork

The commits are:
- `fcc8ccae8` - test: Update set-namespace E2E tests to use :latest
- `200e0f6f3` - Update expected test outputs for set-namespace:latest (1032 files)
- `c770085a9` - Add new expected diff.patch files for fn-eval tests (4 files)

However, I'm not sure how to update this PR with my changes. The PR seems to be from a branch on the main kptdev/kpt repository, but I've pushed my commits to my fork at https://github.com/SurbhiAgarwal1/kpt/tree/test/e2e-set-namespace-v0.4.5-final

Could you guide me on the next steps? Should I:
1. Create a new PR from my fork's branch?
2. Or is there a way to update this existing PR?

Note: During testing, 2 unrelated tests failed (image-pull-policy tests), but all set-namespace tests passed with the updated expected files.
