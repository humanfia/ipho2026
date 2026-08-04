# Deterministic Review Candidate Pack

Iteration: 006
Exact review target count: 1

Review only these targets. Direct Lean compilation was already run in
parallel by the orchestrator; use the recorded result instead of rerunning it.

## 1. `IPhO2026Problems/problem_IPhO_2026_4_A_5.lean`

- Compile status: passed
- Open sorries: 10
- Direct-check seconds: 9.163
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_4_A_5.tex`
- Reports: `.archon/task_results/problem_IPhO_2026_4_A_5.md`, `.archon/task_results/physics-grounding-IPhO2026Problems_problem_IPhO_2026_4_A_5.md`

### Lean excerpt
```lean
iction `beta0 = 1 / T0`
(numerically `0.0037 K^-1` at `T0 = 273.15 K`). This is the content the
official sample compares against, `1 / 273.15 K = 0.0037 K^-1`. -/
theorem beta0_close_to_ideal
    (proc : IsochoricProcess)
    (law : IsIdealGasLaw proc)
    (linear : IsIsochoricLinear proc)
    (ref : IsReferenceState proc)
    (T₀ β₀ : ℝ)
    (hT₀ : T₀ = IsReferenceState.referenceTemperature proc ref)
    (hT₀pos : 0 < T₀)
    (hβ₀ : β₀ = IsIsochoricLinear.thermalPressureCoefficient proc linear ref) :
    β₀ = 1 / T₀ := by
  sorry

/-- Component of `main`, finite-difference form: between any two recorded
temperatures the isochoric pressure increment satisfies
`slope * Delta T = beta0 * P0 * Delta T`; with `beta0 = 1 / T0` the
measured increment matches the ideal-gas increment `P0 * Delta T / T0`.
This is Eq. (2) evaluated on the A.2 data table. -/
theorem beta0_eq_ideal_of_linear
    (proc : IsochoricProcess)
    (law : IsIdealGasLaw proc)
    (linear : IsIsochoricLinear proc)
    (ref : IsReferenceState proc)
    (T₀ β₀ : ℝ)
    (hT₀ : T₀ = IsReferenceState.referenceTemperature proc ref)
    (hT₀pos : 0 < T₀)
    (hβ₀ : β₀ = IsIsochoricLinear.thermalPressureCoefficient proc linear ref) :
    ∀ T₁ T₂ : ℝ,
      linear.slope * (T₂ - T₁) =
        β₀ * IsReferenceState.referencePressure proc ref * (T₂ - T₁) := by
  sorry

/-- Component of `main`: uncertainty propagation. If the two-readout
pressure increment deviates from the ideal-gas increment
`P0 * Delta T / T0` by at most `P0 * |Delta T| * sigma`, then the measured
coefficient satisfies the propagated bound `|beta0 - 1 / T0| <= sigma`.
Formalizes the official sample statement `beta0 = 0.0034 ± 0.0007 K^-1`
covering the ideal-gas reference `0.0037 K^-1`. -/
theorem beta0_uncertainty_bound
    (proc : IsochoricProcess)
    (law : IsIdealGasLaw proc)
    (linear : IsIsochoricLinear proc)
    (ref : IsReferenceState proc)
    (T₀ β₀ : ℝ)
    (hT₀ : T₀ = IsReferenceState.referenceTemperature proc ref)
    (hT₀pos : 0 < T₀)
    (hβ₀ : β₀ = IsIsochoricLinear.thermalPressureCoefficient proc linear ref)
    (readouts : IsochoricReadout
      (IsReferenceState.referencePressure proc ref) T₀ β₀)
    (σ : ℝ) (hσ : 0 < σ)
    (hdev :
      |(readouts.measuredPressure readouts.T₂ (Or.inr rfl)) -
          (readouts.measuredPressure readouts.T₁ (Or.inl rfl)) -
        IsReferenceState.referencePressure proc ref *
          (readouts.T₂ - readouts.T₁) / T₀|
        ≤ IsReferenceState.referencePressure proc ref *
            |readouts.T₂ - readouts.T₁| * σ) :
    |β₀ - 1 / T₀| ≤ σ := by
  sorry

end

end IPhO2026_4_A_5
... [leading content omitted]
```

### Blueprint excerpt
```tex
function of temperature from A2. Reusable conclusions: The expected isochoric ideal-gas plot is linear: P is proportional to absolute T. Policy: natural\_language\_prerequisite\_only; do\_not\_import\_Lean\_output
\end{itemize}

\paragraph{Formalization target.}
create a compiling Lean file with sorry bodies at `IPhO2026Problems/problem\_IPhO\_2026\_4\_A\_5.lean`.
The Lean declarations must preserve the physical quantities, dimensions or dimensional roles, figure labels, governing-law hypotheses, and final relation expressed by this problem.
Use Mathlib/Physlib names found through LeanExplore where available. If a domain API is missing, introduce faithful local abstractions rather than scalar placeholder aliases.

\begin{theorem}[Physics formalization target]
\label{thm:physics:IPhO_2026_4_A_5:target}
The assigned autoformalize agent should translate this physics problem into Lean declarations in the covered file, with theorem and lemma proof bodies written as `by sorry`.
\end{theorem}
\begin{proof}
This is an autoformalization task, not a proof task. Produce faithful statements that can later be proved without weakening the source contract.
\end{proof}
% NOTE: PhysLean grounding reconciliation (planner-recorded, iter-004): positive targeted-import case — the covered file genuinely uses `Physlib.Thermodynamics.Basic`, `Physlib.Thermodynamics.Temperature.Basic` (typed `Temperature`/`absTemp`) and `Physlib.StatisticalMechanics.MicroCanonicalEnsemble.IdealGas` (ideal-gas modeling for the Eq.-(1) state law `P V = n R T`); the blanket domain-import check is satisfied and no further import is added. PhysLean has no gas-expansion-work integral identity, so `IsIdealGasLaw` and the expansion-work carrier are faithful local laws.
% --- Archon physics formalization source end ---
... [leading content omitted]
```

### Report excerpt: `problem_IPhO_2026_4_A_5.md`
```markdown
_5.md` from an earlier iter
  is a generic `Path.target`/`semiformal_result` hit list — not domain-relevant.)

## PhysLean/Mathlib names grounded

- `Physlib.Thermodynamics.Basic`, `Physlib.Thermodynamics.Temperature.Basic`
  (`Temperature`, `Temperature.toReal`, coercion), imported and used.
- `Physlib.StatisticalMechanics.MicroCanonicalEnsemble.IdealGas` imported per the
  planner-recorded grounding-reconciliation NOTE in the chapter (kept; harmless).
- Mathlib: `Real` abs/inequalities via `import Mathlib`.

## Local abstractions introduced (why meaning-preserving)

- `IsochoricProcess` / `IsIdealGasLaw` / `IsIsochoricLinear` / `IsReferenceState` /
  `IsochoricReadout`: smallest structures carrying the typed time series, the Eq.-(1)
  state law with free decalibrated `R` (A.4 note), the A.3 affine law, and the Eq.-(2)
  reference configuration — PhysLean's `IdealGas.ideal_gas_law` fixes `R = 1`
  dimensionlessly and derives `P` from Helmholtz free energy, which cannot express the
  exam's sensor-decalibration premise.

## Grounding gaps / redraft requests

- None blocking. No statement redraft requested — the gate's 0/3 review slot stands;
  this lane changed comment tokens only.
... [leading content omitted]
```

### Report excerpt: `physics-grounding-IPhO2026Problems_problem_IPhO_2026_4_A_5.md`
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
