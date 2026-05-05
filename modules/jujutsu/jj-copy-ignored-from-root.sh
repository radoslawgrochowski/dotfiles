set -euo pipefail

if [ -z "${JJ_WORKSPACE_ROOT:-}" ]; then
  printf 'This alias must be run from a jj workspace\n' >&2
  exit 2
fi

repoPath="$JJ_WORKSPACE_ROOT/.jj/repo"

if [ -d "$repoPath" ]; then
  repoDir="$(cd "$repoPath" && pwd -P)"
elif [ -f "$repoPath" ]; then
  repoDir="$(<"$repoPath")"
  repoDir="$(cd "$repoDir" && pwd -P)"
else
  printf 'Could not resolve jj repo path from %s\n' "$repoPath" >&2
  exit 2
fi

rootWorkspace="${repoDir%/.jj/repo}"

if [ "$rootWorkspace" = "$JJ_WORKSPACE_ROOT" ]; then
  exit 0
fi

git -C "$rootWorkspace" ls-files --others --ignored --exclude-standard --directory -z \
  | while IFS= read -r -d '' path; do
      case "$path" in
        .jj|.jj/*)
          continue
          ;;
      esac

      printf '%s\0' "$path"
    done \
  | rsync -ah --info=progress2 --from0 --files-from=- "$rootWorkspace/" "$JJ_WORKSPACE_ROOT/"
