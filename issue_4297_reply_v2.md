Hi @liamfallon,

Thanks for the detailed explanation! That makes sense - using `:latest` is the right approach since we want tests to catch breaking changes early.

I'll start with updating the tests to use `:latest` tags and do multiple PRs by function to make reviews easier. I'll begin with `set-namespace` since it's used in many test cases.

My plan:
1. Update `set-namespace` tests to use `:latest`
2. Run tests and identify any failures
3. Fix test expectations to match new behavior
4. Submit PR for `set-namespace` updates
5. Repeat for other functions (`set-labels`, `foo`, `bar`, etc.)

Starting work on this now!
