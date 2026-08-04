# Deterministic Review Candidate Pack

Iteration: 005
Exact review target count: 3

Review only these targets. Direct Lean compilation was already run in
parallel by the orchestrator; use the recorded result instead of rerunning it.

## 1. `IPhO2026Problems/problem_IPhO_2026_1_B_2.lean`

- Compile status: passed
- Open sorries: 1
- Direct-check seconds: 156.164
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_1_B_2.tex`
- Reports: `.archon/task_results/physics-grounding-IPhO2026Problems_problem_IPhO_2026_1_B_2.md`

### Lean excerpt
```lean
(2 : ℝ) / 7 ≤ 0.28576211850376 := by norm_num
      _ ≤ Real.sin upperAngleTrial := upperAngleBounds3.1.1
      _ ≤ Real.sin (3321 * Real.pi / 36000) := hmono

  have arcsin_lower_bound :
      3319 * Real.pi / 36000 ≤ Real.arcsin ((2 : ℝ) / 7) := by
    rw [Real.le_arcsin_iff_sin_le]
    · exact lower_endpoint_sine_le
    · constructor <;> nlinarith [Real.pi_pos]
    · norm_num
  have arcsin_upper_bound :
      Real.arcsin ((2 : ℝ) / 7) ≤
        3321 * Real.pi / 36000 := by
    rw [Real.arcsin_le_iff_le_sin]
    · exact upper_endpoint_sine_ge
    · norm_num
    · constructor <;> nlinarith [Real.pi_pos]
  have deflection_number_lower :
      (3319 : ℝ) / 200 ≤
        Real.arcsin ((2 : ℝ) / 7) * 180 / Real.pi := by
    have hpi := Real.pi_pos
    apply (le_div_iff₀ hpi).2
    nlinarith [arcsin_lower_bound]
  have deflection_number_upper :
      Real.arcsin ((2 : ℝ) / 7) * 180 / Real.pi ≤
        (3321 : ℝ) / 200 := by
    have hpi := Real.pi_pos
    apply (div_le_iff₀ hpi).2
    nlinarith [arcsin_upper_bound]
  have negative_arcsin_deflection :
      -Real.arcsin ((2 : ℝ) / 7) * 180 / Real.pi < 0 := by
    have harcsin : 0 < Real.arcsin ((2 : ℝ) / 7) :=
      Real.arcsin_pos.mpr (by norm_num)
    have hpositive :
        0 < Real.arcsin ((2 : ℝ) / 7) * 180 / Real.pi :=
      div_pos (mul_pos harcsin (by norm_num)) Real.pi_pos
    rw [show -Real.arcsin ((2 : ℝ) / 7) * 180 / Real.pi =
        -(Real.arcsin ((2 : ℝ) / 7) * 180 / Real.pi) by ring]
    exact neg_neg_of_pos hpositive
  have negative_arcsin_rounds :
      RoundsToNearestHundredth
        (-Real.arcsin ((2 : ℝ) / 7) * 180 / Real.pi)
        (-(83 : ℝ) / 5) := by
    rw [RoundsToNearestHundredth,
      show -Real.arcsin ((2 : ℝ) / 7) * 180 / Real.pi =
          -(Real.arcsin ((2 : ℝ) / 7) * 180 / Real.pi) by ring,
      abs_le]
    constructor <;> nlinarith

  -- It remains to identify the limiting relative velocity with the outgoing
  -- branch of the position conic, including its clockwise sign.  The facts
  -- proved above determine the asymptotic position-axis cosine, but the
  -- frozen imports provide no mean-value/asymptotic-integration theorem that
  -- turns `positionDerivative` and the velocity limit into a normalized
  -- displacement limit.
  have signed_deflection_formula :
      signedDeflectionDegrees motion frame uInfinity =
        -Real.arcsin ((2 : ℝ) / 7) * 180 / Real.pi := by
    sorry
  constructor
  · rw [signed_deflection_formula]
    exact negative_arcsin_deflection
  · rw [signed_deflection_formula]
    exact negative_arcsin_rounds

