# Deterministic Review Candidate Pack

Iteration: 007
Exact review target count: 1

Review only these targets. Direct Lean compilation was already run in
parallel by the orchestrator; use the recorded result instead of rerunning it.

## 1. `IPhO2026Problems/problem_IPhO_2026_4_A_5.lean`

- Compile status: passed
- Open sorries: 10
- Direct-check seconds: 9.083
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
f}
This is an autoformalization task, not a proof task. Produce faithful statements that can later be proved without weakening the source contract.
\end{proof}
% NOTE: PhysLean grounding reconciliation (planner-recorded, iter-004): positive targeted-import case — the covered file genuinely uses `Physlib.Thermodynamics.Basic`, `Physlib.Thermodynamics.Temperature.Basic` (typed `Temperature`/`absTemp`) and `Physlib.StatisticalMechanics.MicroCanonicalEnsemble.IdealGas` (ideal-gas modeling for the Eq.-(1) state law `P V = n R T`); the blanket domain-import check is satisfied and no further import is added. PhysLean has no gas-expansion-work integral identity, so `IsIdealGasLaw` and the expansion-work carrier are faithful local laws.
% NOTE: Statement reconciliation (planner-recorded, iter-007, review session_6 primary blocker): the A.2 readout protocol records the two pressure readouts around the reference temperature for a finite-difference slope, so the covered file's `IsochoricReadout` structure MUST carry the non-degeneracy field `hT12 : T₁ ≠ T₂` (analogous to the `hvar` guard `main` already carries for the slope bridge). Without it the degenerate instance `T₁ = T₂` satisfies every hypothesis of `beta0_uncertainty_bound` and `main` conjunct 3 (deviation premise `0 ≤ 0` for all `β₀`) while the conclusion `|β₀ − 1/T₀| ≤ σ` fails, e.g. at `β₀ = 2/T₀ + σ` — the uncertainty conjunct is false as stated. With `hT12` the propagation algebra closes: deviation `= P₀·|T₂ − T₁|·|β₀ − 1/T₀|` via the two readout equalities, and `P₀·|T₂ − T₁| > 0` cancels (`IsReferenceState.hP₀` + `hT12`). All construction-free consumers take `readouts` as a hypothesis, so the field is interface-compatible; no answer value moves off the conclusion side.
% --- Archon physics formalization source end ---
... [leading content omitted]
```

### Report excerpt: `problem_IPhO_2026_4_A_5.md`
```markdown
history; keeps typed-temperature semantics instead of
  scalar aliases.
- `IsIdealGasLaw` — governing-law interface: statewise state equation plus
  positivity, free `R` (decalibration note of Part A.4); faithful because
  it asserts the law itself, not any solved form.
- `IsIsochoricLinear` — A.3 affine fit with positive slope; the offset is
  kept general (data need not pass through the origin; ideal-gas
  consistency forces it to zero inside the proofs).
- `IsochoricReadout` — sparse measured data with explicit consistency
  equations on a two-point subtype plus the `hT12` non-degeneracy field.
- `IsReferenceState` — reference instant with positive pressure and
  `T₀`/`P₀` projections.

## Grounding gaps / redraft requests

- Gap (near-miss, recorded): PhysLean's `IdealGas.ideal_gas_law` fixes
  `R = 1`, and no constant-volume thermal-pressure-coefficient constant
  exists in PhysLean/Mathlib; the local abstractions above stand.
- No redraft requested: the statement is review-ready at gate 2/3. Owed
  downstream bookkeeping (not this lane): planner helper-batch
  transcription of the 23 `4_A_5` declarations into blueprint entries with
  `\uses{}` wiring (task_pending iter-007).
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
