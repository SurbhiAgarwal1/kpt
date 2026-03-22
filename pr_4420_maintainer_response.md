Thanks for clarifying the decision! I ran the test updates with `KPT_E2E_UPDATE_EXPECTED=true` for both test suites.

However, I'm seeing that the current `:latest` version of set-namespace is still adding namespaces to Custom resources that don't have one. For example, in `e2e/testdata/fn-eval/out-of-place-fnchain-stdout/resources.yaml`, the Custom resource has no namespace field, but the expected output shows it getting `namespace: staging` added.

Should I:
1. Update the set-namespace function code first to skip Custom resources without namespace, then regenerate the tests?
2. Or wait for that fix to be made separately?
3. Or is the current behavior (adding namespace to Custom resources) actually what we want?

Just want to make sure I'm on the right track before splitting into separate PRs!
