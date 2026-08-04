# Deterministic Review Candidate Pack

Iteration: 003
Exact review target count: 28

Review only these targets. Direct Lean compilation was already run in
parallel by the orchestrator; use the recorded result instead of rerunning it.

## 1. `IPhO2026Problems/problem_IPhO_2026_1_A_1.lean`

- Compile status: passed
- Open sorries: 0
- Direct-check seconds: 24.065
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_1_A_1.tex`
- Reports: `.archon/task_results/IPhO2026Problems_problem_IPhO_2026_1_A_1.lean.md`, `.archon/task_results/physics-grounding-IPhO2026Problems_problem_IPhO_2026_1_A_1.md`

### Lean excerpt
```lean
ctiveWeightMomentAboutO,
    hLaws.pressureResultant, hLaws.effectiveWeight,
    hLaws.hydrostaticPressureDifference, hFigure.slotArea,
    hFigure.cubeVolume, hFigure.pressureLeverArm,
    hFigure.effectiveWeightLeverArm, hFigure.slotVerticalSize,
    hSetup.cubeDensityRatio] at hbalance
  have hfactor :
      state.waterDensitySI.val * state.gravitationalAccelerationSI.val *
          geometry.cubeSideSI.val ^ 3 *
          (state.maximumLevelDifferenceSI.val * Real.sqrt 2 -
            4 * geometry.cubeSideSI.val) = 0 := by
    field_simp [hsqrt2_ne] at hbalance
    rw [hsqrt2_cube] at hbalance
    linear_combination (1 / 2) * hbalance
  have hphysical_ne :
      state.waterDensitySI.val * state.gravitationalAccelerationSI.val *
          geometry.cubeSideSI.val ^ 3 ≠ 0 := by
    exact mul_ne_zero
      (mul_ne_zero (ne_of_gt hSetup.waterDensity_pos)
        (ne_of_gt hSetup.gravitationalAcceleration_pos))
      (pow_ne_zero 3 (ne_of_gt hSetup.cubeSide_pos))
  have hremaining :
      state.maximumLevelDifferenceSI.val * Real.sqrt 2 -
          4 * geometry.cubeSideSI.val = 0 :=
    (mul_eq_zero.mp hfactor).resolve_left hphysical_ne
  have hside :
      geometry.cubeSideSI.val =
        state.maximumLevelDifferenceSI.val / (2 * Real.sqrt 2) := by
    have hsqrt2_recip :
        Real.sqrt 2 / 4 = 1 / (2 * Real.sqrt 2) := by
      field_simp [hsqrt2_ne]
      nlinarith [hsqrt2_sq]
    calc
      geometry.cubeSideSI.val =
          state.maximumLevelDifferenceSI.val * Real.sqrt 2 / 4 := by
        nlinarith [hremaining]
      _ = state.maximumLevelDifferenceSI.val * (Real.sqrt 2 / 4) := by ring
      _ = state.maximumLevelDifferenceSI.val * (1 / (2 * Real.sqrt 2)) := by
        rw [hsqrt2_recip]
      _ = state.maximumLevelDifferenceSI.val / (2 * Real.sqrt 2) := by ring
  have hlength :
      geometry.cubeSideSI =
        ⟨state.maximumLevelDifferenceSI.val / (2 * Real.sqrt 2)⟩ := by
    apply WithDim.ext
    exact hside
  refine ⟨hlength, ?_⟩
  unfold RoundsToNearestCentimeterSI
  rw [hside, hSetup.statedMaximumLevelDifference]
  have hsqrt2_lower : (7 / 5 : ℝ) ≤ Real.sqrt 2 := by
    nlinarith [Real.sqrt_nonneg (2 : ℝ), hsqrt2_sq]
  have hsqrt2_upper : Real.sqrt 2 ≤ (99 / 70 : ℝ) := by
    nlinarith [Real.sqrt_nonneg (2 : ℝ), hsqrt2_sq]
  rw [abs_le]
  constructor
  · rw [le_sub_iff_add_le, le_div_iff₀ (by positivity : 0 < (2 : ℝ) * Real.sqrt 2)]
    norm_num at hsqrt2_upper ⊢
    nlinarith
  · rw [sub_le_iff_le_add, div_le_iff₀ (by positivity : 0 < (2 : ℝ) * Real.sqrt 2)]
    norm_num at hsqrt2_lower ⊢
    nlinarith

end IPhO2026Problems.IPhO2026_1_A_1
... [leading content omitted]
```

### Blueprint excerpt
```tex
SI}
  “length” rounds to “centimetreCount” centimetres when its SI readout lies within half a centimetre of that decimal value.
\end{definition}
\begin{proof}
  This is the defining declaration; unfolding it gives the stated typed data or relation.
\end{proof}

\begin{theorem}[Physics formalization target]
\label{thm:physics:IPhO_2026_1_A_1:target}
\lean{IPhO2026Problems.IPhO2026_1_A_1.sideLength_at_maximumLevelDifference}
\uses{decl:physics:IPhO_2026_1_A_1:LengthSI, decl:physics:IPhO_2026_1_A_1:AreaSI, decl:physics:IPhO_2026_1_A_1:VolumeSI, decl:physics:IPhO_2026_1_A_1:MassDensitySI, decl:physics:IPhO_2026_1_A_1:AccelerationSI, decl:physics:IPhO_2026_1_A_1:PressureSI, decl:physics:IPhO_2026_1_A_1:ForceSI, decl:physics:IPhO_2026_1_A_1:TorqueSI, decl:physics:IPhO_2026_1_A_1:FigurePointLabel, decl:physics:IPhO_2026_1_A_1:WallOrientation, decl:physics:IPhO_2026_1_A_1:SubmersionStatus, decl:physics:IPhO_2026_1_A_1:HingeFriction, decl:physics:IPhO_2026_1_A_1:AxisOrientation, decl:physics:IPhO_2026_1_A_1:ReservoirFluid, decl:physics:IPhO_2026_1_A_1:GateConfiguration, decl:physics:IPhO_2026_1_A_1:Figure1aGeometry, decl:physics:IPhO_2026_1_A_1:HydrostaticGateState, decl:physics:IPhO_2026_1_A_1:MatchesProblemSetup, decl:physics:IPhO_2026_1_A_1:MatchesFigure1a, decl:physics:IPhO_2026_1_A_1:HydrostaticGateLaws, decl:physics:IPhO_2026_1_A_1:RoundsToNearestCentimeterSI}
The assigned autoformalize agent should translate this physics problem into Lean declarations in the covered file, with theorem and lemma proof bodies written as `by sorry`.
\end{theorem}
\begin{proof}
This is an autoformalization task, not a proof task. Produce statements that can later be proved by the physics prover without weakening the physical model.
\end{proof}
% --- Archon physics formalization source end ---
... [leading content omitted]
```

### Report excerpt: `IPhO2026Problems_problem_IPhO_2026_1_A_1.lean.md`
```markdown
miting torque equation is expanded using the hydrostatic-law and
Figure 1a hypotheses.  After using `(Real.sqrt 2)^2 = 2`, it factors as

`ρ * g * a^3 * (Δh * Real.sqrt 2 - 4 * a) = 0`.

Strict positivity of `ρ`, `g`, and `a` rules out the physical prefactor, so
`a = Δh / (2 * Real.sqrt 2)`.  Extensionality of `WithDim` lifts this scalar
identity to the requested `LengthSI` equality.

For the rounding conclusion, the supplied `Δh = 141/100` is substituted and
the rational bounds

`7/5 ≤ Real.sqrt 2 ≤ 99/70`

are proved by squaring.  These bounds put the resulting side length within
`1/200 m` of `50/100 m`.

## Verification

- Lean LSP diagnostics: clean.
- `lake env lean IPhO2026Problems/problem_IPhO_2026_1_A_1.lean`: passed.
- `lake build`: passed (`Build completed successfully`).
- Axiom/source verification found only Lean's standard
  `propext`, `Classical.choice`, and `Quot.sound`; source scan warnings: none.
- Source scan confirms no `sorry`, `admit`, `axiom`, `sorryAx`, or
  `native_decide` remains in the assigned file.

## Blueprint readiness

`IPhO2026Problems.IPhO2026_1_A_1.sideLength_at_maximumLevelDifference` is
closed and ready for the deterministic `sync_leanok` phase.
... [leading content omitted]
```

### Report excerpt: `physics-grounding-IPhO2026Problems_problem_IPhO_2026_1_A_1.md`
```markdown
raction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_1_A_1.ReservoirFluid`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_1_A_1.RoundsToNearestCentimeterSI`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_1_A_1.SubmersionStatus`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_1_A_1.TorqueSI`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_1_A_1.VolumeSI`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_1_A_1.WallOrientation`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.

## Grounding gaps

- No unresolved LeanExplore grounding gaps were recorded by this preflight.
... [leading content omitted]
```

## 2. `IPhO2026Problems/problem_IPhO_2026_1_B_1.lean`

- Compile status: passed
- Open sorries: 0
- Direct-check seconds: 16.341
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_1_B_1.tex`
- Reports: `.archon/task_results/IPhO2026Problems_problem_IPhO_2026_1_B_1.lean.md`, `.archon/task_results/physics-grounding-IPhO2026Problems_problem_IPhO_2026_1_B_1.md`

### Lean excerpt
```lean
` electron-positron pair, the maximum separation is
`1600 / 9` Bohr radii.

Blueprint: `thm:physics:IPhO_2026_1_B_1:target`.
-/
theorem maximum_separation_for_mu_four
    (constants : PhysicalConstants)
    (initial : Figure1bInitialState constants)
    (orbit : ElectronPositronOrbit)
    (laws : SatisfiesClassicalCoulombConicLaws constants initial orbit)
    (bound : IsBoundClosedOrbit orbit) :
    scalarInSI orbit.maximumSeparation =
      ((1600 : ℝ) / 9) * scalarInSI constants.bohrRadius := by
  have heccentricity :=
    eccentricity_for_mu_four constants initial orbit laws
  have hconic_parameter :=
    conic_parameter_for_mu_four constants initial orbit laws
  obtain ⟨apocentreTime, hapocentre_direction⟩ :=
    bound.apocentre_direction_is_attained
  have hapocentre_polar := laws.polar_conic_law apocentreTime
  rw [hconic_parameter, heccentricity, hapocentre_direction] at hapocentre_polar
  have hapocentre_value :
      scalarInSI (orbit.separationAt apocentreTime) =
        ((1600 : ℝ) / 9) * scalarInSI constants.bohrRadius := by
    calc
      scalarInSI (orbit.separationAt apocentreTime) =
          128 * scalarInSI constants.bohrRadius /
            (1 - (7 : ℝ) / 25 * 1) := hapocentre_polar
      _ = ((1600 : ℝ) / 9) *
            scalarInSI constants.bohrRadius := by ring
  have hlower := bound.maximum_is_upper_bound apocentreTime
  rw [hapocentre_value] at hlower
  obtain ⟨maximumTime, hmaximum_attained⟩ := bound.maximum_is_attained
  have hmaximum_readout :
      scalarInSI (orbit.separationAt maximumTime) =
        scalarInSI orbit.maximumSeparation :=
    congrArg (fun quantity : PhysicalLength => scalarInSI quantity)
      hmaximum_attained
  have hmaximum_polar := laws.polar_conic_law maximumTime
  rw [hconic_parameter, heccentricity] at hmaximum_polar
  have hcos_le_one :
      Real.cos (orbit.polarAngleAt maximumTime) ≤ 1 :=
    Real.cos_le_one _
  have hdenominator_pos :
      0 <
        1 - (7 : ℝ) / 25 *
          Real.cos (orbit.polarAngleAt maximumTime) := by
    nlinarith
  have hmaximum_upper :
      scalarInSI (orbit.separationAt maximumTime) ≤
        ((1600 : ℝ) / 9) * scalarInSI constants.bohrRadius := by
    rw [hmaximum_polar]
    apply (div_le_iff₀ hdenominator_pos).2
    have hproduct_nonneg :
        0 ≤ scalarInSI constants.bohrRadius *
          (1 - Real.cos (orbit.polarAngleAt maximumTime)) :=
      mul_nonneg (le_of_lt constants.bohrRadius_pos)
        (sub_nonneg.mpr hcos_le_one)
    nlinarith
  rw [hmaximum_readout] at hmaximum_upper
  exact le_antisymm hmaximum_upper hlower

end IPhO2026Problems.IPhO2026_1_B_1
... [leading content omitted]
```

### Blueprint excerpt
```tex
velocityDimension, decl:physics:IPhO_2026_1_B_1:angularMomentumDimension, decl:physics:IPhO_2026_1_B_1:energyDimension, decl:physics:IPhO_2026_1_B_1:coulombConstantDimension, decl:physics:IPhO_2026_1_B_1:permittivityDimension, decl:physics:IPhO_2026_1_B_1:PhysicalLength, decl:physics:IPhO_2026_1_B_1:PhysicalMass, decl:physics:IPhO_2026_1_B_1:PhysicalCharge, decl:physics:IPhO_2026_1_B_1:PhysicalSpeed, decl:physics:IPhO_2026_1_B_1:PhysicalAngularMomentum, decl:physics:IPhO_2026_1_B_1:PhysicalEnergy, decl:physics:IPhO_2026_1_B_1:PhysicalCoulombConstant, decl:physics:IPhO_2026_1_B_1:PhysicalPermittivity, decl:physics:IPhO_2026_1_B_1:PositionVector, decl:physics:IPhO_2026_1_B_1:VelocityVector, decl:physics:IPhO_2026_1_B_1:scalarInSI, decl:physics:IPhO_2026_1_B_1:vectorInSI, decl:physics:IPhO_2026_1_B_1:PhysicalConstants, decl:physics:IPhO_2026_1_B_1:Figure1bInitialState, decl:physics:IPhO_2026_1_B_1:ElectronPositronOrbit, decl:physics:IPhO_2026_1_B_1:relativePositionInSI, decl:physics:IPhO_2026_1_B_1:relativeVelocityInSI, decl:physics:IPhO_2026_1_B_1:IsBoundClosedOrbit, decl:physics:IPhO_2026_1_B_1:SatisfiesClassicalCoulombConicLaws, decl:physics:IPhO_2026_1_B_1:total_angular_momentum_for_mu_four, decl:physics:IPhO_2026_1_B_1:total_energy_for_mu_four, decl:physics:IPhO_2026_1_B_1:eccentricity_for_mu_four, decl:physics:IPhO_2026_1_B_1:conic_parameter_for_mu_four}
The assigned autoformalize agent should translate this physics problem into Lean declarations in the covered file, with theorem and lemma proof bodies written as `by sorry`.
\end{theorem}
\begin{proof}
This is an autoformalization task, not a proof task. Produce statements that can later be proved by the physics prover without weakening the physical model.
\end{proof}
% --- Archon physics formalization source end ---
... [leading content omitted]
```

### Report excerpt: `IPhO2026Problems_problem_IPhO_2026_1_B_1.lean.md`
```markdown
ximum. At a time
when the maximum is attained, `Real.cos_le_one`, positivity of `a₀`, and the
polar conic law give the reverse inequality.

## Verification

- Sorry count: **5 → 0**.
- Lean language-server diagnostics: no errors or warnings.
- `lake env lean IPhO2026Problems/problem_IPhO_2026_1_B_1.lean`: exit code 0.
- The declared default target `lake build IPhO2026Run`: completed
  successfully. The project does not expose this standalone problem file as a
  separate Lake module target, so the direct Lean invocation is the relevant
  per-file compilation check.
- Source scan found no `sorry`, `admit`, added `axiom`, `native_decide`, or
  `sorryAx`-style escape hatch.
- Axiom verification of `maximum_separation_for_mu_four` (transitively using
  the four preceding theorems) reports only Lean/Mathlib's standard `propext`,
  `Classical.choice`, and `Quot.sound`.
- The read-only `archon dag-query` command was unavailable in this environment
  (`archon: command not found`).

## Blueprint status

The proof environments for all five declarations are ready for deterministic
`\leanok` synchronization. Per prover permissions, the blueprint chapter was
not edited.

## Redraft needed

None.
... [leading content omitted]
```

### Report excerpt: `physics-grounding-IPhO2026Problems_problem_IPhO_2026_1_B_1.md`
```markdown
; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_1_B_1.PositionVector`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_1_B_1.SatisfiesClassicalCoulombConicLaws`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_1_B_1.ScalarQuantity`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_1_B_1.Space`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_1_B_1.VectorQuantity`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_1_B_1.VelocityVector`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.

## Grounding gaps

- No unresolved LeanExplore grounding gaps were recorded by this preflight.
... [leading content omitted]
```

## 3. `IPhO2026Problems/problem_IPhO_2026_1_B_2.lean`

- Compile status: passed
- Open sorries: 1
- Direct-check seconds: 13.977
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_1_B_2.tex`
- Reports: `.archon/task_results/IPhO2026Problems_problem_IPhO_2026_1_B_2.lean.md`, `.archon/task_results/physics-grounding-IPhO2026Problems_problem_IPhO_2026_1_B_2.md`

### Lean excerpt
```lean
B.2 target -/

/--
The signed counterclockwise angle from the initial positron velocity to the
asymptotic positron-relative-to-electron velocity, reported in degrees.
-/
def signedDeflectionDegrees
    (motion : PairMotion) (frame : Figure1bFrame)
    (uInfinity : Plane) : ℝ :=
  (frame.orientation.oangle
      (velocitySI motion .positron 0) uInfinity).toReal *
    180 / Real.pi

/--
`actual` rounds to `reported` at two digits after the decimal point. The
half-unit tolerance is `0.005`.
-/
def RoundsToNearestHundredth (actual reported : ℝ) : Prop :=
  |actual - reported| ≤ (1 : ℝ) / 200

/--
IPhO 2026 Problem 1 B.2: the outgoing relative velocity is directed
`16.60°` below the initial positron line of motion.

The hypotheses assigning `uInfinity` its limiting-velocity role contain no
information about its direction. The negative sign and the numerical
deflection occur only in this conclusion.
-/
theorem IPhO_2026_1_B_2
    (constants : PhysicalConstants)
    (constantRelations : ConstantRelations constants)
    (motion : PairMotion)
    (frame : Figure1bFrame)
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
eal.arcsin orbit.eccentricity⁻¹)
  ```

  This is the standard missing bridge, expressed for the already supplied
  eccentricity rather than encoding the reported decimal. The existing
  initial-state and eccentricity laws can then be used to derive
  `orbit.eccentricity = 7/2`, after which the remaining obligation is the
  rigorous enclosure of
  `-arcsin (2/7) * 180 / π` around `-83/5`.

An equivalent redraft could place this relation in a new governing-law record
parameterized by `uInfinity`; it should not assume the rounded answer itself.

## Verification

- Lean language-server diagnostics: no errors; exactly one expected
  `declaration uses sorry` warning.
- `lake env lean IPhO2026Problems/problem_IPhO_2026_1_B_2.lean`: exit code 0
  with the same single warning.
- No axioms, `admit`, `native_decide`, or `sorryAx`-style declarations were
  introduced.
- The read-only `archon dag-query` command was unavailable in this environment
  (`archon: command not found`); the source report lists no previous parts.

## Blueprint status

The target proof is not ready for a proof `\leanok` marker because one focused
gap remains. Per prover permissions, the blueprint chapter was not edited.
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

## 4. `IPhO2026Problems/problem_IPhO_2026_1_C_1.lean`

- Compile status: passed
- Open sorries: 0
- Direct-check seconds: 35.847
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_1_C_1.tex`
- Reports: `.archon/task_results/IPhO2026Problems_problem_IPhO_2026_1_C_1.lean.md`, `.archon/task_results/physics-grounding-IPhO2026Problems_problem_IPhO_2026_1_C_1.md`

### Lean excerpt
```lean
mul_nonpos_of_nonneg_of_nonpos (mul_nonneg hqnonneg hrnonneg) hcos
      have hkineticLower : q ^ 2 ≤ a ^ 2 := by
        nlinarith only [hatomSq, hqrcos, sq_nonneg r]
      have hkineticLower' :
          q ^ 2 ≤
            2 * oxygenAtomMassSI p *
              (reducedPlanckConstantSI p * w - energyDifferenceSI p) := by
        nlinarith only [henergy4, hkineticLower, sq_nonneg r]
      have hmul := mul_le_mul_of_nonneg_right hkineticLower'
        (sq_nonneg (lightSpeedSI p))
      have hqSq :
          q ^ 2 * (lightSpeedSI p) ^ 2 =
            (reducedPlanckConstantSI p * w) ^ 2 := by
        rw [← hqmul]
        ring
      have hmul' :
          (reducedPlanckConstantSI p * w) ^ 2 ≤
            2 * oxygenAtomMassSI p *
                (reducedPlanckConstantSI p * w - energyDifferenceSI p) *
              (lightSpeedSI p) ^ 2 := by
        rw [← hqSq]
        simpa only [mul_assoc] using hmul
      have hquadratic :
          2 * oxygenAtomMassSI p * (lightSpeedSI p) ^ 2 *
                energyDifferenceSI p +
              (reducedPlanckConstantSI p * w) ^ 2 ≤
            2 * oxygenAtomMassSI p * (lightSpeedSI p) ^ 2 *
              (reducedPlanckConstantSI p * w) := by
        nlinarith only [hmul']
      by_contra hn
      have hwlt : w < W := by
        exact lt_of_not_ge (by simpa [w] using hn)
      have hxlt :
          reducedPlanckConstantSI p * w <
            reducedPlanckConstantSI p * W := by
        nlinarith only [hwlt, hℏ]
      have hsum :
          reducedPlanckConstantSI p * w +
              reducedPlanckConstantSI p * W <
            2 * oxygenAtomMassSI p * (lightSpeedSI p) ^ 2 := by
        nlinarith only [hxlt, hWrest]
      have hWenergyClear :
          2 * oxygenAtomMassSI p * (lightSpeedSI p) ^ 2 *
                energyDifferenceSI p +
              (reducedPlanckConstantSI p * W) ^ 2 =
            2 * oxygenAtomMassSI p * (lightSpeedSI p) ^ 2 *
              (reducedPlanckConstantSI p * W) := by
        field_simp [ne_of_gt hm, ne_of_gt hc] at hWenergy
        nlinarith only [hWenergy]
      have hproduct :
          0 <
            (reducedPlanckConstantSI p * W -
                reducedPlanckConstantSI p * w) *
              (2 * oxygenAtomMassSI p * (lightSpeedSI p) ^ 2 -
                (reducedPlanckConstantSI p * w +
                  reducedPlanckConstantSI p * W)) :=
        mul_pos (sub_pos.mpr hxlt) (sub_pos.mpr hsum)
      nlinarith only [hquadratic, hWenergyClear, hproduct]
    have heq : scalarSI ωmin = W := le_antisymm hminLe hWLe
    simpa only [W, S, D] using heq

end IPhO2026Problems.IPhO2026_1_C_1
... [leading content omitted]
```

### Blueprint excerpt
```tex
ngularFrequency_eq}
\uses{decl:physics:IPhO_2026_1_C_1:MassQuantity, decl:physics:IPhO_2026_1_C_1:ActionQuantity, decl:physics:IPhO_2026_1_C_1:AngularFrequencyQuantity, decl:physics:IPhO_2026_1_C_1:MomentumQuantity2, decl:physics:IPhO_2026_1_C_1:scalarSI, decl:physics:IPhO_2026_1_C_1:speedSI, decl:physics:IPhO_2026_1_C_1:momentumSI, decl:physics:IPhO_2026_1_C_1:dot2, decl:physics:IPhO_2026_1_C_1:magnitude2, decl:physics:IPhO_2026_1_C_1:PhotodissociationParameters, decl:physics:IPhO_2026_1_C_1:reducedPlanckConstantSI, decl:physics:IPhO_2026_1_C_1:lightSpeedSI, decl:physics:IPhO_2026_1_C_1:oxygenAtomMassSI, decl:physics:IPhO_2026_1_C_1:energyDifferenceSI, decl:physics:IPhO_2026_1_C_1:ValidPhotodissociationParameters, decl:physics:IPhO_2026_1_C_1:DissociationAt, decl:physics:IPhO_2026_1_C_1:IsMinimumDissociationFrequency}
For valid dimensioned photodissociation data, the least feasible photon
frequency equals the corrected forward-angle expression above when
\(\theta\leq\pi/2\), and the boundary expression when
\(\theta\geq\pi/2\).
\end{theorem}
\begin{proof}
Write \(q=\hbar\omega/c\) for the incident photon momentum magnitude and
\(p\geq0\) for the outgoing molecular momentum magnitude.  Momentum
conservation makes the atomic momentum the vector difference, so the total
fragment kinetic energy is
\[
\frac{3p^2-4pq\cos\theta+2q^2}{4m}.
\]
If \(\cos\theta\geq0\), this quadratic is minimized at
\(p=2q\cos\theta/3\), giving \(q^2(2\sin^2\theta+1)/(6m)\).
Substitute \(q=\hbar\omega/c\) into energy conservation and take the smaller
nonnegative root of the resulting quadratic.  If \(\cos\theta\leq0\), the
constraint \(p\geq0\) puts the minimum at \(p=0\); solving the corresponding
quadratic gives the boundary formula.
\end{proof}
% --- Archon physics formalization source end ---
... [leading content omitted]
```

### Report excerpt: `IPhO2026Problems_problem_IPhO_2026_1_C_1.lean.md`
```markdown
plicitly chosen SI vectors into `MomentumQuantity2` and proves
the two-dimensional norm identity implied by momentum conservation. For
`θ ≤ π / 2`, completing the square in the molecular momentum gives the kinetic
lower bound with `A = 2 * sin² θ + 1`; the constructed equality case has
molecular momentum magnitude `2q cos θ / 3`. For `π / 2 ≤ θ`, `cos θ ≤ 0`
makes zero molecular momentum the constrained equality case. In both branches,
the corrected square-root expression is shown to solve the corresponding
energy quadratic, and the minimum-frequency hypothesis supplies the opposite
inequality.

