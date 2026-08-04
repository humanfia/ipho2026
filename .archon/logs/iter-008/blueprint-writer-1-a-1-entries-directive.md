# Directive — `blueprint-writer` subagent `1-a-1-entries`

## Scope
Blueprint chapter `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_1_A_1.tex`
(covers Lean file `IPhO2026Problems/problem_IPhO_2026_1_A_1.lean`). You write ONLY this .tex file.

## Why
28 live Lean declarations (the full helper layer of the hydrostatic-gate formalization) have NO
blueprint entry (leandag `unmatched` bucket). Coverage-debt rule: every non-private Lean decl
gets a chapter block with `\label`, `\lean{full.Name}`, accurate `\uses{}`, ≥1-line informal proof.

## What exists on disk (planner-verified this iter, full-file read; file compiles clean, 10 sorries)
Namespace `IPhO2026_1_A_1` — exact names (grep-verified):

GROUP A — setup layer:
- `GatePlane` (abbrev): the transverse figure plane `EuclideanSpace ℝ (Fin 2)`.
- `rho0`, `a`, `DeltaH`, `g` (opaques): water density, cube side, max level difference (`Δh = 1.41` design), gravity magnitude.
- `PhysicalParameters` (structure): positivity regime `rho0_pos, a_pos, DeltaH_pos, g_pos`.
- `cubeMass` (def): `3 ρ₀ a³` (kg) — density 3ρ₀ × volume a³.
- `displacedWaterMass` (def): `ρ₀ a³` (kg).
- `slotVerticalSize` (def): `a√2/2` — the 45°-diamond slot's vertical size (Fig. 1a).
- `HingeAxis` (structure): frictionless hinge at the cube's bottom vertex O; the plane of the figure passes through O perpendicular to the hinge axis.

GROUP B — governing laws (all ASSUMED, none mentions the answer `a = Δh/(2√2)`):
- `IsWeightForce` (def Prop): `F = m·g`.
- `IsUniformGravityField` (def Prop): equal masses get equal weights wherever placed.
- `IsHydrostaticPressure` (def Prop): linear depth law `p = ρ g d`.
- `IsBuoyantForce` (def Prop): Archimedes `B = ρ₀ V g`.
- `IsNetImmersedWeight` (def Prop): `F = W − B` with the weight/buoyancy laws.
- `weightHorizontalLeverArm` (def): `(a/2)·sin(π/4) = a/(2√2)` — horizontal offset of cube centre from O at 45°.
- `PressureMomentReadout` (structure Prop): `heads_bounded : Δh ≤ a√2/2` (critical wetted regime) + net driving couple per unit axis length `τ = ρ₀ g Δh · slotVerticalSize · (a/2) · (a√2/4)`.
- `IsCriticalTorqueBalance` (def Prop): `F · weightHorizontalLeverArm = pressure couple` — moment balance about O.
- `HydrostaticGateSetup` (structure extending PhysicalParameters): uniform gravity field + hydrostatic pressure at the hinge + `pressure_readout` + `torque_balance` existential — the full assumption bundle.

