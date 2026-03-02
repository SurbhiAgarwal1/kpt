Hi @liamfallon,

I'd like to work on this documentation task. I can see that WASM function support exists but needs comprehensive documentation.

## Current State

From my analysis, I found:
- CLI reference docs exist for `kpt alpha wasm push` and `kpt alpha wasm pull`
- WASM functions can be run with `--allow-alpha-wasm` flag
- Support for both OCI images and local `.wasm` files
- No end-to-end guide on developing, testing, or deploying WASM functions

## Proposed Documentation Structure

I can create documentation covering:

1. **Overview**: What are WASM functions and why use them
2. **Running WASM Functions**:
   - Using `kpt fn render --allow-alpha-wasm --image <wasm-image>`
   - Using local `.wasm` files with `--exec`
3. **Developing WASM Functions**:
   - Setting up a WASM build environment
   - Building KRM functions for wasm/js platform
   - Testing locally
4. **Publishing WASM Functions**:
   - Using `kpt alpha wasm push` to publish to OCI registry
   - Using `kpt alpha wasm pull` to fetch modules
5. **Examples**: Complete workflow from development to deployment

## Questions

1. Should this be a new guide under `/book/04-using-functions/` or a separate WASM guide?
2. Are there specific WASM function examples in the catalog I should reference?
3. Should I include information about the krm-functions-catalog#898 work?

Let me know if this approach works and I'll get started!
