# Deterministic Plan Candidate Pack

Iteration: 004
Exact objective count: 5

The loop has already selected and written these objectives. Do not scan
the rest of the corpus and do not replace, reorder, add, or remove targets.
Use the excerpts below only to write a concise per-target proof strategy.

## 1. `IPhO2026Problems/problem_IPhO_2026_1_B_2.lean`

- Open placeholders: 1
- Proof Review: retry; attempts=1
- Review reason: proof Review status=partial
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_1_B_2.tex`

### Lean excerpt
```lean
... [prefix omitted]
me : Figure1bFrame)
    (initial : Figure1bInitialConditions constants motion frame)
    (dynamics : CoulombDynamics constants motion)
    (orbit : ConicOrbitData)
    (orbitLaws : ConicOrbitLaws constants motion frame initial orbit)
    (uInfinity : Plane)
    (unbound : IsUnbound motion)
    (uInfinity_nonzero : uInfinity ≠ 0)
    (uInfinity_isAsymptoticRelativeVelocity :
      Tendsto (relativeVelocitySI motion) atTop (𝓝 uInfinity)) :
    signedDeflectionDegrees motion frame uInfinity < 0 ∧
      RoundsToNearestHundredth
        (signedDeflectionDegrees motion frame uInfinity)
        (-(83 : ℝ) / 5) := by
  have mu_positive : 0 < initial.mu := by
    rw [initial.mu_value]
    norm_num
  have eccentricity_positive : 0 < orbit.eccentricity :=
    lt_trans (by norm_num) orbitLaws.hyperbolicEccentricity
  have separation_tends_to_infinity :
      Tendsto (separationSI motion) atTop atTop := by
    simpa [IsUnbound] using unbound
  have relative_velocity_tends_to_uInfinity :
      Tendsto (relativeVelocitySI motion) atTop (𝓝 uInfinity) :=
    uInfinity_isAsymptoticRelativeVelocity
  have polar_angle_geometry := orbitLaws.polarAngleDefinition
  have polar_conic := orbitLaws.polarConicEquation
  -- The available conic laws control the asymptotic position angle, while
  -- the target concerns the limiting velocity angle.  A law identifying
  -- `uInfinity` with the outgoing conic-asymptote direction (and hence
  -- selecting that branch) is required to connect the facts above.
  sorry

end IPhO2026Problems.IPhO2026_1_B_2
```

### Blueprint excerpt
```tex
... [prefix omitted]
}
\label{ch:IPhO2026Problems_problem_IPhO_2026_1_B_2}

\paragraph{Problem source.}
At one instant a positron and an electron, each of mass m and charges of equal
magnitude and opposite sign, are separated by 100*a\_0.  Their velocities are
antiparallel and perpendicular to their separation.  Each particle has angular
momentum of magnitude mu*hbar about the center of mass.  The system is isolated,
classical, non-relativistic, and has only electrostatic interaction.  The Bohr
radius is a\_0 = 4*pi*epsilon\_0*hbar\textasciicircum{}2/(m*e\textasciicircum{}2), and k = 1/(4*pi*epsilon\_0).

Current subquestion:
For mu = 15/2 the pair is unbound. Find the angle between the asymptotic relative velocity u\_infinity and the initial positron line of motion.

\paragraph{Current subquestion.}
For mu = 15/2 the pair is unbound. Find the angle between the asymptotic relative velocity u\_infinity and the initial positron line of motion.

\paragraph{Recorded answer/context.}
The signed deflection is -16.60 degrees, i.e. 16.60 degrees below the initial line of motion.

\paragraph{Figure/image path.}
/root/proposal\_for\_physic/science-mango/ipho\_2026\_source/image/T1\_page-2.png

