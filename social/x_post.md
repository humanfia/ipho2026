Humanfia cleared all 23/23 IPhO 2026 theory targets, with Codex and Kimi K3.

What "solved" means here: every released Lean 4 file compiles against a pinned toolchain with zero active sorry. not an answer that looks right, not a grader's judgment call, but a proof the compiler accepted end to end.

The breakdown is T1 5/5, T2 8/8, T3 10/10. that comes out to 46 released theory files across the two runs, and check-all.sh compiles every one of them independently and fails the build if Lean reports a single active sorry. one script, no manual grading anywhere in the loop.

Physics is a harder target than contest math for this, and the reason is upstream of the proving. a competition problem is not a theorem. before there is anything to prove you have to commit, in Lean, to the setup, the idealizations, the units and the boundary conditions. get that wrong and you can produce a flawless proof of the wrong statement, which is the failure mode nobody catches by reading the final answer. so targets ran through a formalization review gate before proving started and a proof review gate after.

The whole environment is pinned and shipped, not described: Lean 4.31.0, Mathlib v4.31.0, a fixed PhysLean commit, plus blueprints and the run harnesses. clone it and re-check the proofs yourself. that is the point of publishing it this way.

The six experimental targets are excluded from the 23. their snapshots are in the repo, they may contain placeholders, and we do not claim them as solved.

The models are strong. the agent loop you wrap around them is what turns a strong model into 23 verified proofs.

https://github.com/humanfia/ipho2026
