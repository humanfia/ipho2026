# Task result — IPhO2026Problems/problem_IPhO_2026_2_C_2.lean (iter-010, prover)

## Outcome summary

- `IPhO2026_2_C_2.NeighboringRayExpansion.branch_denominators_ne_zero` — **PROVED** (was sorry at old L138). Closed via acute-branch positivity: `sin_pos_of_pos_of_lt_pi` on `0 < 2θ < π` and `cos_pos_of_mem_Ioo` on `θ ∈ (-π/2, π/2)`, both discharged by `linarith` from `θ_branch`. Axiom check: `propext, Classical.choice, Quot.sound` only.
- `IPhO2026_2_C_2.NeighboringRayExpansion.ray_B_slope_first_order` — partial proof in place; one focused `sorry` remains (coefficient step `dm = -2 csc(2θ)²`, L178). Everything else is fully formalized: unpack `M_first_order`, rewrite the zeroth order by the C.1 value (`← s.m_A_eq, s.m_A_formula`), transfer the little-o defect by `IsLittleO.congr'` + `Eventually.of_forall`, and close the pointwise algebra with `s.m_B_eq`, the coefficient identity, and `ring`.
- `IPhO2026_2_C_2.NeighboringRayExpansion.ray_B_intercept_first_order` — same status; focused `sorry` at L211 (`db = (R/(2 cos θ)) tan θ`), remainder fully proved (`s.b_B_eq`, `ring`).
- `ray_B_first_order_expansion` (main target) — unchanged, already proved by pair introduction; now depends on the two focused coefficient gaps only.

Compile status: fresh `lake env lean IPhO2026Problems/problem_IPhO_2026_2_C_2.lean` exits 0 with exactly two `declaration uses sorry` warnings (L155 slope theorem, L194 intercept theorem) and NO errors. Signatures frozen; no axioms added; no statement touched.

## What was proved and how

`branch_denominators_ne_zero`: from `θ_branch : θ ∈ Set.Ioo 0 (π/2)`, get `0 < 2θ < π`, so `sin (2θ) > 0` (`Real.sin_pos_of_pos_of_lt_pi`) hence `≠ 0`; and `θ ∈ (-π/2, π/2)` so `cos θ > 0` (`Real.cos_pos_of_mem_Ioo`) hence `≠ 0`.

For the two value theorems, the proof skeleton now in the file is:

```
obtain ⟨dm, hdm⟩ := s.M_first_order          -- some linearization exists
have hM : s.M s.θ = cot (2 * s.θ)            -- C.1 zeroth order
apply hdm.congr' _ (EventuallyEq.refl _ _)   -- transport along eventual equality
refine Eventually.of_forall fun Δθ ↦ ?_
have hdmval : dm = -2 * (sin (2 * s.θ))⁻¹ ^ 2 := by sorry  -- ONLY GAP
change … ; calc … rw [hM, hdmval] … rw [s.m_B_eq]; ring
```

The mathematical content of the remaining step is exactly the recorded
derivative identity `(d/dθ) cot (2θ) = -2 csc(2θ)²` (resp.
`(d/dθ)(R/(2 cos θ)) = (R/(2 cos θ)) tan θ`) applied to the interface's
hidden slope. Mathlib route that WOULD close it, once the family is
derivative-controlled: `hasDerivAt_iff_isLittleO_nhds_zero` turns
`hdm` into `HasDerivAt (fun φ ↦ M φ) dm s.θ`, then
`HasDerivAt.unique`/`deriv` against a computed `HasDerivAt` of the
C.1 formula (`HasDerivAt.cot`/`Real.cot_eq_cos_div_sin` + `HasDerivAt.div`
+ `hsin` from the bridge lemma) gives `dm = -2 csc(2θ)²`.

## Redraft needed

