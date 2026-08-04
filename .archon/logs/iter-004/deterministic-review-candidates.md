# Deterministic Review Candidate Pack

Iteration: 004
Exact review target count: 5

Review only these targets. Direct Lean compilation was already run in
parallel by the orchestrator; use the recorded result instead of rerunning it.

## 1. `IPhO2026Problems/problem_IPhO_2026_1_B_2.lean`

- Compile status: passed
- Open sorries: 1
- Direct-check seconds: 22.095
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_1_B_2.tex`
- Reports: `.archon/task_results/IPhO2026Problems_problem_IPhO_2026_1_B_2.lean.md`, `.archon/task_results/physics-grounding-IPhO2026Problems_problem_IPhO_2026_1_B_2.md`

### Lean excerpt
```lean
:= by
    have hconic := polar_conic seconds
    have hsep_ne := ne_of_gt (separation_positive seconds)
    have hden_ne := ne_of_gt (conic_denominator_positive seconds)
    field_simp [hsep_ne, hden_ne] at hconic ⊢
    linarith
  have cartesian_conic_equation (seconds : ℝ) :
      separationSI motion seconds -
          orbit.eccentricity *
            ⟪orbit.periapsisAxis,
              relativeDisplacementSI motion seconds⟫ =
        scalarSI orbit.semiLatusRectum_a := by
    have hsep_ne := ne_of_gt (separation_positive seconds)
    have hden := conic_denominator_eq seconds
    rw [polar_cosine_geometry seconds] at hden
    field_simp [hsep_ne] at hden
    linarith
  have conic_denominator_tends_to_zero :
      Tendsto
        (fun seconds =>
          1 - orbit.eccentricity *
            Real.cos (orbit.polarAngleRad seconds))
        atTop (𝓝 0) := by
    exact
      (tendsto_const_nhds.div_atTop separation_tends_to_infinity).congr'
        (Filter.Eventually.of_forall fun seconds =>
          (conic_denominator_eq seconds).symm)
  have polar_cosine_tends_to_inverse_eccentricity :
      Tendsto
        (fun seconds => Real.cos (orbit.polarAngleRad seconds))
        atTop (𝓝 (1 / orbit.eccentricity)) := by
    have hone :
        Tendsto (fun _ : ℝ => (1 : ℝ)) atTop (𝓝 1) :=
      tendsto_const_nhds
    have h :=
      (hone.sub conic_denominator_tends_to_zero).div_const
        orbit.eccentricity
    convert h using 1
    · ext seconds
      field_simp [ne_of_gt eccentricity_positive]
      ring
    · norm_num
  have polar_cosine_tends_to_two_sevenths :
      Tendsto
        (fun seconds => Real.cos (orbit.polarAngleRad seconds))
        atTop (𝓝 ((2 : ℝ) / 7)) := by
    simpa [eccentricity_value] using
      polar_cosine_tends_to_inverse_eccentricity
  have normalized_displacement_axis_component_tends :
      Tendsto
        (fun seconds =>
          ⟪orbit.periapsisAxis,
            relativeDisplacementSI motion seconds⟫ /
            separationSI motion seconds)
        atTop (𝓝 (1 / orbit.eccentricity)) := by
    exact polar_cosine_tends_to_inverse_eccentricity.congr'
      (Filter.Eventually.of_forall fun seconds =>
        polar_cosine_geometry seconds)
  -- The available conic laws control the asymptotic position angle, while
  -- the target concerns the limiting velocity angle.  The contract has no
  -- stated theorem identifying its nonzero limiting velocity with the
  -- outgoing branch of the conic asymptote.  Such a branch law is required
  -- before the signed numerical angle can be deduced.
  sorry

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

### Report excerpt: `IPhO2026Problems_problem_IPhO_2026_1_B_2.lean.md`
```markdown
Direction`.

After that bridge, the final remaining analytic obligation is a certified
enclosure showing that
`-Real.arcsin (2 / 7) * 180 / Real.pi` lies within `1/200` degree of `-83/5`.

## Redraft needed

- Original problem: `IPhO_2026_1`, part B.2.
- Source report:
  `reports/ipho_2026/problem_IPhO_2026_1_B_2.source.json`.
- Theorem:
  `IPhO2026Problems.IPhO2026_1_B_2.IPhO_2026_1_B_2`.
- Issue: the frozen theorem requires a substantial unstated
  derivative-to-outgoing-asymptote branch theorem before the supplied polar
  conic law can control the signed limiting-velocity angle.