end IPhO2026Problems.IPhO2026_1_B_2
... [leading content omitted]
```

### Blueprint excerpt
```tex
cityVector, decl:physics:IPhO_2026_1_B_2:DimSpeed, decl:physics:IPhO_2026_1_B_2:DimAngularMomentum, decl:physics:IPhO_2026_1_B_2:DimPermittivity, decl:physics:IPhO_2026_1_B_2:DimCoulombConstant, decl:physics:IPhO_2026_1_B_2:scalarSI, decl:physics:IPhO_2026_1_B_2:vectorSI, decl:physics:IPhO_2026_1_B_2:ParticleLabel, decl:physics:IPhO_2026_1_B_2:PhysicalConstants, decl:physics:IPhO_2026_1_B_2:ConstantRelations, decl:physics:IPhO_2026_1_B_2:PairMotion, decl:physics:IPhO_2026_1_B_2:positionSI, decl:physics:IPhO_2026_1_B_2:velocitySI, decl:physics:IPhO_2026_1_B_2:particleMassSI, decl:physics:IPhO_2026_1_B_2:particleChargeSI, decl:physics:IPhO_2026_1_B_2:relativeDisplacementSI, decl:physics:IPhO_2026_1_B_2:relativeVelocitySI, decl:physics:IPhO_2026_1_B_2:separationSI, decl:physics:IPhO_2026_1_B_2:Figure1bFrame, decl:physics:IPhO_2026_1_B_2:signedAngularMomentumSI, decl:physics:IPhO_2026_1_B_2:totalAngularMomentumMagnitudeSI, decl:physics:IPhO_2026_1_B_2:Figure1bInitialConditions, decl:physics:IPhO_2026_1_B_2:coulombForceOnPositronSI, decl:physics:IPhO_2026_1_B_2:CoulombDynamics, decl:physics:IPhO_2026_1_B_2:initialTotalEnergySI, decl:physics:IPhO_2026_1_B_2:ConicOrbitData, decl:physics:IPhO_2026_1_B_2:ConicOrbitLaws, decl:physics:IPhO_2026_1_B_2:IsUnbound, decl:physics:IPhO_2026_1_B_2:signedDeflectionDegrees, decl:physics:IPhO_2026_1_B_2:RoundsToNearestHundredth}
The assigned autoformalize agent should translate this physics problem into Lean declarations in the covered file, with theorem and lemma proof bodies written as `by sorry`.
\end{theorem}
\begin{proof}
This is an autoformalization task, not a proof task. Produce statements that can later be proved by the physics prover without weakening the physical model.
\end{proof}
% --- Archon physics formalization source end ---
... [leading content omitted]
```

### Report excerpt: `physics-grounding-IPhO2026Problems_problem_IPhO_2026_1_B_2.md`
```markdown
eling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_1_B_2.IsUnbound`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_1_B_2.PairMotion`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_1_B_2.ParticleLabel`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_1_B_2.PhysicalConstants`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_1_B_2.Plane`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_1_B_2.RoundsToNearestHundredth`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.

## Grounding gaps

- No unresolved LeanExplore grounding gaps were recorded by this preflight.
... [leading content omitted]
```

## 2. `IPhO2026Problems/problem_IPhO_2026_2_B_1.lean`

- Compile status: passed
- Open sorries: 1
- Direct-check seconds: 5.829
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_2_B_1.tex`
- Reports: `.archon/task_results/physics-grounding-IPhO2026Problems_problem_IPhO_2026_2_B_1.md`

