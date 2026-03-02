## Description

This PR standardizes copyright headers across the krm-functions-catalog repository to use "The kpt Authors" consistently.

## Changes

- **Updated 16 files** with Google LLC headers to "The kpt Authors" (preserved original years 2019-2022)
- **Removed** "Modifications Copyright (C) 2025 OpenInfra Foundation Europe" lines
- **Added** copyright headers to 61 files that were missing them (using year 2026)
- **Skipped** 31 generated files (files with `// Code generated` comment)

## Files Modified

### Google LLC → The kpt Authors (16 files)
- apply-replacements: run.go, run_js.go
- gatekeeper: main.go, validate.go
- render-helm-chart: main.go, helmfn/helmchartprocessor.go
- set-labels: main.go, run.go, run_js.go
- set-namespace: main.go, run.go, run_js.go, transformer/consts.go, transformer/namespace.go
- starlark: run.go, run_js.go

### Added Headers (61 files)
- apply-replacements, apply-setters, create-setters, ensure-name-substring
- gatekeeper, generate-kpt-pkg-docs, kubeconform, list-setters
- remove-local-config-resources, render-helm-chart, search-replace
- set-annotations, set-enforcement-action, set-image, set-namespace
- sleep, starlark, upsert-resource

## Testing

All changes are header-only modifications. No functional code changes.

Fixes kptdev/kpt#4395