- Smallest faithful change: add a general (non-numerical) outgoing hyperbolic
  asymptote hypothesis, for example
  `frame.orientation.oangle (velocitySI motion .positron 0) uInfinity =
    ((-Real.arcsin (1 / orbit.eccentricity) : ℝ) : Real.Angle)`.
  This states the missing general scattering law without assuming the rounded
  answer. The already-proved `eccentricity = 7/2` then reduces the target to a
  standalone rigorous arcsine enclosure.

## Blueprint marker

The theorem proof is not ready for proof-block `\leanok`; the deterministic
sync should leave it unmarked while the focused `sorry` remains.
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
- Direct-check seconds: 5.733
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_2_B_1.tex`
- Reports: `.archon/task_results/IPhO2026Problems_problem_IPhO_2026_2_B_1.lean.md`, `.archon/task_results/physics-grounding-IPhO2026Problems_problem_IPhO_2026_2_B_1.md`

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

### Report excerpt: `IPhO2026Problems_problem_IPhO_2026_2_B_1.lean.md`
```markdown
geometry helper.

## Redraft needed

- Original problem: `IPhO_2026_2`, part `B.1`.
- Source report:
  `reports/ipho_2026/problem_IPhO_2026_2_B_1.source.json`.
- Theorems: `radiusAtIncidence_from_figure2f` and, transitively,
  `problem_IPhO_2026_2_B_1`.
- Why the current statement is not provable: `radiusAtIncidence`,
  `isLimitingPathForRadius`, and `isTangentToContainer` are independent
  abstract fields. `ValidSolarCookerPhysics` asserts existence of paths with
  these predicates but supplies no law connecting them to the Figure 2f
  center displacement or the claimed sine radius response. The formal
  countermodel above satisfies all hypotheses and refutes both conclusions.
- Smallest faithful change: add a governing-law field to
  `ValidSolarCookerPhysics` saying that an admissible, one-reflection
  limiting tangent path of incidence `θ` implies
  ```
  setup.radiusAtIncidence θ =
    scaleLength
      (Real.sin θ - (1 / 2) * Real.sin (2 * θ))
      setup.mirrorRadius
  ```
  with the corresponding path hypotheses. The existing witness extraction
  would then prove `radiusAtIncidence_from_figure2f`, and the already-closed
  coefficient argument would finish the final theorem.
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

## 3. `IPhO2026Problems/problem_IPhO_2026_3_B_2.lean`

- Compile status: passed
- Open sorries: 0
- Direct-check seconds: 21.134
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_3_B_2.tex`
- Reports: `.archon/task_results/physics-grounding-IPhO2026Problems_problem_IPhO_2026_3_B_2.md`

### Lean excerpt
```lean
(T τ * T τ) *
            (mu * K *
              (deriv H τ * H τ + H τ * deriv H τ)) = 0 := by
      linear_combination 2 * T τ * h_ode τ hτ
    have h_quotient_zero :
        ((deriv T τ * T τ + T τ * deriv T τ) * D τ -
          (T τ * T τ) *
            (mu * K *
              (deriv H τ * H τ + H τ * deriv H τ))) /
            D τ ^ 2 = 0 := by
      rw [div_eq_zero_iff]
      exact Or.inl h_numerator_zero
    have hF_has : HasDerivAt F 0 τ := by
      change HasDerivAt ((fun s => T s * T s) / D) 0 τ
      rw [← h_quotient_zero]
      exact h_quot
    exact hF_has.deriv
  obtain ⟨c, hc, hc_slope⟩ :=
    exists_deriv_eq_slope F (by norm_num) hF_diff.continuousOn
      (hF_diff.mono Set.Ioo_subset_Icc_self)
  have hc_zero := hF_deriv_zero c hc
  rw [hc_zero] at hc_slope
  have hF_endpoints : F 1 = F 0 := by
    norm_num at hc_slope
    linarith
  have hT0 : T 0 = T_initial_K := by
    simpa only [T] using h_initial_temperature
  have hH0 : H 0 = H_initial_SI := by
    simpa only [H] using h_initial_field
  have hH1 : H 1 = H_final_SI := by
    simpa only [H] using h_final_field
  have hD0 :
      D 0 = lam + mu * K * H_initial_SI ^ 2 := by
    simp only [D, hH0]
    ring
  have hD1 :
      D 1 = lam + mu * K * H_final_SI ^ 2 := by
    simp only [D, hH1]
    ring
  have hD0_pos : 0 < D 0 := hD_pos 0 h_zero_mem
  have hD1_pos : 0 < D 1 := hD_pos 1 h_one_mem
  have h_square_cross :
      T 1 ^ 2 * D 0 = T 0 ^ 2 * D 1 := by
    apply
      (div_eq_div_iff (ne_of_gt hD1_pos) (ne_of_gt hD0_pos)).mp
    simpa only [F, pow_two] using hF_endpoints
  have h_ratio_pos : 0 < D 1 / D 0 :=
    div_pos hD1_pos hD0_pos
  have h_square_ratio :
      T 1 ^ 2 = T 0 ^ 2 * (D 1 / D 0) := by
    field_simp [ne_of_gt hD0_pos]
    exact h_square_cross
  have h_candidate_square :
      (T 0 * Real.sqrt (D 1 / D 0)) ^ 2 = T 1 ^ 2 := by
    calc
      (T 0 * Real.sqrt (D 1 / D 0)) ^ 2 =
          T 0 ^ 2 * Real.sqrt (D 1 / D 0) ^ 2 := by
            ring
      _ = T 0 ^ 2 * (D 1 / D 0) := by
        rw [Real.sq_sqrt h_ratio_pos.le]
      _ = T 1 ^ 2 := h_square_ratio.symm
  have h_candidate_pos :
      0 < T 0 * Real.sqrt (D 1 / D 0) :=
    mul_pos (hT_pos 0 h_zero_mem) (Real.sqrt_pos.2 h_ratio_pos)
  have hT1_formula :
      T 1 = T 0 * Real.sqrt (D 1 / D 0) := by
    nlinarith [h_candidate_square, hT_pos 1 h_one_mem]
  change
    T 1 - T_initial_K =
      T_initial_K *
        (Real.sqrt
            ((lam + mu * K * H_final_SI ^ 2) /
              (lam + mu * K * H_initial_SI ^ 2)) -
          1)
  rw [hT1_formula, hT0, hD1, hD0]
  ring