- Original problem id / report: IPhO_2026_2 part C.2; report `reports/ipho_2026_k3/problem_IPhO_2026_2_C_2.source.json`; grounding log `.archon/task_results/physics-grounding-IPhO2026Problems_problem_IPhO_2026_2_C_2.md`.
- Theorems: `NeighboringRayExpansion.ray_B_slope_first_order`, `NeighboringRayExpansion.ray_B_intercept_first_order` (and hence the conjunction `ray_B_first_order_expansion`).
- Why the current statement is not provable as formalized: the structure field `M_first_order` (and `B_first_order`) only asserts *existence of some* first-order little-o expansion of an arbitrary function family `M : ℝ → ℝ` at `θ`. For an arbitrary `M` the interface witness `dm` is NOT determined by the hypotheses: nothing ties `M` to the specular-reflection family beyond the single value `M θ = cot (2θ)` at one point. Concretely, the hypotheses admit models where `M` is any smooth-ish function through `(θ, cot 2θ)` whose first-order coefficient at `θ` is anything (e.g. a family whose expansion slope is the claimed value shifted by a constant — the `IsLittleO`-against-`Δθ` remainder absorbs whatever the true slope is). Therefore `dm = -2 csc(2θ)²` is not derivable from the frozen hypotheses, and the two value theorems are underdetermined as stated. (The blueprint's own proof sketch confirms the intended argument — 'the derivative identity of the specular family fixes the first-order coefficient' — which presupposes the family is mathematically the specular family, not an arbitrary carrier with a smoothness interface.)
- Smallest faithful fix (pick one, both keep every signature/theorem statement unchanged):
  1. Strengthen the two regularity interface fields to carry the derivative *values* on the specular family, e.g.
     `M_first_order : (fun Δθ ↦ M (θ + Δθ) - M θ - (-2 * (sin (2 * θ))⁻¹ ^ 2) * Δθ) =o[𝓝 0] (fun Δθ ↦ Δθ)` and similarly for `B` with `(R / (2 * cos θ)) * tan θ`. This is the same physical content (law of reflection smoothness) with the coefficient certified hypothesis-side; the proofs then close by `congr'` + `ring` with no sorry. Downside: named-coefficient appears hypothesis-side (blueprint currently advertises coefficients "never hypothesis-side").
  2. (Preferred, keeps coefficients conclusion-side) Introduce the family abstractly as the specular family: add a field giving `M`/`B` by their geometric formulas at all angles near the branch, e.g. `M_family : ∀ᶠ φ in 𝓝 s.θ, M φ = cot (2 * φ)` and `B_family : ∀ᶠ φ in 𝓝 s.θ, B φ = R / (2 * cos φ)`. Then `HasDerivAt` of `φ ↦ cot (2φ)` at `θ` (computable in Mathlib from `Real.cot_eq_cos_div_sin`, `HasDerivAt.div`, `HasDerivAt.const_mul`, `hsin`, `hsquare := Real.cos_sq_add_sin_sq`) plus `hasDerivAt_iff_isLittleO_nhds_zero` proves the target directly, and `HasDerivAt.unique` handles any interface witness. The C.1 `m_A_formula`/`b_A_formula` fields then become corollaries and can be dropped or kept. This is the minimal physically faithful strengthening: it asserts that the neighboring rays really come from the same mirror, which is the problem's actual hypothesis.
- No `sorry` was laundered: both remain as explicit `sorry` with BLOCKED comments in the file, and the partial proofs around them are complete.

## Ready for blueprint markers (review agent)

- `lem:IPhO2026Problems_problem_IPhO_2026_2_C_2:branch_denominators_ne_zero` — proof complete; candidate for `\leanok` (subject to the deterministic sync).
- `thm:...:ray_B_slope_first_order`, `thm:...:ray_B_intercept_first_order`, `thm:...:ray_B_first_order_expansion`, `thm:physics:IPhO_2026_2_C_2:target` — NOT ready; each retains one focused coefficient sorry tied to the redraft above.
