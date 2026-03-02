#!/bin/bash
# Cleanup script for PR #4391
# Removes unrelated files from the CEL conditional execution PR

echo "Creating backup branch..."
git branch backup-cel-pr-$(date +%Y%m%d-%H%M%S)

echo "Removing unrelated files..."

# Remove test output files
git rm -f container_test_out.txt
git rm -f temp.txt
git rm -f test_all.log
git rm -f test_e2e.log
git rm -f test_e2e_2.log
git rm -f test_failure.log
git rm -f test_failure_utf8.log
git rm -f test_out.txt
git rm -f test_out_cmd.txt
git rm -f test_out_cmd_2.txt
git rm -f test_output.txt
git rm -f test_results.txt

# Remove personal notes
git rm -f issue_1835_comment.md
git rm -f issue_1835_implementation_plan.md
git rm -f pr_1835_description.md
git rm -f pr_comment_4391.md

# Remove CEL_CONDITIONS.md (reviewer requested)
git rm -f internal/fnruntime/CEL_CONDITIONS.md

# Revert unrelated documentation changes
git checkout upstream/main -- documentation/content/en/book/03-packages/_index.md
git checkout upstream/main -- documentation/content/en/guides/namespace-provisioning-cli.md
git checkout upstream/main -- documentation/content/en/guides/tenant-onboarding.md
git checkout upstream/main -- documentation/content/en/installation/migration.md
git checkout upstream/main -- documentation/content/en/reference/cli/pkg/init/_index.md

echo "Files removed. Review changes with: git status"
echo "If everything looks good, commit with:"
echo "git commit -m 'chore: Remove unrelated files from CEL PR'"
