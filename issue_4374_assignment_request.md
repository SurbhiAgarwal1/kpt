Hey! I'd like to work on this issue. 

I've looked at PR #4352 and understand the fix - basically need to provide an empty ResourceList as stdin when running `kpt fn doc` so functions that always read stdin don't fail on `--help`.

I can implement this by modifying `commands/fn/doc/cmdfndoc.go` to add the stdin flags and provide the empty YAML structure. Will also add tests to cover the affected functions.

Can you assign this to me? Thanks!
