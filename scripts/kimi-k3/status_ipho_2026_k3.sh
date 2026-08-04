#!/usr/bin/env bash
set -euo pipefail

RUN_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
RUNTIME_DIR="$RUN_ROOT/.archon/runtime"
ARCHON_PID_FILE="$RUNTIME_DIR/ipho_2026_k3_archon.pid"
LEAN_PID_FILE="$RUNTIME_DIR/lean_explore_8765.pid"
LOG_FILE="$RUNTIME_DIR/ipho_2026_k3_archon.log"
ACCURACY_EXCLUSIONS_FILE="$RUN_ROOT/reports/ipho_2026_k3/accuracy_exclusions.json"
FORMALIZATION_GATE_FILE="$RUN_ROOT/.archon/formalization-review-gate.json"
PROOF_GATE_FILE="$RUN_ROOT/.archon/proof-review-gate.json"

show_process() {
    local label="$1"
    local pid_file="$2"
    if [[ ! -s "$pid_file" ]]; then
        echo "$label: no PID file"
        return
    fi
    local process_pid
    process_pid="$(<"$pid_file")"
    if kill -0 "$process_pid" 2>/dev/null; then
        echo "$label: RUNNING (PID $process_pid)"
        ps -p "$process_pid" -o pid=,etime=,%cpu=,%mem=,stat=,cmd=
    else
        echo "$label: STOPPED (stale PID $process_pid)"
    fi
}

show_process "LeanExplore" "$LEAN_PID_FILE"
show_process "Archon" "$ARCHON_PID_FILE"

if curl --silent --output /dev/null --max-time 1 \
    http://127.0.0.1:8765/mcp; then
    echo "LeanExplore endpoint: READY"
else
    echo "LeanExplore endpoint: NOT READY"
fi

echo "Kimi provider: DIRECT → api.moonshot.cn/anthropic/v1/messages"

lifecycle_jobs="$(jq -r \
    '.loop.pipeline_target_lifecycle_jobs // .loop.max_parallel // 1' \
    "$RUN_ROOT/.archon/config.json")"
claude_workers="$(ps -eo args= | awk '
    /claude/ && /--model kimi-k3/ && !/awk/ { count += 1 }
    END { print count + 0 }
')"
echo "Active K3 Claude workers: $claude_workers / $lifecycle_jobs"
echo "Target queue depth: $(jq -r '.loop.max_objectives // 1' "$RUN_ROOT/.archon/config.json")"

if [[ -f "$ACCURACY_EXCLUSIONS_FILE" \
    && -f "$FORMALIZATION_GATE_FILE" \
    && -f "$PROOF_GATE_FILE" ]]; then
    accuracy_summary="$(
        jq -nr \
            --slurpfile exclusions "$ACCURACY_EXCLUSIONS_FILE" \
            --slurpfile formal "$FORMALIZATION_GATE_FILE" \
            --slurpfile proof "$PROOF_GATE_FILE" '
                ($exclusions[0].excluded_targets // []) as $excluded
                | ($formal[0].targets // {} | keys) as $all
                | [
                    $all[] as $target
                    | select(($excluded | index($target)) == null)
                    | $target
                  ] as $eligible
                | ($proof[0].targets // {}) as $proof_targets
                | [
                    $eligible[] as $target
                    | select(($proof_targets[$target].status // "") == "solved")
                    | $target
                  ] as $solved
                | [
                    $eligible[] as $target
                    | select(
                        (($formal[0].targets[$target].status // "")
                          == "review_exhausted")
                        or
                        (($proof_targets[$target].status // "")
                          == "proof_review_exhausted")
                      )
                    | $target
                  ] as $failed
                | ($eligible | length) as $total
                | ($solved | length) as $done
                | ($failed | length) as $failed_count
                | [
                    $done,
                    $total,
                    ($total - $done - $failed_count),
                    $failed_count,
                    ($excluded | length),
                    (
                      if $total == 0 then 0
                      else (((($done * 10000) / $total) | round) / 100)
                      end
                    )
                  ]
                | @tsv
            '
    )"
    IFS=$'\t' read -r theory_solved theory_total theory_remaining \
        theory_failed experiment_excluded theory_accuracy <<<"$accuracy_summary"
    echo "Scored proof accuracy: $theory_solved / $theory_total ($theory_accuracy%)"
    echo "Scored targets pending: $theory_remaining"
    echo "Scored terminal failures: $theory_failed"
    echo "Accuracy exclusions: $experiment_excluded experimental target(s)"
fi

echo
echo "Current Archon stage:"
if [[ -f "$RUN_ROOT/.archon/PROGRESS.md" ]]; then
    sed -n '/^## Current Stage$/,/^## /p' "$RUN_ROOT/.archon/PROGRESS.md" | sed '$d'
else
    echo "(no PROGRESS.md)"
fi

echo
echo "Recent Archon log:"
if [[ -f "$LOG_FILE" ]]; then
    tail -n 40 "$LOG_FILE"
else
    echo "(no log yet)"
fi