### Lean excerpt
```lean
coefficients are read off. -/
theorem radiusAtIncidence_from_figure2f
    (setup : SolarCookerSetup)
    (figure : Figure2fReadout setup)
    (physics : ValidSolarCookerPhysics setup)
    (θ : ℝ)
    (hθ : IsAdmissibleIncidenceAngle θ) :
    setup.radiusAtIncidence θ =
      scaleLength
        (Real.sin θ - (1 / 2) * Real.sin (2 * θ))
        setup.mirrorRadius := by
  rcases physics.limiting_tangent_path_exists θ hθ with
    ⟨path, hpath, hlimiting, htangent, hreflection, hincidence⟩
  -- The present abstract predicates do not state the geometric consequence of
  -- a limiting tangent path, so these hypotheses cannot yet determine the
  -- numerical value of `radiusAtIncidence θ`.
  sorry

/-- In the formula
`a = α sin θ_max + β sin (2 θ_max)`, Figure 2f and geometrical optics determine
`α = R` and `β = -R/2`. -/
theorem problem_IPhO_2026_2_B_1
    (setup : SolarCookerSetup)
    (figure : Figure2fReadout setup)
    (physics : ValidSolarCookerPhysics setup)
    (α β : PhysicalLength)
    (coefficientFormula : IsRadiusCoefficientFormula setup α β) :
    α = setup.mirrorRadius ∧
      β = scaleLength (-(1 / 2)) setup.mirrorRadius := by
  have h_half : IsAdmissibleIncidenceAngle (Real.pi / 2) := by
    constructor
    · positivity
    · exact le_rfl
  have hgeometry_half :=
    radiusAtIncidence_from_figure2f setup figure physics (Real.pi / 2) h_half
  have hformula_half :=
    coefficientFormula (Real.pi / 2) h_half
  have htwice_half : 2 * (Real.pi / 2) = Real.pi := by
    ring
  have hα : α = setup.mirrorRadius := by
    apply WithDim.ext
    have hval :=
      congrArg WithDim.val (hformula_half.symm.trans hgeometry_half)
    simp only [scaleLength, WithDim.val_add] at hval
    rw [htwice_half, Real.sin_pi_div_two, Real.sin_pi] at hval
    norm_num at hval
    exact hval
  refine ⟨hα, ?_⟩
  have h_quarter : IsAdmissibleIncidenceAngle (Real.pi / 4) := by
    constructor <;> dsimp [IsAdmissibleIncidenceAngle] at *
    · positivity
    · nlinarith [Real.pi_pos]
  have hgeometry_quarter :=
    radiusAtIncidence_from_figure2f setup figure physics (Real.pi / 4) h_quarter
  have hformula_quarter :=
    coefficientFormula (Real.pi / 4) h_quarter
  have htwice_quarter : 2 * (Real.pi / 4) = Real.pi / 2 := by
    ring
  apply WithDim.ext
  have hval :=
    congrArg WithDim.val (hformula_quarter.symm.trans hgeometry_quarter)
  rw [hα] at hval
  simp only [scaleLength, WithDim.val_add] at hval
  rw [htwice_quarter, Real.sin_pi_div_two] at hval
  change β.val = (-(1 / 2) : ℝ) * setup.mirrorRadius.val
  norm_num at hval
  linarith

end IPhO2026Problems.IPhO2026_2_B_1
... [leading content omitted]
```

### Blueprint excerpt
```tex
ValidSolarCookerPhysics}
  The ray geometry of Figure 2f gives the radius response before its two trigonometric coefficients are read off.
\end{theorem}
\begin{proof}
  Combine the governing assumptions named in the statement and carry out the indicated physical or algebraic deduction.
\end{proof}

\begin{theorem}[Physics formalization target]
\label{thm:physics:IPhO_2026_2_B_1:target}
\lean{IPhO2026Problems.IPhO2026_2_B_1.problem_IPhO_2026_2_B_1}
\uses{decl:physics:IPhO_2026_2_B_1:PhysicalLength, decl:physics:IPhO_2026_2_B_1:radiantPowerDimension, decl:physics:IPhO_2026_2_B_1:solarIntensityDimension, decl:physics:IPhO_2026_2_B_1:RadiantPower, decl:physics:IPhO_2026_2_B_1:SolarIntensity, decl:physics:IPhO_2026_2_B_1:scaleLength, decl:physics:IPhO_2026_2_B_1:CrossSection, decl:physics:IPhO_2026_2_B_1:AxisDirection, decl:physics:IPhO_2026_2_B_1:RayDirection2D, decl:physics:IPhO_2026_2_B_1:ParallelDirections, decl:physics:IPhO_2026_2_B_1:LightRay2D, decl:physics:IPhO_2026_2_B_1:PointLiesOnForwardRay, decl:physics:IPhO_2026_2_B_1:OpticalPath2D, decl:physics:IPhO_2026_2_B_1:SolarCookerSetup, decl:physics:IPhO_2026_2_B_1:IsAdmissibleIncidenceAngle, decl:physics:IPhO_2026_2_B_1:Figure2fReadout, decl:physics:IPhO_2026_2_B_1:ValidSolarCookerPhysics, decl:physics:IPhO_2026_2_B_1:IsRadiusCoefficientFormula, decl:physics:IPhO_2026_2_B_1:radiusAtIncidence_from_figure2f}
The assigned autoformalize agent should translate this physics problem into Lean declarations in the covered file, with theorem and lemma proof bodies written as `by sorry`.
\end{theorem}
\begin{proof}
This is an autoformalization task, not a proof task. Produce statements that can later be proved by the physics prover without weakening the physical model.
\end{proof}
% --- Archon physics formalization source end ---
... [leading content omitted]
```

