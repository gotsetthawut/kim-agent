@echo off
setlocal

set REPO_NAME=kim-agent
set REPO_DESC=KIM - Knowledge Intelligence Manager. A Claude Agent skill for token-efficient knowledge management.

echo ============================================================
echo  KIM Agent - GitHub Repo Setup
echo ============================================================
echo.

REM ── Check git ──────────────────────────────────────────────
where git >nul 2>&1
if errorlevel 1 (
    echo ERROR: git not found. Install from https://git-scm.com
    pause & exit /b 1
)

REM ── Check gh CLI ───────────────────────────────────────────
where gh >nul 2>&1
if errorlevel 1 (
    echo ERROR: GitHub CLI (gh) not found.
    echo Install from https://cli.github.com then run: gh auth login
    pause & exit /b 1
)

REM ── Check gh auth ──────────────────────────────────────────
gh auth status >nul 2>&1
if errorlevel 1 (
    echo You need to log in to GitHub first.
    echo Running: gh auth login
    gh auth login
)

REM ── Init git repo ──────────────────────────────────────────
cd /d "%~dp0"

if not exist ".git" (
    echo Initializing git...
    git init
    git add .
    git commit -m "Initial commit: KIM Knowledge Intelligence Manager"
) else (
    echo Git already initialized. Staging changes...
    git add .
    git diff --cached --quiet || git commit -m "Update KIM agent files"
)

REM ── Create private GitHub repo ─────────────────────────────
echo.
echo Creating private GitHub repo: %REPO_NAME%...
gh repo create %REPO_NAME% --private --description "%REPO_DESC%" --source=. --remote=origin --push

if errorlevel 1 (
    echo.
    echo Repo may already exist. Attempting to push to existing remote...
    git remote add origin https://github.com/gotsetthawut/%REPO_NAME%.git 2>nul
    git branch -M main
    git push -u origin main
)

echo.
echo ============================================================
echo  Done! Your private repo is live at:
echo  https://github.com/gotsetthawut/%REPO_NAME%
echo.
echo  Codex can now read KIM files from this repo.
echo ============================================================
echo.
pause
