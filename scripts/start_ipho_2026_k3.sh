#!/usr/bin/env bash
set -euo pipefail

RUN_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
ARCHON_VENV="/root/proposal_for_physic/science-mango/.venv"
ARCHON_BIN="$ARCHON_VENV/bin/archon"
CLAUDE_REAL_BIN="${CLAUDE_REAL_BIN:-/home/codespace/nvm/current/bin/claude}"
RUNTIME_DIR="$RUN_ROOT/.archon/runtime"
CLAUDE_SHIM_DIR="$RUNTIME_DIR/claude-root-compat"
PID_FILE="$RUNTIME_DIR/ipho_2026_k3_archon.pid"
LOG_FILE="$RUNTIME_DIR/ipho_2026_k3_archon.log"
CONFIG_FILE="$RUN_ROOT/.archon/config.json"
ENV_FILE="$RUN_ROOT/.archon/.env"

mkdir -p "$RUNTIME_DIR"
mkdir -p "$CLAUDE_SHIM_DIR"
ln -sfn "$RUN_ROOT/scripts/claude_root_compat.sh" "$CLAUDE_SHIM_DIR/claude"

if [[ -s "$PID_FILE" ]]; then
    existing_pid="$(<"$PID_FILE")"
    if kill -0 "$existing_pid" 2>/dev/null; then
        echo "IPhO 2026 K3 Archon is already running (PID $existing_pid)."
        exit 0
    fi
fi

loop_start_args=()
case "${1:-}" in
    "")
        ;;
    --resume)
        loop_start_args+=("--resume")
        ;;
    --from-prover)
        # Trust the already validated PROGRESS.md objectives and enter the
        # target lifecycle directly.  This is useful for a manually scoped
        # retry because a fresh Plan pass can reintroduce stale objectives.
        loop_start_args+=("--from" "prover")
        ;;
    *)
        echo "Usage: $0 [--resume|--from-prover]" >&2
        exit 2
        ;;
esac

[[ -x "$CLAUDE_REAL_BIN" ]]
[[ -x "$RUN_ROOT/scripts/claude_root_compat.sh" ]]
grep -q '^MOONSHOT_API_KEY=sk-' "$ENV_FILE"
grep -q '^MOONSHOT_BASE_URL=https://api.moonshot.cn/anthropic$' "$ENV_FILE"
grep -q '^MOONSHOT_MODEL=kimi-k3$' "$ENV_FILE"
grep -q '^ANTHROPIC_BASE_URL=https://api.moonshot.cn/anthropic$' "$ENV_FILE"
grep -q '^ANTHROPIC_AUTH_TOKEN=sk-' "$ENV_FILE"
grep -q '^ANTHROPIC_MODEL=kimi-k3$' "$ENV_FILE"

jq -e '
  .loop.harness == "k3-anthropic"
  and .loop.model == "kimi"
  and .loop.max_parallel == 28
  and .loop.axiom_sweep_scope == "current_objectives"
  and .loop.axiom_sweep_jobs == 8
  and .loop.axiom_sweep_timeout_sec == 300
  and .loop.parallel_formalization_review == true
  and .loop.parallel_formalization_review_jobs == 4
  and .loop.parallel_formalization_review_max_attempts == 3
  and .loop.parallel_formalization_review_backoff_sec == 30
  and .loop.max_objectives == 28
  and .loop.pipeline_target_review == true
  and .loop.pipeline_target_lifecycle_jobs == 4
  and .loop.parallel_target_review_jobs == 4
  and .loop.parallel_target_review_max_attempts == 3
  and .loop.parallel_target_review_backoff_sec == 30
  and .harnesses["k3-anthropic"].runner == "claude-code"
  and .harnesses["k3-anthropic"].model == "kimi"
  and .harnesses["k3-anthropic"].backend == "default"
' "$CONFIG_FILE" >/dev/null

"$RUN_ROOT/scripts/start_lean_explore.sh"

set -a
# shellcheck disable=SC1090
. "$ENV_FILE"
set +a

nohup setsid env PATH="$CLAUDE_SHIM_DIR:$ARCHON_VENV/bin:$PATH" \
    CLAUDE_REAL_BIN="$CLAUDE_REAL_BIN" PYTHONUNBUFFERED=1 \
    "$ARCHON_BIN" loop "$RUN_ROOT" \
    --max-iterations 100 \
    --max-parallel 28 \
    --max-objectives 28 \
    --no-dashboard \
    "${loop_start_args[@]}" \
    >>"$LOG_FILE" 2>&1 < /dev/null &
archon_pid=$!
printf '%s\n' "$archon_pid" > "$PID_FILE"

sleep 5
if ! kill -0 "$archon_pid" 2>/dev/null; then
    echo "Archon exited during startup. Recent log:" >&2
    tail -n 100 "$LOG_FILE" >&2 || true
    exit 1
fi

echo "IPhO 2026 K3 Archon started with queue depth 28 and 4 active target lifecycles (PID $archon_pid)."
echo "Model: kimi-k3"
echo "Harness: Claude Code (Anthropic Messages API)"
echo "Upstream: https://api.moonshot.cn/anthropic/v1/messages"
echo "Log: $LOG_FILE"
