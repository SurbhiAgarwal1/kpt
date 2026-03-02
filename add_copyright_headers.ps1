$header = @"
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

"@

# Get all Go files in krm-functions-catalog/functions/go
$files = Get-ChildItem -Path "krm-functions-catalog/functions/go" -Filter "*.go" -Recurse

foreach ($file in $files) {
    $content = Get-Content $file.FullName -Raw
    
    # Skip if already has copyright
    if ($content -match "Copyright.*The kpt Authors" -or $content -match "Copyright.*Google LLC") {
        Write-Host "Skipping $($file.Name) - already has copyright"
        continue
    }
    
    # Skip generated files
    if ($content -match "Code generated") {
        Write-Host "Skipping $($file.Name) - generated file"
        continue
    }
    
    # Add header
    $newContent = $header + $content
    Set-Content -Path $file.FullName -Value $newContent -NoNewline
    Write-Host "Added header to $($file.Name)"
}

Write-Host "Done!"