\paragraph{Formalization target.}
create a compiling Lean file with sorry bodies at `IPhO2026Problems/problem\_IPhO\_2026\_1\_B\_2.lean`. The Lean declarations must preserve the physical quantities, dimensions or dimensional roles, figure labels, governing-law hypotheses, and final relation expressed by this problem.
Use Mathlib/Physlib names found through LeanExplore where available. If a physics API is missing, introduce faithful local abstractions rather than scalar placeholder aliases.

\begin{definition}[Plane]
  \label{decl:physics:IPhO_2026_1_B_2:Plane}
  \lean{IPhO2026Problems.IPhO2026_1_B_2.Plane}
  The oriented two-dimensional plane containing the trajectories in Figure 1b.
\end{definition}
\begin{proof}
  This is the defining declaration; unfolding it gives the stated typed data or relation.
\end{proof}

\begin{definition}[velocityDimension]
  \label{decl:physics:IPhO_2026_1_B_2:velocityDimension}
  \lean{IPhO2026Problems.IPhO2026_1_B_2.velocityDimension}
  Velocity dimension “L T⁻¹”.
\end{definition}
\begin{proof}
  This is the defining declaration; unfolding it gives the stated typed data or relation.
\end{proof}

\begin{definition}[angularMomentumDimension]
  \label{decl:physics:IPhO_2026_1_B_2:angularMomentumDimension}
  \lean{IPhO2026Problems.IPhO2026_1_B_2.angularMomentumDimension
... [suffix omitted]
```

## 2. `IPhO2026Problems/problem_IPhO_2026_2_B_1.lean`

- Open placeholders: 1
- Proof Review: retry; attempts=1
- Review reason: proof Review status=partial
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_2_B_1.tex`

### Lean excerpt
```lean
... [prefix omitted]
_path_exists :
    ∀ θ, IsAdmissibleIncidenceAngle θ →
      ∃ path, setup.isPhysicalPath path ∧
        setup.isLimitingPathForRadius path (setup.radiusAtIncidence θ) ∧
        setup.isTangentToContainer path (setup.radiusAtIncidence θ) ∧
        path.reflectionPoints.length = 1 ∧
        setup.incidenceAngle path = θ

/-- The sinusoidal coefficient form supplied in part B.1, interpreted as a
symbolic identity for the radius response over the admissible angle range. -/
def IsRadiusCoefficientFormula
    (setup : SolarCookerSetup) (α β : PhysicalLength) : Prop :=
  ∀ θ, IsAdmissibleIncidenceAngle θ →
    setup.radiusAtIncidence θ =
      scaleLength (Real.sin θ) α +
        scaleLength (Real.sin (2 * θ)) β

/-- The ray geometry of Figure 2f gives the radius response before its two
trigonometric coefficients are read off. -/
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
  have htwice_qu
... [suffix omitted]
```

### Blueprint excerpt
```tex
... [prefix omitted]
reports/ipho_2026/problem_IPhO_2026_2_B_1.source.json
% archon:problem-id IPhO_2026_2
% archon:part-id B.1

\chapter{Physics problem IPhO\_2026\_2\_B\_1}
\label{ch:IPhO2026Problems_problem_IPhO_2026_2_B_1}

\paragraph{Problem source.}
A half-cylindrical mirror of radius R illuminates a fully absorbing cylindrical
container of radius a.  Their axes are parallel, and the container center lies
R/2 from the mirror center on the symmetry plane.  Uniform parallel sunlight
arrives along the optical axis.  Any ray absorbed by the container reflects at
most once.  Let theta\_max be the largest incidence angle on the mirror among
rays that strike the container, and let P\_0 be the power the cylinder would
receive without the mirror.  See Figure 2f.

Current subquestion:
Given a = alpha*sin(theta\_max) + beta*sin(2*theta\_max), determine alpha and beta in terms of R.

\paragraph{Current subquestion.}
Given a = alpha*sin(theta\_max) + beta*sin(2*theta\_max), determine alpha and beta in terms of R.

\paragraph{Recorded answer/context.}
alpha = R and beta = -R/2.

\paragraph{Figure/image path.}
/root/proposal\_for\_physic/science-mango/ipho\_2026\_source/image/T2\_page-3.png

\paragraph{Formalization target.}
create a compiling Lean file with sorry bodies at `IPhO2026Problems/problem\_IPhO\_2026\_2\_B\_1.lean`. The Lean declarations must preserve the physical quantities, dimensions or dimensional roles, figure labels, governing-law hypotheses, and final relation expressed by this problem.
Use Mathlib/Physlib names found through LeanExplore where available. If a physics API is missing, introduce faithful local abstractions rather than scalar placeholder aliases.

\begin{definition}[PhysicalLength]
  \label{decl:physics:IPhO_2026_2_B_1:PhysicalLength}
  \lean{IPhO2026Problems.IPhO2026_2_B_1.PhysicalLength}
  A physical length, represented by a dimension-tagged real readout.
\end{definition}
\begin{proof}
  This is the defining declaration; unfolding it gives the stated typed data or relation.
\end{proof}

\begin{definition}[radiantPowerDimension]
  \label{decl:physics:IPhO_2026_2_B_1:radiantPowerDimension}
  \lean{IPhO2026Problems.IPhO2026_2_B_1.radiantPowerDimension}
  The physical dimension “mass * length\textasciicircum{}2 * time\textasciicircum{}(-3)” of radiant power.
\end{definition}
\begin{proof}
  This is the defining declaration; unfolding it gives the stated typed data or relation.
\end{proof}

\begin{definition}[solarIntensityDimension]
  \label{decl:physics:I
... [suffix omitted]
```

## 3. `IPhO2026Problems/problem_IPhO_2026_3_B_2.lean`

- Open placeholders: 1
- Proof Review: retry; attempts=1
- Review reason: proof Review status=partial
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_3_B_2.tex`

### Lean excerpt
```lean
... [prefix omitted]
deriv (magnetizationAlongProcessInSI process) τ := by
    intro τ hτ
    rw [← laws.heatCapacityEquation τ (Set.Ioo_subset_Icc_self hτ)]
    rw [← laws.internalEnergyDifferential τ hτ]
    rw [laws.firstLaw_enteringPositive τ hτ]
    rw [laws.adiabatic_noHeat τ hτ, zero_add]
    exact laws.magneticWorkDifferential_previousA3 τ hτ
  have h_initial_temperature_value_positive : 0 < T_initial_K := by
    rw [← h_initial_temperature]
    exact h_initial_temperature_positive
  have h_initial_denominator_value_positive :
      0 <
        lambdaInSI torus.lambda +
          vacuumPermeabilityInSI torus.vacuumPermeability *
            curieConstantInSI torus.curieConstant *
            H_initial_SI ^ 2 := by
    rw [← h_initial_field]
    exact h_initial_denominator_positive
  have h_final_denominator_value_positive :
      0 <
        lambdaInSI torus.lambda +
          vacuumPermeabilityInSI torus.vacuumPermeability *
            curieConstantInSI torus.curieConstant *
            H_final_SI ^ 2 := by
    rw [← h_final_field]
    exact h_final_denominator_positive
  /-
  The remaining step is to differentiate the equation of state, combine it
  with `h_adiabatic_energy_balance`, and apply the mean-value theorem to the
  invariant

    T(τ)^2 / (λ + μ₀ K H(τ)^2).

  The assigned module imports `Deriv.Basic`, which provides `deriv` itself,
  but it does not import the product/quotient derivative rules or the
  mean-value theorem needed to justify this global endpoint step.
  -/
  sorry

end IPhO2026Problems.IPhO2026_3_B_2
```

### Blueprint excerpt
```tex
... [prefix omitted]
26Problems_problem_IPhO_2026_3_B_2}

