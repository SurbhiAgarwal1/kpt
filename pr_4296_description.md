## Description

WASM functions are supported in kpt but there's no documentation on how to run, develop, or deploy them. This PR adds a comprehensive guide covering the complete WASM function workflow.

## Motivation

Users need documentation to understand:
- How to run WASM functions with the `--allow-alpha-wasm` flag
- How to publish WASM modules using `kpt alpha wasm push/pull`
- How to develop WASM functions with proper build tags
- The benefits and limitations of WASM functions vs container-based functions

Without this documentation, users have to dig through code or CLI help to figure out WASM support.

## Changes

Added `documentation/content/en/book/04-using-functions/wasm-functions.md` covering:
- Running WASM functions with `fn render` and `fn eval`
- Publishing and pulling WASM modules to/from OCI registries
- Developing Go-based WASM functions with complete code examples
- Benefits (faster startup, smaller size, better security)
- Limitations (alpha status, sandboxed execution, compatibility)

The code examples are based on actual WASM functions in krm-functions-catalog (set-namespace, set-labels, starlark) and follow the same pattern with separate build tags for regular and WASM builds.

Fixes #4296
