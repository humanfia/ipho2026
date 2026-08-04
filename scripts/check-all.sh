#!/usr/bin/env bash
set -euo pipefail

script_dir=$(cd "$(dirname "$0")" && pwd)
repo_root=$(cd "$script_dir/.." && pwd)
base_dir="$repo_root/base"

check_one() {
  solution=$1
  relative_path=${solution#"$repo_root/"}
  echo "Checking $relative_path"

  if ! output=$(cd "$base_dir" && lake env lean "$solution" 2>&1); then
    echo "$output" >&2
    return 1
  fi

  if grep -Fq "declaration uses 'sorry'" <<<"$output"; then
    echo "$output" >&2
    echo "Active sorry found in $relative_path" >&2
    return 1
  fi
}

checked=0
failed=0
pids=()

wait_for_batch() {
  local pid
  for pid in "${pids[@]}"; do
    if ! wait "$pid"; then
      failed=1
    fi
  done
  pids=()
}

for solution_dir in "$repo_root/codex-v2-solution" "$repo_root/kimi-k3-solution"; do
  for solution in "$solution_dir"/*.lean; do
    check_one "$solution" &
    pids+=("$!")
    checked=$((checked + 1))

    if [[ ${#pids[@]} -eq 4 ]]; then
      wait_for_batch
    fi
  done
done

wait_for_batch

if [[ $checked -ne 46 ]]; then
  echo "Expected 46 theory files, checked $checked" >&2
  exit 1
fi

if [[ $failed -ne 0 ]]; then
  exit 1
fi

echo "Verified $checked theory files: all compile and no active sorry was reported."
