#!/bin/bash
export FILTER_BRANCH_SQUELCH_WARNING=1
git filter-branch -f --msg-filter '
if ! grep -q "Signed-off-by: Surbhi"; then
  cat
  echo
  echo "Signed-off-by: Surbhi <agarwalsurbhi1807@gmail.com>"
else
  cat
fi
' b27e54de9..HEAD