end IPhO2026Problems.IPhO2026_3_B_2
... [leading content omitted]
```

### Blueprint excerpt
```tex
on target]
\label{thm:physics:IPhO_2026_3_B_2:target}
\lean{IPhO2026Problems.IPhO2026_3_B_2.adiabatic_temperature_change}
\uses{decl:physics:IPhO_2026_3_B_2:ThermodynamicTemperature, decl:physics:IPhO_2026_3_B_2:PhysicalVolume, decl:physics:IPhO_2026_3_B_2:AppliedFieldStrengthMagnitude, decl:physics:IPhO_2026_3_B_2:MagnetizationMagnitude, decl:physics:IPhO_2026_3_B_2:VacuumPermeability, decl:physics:IPhO_2026_3_B_2:CurieConstantPerMole, decl:physics:IPhO_2026_3_B_2:LambdaPerMole, decl:physics:IPhO_2026_3_B_2:HeatCapacityAtConstantMagnetization, decl:physics:IPhO_2026_3_B_2:temperatureInKelvin, decl:physics:IPhO_2026_3_B_2:volumeInCubicMeters, decl:physics:IPhO_2026_3_B_2:fieldStrengthInSI, decl:physics:IPhO_2026_3_B_2:magnetizationInSI, decl:physics:IPhO_2026_3_B_2:vacuumPermeabilityInSI, decl:physics:IPhO_2026_3_B_2:curieConstantInSI, decl:physics:IPhO_2026_3_B_2:lambdaInSI, decl:physics:IPhO_2026_3_B_2:heatCapacityInSI, decl:physics:IPhO_2026_3_B_2:energyInJoules, decl:physics:IPhO_2026_3_B_2:ParamagneticTorus, decl:physics:IPhO_2026_3_B_2:ParamagneticTorusState, decl:physics:IPhO_2026_3_B_2:ParamagneticTorusProcess, decl:physics:IPhO_2026_3_B_2:temperatureAlongProcessInKelvin, decl:physics:IPhO_2026_3_B_2:fieldStrengthAlongProcessInSI, decl:physics:IPhO_2026_3_B_2:magnetizationAlongProcessInSI, decl:physics:IPhO_2026_3_B_2:SatisfiesParamagneticTorusLaws}
The assigned autoformalize agent should translate this physics problem into Lean declarations in the covered file, with theorem and lemma proof bodies written as `by sorry`.
\end{theorem}
\begin{proof}
This is an autoformalization task, not a proof task. Produce statements that can later be proved by the physics prover without weakening the physical model.
\end{proof}
% --- Archon physics formalization source end ---
... [leading content omitted]
```

### Report excerpt: `physics-grounding-IPhO2026Problems_problem_IPhO_2026_3_B_2.md`
```markdown
tead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_3_B_2.ParamagneticTorusProcess`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_3_B_2.ParamagneticTorusState`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_3_B_2.PhysicalVolume`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_3_B_2.SatisfiesParamagneticTorusLaws`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_3_B_2.ThermodynamicTemperature`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_3_B_2.VacuumPermeability`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.

