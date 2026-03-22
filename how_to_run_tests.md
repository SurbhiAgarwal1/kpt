# How to Run E2E Tests and Fix PR #4420

## Step 1: Start Docker Desktop
1. Press Windows key
2. Search for "Docker Desktop"
3. Click to open it
4. Wait for it to say "Docker Desktop is running" (green icon in system tray)

## Step 2: Verify Docker is Running
Open PowerShell and run:
```powershell
docker ps
```
You should see a table (even if empty). If you see an error, Docker isn't running yet.

## Step 3: Build kpt
```powershell
cd C:\Users\Surbhi\Catroid\kpt
go build -o bin/kpt.exe .
```

## Step 4: Run E2E Tests with Update Flag
```powershell
$env:KPT_E2E_UPDATE_EXPECTED="true"
$env:PATH="$PWD\bin;$env:PATH"
go test -v --tags=docker --run=TestFnRender ./e2e/
go test -v --tags=docker --run=TestFnEval ./e2e/
```

## Step 5: Check What Changed
```powershell
git status
git diff
```

## Step 6: Commit and Push
```powershell
git add .
git commit -m "Update expected test outputs for set-namespace:latest"
git push
```

## If Docker Desktop Won't Start
Post this comment on GitHub and ask for help:

"Thanks @liamfallon! I've updated internal/kptops/functions.go to use :latest.

The E2E tests are failing because expected output files need regenerating. Docker Desktop isn't starting on my Windows machine. Could you help run the tests with KPT_E2E_UPDATE_EXPECTED=true and share the updated files?

Thanks!"
