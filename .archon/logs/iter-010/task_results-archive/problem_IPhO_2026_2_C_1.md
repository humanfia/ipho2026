# Prover task result: IPhO2026Problems/problem_IPhO_2026_2_C_1.lean

- Lean file: `IPhO2026Problems/problem_IPhO_2026_2_C_1.lean`
- Blueprint chapter: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_2_C_1.tex`
- Archon iteration: 010 (prover stage)
- Status: **COMPLETE — all 4 `sorry` placeholders closed; file compiles with 0 errors, 0 warnings** (no `sorry`, no `axiom`, no `native_decide`).

## Declarations proved

1. `HalfCylindricalMirrorReflection.slope_reflection_key` (new **private** helper theorem; proof body only — signatures of the four contracted theorems untouched):
   `2 * s.m_A θ * sin θ * cos θ = cos θ ^ 2 - sin θ ^ 2`.
   Route: take clause 3 of `reflection_law` (`hNorm`), substitute the Figure-2g readout `P_eq`, clear the denominator `R * sqrt (m_A θ ^ 2 + 1)` via `div_eq_iff` + `mul_div_cancel_left₀`-style field algebra, square (`congrArg (· ^ 2)` + `Real.sq_sqrt`), factor out and cancel the positive `R ^ 2`, `linear_combination`.
   The sign ambiguity normally introduced by squaring is absent here because the cleared equation has *positive* `sqrt` on the right and the law itself fixes orientation (outgoing clause unused but consistent).
2. `reflected_ray_A_slope`: `s.m_A θ = cot (2 * θ)` — from the key equation via `sin_two_mul`, `cos_two_mul'`, `cot_eq_cos_div_sin`, `eq_div_iff` (nonzero `sin (2θ) = 2 sinθ cosθ` on the acute branch from `θ_branch`), closed by `linear_combination`.
3. `reflected_ray_A_intercept`: `s.b_A θ = s.R / (2 * cos θ)` — clause 1 of `reflection_law` (line passes through the reflection point) + the proved slope value + `sin_sq_add_cos_sq`, `field_simp`, `linear_combination`.
4. `intercept_is_length`: `∃ L, L = R/(2 cos θ) ∧ b_A θ = L` — exhibits `L := R/(2 cos θ)` with the proved intercept value. Moved *after* `reflected_ray_A_intercept` in the file (body-only reorder; no signature change) because an anonymous-constructor projection over a later-in-namespace declaration fails to elaborate.
5. `reflected_ray_A_slope_and_intercept`: conjunction of the two bridge theorems.

## Verification

- Fresh `lake env lean IPhO2026Problems/problem_IPhO_2026_2_C_1.lean`: `EXIT=0`, no output (no errors, no sorry-warnings).
- `grep sorry|admit|axiom` on the file: clean.

## Faithfulness notes

- The formalized `reflection_law` hypotheses are used exactly as stated (clause 1 `P_y = m P_x + b`, clause 3 normal-angle, `P_eq` readout, `θ_branch` for angle signs). The recorded official answers `m_A = cot 2θ`, `b_A = R/(2 cos θ)` are derived, not assumed.
- The tangential clause 4 and outgoing clause 5 of `reflection_law` are not needed for the derivation (clause 3 + point-on-line + branch signs suffice and are strictly stronger than the unsigned quadratic); they remain available for the C.2–C.4 parts. No weakening: conclusions are the exact contracted equalities.

## Blueprint markers

Ready for `\leanok` (deterministic sync) on:
- `def:...:HalfCylindricalMirrorReflection` (structure, unchanged),
- `lem:...:intercept_is_length`,
- `thm:...:reflected_ray_A_slope`,
- `thm:...:reflected_ray_A_intercept`,
- `thm:...:reflected_ray_A_slope_and_intercept`.
The new private helper `slope_reflection_key` has no blueprint block (private; not a contract item).

## Redraft needed

None. Statement proved as contracted.