\paragraph{Problem source.}
Continue with the paramagnetic torus.  Its equation of state is T*M*V = n*K*H,
its heat capacity at constant M is C\_M = n*lambda/T\textasciicircum{}2, and dU = C\_M*dT.
The volume is fixed and the magnetic work on the material is
dW = mu\_0*V*H*dM.  Work and heat entering the torus are positive.

Current subquestion:
For an adiabatic change H\_i -> H\_f starting at T\_i, determine Delta T = T\_f - T\_i.

\paragraph{Current subquestion.}
For an adiabatic change H\_i -> H\_f starting at T\_i, determine Delta T = T\_f - T\_i.

\paragraph{Recorded answer/context.}
Delta T = T\_i*[sqrt((lambda + mu\_0*K*H\_f\textasciicircum{}2)/(lambda + mu\_0*K*H\_i\textasciicircum{}2)) - 1].

\paragraph{Figure/image path.}
/root/proposal\_for\_physic/science-mango/ipho\_2026\_source/image/T3\_page-3.png

\paragraph{Reusable previous-part conclusions.}
\begin{itemize}
\item Source A.3. Question: Subtract the vacuum-core contribution and write the work dW done on the paramagnetic material. Reusable conclusions: dW = mu\_0*V*H*dM. Policy: natural\_language\_prerequisite\_only; do\_not\_import\_Lean\_output
\end{itemize}