## Verification

- `lake env lean IPhO2026Problems/problem_IPhO_2026_1_C_1.lean`: passed with
  no diagnostics.
- `lean_verify`: only the standard foundational axioms `propext`,
  `Classical.choice`, and `Quot.sound`.
- Source scan found no `sorry`, `admit`, `axiom`, `sorryAx`, or suspicious
  proof escape.

## Blueprint status

The proof environment for
`IPhO2026Problems.IPhO2026_1_C_1.minimumAngularFrequency_eq` is ready for its
`\leanok` marker. Per prover write restrictions, the blueprint was not edited;
the deterministic marker synchronization should apply it.

## Redraft needed

None.
... [leading content omitted]
```

### Report excerpt: `physics-grounding-IPhO2026Problems_problem_IPhO_2026_1_C_1.md`
```markdown
tead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_1_C_1.DissociationAt`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_1_C_1.IsMinimumDissociationFrequency`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_1_C_1.MassQuantity`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_1_C_1.MomentumQuantity2`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_1_C_1.PhotodissociationParameters`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_1_C_1.ValidPhotodissociationParameters`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.

## Grounding gaps

- No unresolved LeanExplore grounding gaps were recorded by this preflight.
... [leading content omitted]
```

## 5. `IPhO2026Problems/problem_IPhO_2026_1_C_2.lean`

- Compile status: passed
- Open sorries: 0
- Direct-check seconds: 21.214
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_1_C_2.tex`
- Reports: `.archon/task_results/IPhO2026Problems_problem_IPhO_2026_1_C_2.lean.md`, `.archon/task_results/physics-grounding-IPhO2026Problems_problem_IPhO_2026_1_C_2.md`

### Lean excerpt
```lean
nePhotodissociationSetup) : Prop where
  forwardAngle : s.theta ≤ Real.pi / 2 →
    siScalar s.omegaMin = quotedC1ThresholdExpression s s.theta
  backwardAngle : Real.pi / 2 ≤ s.theta →
    siScalar s.omegaMin =
      quotedC1ThresholdExpression s (Real.pi / 2)

/-- The three scalar inputs specified in subquestion C.2, attached to their physical units. -/
structure C2NumericalInputs (s : OzonePhotodissociationSetup) : Prop where
  theta_eq : s.theta = Real.pi / 6
  deltaU_eq :
    s.deltaU = (11 / 10 : ℝ≥0) • DimEnergy.electronVolt
  atomMass_eq :
    s.atomMass = (16 : ℝ≥0) • atomicMassUnit

/--
`x` is reported as `reported` to a precision whose half-width is `tolerance`.

This makes the significant-figure meaning of a numerical physics answer explicit.
-/
def RoundsTo (x reported tolerance : ℝ) : Prop :=
  |x - reported| ≤ tolerance

/--
For `θ = π/6`, `ΔU = 1.10 eV`, and oxygen-atom mass `16.0 amu`, the threshold
excess energy `ℏ ω_min - ΔU` is `2.03 × 10⁻¹¹ eV` to the reported precision.

Blueprint label: `thm:physics:IPhO_2026_1_C_2:target`.
-/
theorem problem_IPhO_2026_1_C_2
    (s : OzonePhotodissociationSetup)
    (physics : ValidOzonePhotodissociationPhysics s)
    (previousPart : QuotedPreviousPartC1Result s)
    (data : C2NumericalInputs s) :
    RoundsTo
      ((siScalar reducedPlanckConstant * siScalar s.omegaMin -
          siScalar s.deltaU) /
        siScalar DimEnergy.electronVolt)
      2.03e-11 5e-14 := by
  rw [previousPart.forwardAngle (by
    rw [data.theta_eq]
    have := Real.pi_pos
    linarith)]
  let t : ℝ :=
    Real.sqrt 932761304735321063788707343 /
      Real.sqrt 932761304804164591030894843
  have ht_nonneg : 0 ≤ t := by
    dsimp [t]
    positivity
  have ht_sq :
      t ^ 2 =
        (932761304735321063788707343 : ℝ) /
          932761304804164591030894843 := by
    dsimp [t]
    rw [div_pow, Real.sq_sqrt (by norm_num), Real.sq_sqrt (by norm_num)]
  have ht_lower :
      (999999999963096921533472 : ℝ) /
          1000000000000000000000000 ≤ t := by
    nlinarith [ht_sq]
  have ht_upper :
      t ≤
        (999999999963096921533473 : ℝ) /
          1000000000000000000000000 := by
    nlinarith [ht_sq]
  norm_num [RoundsTo, quotedC1ThresholdExpression, data.theta_eq,
    data.atomMass_eq, data.deltaU_eq, siScalar, scalarInUnits,
    reducedPlanckConstant, atomicMassUnit, DimEnergy.electronVolt,
    DimSpeed.speedOfLight, CarriesDimension.toDimensionful_apply_apply,
    Constants.ℏ, NNReal.smul_def, abs_le]
  dsimp [t] at ht_lower ht_upper
  constructor <;> nlinarith [ht_lower, ht_upper]

end IPhO2026Problems.IPhO2026_1_C_2
... [leading content omitted]
```

### Blueprint excerpt
```tex
as “reported” to a precision whose half-width is “tolerance”.
\end{definition}
\begin{proof}
  This is the defining declaration; unfolding it gives the stated typed data or relation.
\end{proof}

\begin{theorem}[Physics formalization target]
\label{thm:physics:IPhO_2026_1_C_2:target}
\lean{IPhO2026Problems.IPhO2026_1_C_2.problem_IPhO_2026_1_C_2}
\uses{decl:physics:IPhO_2026_1_C_2:DimMass, decl:physics:IPhO_2026_1_C_2:AngularFrequency, decl:physics:IPhO_2026_1_C_2:DimAction, decl:physics:IPhO_2026_1_C_2:atomicMassUnit, decl:physics:IPhO_2026_1_C_2:reducedPlanckConstant, decl:physics:IPhO_2026_1_C_2:scalarInUnits, decl:physics:IPhO_2026_1_C_2:siScalar, decl:physics:IPhO_2026_1_C_2:momentumSquaredNorm, decl:physics:IPhO_2026_1_C_2:momentumDot, decl:physics:IPhO_2026_1_C_2:MakesAngle, decl:physics:IPhO_2026_1_C_2:OzonePhotodissociationSetup, decl:physics:IPhO_2026_1_C_2:DissociationAt, decl:physics:IPhO_2026_1_C_2:ValidOzonePhotodissociationPhysics, decl:physics:IPhO_2026_1_C_2:quotedC1ThresholdExpression, decl:physics:IPhO_2026_1_C_2:QuotedPreviousPartC1Result, decl:physics:IPhO_2026_1_C_2:C2NumericalInputs, decl:physics:IPhO_2026_1_C_2:RoundsTo}
At \(\theta=\pi/6\), \(\Delta U=1.10\) eV and \(m=16.0\) amu, the corrected
threshold formula makes \(\hbar\omega_{\min}-\Delta U\) round to
\(2.03\times10^{-11}\) eV with the stated tolerance.
\end{theorem}
\begin{proof}
At \(\theta=\pi/6\), the angular factor is \(A=3/2\).  Substitute the supplied
mass and energy into the corrected C.1 expression, convert the dimensioned
quantities to a common SI readout, subtract \(\Delta U\), and divide by one
electronvolt.  The value is approximately \(2.0296693\times10^{-11}\) eV, which
lies inside the requested rounding interval.
\end{proof}
% --- Archon physics formalization source end ---
... [leading content omitted]
```

### Report excerpt: `IPhO2026Problems_problem_IPhO_2026_1_C_2.lean.md`
```markdown
-angle threshold formula from C.1,
substitutes the C.2 angle, mass, and energy data, and reduces every
dimensionful SI readout to its exact rational value. The remaining square root
is bounded between two 24-decimal rational numbers by proving its exact squared
value and using `nlinarith`. Those bounds imply the requested
`2.03e-11 ± 5e-14` eV rounding interval.

## Verification

- `lake env lean IPhO2026Problems/problem_IPhO_2026_1_C_2.lean`: passed.
  The only diagnostic is the frozen but unused `physics` hypothesis.
- `lake build`: completed successfully (4 jobs).
- Lean LSP diagnostics: no errors; only the same unused-variable warning.
- `lean_verify`: only the standard foundational axioms `propext`,
  `Classical.choice`, and `Quot.sound`; no suspicious source patterns.
- A direct source scan found no `sorry`, `admit`, `axiom`, or `sorryAx`.

## Blueprint status

The proof environment for
`IPhO2026Problems.IPhO2026_1_C_2.problem_IPhO_2026_1_C_2` is ready for its
`\leanok` marker. Per prover write restrictions, the blueprint was not edited;
deterministic marker synchronization should apply it.

## Needs blueprint entry

None. No declarations were added.

## Redraft needed

None.
... [leading content omitted]
```

### Report excerpt: `physics-grounding-IPhO2026Problems_problem_IPhO_2026_1_C_2.md`
```markdown
ical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_1_C_2.DissociationAt`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_1_C_2.MakesAngle`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_1_C_2.OzonePhotodissociationSetup`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_1_C_2.QuotedPreviousPartC1Result`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_1_C_2.RoundsTo`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_1_C_2.ValidOzonePhotodissociationPhysics`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.

## Grounding gaps

- No unresolved LeanExplore grounding gaps were recorded by this preflight.
... [leading content omitted]
```

## 6. `IPhO2026Problems/problem_IPhO_2026_2_A_1.lean`

- Compile status: passed
- Open sorries: 0
- Direct-check seconds: 18.627
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_2_A_1.tex`
- Reports: `.archon/task_results/IPhO2026Problems_problem_IPhO_2026_2_A_1.lean.md`, `.archon/task_results/physics-grounding-IPhO2026Problems_problem_IPhO_2026_2_A_1.md`

### Lean excerpt
```lean
Figure-derived limiting-ray relations used before solving for `xN`.

The projection relation reads the transverse coordinate from the radius and
the limiting angle.  The final relation is the full-turn closure accumulated
from the equal turning angles of the specular orbit.  Neither field states the
requested closed form for `xN`. -/
structure Figure2cTo2eLimitingGeometry
    (mirror : HalfCylindricalMirror)
    (family : ParallelIncidentRayFamily)
    (dynamics : MirrorDynamics mirror)
    (N : ℕ) (xN : PhysicalLength) (limitingAngle : ℝ) : Prop where
  limitingAngle_pos : 0 < limitingAngle
  limitingAngle_lt_rightAngle : limitingAngle < Real.pi / 2
  threshold_projection :
    lengthCoordinate xN =
      lengthCoordinate mirror.radius * Real.sin limitingAngle
  threshold_ray_count :
    reflectionCount dynamics (family.rayAt (lengthCoordinate xN)) = N
  total_turning_angle :
    (2 * (N : ℝ) + 1) * (Real.pi - 2 * limitingAngle) =
      2 * Real.pi

/-- The threshold formula requested in IPhO 2026 problem 2, part A.1.

The first equality is the sine form recorded in the marking context; the
second is its complementary-angle cosine form. -/
theorem threshold_formula
    (mirror : HalfCylindricalMirror)
    (family : ParallelIncidentRayFamily)
    (dynamics : MirrorDynamics mirror)
    (R xN : PhysicalLength) (limitingAngle : ℝ) (N : ℕ)
    (hN : 0 < N)
    (hRadius : mirror.radius = R)
    (hAligned : AlignedWithMirror mirror family)
    (hThreshold : IsReflectionThreshold mirror family dynamics N xN)
    (hFigure :
      Figure2cTo2eLimitingGeometry
        mirror family dynamics N xN limitingAngle) :
    lengthCoordinate xN =
        lengthCoordinate R * Real.sin
          (((2 * (N : ℝ) - 1) * Real.pi) / (4 * (N : ℝ) + 2)) ∧
      lengthCoordinate xN =
        lengthCoordinate R * Real.cos (Real.pi / (2 * (N : ℝ) + 1)) := by
  have hDenominator : (4 * (N : ℝ) + 2) ≠ 0 := by
    positivity
  have hLimitingAngle :
      limitingAngle =
        ((2 * (N : ℝ) - 1) * Real.pi) / (4 * (N : ℝ) + 2) := by
    apply (eq_div_iff hDenominator).2
    nlinarith [hFigure.total_turning_angle]
  have hComplementaryAngle :
      ((2 * (N : ℝ) - 1) * Real.pi) / (4 * (N : ℝ) + 2) =
        Real.pi / 2 - Real.pi / (2 * (N : ℝ) + 1) := by
    have hOddDenominator : (2 * (N : ℝ) + 1) ≠ 0 := by
      positivity
    field_simp
    ring
  constructor
  · simpa [hRadius, hLimitingAngle] using hFigure.threshold_projection
  · simpa [hRadius, hLimitingAngle, hComplementaryAngle,
      Real.sin_pi_div_two_sub] using hFigure.threshold_projection

end IPhO2026Problems.IPhO2026_2_A_1
... [leading content omitted]
```

### Blueprint excerpt
```tex
, decl:physics:IPhO_2026_2_A_1:MirrorDynamics, decl:physics:IPhO_2026_2_A_1:reflectionCount}
  Figure-derived limiting-ray relations used before solving for “xN”.
\end{definition}
\begin{proof}
  This is the defining declaration; unfolding it gives the stated typed data or relation.
\end{proof}

\begin{theorem}[Physics formalization target]
\label{thm:physics:IPhO_2026_2_A_1:target}
\lean{IPhO2026Problems.IPhO2026_2_A_1.threshold_formula}
\uses{decl:physics:IPhO_2026_2_A_1:CrossSectionPoint, decl:physics:IPhO_2026_2_A_1:FigureLabel, decl:physics:IPhO_2026_2_A_1:HalfCylindricalMirror, decl:physics:IPhO_2026_2_A_1:OnReflectingArc, decl:physics:IPhO_2026_2_A_1:GeometricRay, decl:physics:IPhO_2026_2_A_1:ParallelIncidentRayFamily, decl:physics:IPhO_2026_2_A_1:AlignedWithMirror, decl:physics:IPhO_2026_2_A_1:ReflectionEvent, decl:physics:IPhO_2026_2_A_1:IsSpecularReflection, decl:physics:IPhO_2026_2_A_1:ReflectionTrace, decl:physics:IPhO_2026_2_A_1:MirrorDynamics, decl:physics:IPhO_2026_2_A_1:reflectionCount, decl:physics:IPhO_2026_2_A_1:IsReflectionThreshold, decl:physics:IPhO_2026_2_A_1:Figure2cTo2eLimitingGeometry}
For every positive integer \(N\), the largest positive transverse distance
whose ray undergoes at most \(N\) reflections is
\[
x_N=R\sin\!\left(\frac{(2N-1)\pi}{4N+2}\right)
   =R\cos\!\left(\frac{\pi}{2N+1}\right),
\]
with \(R\) and \(x_N\) interpreted through the same named length projection.
\end{theorem}
\begin{proof}
Let \(\alpha\) be the limiting incidence angle.  The equal turning angles of
the limiting specular orbit give
\((2N+1)(\pi-2\alpha)=2\pi\), hence
\(\alpha=(2N-1)\pi/(4N+2)=\pi/2-\pi/(2N+1)\).
Figure 2e gives \(x_N=R\sin\alpha\); the complementary-angle identity yields
the cosine form.
\end{proof}
% --- Archon physics formalization source end ---
... [leading content omitted]
```

### Report excerpt: `IPhO2026Problems_problem_IPhO_2026_2_A_1.lean.md`
```markdown
lting
angle into `hFigure.threshold_projection` for the sine form.  A
`field_simp`/`ring` calculation identifies this angle with
`π / 2 - π / (2N + 1)`, and `Real.sin_pi_div_two_sub` gives the cosine form.

The physical alignment and threshold hypotheses are retained in the frozen
contract.  The numerical conclusion itself follows from the stronger
figure-derived projection and total-turning relations, so `hAligned` and
`hThreshold` are not needed in the final algebraic proof.

## Verification

- `lake env lean IPhO2026Problems/problem_IPhO_2026_2_A_1.lean`: passed.
- `lake build`: passed.
- Lean LSP diagnostics: no errors; only unused-variable linter warnings for
  `hAligned` and `hThreshold`.
- Lean axiom/source verification: only standard imported axioms `propext`,
  `Classical.choice`, and `Quot.sound`; no suspicious source patterns.
- The file contains no remaining `sorry`, `admit`, `axiom`, or
  `native_decide`.

## Blueprint marker

The theorem proof environment for
`IPhO2026Problems.IPhO2026_2_A_1.threshold_formula` is ready for `\leanok`.
Per the prover-role instructions, the blueprint chapter was not edited; the
deterministic synchronization phase should apply the marker.
... [leading content omitted]
```

### Report excerpt: `physics-grounding-IPhO2026Problems_problem_IPhO_2026_2_A_1.md`
```markdown
eserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_2_A_1.IsSpecularReflection`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_2_A_1.MirrorDynamics`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_2_A_1.OnReflectingArc`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_2_A_1.ParallelIncidentRayFamily`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_2_A_1.ReflectionEvent`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_2_A_1.ReflectionTrace`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.

## Grounding gaps

- No unresolved LeanExplore grounding gaps were recorded by this preflight.
... [leading content omitted]
```

## 7. `IPhO2026Problems/problem_IPhO_2026_2_B_1.lean`

- Compile status: passed
- Open sorries: 1
- Direct-check seconds: 14.259
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
/ipho_2026/problem_IPhO_2026_2_B_1.source.json`.
- Theorem: `radiusAtIncidence_from_figure2f`.
- Blocker: the current `ValidSolarCookerPhysics` contract treats
  `setup.radiusAtIncidence`, `setup.isLimitingPathForRadius`, and
  `setup.isTangentToContainer` as abstract data/predicates. Its only relevant
  field asserts that a limiting tangent path exists at each admissible angle.
  No field states what tangency means geometrically or connects such a path
  to the displacement/radius equation. Consequently the extracted
  `path`, `hlimiting`, `htangent`, and `hincidence` provide no equality from
  which the claimed sine formula can be deduced.
- Smallest faithful change: add a governing-law hypothesis to
  `ValidSolarCookerPhysics` (or directly to
  `radiusAtIncidence_from_figure2f`) stating that an admissible one-reflection
  limiting tangent path at incidence `θ` implies
  `setup.radiusAtIncidence θ =
    scaleLength (Real.sin θ - (1 / 2) * Real.sin (2 * θ))
      setup.mirrorRadius`.
  A more structural redraft could instead define tangency, reflection
  geometry, and the limiting-radius relation concretely, but that is larger
  than the minimum needed to close the frozen theorem.
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

## 8. `IPhO2026Problems/problem_IPhO_2026_2_B_2.lean`

- Compile status: passed
- Open sorries: 0
- Direct-check seconds: 13.949
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_2_B_2.tex`
- Reports: `.archon/task_results/physics-grounding-IPhO2026Problems_problem_IPhO_2026_2_B_2.md`

### Lean excerpt
```lean
OpticalModel g) : Prop :=
  (∀ ray, o.hitsMirror ray → o.hitsContainer ray → o.reflectionCount ray = 1 →
      o.incidenceAngle ray ≤ o.thetaMax) ∧
    ∃ ray, o.hitsMirror ray ∧ o.hitsContainer ray ∧ o.reflectionCount ray = 1 ∧
      o.incidenceAngle ray = o.thetaMax

/--
The conclusion of previous part B.1 after substituting
`alpha = R` and `beta = -R / 2`.
-/
def HasPartB1RadiusRelation (g : Figure2fGeometry) (thetaMax : ℝ) : Prop :=
  g.containerRadius.val =
    g.mirrorRadius.val * Real.sin thetaMax -
      g.mirrorRadius.val / 2 * Real.sin (2 * thetaMax)

/--
Power equals uniform irradiance times the illuminated projected area.

With the mirror, the transverse collection width is
`2 * R * sin(thetaMax)`; without it, the cylinder's projected width is `2 * a`.
Both areas have the same illuminated axial length.
-/
def SatisfiesProjectedAperturePowerLaws {g : Figure2fGeometry}
    (o : OpticalModel g) : Prop :=
  o.actualReceivedPower.val =
      o.solarIrradiance.val *
        (2 * g.mirrorRadius.val * Real.sin o.thetaMax) * g.illuminatedLength.val ∧
    o.noMirrorReceivedPower.val =
      o.solarIrradiance.val * (2 * g.containerRadius.val) * g.illuminatedLength.val

/--
For the solar cooker of figure 2f, the mirror enhancement of the received
power is `1 / (1 - cos(thetaMax))`.

Blueprint label: `thm:physics:IPhO_2026_2_B_2:target`.
-/
theorem problem_IPhO_2026_2_B_2
    (g : Figure2fGeometry) (o : OpticalModel g)
    (h_placement : HasFigure2fPlacement g)
    (h_sunlight : HasUniformParallelSunlight o)
    (h_absorbing : IsFullyAbsorbing o)
    (h_reflection : IsSingleReflectionRegime o)
    (h_theta_max : IsLargestRelevantIncidenceAngle o)
    (h_theta_pos : 0 < o.thetaMax)
    (h_theta_lt : o.thetaMax < Real.pi / 2)
    (h_mirror_radius : 0 < g.mirrorRadius.val)
    (h_container_radius : 0 < g.containerRadius.val)
    (h_length : 0 < g.illuminatedLength.val)
    (h_part_B1 : HasPartB1RadiusRelation g o.thetaMax)
    (h_power : SatisfiesProjectedAperturePowerLaws o) :
    o.actualReceivedPower.val / o.noMirrorReceivedPower.val =
      1 / (1 - Real.cos o.thetaMax) := by
  rcases h_power with ⟨hP, hP0⟩
  have hI : 0 < o.solarIrradiance.val := h_sunlight.1
  unfold HasPartB1RadiusRelation at h_part_B1
  rw [Real.sin_two_mul] at h_part_B1
  have hcos : 1 - Real.cos o.thetaMax ≠ 0 := by
    intro hz
    have hc : Real.cos o.thetaMax = 1 := by
      linarith
    rw [hc] at h_part_B1
    nlinarith
  rw [hP, hP0]
  field_simp [hcos, ne_of_gt hI, ne_of_gt h_container_radius, ne_of_gt h_length]
  nlinarith [h_part_B1]

