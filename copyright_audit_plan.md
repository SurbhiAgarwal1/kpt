# Copyright Header Audit - krm-functions-catalog

## What the mentor wants:
- Keep original years from git history
- kpt headers only (no Nephio, no Google LLC)
- Fix everything - Go, YAML, Markdown, scripts

## Standard format:
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

## What I found so far:
- Lots of "Copyright Google LLC" that needs changing
- Some files missing headers completely
- Some auto-generated files (docs.go with "DO NOT EDIT")

## Plan:

1. Count all files by type (.go, .yaml, .md, .sh)
2. Check each file:
   - Has correct kpt header? Leave it
   - Has Google LLC? Replace with kpt
   - Missing header? Add one with correct year from git
   - Auto-generated? Skip it
3. Get years from git log for each file
4. Test on a few files first
5. Apply to everything
6. Make sure nothing breaks
7. Commit and PR

## Don't touch:
- Generated files
- Vendor stuff
- Third-party code

## Next: 
Run full audit to see exactly what we're dealing with.
