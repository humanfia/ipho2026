# Refactor Report

## Slug
3-b-2-redraft-invariant-fix (iter-014, mandatory statement redraft, formalization-gate retry 3/3)

## Status
COMPLETE — the false contract is repaired exactly as directed; **all three sorries are now closed** (sorry count 0, better than the ≤ 1 the gate required); `lake env lean` reports **0 errors, 0 warnings**, and the main-theorem statement is byte-identical.

## Changes Made (only `IPhO2026Problems/problem_IPhO_2026_3_B_2.lean` touched)

### 1. Header comment (top of file)
Replaced the stale derivation sketch (`C_M dT = −μ₀VH dM`, `dT/T = −(μ₀K/λ)H dH`, product-invariant endpoint identity) with the official one: quotes "For adiabatic processes, the first law yields to dU = dW", the separated form `nλ dT/T³ = μ₀V²M dM/(nK)`, the integrated identity `λ/T_i² − λ/T_f² = μ₀K(H_f²/T_f² − H_i²/T_i²)`, the conservation of `(λ + μ₀KH²)/T²`, and the corrected endpoint placement `T_f²(λ + μ₀KH_i²) = T_i²(λ + μ₀KH_f²)`.

### 2. Imports
Added `import Mathlib.Analysis.Calculus.Deriv.Inv` (needed for `deriv_fun_div` / `deriv_fun_inv''` — the file previously only imported `Deriv.Mul/Pow/Add`, and the redrafted invariant now divides by `T²`).

### 3. `IsAdiabaticPath` (sign fix)
- Body: last clause `Cm t * deriv (fun s => (p s).temperature) t = -w t` → `… = w t` (PLUS, `dU = dW` for δQ=0).
- Docstring: rewritten; quotes verbatim "For adiabatic processes, the first law yields to dU = dW" (T3-B.2 official solution).

### 4. `adiabaticInvariant` (invariant fix)
- Body: `T ^ 2 * (params.lam + params.mu0 * params.K * H ^ 2)` → `(params.lam + params.mu0 * params.K * H ^ 2) / T ^ 2`.
- Docstring updated (conserved quantity `(λ + μ₀KH²)/T²`, with the official integrated identity quoted).

### 5. `adiabatic_invariant_along_path` (bridge lemma 1 — statement shape unchanged, `sorry` REMOVED)
Conclusion unchanged (`adiabaticInvariant … t₁ = adiabaticInvariant … t₂`). The whole derivation context was reused: `hHfun`/`hHdiff` (H differentiable via EOS), `hderiv_eos` (differentiated EOS), `hBdiff`/`hBderiv` (chain rule for the bracket), `e1` (first law), `e2` (EOS differentiated via `deriv_const_mul` + `deriv_fun_mul` × 2). New material:
- `hFdiff`: differentiability of `(B s)/(T s)²` via `(hBdiff t).div ((hTdiff t).pow 2) …`.
- `hderiv_expand`: quotient-rule expansion via `deriv_fun_div` (denominator `(T²)²`).
- The `sorry`/REDRAFT-BLOCKER block replaced by an honest close: cleared first law `hFL : nλṪ = μ₀VHṀ·T²` (from `e1` × `T²`, `T² ≠ 0`), directed zero-differences `hFLz`, `e2z`, `heosz` (directed so that `linear_combination`…see below), then after `rw [div_eq_iff hT4]` a two-step `calc`:
  ```
  numerator = (-2T·n⁻¹)·(hFLz-diff) + (-2μ₀H·T²·n⁻¹)·(e2z-diff)
            + (-2μ₀H·T·Ṫ·n⁻¹)·(heosz-diff)   := by field_simp [hn0]; ring
          = 0 * (T²)²                          := by rw [hFLz, e2z, heosz]; ring
  ```
  This is the exact algebraic shadow of the official separation: the numerator
  `c·H′·T² − B·(2T·T′)` of `d/dt[B/T²]` equals
  `-(2T/n)(nλṪ − μ₀VHṀT²) − (2μ₀HT²/n)(V(ṪM+TṀ) − nKḢ) − (2μ₀HTṪ/n)(nKH − TMV)`
  (verified symbolically: identically 0 given the three premises).
  Constancy via `is_const_of_deriv_eq_zero hFdiff hzero t₁ t₂`, then `simpa [adiabaticInvariant]`.

**Mathematical caveat discovered en route (important for the blueprint):** along ONE adiabatic path (M(t) is not free — it is slaved to T(t) by the first law), the invariant is conserved; but at a *single point* the three scalar equations (first law, EOS value, differentiated EOS) do NOT by themselves force the numerator to vanish unless the EOS *value* (`heosz`, not just its derivative `e2z`) is used — the differentiated EOS alone admits the counterterm `H·M′·(nK − TV)`. Our proof uses all three; the pre-redraft derivation context (which only carried `e1` + differentiated EOS) was genuinely insufficient, exactly matching the iter-013 review's countermodel analysis.

