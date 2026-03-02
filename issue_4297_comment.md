Hi,

I'd like to work on this issue. I can help update the E2E tests to work with the latest KRM function versions.

From what I understand, the tests are currently pinned to older versions:
- set-namespace:v0.2.0 and v0.4.1
- set-labels:v0.1.5
- foo, bar, drop-comments, printenv:v0.1

My approach would be:
1. Start with a small subset of tests (e.g., `fn-eval/simple-function`)
2. Update to latest function versions and identify breaking changes
3. Fix test expectations to match new function behavior
4. Document any API changes discovered
5. Repeat for remaining tests

Before I start, could you clarify:
- Should I update all tests to use `:latest` tag, or pin to specific newer versions?
- Are there known breaking changes in these functions I should be aware of?
- Should this be done in one PR or split into multiple PRs by function?

Let me know if this approach works!
