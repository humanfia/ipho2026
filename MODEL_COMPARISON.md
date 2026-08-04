# IPhO 2026 模型性能与 Token 对比

统计截至 2026-08-04（UTC）。代码快照：GPT/Codex v2 9b42912，
Kimi K3 91dbe9c。

## 对比总表

| 指标 | GPT/Codex v2 | Kimi K3 |
|---|---:|---:|
| 理论题完成率 | **23/23（100%）** | **23/23（100%）** |
| 实验题 | 6 道，排除在本次评分外 | 6 道，排除在本次评分外 |
| 23 个理论文件逐一 Lean 验证 | 全部通过 | 全部通过 |
| 理论题有效 sorry | 0 | 0 |
| 有完整逐题 Token 数据的题目 | **22/23** | **1/23** |
| 可发布的完整整轮 Token 总计 | 无 | 无 |

## 结论

1. 按理论题口径，两次运行的证明性能相同：均完成 23/23，全部理论
   文件通过 Lean 验证，且有效 sorry 为 0。
2. Token 报告只列出全部直接会话都有 provider 计数的题目。
   GPT/Codex v2 可发布 22 道，Kimi K3 可发布 1 道。
3. 两次运行都缺少至少一道题的完整计量，因此不发布整轮 Token 总量，
   也不据此进行 Token 效率排名。

## 统计口径

- 只统计 T1–T3 的 23 道理论题；六道实验题全部排除。
- 纳入能唯一归属到单道题的形式化、证明、逐题审查和逐题修复会话，
  包括重试与失败尝试。
- 总计 = 非缓存输入 + 缓存输入 + 输出。reasoning token 若为输出
  token 的子集，不重复相加。
- 缺少任一直接会话 usage 的题目不进入公开表格；不发布部分值、下界
  或字符数估算。
- GPT/Codex v2 运行没有固定可核验的精确 GPT 模型 ID，因此保留运行
  名称，不进一步归因到某个具体模型版本。

完整逐题表见 [TOKEN_USAGE.md](TOKEN_USAGE.md)，机器可读数据见
[token_usage_per_problem.csv](token_usage_per_problem.csv)。

主分支中的最终理论文件分别位于
[codex-v2-solution](codex-v2-solution) 和
[kimi-k3-solution](kimi-k3-solution)。
