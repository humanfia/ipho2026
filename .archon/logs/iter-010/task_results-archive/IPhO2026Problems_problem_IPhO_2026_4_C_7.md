# Prover task result — `IPhO2026Problems/problem_IPhO_2026_4_C_7.lean` (iter-010)

- Assigned file: `IPhO2026Problems/problem_IPhO_2026_4_C_7.lean`
- Blueprint chapter: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_4_C_7.tex`
- Source report: `reports/ipho_2026_k3/problem_IPhO_2026_4_C_7.source.json`
- Status: **2 sorries remain, BOTH blocked by unprovable (false) statements.** Redraft requested for both target theorems. File compiles clean (0 errors; only the two `declaration uses sorry` warnings) under fresh `lake env lean`.
- Signatures untouched; only proof bodies after `:= by` were edited. No axioms introduced; no `sorryAx`-style laundering (the two remaining sorries sit at exactly the disprovable steps, each with the refutation evidence inlined as comments). `Real.pi_lt_d20`, `Real.lt_log_one_add_of_pos`, `Real.exp_one_lt_d9`/`Real.exp_one_gt_d9` are the only non-trivial Mathlib inputs used in the (scratch, not in-file) refutation proofs.

## Summary verdict

Both contracted theorems are **semantically false as stated** — provably refutable in Lean, not merely hard:

| declaration | verdict | evidence |
|---|---|---|
| `acrylicConductivity_formula` | hypotheses satisfiable ∧ conclusion negatable | full constructive countermodel compiled 0 errors (see below) |
| `acrylicConductivity_officialSample` | hypotheses satisfiable ∧ conclusion negated | numeric refutation compiled 0 errors (see below) |

Per the workflow (step 7), the signatures were kept frozen; the partial
proof bodies record the reduction up to the exact disprovable step, with a
focused `sorry` there. The `
\leanok` markers should NOT be set for
these two declarations.

---

## Theorem 1: `acrylicConductivity_formula` — Redraft needed

**Problem id:** `IPhO_2026_4` Part C.7 · report `reports/ipho_2026_k3/problem_IPhO_2026_4_C_7.source.json`

**Theorem:** `IPhO2026.Problem4.C7.acrylicConductivity_formula`

**Why the current statement is not provable.** The sign convention is
internally inconsistent. With `hΔT : D.T_IC < D.T_OC`, the lumped law (4)
gives (for `D.R_Th > 0`) `P = (T_OC − T_IC)/R_Th > 0`: heat flows from the
outer cylinder **inward**, the temperature profile **decreases outward**,
`deriv T r < 0`. Fourier's law `P r = -lam · A(r) · deriv T r` with
`A(r) = 2π r h > 0` and the constant current `P > 0` then forces `lam < 0`
— while the claimed right-hand side
`Real.log (r₂/r₁)/(2·π·h·R_Th)` is **positive**
(`r₂ > r₁ > 0` from the geometry structure, `h > 0`, and the missing
`R_Th > 0`). Literally building both signs forces a contradiction with the
conclusion. Also note the hypothesis set carries only `D.R_Th ≠ 0`, never
`0 < D.R_Th`, so even the sign of both sides is not pinned down by the
given assumptions.

**Machine-checked countermodel** (compiles 0 errors against the *current*
on-disk structures; verified with fresh `lake env lean` in this session;
the exact file is reproduced below and re-checkable in minutes):

```lean
-- witness values
G := ⟨1, 2, 1, by norm_num, by norm_num, by norm_num⟩
D := ⟨Real.log 2 / (2 * π), 0, Real.log 2 / (2 * π)⟩
lam := -1
T := fun r => (2 * π)⁻¹ * Real.log r
P := fun _ => 1
-- all hypotheses hold:
--  · LumpedHeatFlowLaw: 1 = (log2/(2π) − 0)/(log2/(2π))   (div_self)
--  · steady: rfl;  fourier: deriv T r = (2π)⁻¹ r⁻¹ (Real.deriv_log),
--    so -(-1)·(2π·r·1)·((2π)⁻¹·r⁻¹) = 1   (field_simp)
--  · hR: log2/(2π) ≠ 0;  hlam: -1 ≠ 0;  T 1 = 0 = T_IC;  T 2 = log2/(2π) = T_OC;
--    0 < log2/(2π)
-- but the claimed RHS is:
--   log(2/1)/(2π·1·(log2/(2π))) = 1 ≠ -1 = lam
```

The complete Lean source of this countermodel (prefix = current file's
declarations, `theorem c7_formula_countermodel … := by …` exactly as in
the comment block I left inside `acrylicConductivity_formula`) compiled
with exit code 0.

**Smallest faithful fix.** Reverse the temperature drive to
`hΔT : D.T_OC < D.T_IC` (outward heat flow, matching the recorded
physics: hot inner cylinder heats the outer bath through the acrylic wall),
and strengthen `hR` to `0 < D.R_Th`. Then `P > 0`, `deriv T r ≥ 0`, the
integration `P·log(r₂/r₁)/(2π lam h) = T(r₂) − T(r₁)` (via
`integral_inv` / `integral_one_div_of_pos`) yields the stated positive
formula. (Equivalently keep `T_IC < T_OC` but add `lam < 0 ∧ D.R_Th < 0`
and negate the formula — physically unnatural. The outward-flow restatement
is the faithful one.)

**Partial progress left in the body (compiled):** constancy of the wall
current (`hP_const : ∀ r ∈ Set.Icc G.r₁ G.r₂, P r = P G.r₁`, using
`hfourier.wall_current`), the lumped value (`hP0`), the drive positivity
(`hΔ : 0 < D.T_OC - D.T_IC`), `1 < r₂/r₁`, `0 < Real.log (r₂/r₁)`,
`0 < 2πh`, and a case split `rcases lt_or_gt_of_ne hR` isolating the
missing `0 < D.R_Th`. The final `sorry` sits exactly at the disprovable
step; the comment block above it documents the refutation and the fix.

---

## Theorem 2: `acrylicConductivity_officialSample` — Redraft needed

**Problem id:** `IPhO_2026_4` Part C.7 · report `reports/ipho_2026_k3/problem_IPhO_2026_4_C_7.source.json`

**Theorem:** `IPhO2026.Problem4.C7.acrylicConductivity_officialSample`

**Why the current statement is not provable.** It is *numerically false*.
Substituting `hR_central : R_Th = 1.17` (which satisfies the window
`hR_uncert : |R_Th − 1.17| ≤ 0.03`) into `hformula`:

```
lam = Real.log ((23.25e-3)/16.85e-3) / (2·π·0.10·1.17)
    = Real.log (465/337) / (2·π·0.117)
    ≈ 0.32195447523499 / 0.73513268094
    ≈ 0.43795   ⇒   |lam − 0.25| ≈ 0.18795 > 0.01.