\paragraph{Formalization target.}
create a compiling Lean file with sorry bodies at `IPhO2026Problems/problem\_IPhO\_2026\_3\_B\_2.lean`. The Lean declarations must preserve the physical quantities, dimensions or dimensional roles, figure labels, governing-law hypotheses, and final relation expressed by this problem.
Use Mathlib/Physlib names found through LeanExplore where available. If a physics API is missing, introduce faithful local abstractions rather than scalar placeholder aliases.

\begin{definition}[ThermodynamicTemperature]
  \label{decl:physics:IPhO_2026_3_B_2:ThermodynamicTemperature}
  \lean{IPhO2026Problems.IPhO2026_3_B_2.ThermodynamicTemperature}
  Absolute thermodynamic temperature, with physical dimension temperature.
\end{definition}
\begin{proof}
  This is the defining declaration; unfolding it gives the stated typed data or relation.
\end{proof}

\begin{definition}[PhysicalVolume]
  \label{decl:physics:IPhO_2026_3_B_2:PhysicalVolume}
  \lean{IPhO2026Problems.IPhO2026_3_B_2.PhysicalVolume}
  The fixed physical volume of the paramagnetic torus.
\end{definition}
\begin{proof}
  This is the defining declaration; unfolding it gives the stated typed data or relation.
\end{proof}