### Report excerpt: `physics-grounding-IPhO2026Problems_problem_IPhO_2026_2_B_1.md`
```markdown
t preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_2_B_1.PointLiesOnForwardRay`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_2_B_1.RadiantPower`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_2_B_1.RayDirection2D`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_2_B_1.SolarCookerSetup`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_2_B_1.SolarIntensity`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_2_B_1.ValidSolarCookerPhysics`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.

## Grounding gaps

- No unresolved LeanExplore grounding gaps were recorded by this preflight.
... [leading content omitted]
```

## 3. `IPhO2026Problems/problem_IPhO_2026_4_B_6.lean`

- Compile status: passed
- Open sorries: 0
- Direct-check seconds: 9.356
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_4_B_6.tex`
- Reports: `.archon/task_results/problem_IPhO_2026_4_B_6.lean.md`, `.archon/task_results/physics-grounding-IPhO2026Problems_problem_IPhO_2026_4_B_6.md`

### Lean excerpt
```lean
periment.waterMolarMassM0KilogramsPerMole * amountMol
  latentEnergyFromMoles :
    ∀ amountMol : ℝ, 0 < amountMol →
      siReadout (experiment.latentEnergyForAmountMol amountMol) =
        experiment.molarLatentHeatQv.centralJoulesPerMole * amountMol
  latentEnergyFromMass :
    ∀ amountMol : ℝ, 0 < amountMol →
      siReadout (experiment.latentEnergyForAmountMol amountMol) =
        siReadout experiment.latentHeatPerUnitMassLv *
          siReadout (experiment.vaporizedWaterMassForAmountMol amountMol)
  molarMass_positive :
    0 < experiment.waterMolarMassM0KilogramsPerMole

/--
The only imported previous-part conclusion: the B.5 graph has reported slope
`-4700 ± 200 K` and gives `Q_v = 39 ± 2 kJ/mol`.
-/
structure PreviousPartB5Result
    (experiment : VaporizationExperiment) : Prop where
  fittedSlope :
    experiment.fittedClausiusSlopeKelvin = -4700
  fittedSlopeUncertainty :
    experiment.fittedSlopeUncertaintyKelvin = 200
  molarLatentHeatCentral :
    experiment.molarLatentHeatQv.centralJoulesPerMole = 39 * 1000
  molarLatentHeatUncertainty :
    experiment.molarLatentHeatQv.uncertaintyJoulesPerMole = 2 * 1000

/-! ## Part B.6 target -/

/--
Converting the B.5 molar result by the water molar mass gives

`L_v = Q_v / M₀`.

The second conjunct formalizes the official rounded report
`L_v = 2190 ± 110 kJ/kg`: the SI value, divided by `1000` to obtain
`kJ/kg`, lies in the stated uncertainty band.
-/
theorem latentHeatPerUnitMass_from_molarEstimate
    (experiment : VaporizationExperiment)
    (_data : HasReferenceAndProcedureData experiment)
    (_laws : GoverningLaws experiment)
    (_previous : PreviousPartB5Result experiment) :
    siReadout experiment.latentHeatPerUnitMassLv =
        experiment.molarLatentHeatQv.centralJoulesPerMole /
          experiment.waterMolarMassM0KilogramsPerMole ∧
      |siReadout experiment.latentHeatPerUnitMassLv / 1000 - 2190| ≤ 110 := by
  have hmass := _laws.vaporizedMassFromMoles 1 (by norm_num)
  have hmolar := _laws.latentEnergyFromMoles 1 (by norm_num)
  have hspecific := _laws.latentEnergyFromMass 1 (by norm_num)
  norm_num at hmass hmolar hspecific
  rw [hmolar, hmass] at hspecific
  have hconversion :
      siReadout experiment.latentHeatPerUnitMassLv =
        experiment.molarLatentHeatQv.centralJoulesPerMole /
          experiment.waterMolarMassM0KilogramsPerMole :=
    (eq_div_iff (ne_of_gt _laws.molarMass_positive)).2 hspecific.symm
  constructor
  · exact hconversion
  · rw [hconversion, _previous.molarLatentHeatCentral, _data.waterMolarMass]
    norm_num [abs_le]

