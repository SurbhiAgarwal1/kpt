import os
import re

def fix_config_file(file_path):
    with open(file_path, 'r', encoding='utf-8') as f:
        content = f.read()

    # Pattern to find 'Custom' resources in ResourceList and remove their namespace
    # Note: Resources are usually inside a multiline string in stdOut: |
    # We look for:
    #   - apiVersion: custom.io/v1
    #     kind: Custom
    #     ...
    #     namespace: staging
    
    # We use a non-greedy regex to find blocks between '- apiVersion:'
    # and look for the 'kind: Custom' and remove 'namespace: [anything]'
    
    # Actually, let's just use a simple regex for:
    # kind: Custom followed by metadata and then namespace
    
    # Regex for a Custom resource block that has a namespace
    # We want to remove the 'namespace: [something]' line if it belongs to a 'Custom' resource
    
    # Step 1: Split by '- apiVersion:'
    parts = content.split('  - apiVersion:')
    if len(parts) <= 1:
        return # Not a multi-resource config, ignore for now or handle differently if needed
    
    new_parts = [parts[0]]
    changed = False
    
    for part in parts[1:]:
        # Re-add the split marker if it's not the first part
        modified_part = '  - apiVersion:' + part
        
        # Check if it's a 'Custom' resource
        if 'kind: Custom' in modified_part:
            # Look for namespace: line and remove it
            # Matches '    namespace: [anything]' or '      namespace: [anything]'
            # But ONLY if it's not and nested in annotations
            # We look for the top-level one at indentation of at least 4 spaces if it follows metadata
            res = re.sub(r'(\n\s+name: [^\n]+)\n\s+namespace: [^\n]+', r'\1', modified_part)
            if res != modified_part:
                modified_part = res
                changed = True
            
            # Additional pattern if namespace is after annotations
            res = re.sub(r'(\n\s+annotations:[^\n]*(\n\s+  [^\n]*)*)\n\s+namespace: [^\n]+', r'\1', modified_part)
            if res != modified_part:
                modified_part = res
                changed = True

        new_parts.append(modified_part)
    
    if changed:
        print(f"Fixed {file_path}")
        with open(file_path, 'w', encoding='utf-8') as f:
            f.write("".join(new_parts))

# Traverse all e2e/testdata directories
for root, dirs, files in os.walk('e2e/testdata'):
    for file in files:
        if file == 'config.yaml' and '.expected' in root:
            fix_config_file(os.path.join(root, file))
