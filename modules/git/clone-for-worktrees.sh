#!/usr/bin/env bash

# original: https://morgan.cugerone.com/blog/workarounds-to-git-worktree-using-bare-repository-and-cannot-fetch-remote-branches/

set -euo pipefail

# Examples of call:
# clone-for-worktrees git@github.com:name/repo.git
# => Clones to a /repo directory
#
# clone-for-worktrees git@github.com:name/repo.git my-repo
# => Clones to a /my-repo directory

show_usage() {
  echo "Usage: clone-for-worktrees <git-url> [directory-name]"
  echo ""
  echo "Creates a bare git repository optimized for worktrees."
  echo ""
  echo "Arguments:"
  echo "  git-url          The git repository URL to clone"
  echo "  directory-name   Optional: Custom directory name (defaults to repo name)"
  exit 1
}

# Validate input
if [[ $# -eq 0 ]] || [[ -z "${1:-}" ]]; then
  echo "Error: Git repository URL is required" >&2
  show_usage
fi

url="$1"
basename="${url##*/}"
name="${2:-${basename%.*}}"

# Validate that name is not empty after extraction
if [[ -z "$name" ]]; then
  echo "Error: Could not determine directory name from URL: $url" >&2
  exit 1
fi

# Check if directory already exists
if [[ -d "$name" ]]; then
  echo "Error: Directory '$name' already exists" >&2
  exit 1
fi

# Create and enter directory
mkdir "$name"
cd "$name"

# Moves all the administrative git files (a.k.a $GIT_DIR) under .bare directory.
#
# Plan is to create worktrees as siblings of this directory.
# Example targeted structure:
# .bare
# main
# new-awesome-feature
# hotfix-bug-12
# ...
echo "Cloning bare repository..."
git clone --bare "$url" .bare

echo "Setting up worktree configuration..."
echo "gitdir: ./.bare" > .git

# Explicitly sets the remote origin fetch so we can fetch remote branches
git config remote.origin.fetch "+refs/heads/*:refs/remotes/origin/*"

# Gets all branches from origin
echo "Fetching all branches..."
git fetch origin

echo ""
echo "Successfully created bare repository in: $name"
echo "You can now create worktrees using: git worktree add <branch-name>"
