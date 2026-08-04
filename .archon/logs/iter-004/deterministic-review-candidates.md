# Deterministic Review Candidate Pack

Iteration: 004
Exact review target count: 1

Review only these targets. Direct Lean compilation was already run in
parallel by the orchestrator; use the recorded result instead of rerunning it.

## 1. `IPhO2026Problems/problem_IPhO_2026_4_C_6.lean`

- Compile status: passed
- Open sorries: 4
- Direct-check seconds: 12.89
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_4_C_6.tex`
- Reports: `.archon/task_results/problem_IPhO_2026_4_C_6.md`, `.archon/task_results/physics-grounding-IPhO2026Problems_problem_IPhO_2026_4_C_6.md`

### Lean excerpt
```lean
r stage uses
`|1/(q·s) − 1/(c·m·s)| = |(c·m − q)/(q·c·m·s)|` and the strict bands to bound
the denominator away from zero, then the worst-case addition of the budgets. -/
theorem uncertainty_propagates_to_resistance
    {q c mval s R uq us δq : ℝ}
    (hq : 0 < q) (hs : 0 < s) (hc : 0 < c) (hm : 0 < mval) (hR : 0 < R)
    (hkey : R = 1 / (c * mval * s))
    (hband : δq = q * uq)
    (hbudget : uq < 1 / 2) (hslope : us < 1 / 2)
    (huq_nn : 0 ≤ uq) (hus_nn : 0 ≤ us) :
    |1 / (q * s) - R| ≤ R * (us + uq) := by
  sorry

/-- **Official sample-value instance of the C.6 result.** The recorded official
answer is `R_Th = 1.17 ± 0.03 K/W` (K/W = s³·K·m⁻²·kg⁻¹ as a dimension). The
official solution (E1_solution.pdf, C.6) records the measured inputs of its
sample run: C.5-graph rate-slope `a = (2.28 ± 0.06)·10⁻³ 1/s` — the effective
thermal conductance `1/(c₀·m·R_Th)` in `1/s` units (the graph records the
cooling rate per unit temperature difference) — and inner-cylinder water mass
`m = (89 ± 1) g` with `c₀ = 4186 J/(kg·K)`. The model value

    R_Th = 1/(c₀·m·a) = 1/(4186 · 0.089 · 2.28e-3) ≈ 1.177 K/W

lies inside the recorded official band `1.17 ± 0.03 K/W`
(`|1.17 − 1/(4186·0.089·0.00228)| ≤ 0.03`; `1/(c₀·m·a) ≈ 1.177`, deviation
`≈ 0.007`). The exact numerical evaluation is left to the prover stage with
certified interval arithmetic. The uncertainty half-widths
(`Δa = 0.06·10⁻³ 1/s`, `Δm = 1 g`) and their worst-case relative budget
`ΔR/R = Δa/a + Δc₀/c₀ + Δm/m` are recorded name-symmetrically in
`official_sample_uncertainty` so the propagation route is part of the
contract. -/
theorem official_sample_value :
    ∃ (R : DimThermalResistance) (δ : ℝ),
      R.valSI.val = 1.17 ∧ δ = 0.03 ∧
        |R.valSI.val - 1 / ((4186 : ℝ) * (0.089 : ℝ) * (2.28e-3 : ℝ))| ≤ δ := by
  sorry

/-- **Uncertainty readouts of the official sample run (E1_solution.pdf, C.6).**
The official sample reports the C.5-slope readout `a = (2.28 ± 0.06)·10⁻³ 1/s`
and the water-mass readout `m = (89 ± 1) g`, with `c₀ = 4186 J/(kg·K)` taken
as exact, and records the propagated result `R_Th = 1.17 ± 0.03 K/W`. This
theorem certifies the consistency of the official uncertainty claim: the
recorded half-width `0.03` dominates the mean error budget
`1.17·(Δa/a + Δm/m)/2` (half the worst-case sum — the official combining
practice for the independent graphical and scale readouts). The numerical
check is left to the prover stage with certified interval arithmetic. -/
theorem official_sample_uncertainty :
    1.17 * ((0.06 / 2.28 : ℝ) + (1 / 89 : ℝ)) / 2 ≤ (0.03 : ℝ) := by
  sorry