end IPhO2026_2_B_2
end IPhO2026Problems
... [leading content omitted]
```

### Blueprint excerpt
```tex
n{definition}[SatisfiesProjectedAperturePowerLaws]
  \label{decl:physics:IPhO_2026_2_B_2:SatisfiesProjectedAperturePowerLaws}
  \lean{IPhO2026Problems.IPhO2026_2_B_2.SatisfiesProjectedAperturePowerLaws}
  \uses{decl:physics:IPhO_2026_2_B_2:Figure2fGeometry, decl:physics:IPhO_2026_2_B_2:OpticalModel}
  Power equals uniform irradiance times the illuminated projected area.
\end{definition}
\begin{proof}
  This is the defining declaration; unfolding it gives the stated typed data or relation.
\end{proof}

\begin{theorem}[Physics formalization target]
\label{thm:physics:IPhO_2026_2_B_2:target}
\lean{IPhO2026Problems.IPhO2026_2_B_2.problem_IPhO_2026_2_B_2}
\uses{decl:physics:IPhO_2026_2_B_2:LengthQuantity, decl:physics:IPhO_2026_2_B_2:powerDimension, decl:physics:IPhO_2026_2_B_2:PowerQuantity, decl:physics:IPhO_2026_2_B_2:irradianceDimension, decl:physics:IPhO_2026_2_B_2:IrradianceQuantity, decl:physics:IPhO_2026_2_B_2:Figure2fGeometry, decl:physics:IPhO_2026_2_B_2:OpticalModel, decl:physics:IPhO_2026_2_B_2:HasFigure2fPlacement, decl:physics:IPhO_2026_2_B_2:HasUniformParallelSunlight, decl:physics:IPhO_2026_2_B_2:IsFullyAbsorbing, decl:physics:IPhO_2026_2_B_2:IsSingleReflectionRegime, decl:physics:IPhO_2026_2_B_2:IsLargestRelevantIncidenceAngle, decl:physics:IPhO_2026_2_B_2:HasPartB1RadiusRelation, decl:physics:IPhO_2026_2_B_2:SatisfiesProjectedAperturePowerLaws}
The assigned autoformalize agent should translate this physics problem into Lean declarations in the covered file, with theorem and lemma proof bodies written as `by sorry`.
\end{theorem}
\begin{proof}
This is an autoformalization task, not a proof task. Produce statements that can later be proved by the physics prover without weakening the physical model.
\end{proof}
% --- Archon physics formalization source end ---
... [leading content omitted]
```

### Report excerpt: `physics-grounding-IPhO2026Problems_problem_IPhO_2026_2_B_2.md`
```markdown
instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_2_B_2.IsLargestRelevantIncidenceAngle`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_2_B_2.IsSingleReflectionRegime`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_2_B_2.LengthQuantity`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_2_B_2.OpticalModel`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_2_B_2.PowerQuantity`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_2_B_2.SatisfiesProjectedAperturePowerLaws`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.

## Grounding gaps

- No unresolved LeanExplore grounding gaps were recorded by this preflight.
... [leading content omitted]
```

## 9. `IPhO2026Problems/problem_IPhO_2026_2_B_3.lean`

- Compile status: passed
- Open sorries: 0
- Direct-check seconds: 16.028
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_2_B_3.tex`
- Reports: `.archon/task_results/physics-grounding-IPhO2026Problems_problem_IPhO_2026_2_B_3.md`

### Lean excerpt
```lean
rs setup.mirror.radius * Real.sin thetaMax -
          (lengthInMeters setup.mirror.radius / 2) *
            Real.sin (2 * thetaMax))
    (h_previous_B2_powerRatio :
      powerInSI P / powerInSI P₀ =
        1 / (1 - Real.cos thetaMax))
    (h_fivefold_absorbed_power :
      powerInSI P = 5 * powerInSI P₀) :
    Real.cos thetaMax = (4 : ℝ) / 5 ∧
      lengthInMeters setup.container.radius = (3 : ℝ) / 25 ∧
      lengthInCentimeters setup.container.radius = 12 := by
  have hP₀_ne : powerInSI P₀ ≠ 0 :=
    ne_of_gt h_baseline_power_positive
  have h_power_ratio : powerInSI P / powerInSI P₀ = 5 := by
    rw [h_fivefold_absorbed_power]
    rw [mul_div_assoc, div_self hP₀_ne, mul_one]
  have h_inverse_ratio : 1 / (1 - Real.cos thetaMax) = 5 :=
    h_previous_B2_powerRatio.symm.trans h_power_ratio
  have h_denominator_ne : 1 - Real.cos thetaMax ≠ 0 := by
    intro h
    rw [h] at h_inverse_ratio
    norm_num at h_inverse_ratio
  have h_cos : Real.cos thetaMax = (4 : ℝ) / 5 := by
    have h_cross_multiply := (div_eq_iff h_denominator_ne).mp h_inverse_ratio
    norm_num at h_cross_multiply ⊢
    linarith
  have h_theta_le_pi : thetaMax ≤ Real.pi := by
    nlinarith [h_thetaMax_range.2, Real.pi_pos]
  have h_sin_nonnegative : 0 ≤ Real.sin thetaMax :=
    Real.sin_nonneg_of_nonneg_of_le_pi h_thetaMax_range.1 h_theta_le_pi
  have h_sin : Real.sin thetaMax = (3 : ℝ) / 5 := by
    have h_pythagorean := Real.sin_sq_add_cos_sq thetaMax
    rw [h_cos] at h_pythagorean
    nlinarith [sq_nonneg (Real.sin thetaMax - 3 / 5)]
  have h_sin_double : Real.sin (2 * thetaMax) = (24 : ℝ) / 25 := by
    rw [Real.sin_two_mul, h_sin, h_cos]
    norm_num
  have h_radius_m : lengthInMeters setup.container.radius = (3 : ℝ) / 25 := by
    rw [h_previous_B1_geometry, h_mirror_radius, h_sin, h_sin_double]
    norm_num
  have h_unit_scale :
      UnitChoices.dimScale SI centimeterUnits L𝓭 = (100 : NNReal) := by
    apply NNReal.eq
    simp [UnitChoices.dimScale, centimeterUnits, LengthUnit.centimeters,
      LengthUnit.scale, LengthUnit.meters, LengthUnit.div_eq_val]
    norm_num
    rfl
  have h_length_conversion :
      lengthInCentimeters setup.container.radius =
        100 * lengthInMeters setup.container.radius := by
    have h_scaling :=
      setup.container.radius.property SI centimeterUnits
    have h_scaling_val := congrArg WithDim.val h_scaling
    simpa [lengthInCentimeters, lengthInMeters, h_unit_scale, NNReal.smul_def,
      smul_eq_mul] using h_scaling_val
  refine ⟨h_cos, h_radius_m, ?_⟩
  rw [h_length_conversion, h_radius_m]
  norm_num

end IPhO2026Problems.IPhO2026_2_B_3
... [leading content omitted]
```

### Blueprint excerpt
```tex
htBeam}
  The uniform parallel sunlight incident along the optical axis.
\end{definition}
\begin{proof}
  This is the defining declaration; unfolding it gives the stated typed data or relation.
\end{proof}

\begin{definition}[Figure2fSetup]
  \label{decl:physics:IPhO_2026_2_B_3:Figure2fSetup}
  \lean{IPhO2026Problems.IPhO2026_2_B_3.Figure2fSetup}
  \uses{decl:physics:IPhO_2026_2_B_3:PhysicalLength, decl:physics:IPhO_2026_2_B_3:HalfCylindricalMirror, decl:physics:IPhO_2026_2_B_3:FullyAbsorbingCylinder, decl:physics:IPhO_2026_2_B_3:SunlightBeam}
  The physical objects and center-to-center separation shown in Figure 2f.
\end{definition}
\begin{proof}
  This is the defining declaration; unfolding it gives the stated typed data or relation.
\end{proof}

\begin{theorem}[Physics formalization target]
\label{thm:physics:IPhO_2026_2_B_3:target}
\lean{IPhO2026Problems.IPhO2026_2_B_3.radius_for_fivefold_power}
\uses{decl:physics:IPhO_2026_2_B_3:PhysicalLength, decl:physics:IPhO_2026_2_B_3:OpticalPower, decl:physics:IPhO_2026_2_B_3:centimeterUnits, decl:physics:IPhO_2026_2_B_3:lengthInMeters, decl:physics:IPhO_2026_2_B_3:lengthInCentimeters, decl:physics:IPhO_2026_2_B_3:powerInSI, decl:physics:IPhO_2026_2_B_3:HalfCylindricalMirror, decl:physics:IPhO_2026_2_B_3:FullyAbsorbingCylinder, decl:physics:IPhO_2026_2_B_3:SunlightBeam, decl:physics:IPhO_2026_2_B_3:Figure2fSetup}
The assigned autoformalize agent should translate this physics problem into Lean declarations in the covered file, with theorem and lemma proof bodies written as `by sorry`.
\end{theorem}
\begin{proof}
This is an autoformalization task, not a proof task. Produce statements that can later be proved by the physics prover without weakening the physical model.
\end{proof}
% --- Archon physics formalization source end ---
... [leading content omitted]
```

### Report excerpt: `physics-grounding-IPhO2026Problems_problem_IPhO_2026_2_B_3.md`
```markdown
Explode.entriesToMessageData` (Mathlib)

## Local abstractions introduced

- `IPhO2026Problems.IPhO2026_2_B_3.Figure2fSetup`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_2_B_3.FullyAbsorbingCylinder`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_2_B_3.HalfCylindricalMirror`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_2_B_3.OpticalPower`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_2_B_3.PhysicalLength`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_2_B_3.SunlightBeam`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.

## Grounding gaps

- No unresolved LeanExplore grounding gaps were recorded by this preflight.
... [leading content omitted]
```

## 10. `IPhO2026Problems/problem_IPhO_2026_2_C_1.lean`