```

i.e. the negation of the goal is provable, not just unprovable-either-way.

**Machine-checked refutation** (compiled 0 errors this session against
the current on-disk `open Real` environment):

```lean
theorem sample_counter :
    ∃ lam R_Th : ℝ,
      (lam = Real.log ((23.25e-3 : ℝ) / 16.85e-3) / (2 * π * (0.10 : ℝ) * R_Th)) ∧
      R_Th = 1.17 ∧ |R_Th - 1.17| ≤ 0.03 ∧ ¬ (|lam - 0.25| ≤ 0.01) := by
  refine ⟨_, 1.17, rfl, rfl, by norm_num, ?_⟩
  have hlog : (128:ℝ)/401 < Real.log ((23.25e-3 : ℝ) / 16.85e-3) := by
    have h := Real.lt_log_one_add_of_pos (show (0:ℝ) < (128/337 : ℝ) by norm_num)
    rw [show (1:ℝ) + 128/337 = 465/337 by norm_num] at h
    have heq : (23.25e-3 : ℝ) / 16.85e-3 = 465/337 := by norm_num
    rw [heq]
    have hsimp : 2 * ((128:ℝ)/337) / ((128:ℝ)/337 + 2) = (128:ℝ)/401 := by
      field_simp; ring
    rwa [hsimp] at h
  have hpi_lt : π < 3.141592654 := by linarith [Real.pi_lt_d20]
  have hden_lt : 2 * π * (0.10:ℝ) * 1.17 < 2 * 3.141592654 * (0.10:ℝ) * 1.17 := by
    nlinarith [hpi_lt]
  have hlb : (128:ℝ)/401 / (2 * 3.141592654 * (0.10:ℝ) * 1.17) <
      Real.log ((23.25e-3 : ℝ) / 16.85e-3) / (2 * π * (0.10 : ℝ) * 1.17) := by
    have h1 := div_lt_div_of_pos_right hlog (by norm_num : (0:ℝ) < 2 * 3.141592654 * 0.10 * 1.17)
    have h2 := div_lt_div_of_pos_left (lt_trans (by norm_num : (0:ℝ) < 128/401) hlog)
                 (by positivity : (0:ℝ) < 2 * π * 0.10 * 1.17) hden_lt
    exact lt_trans h1 h2
  have hgt : (128:ℝ)/401 / (2 * 3.141592654 * (0.10:ℝ) * 1.17) > (0.26 : ℝ) := by norm_num
  -- hence lam > 0.26, so |lam − 0.25| > 0.01  (norm_num/gt of 0.43..)
  …