### 6. `endpoint_relation` (brackets swapped, `exact h` → cross-multiplied)
- Statement: `Tf ^ 2 * (lam + mu0*K*Hf^2) = Ti^2 * (lam + mu0*K*Hi^2)` → `Tf ^ 2 * (lam + mu0*K*Hi^2) = Ti^2 * (lam + mu0*K*Hf^2)` (INITIAL bracket on `Tf²`, FINAL bracket on `Ti²`).
- Body: same `obtain` + `adiabatic_invariant_along_path … tf t0` + `simp only [adiabaticInvariant, …]`, then cross-multiplication with `hTi2 := pow_ne_zero 2 hendpoints.Ti_pos.ne'` and `hTf2` derived from `laws.temp_pos tf` via `hTf` (as the directive anticipated), closing with `rw [div_eq_div_iff hTf2 hTi2] at h; linear_combination -h`.
- Docstring updated.

### 7. `adiabatic_temperature_change` (main theorem — statement BYTE-IDENTICAL)
Only the `hratio_sq` block was repaired for the corrected `hrel`:
- deleted the stale `hTf2` substitution dance + wrong-shaped `e`/`linear_combination e`;
- comments re-keyed to `hrel : Tf²·A = Ti²·B`, `Tf² = Ti²·B/A`, `(Tf/Ti)² = B/A`;
- proof is now `field_simp [ha, hb, (pow_pos hTi 2).ne']; linear_combination hrel` (bytes of the rest of the theorem — `hratio_nonneg`, `Real.sqrt_sq`, `hratio`, final `linarith` — unchanged).

### Tactic wrinkle worth recording
`linear_combination`'s ring checker canonicalizes each hypothesis use as `c * (lhs − rhs)` and reduces in the FREE commutative ring where `n⁻¹` is an atom: `n·n⁻¹` pairs do NOT cancel unless they appear textually in goal-minus-certificate. This is why bridge 1 closes via an explicit `calc` with `field_simp [hn0]` (the certificate contains `n⁻¹`s), while `endpoint_relation` needed the sign flip `-h` (the doubled atom `Int.negOfNat 2` arose from `B·Ti² − A·Tf²` being the negation of the goal difference).

## Sorry Landscape
- 0 sorries in the whole file (was 3: bridge 1 (the countermodel-blocked one), plus the two sites broken by the false contract). The directive allowed ≤ 1; the repaired contract made all three closable, so none remain.
- No new axioms, no `sorry` in `endpoint_relation` / `lam_add_mu0_K_sq_pos` / main theorem; protected declarations (`TorusParameters`, `ParamagneticTorusState`, `StatePath`, `AdiabaticEndpoints`, `ParamagneticTorusLaws` (iter-012 differentiability fields kept verbatim), `lam_add_mu0_K_sq_pos`) untouched.

## Compilation
Fresh process, final state:
```
$ lake env lean IPhO2026Problems/problem_IPhO_2026_3_B_2.lean
(no output — 0 errors, 0 warnings; sorry-grep count 0; exit 0)
```
(`grep -c sorry` on the file returns 0; `warning`-grep on the lean output returns 0.)

## Declarations deleted / renamed
None. Only bodies/docstrings changed; `endpoint_relation`'s *statement* changed exactly as mandated by the directive (the bracket swap).

## Notes for Plan Agent / blueprint transcription
- Blueprint chapter `IPhO2026Problems_problem_IPhO_2026_3_B_2.tex` should be re-keyed: first law `dU = dW` (PLUS sign, official quote "For adiabatic processes, the first law yields to dU = dW"); separated form `nλ dT/T³ = μ₀V²M dM/(nK)`; integration `(nλ/2)(1/T_i² − 1/T_f²) = μ₀(V²/(2nK))(M_f² − M_i²)`; simplification `λ/T_i² − λ/T_f² = μ₀K(H_f²/T_f² − H_i²/T_i²)` via `M = nKH/(TV)`; hence `T_f²/T_i² = (λ + μ₀KH_f²)/(λ + μ₀KH_i²)`.
- The bridge-lemma proof is the Lean image of that separation: `d/dt[(λ+μ₀KH²)/T²] = −(2T/n)(first law cleared) − (2μ₀HT²/n)(dEOS) − (2μ₀HT·Ṫ/n)(EOS)`; worth transcribing as the "derivative of the candidate invariant vanishes by direct substitution" step.
- The insufficiency of `e1` + differentiated EOS without the EOS value is a nice blueprint remark (matches the official route, which substitutes `M = nKH/(TV)` *as a value*).
