# Task result — `IPhO2026Problems/problem_IPhO_2026_1_A_1.lean`

- Stage: autoformalize (physics-formalize mode), Archon iteration 001.
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_1_A_1.tex` (`% archon:physics` present), theorem node `thm:physics:IPhO_2026_1_A_1:target`.
- Source report: `reports/ipho_2026_k3/problem_IPhO_2026_1_A_1.source.json`; figure `T1_page-1.png` inspected (Fig. 1a: vertical wall MN, higher left reservoir, `Δh` between free surfaces, cube diamond-sealing the slot with side labels `a`, `√2 a` vertical diagonal, hinge O at bottom vertex).
- Acceptance check: `lake env lean IPhO2026Problems/problem_IPhO_2026_1_A_1.lean` exits 0 with **only** the 10 expected `declaration uses sorry` warnings (no errors, no other warnings).
- Blueprint chapter left untouched per prover rules; `\leanok` flagging left to the deterministic sync. The declarations below cover `thm:physics:IPhO_2026_1_A_1:target`.

## Assumption/target split

- **Governing laws (hypotheses/predicates, file `section GoverningLaws`):**
  - uniform gravity field `IsUniformGravityField` (equal masses → equal weight forces, one common `g`);
  - weight law `IsWeightForce` (`F = m g`);
  - hydrostatic linear depth law `IsHydrostaticPressure` (`p = ρ g depth`);
  - Archimedes buoyancy `IsBuoyantForce` (`B = ρ₀ V g`) and net immersed weight `IsNetImmersedWeight` (`F = W - B` with the witnesses);
  - frictionless-hinge rotational equilibrium at the critical configuration `IsCriticalTorqueBalance` (restoring moment of net immersed weight about O balances the hydrostatic couple);
  - pressure readout structure `PressureMomentReadout` (faces fully wetted `Δh ≤ slotVerticalSize`; couple magnitude equation, per unit hinge-axis length).
- **Previous-part results:** none (`previous_parts: []` in the source report; T1-A.1 is the first subquestion).
- **Figure/data readouts (Figure 1a):** opaque scalars `rho0`, `a`, `DeltaH`, `g`; cube density `3ρ₀` via `cubeMass = 3 * rho0 * a ^ 3`; displaced mass `displacedWaterMass = rho0 * a ^ 3`; slot vertical size `slotVerticalSize = a√2/2`; centre of cube `a/2` above O with horizontal lever arm `weightHorizontalLeverArm = (a/2)·sin(π/4)`; pressure couple arm `(a√2)/4` (half horizontal thickness); `PhysicalParameters` positivity structure; `HingeAxis` records the frictionless hinge at the figure-plane point O.
- **Current target conclusions (conclusion side only):** `a = Δh/(2√2)` and `|a - 0.50| < 1/200` (for `Δh = 1.41`) in `hydrostatic_gate_side_length_a_target`; the intermediate equation chain in the bridge lemmas.

## Goal-faithfulness audit

- The recorded official answer `a = Δh/(2√2) = 0.50 m` appears **only** in conclusions: `side_length_eq_delta_h_over`, `numerical_value`, and the main theorem `hydrostatic_gate_side_length_a_target`. No hypothesis, premise structure field, `Laws`-style field, or local definition mentions `2 * Real.sqrt 2` as a divisor of `DeltaH`, and nothing defines `a` as that quotient (`a` is `opaque`).
- `IsCriticalTorqueBalance` states the *physical* balance (restoring moment = hydrostatic couple with figure lever arms), not the solved form; deriving `a = Δh/(2√2)` still requires Steps 1–7 (`net_immersed_weight_eq` … `side_length_eq_delta_h_over`), all `sorry`.
- `pressure_couple_eq`, `restoring_moment_eq`, `critical_balance_eq` contain no target value: they record the force/moment magnitudes derived from the laws.
- `HydrostaticGateSetup` bundles regime + laws only; the `torque_balance` field quantifies existentially over force/couple magnitudes constrained by the law predicates — the target quotient is not assumed.
- No `axiom`/cheat: four `opaque` scalars are parameter constants (ρ₀, a, Δh, g), standard for wave-1 files; all theorem/lemma bodies are plain `by sorry`.
- I did **not** alter the blueprint chapter; `\leanok` is the sync's job (noted for review).

## Derivability and bridge obligations

| Step | Source claim | Lean carrier | Status |
|---|---|---|---|
| B1 | Net immersed weight = `2ρ₀a³g` (density 3ρ₀, full submersion, weight & buoyancy laws) | `net_immersed_weight_eq` (from `IsWeightForce`, `IsBuoyantForce`, `cubeMass`, `displacedWaterMass`) | covered (sorry) |
| B2 | Horizontal lever arm of centre about O at 45° = `a/(2√2)` | `weight_lever_arm_eq` (from `weightHorizontalLeverArm = (a/2) sin(π/4)`, `Real.sin_pi_div_four`) | covered (sorry) |
| B3 | Restoring moment = `ρ₀ g a⁴/√2` | `restoring_moment_eq` (B1 ∘ B2) | covered (sorry) |
| B4 | Hydrostatic couple = `ρ₀ g Δh (a√2/2)(a/2)((a√2)/4) = ρ₀ g Δh a³/4` | `pressure_couple_eq` (from `PressureMomentReadout.pressure_couple`) | covered (sorry) |
| B5 | Critical configuration ⇒ scalar moment balance `ρ₀ g a⁴/√2 = ρ₀ g Δh a³/4` | `critical_balance_eq` (from `IsCriticalTorqueBalance`) | covered (sorry) |
| B6 | Position trace of the couple: arm `(a√2)/4` is 1/4 of slot height; top face flush at slot lip (branch/geometry of the critical configuration) | `pressure_couple_position_trace` + `PressureMomentReadout.heads_bounded` | covered (sorry) |
| B7 | Algebra: cancel `ρ₀ g a³`, use `(√2)² = 2` ⇒ `a = Δh/(2√2)` | `side_length_eq_delta_h_over` | covered (sorry) |
| B8 | Numeric: `Δh = 1.41` ⇒ `a ≈ 0.50 m` | `numerical_value`, main theorem second conjunct `|a - 0.50| < 1/200` | covered (sorry) |
| B9 | Laws-bundle ⇒ scalar balance used by the target theorem | `torque_balance_contract`, hypothesis `hbal` of main theorem | covered (sorry) |

All bridges are locally encoded; none blocked. Main theorem carrier: `hydrostatic_gate_side_length_a_target` = direct source-to-contract mapping of the subquestion.

## Abstraction sufficiency and countermodel audit

- `IsUniformGravityField`: gives equation `F₁ = F₂` for equal masses — eliminates to a usable equality; not void (rules out position-dependent `g`).
- `IsWeightForce`, `IsHydrostaticPressure`, `IsBuoyantForce`, `IsNetImmersedWeight`: each definition unfolds to a concrete equation (`F = m g`, `p = ρ g d`, `B = ρ₀ V g`, `F = W - B` with witnesses), so proofs can `rw`/`subst`; no opaque witness-only Props.
- `PressureMomentReadout`: constrains via `heads_bounded : Δh ≤ a√2/2` (inequality) and `pressure_couple` (equation for the couple magnitude + nonnegativity). Countermodel check: interpreting `rho0, g, DeltaH, a` arbitrarily positive breaks `pressure_couple`/`heads_bounded` unless the magnitudes match, so the bundle is not vacuous.
- `IsCriticalTorqueBalance`: a single scalar equation tying `F`, arms, and the couple; under countermodel assignment of `a` the equation fails unless the balance holds — the contract is determined.
- `HydrostaticGateSetup.torque_balance`: existential over `τ F` *constrained* by the two law predicates — a later proof eliminates it to the scalar balance (via `torque_balance_contract`); it is not an unconstrained “there exists a relation with a witness”.
- `HingeAxis.axis_perpendicular_to_plane : origin = origin` is carried by `rfl`; it records only that the axis pierces the figure plane at O (no substantive physics claimed).
- Countermodel audit on the whole bundle: with `a` interpreted as any positive real ≠ `Δh/(2√2)`, the simultaneous constraints `net_immersed_weight_eq`, balance, and couple equations are inconsistent — so the target equation is genuinely forced, not unfolded.

## Uncertainty and branch coverage

- **Uncertainty:** `not applicable` — the source reports exact values (`Δh = 1.41 m`, answer `0.50 m`); no `±` uncertainty is given. The numeric contract keeps an honest precision clause `|a - 0.50| < 1/200` (rounding of `1.41/(2√2) = 0.4981…` to the stated 3-s.f. answer) instead of asserting false exact equality `a = 0.50`.
- **Branch/orientation:** **covered** — clockwise (pressure) vs anticlockwise (weight restoring) torques are distinguished in `IsCriticalTorqueBalance` docstring and the moment equation; the critical-branch geometry (top face flush at the slot's upper lip, both faces fully wetted) is encoded by `PressureMomentReadout.heads_bounded : Δh ≤ slotVerticalSize` and `pressure_couple_position_trace`; the 45° diamond orientation by `weightHorizontalLeverArm` and `slotVerticalSize`.

## Declarations created (blueprint label)

All under namespace `IPhO2026_1_A_1`; covering `thm:physics:IPhO_2026_1_A_1:target`:
- Setup/geometry: `GatePlane`, `rho0`, `a`, `DeltaH`, `g`, `PhysicalParameters`, `cubeMass`, `displacedWaterMass`, `slotVerticalSize`, `HingeAxis`.
- Laws: `IsWeightForce`, `IsUniformGravityField`, `IsHydrostaticPressure`, `IsBuoyantForce`, `IsNetImmersedWeight`, `weightHorizontalLeverArm`, `PressureMomentReadout`, `IsCriticalTorqueBalance`, `HydrostaticGateSetup`.
- Derived quantities: `netImmersedWeight`, `restoringMoment`, `pressureCoupleMagnitude`.
- Bridges (all `by sorry`): `net_immersed_weight_eq`, `weight_lever_arm_eq`, `restoring_moment_eq`, `pressure_couple_eq`, `critical_balance_eq`, `pressure_couple_position_trace`, `side_length_eq_delta_h_over`, `numerical_value`, `torque_balance_contract`.
- Main theorem: `hydrostatic_gate_side_length_a_target` (`by sorry`).

## LeanExplore queries/candidates actually used

- Pre-existing grounding log `task_results/physics-grounding-IPhO2026Problems_problem_IPhO_2026_1_A_1.md` (queries `Real.sqrt square root`, `Physics formalization target`) grounded `Real.sqrt` + sibling lemmas; used names below.
- Mathlib APIs verified live via `lean_run_code` snippets: `Real.sqrt_pos.mpr`, `Real.sq_sqrt`, `Real.sqrt_sq`, `Real.sqrt_lt_sqrt`, `Real.sqrt_one`, `positivity` on `a * t * Real.sqrt 2 * (a / 2)`, `EuclideanSpace ℝ (Fin 2)` norm/inner.
- Sibling-file idioms reused (imports stay self-contained): opaque-scalar + `structure … : Prop` law-predicate pattern from `problem_IPhO_2026_1_C_1.lean` / `problem_IPhO_2026_2_B_2.lean`.

## PhysLean/Mathlib names grounded

`Real.sqrt` (and `√` arithmetic), `Real.sin (π/4)` (via `Real.sin_pi_div_four` for the proof side), `EuclideanSpace ℝ (Fin 2)`, `Set.Icc/Ioo` (not needed in the end), `|·|` abs. No PhysLean object used: PhysLean is mechanics/QFT-oriented and has no hydrostatics/torque module (near-miss recorded below).

## Local abstractions introduced and why they preserve physical meaning

- `GatePlane` = Euclidean 2-space (figure plane), matching the translational invariance along the hinge axis; kept abstract-intrinsic like sibling files (`ReactionPlane`, `Plane`).
- `opaque rho0, a, DeltaH, g` — physical scalars with SI roles; scalar opacity prevents proving things by unfolding while their *roles* (density, length, head, field strength) are fixed by the law predicates that use them.
- `HingeAxis` — the frictionless hinge at point O with axis perpendicular to the figure plane (figure label).
- Law predicates listed above — each states a *physical law relation* with eliminable equations, none restates the final formula.
- `cubeMass/displacedWaterMass/slotVerticalSize/weightHorizontalLeverArm` — derived geometric/mass quantities from the figure, not the answer.

## Grounding gaps / notes

- No hydrostatics (pressure-vs-depth, Archimedes, torque about a hinge) exists in Mathlib/PhysLean — recorded as a grounding gap and encoded locally as law predicates, per the physics modeling rules.
- Environment quirk worth memory: this toolchain's term parser rejects Unicode `−` (U+2212 MINUS SIGN) in *code* (fine in comments); ASCII `-` required. Related: the wave-1 `problem_IPhO_2026_1_C_1.lean` currently on disk does **not** `lake env lean`-compile (`ℏannotated`/`where`-in-field parse errors) — flagging to the plan agent, out of my lane to fix.
- Redraft requests: none. The blueprint chapter is minimal but sufficient (context + answer + figure pointer); the plan agent may flesh out the informal derivation later (weight/buoyancy torque-balance steps B1–B7 above are the informal chain).