- Compile status: passed
- Open sorries: 0
- Direct-check seconds: 15.331
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_2_C_1.tex`
- Reports: `.archon/task_results/IPhO2026Problems_problem_IPhO_2026_2_C_1.lean.md`, `.archon/task_results/physics-grounding-IPhO2026Problems_problem_IPhO_2026_2_C_1.md`

### Lean excerpt
```lean
WithDim Dimension.L𝓭 ℝ))
    (h_strike_y :
      strike.y =
        (⟨mirror.radius.val * Real.cos θ⟩ : WithDim Dimension.L𝓭 ℝ))
    (h_incident_vertical : incidentDirection = Real.pi / 2)
    (h_tangent_direction : tangentDirection = Real.pi - θ)
    (h_reflection :
      ObeysSpecularReflection incidentDirection tangentDirection rayA.directionAngle)
    (h_slope_from_direction : rayA.slope = Real.tan rayA.directionAngle)
    (h_ray_through_strike : LiesOnRayLine rayA strike) :
    rayA.slope = Real.cot (2 * θ) ∧
      rayA.intercept =
        (⟨mirror.radius.val / (2 * Real.cos θ)⟩ :
          WithDim Dimension.L𝓭 ℝ) := by
  have h_reflected_direction :
      rayA.directionAngle = 2 * (Real.pi - θ) - Real.pi / 2 := by
    simpa [ObeysSpecularReflection, h_incident_vertical, h_tangent_direction] using
      h_reflection
  have h_direction_as_shift :
      2 * (Real.pi - θ) - Real.pi / 2 =
        (Real.pi / 2 - 2 * θ) + Real.pi := by
    ring
  have h_slope : rayA.slope = Real.cot (2 * θ) := by
    calc
      rayA.slope = Real.tan rayA.directionAngle := h_slope_from_direction
      _ = Real.tan ((Real.pi / 2 - 2 * θ) + Real.pi) := by
        rw [h_reflected_direction, h_direction_as_shift]
      _ = Real.tan (Real.pi / 2 - 2 * θ) := Real.tan_add_pi _
      _ = (Real.tan (2 * θ))⁻¹ := Real.tan_pi_div_two_sub _
      _ = Real.cot (2 * θ) := Real.tan_inv_eq_cot _

  have hθ_lt_pi : θ < Real.pi := by
    nlinarith [Real.pi_pos]
  have hsin_pos : 0 < Real.sin θ :=
    Real.sin_pos_of_pos_of_lt_pi hθ_pos hθ_lt_pi
  have hcos_pos : 0 < Real.cos θ := by
    apply Real.cos_pos_of_mem_Ioo
    constructor
    · nlinarith [Real.pi_pos]
    · exact hθ_acute
  have hsin_ne : Real.sin θ ≠ 0 := ne_of_gt hsin_pos
  have hcos_ne : Real.cos θ ≠ 0 := ne_of_gt hcos_pos
  have htrig :
      Real.cos θ - Real.cot (2 * θ) * Real.sin θ =
        1 / (2 * Real.cos θ) := by
    rw [Real.cot_eq_cos_div_sin, Real.sin_two_mul, Real.cos_two_mul']
    field_simp [hsin_ne, hcos_ne]
    nlinarith [Real.sin_sq_add_cos_sq θ]

  constructor
  · exact h_slope
  · rw [LiesOnRayLine, h_strike_x, h_strike_y, h_slope] at h_ray_through_strike
    apply WithDim.ext
    calc
      rayA.intercept.val =
          mirror.radius.val * Real.cos θ -
            Real.cot (2 * θ) * (mirror.radius.val * Real.sin θ) := by
        linarith
      _ = mirror.radius.val *
          (Real.cos θ - Real.cot (2 * θ) * Real.sin θ) := by
        ring
      _ = mirror.radius.val * (1 / (2 * Real.cos θ)) := by rw [htrig]
      _ = mirror.radius.val / (2 * Real.cos θ) := by ring

end IPhO2026_2_C_1
end IPhO2026Problems
... [leading content omitted]
```

### Blueprint excerpt
```tex
ves the stated typed data or relation.
\end{proof}

\begin{definition}[LiesOnRayLine]
  \label{decl:physics:IPhO_2026_2_C_1:LiesOnRayLine}
  \lean{IPhO2026Problems.IPhO2026_2_C_1.LiesOnRayLine}
  \uses{decl:physics:IPhO_2026_2_C_1:PlanePoint, decl:physics:IPhO_2026_2_C_1:SlopeInterceptRay}
  Incidence of a point on the slope-intercept line supporting a ray.
\end{definition}
\begin{proof}
  This is the defining declaration; unfolding it gives the stated typed data or relation.
\end{proof}

\begin{definition}[ObeysSpecularReflection]
  \label{decl:physics:IPhO_2026_2_C_1:ObeysSpecularReflection}
  \lean{IPhO2026Problems.IPhO2026_2_C_1.ObeysSpecularReflection}
  The equal-angle law of specular reflection, written in terms of oriented direction angles and the tangent line at the impact point.
\end{definition}
\begin{proof}
  This is the defining declaration; unfolding it gives the stated typed data or relation.
\end{proof}

\begin{theorem}[Physics formalization target]
\label{thm:physics:IPhO_2026_2_C_1:target}
\lean{IPhO2026Problems.IPhO2026_2_C_1.rayA_slope_and_intercept}
\uses{decl:physics:IPhO_2026_2_C_1:PlanePoint, decl:physics:IPhO_2026_2_C_1:HalfCylindricalMirror, decl:physics:IPhO_2026_2_C_1:SlopeInterceptRay, decl:physics:IPhO_2026_2_C_1:OnUpperHalfMirror, decl:physics:IPhO_2026_2_C_1:LiesOnRayLine, decl:physics:IPhO_2026_2_C_1:ObeysSpecularReflection}
The assigned autoformalize agent should translate this physics problem into Lean declarations in the covered file, with theorem and lemma proof bodies written as `by sorry`.
\end{theorem}
\begin{proof}
This is an autoformalization task, not a proof task. Produce statements that can later be proved by the physics prover without weakening the physical model.
\end{proof}
% --- Archon physics formalization source end ---
... [leading content omitted]
```

### Report excerpt: `IPhO2026Problems_problem_IPhO_2026_2_C_1.lean.md`
```markdown
h-valued intercept.

## Verification

- `lake env lean IPhO2026Problems/problem_IPhO_2026_2_C_1.lean`: exit code 0.
  Its only output was an unused-hypothesis linter warning for
  `h_strike_on_mirror`; there were no errors or `declaration uses sorry`
  warnings. The explicit strike-coordinate hypotheses already provide all
  geometry needed by the conclusion.
- `lake build`: completed successfully (4 jobs).
- Lean LSP diagnostics: no errors; only the same unused-hypothesis warning.
- `lean_verify` reported only the standard foundational axioms `propext`,
  `Classical.choice`, and `Quot.sound`, with no suspicious source patterns.
- A direct scan found no `sorry`, `admit`, `axiom`, `native_decide`, or
  `sorryAx` in the file.

## Blueprint status

The theorem environment `thm:physics:IPhO_2026_2_C_1:target` is ready for its
proof `\leanok` marker. Per the prover write restrictions in `.archon/AGENTS.md`,
the blueprint was not edited; deterministic marker synchronization should
apply it.

## Needs blueprint entry

None. No declarations were added.

## Redraft needed

None.

## Why I stopped

The sole assigned placeholder was soundly closed and the unchanged theorem
statement compiles.
... [leading content omitted]
```

### Report excerpt: `physics-grounding-IPhO2026Problems_problem_IPhO_2026_2_C_1.md`
```markdown
ctive.sameRay_map_iff` (Mathlib)

## Local abstractions introduced

- `IPhO2026Problems.IPhO2026_2_C_1.HalfCylindricalMirror`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_2_C_1.LiesOnRayLine`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_2_C_1.ObeysSpecularReflection`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_2_C_1.OnUpperHalfMirror`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_2_C_1.PlanePoint`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_2_C_1.SlopeInterceptRay`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.

## Grounding gaps

- No unresolved LeanExplore grounding gaps were recorded by this preflight.
... [leading content omitted]
```

## 11. `IPhO2026Problems/problem_IPhO_2026_2_C_2.lean`

- Compile status: passed
- Open sorries: 0
- Direct-check seconds: 13.766
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_2_C_2.tex`
- Reports: `.archon/task_results/IPhO2026Problems_problem_IPhO_2026_2_C_2.lean.md`, `.archon/task_results/physics-grounding-IPhO2026Problems_problem_IPhO_2026_2_C_2.md`

### Lean excerpt
```lean
radiusReadout / (2 * Real.cos (θ + h)) -
            (radiusReadout / (2 * Real.cos θ) +
              (radiusReadout / (2 * Real.cos θ) * Real.tan θ) * h))
        =O[𝓝 0] (fun h : ℝ => h ^ 2) :=
    analytic_remainder_bigO
      (fun angleRad : ℝ =>
        radiusReadout / (2 * Real.cos angleRad))
      θ ((radiusReadout / (2 * Real.cos θ)) * Real.tan θ)
      hintercept_analytic hintercept_deriv

  have hangle_tendsto :
      Tendsto (fun h : ℝ => θ + h) (𝓝 0) (𝓝 θ) := by
    simpa using
      ((tendsto_const_nhds :
          Tendsto (fun _ : ℝ => θ) (𝓝 0) (𝓝 θ)).add tendsto_id)
  have hadmissible :
      ∀ᶠ h : ℝ in 𝓝 0, 0 < θ + h ∧ θ + h < Real.pi / 2 :=
    hangle_tendsto.eventually
      (Ioo_mem_nhds setup.incidenceAngleRad_pos
        setup.incidenceAngleRad_lt_pi_div_two)
  refine hTaylor.congr' ?_ (Filter.Eventually.of_forall fun h => rfl)
  filter_upwards [hadmissible] with h hh
  have hray := reflectionLaw (θ + h) hh.1 hh.2
  change
    radiusReadout / (2 * Real.cos (θ + h)) -
        (radiusReadout / (2 * Real.cos θ) +
          (radiusReadout / (2 * Real.cos θ) * Real.tan θ) * h) =
      figure2gLengthReadout setup.coordinateUnits
          (setup.reflectedRayReadoutAt (θ + h)).intercept -
        (radiusReadout / (2 * Real.cos θ) *
          (1 + Real.tan θ * h))
  rw [hray.2]
  ring

/-- IPhO 2026 Problem 2 C.2: both requested first-order expansions of ray `B`.

The two conclusions say precisely that the displayed residuals are
`O((Δθ)²)` in the neighboring-ray limit `Δθ → 0`. -/
theorem IPhO_2026_2_C_2
    (setup : Figure2gSetup)
    (reflectionLaw : HalfCylindricalReflectionLaw setup)
    (previousPart : PreviousPartC1Result setup) :
    ((fun angularIncrementRad : ℝ =>
          (rayB setup angularIncrementRad).slope -
            (Real.cot (2 * setup.incidenceAngleRad) -
              2 * (Real.sin (2 * setup.incidenceAngleRad))⁻¹ ^ 2 *
                angularIncrementRad))
        =O[𝓝 0] (fun angularIncrementRad : ℝ => angularIncrementRad ^ 2)) ∧
      ((fun angularIncrementRad : ℝ =>
          figure2gLengthReadout setup.coordinateUnits
              (rayB setup angularIncrementRad).intercept -
            (figure2gLengthReadout setup.coordinateUnits setup.radius /
                (2 * Real.cos setup.incidenceAngleRad) *
              (1 + Real.tan setup.incidenceAngleRad * angularIncrementRad)))
        =O[𝓝 0] (fun angularIncrementRad : ℝ => angularIncrementRad ^ 2)) := by
  exact
    ⟨rayB_slope_firstOrder setup reflectionLaw previousPart,
      rayB_intercept_firstOrder setup reflectionLaw previousPart⟩

end IPhO2026_2_C_2
... [leading content omitted]
```

### Blueprint excerpt
```tex
intercept_firstOrder}
  \uses{decl:physics:IPhO_2026_2_C_2:Figure2gSetup, decl:physics:IPhO_2026_2_C_2:rayB, decl:physics:IPhO_2026_2_C_2:HalfCylindricalReflectionLaw, decl:physics:IPhO_2026_2_C_2:PreviousPartC1Result}
  The first-order intercept formula for neighboring ray “B”, with a remainder bounded by a constant times “(Δθ)²” as “Δθ → 0”.
\end{theorem}
\begin{proof}
  Combine the governing assumptions named in the statement and carry out the indicated physical or algebraic deduction.
\end{proof}

\begin{theorem}[Physics formalization target]
\label{thm:physics:IPhO_2026_2_C_2:target}
\lean{IPhO2026_2_C_2.IPhO_2026_2_C_2}
\uses{decl:physics:IPhO_2026_2_C_2:ReflectedRayReadout, decl:physics:IPhO_2026_2_C_2:ReflectedRayReadout:yCoordinateLengthReadout, decl:physics:IPhO_2026_2_C_2:Figure2gSetup, decl:physics:IPhO_2026_2_C_2:rayA, decl:physics:IPhO_2026_2_C_2:rayB, decl:physics:IPhO_2026_2_C_2:HalfCylindricalReflectionLaw, decl:physics:IPhO_2026_2_C_2:PreviousPartC1Result, decl:physics:IPhO_2026_2_C_2:rayB_slope_firstOrder, decl:physics:IPhO_2026_2_C_2:rayB_intercept_firstOrder}
The reflected neighboring ray has
\[
m_B=\cot(2\theta)-2\csc^2(2\theta)\Delta\theta
  +O(\Delta\theta^2)
\]
and
\[
b_B=\frac{R}{2\cos\theta}
  \left(1+\tan\theta\,\Delta\theta\right)+O(\Delta\theta^2),
\]
where every length readout uses the named common-unit projection.
\end{theorem}
\begin{proof}
Differentiate the exact Figure 2g relations
\(m(\phi)=\cot(2\phi)\) and \(b(\phi)=R/(2\cos\phi)\).
Their derivatives at \(\theta\) are
\(-2\csc^2(2\theta)\) and
\((R/(2\cos\theta))\tan\theta\), respectively.
Taylor expansion at \(\theta\), with the angle restricted away from the
singular endpoints, gives the two stated quadratic remainders.
\end{proof}
% --- Archon physics formalization source end ---
... [leading content omitted]
```

### Report excerpt: `IPhO2026Problems_problem_IPhO_2026_2_C_2.lean.md`
```markdown
dentifies the modeled ray readouts with the
  exact trigonometric formulas.
- The final theorem pairs the two proved expansion lemmas.

The exact reflection law is stronger than the central-ray equality supplied by
`previousPart`, so that frozen argument is intentionally unused in the first
two lemmas; Lean reports only the corresponding linter warnings.

## Verification

- Lean LSP diagnostics: no errors; only the two expected unused-variable
  warnings.
- `lake env lean IPhO2026Problems/problem_IPhO_2026_2_C_2.lean`: passed.
- `lake build`: passed (`Build completed successfully (4 jobs)`).
- `lean_verify` on all three proved theorems found only the standard
  foundational axioms `propext`, `Classical.choice`, and `Quot.sound`, with no
  suspicious source warnings.
- Direct source scan found no `sorry`, `admit`, `axiom`, `sorryAx`, or
  `native_decide`.

## Blueprint readiness

The proof environments for
`IPhO2026_2_C_2.rayB_slope_firstOrder`,
`IPhO2026_2_C_2.rayB_intercept_firstOrder`, and
`IPhO2026_2_C_2.IPhO_2026_2_C_2` are closed and ready for the deterministic
`sync_leanok` phase. Per prover permissions, the blueprint chapter was not
edited directly.

## Redraft needed

None.
... [leading content omitted]
```

### Report excerpt: `physics-grounding-IPhO2026Problems_problem_IPhO_2026_2_C_2.md`
```markdown
art` (Mathlib)
- `ComplexShape.prev_eq'` (Mathlib)
- `Mathlib.Command.MinImports.previousInstName` (Mathlib)
- `slope` (Mathlib)
- `slope_pos_iff` (Mathlib)
- `slope_pos_iff_gt` (Mathlib)
- `FirstOrder.«term_≅[_]_»` (Mathlib)
- `Set.Ioi` (Mathlib)
- `Set.Ioc_inter_Ioi` (Mathlib)

## Local abstractions introduced

- `IPhO2026_2_C_2.Figure2gSetup`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026_2_C_2.HalfCylindricalReflectionLaw`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026_2_C_2.IPhO_2026_2_C_2`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026_2_C_2.PreviousPartC1Result`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026_2_C_2.ReflectedRayReadout`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.

## Grounding gaps

- No unresolved LeanExplore grounding gaps were recorded by this preflight.
... [leading content omitted]
```

## 12. `IPhO2026Problems/problem_IPhO_2026_2_C_3.lean`

- Compile status: passed
- Open sorries: 0
- Direct-check seconds: 21.225
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_2_C_3.tex`
- Reports: `.archon/task_results/IPhO2026Problems_problem_IPhO_2026_2_C_3.lean.md`, `.archon/task_results/physics-grounding-IPhO2026Problems_problem_IPhO_2026_2_C_3.md`

### Lean excerpt
```lean
θ) /
            (-(2 * (Real.sin (2 * θ))⁻¹ ^ 2)))) :=
    hInterceptQuotient.neg.div hSlopeQuotient hSlopeLimit_ne
  have hXValue :
      (-
            ((lengthProjection.readout mirror.radius /
              (2 * Real.cos θ)) * Real.tan θ) /
          (-(2 * (Real.sin (2 * θ))⁻¹ ^ 2))) =
        lengthProjection.readout mirror.radius * Real.sin θ ^ 3 := by
    rw [Real.tan_eq_sin_div_cos, Real.sin_two_mul]
    field_simp
  have hXLimit :
      Tendsto
        (fun Δθ : ℝ ↦
          lengthProjection.readout
            (neighboringIntersection Δθ).xCoordinate)
        (𝓝[≠] (0 : ℝ))
        (𝓝
          (lengthProjection.readout mirror.radius *
            Real.sin θ ^ 3)) := by
    rw [← hXValue]
    exact hXRatioLimit.congr' hXEventual.symm
  have hYEventual :
      (fun Δθ : ℝ ↦
          lengthProjection.readout
            (neighboringIntersection Δθ).yCoordinate)
        =ᶠ[𝓝[≠] (0 : ℝ)]
      (fun Δθ : ℝ ↦
        Real.cot (2 * θ) *
            lengthProjection.readout
              (neighboringIntersection Δθ).xCoordinate +
          lengthProjection.readout mirror.radius /
            (2 * Real.cos θ)) := by
    filter_upwards [hNeighboringIntersection] with Δθ hIntersection
    rcases hIntersection with ⟨hRayA, _⟩
    rw [ReflectedRayLine.Contains] at hRayA
    simpa only [hRayA_slope, hRayA_intercept] using hRayA
  have hYRawLimit :
      Tendsto
        (fun Δθ : ℝ ↦
          Real.cot (2 * θ) *
              lengthProjection.readout
                (neighboringIntersection Δθ).xCoordinate +
            lengthProjection.readout mirror.radius /
              (2 * Real.cos θ))
        (𝓝[≠] (0 : ℝ))
        (𝓝
          (Real.cot (2 * θ) *
              (lengthProjection.readout mirror.radius *
                Real.sin θ ^ 3) +
            lengthProjection.readout mirror.radius /
              (2 * Real.cos θ))) :=
    (tendsto_const_nhds.mul hXLimit).add tendsto_const_nhds
  have hYValue :
      Real.cot (2 * θ) *
            (lengthProjection.readout mirror.radius *
              Real.sin θ ^ 3) +
          lengthProjection.readout mirror.radius /
            (2 * Real.cos θ) =
        (lengthProjection.readout mirror.radius / 2) * Real.cos θ *
          (2 - Real.cos (2 * θ)) := by
    rw [Real.cot_eq_cos_div_sin, Real.sin_two_mul,
      Real.cos_two_mul_eq_one_sub]
    field_simp
    have hcos_sq : Real.cos θ ^ 2 = 1 - Real.sin θ ^ 2 := by
      nlinarith [Real.sin_sq_add_cos_sq θ]
    rw [hcos_sq]
    ring
  constructor
  · exact hXLimit
  · rw [← hYValue]
    exact hYRawLimit.congr' hYEventual.symm

end IPhO2026Problems.IPhO2026_2_C_3
... [leading content omitted]
```

### Blueprint excerpt
```tex
hboringReflectedIntersection}
  \lean{IPhO2026Problems.IPhO2026_2_C_3.IsNeighboringReflectedIntersection}
  \uses{decl:physics:IPhO_2026_2_C_3:Figure2gPoint, decl:physics:IPhO_2026_2_C_3:ReflectedRayLine}
  A point is the intersection of the reflected ray at incidence angle “θ” (ray A) and the reflected ray at the neighboring angle “θ + Δθ” (ray B).
\end{definition}
\begin{proof}
  This is the defining declaration; unfolding it gives the stated typed data or relation.
\end{proof}

\begin{theorem}[Physics formalization target]
\label{thm:physics:IPhO_2026_2_C_3:target}
\lean{IPhO2026Problems.IPhO2026_2_C_3.limitingIntersectionCoordinates}
\uses{decl:physics:IPhO_2026_2_C_3:Figure2gMirror, decl:physics:IPhO_2026_2_C_3:Figure2gPoint, decl:physics:IPhO_2026_2_C_3:Figure2gMirror:OnReflectingSurface, decl:physics:IPhO_2026_2_C_3:ReflectedRayLine, decl:physics:IPhO_2026_2_C_3:ReflectedRayLine:Contains, decl:physics:IPhO_2026_2_C_3:IsNeighboringReflectedIntersection}
The intersections of ray \(A\) with ray \(B\) tend, as
\(\Delta\theta\to0\) through nonzero values, to
\[
X_c=R\sin^3\theta,\qquad
Y_c=\frac R2\cos\theta\left(2-\cos(2\theta)\right),
\]
using the same named length projection for \(R,X_c,Y_c\).
\end{theorem}
\begin{proof}
For the two affine ray equations, subtract to obtain
\[
x(\Delta\theta)=-
\frac{b(\theta+\Delta\theta)-b(\theta)}
     {m(\theta+\Delta\theta)-m(\theta)}.
\]
The C.2 expansions show that the limit is \(-b'(\theta)/m'(\theta)\).
Substituting \(m'(\theta)=-2\csc^2(2\theta)\) and
\(b'(\theta)=R\tan\theta/(2\cos\theta)\), then simplifying, gives
\(X_c=R\sin^3\theta\).  Substitute this limit into
\(y=m(\theta)x+b(\theta)\) and use the double-angle identities to obtain the
formula for \(Y_c\).
\end{proof}
% --- Archon physics formalization source end ---
... [leading content omitted]
```

### Report excerpt: `IPhO2026Problems_problem_IPhO_2026_2_C_3.lean.md`
```markdown
onzero. The two affine-line
incidence equations then give the neighboring intersection's `x` coordinate
as the quotient of those differences. The `y` coordinate follows from the
fixed ray-A equation. Mathlib's double-angle identities and field
simplification establish the two requested closed forms.

## Verification

- `lake env lean IPhO2026Problems/problem_IPhO_2026_2_C_3.lean`: exit code 0
  with no output.
- `lake build`: exit code 0 (`Build completed successfully (4 jobs)`).
- Lean LSP diagnostics: no errors or warnings.
- `lean_verify` reported only the standard foundational axioms
  (`propext`, `Classical.choice`, and `Quot.sound`) and no suspicious source
  patterns.
- No `sorry`, `admit`, `axiom`, or `sorryAx` remains in the assigned file.

## Blueprint status

The proof environment `thm:physics:IPhO_2026_2_C_3:target` is ready for its
proof `\leanok` marker. Per the prover write restrictions, the blueprint was
not edited; deterministic marker synchronization should apply it.

## Needs blueprint entry

None. No declarations were added.

## Redraft needed

None.

## Why I stopped

The sole assigned placeholder was soundly closed and the unchanged theorem
statement compiles.
... [leading content omitted]
```

### Report excerpt: `physics-grounding-IPhO2026Problems_problem_IPhO_2026_2_C_3.md`
```markdown
# Local abstractions introduced

- `IPhO2026Problems.IPhO2026_2_C_3.Figure2gMirror`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_2_C_3.Figure2gMirror.OnReflectingSurface`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_2_C_3.Figure2gPoint`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_2_C_3.IsNeighboringReflectedIntersection`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_2_C_3.ReflectedRayLine`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_2_C_3.ReflectedRayLine.Contains`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.

## Grounding gaps

- No unresolved LeanExplore grounding gaps were recorded by this preflight.
... [leading content omitted]
```

## 13. `IPhO2026Problems/problem_IPhO_2026_2_C_4.lean`

- Compile status: passed
- Open sorries: 0
- Direct-check seconds: 14.514
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_2_C_4.tex`
- Reports: `.archon/task_results/IPhO2026Problems_problem_IPhO_2026_2_C_4.lean.md`, `.archon/task_results/physics-grounding-IPhO2026Problems_problem_IPhO_2026_2_C_4.md`

### Lean excerpt
```lean
rw [show u.val = R / 2 by rfl]
    rw [(hC3 θ).1, (hC3 θ).2, hden, Real.cos_two_mul, Real.sin_sq]
    have hRpow_ne : Real.rpow R (2 / 3 : ℝ) ≠ 0 :=
      ne_of_gt (Real.rpow_pos_of_pos hR _)
    have hone_minus_cos_sq_ne : 1 - Real.cos θ ^ 2 ≠ 0 := by
      rw [← Real.sin_sq]
      exact hsin_sq_ne
    dsimp [R] at hRsplit hRpow_ne ⊢
    field_simp [hRpow_ne, hcos_add_ne, hone_minus_cos_sq_ne]
    calc
      system.radius.val *
            (Real.cos θ * (2 - (2 * Real.cos θ ^ 2 - 1)) - 1) *
          (1 + Real.cos θ) =
          system.radius.val *
            ((1 - Real.cos θ ^ 2) *
              (2 * Real.cos θ ^ 2 + 2 * Real.cos θ - 1)) := by
        ring
      _ =
          (system.radius.val ^ (1 / 3 : ℝ) *
              system.radius.val ^ (2 / 3 : ℝ)) *
            ((1 - Real.cos θ ^ 2) *
              (2 * Real.cos θ ^ 2 + 2 * Real.cos θ - 1)) := by
        rw [← hRsplit]
      _ =
          system.radius.val ^ (2 / 3 : ℝ) *
              (1 - Real.cos θ ^ 2) *
            system.radius.val ^ (1 / 3 : ℝ) *
              (2 * Real.cos θ * (Real.cos θ + 1) - 1) := by
        ring
  have hcontinuous :
      ContinuousAt
        (fun θ : ℝ =>
          (Real.rpow R (1 / 3 : ℝ) / 2) *
            ((2 * Real.cos θ ^ 2 + 2 * Real.cos θ - 1) /
              (1 + Real.cos θ)))
        0 := by
    have hcos : ContinuousAt (fun θ : ℝ => Real.cos θ) 0 :=
      Real.continuous_cos.continuousAt
    have hnum :
        ContinuousAt
          (fun θ : ℝ =>
            2 * Real.cos θ ^ 2 + 2 * Real.cos θ - 1)
          0 := by
      exact ((continuousAt_const.mul (hcos.pow 2)).add
        (continuousAt_const.mul hcos)).sub continuousAt_const
    have hden :
        ContinuousAt (fun θ : ℝ => 1 + Real.cos θ) 0 :=
      continuousAt_const.add hcos
    exact continuousAt_const.mul (hnum.div hden (by norm_num))
  have hlimit :
      Tendsto
        (fun θ : ℝ =>
          (Real.rpow R (1 / 3 : ℝ) / 2) *
            ((2 * Real.cos θ ^ 2 + 2 * Real.cos θ - 1) /
              (1 + Real.cos θ)))
        (𝓝[≠] 0)
        (𝓝
          ((Real.rpow R (1 / 3 : ℝ) / 2) *
            ((2 * Real.cos 0 ^ 2 + 2 * Real.cos 0 - 1) /
              (1 + Real.cos 0)))) :=
    hcontinuous.tendsto.mono_left inf_le_left
  have hlimit' :
      Tendsto
        (fun θ : ℝ =>
          (Real.rpow R (1 / 3 : ℝ) / 2) *
            ((2 * Real.cos θ ^ 2 + 2 * Real.cos θ - 1) /
              (1 + Real.cos θ)))
        (𝓝[≠] 0) (𝓝 v.val) := by
    convert hlimit using 1
    norm_num [v, R]
    ring
  simpa using Filter.Tendsto.congr' hformula.symm hlimit'

end

end IPhO2026Problems.IPhO2026_2_C_4
... [leading content omitted]
```

### Blueprint excerpt
```tex
ope law: the caustic point at angle “θ” is the limit of intersections of reflected rays whose incidence-angle separation “Δθ” tends to zero through nonzero values.
\end{definition}
\begin{proof}
  This is the defining declaration; unfolding it gives the stated typed data or relation.
\end{proof}

\begin{definition}[HasPreviousPartC3Coordinates]
  \label{decl:physics:IPhO_2026_2_C_4:HasPreviousPartC3Coordinates}
  \lean{IPhO2026Problems.IPhO2026_2_C_4.HasPreviousPartC3Coordinates}
  \uses{decl:physics:IPhO_2026_2_C_4:Figure2gOpticalSystem}
  The reusable conclusion of part C.3, stated directly rather than importing that part's Lean output.
\end{definition}
\begin{proof}
  This is the defining declaration; unfolding it gives the stated typed data or relation.
\end{proof}

\begin{theorem}[Physics formalization target]
\label{thm:physics:IPhO_2026_2_C_4:target}
\lean{IPhO2026Problems.IPhO2026_2_C_4.determineSmallAngleCaustic}
\uses{decl:physics:IPhO_2026_2_C_4:LengthReading, decl:physics:IPhO_2026_2_C_4:CubeRootLengthReading, decl:physics:IPhO_2026_2_C_4:ReflectedLineReadout, decl:physics:IPhO_2026_2_C_4:Figure2gOpticalSystem, decl:physics:IPhO_2026_2_C_4:neighboringIntersectionX, decl:physics:IPhO_2026_2_C_4:neighboringIntersectionY, decl:physics:IPhO_2026_2_C_4:NeighboringReflectedRaysGenerateCaustic, decl:physics:IPhO_2026_2_C_4:HasPreviousPartC3Coordinates}
The assigned autoformalize agent should translate this physics problem into Lean declarations in the covered file, with theorem and lemma proof bodies written as `by sorry`.
\end{theorem}
\begin{proof}
This is an autoformalization task, not a proof task. Produce statements that can later be proved by the physics prover without weakening the physical model.
\end{proof}
% --- Archon physics formalization source end ---
... [leading content omitted]
```

### Report excerpt: `IPhO2026Problems_problem_IPhO_2026_2_C_4.lean.md`
```markdown
onzero. This permits the
exact simplification

`|R sin^3 θ|^(2/3) = R^(2/3) sin^2 θ`.

Using the C.3 coordinate hypothesis, the normalized caustic ordinate is then
eventually equal to

`(R^(1/3) / 2) * (2 cos^2 θ + 2 cos θ - 1) / (1 + cos θ)`.

Continuity at `θ = 0` gives the limit
`(R^(1/3) / 2) * (3 / 2) = (3 / 4) R^(1/3)`.
The envelope hypothesis is faithful contextual data but is not needed once
the reusable C.3 coordinate formulas are assumed.

## Verification

- `lake env lean IPhO2026Problems/problem_IPhO_2026_2_C_4.lean`: passed.
  The only theorem-specific compiler warning is that the frozen contextual
  hypothesis `hEnvelope` is unused.
- `lake build`: passed (4 jobs).
- Lean LSP diagnostics: no errors.
- Source scan: no `sorry`, `admit`, `axiom`, `native_decide`, or `sorryAx`.
- `lean_verify`: only the standard foundational axioms `propext`,
  `Classical.choice`, and `Quot.sound`; no suspicious source patterns.

## Blueprint status

The target theorem environment
`thm:physics:IPhO_2026_2_C_4:target` is ready for its proof `\leanok`
marker. Per prover permissions, the blueprint was not edited; deterministic
marker synchronization should apply it.

## Redraft needed

None.
... [leading content omitted]
```

### Report excerpt: `physics-grounding-IPhO2026Problems_problem_IPhO_2026_2_C_4.md`
```markdown
l abstractions introduced

- `IPhO2026Problems.IPhO2026_2_C_4.CubeRootLengthReading`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_2_C_4.Figure2gOpticalSystem`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_2_C_4.HasPreviousPartC3Coordinates`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_2_C_4.LengthReading`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_2_C_4.NeighboringReflectedRaysGenerateCaustic`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_2_C_4.ReflectedLineReadout`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.

## Grounding gaps

- No unresolved LeanExplore grounding gaps were recorded by this preflight.
... [leading content omitted]
```

## 14. `IPhO2026Problems/problem_IPhO_2026_3_A_1.lean`

- Compile status: passed
- Open sorries: 0
- Direct-check seconds: 9.795
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_3_A_1.tex`
- Reports: `.archon/task_results/IPhO2026Problems_problem_IPhO_2026_3_A_1.lean.md`, `.archon/task_results/physics-grounding-IPhO2026Problems_problem_IPhO_2026_3_A_1.md`

### Lean excerpt
```lean
eadout state.instantaneousCurrent

/--
For the homogeneous thin torus of Figure 3a, Ampère's circuital law gives

`H = N I A / V`.

This is the formalization target for IPhO 2026 problem 3, part A.1.
-/
theorem fieldStrength_eq_turns_current_area_div_volume
    (torus : ParamagneticTorus)
    (winding : ToroidalWinding)
    (state : ToroidalMagneticState)
    (μ₀ : VacuumPermeabilityMagnitude)
    (ampereReadouts : ToroidalAmpereReadouts)
    (ε : ℝ)
    (signConvention : EnergyTransferSignConvention)
    (h_material : HasStatedMaterialProperties torus)
    (h_geometry : HasFigure3aGeometry torus)
    (h_thin_torus : IsThinToroidAtScale torus ε)
    (h_winding : HasStatedWindingProperties winding)
    (h_uniform_fields : UsesUniformParallelFieldApproximation state)
    (h_nonnegative_magnitudes : HasNonnegativeMagnitudes state)
    (h_constitutive :
      SatisfiesParamagneticConstitutiveLaw μ₀ state)
    (h_ampere :
      SatisfiesToroidalAmpereCircuitalLaw
        torus winding state ampereReadouts)
    (h_sign_convention :
      signConvention = EnergyTransferSignConvention.positiveIntoTorus) :
    siReadout state.fieldStrength =
      (winding.turnCount : ℝ) *
        siReadout state.instantaneousCurrent *
        siReadout torus.crossSectionArea /
        siReadout torus.volume := by
  rcases h_geometry with
    ⟨_, _, _, h_volume_pos, _, _, h_volume⟩
  rcases h_ampere with
    ⟨h_circulation_eq_linked, h_circulation_eval, h_linked_current⟩
  have h_ampere_scalar :
      siReadout state.fieldStrength *
          siReadout torus.meanAmperePathLength =
        (winding.turnCount : ℝ) *
          siReadout state.instantaneousCurrent := by
    calc
      siReadout state.fieldStrength *
            siReadout torus.meanAmperePathLength =
          siReadout ampereReadouts.fieldCirculation :=
        h_circulation_eval.symm
      _ = siReadout ampereReadouts.linkedFreeCurrent :=
        h_circulation_eq_linked
      _ = (winding.turnCount : ℝ) *
            siReadout state.instantaneousCurrent :=
        h_linked_current
  apply (eq_div_iff h_volume_pos.ne').2
  rw [h_volume]
  calc
    siReadout state.fieldStrength *
          (siReadout torus.crossSectionArea *
            siReadout torus.meanAmperePathLength) =
        (siReadout state.fieldStrength *
            siReadout torus.meanAmperePathLength) *
          siReadout torus.crossSectionArea := by
      ring
    _ = (winding.turnCount : ℝ) *
          siReadout state.instantaneousCurrent *
          siReadout torus.crossSectionArea := by
      rw [h_ampere_scalar]

end IPhO2026Problems.IPhO2026_3_A_1
... [leading content omitted]
```

### Blueprint excerpt
```tex
entDimension, decl:physics:IPhO_2026_3_A_1:magneticFieldStrengthDimension, decl:physics:IPhO_2026_3_A_1:vacuumPermeabilityDimension, decl:physics:IPhO_2026_3_A_1:magneticFluxDensityDimension, decl:physics:IPhO_2026_3_A_1:PhysicalLength, decl:physics:IPhO_2026_3_A_1:PhysicalArea, decl:physics:IPhO_2026_3_A_1:PhysicalVolume, decl:physics:IPhO_2026_3_A_1:ElectricCurrentMagnitude, decl:physics:IPhO_2026_3_A_1:MagneticFieldStrengthMagnitude, decl:physics:IPhO_2026_3_A_1:MagnetizationMagnitude, decl:physics:IPhO_2026_3_A_1:VacuumPermeabilityMagnitude, decl:physics:IPhO_2026_3_A_1:MagneticFluxDensityMagnitude, decl:physics:IPhO_2026_3_A_1:siReadout, decl:physics:IPhO_2026_3_A_1:ParamagneticTorus, decl:physics:IPhO_2026_3_A_1:HasStatedMaterialProperties, decl:physics:IPhO_2026_3_A_1:HasFigure3aGeometry, decl:physics:IPhO_2026_3_A_1:IsThinToroidAtScale, decl:physics:IPhO_2026_3_A_1:ToroidalWinding, decl:physics:IPhO_2026_3_A_1:HasStatedWindingProperties, decl:physics:IPhO_2026_3_A_1:EnergyTransferSignConvention, decl:physics:IPhO_2026_3_A_1:ToroidalMagneticState, decl:physics:IPhO_2026_3_A_1:UsesUniformParallelFieldApproximation, decl:physics:IPhO_2026_3_A_1:HasNonnegativeMagnitudes, decl:physics:IPhO_2026_3_A_1:SatisfiesParamagneticConstitutiveLaw, decl:physics:IPhO_2026_3_A_1:ToroidalAmpereReadouts, decl:physics:IPhO_2026_3_A_1:SatisfiesToroidalAmpereCircuitalLaw}
The assigned autoformalize agent should translate this physics problem into Lean declarations in the covered file, with theorem and lemma proof bodies written as `by sorry`.
\end{theorem}
\begin{proof}
This is an autoformalization task, not a proof task. Produce statements that can later be proved by the physics prover without weakening the physical model.
\end{proof}
% --- Archon physics formalization source end ---
... [leading content omitted]
```

### Report excerpt: `IPhO2026Problems_problem_IPhO_2026_3_A_1.lean.md`
```markdown
A * ℓ` and the hypothesis `0 < V`; after
rewriting the volume, `eq_div_iff` and commutative-ring normalization prove
`H = N * I * A / V`.

## Verification

- `lake env lean IPhO2026Problems/problem_IPhO_2026_3_A_1.lean`: exit code 0.
  The only output was unused-hypothesis linter warnings; there were no errors
  and no `declaration uses sorry` warning.
- A direct scan found no `sorry`, `admit`, `axiom`, or `sorryAx` in the file.
- `lake build IPhO2026Problems.problem_IPhO_2026_3_A_1` is not a declared Lake
  target (`unknown target`); the file-level Lean compilation above is the
  applicable check because the package exposes only the `IPhO2026Run` library,
  whose source root does not contain this file.

## Blueprint status

The theorem environment
`thm:physics:IPhO_2026_3_A_1:target` is ready for its proof `\leanok` marker.
Per the prover write restrictions, the blueprint was not edited; deterministic
marker synchronization should apply it.

## Needs blueprint entry

None. No declarations were added.

## Redraft needed

None.

## Why I stopped

Real progress: the sole assigned sorry was closed, reducing the file from one
sorry to zero. The unchanged theorem statement now compiles.
... [leading content omitted]
```

### Report excerpt: `physics-grounding-IPhO2026Problems_problem_IPhO_2026_3_A_1.md`
```markdown
are scalar.
- `IPhO2026Problems.IPhO2026_3_A_1.SatisfiesToroidalAmpereCircuitalLaw`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_3_A_1.ToroidalAmpereReadouts`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_3_A_1.ToroidalMagneticState`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_3_A_1.ToroidalWinding`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_3_A_1.UsesUniformParallelFieldApproximation`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_3_A_1.VacuumPermeabilityMagnitude`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.

## Grounding gaps

- No unresolved LeanExplore grounding gaps were recorded by this preflight.
... [leading content omitted]
```

## 15. `IPhO2026Problems/problem_IPhO_2026_3_A_2.lean`

- Compile status: passed
- Open sorries: 0
- Direct-check seconds: 18.565
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_3_A_2.tex`
- Reports: `.archon/task_results/IPhO2026Problems_problem_IPhO_2026_3_A_2.lean.md`, `.archon/task_results/physics-grounding-IPhO2026Problems_problem_IPhO_2026_3_A_2.md`

### Lean excerpt
```lean
volume u

/--
Faraday induction with the external voltage compensating the induced emf.
The source voltage impulse is therefore `N A dB` with the sign that increases
the torus flux density.
-/
def SatisfiesFaradayCompensationLaw
    (g : TorusGeometry) (w : IdealToroidalWinding)
    (dB : DimMagneticFluxDensityIncrement)
    (sourceVoltageImpulse : DimVoltageImpulse) : Prop :=
  ∀ u : UnitChoices,
    signedReadout sourceVoltageImpulse u =
      (w.turnCount : ℝ) * magnitudeReadout g.crossSectionArea u *
        signedReadout dB u

/--
Electrical work supplied by a lossless external source is current times the
source voltage impulse.  Positive `dWemf` means energy entering the
paramagnetic torus, as required by the problem's sign convention.
-/
def SatisfiesExternalSourceWorkLaw
    (w : IdealToroidalWinding)
    (sourceVoltageImpulse : DimVoltageImpulse)
    (dWemf : DimEnergy) : Prop :=
  ∀ u : UnitChoices,
    signedReadout dWemf u =
      signedReadout w.current u * signedReadout sourceVoltageImpulse u

/--
For a magnetic-flux-density change `dB`, the work performed by the external
voltage source is

`dW_emf = V H dB`.

The conclusion is stated for every choice of units.  The hypotheses contain
the constitutive, Ampère, Faraday, and source-work laws, but do not assume this
final relation.
-/
theorem externalSourceWorkIncrement_eq_volume_mul_fieldStrength_mul_fluxDensityIncrement
    (g : TorusGeometry)
    (ε : ℝ)
    (w : IdealToroidalWinding)
    (s : UniformMagneticState)
    (μ₀ : DimVacuumPermeability)
    (dB : DimMagneticFluxDensityIncrement)
    (sourceVoltageImpulse : DimVoltageImpulse)
    (dWemf : DimEnergy)
    (hGeometry : IsThinCircularTorus g ε)
    (hTurns : 0 < w.turnCount)
    (hAligned : IsAlignedParamagneticState s)
    (hConstitutive : SatisfiesParamagneticConstitutiveLaw μ₀ s)
    (hAmpere : SatisfiesThinTorusAmpereLaw g w s)
    (hFaraday :
      SatisfiesFaradayCompensationLaw g w dB sourceVoltageImpulse)
    (hSourceWork :
      SatisfiesExternalSourceWorkLaw w sourceVoltageImpulse dWemf) :
    ∀ u : UnitChoices,
      signedReadout dWemf u =
        magnitudeReadout g.volume u *
          signedReadout s.fieldStrength u * signedReadout dB u := by
  intro u
  rcases hGeometry with ⟨_, _, hGeometry⟩
  rcases hGeometry u with ⟨hR, hr, _, hA, hV⟩
  have hA_pos : 0 < magnitudeReadout g.crossSectionArea u := by
    rw [hA]
    positivity
  have hV_pos : 0 < magnitudeReadout g.volume u := by
    rw [hV]
    positivity
  rw [hSourceWork u, hFaraday u, hAmpere u]
  field_simp [ne_of_gt hV_pos]

end IPhO2026_3_A_2
end IPhO2026Problems
... [leading content omitted]
```

### Blueprint excerpt
```tex
roof}
  This is the defining declaration; unfolding it gives the stated typed data or relation.
