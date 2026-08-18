set -eEuo pipefail

printPath=false

if [ "${1:-}" = "--path" ]; then
  printPath=true
  shift
fi

if [ "$#" -ne 1 ]; then
  printf 'Usage: jj-workspace-sibling [--path] <workspace-name>\n' >&2
  exit 2
fi

workspaceName="$1"
currentWorkspace="$(jj --ignore-working-copy workspace root)"

case "$workspaceName" in
  "" | */*)
    printf 'Workspace name must not be empty or contain /\n' >&2
    exit 2
    ;;
esac

repoPath="$currentWorkspace/.jj/repo"

if [ -d "$repoPath" ]; then
  repoDir="$(cd "$repoPath" && pwd -P)"
elif [ -f "$repoPath" ]; then
  repoDir="$(<"$repoPath")"
  repoDir="$(cd "$(dirname "$repoPath")" && cd "$repoDir" && pwd -P)"
else
  printf 'Could not resolve jj repo path from %s\n' "$repoPath" >&2
  exit 2
fi

rootWorkspace="${repoDir%/.jj/repo}"

if [ "$rootWorkspace" = "$repoDir" ]; then
  printf 'Could not resolve root workspace from %s\n' "$repoDir" >&2
  exit 2
fi

rootWorkspace="$(cd "$rootWorkspace" && pwd -P)"
workspacePath="$(dirname "$rootWorkspace")/$(basename "$rootWorkspace").$workspaceName"
workspaceCreated=false

if [ "$printPath" = true ]; then
  printf '%s\n' "$workspacePath"
  exit 0
fi

onError() {
  exitStatus=$?

  if [ "$workspaceCreated" = true ]; then
    printRecovery
  fi

  exit "$exitStatus"
}

trap onError ERR

printRecovery() {
  printf 'Workspace provisioning failed. Remove it with:\n' >&2
  printf '  jj -R %q workspace forget %q\n' "$rootWorkspace" "$workspaceName" >&2
  printf '  rm -rf %q\n' "$workspacePath" >&2
}

if [ -e "$workspacePath" ] || [ -L "$workspacePath" ]; then
  printf 'Workspace path already exists: %s\n' "$workspacePath" >&2
  exit 2
fi

untrackedPaths="$(mktemp)"
copyPaths="$(mktemp)"
trap 'rm -f "$untrackedPaths" "$copyPaths"' EXIT

git -C "$rootWorkspace" ls-files --others --exclude-standard -z > "$untrackedPaths"
git -C "$rootWorkspace" ls-files --others --ignored --exclude-standard -z >> "$untrackedPaths"

matchingLocalPath() {
  matchingPath=""
  remainingPath="$1"
  pathPrefix=""

  while :; do
    pathPart="${remainingPath%%/*}"

    if [ -n "$pathPrefix" ]; then
      pathPrefix="$pathPrefix/$pathPart"
    else
      pathPrefix="$pathPart"
    fi

    case "$pathPart" in
      *.local | *.local.*)
        matchingPath="$pathPrefix"
        return 0
        ;;
    esac

    if [ "$pathPart" = "$remainingPath" ]; then
      return 1
    fi

    remainingPath="${remainingPath#*/}"
  done
}

linkPath() {
  sourcePath="$1"
  destinationPath="$2"
  replaceExisting="$3"

  if [ -e "$destinationPath" ] || [ -L "$destinationPath" ]; then
    if [ "$replaceExisting" = true ]; then
      if [ -d "$destinationPath" ] && [ ! -L "$destinationPath" ]; then
        printf 'Cannot replace directory with symlink: %s\n' "$destinationPath" >&2
        return 2
      fi

      rm -f "$destinationPath"
    elif [ -L "$destinationPath" ]; then
      return
    else
      printf 'Cannot replace existing path with symlink: %s\n' "$destinationPath" >&2
      return 2
    fi
  fi

  destinationDir="$(dirname "$destinationPath")"
  mkdir -p "$destinationDir"
  linkTarget="$(realpath --no-symlinks --relative-to="$destinationDir" "$sourcePath")"
  ln -s "$linkTarget" "$destinationPath"
}

if ! jj -R "$currentWorkspace" workspace add --name "$workspaceName" "$workspacePath"; then
  if [ -e "$workspacePath" ] || [ -L "$workspacePath" ]; then
    printRecovery
  fi

  exit 1
fi

workspaceCreated=true

while IFS= read -r -d '' path; do
  case "$path" in
    .jj | .jj/* | .direnv | .direnv/* | .dockercache | .dockercache/* | *.cache/* | .envrc)
      continue
      ;;
  esac

  if matchingLocalPath "$path"; then
    linkPath "$rootWorkspace/$matchingPath" "$workspacePath/$matchingPath" false
  else
    printf '%s\0' "$path" >> "$copyPaths"
  fi
done < "$untrackedPaths"

if [ -s "$copyPaths" ]; then
  rsync -a --info=name,progress2 --from0 --files-from="$copyPaths" "$rootWorkspace/" "$workspacePath/"
fi

if [ -e "$rootWorkspace/.envrc" ]; then
  linkPath "$rootWorkspace/.envrc" "$workspacePath/.envrc" true
  direnv allow "$workspacePath"
fi
