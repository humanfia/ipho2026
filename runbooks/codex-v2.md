# IPhO 2026 Archon 后台运行说明

## 固定信息

- 运行目录：`/root/proposal_for_physic/science-mango-ipho-2026-run`
- 数据仓库：`/root/proposal_for_physic/science-mango`
- 数据分支：`physics`
- 数据提交：`66bbb024680e5c08ba84cd529a0cf1ebe1fdd460`
- 输入文件：`ipho_2026_source/ipho_2026_archon_pipeline.jsonl`
- 目标数：28
- Codex 会话 ID：`019f9f07-2119-7e13-a847-9bc66f1f50ab`
- 建议会话名：`physic`（在当前 TUI 输入 `/rename physic`）

## 明天恢复 Codex 会话

```bash
codex resume 019f9f07-2119-7e13-a847-9bc66f1f50ab
```

如果已执行 `/rename physic`，也可以运行 `codex resume physic`。

进入会话后说：“继续 IPhO 2026，先检查后台运行状态再续跑”。

## 查看后台状态

```bash
cd /root/proposal_for_physic/science-mango-ipho-2026-run
scripts/status_ipho_2026.sh
```

实时查看 Archon 日志：

```bash
tail -f .archon/runtime/ipho_2026_archon.log
```

## 后台进程文件

- Archon PID：`.archon/runtime/ipho_2026_archon.pid`
- Archon 日志：`.archon/runtime/ipho_2026_archon.log`
- LeanExplore PID：`.archon/runtime/lean_explore_8765.pid`
- LeanExplore 日志：`.archon/runtime/lean_explore_8765.log`

## 启动与断点续跑

首次后台启动：`scripts/start_ipho_2026.sh`

只有在旧 Archon 进程已经停止时，才使用断点续跑：

```bash
scripts/start_ipho_2026.sh --resume
```

脚本会先确保共享的本地 LeanExplore HTTP MCP 服务已启动，再以 `nohup`
启动 Archon。重复执行不会创建第二个仍在运行的实例。

## 当前管线参数

- Lean 4.31.0、Mathlib v4.31.0
- PhysLean `1706ae68b63996f1d97717e672e50c9e3933d933`
- Archon 0.3.1
- Codex harness，reasoning effort `xhigh`
- 28 个并行 prover / review worker
- formalization review gate：开启，最多 3 次
- proof review gate：开启，最多 3 次
- 本地 MCP：`lean-lsp`、`lean-explore`

## 数据与预检结果

- `physics-formalize` 已准备 28 个目标。
- Lean/PhysLean preflight 已通过。
- 生成清单：`.archon/physics-formalize/ipho_2026/batch_manifest.json`
- 目标状态：`.archon/PROGRESS.md`

不要在旧 PID 仍存活时手动再次运行 `archon loop`，否则会有两个进程同时修改同一批 Lean 文件。