\end{proof}

\begin{theorem}[Physics formalization target]
\label{thm:physics:IPhO_2026_3_A_2:target}
\lean{IPhO2026Problems.IPhO2026_3_A_2.externalSourceWorkIncrement_eq_volume_mul_fieldStrength_mul_fluxDensityIncrement}
\uses{decl:physics:IPhO_2026_3_A_2:DimLengthMagnitude, decl:physics:IPhO_2026_3_A_2:DimVolumeMagnitude, decl:physics:IPhO_2026_3_A_2:DimElectricCurrent, decl:physics:IPhO_2026_3_A_2:DimMagneticFieldStrength, decl:physics:IPhO_2026_3_A_2:DimMagnetization, decl:physics:IPhO_2026_3_A_2:DimMagneticFluxDensity, decl:physics:IPhO_2026_3_A_2:DimMagneticFluxDensityIncrement, decl:physics:IPhO_2026_3_A_2:DimVacuumPermeability, decl:physics:IPhO_2026_3_A_2:DimVoltageImpulse, decl:physics:IPhO_2026_3_A_2:signedReadout, decl:physics:IPhO_2026_3_A_2:magnitudeReadout, decl:physics:IPhO_2026_3_A_2:TorusGeometry, decl:physics:IPhO_2026_3_A_2:IsThinCircularTorus, decl:physics:IPhO_2026_3_A_2:IdealToroidalWinding, decl:physics:IPhO_2026_3_A_2:UniformMagneticState, decl:physics:IPhO_2026_3_A_2:IsAlignedParamagneticState, decl:physics:IPhO_2026_3_A_2:SatisfiesParamagneticConstitutiveLaw, decl:physics:IPhO_2026_3_A_2:SatisfiesThinTorusAmpereLaw, decl:physics:IPhO_2026_3_A_2:SatisfiesFaradayCompensationLaw, decl:physics:IPhO_2026_3_A_2:SatisfiesExternalSourceWorkLaw}
The assigned autoformalize agent should translate this physics problem into Lean declarations in the covered file, with theorem and lemma proof bodies written as `by sorry`.
\end{theorem}
\begin{proof}
This is an autoformalization task, not a proof task. Produce statements that can later be proved by the physics prover without weakening the physical model.
\end{proof}
% --- Archon physics formalization source end ---
... [leading content omitted]
```

### Report excerpt: `IPhO2026Problems_problem_IPhO_2026_3_A_2.lean.md`
```markdown
e the cross-sectional area and volume
  readouts are strictly positive, hence the volume denominator is nonzero.
- Specialized the source-work, Faraday-compensation, and thin-torus Ampère
  laws.
- Rewrote the three identities and closed
  `I * (N * A * dB) = V * ((N * I * A) / V) * dB` with `field_simp`.
- The alignment and constitutive-law assumptions remain faithful contextual
  hypotheses but are not needed for this subquestion.

No declaration search was needed: the proof uses only local hypotheses and
standard arithmetic tactics.

## Verification

- Lean LSP: no errors; only expected unused-context warnings for the frozen
  `hAligned` and `hConstitutive` parameters.
- `lake env lean IPhO2026Problems/problem_IPhO_2026_3_A_2.lean`: passed.
- `lake build`: passed.
- Source scan: no `sorry`, `admit`, `sorryAx`, or introduced `axiom`.
- `lean_verify`: only the standard foundational axioms `propext`,
  `Classical.choice`, and `Quot.sound`; no suspicious source patterns.

## Blueprint

The target theorem proof is closed and ready for `\leanok`. Per prover
permissions, the blueprint chapter was not edited; deterministic
`sync_leanok` should apply the marker.

## Redraft needed

None.
... [leading content omitted]
```

### Report excerpt: `physics-grounding-IPhO2026Problems_problem_IPhO_2026_3_A_2.md`
```markdown
are scalar.
- `IPhO2026Problems.IPhO2026_3_A_2.SatisfiesExternalSourceWorkLaw`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_3_A_2.SatisfiesFaradayCompensationLaw`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_3_A_2.SatisfiesParamagneticConstitutiveLaw`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_3_A_2.SatisfiesThinTorusAmpereLaw`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_3_A_2.TorusGeometry`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_3_A_2.UniformMagneticState`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.

## Grounding gaps

- No unresolved LeanExplore grounding gaps were recorded by this preflight.
... [leading content omitted]
```

## 16. `IPhO2026Problems/problem_IPhO_2026_3_A_3.lean`

- Compile status: passed
- Open sorries: 0
- Direct-check seconds: 17.512
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_3_A_3.tex`
- Reports: `.archon/task_results/physics-grounding-IPhO2026Problems_problem_IPhO_2026_3_A_3.md`

### Lean excerpt
```lean
ment)
    (emSystem : Electromagnetism.EMSystem)
    (work : WorkIncrementReadouts) : Prop where
  vacuumPermeability_pos : 0 < emSystem.μ₀
  constitutiveLaw :
    state.fluxDensity_B_T =
      emSystem.μ₀ * state.fieldStrength_H_A_per_m
        + emSystem.μ₀ * state.magnetization_M_A_per_m
  incrementalConstitutiveLaw :
    change.dFluxDensity_dB_T =
      emSystem.μ₀ * change.dFieldStrength_dH_A_per_m
        + emSystem.μ₀ * change.dMagnetization_dM_A_per_m
  ampereLawForMeanToroidalLoop :
    state.fieldStrength_H_A_per_m
        * (2 * Real.pi * toroid.meanRadius_R_m) =
      (winding.turnCount_N : ℝ) * winding.instantaneousCurrent_I_A
  sourceWork_previousPart_A2 :
    work.sourceWork_dWemf_J =
      toroid.volume_V_m3 * state.fieldStrength_H_A_per_m
        * change.dFluxDensity_dB_T
  vacuumCoreIncrement :
    change.vacuumCore_dFluxDensity_dBvac_T =
      emSystem.μ₀ * change.dFieldStrength_dH_A_per_m
  vacuumCoreWork_from_A2 :
    work.vacuumCoreWork_dWvac_J =
      toroid.volume_V_m3 * state.fieldStrength_H_A_per_m
        * change.vacuumCore_dFluxDensity_dBvac_T
  sourceWork_partition :
    work.sourceWork_dWemf_J =
      work.vacuumCoreWork_dWvac_J + work.materialWork_dW_J

/-- **IPhO 2026 T3-A3.** After subtracting the work needed for the
corresponding vacuum-core field change, the signed work done on the
paramagnetic material is `μ₀ V H dM`.
-/
theorem materialWork_eq_mu0_mul_volume_mul_H_mul_dM
    (toroid : ParamagneticToroid)
    (winding : DenseInsulatedWinding)
    (state : UniformMagneticState)
    (change : UniformMagneticIncrement)
    (emSystem : Electromagnetism.EMSystem)
    (work : WorkIncrementReadouts)
    (hmodel :
      SatisfiesWorkModel toroid winding state change emSystem work) :
    work.materialWork_dW_J =
      emSystem.μ₀ * toroid.volume_V_m3 * state.fieldStrength_H_A_per_m
        * change.dMagnetization_dM_A_per_m := by
  calc
    work.materialWork_dW_J =
        work.sourceWork_dWemf_J - work.vacuumCoreWork_dWvac_J := by
      linarith [hmodel.sourceWork_partition]
    _ =
        toroid.volume_V_m3 * state.fieldStrength_H_A_per_m
            * change.dFluxDensity_dB_T
          - toroid.volume_V_m3 * state.fieldStrength_H_A_per_m
            * change.vacuumCore_dFluxDensity_dBvac_T := by
      rw [hmodel.sourceWork_previousPart_A2, hmodel.vacuumCoreWork_from_A2]
    _ =
        emSystem.μ₀ * toroid.volume_V_m3 * state.fieldStrength_H_A_per_m
          * change.dMagnetization_dM_A_per_m := by
      rw [hmodel.incrementalConstitutiveLaw, hmodel.vacuumCoreIncrement]
      ring

end IPhO2026_3_A_3
end IPhO2026Problems
... [leading content omitted]
```

### Blueprint excerpt
```tex
at energy entering the paramagnetic torus is positive.
\end{definition}
\begin{proof}
  This is the defining declaration; unfolding it gives the stated typed data or relation.
\end{proof}

\begin{definition}[SatisfiesWorkModel]
  \label{decl:physics:IPhO_2026_3_A_3:SatisfiesWorkModel}
  \lean{IPhO2026Problems.IPhO2026_3_A_3.SatisfiesWorkModel}
  \uses{decl:physics:IPhO_2026_3_A_3:ParamagneticToroid, decl:physics:IPhO_2026_3_A_3:DenseInsulatedWinding, decl:physics:IPhO_2026_3_A_3:UniformMagneticState, decl:physics:IPhO_2026_3_A_3:UniformMagneticIncrement, decl:physics:IPhO_2026_3_A_3:WorkIncrementReadouts}
  Governing laws, the A.2 result, and the figure/model readouts needed for the A.3 work subtraction.
\end{definition}
\begin{proof}
  This is the defining declaration; unfolding it gives the stated typed data or relation.
\end{proof}

\begin{theorem}[Physics formalization target]
\label{thm:physics:IPhO_2026_3_A_3:target}
\lean{IPhO2026Problems.IPhO2026_3_A_3.materialWork_eq_mu0_mul_volume_mul_H_mul_dM}
\uses{decl:physics:IPhO_2026_3_A_3:ScaleSeparation, decl:physics:IPhO_2026_3_A_3:ParamagneticToroid, decl:physics:IPhO_2026_3_A_3:DenseInsulatedWinding, decl:physics:IPhO_2026_3_A_3:UniformMagneticState, decl:physics:IPhO_2026_3_A_3:UniformMagneticIncrement, decl:physics:IPhO_2026_3_A_3:WorkIncrementReadouts, decl:physics:IPhO_2026_3_A_3:SatisfiesWorkModel}
The assigned autoformalize agent should translate this physics problem into Lean declarations in the covered file, with theorem and lemma proof bodies written as `by sorry`.
\end{theorem}
\begin{proof}
This is an autoformalization task, not a proof task. Produce statements that can later be proved by the physics prover without weakening the physical model.
\end{proof}
% --- Archon physics formalization source end ---
... [leading content omitted]
```

### Report excerpt: `physics-grounding-IPhO2026Problems_problem_IPhO_2026_3_A_3.md`
```markdown
hysical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_3_A_3.ParamagneticToroid`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_3_A_3.SatisfiesWorkModel`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_3_A_3.ScaleSeparation`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_3_A_3.UniformMagneticIncrement`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_3_A_3.UniformMagneticState`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_3_A_3.WorkIncrementReadouts`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.

## Grounding gaps

- No unresolved LeanExplore grounding gaps were recorded by this preflight.
... [leading content omitted]
```

## 17. `IPhO2026Problems/problem_IPhO_2026_3_B_1.lean`

- Compile status: passed
- Open sorries: 0
- Direct-check seconds: 14.124
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_3_B_1.tex`
- Reports: `.archon/task_results/IPhO2026Problems_problem_IPhO_2026_3_B_1.lean.md`, `.archon/task_results/physics-grounding-IPhO2026Problems_problem_IPhO_2026_3_B_1.md`

### Lean excerpt
```lean
((c • ContinuousLinearMap.id ℝ ℝ).hasFDerivAt).hasDerivAt using 1
      · rfl
      · change c = c * 1
        ring
    exact hlin.deriv
  have halfSquareDeriv (x : ℝ) :
      HasDerivAt (fun y : ℝ => y ^ 2 / 2) x x := by
    apply HasDerivAt.of_isLittleO
    have hzero :
        (fun y : ℝ => y - x) =o[nhds x] (fun _ : ℝ => (1 : ℝ)) := by
      apply (Asymptotics.isLittleO_one_iff ℝ).2
      simpa using (Filter.tendsto_id.sub_const x :
        Filter.Tendsto (fun y : ℝ => y - x) (nhds x) (nhds (x - x)))
    have hsq :
        (fun y : ℝ => (y - x) * (y - x)) =o[nhds x]
          (fun y : ℝ => (1 : ℝ) * (y - x)) :=
      hzero.mul_isBigO
        (Asymptotics.isBigO_refl (fun y : ℝ => y - x) (nhds x))
    have hhalf := hsq.const_mul_left (1 / 2 : ℝ)
    apply hhalf.congr'
    · filter_upwards [] with y
      dsimp
      ring
    · filter_upwards [] with y
      ring
  have integral_id :
      (∫ H in initialFieldIntensitySI..finalFieldIntensitySI, H) =
        (finalFieldIntensitySI ^ 2 - initialFieldIntensitySI ^ 2) / 2 := by
    rw [intervalIntegral.integral_eq_sub_of_hasDerivAt
      (fun x _ => halfSquareDeriv x)
      (continuous_id.intervalIntegrable
        initialFieldIntensitySI finalFieldIntensitySI)]
    ring
  have work_eq :
      energyInJoules
          (laws.isothermalMagneticWorkInto temperatureSI
            initialFieldIntensitySI finalFieldIntensitySI) =
        (torus.vacuumPermeabilitySI * torus.volumeSI * c) *
          ((finalFieldIntensitySI ^ 2 - initialFieldIntensitySI ^ 2) / 2) := by
    rw [laws.magneticWorkLaw]
    simp_rw [derivative_eq]
    rw [show
      (fun H : ℝ => torus.vacuumPermeabilitySI * torus.volumeSI * H * c) =
        fun H : ℝ => (torus.vacuumPermeabilitySI * torus.volumeSI * c) * H by
          funext H
          ring]
    rw [intervalIntegral.integral_const_mul, integral_id]
  have first_law := laws.isothermalFirstLaw temperatureSI
    initialFieldIntensitySI finalFieldIntensitySI
  calc
    energyInJoules
        (laws.isothermalHeatInto temperatureSI
          initialFieldIntensitySI finalFieldIntensitySI) =
        -energyInJoules
          (laws.isothermalMagneticWorkInto temperatureSI
            initialFieldIntensitySI finalFieldIntensitySI) := by
              linarith
    _ = -(torus.vacuumPermeabilitySI * torus.amountMoles *
            torus.materialConstantKSI / (2 * temperatureSI)) *
          (finalFieldIntensitySI ^ 2 - initialFieldIntensitySI ^ 2) := by
            rw [work_eq]
            dsimp [c]
            field_simp [temperature_ne, volume_ne]

end

end IPhO2026_3_B_1
end IPhO2026Problems
... [leading content omitted]
```

### Blueprint excerpt
```tex
nJoules}
  \lean{IPhO2026Problems.IPhO2026_3_B_1.energyInJoules}
  The numerical value, in joules, of a dimensionful energy.
\end{definition}
\begin{proof}
  This is the defining declaration; unfolding it gives the stated typed data or relation.
\end{proof}

\begin{definition}[ParamagneticTorus]
  \label{decl:physics:IPhO_2026_3_B_1:ParamagneticTorus}
  \lean{IPhO2026Problems.IPhO2026_3_B_1.ParamagneticTorus}
  The fixed parameters of the paramagnetic torus.
\end{definition}
\begin{proof}
  This is the defining declaration; unfolding it gives the stated typed data or relation.
\end{proof}

\begin{definition}[ParamagneticTorusLaws]
  \label{decl:physics:IPhO_2026_3_B_1:ParamagneticTorusLaws}
  \lean{IPhO2026Problems.IPhO2026_3_B_1.ParamagneticTorusLaws}
  \uses{decl:physics:IPhO_2026_3_B_1:energyInJoules, decl:physics:IPhO_2026_3_B_1:ParamagneticTorus}
  The governing constitutive and thermodynamic laws used for the torus.
\end{definition}
\begin{proof}
  This is the defining declaration; unfolding it gives the stated typed data or relation.
\end{proof}

\begin{theorem}[Physics formalization target]
\label{thm:physics:IPhO_2026_3_B_1:target}
\lean{IPhO2026Problems.IPhO2026_3_B_1.heatTransferredInto_isothermal}
\uses{decl:physics:IPhO_2026_3_B_1:energyInJoules, decl:physics:IPhO_2026_3_B_1:ParamagneticTorus, decl:physics:IPhO_2026_3_B_1:ParamagneticTorusLaws}
The assigned autoformalize agent should translate this physics problem into Lean declarations in the covered file, with theorem and lemma proof bodies written as `by sorry`.
\end{theorem}
\begin{proof}
This is an autoformalization task, not a proof task. Produce statements that can later be proved by the physics prover without weakening the physical model.
\end{proof}
% --- Archon physics formalization source end ---
... [leading content omitted]
```

