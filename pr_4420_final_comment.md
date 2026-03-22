Hi @efiacor,

I've finished updating the E2E tests for `set-namespace:latest`. Everything passes when I run tests locally in WSL, but the CI keeps failing and I'm not sure why.

Here's what I did:

1. Changed `internal/kptops/functions.go` to use `:latest` instead of `v0.4.5`

2. Set up WSL on my Windows machine, installed make and go, built kpt from source

3. Ran the tests with `KPT_E2E_UPDATE_EXPECTED=true`:
   - `make test-fn-render` - regenerated a ton of expected output files
   - `make test-fn-eval` - updated more expected files
   
   I spent some time understanding how the `.expected` directories work - basically when we change the function version, all those expected outputs need to match what the new version produces. The `KPT_E2E_UPDATE_EXPECTED` flag regenerates these golden files by running the actual functions and capturing their output.

4. Locally, all the set-namespace tests pass. Only 2 image-pull-policy tests fail, but those seem unrelated to my changes.

The CI failures I've been chasing:
- File mode issues (100755 vs 100644 in diff.patch files) - turns out git was embedding executable permissions in the diff headers, fixed 59 files
- Line ending problems (bash\r errors) - Windows was converting LF to CRLF, added .gitattributes to force LF for shell scripts
- Merge conflicts with upstream/main - resolved those

But tests are still failing in CI even though they work fine on my machine. I'm guessing it's something about the Windows/WSL environment vs the CI environment, but I'm not sure what else to try.

Also, I noticed Copilot flagged something interesting - the golden assertions now depend on exact message text from `set-namespace:latest`. Since `:latest` can change message wording anytime, this might cause frequent test failures unrelated to actual functionality. Should we consider relaxing the assertions to check only exitCode/severity instead of exact message text? Or is there a better approach?

Since you mentioned tests run fine for you - are these failures actually related to my changes? Or is there something about the CI setup I'm missing?

I really want to get this right and learn the proper workflow. Any guidance would be helpful!

Thanks
