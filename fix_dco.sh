#!/bin/bash

# Fix DCO for specific commits
git filter-branch -f --msg-filter '
if [ "$GIT_COMMIT" = "a5bf06a828fd1bef48f0e70f0a59eea734046619" ] || \
   [ "$GIT_COMMIT" = "771604b58e706caa764062d62057a0c3d93787db" ] || \
   [ "$GIT_COMMIT" = "a7c47c3ee9f3205207116052b91730dbc1811e3c" ]; then
  cat
  echo
  echo "Signed-off-by: Surbhi <surbhiagarwal1198@gmail.com>"
else
  cat
fi
' HEAD~18..HEAD