```

(The chain closes with `(128/401)/(2·3.141592654·0.10·1.17) ≈ 0.4342 > 0.26`,
so `|lam − 0.25| > 0.01`. Full file compiled green.)

**Cross-check.** The 0.25 official value is recovered only with different
inputs: `R_Th ≈ 2.05 K/W` or `h ≈ 0.175 m` (or both radii measured with
the full outer diameter counting twice the wall). With the frozen inputs
(`r₂/r₁ = 465/337`, `h = 0.10`, `R_Th = 1.17 ± 0.03`), even the
interval-propagated bound `[0.427, 0.449]` never intersects
`[0.24, 0.26]`. Note also: `hR_central : R_Th = 1.17` makes `hR_uncert`
redundant; an honest "propagated uncertainty" statement should quantify
over the whole interval instead.

**Smallest faithful fix.** Either (a) correct the wetted height
hypothesis to the value the official derivation actually used
(`(0.10 : ℝ)` → the cm→m conversion that yields `lam ≈ 0.25`;
check the source whether it is `0.175 m`/`17.5 cm` or the
resistance), or (b) widen the conclusion to the propagated bound
`|lam − 0.43795…| ≤ …` — (a) is the physically faithful one pending a
re-read of the source figure/procedure, so the redraft decision is left to
the plan agent with this analysis.

**Partial progress left in the body (compiled):** `hR_central` substituted
into `hformula`, `lam` rewritten by `hformula`, `abs_le` split into the two
one-sided goals; the upper goal `lam − 0.25 ≤ 0.01` is exactly the
refutable one (evidence above), so both halves carry a focused `sorry`
covered by the comment block documenting the refutation.

---

## Blueprint bookkeeping (for the review agent)

- `thm:IPhO2026Problems_problem_IPhO_2026_4_C_7:acrylicConductivity_formula` — do **not** mark `\leanok` (proof absent; statement false as written; redraft requested).
- `thm:IPhO2026Problems_problem_IPhO_2026_4_C_7:acrylicConductivity_officialSample` — do **not** mark `\leanok` (proof absent; statement numerically false; redraft requested).
- All assumption-side definitions (`CylindricalWallGeometry`, `lateralArea`, `ThermalExperimentData`, `LumpedHeatFlowLaw`, `RadialFourierConduction`) and the bridge lemma `RadialFourierConduction.wall_current` are proof-complete and could keep/acquire `\leanok` per the deterministic sync; they were validated as reusable (the countermodel built on them compiles).

## Verification

- `lake env lean IPhO2026Problems/problem_IPhO_2026_4_C_7.lean` → exit 0,
  only warnings `declaration uses sorry` at L172 and L242 (the two frozen
  targets). Baseline before my edits: same two warnings, 0 errors.
- Countermodel for theorem 1: full Lean file (current prefix +
  `c7_formula_countermodel`) → exit 0.
- Refutation for theorem 2: standalone `sample_counter` file → exit 0.
