# IPhO 2026 模型性能与 Token 对比

统计截至 2026-08-04（UTC）。代码快照：GPT/Codex v2 9b42912，
Kimi K3 91dbe9c。

> **结果：GPT/Codex v2 与 Kimi K3 均完成 23/23 道理论题。**
>
> **Token cost：在数据完整且可直接对齐的 22 道题上，GPT/Codex v2
> 为 146,641,757，Kimi K3 为 1,189,135,736；Kimi K3 是 8.11×。**

## 对比总表

| 指标 | GPT/Codex v2 | Kimi K3 |
|---|---:|---:|
| 理论题完成率 | **23/23（100%）** | **23/23（100%）** |
| 实验题 | 6 道，排除在本次评分外 | 6 道，排除在本次评分外 |
| 23 个理论文件逐一 Lean 验证 | 全部通过 | 全部通过 |
| 理论题有效 sorry | 0 | 0 |
| Provider 精确逐题 Token | **22/23** | **1/23** |
| 完整轨迹逐题 Token | **22/23** | **23/23** |
| 共同 22 题输入 Token | 145,594,784 | 1,182,905,613 |
| 共同 22 题输出 Token | 1,046,973 | 6,230,123 |
| **共同 22 题 Token 总计** | **146,641,757** | **1,189,135,736** |
| 共同 22 题相对 Token | **1.00×** | **8.11×** |
| 全部 23 题 Token 总计 | 数据不完整，不发布 | **1,220,581,322** |

## 结论

1. 按理论题口径，两次运行的证明性能相同：均完成 23/23，全部理论
   文件通过 Lean 验证，且有效 sorry 为 0。
2. 只比较双方数据都完整的 22 道题时，Kimi K3 使用的 Token 是
   GPT/Codex v2 的 8.11 倍。GPT/Codex v2 在这个口径下 Token 效率更高。
3. Kimi K3 的完整运行共 1,220,581,322 Token；其中 67,884,210 是
   provider 精确 usage，1,152,697,112 是保存轨迹逐请求重算结果。
4. 先前的 `≥64,381,419` 只累计了当时能直接读取 usage 的部分，是下界，
   不能代表 Kimi K3 全部运行。恢复早期轨迹后，结论不再是“Kimi 更少”。

## 为什么 Kimi K3 的完整数字更高

在共同 22 题中，Kimi K3 有 302 个可归属会话、13,273 次成功模型调用；
GPT/Codex v2 有 76 个会话、2,825 个已计量 turn。模型调用使用累计上下文，
同一题后续调用会再次计入此前提示、工具 schema、对话和工具输出，所以更多
重试与更长轨迹会快速放大输入 Token。Kimi K3 的共同 22 题中，输入占
总 Token 的 99.48%，这也是差距的主要来源。

## 统计口径

- 只统计 T1–T3 的 23 道理论题；六道实验题全部排除。
- 纳入能唯一归属到单道题的形式化、证明、逐题审查和逐题修复会话，
  包括重试；共享规划不强行分摊到各题。
- GPT/Codex v2 的共同 22 题全部使用 provider usage。总计 = 非缓存输入
  + 缓存输入 + 输出；reasoning token 是输出的子集，不重复相加。
- Kimi K3 后期 30 个会话使用 provider usage；早期 287 个会话用固定版本
  的官方 tokenizer 逐请求重放。详细方法与校验见重算报告。
- 没有成功模型输出、也没有可靠 usage 的失败请求不计 Token；CSV 单独
  保留其数量。
- GPT/Codex v2 的 T3-B1 有一个直接会话缺少完整计量且无法精确重建，
  因此该题不进入 Token 对比，也不发布 GPT 的不完整 23 题总量。
- GPT/Codex v2 运行没有固定可核验的精确 GPT 模型 ID，因此保留运行
  名称，不进一步归因到某个具体模型版本。
- Kimi K3 的早期重算数据没有缓存计费分类，因此不报告 USD 成本。
  8.11× 是 Token 量之比，不是账单金额之比。

Provider 精确逐题表见 [TOKEN_USAGE.md](TOKEN_USAGE.md)，Kimi K3 完整
重算表见 [TOKEN_USAGE_RECONSTRUCTED.md](TOKEN_USAGE_RECONSTRUCTED.md)。
对应机器可读数据为
[token_usage_per_problem.csv](token_usage_per_problem.csv) 和
[token_usage_reconstructed_per_problem.csv](token_usage_reconstructed_per_problem.csv)。

主分支中的最终理论文件分别位于
[codex-v2-solution](codex-v2-solution) 和
[kimi-k3-solution](kimi-k3-solution)。
