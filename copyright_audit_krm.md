# Copyright Header Audit - krm-functions-catalog

## Audit Date: February 25, 2026

## Scope
Auditing copyright headers in the krm-functions-catalog repository to identify:
1. Files with incorrect copyright (Google LLC instead of The kpt Authors)
2. Files with missing copyright headers
3. Files with outdated years

## Standard Format (from kpt repo)
```go
// Copyright YYYY The kpt Authors
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
```

## Mentor Requirements
1. Keep original years if possible
2. Use "The kpt Authors" only (not "The kpt and Nephio Authors")
3. Include all file types that need headers

## Files with INCORRECT Headers

### Google LLC Headers (should be "The kpt Authors"):
1. `scripts/patch_reader/main.go` - Copyright 2022 Google LLC
2. `scripts/update_function_docs/function_release.go` - Copyright 2021 Google LLC
3. `scripts/update_function_docs/git.go` - Copyright 2021 Google LLC
4. `scripts/update_function_docs/main.go` - Copyright 2021 Google LLC

### OpenInfra Foundation Headers:
- `scripts/patch_reader/main.go` - Has "Modifications Copyright (C) 2025 OpenInfra Foundation Europe"
- `scripts/update_function_docs/function_release.go` - Has "Modifications Copyright (C) 2025 OpenInfra Foundation Europe"
- `scripts/update_function_docs/git.go` - Has "Modifications Copyright (C) 2025 OpenInfra Foundation Europe"

## Next Steps

1. **Count total Go files** in active functions (excluding archived/)
2. **Check each file** for copyright header
3. **Create list** of files to fix
4. **Submit PR** with fixes

## Questions for Mentor

1. Should we fix archived functions too, or only active ones?
2. What to do with OpenInfra Foundation modifications?
3. Should we update years to 2026 for recently modified files?