\begin{definition}[AppliedFieldStrengthMagnitude]
  \label{decl:physics:IPhO_2026_3_B_2:AppliedFieldStre
... [suffix omitted]
```

## 4. `IPhO2026Problems/problem_IPhO_2026_4_B_6.lean`

- Open placeholders: 0
- Proof Review: retry; attempts=1
- Review reason: proof Review status=partial
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_4_B_6.tex`

### Lean excerpt
```lean
... [prefix omitted]
periment.vaporPressureScalePv0) =
        -(experiment.molarLatentHeatQv.centralJoulesPerMole /
            experiment.gasConstantJoulesPerMoleKelvin) *
          (1 / siReadout temperature -
            1 / siReadout experiment.referenceTemperatureT0)
  vaporizedMassFromMoles :
    ∀ amountMol : ℝ, 0 < amountMol →
      siReadout (experiment.vaporizedWaterMassForAmountMol amountMol) =
        experiment.waterMolarMassM0KilogramsPerMole * amountMol
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
```

### Blueprint excerpt
```tex
... [prefix omitted]
ylinder contains dry air plus water vapor at total pressure
approximately P\_atm.  The water level is adjusted and its height H is recorded
as temperature T falls.  At T\_0 = 273.15 K, extrapolated height is H\_0 and the
water vapor pressure may be taken as zero.  Vapor pressure obeys
ln(P\_v/P\_v0) = -(Q\_v/R)*(1/T - 1/T\_0).  Use the experimental procedure and
geometry on pages 11--12.

Current subquestion:
Convert Q\_v into latent heat per unit mass L\_v and state the formula.

\paragraph{Current subquestion.}
Convert Q\_v into latent heat per unit mass L\_v and state the formula.

\paragraph{Recorded answer/context.}
L\_v = Q\_v/M\_0 = 2190 +/- 110 kJ/kg.

\paragraph{Figure/image path.}
/root/proposal\_for\_physic/science-mango/ipho\_2026\_source/image/E1\_page-12.png

\paragraph{Reusable previous-part conclusions.}
\begin{itemize}
\item Source B.5. Question: Construct a Clausius-Clapeyron graph and use it to determine the molar latent heat Q\_v. Reusable conclusions: Plot ln(P\_v/P\_atm) against 1/T; official sample slope is -4700 +/- 200 K and Q\_v = 39 +/- 2 kJ/mol. Policy: natural\_language\_prerequisite\_only; do\_not\_import\_Lean\_output
\end{itemize}

\paragraph{Formalization target.}
create a compiling Lean file with sorry bodies at `IPhO2026Problems/problem\_IPhO\_2026\_4\_B\_6.lean`. The Lean declarations must preserve the physical quantities, dimensions or dimensional roles, figure labels, governing-law hypotheses, and final relation expressed by this problem.
Use Mathlib/Physlib names found through LeanExplore where available. If a physics API is missing, introduce faithful local abstractions rather than scalar placeholder aliases.

\begin{definition}[energyDimension]
  \label{decl:physics:IPhO_2026_4_B_6:energyDimension}
  \lean{IPhO2026Problems.IPhO2026_4_B_6.energyDimension}
  The mechanical dimension of energy.
\end{definition}
\begin{proof}
  This is the defining declaration; unfolding it gives the stated typed data or relation.
\end{proof}

\begin{definition}[specificEnergyDimension]
  \label{decl:physics:IPhO_2026_4_B_6:specificEnergyDimension}
  \lean{IPhO2026Problems.IPhO2026_4_B_6.specificEnergyDimension}
  \uses{decl:physics:IPhO_2026_4_B_6:energyDimension}
  The dimension of energy per unit mass.
\end{definition}
\begin{proof}
  This is the defining declaration; unfolding it gives the stated typed data or relation.
\end{proof}

\begin{definition}[Temperature]
  \label{decl:physics:IPhO_2026_4_B_6:Temperature}
  \lean{IPhO2026Pr
... [suffix omitted]
```

## 5. `IPhO2026Problems/problem_IPhO_2026_4_C_7.lean`

- Open placeholders: 1
- Proof Review: retry; attempts=1
- Review reason: proof Review status=partial
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_4_C_7.tex`

### Lean excerpt
```lean
... [prefix omitted]
eatFlow
          observationTimeSeconds) =
        -κ * (2 * Real.pi * radiusMeters * h) *
          experiment.radialTemperatureGradientKelvinPerMeter
            observationTimeSeconds radiusMeters at hfourier
    rw [horientation, hflow] at hfourier
    dsimp [coefficient]
    field_simp [ne_of_gt hR_pos, ne_of_gt hκ_pos,
      ne_of_gt Real.pi_pos, ne_of_gt hh_pos, ne_of_gt hradius_pos]
      at hfourier ⊢
    nlinarith

  have hprofile_deriv : ∀ radiusMeters ∈ Set.Ico r₁ r₂,
      HasDerivWithinAt profile (coefficient * radiusMeters⁻¹)
        (Set.Ici radiusMeters) radiusMeters := by
    intro radiusMeters hradius
    have hbase :=
      laws.radial_temperature_has_gradient observationTimeSeconds
        radiusMeters ⟨hradius.1, le_of_lt hradius.2⟩
    rw [hgradient radiusMeters ⟨hradius.1, le_of_lt hradius.2⟩] at hbase
    exact hbase.hasDerivWithinAt

  have hprofile_cont : ContinuousOn profile (Set.Icc r₁ r₂) := by
    intro radiusMeters hradius
    exact
      (laws.radial_temperature_has_gradient observationTimeSeconds
        radiusMeters (by simpa [r₁, r₂] using hradius)).continuousAt.continuousWithinAt

  have hendpoint :
      ΔT = coefficient * (Real.log r₂ - Real.log r₁) := by
    -- The hypotheses above establish the complete ODE and its continuity
    -- premises.  Closing this endpoint identity uses
    -- `Real.hasDerivAt_log` and `eq_of_has_deriv_right_eq`, but the modules
    -- defining those declarations are not among this file's frozen imports.
    sorry
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
```

### Blueprint excerpt
```tex
... [prefix omitted]
ource.}
Water in the inner and outer cylinders exchanges heat radially through an
acrylic cylindrical wall.  Record T\_IC and T\_OC versus time.  The heat-flow
model is dQ/dt = (T\_OC - T\_IC)/R\_Th.  For radial Fourier conduction,
dQ/dt = -lambda*A*dT/dr.  Ignore apparatus heat capacity where instructed and
use the dimensions in Figure 17.

