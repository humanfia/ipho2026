# Independent K3 review: `problem_IPhO_2026_3_C_2` (IPhO 2026 T3-C.2)

Formalization verdict: passed
Proof verdict: solved

Reviewer: independent Kimi K3 reviewer, 2026-08-04. Files audited read in full:
`reports/ipho_2026_k3/problem_IPhO_2026_3_C_2.source.json`, `T3_problem.txt`,
`T3_solution.txt`, `T3_marking_scheme.txt`, `image/T3_page-3.png`,
`IPhO2026Problems/problem_IPhO_2026_3_C_2.lean`,
`blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_3_C_2.tex`,
`.archon/task_results/problem_IPhO_2026_3_C_2.md`.

## 1. Figure 3b assignment and heat signs vs. official C.1/C.2 — MATCH

Official evidence:
- `T3_solution.txt` T3-C2: "we have Qc = |Q2→3| = Q2→3 and Qh = |Q4→1| = −Q4→1",
  "Qc = −µ0(nK/Tc)(H3²−H2²)/2 = µ0(nK/Tc)(H2²−H3²)/2",
  "Qh = −(−µ0(nK/Th)(H1²−H4²)/2) = µ0(nK/Th)(H1²−H4²)/2",
  "where Tc = T2 = T3 and Th = T4 = T1 are the respective temperatures of the
  isothermal processes 2 → 3 and 4 → 1".
- Page image `T3_page-3.png` (Fig. 3b): H vertical, T horizontal; vertices 2,3
  on the left vertical leg (lower T), vertices 1,4 on the right vertical leg
  (higher T). Vertical legs 2→3 and 4→1 are the isothermal legs; curved legs
  1→2 (H decreasing) and 3→4 (H increasing) are adiabatic. On 2→3 the field
  decreases (H2 > H3); on 4→1 it increases (H1 > H4).
- Recorded C.1 conclusion (source.json `previous_parts[1]`): "States 1 and 4
  lie at T_h; states 2 and 3 lie at T_c. Q_c is absorbed on 2->3, and Q_h is
  delivered on 4->1." Matches the sibling contract noted in memory.

Lean evidence (`problem_IPhO_2026_3_C_2.lean`):
- `Figure3bAssignment` (lines 218–221): `T v1 = Th ∧ T v4 = Th ∧ T v2 = Tc ∧
  T v3 = Tc ∧ proc12 = adiabatic true ∧ proc23 = isothermal true ∧
  proc34 = adiabatic false ∧ proc41 = isothermal false` — exactly the official
  assignment, including field directions (`true` = decreasing: 1→2, 2→3;
  `false` = increasing: 3→4, 4→1), all consistent with the figure.
- Heat signs: `heat_23` (line 267) attaches the B.1 law on leg 2→3 at `Tc`
  with heat **+Qc** into the torus; `heat_41` (line 271) attaches it on leg
  4→1 at `Th` with heat **−Qh** into the torus. Unfolding
  `IsothermalHeatIntoTorus` (line 166, Q = −(µ0nK/(2T))(Hf²−Hi²), verbatim the
  official B.1 formula) gives Qc = µ0(nK/Tc)(H2²−H3²)/2 and
  Qh = µ0(nK/Th)(H1²−H4²)/2 — identical to the official C.2 pair above,
  signs included. `Tc_lt_Th : Tc < Th` matches the refrigeration orientation.
- Sign consistency is physically realizable (not vacuous): official C.3 numbers
  H2 = 311306 > H3 = 204618 give Qc = 1.29×10⁻¹ J > 0, as the solution computes.

## 2. Official C.2 derivation faithfully represented — YES