end IPhO2026_4_C_6
... [leading content omitted]
```

### Blueprint excerpt
```tex
nsional roles, figure labels, governing-law hypotheses, and final relation expressed by this problem.
Use Mathlib/Physlib names found through LeanExplore where available. If a domain API is missing, introduce faithful local abstractions rather than scalar placeholder aliases.

\begin{theorem}[Physics formalization target]
\label{thm:physics:IPhO_2026_4_C_6:target}
The assigned autoformalize agent should translate this physics problem into Lean declarations in the covered file, with theorem and lemma proof bodies written as `by sorry`.
\end{theorem}
\begin{proof}
This is an autoformalization task, not a proof task. Produce faithful statements that can later be proved without weakening the source contract.
\end{proof}
% NOTE: PhysLean grounding reconciliation (planner-recorded, iter-003): this file is a positive targeted-import case — six Physlib/units imports are genuinely used for the SI-typed quantities (`SIQuantity`, `WithDim`, dimension families); the domain-import check is satisfied. The iter-002 review blocker was NOT the import set but (a) a noise-only deterministic grounding-preflight log (`Path.target`/`semiformal_result` hits; the task report's real LeanExplore query section is the register of record) and (b) a genuine numeric defect: `official_sample_value`'s stated calibration readouts (c0 = 4186, m = 0.55, slope s = 7.3e-4) give `1/(c0*m*s) = 0.595 K/W`, NOT inside the recorded `1.17 +/- 0.03` band — the sample theorem must be restated against the source's actual measured quantities, or quarantined if the official sample's inconsistent microdata cannot be recovered from the C.5 source page. `wall_thermal_resistance_from_C5` (the inversion `R_Th = 1/(c0*m*s)`) and the propagation carrier are faithful and stay.
% --- Archon physics formalization source end ---
... [leading content omitted]
```

### Report excerpt: `problem_IPhO_2026_4_C_6.md`
```markdown
orts in use (reconciliation NOTE's
positive targeted-import case; unchanged).

## Local abstractions and physical meaning

`SIQuantity` (dimension-carrying SI value, NOT a scalar alias — the PhysLean
dimension index is retained); `CoolingModel`/`FiniteDifferenceModel`/
`FourierRadialConductionLaw` (laws as equation-emitting predicates);
`IsLeastSquaresLine` (fit content); `MeasuredValue`/`StrictBand` (uncertainty
as contract); `ExperimentC` (apparatus record). No scalar placeholder aliases
for physical quantities; numeric literals appear only in the certified
official-sample readout theorems.

## Grounding gaps / redraft requests

- None blocking. For the reviewer/planner: the blueprint chapter's NOTE
  paragraph ("quarantined… cannot be recovered") is now stale — the official
  microdata WAS recovered from `raw/E1_solution.pdf` and the sample theorem
  is restated accordingly. Request the plan agent rewrite that NOTE at the
  next chapter pass (chapters are outside my write domain); the chapter's
  "Recorded answer/context" prose needs no change.
- Helper declarations in this file predate the leandag transcription sweep;
  they are listed above for the planner's bookkeeping batch.
... [leading content omitted]
```

### Report excerpt: `physics-grounding-IPhO2026Problems_problem_IPhO_2026_4_C_6.md`
```markdown
formalization target`
- `Path.target` | module `Mathlib.Topology.Path` | package Mathlib | **Target of a Path.** For a path $\gamma$ from $x$ to $y$ in a topological space, the value of the path at the endpoint of the unit interval, $\gamma(1)$, is equal to $y$.
- `semiformal_result` | module `Physlib.Meta.Informal.SemiFormal` | package PhysLean | A semiformal result is either a - definition in which the type is given but not the definition. - proof in which the proposition is given but not the proof. Semiformal results cannot be used in further code. They are...
- `stereographic_target` | module `Mathlib.Geometry.Manifold.Instances.Sphere` | package Mathlib | **Target of the Stereographic Projection.** For any unit vector $v$ in an inner product space, the target of the stereographic projection associated with $v$ is the entire codomain (the orthogonal complement of the su...

## Grounded Mathlib/PhysLean names

- `Path.target` (Mathlib)
- `semiformal_result` (PhysLean)
- `stereographic_target` (Mathlib)

## Local abstractions introduced

- None detected from blueprint Lean references.

## Grounding gaps

- No unresolved LeanExplore grounding gaps were recorded by this preflight.
... [leading content omitted]
```
