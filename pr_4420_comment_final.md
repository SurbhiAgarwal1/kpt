Hi @liamfallon, I see the issue now. The tests are failing because:

1. The config files specify `set-namespace:latest`
2. But `internal/kptops/functions.go` maps this to a compiled-in version  
3. The actual output from the function doesn't match the expected output in the `.expected/diff.patch` files

The test log shows the function is adding `namespace: dev` to resources, but the expected diff files don't include this change.

Should I:
1. Update all the `.expected/diff.patch` files to match the new output from `:latest`?
2. Or use a specific pinned version instead of `:latest`?

I need guidance on how to regenerate the expected output files correctly, especially since I'm on Windows and can't easily run `KPT_E2E_UPDATE_EXPECTED=true make test-fn-eval`.