end IPhO2026Problems.IPhO2026_4_B_6
... [leading content omitted]
```

### Blueprint excerpt
```tex
g declaration; unfolding it gives the stated typed data or relation.
\end{proof}

\begin{definition}[PreviousPartB5Result]
  \label{decl:physics:IPhO_2026_4_B_6:PreviousPartB5Result}
  \lean{IPhO2026Problems.IPhO2026_4_B_6.PreviousPartB5Result}
  \uses{decl:physics:IPhO_2026_4_B_6:VaporizationExperiment}
  The only imported previous-part conclusion: the B.5 graph has reported slope “-4700 ± 200 K” and gives “Q\_v = 39 ± 2 kJ/mol”.
\end{definition}
\begin{proof}
  This is the defining declaration; unfolding it gives the stated typed data or relation.
\end{proof}

\begin{theorem}[Physics formalization target]
\label{thm:physics:IPhO_2026_4_B_6:target}
\lean{IPhO2026Problems.IPhO2026_4_B_6.latentHeatPerUnitMass_from_molarEstimate}
\uses{decl:physics:IPhO_2026_4_B_6:energyDimension, decl:physics:IPhO_2026_4_B_6:specificEnergyDimension, decl:physics:IPhO_2026_4_B_6:Temperature, decl:physics:IPhO_2026_4_B_6:Length, decl:physics:IPhO_2026_4_B_6:Pressure, decl:physics:IPhO_2026_4_B_6:Mass, decl:physics:IPhO_2026_4_B_6:Energy, decl:physics:IPhO_2026_4_B_6:SpecificEnergy, decl:physics:IPhO_2026_4_B_6:siReadout, decl:physics:IPhO_2026_4_B_6:MolarLatentHeatEstimate, decl:physics:IPhO_2026_4_B_6:VaporizationExperiment, decl:physics:IPhO_2026_4_B_6:HasReferenceAndProcedureData, decl:physics:IPhO_2026_4_B_6:GoverningLaws, decl:physics:IPhO_2026_4_B_6:PreviousPartB5Result}
The assigned autoformalize agent should translate this physics problem into Lean declarations in the covered file, with theorem and lemma proof bodies written as `by sorry`.
\end{theorem}
\begin{proof}
This is an autoformalization task, not a proof task. Produce statements that can later be proved by the physics prover without weakening the physical model.
\end{proof}
% --- Archon physics formalization source end ---
... [leading content omitted]
```

### Report excerpt: `problem_IPhO_2026_4_B_6.lean.md`
```markdown
# IPhO 2026 Problem 4 B.6 prover result

## Result

- `latentHeatPerUnitMass_from_molarEstimate` is fully proved with no remaining
  `sorry`.
- The proof specializes the three governing energy/mass laws to one mole,
  derives `L_v = Q_v / M₀` using positivity of the molar mass, and verifies the
  stated `2190 ± 110 kJ/kg` band from `Q_v = 39 kJ/mol` and
  `M₀ = 0.018 kg/mol`.
- No declaration signature or physical hypothesis was changed.

## Verification

- `lake env lean IPhO2026Problems/problem_IPhO_2026_4_B_6.lean` succeeds.
- `lake build` succeeds.
- Lean LSP reports no diagnostics.
- Axiom/source verification reports no suspicious source patterns; the theorem
  depends only on the standard foundational axioms `propext`,
  `Classical.choice`, and `Quot.sound`.

## Blueprint status

- `IPhO2026Problems.IPhO2026_4_B_6.latentHeatPerUnitMass_from_molarEstimate`
  is ready for the automatically managed `\leanok` marker.

## Redraft needed

None.
```

### Report excerpt: `physics-grounding-IPhO2026Problems_problem_IPhO_2026_4_B_6.md`
```markdown
ust preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_4_B_6.MolarLatentHeatEstimate`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_4_B_6.Pressure`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_4_B_6.PreviousPartB5Result`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_4_B_6.SpecificEnergy`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_4_B_6.Temperature`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_4_B_6.VaporizationExperiment`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.

## Grounding gaps

- No unresolved LeanExplore grounding gaps were recorded by this preflight.
... [leading content omitted]
```