Every step of the official solution is a named carrier:
1. B.1 + EOS on both isothermal legs: `IsothermalHeatIntoTorus.magnetization_form`
   (line 181) proves Q = A·T·(Mi²−Mf²), A = µ0V²/(2nK), from EOS
   `T·M·V = n·K·H` (line 155, verbatim the table's EOS). Instantiated per leg:
   `Qc_eq` (line 313): Qc = A·Tc·(M2²−M3²); `Qh_eq` (line 337):
   Qh = A·Th·(M1²−M4²). These equal the official
   Qc = µ0(nK/Tc)(H2²−H3²)/2 and Qh = µ0(nK/Th)(H1²−H4²)/2 after substituting
   H = TMV/(nK) — the official "Since, by the equation of state, M = nKH/TV"
   step.
2. Carnot ratio: `CarnotHeatRatio` (line 208): `Qh·Tc = Qc·Th`, i.e. the
   official "Qc/Qh = Tc/Th" in sign-free magnitude form, exactly as the
   official solution uses it.
3. Cancellation: `sq_diff_eq` (line 357) substitutes `Qh_eq`/`Qc_eq` into
   `carnot_ratio` and cancels the positive factor A·Th·Tc via
   `mul_left_cancel₀` — the official "after substitution and simplification".
4. Squared relation: `m1_sq` (line 377): M1² = M2²−M3²+M4².
5. Nonnegative root: `m1_eq_sqrt` (line 388): M1 = √(M2²−M3²+M4²), proved by
   `Real.sqrt_sq (m.M_nonneg .v1)` — the official final line
   "M1 = √(M2²−M3²+M4²)" with the magnitude (nonnegative) branch, plus the
   consistency consequence `m1_sq_arg_nonneg` (radicand ≥ 0).
Marking-scheme coverage (C2 rubric, 1.5 pts): correct heat signs (heat_23,
heat_41), vertex temperatures (figure3b), Carnot's relation (carnot_ratio),
EOS simplification (magnetization_form), final expression (m1_eq_sqrt) — all
five rubric items have explicit Lean carriers.

## 3. Answer not assumed; target not weakened — CONFIRMED

Every hypothesis-side field of `CarnotMagnetizationModel` (lines 233–277) was
audited: reservoir data, figure assignment, per-vertex EOS, per-leg B.1 heat
laws (in H, not M), zero-heat adiabatic legs, Carnot heat ratio, positivity
witnesses. No field states M1² = M2²−M3²+M4², M2²−M3² = M1²−M4², or any
equation among the four M's; the EOS fields are per-vertex only. The official
answer appears exclusively in theorem conclusions (`sq_diff_eq`, `m1_sq`,
`m1_eq_sqrt`, `m1_sq_arg_nonneg`). The main target is the exact official
answer `M1 = Real.sqrt (M2^2 - M3^2 + M4^2)` — compiled goal confirmed by LSP:
`⊢ m.M1 = √(m.M2 ^ 2 - m.M3 ^ 2 + m.M4 ^ 2)`; no trivialization, no stronger
hypothesis than the official inputs (B.1 law, EOS, Carnot identity, figure
data — all of which the official solution itself assumes/reuses).

## 4. Hypotheses honest and sufficient — CONFIRMED

- Honest: B.1 law flagged as assumed previous-part result (per source.json
  policy `natural_language_prerequisite_only`); Carnot ratio flagged as the
  assumed second-law input; EOS as the problem-table governing law; figure
  assignment as the C.1 prerequisite. All documented as assumptions in
  docstrings.
- Sufficient: the derivation chain closes with no additional physics (no
  adiabatic-leg state law needed — correct, since the official C.2 solution
  never uses one; the redraft correctly removed that machinery).
- Branch/sign/positivity: process kinds with field-direction flags preserve
  figure branch data; heats carried signed into the torus with magnitudes
  Qh, Qc ≥ 0; `Th_pos`, `Tc_pos`, `Tc_lt_Th`, `H_nonneg`, `M_nonneg` supply
  every side condition the proof uses (`ne_of_gt` for divisions, `sqrt_sq`
  for the root, `mul_left_cancel₀` for cancellation of A·Th·Tc > 0).
- Units: all quantities are ℝ scalars with documented dimensional roles
  (kelvin, joule, A/m, mol, m³) in docstrings — standard for this pipeline.

## 5. Compile / sorry / axiom evidence (independently rerun this review)

- Fresh compile: `lake env lean IPhO2026Problems/problem_IPhO_2026_3_C_2.lean`
  → **exit 0, zero bytes of output** (no errors, warnings, or sorry
  admissions), ~10 s wall.
- Forbidden-token scan (sorry|admit|axiom|unsafe|native_decide|sorryAx|
  nativeDecide) over the whole file: **no matches**.
- LSP `lean_diagnostic_messages`: `{"success":true,"items":[]}` — zero
  diagnostics of any severity across the file.
- `lean_verify` on `IPhO2026.Problem3.C2.CarnotMagnetizationModel.m1_eq_sqrt`:
  axioms **`[propext, Classical.choice, Quot.sound]`** only — the three
  standard Mathlib axioms; no `sorryAx`, no custom axioms; warnings `[]`.
  This covers the full dependency chain (m1_eq_sqrt ← m1_sq ← sq_diff_eq ←
  Qc_eq/Qh_eq ← magnetization_form).
- Compiled goal spot-checks: line 357 goal `M2²−M3² = M1²−M4²`, line 388 goal
  `M1 = √(M2²−M3²+M4²)` — statements as advertised.

## 6. Blueprint and task result vs. Lean file — AGREE

- Blueprint `.tex` covers all 18 non-private declarations of the file
  (ProcessKind, Vertex, CarnotCycle, TorusParams, EquationOfStateParamagnet,
  IsothermalHeatIntoTorus, magnetization_form, CarnotHeatRatio,
  Figure3bAssignment, CarnotMagnetizationModel, M1–M4 abbrevs, vertex_T_pos,
  Qc_eq, Qh_eq, sq_diff_eq, m1_sq, m1_eq_sqrt, m1_sq_arg_nonneg) with
  `\lean` names matching the actual fully-qualified Lean names; `\uses` edges
  and proof sketches match the real carriers; the recorded-answer paragraph
  and the redraft note (process-kind swap corrected) match the file's header
  note verbatim in substance.
- Task result `.md` claims (corrected assignment, proof route, exit-0 compile
  with zero output, zero diagnostics, zero sorry, standard-axiom verify) were
  each independently reproduced in this review (sections 1, 5). No
  discrepancies found.

## Findings

None. No defects, no smuggled hypotheses, no weakened target, no verification
gaps. (Observed, non-blocking: the `isFieldDecreasing` flags in `ProcessKind`
are inert figure data that no hypothesis ties to the actual `Hmag` ordering;
they document branch information only and cannot create inconsistency. The
official solution likewise reads directions from the figure without a formal
constraint.)

## Gate-ready reason

This file is a faithful, fully proved formalization of IPhO 2026 T3-C.2.
The Figure-3b assignment (isothermal legs 2→3 at Tc with +Qc in, 4→1 at Th
with −Qh in; adiabatic legs 1→2, 3→4) and both heat signs match the official
solution text, the official page image, and the recorded C.1 conclusion
exactly; the proof replays the official derivation step-for-step (B.1 law +
EOS per isothermal leg → Carnot magnitude ratio → cancellation of the
positive factor A·Th·Tc → M1² = M2²−M3²+M4² → nonnegative root), with the
answer confined to theorem conclusions and never assumed; the hypotheses are
exactly the official inputs with all needed positivity/sign/branch side
conditions; and the file independently re-verified clean in this review:
fresh `lake env lean` exit 0 with zero output, zero LSP diagnostics, zero
forbidden tokens, and `lean_verify` reporting only the standard Mathlib
axioms `[propext, Classical.choice, Quot.sound]` for the main theorem
`CarnotMagnetizationModel.m1_eq_sqrt : M1 = √(M2²−M3²+M4²)`. Blueprint and
task result agree with the file. Gate: **pass — formalization passed, proof
solved.**