## Grounding gaps

- No unresolved LeanExplore grounding gaps were recorded by this preflight.
... [leading content omitted]
```

## 4. `IPhO2026Problems/problem_IPhO_2026_4_B_6.lean`

- Compile status: passed
- Open sorries: 0
- Direct-check seconds: 9.254
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_4_B_6.tex`
- Reports: `.archon/task_results/IPhO2026Problems_problem_IPhO_2026_4_B_6.lean.md`, `.archon/task_results/physics-grounding-IPhO2026Problems_problem_IPhO_2026_4_B_6.md`

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

### Report excerpt: `IPhO2026Problems_problem_IPhO_2026_4_B_6.lean.md`
```markdown
`, or file-specific `USER` comment.
- The assigned file is byte-for-byte identical to the iteration-004 baseline
  (SHA-256
  `dbb124ad902064746e192cda5fec63a4bc7c9616cd20c87c1e1b751b6a82f13f`).

## Review retry disposition

The session-3 recommendation concerns the *statement's* interpretation of
`±110`: the frozen conclusion records an enclosure for the central `L_v`
readout rather than a separate propagated-uncertainty formula. That concern
cannot be changed by editing only the proof body. The formalization gate has
already passed this signature, and the iteration-004 plan explicitly directs
rechecking the proof unchanged, so no unauthorized signature change was made.

## Blueprint status

The theorem environment `thm:physics:IPhO_2026_4_B_6:target` is ready for its
proof `\leanok` marker. Per prover permissions, the blueprint was not edited;
deterministic marker synchronization should apply it.

## Needs blueprint entry

None. No declarations were added.

## Redraft needed

None for the frozen contract. The proof obligation is sound and fully closed.

## Why I stopped

The assigned theorem has no placeholder, compiles unchanged, and passes all
requested proof and source checks.
... [leading content omitted]
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

## 5. `IPhO2026Problems/problem_IPhO_2026_4_C_7.lean`

- Compile status: passed
- Open sorries: 0
- Direct-check seconds: 6.728
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_4_C_7.tex`
- Reports: `.archon/task_results/physics-grounding-IPhO2026Problems_problem_IPhO_2026_4_C_7.md`

### Lean excerpt
```lean
sMeters (by simpa [r₁, r₂] using hradius)).continuousAt.continuousWithinAt

  have hendpoint :
      ΔT = coefficient * (Real.log r₂ - Real.log r₁) := by
    let model : ℝ → ℝ := fun radiusMeters =>
      profile r₁ +
        coefficient * (Real.log radiusMeters - Real.log r₁)
    have hmodel_deriv : ∀ radiusMeters ∈ Set.Ico r₁ r₂,
        HasDerivWithinAt model (coefficient * radiusMeters⁻¹)
          (Set.Ici radiusMeters) radiusMeters := by
      intro radiusMeters hradius
      have hradius_pos : 0 < radiusMeters :=
        lt_of_lt_of_le hr₁_pos hradius.1
      have hlog :=
        Real.hasDerivAt_log (ne_of_gt hradius_pos)
      have hmodel_at :
          HasDerivAt model (coefficient * radiusMeters⁻¹)
            radiusMeters := by
        simpa [model] using
          ((hlog.sub_const (Real.log r₁)).const_mul coefficient).const_add
            (profile r₁)
      exact hmodel_at.hasDerivWithinAt
    have hmodel_cont : ContinuousOn model (Set.Icc r₁ r₂) := by
      intro radiusMeters hradius
      have hradius_pos : 0 < radiusMeters :=
        lt_of_lt_of_le hr₁_pos hradius.1
      have hlog :=
        Real.hasDerivAt_log (ne_of_gt hradius_pos)
      have hmodel_at :
          HasDerivAt model (coefficient * radiusMeters⁻¹)
            radiusMeters := by
        simpa [model] using
          ((hlog.sub_const (Real.log r₁)).const_mul coefficient).const_add
            (profile r₁)
      exact hmodel_at.continuousAt.continuousWithinAt
    have hprofiles_agree :
        profile r₂ = model r₂ :=
      eq_of_has_deriv_right_eq hprofile_deriv hmodel_deriv
        hprofile_cont hmodel_cont (by simp [model]) r₂
        ⟨le_of_lt hr₂_gt, le_rfl⟩
    have hinner :
        profile r₁ =
          siValue (experiment.innerTemperature observationTimeSeconds) := by
      simpa [profile, r₁] using
        laws.inner_boundary_temperature observationTimeSeconds
    have houter :
        profile r₂ =
          siValue (experiment.outerTemperature observationTimeSeconds) := by
      simpa [profile, r₂] using
        laws.outer_boundary_temperature observationTimeSeconds
    dsimp [ΔT]
    rw [← houter, ← hinner]
    dsimp [model] at hprofiles_agree
    linarith
  have hlog_div :
      Real.log (r₂ / r₁) = Real.log r₂ - Real.log r₁ :=
    Real.log_div (ne_of_gt hr₂_pos) (ne_of_gt hr₁_pos)
  rw [← hlog_div] at hendpoint
  dsimp [coefficient] at hendpoint

  change κ = Real.log (r₂ / r₁) / (2 * Real.pi * h * R)
  field_simp [ne_of_gt hR_pos, ne_of_gt hκ_pos,
    ne_of_gt Real.pi_pos, ne_of_gt hh_pos, hΔT_ne] at hendpoint ⊢
  nlinarith

