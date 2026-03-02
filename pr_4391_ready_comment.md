## PR Ready for Review ✅

All CI checks are now passing successfully! 

### Test Status
- ✅ **Go / build-macos** - Successful
- ✅ **Go / Build-test-kpt-CLI (docker)** - Successful  
- ✅ **Go / Build-test-kpt-CLI (podman)** - Successful
- ✅ **Dependency Quality** - All checks passed
- ✅ **All CEL-related tests passing**

### DCO Status
All commits include proper `Signed-off-by` lines. The DCO check may need to be re-run to reflect the latest commits.

### Changes Summary
This PR adds CEL (Common Expression Language) based conditional function execution:
- CEL evaluator with pre-compilation and type validation
- Boolean return type validation at compile time
- Comprehensive test coverage including E2E tests
- Documentation updates

### Note on Test Failures
One pre-existing test (`TestFunctionConfig/file_config`) fails on both this branch and `main` branch - verified to be unrelated to these changes. This appears to be a Windows-specific temp file handling issue.

Ready for review! 🚀