### Report excerpt: `IPhO2026Problems_problem_IPhO_2026_3_B_1.lean.md`
```markdown
y temperature.

The endpoint nonnegativity hypotheses are intentionally unused: the work law
uses an oriented interval integral, so the formula is valid for arbitrary
endpoints and in either direction.

## Verification

- `lake env lean IPhO2026Problems/problem_IPhO_2026_3_B_1.lean`: exit code 0.
  It reports only the expected unused-variable warnings for the two endpoint
  nonnegativity hypotheses.
- `lake build`: completed successfully (4 jobs).
- Lean LSP diagnostics: no errors; the same two unused-variable warnings only.
- `lean_verify` reported only standard foundational axioms
  (`propext`, `Classical.choice`, and `Quot.sound`) and no suspicious source
  patterns.
- A direct scan found no `sorry`, `admit`, `axiom`, or `sorryAx` in the file.

## Blueprint status

The theorem environment `thm:physics:IPhO_2026_3_B_1:target` is ready for its
proof `\leanok` marker. Per the prover write restrictions, the blueprint was not
edited; deterministic marker synchronization should apply it.

## Needs blueprint entry

None. No declarations were added.

## Redraft needed

None.

## Why I stopped

The sole assigned placeholder was soundly closed and the unchanged theorem
statement compiles.
... [leading content omitted]
```

### Report excerpt: `physics-grounding-IPhO2026Problems_problem_IPhO_2026_3_B_1.md`
```markdown
(Mathlib)
- `TorusIntegrable` (Mathlib)
- `torusIntegral` (Mathlib)
- `TorusIntegrable` (Mathlib)
- `HahnSeries.orderTop` (Mathlib)
- `Path.target` (Mathlib)
- `semiformal_result` (PhysLean)
- `stereographic_target` (Mathlib)
- `Finset.mulEnergy` (Mathlib)
- `Finset.addEnergy` (Mathlib)
- `DimEnergy.joule` (PhysLean)
- `torusMap` (Mathlib)
- `HahnSeries.orderTop` (Mathlib)
- `torusIntegral` (Mathlib)
- `torusIntegral` (Mathlib)
- `HahnSeries.orderTop` (Mathlib)
- `Electromagnetism.ElectromagneticPotential.ofElectromagneticField_electricField` (PhysLean)
- `CanonicalEnsemble.heatCapacity` (PhysLean)
- `HahnSeries.orderTop` (Mathlib)
- `Subgroup.transferFocal.quotientKerMulEquivQuotientFocalSubroupOf` (Mathlib)

## Local abstractions introduced

- `IPhO2026Problems.IPhO2026_3_B_1.ParamagneticTorus`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_3_B_1.ParamagneticTorusLaws`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.

## Grounding gaps

- No unresolved LeanExplore grounding gaps were recorded by this preflight.
... [leading content omitted]
```

## 18. `IPhO2026Problems/problem_IPhO_2026_3_B_2.lean`

- Compile status: passed
- Open sorries: 1
- Direct-check seconds: 11.601
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_3_B_2.tex`
- Reports: `.archon/task_results/IPhO2026Problems_problem_IPhO_2026_3_B_2.lean.md`, `.archon/task_results/physics-grounding-IPhO2026Problems_problem_IPhO_2026_3_B_2.md`

### Lean excerpt
```lean
oefficient_nonnegative :
        0 ≤
          vacuumPermeabilityInSI torus.vacuumPermeability *
            curieConstantInSI torus.curieConstant :=
      mul_nonneg
        (le_of_lt laws.vacuumPermeability_positive)
        (le_of_lt laws.curieConstant_positive)
    have h_field_term_nonnegative :
        0 ≤
          (vacuumPermeabilityInSI torus.vacuumPermeability *
              curieConstantInSI torus.curieConstant) *
            fieldStrengthAlongProcessInSI process 1 ^ 2 :=
      mul_nonneg h_coefficient_nonnegative
        (sq_nonneg (fieldStrengthAlongProcessInSI process 1))
    linarith [laws.lambda_positive]
  have h_adiabatic_energy_balance :
      ∀ τ ∈ Set.Ioo (0 : ℝ) 1,
        (torus.amountInMoles * lambdaInSI torus.lambda /
              temperatureAlongProcessInKelvin process τ ^ 2) *
            deriv (temperatureAlongProcessInKelvin process) τ =
          vacuumPermeabilityInSI torus.vacuumPermeability *
                volumeInCubicMeters torus.volume *
              fieldStrengthAlongProcessInSI process τ *
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

### Report excerpt: `IPhO2026Problems_problem_IPhO_2026_3_B_2.lean.md`
```markdown
rved-ratio argument was successfully checked
under `import Mathlib`. The minimal module-level remedy is to import the
appropriate derivative algebra and mean-value modules, for example
`Mathlib.Analysis.Calculus.Deriv.Inv` and
`Mathlib.Analysis.Calculus.MeanValue` (using multiplication instead of `pow`
in the differentiated invariant). The prover instructions freeze everything
outside the body after `:= by`, so I did not alter the import list.

## Verification

- `lake env lean IPhO2026Problems/problem_IPhO_2026_3_B_2.lean`: exit code 0.
- Lean LSP diagnostics: no errors; one expected warning that
  `adiabatic_temperature_change` still uses `sorry`.
- No axiom, `admit`, `native_decide`, or `sorryAx` was introduced.

## Blueprint status

The proof environment for
`IPhO2026Problems.IPhO2026_3_B_2.adiabatic_temperature_change` is **not**
ready for a proof `\leanok` marker because the focused final `sorry` remains.
Per prover permissions, the blueprint was not edited.

## Redraft needed

None. The theorem statement is physically faithful and mathematically
provable as written; the blocker is the frozen module import surface, not a
missing physical hypothesis or an incorrect conclusion.
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

## 19. `IPhO2026Problems/problem_IPhO_2026_3_C_2.lean`

- Compile status: passed
- Open sorries: 0
- Direct-check seconds: 14.289
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_3_C_2.tex`
- Reports: `.archon/task_results/IPhO2026Problems_problem_IPhO_2026_3_C_2.lean.md`, `.archon/task_results/physics-grounding-IPhO2026Problems_problem_IPhO_2026_3_C_2.md`

### Lean excerpt
```lean
t] at hEOS4
  change Th * M1 * V = n * K * H1 at hEOS1
  change Tc * M2 * V = n * K * H2 at hEOS2
  change Tc * M3 * V = n * K * H3 at hEOS3
  change Th * M4 * V = n * K * H4 at hEOS4
  simp only [SatisfiesIsothermalHeatLaw] at hColdIsotherm hHotIsotherm
  simp only [SatisfiesReversibleCarnotHeatBalance] at hCarnotBalance
  change Qc = -(μ * n * K / (2 * Tc)) * (H3 ^ 2 - H2 ^ 2) at hColdIsotherm
  change -Qh = -(μ * n * K / (2 * Th)) * (H1 ^ 2 - H4 ^ 2) at hHotIsotherm
  change Qc / Tc = Qh / Th at hCarnotBalance
  have hTc_pos : 0 < Tc := readout.temperature_pos _
  have hTh_pos : 0 < Th := readout.temperature_pos _
  have hV_pos : 0 < V := readout.volume_pos _
  have hn_pos : 0 < n := cycle.amountMoles_pos
  have hK_pos : 0 < K := cycle.curieConstant_pos
  have hμ_pos : 0 < μ := cycle.vacuumPermeability_pos
  have hM1_nonneg : 0 ≤ M1 := readout.magnetization_nonneg _
  have hNK_ne : n * K ≠ 0 :=
    mul_ne_zero (ne_of_gt hn_pos) (ne_of_gt hK_pos)
  field_simp [ne_of_gt hTc_pos] at hColdIsotherm
  field_simp [ne_of_gt hTh_pos] at hHotIsotherm
  field_simp [ne_of_gt hTc_pos, ne_of_gt hTh_pos] at hCarnotBalance
  have hWeightedFieldWithFactor :
      μ * n * K *
          (Th ^ 2 * (H3 ^ 2 - H2 ^ 2) +
            Tc ^ 2 * (H1 ^ 2 - H4 ^ 2)) =
        0 := by
    linear_combination
      Th ^ 2 * hColdIsotherm + Tc ^ 2 * hHotIsotherm -
        (2 * Tc * Th) * hCarnotBalance
  have hField :
      Th ^ 2 * (H3 ^ 2 - H2 ^ 2) +
          Tc ^ 2 * (H1 ^ 2 - H4 ^ 2) =
        0 := by
    have hFactor_ne : μ * n * K ≠ 0 :=
      mul_ne_zero
        (mul_ne_zero (ne_of_gt hμ_pos) (ne_of_gt hn_pos))
        (ne_of_gt hK_pos)
    exact (mul_eq_zero.mp hWeightedFieldWithFactor).resolve_left hFactor_ne
  have hH1 : H1 = Th * M1 * V / (n * K) := by
    field_simp [hNK_ne]
    linarith
  have hH2 : H2 = Tc * M2 * V / (n * K) := by
    field_simp [hNK_ne]
    linarith
  have hH3 : H3 = Tc * M3 * V / (n * K) := by
    field_simp [hNK_ne]
    linarith
  have hH4 : H4 = Th * M4 * V / (n * K) := by
    field_simp [hNK_ne]
    linarith
  rw [hH1, hH2, hH3, hH4] at hField
  field_simp [hNK_ne] at hField
  have hCore : M3 ^ 2 - M2 ^ 2 + (M1 ^ 2 - M4 ^ 2) = 0 := by
    have hCoefficient_ne : Th ^ 2 * Tc ^ 2 * V ^ 2 ≠ 0 := by
      positivity
    apply (mul_eq_zero.mp ?_).resolve_left hCoefficient_ne
    simpa only [mul_zero] using hField
  have hSquared : M1 ^ 2 = M2 ^ 2 - M3 ^ 2 + M4 ^ 2 := by
    linarith
  calc
    M1 = Real.sqrt (M1 ^ 2) := (Real.sqrt_sq hM1_nonneg).symm
    _ = Real.sqrt (M2 ^ 2 - M3 ^ 2 + M4 ^ 2) := by rw [hSquared]

end IPhO2026_3_C_2
end IPhO2026Problems
... [leading content omitted]
```

### Blueprint excerpt
```tex
declaration; unfolding it gives the stated typed data or relation.
\end{proof}

\begin{definition}[EquationOfStateAtVertices]
  \label{decl:physics:IPhO_2026_3_C_2:EquationOfStateAtVertices}
  \lean{IPhO2026Problems.IPhO2026_3_C_2.EquationOfStateAtVertices}
  \uses{decl:physics:IPhO_2026_3_C_2:PhysicalQuantityTypes, decl:physics:IPhO_2026_3_C_2:SIReadout, decl:physics:IPhO_2026_3_C_2:CarnotCycle, decl:physics:IPhO_2026_3_C_2:SatisfiesParamagneticEquationOfState}
  All four vertices obey the same paramagnetic equation of state.
\end{definition}
\begin{proof}
  This is the defining declaration; unfolding it gives the stated typed data or relation.
\end{proof}

\begin{theorem}[Physics formalization target]
\label{thm:physics:IPhO_2026_3_C_2:target}
\lean{IPhO2026Problems.IPhO2026_3_C_2.magnetization_state1_eq_sqrt}
\uses{decl:physics:IPhO_2026_3_C_2:PhysicalQuantityTypes, decl:physics:IPhO_2026_3_C_2:SIReadout, decl:physics:IPhO_2026_3_C_2:TorusState, decl:physics:IPhO_2026_3_C_2:CycleLeg, decl:physics:IPhO_2026_3_C_2:ProcessKind, decl:physics:IPhO_2026_3_C_2:CarnotCycle, decl:physics:IPhO_2026_3_C_2:Figure3bReadout, decl:physics:IPhO_2026_3_C_2:SatisfiesParamagneticEquationOfState, decl:physics:IPhO_2026_3_C_2:SatisfiesIsothermalHeatLaw, decl:physics:IPhO_2026_3_C_2:SatisfiesReversibleCarnotHeatBalance, decl:physics:IPhO_2026_3_C_2:EquationOfStateAtVertices}
The assigned autoformalize agent should translate this physics problem into Lean declarations in the covered file, with theorem and lemma proof bodies written as `by sorry`.
\end{theorem}
\begin{proof}
This is an autoformalization task, not a proof task. Produce statements that can later be proved by the physics prover without weakening the physical model.
\end{proof}
% --- Archon physics formalization source end ---
... [leading content omitted]
```

### Report excerpt: `IPhO2026Problems_problem_IPhO_2026_3_C_2.lean.md`
```markdown
converts the equation of state at each vertex to scalar equalities.
It combines the cold and hot isothermal laws with the reversible Carnot heat
balance to obtain
`T_h² (H₃² - H₂²) + T_c² (H₁² - H₄²) = 0`. Substituting
`H_i = T_i M_i V / (n K)` and cancelling the positive common factor gives
`M₁² = M₂² - M₃² + M₄²`. Magnetization nonnegativity then selects the
nonnegative square root via `Real.sqrt_sq`.

## Verification

- `lake env lean IPhO2026Problems/problem_IPhO_2026_3_C_2.lean`: passed with
  no output.
- `lake build IPhO2026Run`: completed successfully (4 jobs).
- Lean LSP diagnostics: no errors or warnings.
- `lean_verify`: only the standard foundational axioms `propext`,
  `Classical.choice`, and `Quot.sound`; no suspicious source patterns.
- A direct source scan found no `sorry`, `admit`, `axiom`, `sorryAx`, or
  `native_decide`.

## Blueprint status

The proof environment for
`IPhO2026Problems.IPhO2026_3_C_2.magnetization_state1_eq_sqrt` is ready for
its `\leanok` marker. Per prover write restrictions, the blueprint was not
edited; deterministic marker synchronization should apply it.

## Needs blueprint entry

None. No declarations were added.

## Redraft needed

None.
... [leading content omitted]
```

### Report excerpt: `physics-grounding-IPhO2026Problems_problem_IPhO_2026_3_C_2.md`
```markdown
instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_3_C_2.ProcessKind`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_3_C_2.SIReadout`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_3_C_2.SatisfiesIsothermalHeatLaw`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_3_C_2.SatisfiesParamagneticEquationOfState`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_3_C_2.SatisfiesReversibleCarnotHeatBalance`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_3_C_2.TorusState`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.

## Grounding gaps

- No unresolved LeanExplore grounding gaps were recorded by this preflight.
... [leading content omitted]
```

## 20. `IPhO2026Problems/problem_IPhO_2026_3_C_3.lean`

- Compile status: passed
- Open sorries: 0
- Direct-check seconds: 21.802
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_3_C_3.tex`
- Reports: `.archon/task_results/IPhO2026Problems_problem_IPhO_2026_3_C_3.lean.md`, `.archon/task_results/physics-grounding-IPhO2026Problems_problem_IPhO_2026_3_C_3.md`

### Lean excerpt
```lean
ermal-heat relation on the cold leg `2 → 3`, and the nonnegative-magnitude
relation from part C.2.
-/
structure PreviousPartResults (s : Setup) : Prop where
  coldIsothermalHeat :
    s.heatAbsorbedFromHelium.val =
      -(s.vacuumPermeability.val * s.torusAmountMol *
          s.molarCurieConstantK_m3_per_mol /
          (2 * s.coldReservoirTemperature.val)) *
        ((s.magneticFieldStrength CarnotState.three).val ^ 2 -
          (s.magneticFieldStrength CarnotState.two).val ^ 2)
  hotIsothermalHeat :
    s.heatDeliveredToHotReservoir.val =
      s.vacuumPermeability.val * s.torusAmountMol *
          s.molarCurieConstantK_m3_per_mol /
          (2 * s.hotReservoirTemperature.val) *
        ((s.magneticFieldStrength CarnotState.one).val ^ 2 -
          (s.magneticFieldStrength CarnotState.four).val ^ 2)
  magnetizationOne :
    (s.magnetization CarnotState.one).val =
      Real.sqrt
        ((s.magnetization CarnotState.two).val ^ 2 -
          (s.magnetization CarnotState.three).val ^ 2 +
          (s.magnetization CarnotState.four).val ^ 2)

/--
After one cycle, the calculated heat, helium temperature decrease, and final
temperature agree with the reported rounded values `0.129 J`, `0.00992 K`, and
`0.99008 K`, within explicit tolerances appropriate to the rounded input data.
-/
theorem helium_temperature_after_one_cycle
    (s : Setup)
    (hData : HasSuppliedData s)
    (hLaws : GoverningLaws s)
    (hPrevious : PreviousPartResults s) :
    |s.heatAbsorbedFromHelium.val - (129 : ℝ) / 1000| ≤ (1 : ℝ) / 2000 ∧
      |(s.heliumInitialTemperature.val - s.heliumFinalTemperature.val) -
          (992 : ℝ) / 100000| ≤ (1 : ℝ) / 20000 ∧
      |s.heliumFinalTemperature.val - (99008 : ℝ) / 100000| ≤ (1 : ℝ) / 20000 := by
  have hColdTemperature : s.coldReservoirTemperature.val = 1 := by
    rw [hLaws.coldReservoirInitiallyIsHelium]
    exact hData.heliumInitialTemperature
  have hHeat := hPrevious.coldIsothermalHeat
  rw [hData.vacuumPermeability, hData.torusAmountMol,
    hData.molarCurieConstant, hColdTemperature, hData.fieldThree,
    hData.fieldTwo] at hHeat
  norm_num at hHeat
  have hCalorimetry := hLaws.heliumCalorimetry
  rw [hData.heliumDensity, hData.heliumVolume,
    hData.heliumSpecificHeatCapacity, hData.heliumInitialTemperature] at hCalorimetry
  norm_num at hCalorimetry
  have hPiLower := Real.pi_gt_d4
  have hPiUpper := Real.pi_lt_d4
  rw [hData.heliumInitialTemperature]
  refine
    ⟨abs_le.2 ⟨?_, ?_⟩, abs_le.2 ⟨?_, ?_⟩,
      abs_le.2 ⟨?_, ?_⟩⟩ <;>
    nlinarith [hHeat, hCalorimetry, hPiLower, hPiUpper]

end IPhO2026Problems.IPhO2026_3_C_3
... [leading content omitted]
```

### Blueprint excerpt
```tex
}
  \uses{decl:physics:IPhO_2026_3_C_3:CarnotState, decl:physics:IPhO_2026_3_C_3:Setup}
  The two reusable results explicitly licensed by the blueprint: the part B.1 isothermal-heat relation on the cold leg “2 → 3”, and the nonnegative-magnitude relation from part C.2.
\end{definition}
\begin{proof}
  This is the defining declaration; unfolding it gives the stated typed data or relation.
\end{proof}

\begin{theorem}[Physics formalization target]
\label{thm:physics:IPhO_2026_3_C_3:target}
\lean{IPhO2026Problems.IPhO2026_3_C_3.helium_temperature_after_one_cycle}
\uses{decl:physics:IPhO_2026_3_C_3:CarnotState, decl:physics:IPhO_2026_3_C_3:CarnotState:next, decl:physics:IPhO_2026_3_C_3:Temperature, decl:physics:IPhO_2026_3_C_3:Volume, decl:physics:IPhO_2026_3_C_3:MassDensity, decl:physics:IPhO_2026_3_C_3:SpecificHeatCapacity, decl:physics:IPhO_2026_3_C_3:MagneticFieldStrength, decl:physics:IPhO_2026_3_C_3:Magnetization, decl:physics:IPhO_2026_3_C_3:Energy, decl:physics:IPhO_2026_3_C_3:MagneticPermeability, decl:physics:IPhO_2026_3_C_3:Setup, decl:physics:IPhO_2026_3_C_3:HasSuppliedData, decl:physics:IPhO_2026_3_C_3:GoverningLaws, decl:physics:IPhO_2026_3_C_3:PreviousPartResults}
The supplied cycle data imply \(Q_c\approx0.129\) J, a helium temperature drop
of approximately \(0.00992\) K, and final temperature approximately
\(0.99008\) K, each within the stated tolerance.
\end{theorem}
\begin{proof}
Insert \(H_2,H_3,\mu_0,n,K,T_c\) into the licensed cold-isotherm heat formula
to obtain \(Q_c\).  The helium mass is its density times \(1.00\) L, so
calorimetry gives
\(\Delta T=Q_c/(\rho_{\mathrm{He}}V_{\mathrm{He}}c_{\mathrm{He}})\).
Subtract this positive drop from \(1.00\) K and check the three rounding
intervals.
\end{proof}
% --- Archon physics formalization source end ---
... [leading content omitted]
```

### Report excerpt: `IPhO2026Problems_problem_IPhO_2026_3_C_3.lean.md`
```markdown
e.

The proof first rewrites the licensed cold-isotherm heat formula with the
supplied field values, material constants, and the fact that the cold
reservoir initially has temperature `1 K`. It then rewrites helium
calorimetry to the exact relation
`Q_c = 13 * (1 - T_final)`. Mathlib's bounds
`Real.pi_gt_d4` and `Real.pi_lt_d4`, followed by `nlinarith`, establish all
three requested rounding intervals.

## Verification

- `lake env lean IPhO2026Problems/problem_IPhO_2026_3_C_3.lean`: exit code 0
  with no output.
- Lean LSP diagnostics: no errors or warnings.
- `lean_verify` reported only standard foundational axioms
  (`propext`, `Classical.choice`, and `Quot.sound`) and no suspicious source
  patterns.
- No `sorry` remains in the assigned file.

## Blueprint status

The theorem environment `thm:physics:IPhO_2026_3_C_3:target` is ready for its
proof `\leanok` marker. Per the prover write restrictions, the blueprint was
not edited; deterministic marker synchronization should apply it.

## Needs blueprint entry

None. No declarations were added.

## Redraft needed

None.

## Why I stopped

The sole assigned placeholder was soundly closed and the unchanged theorem
statement compiles.
... [leading content omitted]
```

### Report excerpt: `physics-grounding-IPhO2026Problems_problem_IPhO_2026_3_C_3.md`
```markdown
cs/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_3_C_3.MassDensity`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_3_C_3.PreviousPartResults`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_3_C_3.Setup`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_3_C_3.SpecificHeatCapacity`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_3_C_3.Temperature`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_3_C_3.Volume`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.

## Grounding gaps

- No unresolved LeanExplore grounding gaps were recorded by this preflight.
... [leading content omitted]
```

## 21. `IPhO2026Problems/problem_IPhO_2026_3_C_4.lean`

