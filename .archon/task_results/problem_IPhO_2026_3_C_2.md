# Task result: `IPhO2026Problems/problem_IPhO_2026_3_C_2.lean` (K3 redraft + proof, 2026-08-04)

Status: **complete — process-kind swap corrected, full file proved, zero `sorry`.**

## Corrected physical assignment (official IPhO 2026 T3)

Sources: `T3_problem.txt`, `T3_solution.txt` (T3-C1/C2), `T3_marking_scheme.txt`,
page image `T3_page-3.png` (Figure 3b: legs 2→3 and 4→1 vertical in the H–T
plane), and the proved sibling contract `problem_IPhO_2026_3_C_1.lean` (iter-017).

- **T₁ = T₄ = Tₕ** (hot reservoir), **T₂ = T₃ = T_c** (cold reservoir).
- Legs **1→2** (H decreasing) and **3→4** (H increasing) are **adiabatic** — no heat
  transferred (`heat_12_zero`, `heat_34_zero`).
- Leg **2→3** is **isothermal at T_c**, field decreasing; the torus absorbs heat:
  heat into torus **+Q_c** (`heat_23`).
- Leg **4→1** is **isothermal at Tₕ**, field increasing; the torus delivers heat:
  heat into torus **−Qₕ** (`heat_41`).

The previous file had the isothermal/adiabatic legs swapped (isothermal 1→2/3→4,
adiabatic 2→3/4→1), which made the "adiabatic" legs connect same-temperature
states, collapsed the leg laws to M₁=M₄, M₂=M₃, and left the `q_relation` bridge
unprovable (old `sorry`). The redraft removes `AdiabaticLegStateLaw`,
`IsothermalHeatQForm`, `q`, `q_relation`, `q4_eq_adiabatic_41`, `q3_eq` and the
unused `Cv` parameter; the official C.2 route needs no adiabatic-leg state law.

## Main theorem (name and conclusion preserved)

`IPhO2026.Problem3.C2.CarnotMagnetizationModel.m1_eq_sqrt :
  m.M1 = Real.sqrt (m.M2 ^ 2 - m.M3 ^ 2 + m.M4 ^ 2)`

The official answer appears only in theorem conclusions (`sq_diff_eq`, `m1_sq`,
`m1_eq_sqrt`, `m1_sq_arg_nonneg`), never among the model's hypothesis fields.

## Proof route (official C.2 derivation)

1. `IsothermalHeatIntoTorus.magnetization_form` — EOS-substituted B.1 law: along an
   isothermal leg at T, `Q = A·T·(M_i² − M_f²)` with `A = μ₀V²/(2nK)`. Proof:
   `H = TMV/(nK)` at both endpoints (`eq_div_iff` + `linear_combination -heos`),
   then `field_simp [hn, hK, hT]; ring`.
2. `Qc_eq : Qc = A·Tc·(M2² − M3²)` — bridge applied to `heat_23` (leg 2→3 at T_c,
   EOS rewritten by Figure-3b's `T v2 = Tc`, `T v3 = Tc`).
3. `Qh_eq : Qh = A·Th·(M1² − M4²)` — bridge applied to `heat_41` (leg 4→1 at Tₕ),
   giving `−Qh = A·Th·(M4² − M1²)`, negated by `linear_combination -h`.
4. `sq_diff_eq : M2² − M3² = M1² − M4²` — substitute `Qc_eq`/`Qh_eq` into the
   Carnot magnitude relation `Qh·Tc = Qc·Th` (`carnot_ratio`), cancel the positive
   factor `A·Th·Tc` via `mul_left_cancel₀` (`linear_combination -hratio` for the
   scaled identity).
5. `m1_sq : M1² = M2² − M3² + M4²` — `linear_combination -(sq_diff_eq)`.
6. `m1_eq_sqrt` — `rw [← m.m1_sq, Real.sqrt_sq (m.M_nonneg .v1)]` (nonnegative root,
   M₁ a magnitude). `m1_sq_arg_nonneg` — radicand `= M1² ≥ 0`.

## Verification evidence

- `lake env lean IPhO2026Problems/problem_IPhO_2026_3_C_2.lean` — run twice fresh:
  **exit 0, zero bytes of output** (no errors, no warnings, no `sorry` admissions).
- LSP `lean_diagnostic_messages` on the file: `{"success":true,"items":[]}` — no
  diagnostics of any severity.
- Source scan (ripgrep) for `sorry|admit|axiom|unsafe|native_decide|sorryAx`:
  **no matches** — sorry count **0**.
- `lean_verify` on `IPhO2026.Problem3.C2.CarnotMagnetizationModel.m1_eq_sqrt`:
  axioms **`[propext, Classical.choice, Quot.sound]`** only (standard Mathlib
  axioms; no `sorryAx`, no new axioms), warnings `[]`. This covers the whole
  dependency chain (`m1_sq` ← `sq_diff_eq` ← `Qc_eq`/`Qh_eq` ←
  `magnetization_form`).

## Files updated

- `IPhO2026Problems/problem_IPhO_2026_3_C_2.lean` — redrafted and fully proved
  (namespace `IPhO2026.Problem3.C2`, main theorem name/statement preserved).
- `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_3_C_2.tex` — rewritten
  to describe exactly the corrected official route and the new declaration list
  (swap correction recorded in the chapter's REDRAFT NOTE).
- `.archon/task_results/problem_IPhO_2026_3_C_2.md` — this report.

## Notes for future lanes

- `Figure3bAssignment` now matches `problem_IPhO_2026_3_C_1.lean`'s proved contract
  (isothermal 2→3 @ Tc, 4→1 @ Th; adiabatic 1→2, 3→4). Any further 3_C_* file must
  reuse this assignment.
- Tactic notes: the EOS elimination `H = TMV/(nK)` inside divisions is cleanest via
  `rw [eq_div_iff hnK]; linear_combination -heos'`; the final rational identity
  closes with `field_simp [hn, hK, hT]` (atomic ≠0 facts) followed by `ring`.
