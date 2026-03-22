Thanks @liamfallon! I've updated `internal/kptops/functions.go` to use `:latest`.

I'm on Windows and having trouble running the E2E tests with `KPT_E2E_UPDATE_EXPECTED=true` to regenerate the expected output files. The tests require Unix commands and Docker.

Could you help me with one of these:
1. Run the tests locally with the update flag and share the updated expected files
2. Guide me on the best way to set up the test environment on Windows (WSL, Docker Desktop, etc.)

I want to make sure the expected files match the `:latest` output correctly.