- Compile status: passed
- Open sorries: 0
- Direct-check seconds: 15.084
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_3_C_4.tex`
- Reports: `.archon/task_results/IPhO2026Problems_problem_IPhO_2026_3_C_4.lean.md`, `.archon/task_results/physics-grounding-IPhO2026Problems_problem_IPhO_2026_3_C_4.md`

### Lean excerpt
```lean
HeatRate s).val *
              ((run.hotReservoirTemperature : ℝ) - temperature s) =
            (run.coldHeatRate s).val *
                (run.hotReservoirTemperature : ℝ) -
              temperature s * (run.coldHeatRate s).val := by ring
        _ = temperature s * (run.hotHeatRate s).val -
              temperature s * (run.coldHeatRate s).val := by
            rw [h_ratio_cross]
        _ = temperature s *
              ((run.hotHeatRate s).val - (run.coldHeatRate s).val) := by ring
        _ = temperature s * run.inputPower.val := by rw [h_power_balance]
        _ = run.inputPower.val * temperature s := by ring
    have h_temperature_ne_s : temperature s ≠ 0 :=
      ne_of_gt (h_temperature_range s hs_closed).1
    have h_raw_derivative :=
      ((((h_temperature_derivative.log h_temperature_ne_s).const_mul
          (run.hotReservoirTemperature : ℝ)).sub h_temperature_derivative).const_mul
        (run.bodyHeatCapacity.val / run.inputPower.val))
    have h_derivative_value :
        (run.bodyHeatCapacity.val / run.inputPower.val) *
              ((run.hotReservoirTemperature : ℝ) *
                  (-((run.coldHeatRate s).val / run.bodyHeatCapacity.val) /
                    temperature s) -
                (-((run.coldHeatRate s).val / run.bodyHeatCapacity.val))) =
            -1 := by
      rw [h_cold_formula]
      field_simp [h_heatCapacity_pos.ne', h_power_pos.ne',
        h_temperature_ne_s, h_hot_sub_temperature]
      ring
    simpa only [potential, temperature, Pi.sub_apply, h_derivative_value] using
      h_raw_derivative
  obtain ⟨s, hs, h_slope⟩ :=
    exists_hasDerivAt_eq_slope potential (fun _ => -1) h_elapsed_pos
      h_potential_continuous h_potential_derivative
  have h_potential_difference :
      potential run.elapsedTime.val - potential 0 = -run.elapsedTime.val := by
    rw [sub_zero] at h_slope
    field_simp [h_elapsed_pos.ne'] at h_slope
    linarith
  have h_temperature_zero_real :
      temperature 0 = (run.initialTemperature : ℝ) := by
    simp only [temperature, h_temperature_zero]
  have h_temperature_elapsed_real :
      temperature run.elapsedTime.val = (run.finalTemperature : ℝ) := by
    simp only [temperature, h_temperature_elapsed]
  dsimp only [potential] at h_potential_difference
  rw [h_temperature_zero_real, h_temperature_elapsed_real] at h_potential_difference
  rw [Real.log_div (ne_of_gt (h_final_pos.trans h_final_lt_initial))
    (ne_of_gt h_final_pos)]
  field_simp [h_power_pos.ne', h_hot_pos.ne'] at h_potential_difference ⊢
  nlinarith [h_potential_difference]

end

end IPhO2026Problems.IPhO2026_3_C_4
... [leading content omitted]
```

### Blueprint excerpt
```tex
Carnot cycles.
\end{definition}
\begin{proof}
  This is the defining declaration; unfolding it gives the stated typed data or relation.
\end{proof}

\begin{theorem}[Physics formalization target]
\label{thm:physics:IPhO_2026_3_C_4:target}
\lean{IPhO2026Problems.IPhO2026_3_C_4.IPhO_2026_3_C_4_elapsedTime}
\uses{decl:physics:IPhO_2026_3_C_4:energyDimension, decl:physics:IPhO_2026_3_C_4:volumeDimension, decl:physics:IPhO_2026_3_C_4:magneticIntensityDimension, decl:physics:IPhO_2026_3_C_4:heatCapacityDimension, decl:physics:IPhO_2026_3_C_4:powerDimension, decl:physics:IPhO_2026_3_C_4:molarCurieConstantDimension, decl:physics:IPhO_2026_3_C_4:EnergyReadout, decl:physics:IPhO_2026_3_C_4:VolumeReadout, decl:physics:IPhO_2026_3_C_4:MagneticIntensityReadout, decl:physics:IPhO_2026_3_C_4:HeatCapacityReadout, decl:physics:IPhO_2026_3_C_4:PowerReadout, decl:physics:IPhO_2026_3_C_4:TimeReadout, decl:physics:IPhO_2026_3_C_4:AmountOfSubstanceReadout, decl:physics:IPhO_2026_3_C_4:CyclePoint, decl:physics:IPhO_2026_3_C_4:refrigerationCycleOrder, decl:physics:IPhO_2026_3_C_4:ParamagneticCarnotCycle, decl:physics:IPhO_2026_3_C_4:ObeysParamagneticEquationOfState, decl:physics:IPhO_2026_3_C_4:FollowsFigureThreeB, decl:physics:IPhO_2026_3_C_4:ContinuousCoolingRun, decl:physics:IPhO_2026_3_C_4:HasPhysicalOperatingRange, decl:physics:IPhO_2026_3_C_4:ObeysContinuousCarnotCoolingLaws}
The assigned autoformalize agent should translate this physics problem into Lean declarations in the covered file, with theorem and lemma proof bodies written as `by sorry`.
\end{theorem}
\begin{proof}
This is an autoformalization task, not a proof task. Produce statements that can later be proved by the physics prover without weakening the physical model.
\end{proof}
% --- Archon physics formalization source end ---
... [leading content omitted]
```

### Report excerpt: `IPhO2026Problems_problem_IPhO_2026_3_C_4.lean.md`
```markdown
apsed-time formula.

The import of `Mathlib.Analysis.SpecialFunctions.Log.Basic` was strengthened
to `Mathlib.Analysis.SpecialFunctions.Log.Deriv`; this supplies the derivative
of `Real.log` and the mean-value theorem used by the proof. No declaration
signature was changed.

## Verification

- `lake env lean IPhO2026Problems/problem_IPhO_2026_3_C_4.lean`: exit code 0;
  only unused-hypothesis linter warnings were emitted.
- Lean LSP diagnostics: no errors; only unused-hypothesis linter warnings.
- `lake build`: exit code 0.
- `lean_verify` reported only the standard foundational axioms
  (`propext`, `Classical.choice`, and `Quot.sound`) and no suspicious source
  patterns.
- No `sorry`, `admit`, `axiom`, or `sorryAx` remains in the assigned file.

## Blueprint status

The theorem environment `thm:physics:IPhO_2026_3_C_4:target` is ready for its
proof `\leanok` marker. Per the prover write restrictions, the blueprint was
not edited; deterministic marker synchronization should apply it.

## Needs blueprint entry

None. No declarations were added.

## Redraft needed

None.

## Why I stopped

The sole assigned placeholder was soundly closed and the unchanged theorem
statement compiles.
... [leading content omitted]
```

### Report excerpt: `physics-grounding-IPhO2026Problems_problem_IPhO_2026_3_C_4.md`
```markdown
role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_3_C_4.ObeysContinuousCarnotCoolingLaws`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_3_C_4.ObeysParamagneticEquationOfState`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_3_C_4.ParamagneticCarnotCycle`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_3_C_4.PowerReadout`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_3_C_4.TimeReadout`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_3_C_4.VolumeReadout`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.

## Grounding gaps

- No unresolved LeanExplore grounding gaps were recorded by this preflight.
... [leading content omitted]
```

## 22. `IPhO2026Problems/problem_IPhO_2026_3_C_5.lean`

- Compile status: passed
- Open sorries: 0
- Direct-check seconds: 13.187
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_3_C_5.tex`
- Reports: `.archon/task_results/IPhO2026Problems_problem_IPhO_2026_3_C_5.lean.md`, `.archon/task_results/physics-grounding-IPhO2026Problems_problem_IPhO_2026_3_C_5.md`

### Lean excerpt
```lean
k :
      run.totalInputWorkJoule = run.inputPowerWatt * run.elapsedTimeSecond) :
    coefficientOfPerformance run =
      (run.hotReservoirTemperature.val /
            (run.initialTemperature.val - run.finalTemperature.val) *
          Real.log (run.initialTemperature.val / run.finalTemperature.val) -
        1)⁻¹ := by
  have hHotNN : 0 < run.hotReservoirTemperature.val := by
    rw [← hHotReservoir]
    exact hCyclePhysical.2.2.2.2.1
  have hHotReal : 0 < (run.hotReservoirTemperature.val : ℝ) := by
    exact_mod_cast hHotNN
  have hCoolingReal : (run.finalTemperature.val : ℝ) <
      (run.initialTemperature.val : ℝ) := by
    exact_mod_cast hCooling
  rw [coefficientOfPerformance, hTotalColdHeat, hTotalInputWork,
    hElapsedTimeFromC4]
  have hC : run.cooledBodyHeatCapacityJoulePerKelvin ≠ 0 :=
    ne_of_gt hHeatCapacityPositive
  have hP : run.inputPowerWatt ≠ 0 := ne_of_gt hPowerPositive
  have hHot : (run.hotReservoirTemperature.val : ℝ) ≠ 0 := ne_of_gt hHotReal
  have hDelta : (run.initialTemperature.val : ℝ) -
      (run.finalTemperature.val : ℝ) ≠ 0 :=
    sub_ne_zero.mpr (ne_of_gt hCoolingReal)
  rw [show run.inputPowerWatt *
          (run.cooledBodyHeatCapacityJoulePerKelvin *
              (run.hotReservoirTemperature.val : ℝ) / run.inputPowerWatt *
            (Real.log ((run.initialTemperature.val : ℝ) /
                (run.finalTemperature.val : ℝ)) -
              ((run.initialTemperature.val : ℝ) -
                  (run.finalTemperature.val : ℝ)) /
                (run.hotReservoirTemperature.val : ℝ))) =
        run.cooledBodyHeatCapacityJoulePerKelvin *
          ((run.hotReservoirTemperature.val : ℝ) *
              Real.log ((run.initialTemperature.val : ℝ) /
                (run.finalTemperature.val : ℝ)) -
            ((run.initialTemperature.val : ℝ) -
              (run.finalTemperature.val : ℝ))) by
      field_simp [hP, hHot]]
  rw [mul_div_mul_left _ _ hC]
  rw [show (run.hotReservoirTemperature.val : ℝ) /
            ((run.initialTemperature.val : ℝ) -
              (run.finalTemperature.val : ℝ)) *
          Real.log ((run.initialTemperature.val : ℝ) /
            (run.finalTemperature.val : ℝ)) - 1 =
        ((run.hotReservoirTemperature.val : ℝ) *
              Real.log ((run.initialTemperature.val : ℝ) /
                (run.finalTemperature.val : ℝ)) -
            ((run.initialTemperature.val : ℝ) -
              (run.finalTemperature.val : ℝ))) /
          ((run.initialTemperature.val : ℝ) -
            (run.finalTemperature.val : ℝ)) by
      field_simp [hDelta]]
  rw [inv_div]

end IPhO2026Problems.IPhO2026_3_C_5
... [leading content omitted]
```

### Blueprint excerpt
```tex
d while a constant-heat-capacity body cools from “initialTemperature” to “finalTemperature”.
\end{definition}
\begin{proof}
  This is the defining declaration; unfolding it gives the stated typed data or relation.
\end{proof}

\begin{definition}[coefficientOfPerformance]
  \label{decl:physics:IPhO_2026_3_C_5:coefficientOfPerformance}
  \lean{IPhO2026Problems.IPhO2026_3_C_5.coefficientOfPerformance}
  \uses{decl:physics:IPhO_2026_3_C_5:CoolingRun}
  Overall refrigerator coefficient of performance, “COP = Q\_c / W”.
\end{definition}
\begin{proof}
  This is the defining declaration; unfolding it gives the stated typed data or relation.
\end{proof}

\begin{theorem}[Physics formalization target]
\label{thm:physics:IPhO_2026_3_C_5:target}
\lean{IPhO2026Problems.IPhO2026_3_C_5.overallCoefficientOfPerformance}
\uses{decl:physics:IPhO_2026_3_C_5:CycleState, decl:physics:IPhO_2026_3_C_5:CycleLeg, decl:physics:IPhO_2026_3_C_5:CycleLeg:startState, decl:physics:IPhO_2026_3_C_5:CycleLeg:endState, decl:physics:IPhO_2026_3_C_5:MagneticCarnotCycle, decl:physics:IPhO_2026_3_C_5:FollowsFigureThreeB, decl:physics:IPhO_2026_3_C_5:SatisfiesParamagneticEquationOfState, decl:physics:IPhO_2026_3_C_5:SatisfiesIsothermalHeatRelation, decl:physics:IPhO_2026_3_C_5:HasPhysicalCycleParameters, decl:physics:IPhO_2026_3_C_5:CoolingRun, decl:physics:IPhO_2026_3_C_5:coefficientOfPerformance}
The assigned autoformalize agent should translate this physics problem into Lean declarations in the covered file, with theorem and lemma proof bodies written as `by sorry`.
\end{theorem}
\begin{proof}
This is an autoformalization task, not a proof task. Produce statements that can later be proved by the physics prover without weakening the physical model.
\end{proof}
% --- Archon physics formalization source end ---
... [leading content omitted]
```

### Report excerpt: `IPhO2026Problems_problem_IPhO_2026_3_C_5.lean.md`
```markdown
ances. Positivity of the heat capacity, input power, hot-reservoir
temperature, and temperature drop justifies the required cancellations. The
resulting quotient is algebraically rewritten as
`(T_h / (T₀ - T) * log (T₀ / T) - 1)⁻¹`.

## Verification

- `lake env lean IPhO2026Problems/problem_IPhO_2026_3_C_5.lean`: exit code 0.
  Its only output was unused-hypothesis linter warnings from the frozen theorem
  contract; there were no errors or `declaration uses sorry` warnings.
- `lake build`: completed successfully (4 jobs).
- `lean_verify` reported only the standard foundational axioms `propext`,
  `Classical.choice`, and `Quot.sound`, with no suspicious source patterns.
- A direct scan found no `sorry`, `admit`, `axiom`, or `sorryAx` in the file.

## Blueprint status

The theorem environment `thm:physics:IPhO_2026_3_C_5:target` is ready for its
proof `\leanok` marker. Per the prover write restrictions, the blueprint was not
edited; deterministic marker synchronization should apply it.

## Needs blueprint entry

None. No declarations were added.

## Redraft needed

None.

## Why I stopped

The sole assigned placeholder was soundly closed and the unchanged theorem
statement compiles.
... [leading content omitted]
```

### Report excerpt: `physics-grounding-IPhO2026Problems_problem_IPhO_2026_3_C_5.md`
```markdown
rasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_3_C_5.CycleState`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_3_C_5.FollowsFigureThreeB`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_3_C_5.HasPhysicalCycleParameters`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_3_C_5.MagneticCarnotCycle`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_3_C_5.SatisfiesIsothermalHeatRelation`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_3_C_5.SatisfiesParamagneticEquationOfState`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.

## Grounding gaps

- No unresolved LeanExplore grounding gaps were recorded by this preflight.
... [leading content omitted]
```

## 23. `IPhO2026Problems/problem_IPhO_2026_4_A_1.lean`

- Compile status: passed
- Open sorries: 0
- Direct-check seconds: 22.638
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_4_A_1.tex`
- Reports: `.archon/task_results/IPhO2026Problems_problem_IPhO_2026_4_A_1.lean.md`, `.archon/task_results/physics-grounding-IPhO2026Problems_problem_IPhO_2026_4_A_1.md`

### Lean excerpt
```lean
geometry ∧
      model.amountInMoles setup.confinedAirCA.amount =
        siValue setup.confinedAirCA.mass /
          model.molarMassInKilogramsPerMole setup.airMolarMass ∧
      model.moleculeCount setup.confinedAirCA.molecules =
        model.amountInMoles setup.confinedAirCA.amount *
          model.avogadroConstantPerMole setup.avogadroConstant ∧
      MatchesOfficialSample model setup := by
  have hvolume :
      siValue setup.geometry.confinedAirVolume =
        cylindricalAirVolumeSI setup.geometry := by
    rw [_laws.cylinder_geometry]
    unfold cylindricalAirVolumeSI
    rw [_laws.diameter_radius]
    ring
  have hmass :
      siValue setup.confinedAirCA.mass =
        siValue setup.ambientAirDensity *
          cylindricalAirVolumeSI setup.geometry := by
    rw [_laws.mass_density, hvolume]
  have hamount :
      model.amountInMoles setup.confinedAirCA.amount =
        siValue setup.confinedAirCA.mass /
          model.molarMassInKilogramsPerMole setup.airMolarMass := by
    apply (eq_div_iff (ne_of_gt _admissible.molar_mass_positive)).2
    rw [_laws.molar_mass_relation]
    ring
  have hmolecules :
      model.moleculeCount setup.confinedAirCA.molecules =
        model.amountInMoles setup.confinedAirCA.amount *
          model.avogadroConstantPerMole setup.avogadroConstant := by
    rw [_laws.avogadro_relation]
    ring
  refine ⟨hvolume, hmass, hamount, hmolecules, ?_⟩
  have hmass_numeric :
      siValue setup.confinedAirCA.mass =
        1.12 * (Real.pi * (0.0337 / 2) ^ 2 * 0.095) := by
    rw [hmass, cylindricalAirVolumeSI, _readouts.ambient_density,
      _readouts.inner_diameter, _readouts.confined_air_height]
  have hamount_numeric :
      model.amountInMoles setup.confinedAirCA.amount =
        (1.12 * (Real.pi * (0.0337 / 2) ^ 2 * 0.095)) / 0.02896 := by
    rw [hamount, hmass_numeric, _readouts.air_molar_mass]
  have hmolecules_numeric :
      model.moleculeCount setup.confinedAirCA.molecules =
        ((1.12 * (Real.pi * (0.0337 / 2) ^ 2 * 0.095)) / 0.02896) *
          (6.02 * 10 ^ 23) := by
    rw [hmolecules, hamount_numeric, _readouts.avogadro_constant]
  unfold MatchesOfficialSample
  rw [hmass_numeric, hamount_numeric, hmolecules_numeric]
  unfold WithinEstimate
  norm_num [officialMassEstimateKilograms, officialAmountEstimateMoles,
    officialMoleculeCountEstimate, abs_le]
  constructor
  · constructor <;> nlinarith [Real.pi_gt_d6, Real.pi_lt_d6]
  · constructor
    · constructor <;> nlinarith [Real.pi_gt_d6, Real.pi_lt_d6]
    · constructor <;> nlinarith [Real.pi_gt_d6, Real.pi_lt_d6]

end IPhO2026Problems.IPhO2026_4_A_1
... [leading content omitted]
```

### Blueprint excerpt
```tex
6_4_A_1:Volume, decl:physics:IPhO_2026_4_A_1:Mass, decl:physics:IPhO_2026_4_A_1:MassDensity, decl:physics:IPhO_2026_4_A_1:AbsoluteTemperature, decl:physics:IPhO_2026_4_A_1:Pressure, decl:physics:IPhO_2026_4_A_1:siValue, decl:physics:IPhO_2026_4_A_1:SubstanceCountingModel, decl:physics:IPhO_2026_4_A_1:ConfinedAirState, decl:physics:IPhO_2026_4_A_1:Figure17Geometry, decl:physics:IPhO_2026_4_A_1:IsochoricAirSetup, decl:physics:IPhO_2026_4_A_1:cylindricalAirVolumeSI, decl:physics:IPhO_2026_4_A_1:GoverningLaws, decl:physics:IPhO_2026_4_A_1:SourceReadouts, decl:physics:IPhO_2026_4_A_1:ExperimentalConditions, decl:physics:IPhO_2026_4_A_1:PhysicalAdmissibility, decl:physics:IPhO_2026_4_A_1:ScalarEstimate, decl:physics:IPhO_2026_4_A_1:officialMassEstimateKilograms, decl:physics:IPhO_2026_4_A_1:officialAmountEstimateMoles, decl:physics:IPhO_2026_4_A_1:officialMoleculeCountEstimate, decl:physics:IPhO_2026_4_A_1:WithinEstimate, decl:physics:IPhO_2026_4_A_1:MatchesOfficialSample}
For the sealed air column,
\[
V=\pi(d/2)^2H,\qquad m=\rho_aV,\qquad
n=m/M_a,\qquad N=nN_A.
\]
With \(d=33.7\) mm, \(H=9.5\) cm and the supplied constants, these values lie
within the corrected \(m=0.094\pm0.002\) g interval and the reported
\(n=3.24\) mmol and \(N=(1.95\pm0.05)\times10^{21}\) intervals.
\end{theorem}
\begin{proof}
Convert the diameter and air height to metres and evaluate the cylindrical
volume, obtaining approximately \(85\) mL.  Multiplication by
\(1.12\,\mathrm{kg\,m^{-3}}\) gives approximately \(9.5\times10^{-5}\) kg.
Divide by the molar mass of air to obtain about \(3.24\) mmol, then multiply by
Avogadro's constant to obtain about \(1.95\times10^{21}\) molecules.  Verify
each result against its explicit uncertainty interval.
\end{proof}
% --- Archon physics formalization source end ---
... [leading content omitted]
```

### Report excerpt: `IPhO2026Problems_problem_IPhO_2026_4_A_1.lean.md`
```markdown
amount, and molecule formulas from the
density, molar-mass, and Avogadro relations. It substitutes the source
readouts and proves all three uncertainty intervals using exact rational
normalization together with Mathlib's certified bounds
`Real.pi_gt_d6` and `Real.pi_lt_d6`.

## Verification

- `lake env lean IPhO2026Problems/problem_IPhO_2026_4_A_1.lean`: exit code 0
  with no output.
- `lake build`: completed successfully (4 jobs).
- Lean LSP diagnostics: no errors or warnings.
- `lean_verify` reported only standard foundational axioms
  (`propext`, `Classical.choice`, and `Quot.sound`) and no suspicious source
  patterns.
- A direct scan found no `sorry`, `admit`, `axiom`, `sorryAx`,
  `native_decide`, or `USER:` comments in the assigned file.

## Blueprint status

The theorem environment `thm:physics:IPhO_2026_4_A_1:target` is ready for its
proof `\leanok` marker. Per the prover write restrictions, the blueprint was
not edited; deterministic marker synchronization should apply it.

## Needs blueprint entry

None. No declarations were added.

## Redraft needed

None.

## Why I stopped

The sole assigned placeholder was soundly closed and the unchanged theorem
statement compiles.
... [leading content omitted]
```

### Report excerpt: `physics-grounding-IPhO2026Problems_problem_IPhO_2026_4_A_1.md`
```markdown
eling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_4_A_1.Pressure`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_4_A_1.ScalarEstimate`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_4_A_1.SourceReadouts`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_4_A_1.SubstanceCountingModel`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_4_A_1.Volume`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_4_A_1.WithinEstimate`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.

## Grounding gaps

- No unresolved LeanExplore grounding gaps were recorded by this preflight.
... [leading content omitted]
```

## 24. `IPhO2026Problems/problem_IPhO_2026_4_A_5.lean`

- Compile status: passed
- Open sorries: 0
- Direct-check seconds: 18.314
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_4_A_5.tex`
- Reports: `.archon/task_results/physics-grounding-IPhO2026Problems_problem_IPhO_2026_4_A_5.md`

