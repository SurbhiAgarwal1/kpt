#!/bin/bash

# Fix Google LLC headers in krm-functions-catalog
cd krm-functions-catalog/functions/go

# Files with Google LLC and OpenInfra line
for file in \
  apply-replacements/run.go \
  apply-replacements/run_js.go \
  set-labels/run.go \
  set-labels/run_js.go \
  set-namespace/run.go \
  set-namespace/run_js.go \
  starlark/run.go \
  starlark/run_js.go
do
  if [ -f "$file" ]; then
    # Get the year from the file
    year=$(grep -m1 "Copyright [0-9]" "$file" | sed 's/.*Copyright \([0-9]*\).*/\1/')
    # Replace Google LLC with The kpt Authors and remove OpenInfra line
    sed -i "s/\/\/ Copyright $year Google LLC/\/\/ Copyright $year The kpt Authors/" "$file"
    sed -i "/Modifications Copyright (C) 2025 OpenInfra Foundation Europe./d" "$file"
  fi
done

# Files with just Google LLC (no OpenInfra line)
for file in \
  gatekeeper/main.go \
  gatekeeper/validate.go \
  render-helm-chart/main.go \
  render-helm-chart/helmfn/helmchartprocessor.go \
  set-labels/main.go \
  set-namespace/main.go \
  set-namespace/transformer/consts.go \
  set-namespace/transformer/namespace.go
do
  if [ -f "$file" ]; then
    year=$(grep -m1 "Copyright [0-9]" "$file" | sed 's/.*Copyright \([0-9]*\).*/\1/')
    sed -i "s/\/\/ Copyright $year Google LLC/\/\/ Copyright $year The kpt Authors/" "$file"
  fi
done

echo "Fixed Google LLC headers"
