Thanks @nagygergo and @efiacor for the detailed review! I see the PR got messy with mixed changes. Let me clean this up:

## Will Fix:

1. **Remove all unrelated files** - pkg init docs, test output files, temp files
2. **Remove CEL_CONDITIONS.md** - will add proper documentation instead
3. **Fix CEL cost checking** - will research how k8s does it and implement properly
4. **Remove unused functions** - FilterResources() and ResourceExists()
5. **Fix RNode conversion** - will use rnode.Map() or rnode.datamap
6. **Add proper E2E test and documentation**

The PR accidentally included changes from #1835 (pkg init). I'll revert those and keep only CEL-related changes.

Should I clean up this PR or create a fresh one from a clean branch?
