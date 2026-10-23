#!/usr/bin/env bash
# Sample fixture for Nautilus Bash token roles.

set -euo pipefail

readonly VERSION="1.2.3"
declare -a FILES=()
local COUNT=0
export PATH="${PATH:-/usr/bin}:/opt/bin"

alias ll='ls -la --color=auto'

greet() {
  local name="${1:-world}"
  printf 'Hello, %s\n' "$name"
}

usage() {
  cat <<'EOF'
Usage: sample.sh [--verbose] <path>
EOF
}

if [[ $# -lt 1 ]]; then
  usage >&2
  exit 1
fi

VERBOSE=0
TARGET=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    -v|--verbose)
      VERBOSE=1
      shift
      ;;
    -*)
      echo "Unknown option: $1" >&2
      exit 2
      ;;
    *)
      TARGET="$1"
      shift
      ;;
  esac
done

FILES=(*.sh)
COUNT="${#FILES[@]}"

echo "files: ${COUNT}"
echo "home: ${HOME:?missing HOME}"
echo "first: ${FILES[0]:-none}"
echo "status: $?"
echo "pid: $$  args: $#  all: $*"
echo "positional: $1 $2"

(( COUNT > 0 )) && echo "count is ${COUNT}"

grep -n --fixed-strings 'TODO' "$TARGET" 2>/dev/null || true
ls -la -- "$TARGET" | head -n 5

result="$(basename "$TARGET")"
backticks=`date +%Y-%m-%d`
ansi=$'line\twith\tescapes\n'

echo "$result" && echo "$backticks" || echo "$ansi"

for file in "${FILES[@]}"; do
  [[ -f "$file" ]] || continue
  echo "file=${file}"
done

select choice in yes no; do
  echo "picked ${choice}"
  break
done

until [[ $COUNT -eq 0 ]]; do
  COUNT=$((COUNT - 1))
done

time ls >/dev/null

diff <(printf 'a\n') <(printf 'b\n') || true

extglob="@(foo|bar)"
echo "${extglob}" ~ "${HOME}" *

exit 0
