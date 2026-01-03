#!/bin/bash

# Upload CURRENT directory to GitHub
# Repo name = current directory name

REPO=$(basename "$PWD")

echo "Repo name: $REPO"

# 1. Install gh if needed
if ! command -v gh &> /dev/null; then
    echo "Installing GitHub CLI..."
    sudo apt update
    sudo apt install -y gh
fi

# 2. Authenticate if not logged in
if ! gh auth status &> /dev/null; then
    echo "Logging in..."
    gh auth login -w
fi

# 3. Initialize git (if not already)
if [ ! -d ".git" ]; then
    echo "Initializing Git..."
    git init
fi

# 4. If repo does NOT exist → create it (WITHOUT exiting!)
if gh repo view "$REPO" &>/dev/null; then
    echo "Repo exists."
else
    echo "Creating GitHub repo..."
    gh repo create "$REPO" --public
fi

# 5. Ensure remote origin is correct
USERNAME=$(gh api user --jq '.login')
git remote remove origin 2>/dev/null
git remote add origin "https://github.com/$USERNAME/$REPO.git"

# 6. Commit everything
echo "Adding files..."
git add .

git commit -m "Upload $(date)" 2>/dev/null || echo "No changes to commit"

# 7. Force correct branch
git branch -M main

# 8. Push EVERYTHING
echo "Pushing..."
git push -u origin main

echo "🚀 DONE — your files are now on GitHub!"