end IPhO2026Problems.IPhO2026_4_C_7
... [leading content omitted]
```

### Blueprint excerpt
```tex
MetersSquared}
  The governing physical laws for the experiment.
\end{definition}
\begin{proof}
  This is the defining declaration; unfolding it gives the stated typed data or relation.
\end{proof}

\begin{theorem}[Physics formalization target]
\label{thm:physics:IPhO_2026_4_C_7:target}
\lean{IPhO2026Problems.IPhO2026_4_C_7.acrylicConductivity_from_radial_fourier}
\uses{decl:physics:IPhO_2026_4_C_7:powerDimension, decl:physics:IPhO_2026_4_C_7:thermalResistanceDimension, decl:physics:IPhO_2026_4_C_7:thermalConductivityDimension, decl:physics:IPhO_2026_4_C_7:specificHeatCapacityDimension, decl:physics:IPhO_2026_4_C_7:DimLength, decl:physics:IPhO_2026_4_C_7:DimMass, decl:physics:IPhO_2026_4_C_7:DimTemperature, decl:physics:IPhO_2026_4_C_7:DimPower, decl:physics:IPhO_2026_4_C_7:DimThermalResistance, decl:physics:IPhO_2026_4_C_7:DimThermalConductivity, decl:physics:IPhO_2026_4_C_7:DimSpecificHeatCapacity, decl:physics:IPhO_2026_4_C_7:DimInverseTime, decl:physics:IPhO_2026_4_C_7:siValue, decl:physics:IPhO_2026_4_C_7:ApparatusGeometry, decl:physics:IPhO_2026_4_C_7:Figure17AndProcedureReadout, decl:physics:IPhO_2026_4_C_7:PreviousPartC6Data, decl:physics:IPhO_2026_4_C_7:PreviousPartC6Result, decl:physics:IPhO_2026_4_C_7:ThermalConductionExperiment, decl:physics:IPhO_2026_4_C_7:cylindricalWallAreaMetersSquared, decl:physics:IPhO_2026_4_C_7:CylindricalConductionLaws}
The assigned autoformalize agent should translate this physics problem into Lean declarations in the covered file, with theorem and lemma proof bodies written as `by sorry`.
\end{theorem}
\begin{proof}
This is an autoformalization task, not a proof task. Produce statements that can later be proved by the physics prover without weakening the physical model.
\end{proof}
% --- Archon physics formalization source end ---
... [leading content omitted]
```

### Report excerpt: `physics-grounding-IPhO2026Problems_problem_IPhO_2026_4_C_7.md`
```markdown
ad of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_4_C_7.DimThermalConductivity`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_4_C_7.DimThermalResistance`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_4_C_7.Figure17AndProcedureReadout`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_4_C_7.PreviousPartC6Data`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_4_C_7.PreviousPartC6Result`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_4_C_7.ThermalConductionExperiment`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.

## Grounding gaps

- No unresolved LeanExplore grounding gaps were recorded by this preflight.
... [leading content omitted]
```
