# Parallel Lean Review Preflight

- Iteration: 003
- Jobs: 1
- Duration: 10.287s
- Result: 0 passed / 1 failed

| Target | Compile | Sorries | Seconds |
| --- | ---: | ---: | ---: |
| `IPhO2026Problems/problem_IPhO_2026_1_B_1.lean` | failed | 5 | 10.280 |

## `IPhO2026Problems/problem_IPhO_2026_1_B_1.lean` diagnostics
```text
IPhO2026Problems/problem_IPhO_2026_1_B_1.lean:137:8: warning: declaration uses `sorry`
IPhO2026Problems/problem_IPhO_2026_1_B_1.lean:319:8: warning: declaration uses `sorry`
IPhO2026Problems/problem_IPhO_2026_1_B_1.lean:361:8: warning: declaration uses `sorry`
IPhO2026Problems/problem_IPhO_2026_1_B_1.lean:401:4: error: linarith failed to find a contradiction
hR : ScalingRegime
D : CoulombPairData hR
hm : 0 < D.reduced_mass
r : ℝ
hr : coulombK * elementaryCharge ^ 2 / -D.total_energy ≤ r
hE : D.total_energy < 0
hneg : 0 < -D.total_energy
he : elementaryCharge ≠ 0
hnum_pos : 0 < coulombK * elementaryCharge ^ 2
hr_pos : 0 < r
hnn : 0 ≤ coulombK * elementaryCharge ^ 2
hmul : coulombK * elementaryCharge ^ 2 ≤ r * -D.total_energy
hcast : D.total_energy * r = -(r * -D.total_energy)
a✝ : -(r * -D.total_energy) + coulombK * elementaryCharge ^ 2 < 0
⊢ False
failed
IPhO2026Problems/problem_IPhO_2026_1_B_1.lean:404:4: warning: `push_neg` has been deprecated. Prefer using `push Not` instead.
If you'd rather continue using `push_neg` in your project, you can implement it as follows:
```
open Lean.Parser.Tactic in
macro "push_neg" cfg:optConfig loc:(location)? : tactic =>
  `(tactic| push $cfg:optConfig Not $[$loc]?)
```
IPhO2026Problems/problem_IPhO_2026_1_B_1.lean:419:4: error: linarith failed to find a contradiction
hR : ScalingRegime
D : CoulombPairData hR
hm : 0 < D.reduced_mass
r : ℝ
hr : coulombK * elementaryCharge ^ 2 / -D.total_energy ≤ r
hE : D.total_energy < 0
hneg : 0 < -D.total_energy
he : elementaryCharge ≠ 0
hnum_pos : 0 < coulombK * elementaryCharge ^ 2
hr_pos : 0 < r
hnn : 0 ≤ coulombK * elementaryCharge ^ 2
hkey : 0 ≤ D.total_energy * r + coulombK * elementaryCharge ^ 2
hnotpos : D.total_angular_momentum ^ 2 / (2 * D.reduced_mass) ≤ 0
hinit_pos : 0 < D.initial_separation
hterm : D.total_energy * D.initial_separation ^ 2 < 0
hcoul : 0 < coulombK * elementaryCharge ^ 2 * D.initial_separation
hnonneg_L : 0 ≤ D.total_angular_momentum ^ 2 / (2 * D.reduced_mass)
hL0 : D.total_angular_momentum ^ 2 / (2 * D.reduced_mass) = 0
hturn : D.total_energy * D.initial_separation ^ 2 + coulombK * elementaryCharge ^ 2 * D.initial_separation = 0
⊢ False
failed
IPhO2026Problems/problem_IPhO_2026_1_B_1.lean:427:2: error: linarith failed to find a contradiction
hR : ScalingRegime
D : CoulombPairData hR
hm : 0 < D.reduced_mass
r : ℝ
hr : coulombK * elementaryCharge ^ 2 / -D.total_energy ≤ r
hE : D.total_energy < 0
hneg : 0 < -D.total_energy
he : elementaryCharge ≠ 0
hnum_pos : 0 < coulombK * elementaryCharge ^ 2
hr_pos : 0 < r
hnn : 0 ≤ coulombK * elementaryCharge ^ 2
hkey : 0 ≤ D.total_energy * r + coulombK * elementaryCharge ^ 2
hL : 0 < D.total_angular_momentum ^ 2 / (2 * D.reduced_mass)
hexpand :
  D.turningQuadratic r =
    r * (D.total_energy * r + coulombK * elementaryCharge ^ 2) - D.total_angular_momentum ^ 2 / (2 * D.reduced_mass)
hnonneg : 0 ≤ r * (D.total_energy * r + coulombK * elementaryCharge ^ 2)
a✝ :
  r * (D.total_energy * r + coulombK * elementaryCharge ^ 2) - D.total_angular_momentum ^ 2 / (2 * D.reduced_mass) ≤ 0
⊢ False
failed
IPhO2026Problems/problem_IPhO_2026_1_B_1.lean:441:2: warning: `push_neg` has been deprecated. Prefer using `push Not` instead.
If you'd rather continue using `push_neg` in your project, you can implement it as follows:
```
open Lean.Parser.Tactic in
macro "push_neg" cfg:optConfig loc:(location)? : tactic =>
  `(tactic| push $cfg:optConfig Not $[$loc]?)
```
IPhO2026Problems/problem_IPhO_2026_1_B_1.lean:563:8: warning: declaration uses `sorry`
IPhO2026Problems/problem_IPhO_2026_1_B_1.lean:576:8: warning: declaration uses `sorry`
```
