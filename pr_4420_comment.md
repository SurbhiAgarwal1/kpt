Hi @liamfallon, the tests are failing because the expected output files don't match the actual output from set-namespace:latest. 

I'm on Windows and having trouble running the E2E tests locally with `KPT_E2E_UPDATE_EXPECTED=true` to regenerate the expected files (the tests require Unix commands like `cp` and `which`).

Could you help me with one of these approaches:
1. Run the tests locally with the update flag and share the updated expected files
2. Guide me on setting up a proper Linux environment to run the tests
3. Let me know if there's a Windows-compatible way to update the expected files

I want to make sure the expected files are updated correctly to match the :latest output.
