#!/bin/sh

# If a command fails then the deploy stops
set -e

printf "\033[0;32mDeploying updates to GitHub...\033[0m\n"

# Build the project.
#hugo # if using a theme, replace with `hugo -t <YOURTHEME>`
hugo -d bongosway.github.io

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

printf "\033[0;32mDeploying updates to GitHub...COMPLETE\033[0m\n"

cd ..

printf "\033[0;32mUpdating source repository...\033[0m\n"

git add .

# Commit changes.
msg="Updating repo $(date)"
if [ -n "$*" ]; then
	msg="$*"
fi
git commit -m "$msg"

git push origin master