### Lean excerpt
```lean
Equation (2), `β₀ = (1 / P₀) (ΔP / ΔT)`, interpreted through SI readouts.
-/
noncomputable def MatchesCoefficientDefinition
    (experiment : IsochoricAirExperiment)
    (betaZero : ThermalPressureCoefficient) : Prop :=
  siValue betaZero =
    (1 / pressurePascal experiment.referenceState) *
      (pressureChangePascal experiment /
        temperatureChangeKelvin experiment)

/-- Whether a scalar SI readout lies in a stated uncertainty interval. -/
def WithinUncertainty
    (readout centralValue uncertainty : ℝ) : Prop :=
  |readout - centralValue| ≤ uncertainty

/--
The official experimental result `0.0034 ± 0.0007 K⁻¹`.
-/
noncomputable def MatchesOfficialExperimentalResult
    (betaZero : ThermalPressureCoefficient) : Prop :=
  WithinUncertainty (siValue betaZero) 0.0034 0.0007

/--
Part A.5: determine the constant-volume thermal pressure coefficient of air.

The first conclusion identifies the physical inverse-temperature quantity
using the definition in equation (2).  The second gives the official
experimental uncertainty interval.  The last records that the ideal-gas
reference `1 / 273.15 K` rounds to `0.0037 K⁻¹`.
-/
theorem target
    (experiment : IsochoricAirExperiment)
    (_readouts : SourceReadouts experiment)
    (_conditions : ExperimentalConditions experiment)
    (_laws : GoverningLaws experiment)
    (_admissible : PhysicalAdmissibility experiment)
    (_previousPartA3 : PreviousPartA3Linearity experiment) :
    ∃ betaZero : ThermalPressureCoefficient,
      MatchesCoefficientDefinition experiment betaZero ∧
        MatchesOfficialExperimentalResult betaZero ∧
          WithinUncertainty (1 / 273.15) 0.0037 0.00005 := by
  rcases _previousPartA3 with
    ⟨slopePascalPerKelvin, slope_positive, pressure_reference,
      pressure_initial, pressure_heated⟩
  let betaZero : ThermalPressureCoefficient :=
    CarriesDimension.toDimensionful UnitChoices.SI
      ⟨(1 : ℝ) / 273.15⟩
  have betaZero_si : siValue betaZero = (1 : ℝ) / 273.15 := by
    simp [betaZero, siValue,
      CarriesDimension.toDimensionful_apply_apply]
  refine ⟨betaZero, ?_, ?_, ?_⟩
  · rw [MatchesCoefficientDefinition, betaZero_si,
      pressureChangePascal, temperatureChangeKelvin,
      pressure_reference, pressure_initial, pressure_heated,
      _readouts.referenceTemperature]
    field_simp
    rw [div_self _admissible.nonzeroTemperatureChange]
  · rw [MatchesOfficialExperimentalResult, WithinUncertainty, betaZero_si]
    norm_num [abs_of_nonneg, abs_of_nonpos]
  · rw [WithinUncertainty]
    norm_num [abs_of_nonneg, abs_of_nonpos]

end IPhO2026Problems.IPhO2026_4_A_5
... [leading content omitted]
```

### Blueprint excerpt
```tex
ion; unfolding it gives the stated typed data or relation.
\end{proof}

\begin{theorem}[Physics formalization target]
\label{thm:physics:IPhO_2026_4_A_5:target}
\lean{IPhO2026Problems.IPhO2026_4_A_5.target}
\uses{decl:physics:IPhO_2026_4_A_5:Length, decl:physics:IPhO_2026_4_A_5:Volume, decl:physics:IPhO_2026_4_A_5:MassDensity, decl:physics:IPhO_2026_4_A_5:ThermalPressureCoefficient, decl:physics:IPhO_2026_4_A_5:siValue, decl:physics:IPhO_2026_4_A_5:ApparatusLabel, decl:physics:IPhO_2026_4_A_5:CylinderDimensions, decl:physics:IPhO_2026_4_A_5:Figure17Geometry, decl:physics:IPhO_2026_4_A_5:AirColumnState, decl:physics:IPhO_2026_4_A_5:pressurePascal, decl:physics:IPhO_2026_4_A_5:temperatureKelvin, decl:physics:IPhO_2026_4_A_5:volumeCubicMeter, decl:physics:IPhO_2026_4_A_5:IsochoricAirExperiment, decl:physics:IPhO_2026_4_A_5:SourceReadouts, decl:physics:IPhO_2026_4_A_5:ExperimentalConditions, decl:physics:IPhO_2026_4_A_5:SatisfiesIdealGasLawAt, decl:physics:IPhO_2026_4_A_5:GoverningLaws, decl:physics:IPhO_2026_4_A_5:PreviousPartA3Linearity, decl:physics:IPhO_2026_4_A_5:PhysicalAdmissibility, decl:physics:IPhO_2026_4_A_5:pressureChangePascal, decl:physics:IPhO_2026_4_A_5:temperatureChangeKelvin, decl:physics:IPhO_2026_4_A_5:MatchesCoefficientDefinition, decl:physics:IPhO_2026_4_A_5:WithinUncertainty, decl:physics:IPhO_2026_4_A_5:MatchesOfficialExperimentalResult}
The assigned autoformalize agent should translate this physics problem into Lean declarations in the covered file, with theorem and lemma proof bodies written as `by sorry`.
\end{theorem}
\begin{proof}
This is an autoformalization task, not a proof task. Produce statements that can later be proved by the physics prover without weakening the physical model.
\end{proof}
% --- Archon physics formalization source end ---
... [leading content omitted]
```

### Report excerpt: `physics-grounding-IPhO2026Problems_problem_IPhO_2026_4_A_5.md`
```markdown
ve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_4_A_5.PreviousPartA3Linearity`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_4_A_5.SatisfiesIdealGasLawAt`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_4_A_5.SourceReadouts`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_4_A_5.ThermalPressureCoefficient`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_4_A_5.Volume`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_4_A_5.WithinUncertainty`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.

## Grounding gaps

- No unresolved LeanExplore grounding gaps were recorded by this preflight.
... [leading content omitted]
```

## 25. `IPhO2026Problems/problem_IPhO_2026_4_B_4.lean`

- Compile status: passed
- Open sorries: 0
- Direct-check seconds: 10.382
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_4_B_4.tex`
- Reports: `.archon/task_results/IPhO2026Problems_problem_IPhO_2026_4_B_4.lean.md`, `.archon/task_results/physics-grounding-IPhO2026Problems_problem_IPhO_2026_4_B_4.md`

### Lean excerpt
```lean
suredVaporPressure =
    pressureInPascals data.referenceVaporPressure *
      Real.exp
        (-(data.molarLatentHeatJPerMol / data.molarGasConstantJPerMolKelvin) *
          (1 / temperatureInKelvin measuredTemperature -
            1 / temperatureInKelvin referenceTemperature))

/-- In the Figure 19 atmospheric-pressure experiment, the measured water-vapor
partial pressure is determined by the two gas-column heights and absolute temperatures. -/
theorem vaporPressure_formula
    (geometry : Figure19CylinderGeometry)
    (referenceTemperature measuredTemperature : Temperature)
    (atmosphericPressure referenceDryAirPressure referenceVaporPressure
      measuredDryAirPressure measuredVaporPressure : DimPressure)
    (_previousPart : PreviousPartB3Readout geometry)
    (_model : DryAirWaterVaporExperiment geometry referenceTemperature measuredTemperature
      atmosphericPressure referenceDryAirPressure referenceVaporPressure
      measuredDryAirPressure measuredVaporPressure) :
    pressureInPascals measuredVaporPressure =
      pressureInPascals atmosphericPressure *
        (1 -
          lengthInMeters geometry.referenceGasColumnHeight *
              temperatureInKelvin measuredTemperature /
            (lengthInMeters geometry.measuredGasColumnHeight *
              temperatureInKelvin referenceTemperature)) := by
  have hRefDry :
      pressureInPascals referenceDryAirPressure =
        pressureInPascals atmosphericPressure := by
    linarith [_model.referenceTotalPressure, _model.referenceVaporPressure_zero]
  have hInv := _model.dryAirIdealGasInvariant
  rw [_model.referenceVolume_geometry, _model.measuredVolume_geometry, hRefDry] at hInv
  field_simp [ne_of_gt _model.referenceTemperature_pos,
    ne_of_gt _model.measuredTemperature_pos] at hInv
  have hInv' :
      pressureInPascals atmosphericPressure *
            lengthInMeters geometry.referenceGasColumnHeight *
          temperatureInKelvin measuredTemperature =
        temperatureInKelvin referenceTemperature *
            pressureInPascals measuredDryAirPressure *
          lengthInMeters geometry.measuredGasColumnHeight := by
    apply mul_left_cancel₀ (ne_of_gt _model.crossSection_pos)
    nlinarith [hInv]
  have hVapor :
      pressureInPascals measuredVaporPressure =
        pressureInPascals atmosphericPressure -
          pressureInPascals measuredDryAirPressure := by
    linarith [_model.measuredTotalPressure]
  rw [hVapor]
  field_simp [ne_of_gt _model.measuredHeight_pos,
    ne_of_gt _model.referenceTemperature_pos]
  nlinarith [hInv']

end

end IPhO2026Problems.IPhO2026_4_B_4
... [leading content omitted]
```

### Blueprint excerpt
```tex
stated typed data or relation.
\end{proof}

\begin{definition}[SatisfiesClausiusClapeyron]
  \label{decl:physics:IPhO_2026_4_B_4:SatisfiesClausiusClapeyron}
  \lean{IPhO2026Problems.IPhO2026_4_B_4.SatisfiesClausiusClapeyron}
  \uses{decl:physics:IPhO_2026_4_B_4:pressureInPascals, decl:physics:IPhO_2026_4_B_4:temperatureInKelvin, decl:physics:IPhO_2026_4_B_4:ClausiusClapeyronData}
  The Clausius--Clapeyron law from equation (3), kept separate from the B.4 zero-reference-vapor approximation.
\end{definition}
\begin{proof}
  This is the defining declaration; unfolding it gives the stated typed data or relation.
\end{proof}

\begin{theorem}[Physics formalization target]
\label{thm:physics:IPhO_2026_4_B_4:target}
\lean{IPhO2026Problems.IPhO2026_4_B_4.vaporPressure_formula}
\uses{decl:physics:IPhO_2026_4_B_4:DimLength, decl:physics:IPhO_2026_4_B_4:DimVolume, decl:physics:IPhO_2026_4_B_4:pressureInPascals, decl:physics:IPhO_2026_4_B_4:lengthInMeters, decl:physics:IPhO_2026_4_B_4:areaInSquareMeters, decl:physics:IPhO_2026_4_B_4:volumeInCubicMeters, decl:physics:IPhO_2026_4_B_4:temperatureInKelvin, decl:physics:IPhO_2026_4_B_4:Figure19CylinderGeometry, decl:physics:IPhO_2026_4_B_4:PreviousPartB3Readout, decl:physics:IPhO_2026_4_B_4:DryAirWaterVaporExperiment, decl:physics:IPhO_2026_4_B_4:ClausiusClapeyronData, decl:physics:IPhO_2026_4_B_4:SatisfiesClausiusClapeyron}
The assigned autoformalize agent should translate this physics problem into Lean declarations in the covered file, with theorem and lemma proof bodies written as `by sorry`.
\end{theorem}
\begin{proof}
This is an autoformalization task, not a proof task. Produce statements that can later be proved by the physics prover without weakening the physical model.
\end{proof}
% --- Archon physics formalization source end ---
... [leading content omitted]
```

### Report excerpt: `IPhO2026Problems_problem_IPhO_2026_4_B_4.lean.md`
```markdown
r pressures; clearing the positive
measured-height/reference-temperature denominator yields the stated formula.

The previous-part numerical readout is intentionally unused: the requested B.4
identity follows from the thermodynamic model for arbitrary positive column
heights.

## Verification

- `lake env lean IPhO2026Problems/problem_IPhO_2026_4_B_4.lean`: exit code 0
  with no output.
- `lake build`: completed successfully (4 jobs).
- Lean LSP diagnostics: no errors or warnings.
- `lean_verify` reported only standard foundational axioms
  (`propext`, `Classical.choice`, and `Quot.sound`) and no suspicious source
  patterns.
- A direct scan found no `sorry`, `admit`, `axiom`, `native_decide`, or
  `sorryAx` in the file.

## Blueprint status

The theorem environment `thm:physics:IPhO_2026_4_B_4:target` is ready for its
proof `\leanok` marker. Per the prover write restrictions and project marker
policy, the blueprint was not edited; deterministic marker synchronization
should apply it.

## Needs blueprint entry

None. No declarations were added.

## Redraft needed

None.

## Why I stopped

The sole assigned placeholder was soundly closed and the unchanged theorem
statement compiles.
... [leading content omitted]
```

### Report excerpt: `physics-grounding-IPhO2026Problems_problem_IPhO_2026_4_B_4.md`
```markdown
physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_4_B_4.DimLength`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_4_B_4.DimVolume`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_4_B_4.DryAirWaterVaporExperiment`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_4_B_4.Figure19CylinderGeometry`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_4_B_4.PreviousPartB3Readout`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_4_B_4.SatisfiesClausiusClapeyron`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.

## Grounding gaps

- No unresolved LeanExplore grounding gaps were recorded by this preflight.
... [leading content omitted]
```

## 26. `IPhO2026Problems/problem_IPhO_2026_4_B_6.lean`

- Compile status: passed
- Open sorries: 0
- Direct-check seconds: 18.407
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
The proof applies the mass, molar-energy, and specific-energy governing laws to
one mole. Positivity of the water molar mass permits cancellation and yields
`L_v = Q_v / M₀`. Rewriting with `Q_v = 39 000 J/mol` and
`M₀ = 18/1000 kg/mol` then proves the stated `2190 ± 110 kJ/kg` interval by
exact rational normalization.

## Verification

- `lake env lean IPhO2026Problems/problem_IPhO_2026_4_B_6.lean`: exit code 0
  with no output.
- `lake build`: completed successfully (4 jobs).
- Lean LSP diagnostics: no errors or warnings.
- `lean_verify` reported only standard foundational axioms
  (`propext`, `Classical.choice`, and `Quot.sound`) and no suspicious source
  patterns.
- A direct scan found no `sorry`, `admit`, `axiom`, or `sorryAx` in the file.

## Blueprint status

The theorem environment `thm:physics:IPhO_2026_4_B_6:target` is ready for its
proof `\leanok` marker. Per the prover write restrictions, the blueprint was not
edited; deterministic marker synchronization should apply it.

## Needs blueprint entry

None. No declarations were added.

## Redraft needed

None.

## Why I stopped

The sole assigned placeholder was soundly closed and the unchanged theorem
statement compiles.
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

## 27. `IPhO2026Problems/problem_IPhO_2026_4_C_6.lean`

- Compile status: passed
- Open sorries: 0
- Direct-check seconds: 18.491
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_4_C_6.tex`
- Reports: `.archon/task_results/IPhO2026Problems_problem_IPhO_2026_4_C_6.lean.md`, `.archon/task_results/physics-grounding-IPhO2026Problems_problem_IPhO_2026_4_C_6.md`

### Lean excerpt
```lean
/
structure GoverningLaws (experiment : ThermalExperiment) : Prop where
  heatFlowThroughWall : ∀ time : DimTime,
    siReadout (experiment.wallHeatFlowRateAt time) =
      (siReadout (experiment.outerTemperatureAt time) -
          siReadout (experiment.innerTemperatureAt time)) /
        siReadout experiment.effectiveWallResistance_RTh
  innerWaterEnergyBalance : ∀ time : DimTime,
    siReadout (experiment.wallHeatFlowRateAt time) =
      siReadout experiment.innerWaterSpecificHeat_c0 *
        siReadout experiment.innerWaterMass_m *
        siReadout (experiment.innerTemperatureRateAt time)
  radialFourierConduction : ∀ time : DimTime,
    siReadout (experiment.wallHeatFlowRateAt time) =
      -(siReadout experiment.acrylicConductivity_lambda) *
        siReadout experiment.radialConductionArea_A *
        siReadout (experiment.radialTemperatureGradientAt time)

/-! ## C.6 target and official sample metadata -/

/--
The official sample is a reported scalar estimate, so its central value and
uncertainty are explicitly labeled in kelvin per watt.
-/
structure ThermalResistanceEstimate where
  centralKelvinPerWatt : ℝ
  uncertaintyKelvinPerWatt : ℝ
  uncertainty_nonnegative : 0 ≤ uncertaintyKelvinPerWatt

/-- Official sample report: `R_Th = 1.17 ± 0.03 K/W`. -/
def officialSampleResistance : ThermalResistanceEstimate where
  centralKelvinPerWatt := 1.17
  uncertaintyKelvinPerWatt := 0.03
  uncertainty_nonnegative := by norm_num

/--
From the previous-part C.5 slope relation

`slope = 1 / (c₀ * m * R_Th)`,

determine the effective acrylic-wall thermal resistance.  The previous-part
relation is an allowed graph-model result; the conclusion below is the current
C.6 target and is not a field of `GoverningLaws` or `ThermalExperiment`.
-/
theorem effectiveWallThermalResistance_from_C5Graph
    (experiment : ThermalExperiment)
    (_laws : GoverningLaws experiment)
    (graph : C5GraphReadout)
    (c5SlopeRelation :
      siReadout graph.fittedSlope =
        1 /
          (siReadout experiment.innerWaterSpecificHeat_c0 *
            siReadout experiment.innerWaterMass_m *
            siReadout experiment.effectiveWallResistance_RTh)) :
    siReadout experiment.effectiveWallResistance_RTh =
      1 /
        (siReadout experiment.innerWaterSpecificHeat_c0 *
          siReadout experiment.innerWaterMass_m *
          siReadout graph.fittedSlope) := by
  rw [c5SlopeRelation]
  field_simp [ne_of_gt experiment.specificHeat_positive,
    ne_of_gt experiment.innerWaterMass_positive,
    ne_of_gt experiment.wallResistance_positive]

end IPhO2026Problems.IPhO2026_4_C_6
... [leading content omitted]
```

### Blueprint excerpt
```tex
on, decl:physics:IPhO_2026_4_C_6:thermalResistanceDimension, decl:physics:IPhO_2026_4_C_6:specificHeatCapacityDimension, decl:physics:IPhO_2026_4_C_6:thermalConductivityDimension, decl:physics:IPhO_2026_4_C_6:DimTemperature, decl:physics:IPhO_2026_4_C_6:DimTime, decl:physics:IPhO_2026_4_C_6:DimLength, decl:physics:IPhO_2026_4_C_6:DimMass, decl:physics:IPhO_2026_4_C_6:DimArea, decl:physics:IPhO_2026_4_C_6:DimHeatEnergy, decl:physics:IPhO_2026_4_C_6:DimHeatFlowRate, decl:physics:IPhO_2026_4_C_6:DimThermalResistance, decl:physics:IPhO_2026_4_C_6:DimSpecificHeatCapacity, decl:physics:IPhO_2026_4_C_6:DimThermalConductivity, decl:physics:IPhO_2026_4_C_6:DimTemperatureRate, decl:physics:IPhO_2026_4_C_6:DimTemperatureGradient, decl:physics:IPhO_2026_4_C_6:DimInverseTime, decl:physics:IPhO_2026_4_C_6:siReadout, decl:physics:IPhO_2026_4_C_6:Figure17Geometry, decl:physics:IPhO_2026_4_C_6:ProcedureReadouts, decl:physics:IPhO_2026_4_C_6:TemperatureObservation, decl:physics:IPhO_2026_4_C_6:finiteDifferenceInnerRateSI, decl:physics:IPhO_2026_4_C_6:averageDrivingTemperatureDifferenceSI, decl:physics:IPhO_2026_4_C_6:c5PlotPointSI, decl:physics:IPhO_2026_4_C_6:C5GraphReadout, decl:physics:IPhO_2026_4_C_6:ThermalExperiment, decl:physics:IPhO_2026_4_C_6:GoverningLaws, decl:physics:IPhO_2026_4_C_6:ThermalResistanceEstimate, decl:physics:IPhO_2026_4_C_6:officialSampleResistance}
The assigned autoformalize agent should translate this physics problem into Lean declarations in the covered file, with theorem and lemma proof bodies written as `by sorry`.
\end{theorem}
\begin{proof}
This is an autoformalization task, not a proof task. Produce statements that can later be proved by the physics prover without weakening the physical model.
\end{proof}
% --- Archon physics formalization source end ---
... [leading content omitted]
```

### Report excerpt: `IPhO2026Problems_problem_IPhO_2026_4_C_6.lean.md`
```markdown
C5Graph`.
- No sorries remain in the assigned file.

The proof rewrites the fitted slope using the supplied C.5 relation and then
cancels the nonzero specific heat, water mass, and wall resistance factors.
Their nonzeroness follows from the corresponding strict-positivity fields of
`ThermalExperiment`.

## Verification

- `lake env lean IPhO2026Problems/problem_IPhO_2026_4_C_6.lean`: exit code 0
  with no output.
- `lake build`: completed successfully (4 jobs).
- Lean LSP diagnostics: no errors or warnings.
- `lean_verify` reported only standard foundational axioms
  (`propext`, `Classical.choice`, and `Quot.sound`) and no suspicious source
  patterns.
- A direct scan found no `sorry`, `admit`, `axiom`, or `USER:` comments in the
  assigned file.

## Blueprint status

The theorem environment `thm:physics:IPhO_2026_4_C_6:target` is ready for its
proof `\leanok` marker. Per the prover write restrictions, the blueprint was not
edited; deterministic marker synchronization should apply it.

## Needs blueprint entry

None. No declarations were added.

## Redraft needed

None.

## Why I stopped

The sole assigned placeholder was soundly closed and the unchanged theorem
statement compiles.
... [leading content omitted]
```

### Report excerpt: `physics-grounding-IPhO2026Problems_problem_IPhO_2026_4_C_6.md`
```markdown
the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_4_C_6.Figure17Geometry`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_4_C_6.GoverningLaws`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_4_C_6.ProcedureReadouts`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_4_C_6.TemperatureObservation`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_4_C_6.ThermalExperiment`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_4_C_6.ThermalResistanceEstimate`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.

## Grounding gaps

- No unresolved LeanExplore grounding gaps were recorded by this preflight.
... [leading content omitted]
```

## 28. `IPhO2026Problems/problem_IPhO_2026_4_C_7.lean`

- Compile status: passed
- Open sorries: 1
- Direct-check seconds: 15.093
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_4_C_7.tex`
- Reports: `.archon/task_results/IPhO2026Problems_problem_IPhO_2026_4_C_7.lean.md`, `.archon/task_results/physics-grounding-IPhO2026Problems_problem_IPhO_2026_4_C_7.md`

### Lean excerpt
```lean
of_le hr₁_pos hradius.1
    have hflow := laws.heat_flow_relation observationTimeSeconds
    have horientation := laws.radial_orientation observationTimeSeconds
    have hfourier :=
      laws.radial_fourier_law observationTimeSeconds radiusMeters (by
        simpa [r₁, r₂] using hradius)
    change
      siValue (experiment.heatReceivedByInnerCylinder
          observationTimeSeconds) =
        ΔT / R at hflow
    change
      siValue (experiment.signedOutwardRadialHeatFlow
          observationTimeSeconds) =
        -siValue (experiment.heatReceivedByInnerCylinder
          observationTimeSeconds) at horientation
    change
      siValue (experiment.signedOutwardRadialHeatFlow
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

### Report excerpt: `IPhO2026Problems_problem_IPhO_2026_4_C_7.lean.md`
```markdown
)

- Original problem: `IPhO_2026_4`, part C.7.
- Source report: `reports/ipho_2026/problem_IPhO_2026_4_C_7.source.json`.
- The theorem statement is mathematically sufficient and physically faithful. No hypothesis or
  conclusion change is needed. Allowing the two Mathlib imports listed above is sufficient to close
  the remaining proof without changing the protected declaration.

## Summary

- Sorry count: **1 → 1**.
- Closed sorries: none.
- Still open: `acrylicConductivity_from_radial_fourier`, only at its endpoint integration step.
- No adjacent sorries exist in the assigned file.

## Why I stopped

- **Partial progress:** the file now contains a compiling derivation through the radial-gradient ODE
  and a compiling post-integration cancellation argument. The complete middle integration argument
  was also compiled successfully in a read-only streamed test with the required modules prepended.
- Continuing inside the proof body alone would require reproving Mathlib's logarithm derivative and
  mean-value theorem from primitive definitions despite their already-available library
  implementations; loading them through metaprogramming would violate the anti-elaboration-trick rule.
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
