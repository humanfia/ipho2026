# Iteration 002 plan

## Decision made

- Retry exactly the seven Review failures in `physics-formalize`; keep the 21 accepted signatures frozen until the stage advances.
- Correct T1 C.1 from conservation laws: the fragment kinetic minimum inserts factor \(2\) under the radical. This restores C.2's \(2.0296693\times10^{-11}\) eV value; reverse only if an official erratum supersedes the laws and C.2.
- Correct E1 A.1's printed `0.94 g` to `0.094 g`: Figure 17 gives \(d=33.7\) mm, the solution gives \(H=9.5\) cm and \(V=85\) mL, and its mole/count answers require the corrected mass.
- Restore graph truth before dispatch: mapped all 498 Lean declarations, added concise informal blocks, and wired file-local dependencies/targets.

## Evidence

- Read official images T1 p.3, T2 pp.1/2/4, T3 p.4, E1 pp.7/9, plus E1 solution pp.1--2.
- Iter-001 Review: 21 passed, seven retry, all 28 compile, 35 open sorries.

## Subagent skips

- None enabled; classic single-agent loop.

## Structural deferral

- `def:project:hello` remains an isolated dead bootstrap; wiring it to physics would be false. Remove or privatize it in a later structural pass.
