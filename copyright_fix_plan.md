# Copyright Header Fix Plan - krm-functions-catalog

## Summary
- Total Go files in functions/go: 108
- Files with Google LLC headers: 16
- Files missing headers: 61
- Files with correct headers: 0
- Generated files (skip): 31

**Total files to fix: 77**

## Files with Google LLC Headers (16 files)

Need to replace "Copyright YYYY Google LLC" with "Copyright YYYY The kpt Authors"

1. functions/go/apply-replacements/run.go
2. functions/go/apply-replacements/run_js.go
3. functions/go/gatekeeper/main.go
4. functions/go/gatekeeper/validate.go
5. functions/go/render-helm-chart/main.go
6. functions/go/render-helm-chart/helmfn/helmchartprocessor.go
7. functions/go/set-labels/main.go
8. functions/go/set-labels/run.go
9. functions/go/set-labels/run_js.go
10. functions/go/set-namespace/main.go
11. functions/go/set-namespace/run.go
12. functions/go/set-namespace/run_js.go
13. functions/go/set-namespace/transformer/consts.go
14. functions/go/set-namespace/transformer/namespace.go
15. functions/go/starlark/run.go
16. functions/go/starlark/run_js.go

## Files Missing Headers (61 files - showing first 30)

Need to add full copyright header at the top

1. functions/go/apply-replacements/main.go
2. functions/go/apply-replacements/replacements/replacements.go
3. functions/go/apply-setters/main.go
4. functions/go/apply-setters/applysetters/apply_setters.go
5. functions/go/apply-setters/applysetters/apply_setters_test.go
6. functions/go/apply-setters/applysetters/walk.go
7. functions/go/create-setters/main.go
8. functions/go/create-setters/createsetters/create_setters.go
9. functions/go/create-setters/createsetters/create_setters_test.go
10. functions/go/create-setters/createsetters/walk.go
11. functions/go/ensure-name-substring/ensure_name_substring.go
12. functions/go/ensure-name-substring/ensure_name_substring_test.go
13. functions/go/ensure-name-substring/main.go
14. functions/go/gatekeeper/validate_test.go
15. functions/go/generate-kpt-pkg-docs/main.go
16. functions/go/generate-kpt-pkg-docs/docs/generate.go
17. functions/go/generate-kpt-pkg-docs/docs/generate_test.go
18. functions/go/generate-kpt-pkg-docs/docs/insert.go
19. functions/go/generate-kpt-pkg-docs/docs/insert_test.go
20. functions/go/generate-kpt-pkg-docs/docs/markdown.go
21. functions/go/kubeconform/main.go
22. functions/go/kubeconform/kubeconform/kubeconform.go
23. functions/go/list-setters/main.go
24. functions/go/list-setters/listsetters/list_setters.go
25. functions/go/list-setters/listsetters/list_setters_test.go
26. functions/go/remove-local-config-resources/main.go
27. functions/go/render-helm-chart/helmfn/helmchartprocessor_test.go
28. functions/go/search-replace/main.go
29. functions/go/search-replace/searchreplace/search_replace.go
30. functions/go/search-replace/searchreplace/search_replace_test.go
... (31 more files)

## Standard Header to Use

```go
// Copyright 2026 The kpt Authors
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

## Implementation Steps

1. Create a branch: `fix/copyright-headers-krm-catalog`
2. Fix Google LLC headers (16 files) - replace with kpt Authors
3. Add missing headers (61 files) - add full header
4. Test compilation: `cd functions/go && go build ./...`
5. Commit with message: "docs: Standardize copyright headers in krm-functions-catalog"
6. Push and create PR

## Notes

- Skip files with "// Code generated" comment
- Use year 2026 for new headers (current year)
- Keep original year for Google LLC files (2021-2022)
- Remove "Modifications Copyright (C) 2025 OpenInfra Foundation Europe" lines