Current subquestion:
Combine the heat-flow relation and radial Fourier law to determine acrylic conductivity lambda.

\paragraph{Current subquestion.}
Combine the heat-flow relation and radial Fourier law to determine acrylic conductivity lambda.

\paragraph{Recorded answer/context.}
lambda = ln(r\_2/r\_1)/(2*pi*h*R\_Th). Official sample: lambda = 0.25 +/- 0.01 W/(m*K).

\paragraph{Figure/image path.}
/root/proposal\_for\_physic/science-mango/ipho\_2026\_source/image/E1\_page-14.png

\paragraph{Reusable previous-part conclusions.}
\begin{itemize}
\item Source C.6. Question: Determine the effective wall thermal resistance R\_Th from the C5 graph. Reusable conclusions: R\_Th = 1/(c\_0*m*slope). Official sample: R\_Th = 1.17 +/- 0.03 K/W. Policy: natural\_language\_prerequisite\_only; do\_not\_import\_Lean\_output
\end{itemize}

\paragraph{Formalization target.}
create a compiling Lean file with sorry bodies at `IPhO2026Problems/problem\_IPhO\_2026\_4\_C\_7.lean`. The Lean declarations must preserve the physical quantities, dimensions or dimensional roles, figure labels, governing-law hypotheses, and final relation expressed by this problem.
Use Mathlib/Physlib names found through LeanExplore where available. If a physics API is missing, introduce faithful local abstractions rather than scalar placeholder aliases.

\begin{definition}[powerDimension]
  \label{decl:physics:IPhO_2026_4_C_7:powerDimension}
  \lean{IPhO2026Problems.IPhO2026_4_C_7.powerDimension}
  The physical dimension of energy per unit time.
\end{definition}
\begin{proof}
  This is the defining declaration; unfolding it gives the stated typed data or relation.
\end{proof}

\begin{definition}[thermalResistanceDimension]
  \label{decl:physics:IPhO_2026_4_C_7:thermalResistanceDimension}
  \lean{IPhO2026Problems.IPhO2026_4_C_7.thermalResistanceDimension}
  \uses{decl:physics:IPhO_2026_4_C_7:powerDimension}
  The physical dimension kelvin per watt.
\end{definition}
\begin{proof}
  This is the defining declaration; unfolding it gives the stated typed data or relation.
\end{proof}

\begin{definition}[thermalConductivityDimension]
  \label{decl:physics:IPhO_2026_4_
... [suffix omitted]
```