GROUP C — derived quantities + bridge chain (10 sorry sites live here + target):
- `netImmersedWeight` (def): `(cubeMass − displacedWaterMass)·g`.
- `restoringMoment` (def): `netImmersedWeight · weightHorizontalLeverArm`.
- `pressureCoupleMagnitude` (def): the RHS expression of the couple.
- `net_immersed_weight_eq` (lemma, sorry): `netImmersedWeight = 2 ρ₀ a³ g`. Proof: unfold defs, ring.
- `weight_lever_arm_eq` (lemma, sorry): `weightHorizontalLeverArm = a/(2√2)`; `sin(π/4)=√2/2`, field simplification.
- `restoring_moment_eq` (lemma, sorry): `restoringMoment = ρ₀ g a⁴/√2`; combine the two above: `2ρ₀a³g · a/(2√2)`.
- `pressure_couple_eq` (lemma, sorry): `pressureCoupleMagnitude = ρ₀ g Δh a³/4`; insert `slotVerticalSize = a√2/2` and collect `√2·√2 = 2`.
- `critical_balance_eq` (lemma, sorry): from `restoringMoment = pressureCoupleMagnitude`, rewrite to `ρ₀ g a⁴/√2 = ρ₀ g Δh a³/4`.
- `pressure_couple_position_trace` (lemma, sorry): `4·(a√2/4) = a√2` — the couple arm is one quarter of the slot's vertical size (pure geometrical trace; ring).
- `side_length_eq_delta_h_over` (lemma, sorry): cancel `ρ₀ g a³ ≠ 0` from the balance, leaving `a/√2 = Δh/4` wait — actually `a = Δh/(2√2)`: `ρ₀ g a⁴/√2 = ρ₀ g Δh a³/4` ⇒ `a/√2 = Δh/4` ⇒ CHECK: `a = Δh·√2/4 = Δh/(2√2)`. Record the cancellation of `ρ₀·g·a³` and `√2² = 2`.
- `numerical_value` (lemma, sorry): at `Δh = 1.41`, `a = 0.50 ∨ |a − 0.50| < 1/200`; `1.41/(2√2) = 0.4984…`, the interval membership by `1.414 < √2 < 1.415` rational bounds.
- `hydrostatic_gate_side_length_a_target` (theorem, sorry): THE T1-A1 TARGET — from `HydrostaticGateSetup` + `Δh = 1.41` + the balance hypothesis, conclude `a = Δh/(2√2) ∧ |a−0.50| < 1/200`. The official answer `0.50 m` first appears here, conclusion-side only.
- `torque_balance_contract` (lemma, sorry): the bundled existential in `HydrostaticGateSetup` re-expressed with derived magnitudes (the consistency bridge the target consumes).

## Task
1. KEEP the existing skeleton verbatim (source paragraphs, `thm:physics:IPhO_2026_1_A_1:target`,
   the iter-002 PhysLean-exemption NOTE).
2. ADD three `\subsection*` blocks mirroring the groups above:
   `\subsection*{Setup: parameters and figure constants}`,
   `\subsection*{Governing laws (assumption side)}`,
   `\subsection*{Derivation chain to the official value}`.
   One `definition`/`lemma`/`theorem` block per declaration (struct/projections fold only if the
   parent entry literally contains them — here every declared name gets its own label, since each
   carries its own statement), with `\label{def|lem|thm:IPhO2026Problems_problem_IPhO_2026_1_A_1:<name>}`,
   `\lean{IPhO2026_1_A_1.<exact name>}`, `\uses{}` of real logical deps, a 1–3 line informal
   statement, and a 1–3 line mathematical proof (def blocks: "Definition; no claim."; the
   bridge lemmas: the one-line algebra sketched in GROUP C). NO Lean tactic names in proofs.
3. The target theorem block gets `\label{thm:IPhO2026Problems_problem_IPhO_2026_1_A_1:hydrostatic_gate_side_length_a_target}`,
   `\lean{IPhO2026_1_A_1.hydrostatic_gate_side_length_a_target}`, `\uses{}` = the bridge lemmas
   1–5+7+8 (`net_immersed_weight_eq` … `side_length_eq_delta_h_over`, `numerical_value`,
   `torque_balance_contract`) plus the setup structures, and a 3–4 line informal proof assembling
   the chain.
4. Wire `thm:physics:IPhO_2026_1_A_1:target`'s `\uses{}` to include the target label.
5. Physical-fidelity: every assumption-side block must be marked as carrying figure/governing-law
   content; the closed form `Δh/(2√2)` and `0.50` appear ONLY in `numerical_value` /
   `side_length_eq_delta_h_over` / the target theorem conclusions. The 45° geometry inputs
   (`sin(π/4)`, `a√2/2`, `a√2/4`) are figure readouts — say so explicitly in their blocks.
6. Do NOT touch other files or markers.

## Report
`.archon/task_results/blueprint-writer-1-a-1-entries.md`: list of blocks + final pins.
