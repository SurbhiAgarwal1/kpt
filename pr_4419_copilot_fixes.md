Hey, addressed all the Copilot review comments:

- **js.Func GC issue**: stored `processResourceListFunc` and `processResourceListErrorsFunc` as package-level variables so they're kept alive for the program lifetime and won't be garbage collected
- **Missing `--allow-exec`**: added the flag to all three `fn eval --exec` examples (local WASM files section, Test locally section, and Complete example section)
- **gofmt formatting**: fixed indentation in both Go snippets to use tabs instead of spaces
- **DCO**: rebased all commits with `--signoff` to fix the missing sign-off on the Copilot autofix commit

Should be good to go now!
