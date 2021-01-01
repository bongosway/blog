#!/bin/sh

# If a command fails then the deploy stops
set -e

printf "\033[0;32mDeploying updates to GitHub...\033[0m\n"

# Build the project.
hugo --gc --minify # if using a theme, replace with `hugo -t <YOURTHEME>`

# Go To Public folder
cd bongosway.github.io

# Add changes to git.
git add .

# Commit changes.
msg="rebuilding site $(date)"
if [ -n "$*" ]; then
	msg="$*"
fi
git commit -m "$msg"

# Push source and build repos.
git push origin master

cd ..
git add .
msg="update blog repository $(date)"
if [ -n "$*" ]; then
	msg="$*"
fi
git push origin master

printf "\033[0;32mDeploying updates done...\033[0m\n"
