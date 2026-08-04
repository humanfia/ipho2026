# Deterministic Review Candidate Pack

Iteration: 001
Exact review target count: 28

Review only these targets. Direct Lean compilation was already run in
parallel by the orchestrator; use the recorded result instead of rerunning it.

## 1. `IPhO2026Problems/problem_IPhO_2026_1_A_1.lean`

- Compile status: passed
- Open sorries: 1
- Direct-check seconds: 28.682
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_1_A_1.tex`
- Reports: `.archon/task_results/IPhO2026Problems_problem_IPhO_2026_1_A_1.lean.md`, `.archon/task_results/physics-grounding-IPhO2026Problems_problem_IPhO_2026_1_A_1.md`

### Lean excerpt
```lean
geometry.slotVerticalSizeSI.val
  cubeVolume :
    geometry.cubeVolumeSI.val = geometry.cubeSideSI.val ^ 3
  pressureLeverArm :
    geometry.pressureLeverArmAboutO_SI.val =
      geometry.slotVerticalSizeSI.val / 2
  effectiveWeightLeverArm :
    geometry.effectiveWeightLeverArmAboutO_SI.val =
      geometry.cubeSideSI.val / (2 * Real.sqrt 2)

/--
The governing physical laws at the maximum permissible level difference:
hydrostatic pressure, resultant force, buoyancy-reduced weight, the two moments
about the frictionless hinge `O`, and equality of those moments at incipient
rotation.
-/
structure HydrostaticGateLaws
    (geometry : Figure1aGeometry)
    (state : HydrostaticGateState) : Prop where
  hydrostaticPressureDifference :
    state.pressureDifferenceSI.val =
      state.waterDensitySI.val *
        state.gravitationalAccelerationSI.val *
        state.maximumLevelDifferenceSI.val
  pressureResultant :
    state.pressureResultantSI.val =
      state.pressureDifferenceSI.val * geometry.slotAreaSI.val
  effectiveWeight :
    state.effectiveWeightSI.val =
      (state.cubeDensitySI.val - state.waterDensitySI.val) *
        state.gravitationalAccelerationSI.val *
        geometry.cubeVolumeSI.val
  pressureMomentAboutO :
    state.pressureTorqueAboutO_SI.val =
      state.pressureResultantSI.val *
        geometry.pressureLeverArmAboutO_SI.val
  effectiveWeightMomentAboutO :
    state.effectiveWeightTorqueAboutO_SI.val =
      state.effectiveWeightSI.val *
        geometry.effectiveWeightLeverArmAboutO_SI.val
  limitingMomentBalance :
    state.pressureTorqueAboutO_SI.val =
      state.effectiveWeightTorqueAboutO_SI.val

/--
`length` rounds to `centimetreCount` centimetres when its SI readout lies
within half a centimetre of that decimal value.
-/
def RoundsToNearestCentimeterSI
    (length : LengthSI) (centimetreCount : ℤ) : Prop :=
  |length.val - (centimetreCount : ℝ) / 100| ≤ 1 / 200

/--
At the limiting water-level difference, the cube side is
`Δh / (2 * √2)` and hence rounds to `0.50 m`.

Blueprint label: `thm:physics:IPhO_2026_1_A_1:target`.
-/
theorem sideLength_at_maximumLevelDifference
    (configuration : GateConfiguration)
    (geometry : Figure1aGeometry)
    (state : HydrostaticGateState)
    (hSetup : MatchesProblemSetup configuration geometry state)
    (hFigure : MatchesFigure1a geometry)
    (hLaws : HydrostaticGateLaws geometry state) :
    geometry.cubeSideSI =
        ⟨state.maximumLevelDifferenceSI.val / (2 * Real.sqrt 2)⟩ ∧
      RoundsToNearestCentimeterSI geometry.cubeSideSI 50 := by
  sorry

end IPhO2026Problems.IPhO2026_1_A_1
... [leading content omitted]
```

### Blueprint excerpt
```tex
by a fully submerged solid cube of side a
and density 3*rho\_0, where rho\_0 is the density of water.  The cube is hinged
frictionlessly at O and may rotate about an axis perpendicular to the figure.
The maximum permitted difference in water levels is Delta h = 1.41 m.  Use
Figure 1a on the source page for the exact geometry and lever arms.

Current subquestion:
Calculate the side length a that makes Delta h = 1.41 m the maximum permissible water-level difference.

\paragraph{Current subquestion.}
Calculate the side length a that makes Delta h = 1.41 m the maximum permissible water-level difference.

\paragraph{Recorded answer/context.}
a = Delta h/(2*sqrt(2)) = 0.50 m.

\paragraph{Figure/image path.}
/root/proposal\_for\_physic/science-mango/ipho\_2026\_source/image/T1\_page-1.png

\paragraph{Formalization target.}
create a compiling Lean file with sorry bodies at `IPhO2026Problems/problem\_IPhO\_2026\_1\_A\_1.lean`. The Lean declarations must preserve the physical quantities, dimensions or dimensional roles, figure labels, governing-law hypotheses, and final relation expressed by this problem.
Use Mathlib/Physlib names found through LeanExplore where available. If a physics API is missing, introduce faithful local abstractions rather than scalar placeholder aliases.

\begin{theorem}[Physics formalization target]
\label{thm:physics:IPhO_2026_1_A_1:target}
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
mixed with the
  problem's uniformly fixed-SI `WithDim` readouts.
- No packaged `DimLength`, constant dimensional mass-density, `DimForce`, or
  `DimTorque` alias matching this fixed-SI model was found.
- The chapter has no `\lean{...}` name. The plan/review layer should attach
  `\lean{IPhO2026Problems.IPhO2026_1_A_1.sideLength_at_maximumLevelDifference}`
  so deterministic marker sync can associate the theorem.
- The advertised `archon` DAG command was unavailable on `PATH`
  (`archon: command not found`).
- The root `lean_lib` is named/prefixed `IPhO2026Run`, so Lake does not
  recognize the prescribed `IPhO2026Problems...` module as a build target.
  This configuration is outside this prover's write permissions.

## Verification

- `mcp__archon_lean_lsp.lean_diagnostic_messages`: no errors and exactly one
  expected `declaration uses sorry` warning.
- `lake env lean IPhO2026Problems/problem_IPhO_2026_1_A_1.lean`: exit code 0
  with exactly the expected `sorry` warning.
- `lake build IPhO2026Problems.problem_IPhO_2026_1_A_1` and the explicit
  source-path/module variants fail before invoking Lean because the module is
  not registered under the root `IPhO2026Run` library target.
... [leading content omitted]
```

### Report excerpt: `physics-grounding-IPhO2026Problems_problem_IPhO_2026_1_A_1.md`
```markdown
e Mathlib | **Target of a Path.** For a path $\gamma$ from $x$ to $y$ in a topological space, the value of the path at the endpoint of the unit interval, $\gamma(1)$, is equal to $y$.
- `semiformal_result` | module `Physlib.Meta.Informal.SemiFormal` | package PhysLean | A semiformal result is either a - definition in which the type is given but not the definition. - proof in which the proposition is given but not the proof. Semiformal results cannot be used in further code. They are...
- `stereographic_target` | module `Mathlib.Geometry.Manifold.Instances.Sphere` | package Mathlib | **Target of the Stereographic Projection.** For any unit vector $v$ in an inner product space, the target of the stereographic projection associated with $v$ is the entire codomain (the orthogonal complement of the su...

## Grounded Mathlib/PhysLean names

- `Real.sqrt` (Mathlib)
- `Real.coe_sqrt` (Mathlib)
- `Real.sqrt_lt'` (Mathlib)
- `Path.target` (Mathlib)
- `semiformal_result` (PhysLean)
- `stereographic_target` (Mathlib)

## Local abstractions introduced

- None detected from blueprint Lean references.

## Grounding gaps

- No unresolved LeanExplore grounding gaps were recorded by this preflight.
... [leading content omitted]
```

## 2. `IPhO2026Problems/problem_IPhO_2026_1_B_1.lean`

- Compile status: passed
- Open sorries: 5
- Direct-check seconds: 22.799
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_1_B_1.tex`
- Reports: `.archon/task_results/IPhO2026Problems_problem_IPhO_2026_1_B_1.lean.md`, `.archon/task_results/physics-grounding-IPhO2026Problems_problem_IPhO_2026_1_B_1.md`

### Lean excerpt
```lean
scalarInSI constants.coulombConstant *
          scalarInSI constants.elementaryChargeMagnitude ^ 2)
  polar_conic_law :
    ∀ timeSI,
      scalarInSI (orbit.separationAt timeSI) =
        scalarInSI orbit.conicParameter /
          (1 - orbit.eccentricity * Real.cos (orbit.polarAngleAt timeSI))

/-- For `mu = 4`, the two equal, co-oriented particle angular momenta total `8 ℏ`. -/
theorem total_angular_momentum_for_mu_four
    (constants : PhysicalConstants)
    (initial : Figure1bInitialState constants)
    (orbit : ElectronPositronOrbit)
    (laws : SatisfiesClassicalCoulombConicLaws constants initial orbit) :
    scalarInSI orbit.totalAngularMomentumMagnitude =
      8 * scalarInSI constants.reducedPlanckConstant := by
  sorry

/-- The conserved mechanical energy obtained from the Figure 1b initial state. -/
theorem total_energy_for_mu_four
    (constants : PhysicalConstants)
    (initial : Figure1bInitialState constants)
    (orbit : ElectronPositronOrbit)
    (laws : SatisfiesClassicalCoulombConicLaws constants initial orbit) :
    scalarInSI orbit.totalEnergy =
      -((9 : ℝ) / 2500) *
        (scalarInSI constants.coulombConstant *
            scalarInSI constants.elementaryChargeMagnitude ^ 2 /
          scalarInSI constants.bohrRadius) := by
  sorry

/-- The eccentricity of the bound Coulomb ellipse for `mu = 4`. -/
theorem eccentricity_for_mu_four
    (constants : PhysicalConstants)
    (initial : Figure1bInitialState constants)
    (orbit : ElectronPositronOrbit)
    (laws : SatisfiesClassicalCoulombConicLaws constants initial orbit) :
    orbit.eccentricity = (7 : ℝ) / 25 := by
  sorry

/-- The semi-latus rectum (the numerator in Hint 2) for `mu = 4`. -/
theorem conic_parameter_for_mu_four
    (constants : PhysicalConstants)
    (initial : Figure1bInitialState constants)
    (orbit : ElectronPositronOrbit)
    (laws : SatisfiesClassicalCoulombConicLaws constants initial orbit) :
    scalarInSI orbit.conicParameter =
      128 * scalarInSI constants.bohrRadius := by
  sorry

/--
For the bound `mu = 4` electron-positron pair, the maximum separation is
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
  sorry

end IPhO2026Problems.IPhO2026_1_B_1
... [leading content omitted]
```

### Blueprint excerpt
```tex
Their velocities are
antiparallel and perpendicular to their separation.  Each particle has angular
momentum of magnitude mu*hbar about the center of mass.  The system is isolated,
classical, non-relativistic, and has only electrostatic interaction.  The Bohr
radius is a\_0 = 4*pi*epsilon\_0*hbar\textasciicircum{}2/(m*e\textasciicircum{}2), and k = 1/(4*pi*epsilon\_0).

Current subquestion:
For mu = 4 the pair is bound. Find the maximum electron-positron separation in units of a\_0.

\paragraph{Current subquestion.}
For mu = 4 the pair is bound. Find the maximum electron-positron separation in units of a\_0.

\paragraph{Recorded answer/context.}
r\_max = (1600/9)*a\_0.

\paragraph{Figure/image path.}
/root/proposal\_for\_physic/science-mango/ipho\_2026\_source/image/T1\_page-2.png

\paragraph{Formalization target.}
create a compiling Lean file with sorry bodies at `IPhO2026Problems/problem\_IPhO\_2026\_1\_B\_1.lean`. The Lean declarations must preserve the physical quantities, dimensions or dimensional roles, figure labels, governing-law hypotheses, and final relation expressed by this problem.
Use Mathlib/Physlib names found through LeanExplore where available. If a physics API is missing, introduce faithful local abstractions rather than scalar placeholder aliases.

\begin{theorem}[Physics formalization target]
\label{thm:physics:IPhO_2026_1_B_1:target}
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
ation,
  Coulomb-potential, eccentricity, conic-parameter, and polar-orbit laws
  directly.

## Grounding gaps

- PhysLean's stationary point-particle electromagnetic-potential declarations
  do not provide two-body trajectories, conserved mechanical quantities, or
  Coulomb conics.
- `Electromagnetism.EMSystem.coulombConstant` is an untyped scalar attached to
  the older `EMSystem` API.  It does not preserve the dimensionful role needed
  here, so the model uses a dimensionful constant with the same defining law.
- `ChargeUnit.elementaryCharge` represents a choice of charge unit rather than
  the physical charge carried by either particle, so it is not substituted
  for `PhysicalCharge`.
- The blueprint target currently lacks a `\lean{...}` declaration name.  The
  plan/review layer should attach
  `\lean{IPhO2026Problems.IPhO2026_1_B_1.maximum_separation_for_mu_four}`.

## Verification

- `mcp__archon_lean_lsp.lean_diagnostic_messages`: no errors; exactly five
  expected `declaration uses sorry` warnings.
- `lake env lean IPhO2026Problems/problem_IPhO_2026_1_B_1.lean`: exit code 0,
  with exactly the same five expected warnings.
- `git diff --check` reported no whitespace errors.
... [leading content omitted]
```

### Report excerpt: `physics-grounding-IPhO2026Problems_problem_IPhO_2026_1_B_1.md`
```markdown
ogical space, the value of the path at the endpoint of the unit interval, $\gamma(1)$, is equal to $y$.
- `semiformal_result` | module `Physlib.Meta.Informal.SemiFormal` | package PhysLean | A semiformal result is either a - definition in which the type is given but not the definition. - proof in which the proposition is given but not the proof. Semiformal results cannot be used in further code. They are...
- `stereographic_target` | module `Mathlib.Geometry.Manifold.Instances.Sphere` | package Mathlib | **Target of the Stereographic Projection.** For any unit vector $v$ in an inner product space, the target of the stereographic projection associated with $v$ is the entire codomain (the orthogonal complement of the su...

## Grounded Mathlib/PhysLean names

- `Electromagnetism.ElectromagneticPotential.electricField` (PhysLean)
- `ChargeUnit.elementaryCharge` (PhysLean)
- `Electromagnetism.ElectricField` (PhysLean)
- `Path.target` (Mathlib)
- `semiformal_result` (PhysLean)
- `stereographic_target` (Mathlib)

## Local abstractions introduced

- None detected from blueprint Lean references.

## Grounding gaps

- No unresolved LeanExplore grounding gaps were recorded by this preflight.
... [leading content omitted]
```

## 3. `IPhO2026Problems/problem_IPhO_2026_1_B_2.lean`

- Compile status: passed
- Open sorries: 1
- Direct-check seconds: 22.647
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_1_B_2.tex`
- Reports: `.archon/task_results/IPhO2026Problems_problem_IPhO_2026_1_B_2.lean.md`, `.archon/task_results/physics-grounding-IPhO2026Problems_problem_IPhO_2026_1_B_2.md`

### Lean excerpt
```lean
^ 2 *
              scalarSI constants.elementaryChargeMagnitude_e ^ 4 *
              scalarSI constants.particleMass_m))
  hyperbolicEccentricity : 1 < orbit.eccentricity
  semiLatusRectum_positive : 0 < scalarSI orbit.semiLatusRectum_a
  periapsisAxis_unit : ‖orbit.periapsisAxis‖ = 1
  polarAngleDefinition :
    ∀ seconds : ℝ,
      frame.orientation.oangle
          orbit.periapsisAxis (relativeDisplacementSI motion seconds) =
        ((orbit.polarAngleRad seconds : ℝ) : Real.Angle)
  polarConicEquation :
    ∀ seconds : ℝ,
      separationSI motion seconds =
        scalarSI orbit.semiLatusRectum_a /
          (1 - orbit.eccentricity * Real.cos (orbit.polarAngleRad seconds))

/-- The stated unbound condition: the separation tends to infinity in the future. -/
def IsUnbound (motion : PairMotion) : Prop :=
  Tendsto (separationSI motion) atTop atTop

/-! ## Current B.2 target -/

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
  sorry

end IPhO2026Problems.IPhO2026_1_B_2
... [leading content omitted]
```

### Blueprint excerpt
```tex
is isolated,
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

\begin{theorem}[Physics formalization target]
\label{thm:physics:IPhO_2026_1_B_2:target}
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
anar position/velocity or angular-momentum type for
  this problem; those types are assembled from genuine Physlib dimensions.
- Mathlib has an oriented angle in radians modulo `2π`, but no retrieved
  physical degree-quantity API. The degree value is therefore an explicitly
  labeled scalar readout derived from `Real.Angle.toReal`.
- The read-only DAG command was unavailable in this environment
  (`archon: command not found`), so no ancestor declarations could be queried.
  The source report independently states that there are no previous parts.
- The blueprint theorem environment currently has no `\lean{...}` declaration
  name. The plan/review layer should attach
  `\lean{IPhO2026Problems.IPhO2026_1_B_2.IPhO_2026_1_B_2}` so deterministic
  synchronization can associate the target.

## Verification

- `mcp__archon_lean_lsp__lean_diagnostic_messages`: success, no errors, and
  exactly one expected `declaration uses sorry` warning.
- `lake env lean IPhO2026Problems/problem_IPhO_2026_1_B_2.lean`: exit code
  `0`, with exactly the same expected `sorry` warning.
- The assigned Lean file did not exist at lane start, so there was no
  file-specific `/- USER: ... -/` comment to preserve.
... [leading content omitted]
```

### Report excerpt: `physics-grounding-IPhO2026Problems_problem_IPhO_2026_1_B_2.md`
```markdown
ogical space, the value of the path at the endpoint of the unit interval, $\gamma(1)$, is equal to $y$.
- `semiformal_result` | module `Physlib.Meta.Informal.SemiFormal` | package PhysLean | A semiformal result is either a - definition in which the type is given but not the definition. - proof in which the proposition is given but not the proof. Semiformal results cannot be used in further code. They are...
- `stereographic_target` | module `Mathlib.Geometry.Manifold.Instances.Sphere` | package Mathlib | **Target of the Stereographic Projection.** For any unit vector $v$ in an inner product space, the target of the stereographic projection associated with $v$ is the entire codomain (the orthogonal complement of the su...

## Grounded Mathlib/PhysLean names

- `Electromagnetism.ElectromagneticPotential.electricField` (PhysLean)
- `ChargeUnit.elementaryCharge` (PhysLean)
- `Electromagnetism.ElectricField` (PhysLean)
- `Path.target` (Mathlib)
- `semiformal_result` (PhysLean)
- `stereographic_target` (Mathlib)

## Local abstractions introduced

- None detected from blueprint Lean references.

## Grounding gaps

- No unresolved LeanExplore grounding gaps were recorded by this preflight.
... [leading content omitted]
```

## 4. `IPhO2026Problems/problem_IPhO_2026_1_C_1.lean`

- Compile status: passed
- Open sorries: 1
- Direct-check seconds: 19.187
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_1_C_1.tex`
- Reports: `.archon/task_results/IPhO2026Problems_problem_IPhO_2026_1_C_1.lean.md`, `.archon/task_results/physics-grounding-IPhO2026Problems_problem_IPhO_2026_1_C_1.md`

### Lean excerpt
```lean
sured in radians per second, producing the two fragments at
the Figure 1c angle `θ`.

The final `O₂` mass is `2m`, hence its kinetic energy denominator is
`2 * (2m)`.  The atomic oxygen denominator is `2m`.
-/
def DissociationAt
    (p : PhotodissociationParameters) (θ ω : ℝ) : Prop :=
  0 ≤ ω ∧
    ∃ photonMomentum oxygenMoleculeMomentum oxygenAtomMomentum :
        MomentumQuantity2,
      momentumSI photonMomentum =
          momentumSI oxygenMoleculeMomentum + momentumSI oxygenAtomMomentum ∧
      magnitude2 (momentumSI photonMomentum) =
          reducedPlanckConstantSI p * ω / lightSpeedSI p ∧
      dot2 (momentumSI photonMomentum) (momentumSI oxygenMoleculeMomentum) =
          magnitude2 (momentumSI photonMomentum) *
            magnitude2 (momentumSI oxygenMoleculeMomentum) * Real.cos θ ∧
      reducedPlanckConstantSI p * ω =
          energyDifferenceSI p +
            magnitude2 (momentumSI oxygenMoleculeMomentum) ^ 2 /
              (2 * (2 * oxygenAtomMassSI p)) +
            magnitude2 (momentumSI oxygenAtomMomentum) ^ 2 /
              (2 * oxygenAtomMassSI p)

/--
The proposed angular frequency is feasible and no smaller feasible
nonnegative frequency exists at the same outgoing `O₂` angle.
-/
def IsMinimumDissociationFrequency
    (p : PhotodissociationParameters) (θ : ℝ)
    (ωmin : AngularFrequencyQuantity) : Prop :=
  DissociationAt p θ (scalarSI ωmin) ∧
    ∀ ω : ℝ, DissociationAt p θ ω → scalarSI ωmin ≤ ω

/--
The recorded answer for the minimum photon angular frequency.  For acute and
right angles it is the angle-dependent expression; for obtuse angles it
saturates at the value obtained at `θ = π / 2`.
-/
theorem minimumAngularFrequency_eq
    (p : PhotodissociationParameters) (θ : ℝ)
    (ωmin : AngularFrequencyQuantity)
    (hvalid : ValidPhotodissociationParameters p θ)
    (hminimum : IsMinimumDissociationFrequency p θ ωmin) :
    (θ ≤ Real.pi / 2 →
      scalarSI ωmin =
        (3 * oxygenAtomMassSI p * (lightSpeedSI p) ^ 2 *
            (1 - Real.sqrt
              (1 -
                energyDifferenceSI p /
                    (3 * oxygenAtomMassSI p * (lightSpeedSI p) ^ 2) *
                  (2 * (Real.sin θ) ^ 2 + 1)))) /
          (reducedPlanckConstantSI p * (2 * (Real.sin θ) ^ 2 + 1))) ∧
    (Real.pi / 2 ≤ θ →
      scalarSI ωmin =
        (oxygenAtomMassSI p * (lightSpeedSI p) ^ 2 *
            (1 - Real.sqrt
              (1 -
                energyDifferenceSI p /
                  (oxygenAtomMassSI p * (lightSpeedSI p) ^ 2)))) /
          reducedPlanckConstantSI p) := by
  sorry

end IPhO2026Problems.IPhO2026_1_C_1
... [leading content omitted]
```

### Blueprint excerpt
```tex
\_gamma/c = hbar*omega/c.

Current subquestion:
Determine the minimum angular frequency omega\_min required for dissociation at outgoing O2 angle theta, in terms of hbar, c, theta, Delta U, and m.

\paragraph{Current subquestion.}
Determine the minimum angular frequency omega\_min required for dissociation at outgoing O2 angle theta, in terms of hbar, c, theta, Delta U, and m.

\paragraph{Recorded answer/context.}
For theta <= pi/2, omega\_min = 3*m*c\textasciicircum{}2*[1 - sqrt(1 - (Delta U/(3*m*c\textasciicircum{}2))*(2*sin(theta)\textasciicircum{}2 + 1))]/[hbar*(2*sin(theta)\textasciicircum{}2 + 1)]. For theta >= pi/2 use the same threshold evaluated at theta = pi/2.

\paragraph{Figure/image path.}
/root/proposal\_for\_physic/science-mango/ipho\_2026\_source/image/T1\_page-3.png

\paragraph{Formalization target.}
create a compiling Lean file with sorry bodies at `IPhO2026Problems/problem\_IPhO\_2026\_1\_C\_1.lean`. The Lean declarations must preserve the physical quantities, dimensions or dimensional roles, figure labels, governing-law hypotheses, and final relation expressed by this problem.
Use Mathlib/Physlib names found through LeanExplore where available. If a physics API is missing, introduce faithful local abstractions rather than scalar placeholder aliases.

\begin{theorem}[Physics formalization target]
\label{thm:physics:IPhO_2026_1_C_1:target}
The assigned autoformalize agent should translate this physics problem into Lean declarations in the covered file, with theorem and lemma proof bodies written as `by sorry`.
\end{theorem}
\begin{proof}
This is an autoformalization task, not a proof task. Produce statements that can later be proved by the physics prover without weakening the physical model.
\end{proof}
% --- Archon physics formalization source end ---
... [leading content omitted]
```

### Report excerpt: `IPhO2026Problems_problem_IPhO_2026_1_C_1.lean.md`
```markdown
s and redraft requests

- No packaged PhysLean model for ozone photodissociation or a general
  dimensionful mass/action/angular-frequency type was found.
- The `archon` executable advertised for dependency-graph navigation was not
  available on `PATH` (`archon: command not found`).
- There is a likely factor-of-two inconsistency in the blueprint's recorded
  answer. From the encoded conservation laws, minimizing over the outgoing
  `O₂` momentum for `θ ≤ π/2` gives
  `ℏω = ΔU + A (ℏω)²/(6 m c²)`, where
  `A = 1 + 2 sin² θ`. Its lower solution has radicand
  `1 - 2 A ΔU/(3 m c²)`, whereas the blueprint records
  `1 - A ΔU/(3 m c²)`. The recorded expression therefore approaches
  `ΔU/(2ℏ)` rather than the expected `ΔU/ℏ` as `ΔU/(mc²) → 0`.
  The formal theorem faithfully retains the supplied recorded answer, but a
  physics prover should not be expected to close it from the stated laws
  until the source formula is reviewed.

## Verification

- `mcp__archon_lean_lsp.lean_diagnostic_messages`: no errors and exactly one
  expected `declaration uses sorry` warning.
- `lake env lean IPhO2026Problems/problem_IPhO_2026_1_C_1.lean`: exit code 0
  with exactly the expected `sorry` warning.
... [leading content omitted]
```

### Report excerpt: `physics-grounding-IPhO2026Problems_problem_IPhO_2026_1_C_1.md`
```markdown
e Mathlib | **Target of a Path.** For a path $\gamma$ from $x$ to $y$ in a topological space, the value of the path at the endpoint of the unit interval, $\gamma(1)$, is equal to $y$.
- `semiformal_result` | module `Physlib.Meta.Informal.SemiFormal` | package PhysLean | A semiformal result is either a - definition in which the type is given but not the definition. - proof in which the proposition is given but not the proof. Semiformal results cannot be used in further code. They are...
- `stereographic_target` | module `Mathlib.Geometry.Manifold.Instances.Sphere` | package Mathlib | **Target of the Stereographic Projection.** For any unit vector $v$ in an inner product space, the target of the stereographic projection associated with $v$ is the entire codomain (the orthogonal complement of the su...

## Grounded Mathlib/PhysLean names

- `Real.sqrt` (Mathlib)
- `Real.coe_sqrt` (Mathlib)
- `Real.sqrt_lt'` (Mathlib)
- `Path.target` (Mathlib)
- `semiformal_result` (PhysLean)
- `stereographic_target` (Mathlib)

## Local abstractions introduced

- None detected from blueprint Lean references.

## Grounding gaps

- No unresolved LeanExplore grounding gaps were recorded by this preflight.
... [leading content omitted]
```

## 5. `IPhO2026Problems/problem_IPhO_2026_1_C_2.lean`

- Compile status: passed
- Open sorries: 1
- Direct-check seconds: 29.948
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_1_C_2.tex`
- Reports: `.archon/task_results/IPhO2026Problems_problem_IPhO_2026_1_C_2.lean.md`, `.archon/task_results/physics-grounding-IPhO2026Problems_problem_IPhO_2026_1_C_2.md`

### Lean excerpt
```lean
(2 * scalarInUnits s.oxygenMoleculeMass s.workingUnits) +
        momentumSquaredNorm s.outgoingOxygenAtomMomentum /
          (2 * scalarInUnits s.oxygenAtomMass s.workingUnits)
  omegaMin_is_threshold :
    IsLeast
      {ω : ℝ | DissociationAt s s.theta ω}
      (scalarInUnits s.omegaMin s.workingUnits)

/--
The threshold angular-frequency expression quoted in the blueprint from part C.1.

This definition deliberately transcribes the blueprint's natural-language prerequisite verbatim.
-/
noncomputable def quotedC1ThresholdExpression
    (s : OzonePhotodissociationSetup) (angle : ℝ) : ℝ :=
  let angularFactor := 2 * (Real.sin angle) ^ 2 + 1
  let restEnergyScale :=
    3 * siScalar s.atomMass * (siScalar DimSpeed.speedOfLight) ^ 2
  restEnergyScale *
      (1 - Real.sqrt
        (1 - siScalar s.deltaU / restEnergyScale * angularFactor)) /
    (siScalar reducedPlanckConstant * angularFactor)

/--
The reusable C.1 conclusion supplied by the blueprint. For backward angles, the threshold is the
same expression evaluated at `π/2`.
-/
structure QuotedPreviousPartC1Result
    (s : OzonePhotodissociationSetup) : Prop where
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
  sorry

end IPhO2026Problems.IPhO2026_1_C_2
... [leading content omitted]
```

### Blueprint excerpt
```tex
rded answer/context.}
hbar*omega\_min - Delta U = 2.03e-11 eV.

\paragraph{Figure/image path.}
/root/proposal\_for\_physic/science-mango/ipho\_2026\_source/image/T1\_page-3.png

\paragraph{Reusable previous-part conclusions.}
\begin{itemize}
\item Source C.1. Question: Determine the minimum angular frequency omega\_min required for dissociation at outgoing O2 angle theta, in terms of hbar, c, theta, Delta U, and m. Reusable conclusions: For theta <= pi/2, omega\_min = 3*m*c\textasciicircum{}2*[1 - sqrt(1 - (Delta U/(3*m*c\textasciicircum{}2))*(2*sin(theta)\textasciicircum{}2 + 1))]/[hbar*(2*sin(theta)\textasciicircum{}2 + 1)]. For theta >= pi/2 use the same threshold evaluated at theta = pi/2. Policy: natural\_language\_prerequisite\_only; do\_not\_import\_Lean\_output
\end{itemize}

\paragraph{Formalization target.}
create a compiling Lean file with sorry bodies at `IPhO2026Problems/problem\_IPhO\_2026\_1\_C\_2.lean`. The Lean declarations must preserve the physical quantities, dimensions or dimensional roles, figure labels, governing-law hypotheses, and final relation expressed by this problem.
Use Mathlib/Physlib names found through LeanExplore where available. If a physics API is missing, introduce faithful local abstractions rather than scalar placeholder aliases.

\begin{theorem}[Physics formalization target]
\label{thm:physics:IPhO_2026_1_C_2:target}
The assigned autoformalize agent should translate this physics problem into Lean declarations in the covered file, with theorem and lemma proof bodies written as `by sorry`.
\end{theorem}
\begin{proof}
This is an autoformalization task, not a proof task. Produce statements that can later be proved by the physics prover without weakening the physical model.
\end{proof}
% --- Archon physics formalization source end ---
... [leading content omitted]
```

### Report excerpt: `IPhO2026Problems_problem_IPhO_2026_1_C_2.lean.md`
```markdown
quency role.

## Grounding gaps and redraft requests

- The blueprint's reusable C.1 expression appears to omit a factor `2`
  multiplying `ΔU/(3mc²)` inside the square root. Its small-`ΔU` expansion
  gives `ℏω_min ≈ ΔU/2`, and the C.2 inputs give an excess near `-0.55 eV`,
  incompatible with the recorded `2.03e-11 eV`. Inserting the factor `2`
  gives approximately `2.0296693e-11 eV`. The plan/review layer should check
  and redraft the C.1 prerequisite before the proof stage.
- No Physlib constant for the unified atomic mass unit was found.
- The blueprint theorem environment has no `\lean{...}` declaration name.
  The plan/review or marker-sync layer should associate it with
  `IPhO2026Problems.IPhO2026_1_C_2.problem_IPhO_2026_1_C_2`.
- The `archon` executable advertised for DAG navigation was not available on
  `PATH` in this prover environment; this did not block the source-driven
  formalization.
- Per prover permissions, the blueprint chapter was not edited and marker
  bookkeeping is left to the deterministic sync.

## Verification

- `lake env lean IPhO2026Problems/problem_IPhO_2026_1_C_2.lean`: exit code
  `0`, with exactly one expected `declaration uses sorry` warning.
... [leading content omitted]
```

### Report excerpt: `physics-grounding-IPhO2026Problems_problem_IPhO_2026_1_C_2.md`
```markdown
e Mathlib | **Target of a Path.** For a path $\gamma$ from $x$ to $y$ in a topological space, the value of the path at the endpoint of the unit interval, $\gamma(1)$, is equal to $y$.
- `semiformal_result` | module `Physlib.Meta.Informal.SemiFormal` | package PhysLean | A semiformal result is either a - definition in which the type is given but not the definition. - proof in which the proposition is given but not the proof. Semiformal results cannot be used in further code. They are...
- `stereographic_target` | module `Mathlib.Geometry.Manifold.Instances.Sphere` | package Mathlib | **Target of the Stereographic Projection.** For any unit vector $v$ in an inner product space, the target of the stereographic projection associated with $v$ is the entire codomain (the orthogonal complement of the su...

## Grounded Mathlib/PhysLean names

- `Real.sqrt` (Mathlib)
- `Real.coe_sqrt` (Mathlib)
- `Real.sqrt_lt'` (Mathlib)
- `Path.target` (Mathlib)
- `semiformal_result` (PhysLean)
- `stereographic_target` (Mathlib)

## Local abstractions introduced

- None detected from blueprint Lean references.

## Grounding gaps

- No unresolved LeanExplore grounding gaps were recorded by this preflight.
... [leading content omitted]
```

## 6. `IPhO2026Problems/problem_IPhO_2026_2_A_1.lean`

- Compile status: passed
- Open sorries: 1
- Direct-check seconds: 29.487
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_2_A_1.tex`
- Reports: `.archon/task_results/IPhO2026Problems_problem_IPhO_2026_2_A_1.lean.md`, `.archon/task_results/physics-grounding-IPhO2026Problems_problem_IPhO_2026_2_A_1.md`

### Lean excerpt
```lean
ray : GeometricRay)
      (i : Fin (trace ray).numberOfReflections),
      IsSpecularReflection ((trace ray).eventAt i)

/-- The number `N` of reflections undergone by a ray. -/
def reflectionCount {mirror : HalfCylindricalMirror}
    (dynamics : MirrorDynamics mirror) (ray : GeometricRay) : ℕ :=
  (dynamics.trace ray).numberOfReflections

/-- Figure 2e's threshold meaning: within the open aperture `|x| < R`, a ray
has at most `N` reflections exactly when its distance from the optical axis is
at most the positive threshold `xN`. -/
def IsReflectionThreshold (mirror : HalfCylindricalMirror)
    (family : ParallelIncidentRayFamily) (dynamics : MirrorDynamics mirror)
    (N : ℕ) (xN : ℝ) : Prop :=
  0 < xN ∧
    xN < mirror.radiusReadout ∧
    ∀ x, |x| < mirror.radiusReadout →
      (reflectionCount dynamics (family.rayAt x) ≤ N ↔ |x| ≤ xN)

/-- Figure-derived limiting-ray relations used before solving for `xN`.

The projection relation reads the transverse coordinate from the radius and
the limiting angle.  The final relation is the full-turn closure accumulated
from the equal turning angles of the specular orbit.  Neither field states the
requested closed form for `xN`. -/
structure Figure2cTo2eLimitingGeometry
    (mirror : HalfCylindricalMirror)
    (family : ParallelIncidentRayFamily)
    (dynamics : MirrorDynamics mirror)
    (N : ℕ) (xN limitingAngle : ℝ) : Prop where
  limitingAngle_pos : 0 < limitingAngle
  limitingAngle_lt_rightAngle : limitingAngle < Real.pi / 2
  threshold_projection :
    xN = mirror.radiusReadout * Real.sin limitingAngle
  threshold_ray_count :
    reflectionCount dynamics (family.rayAt xN) = N
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
    (R xN limitingAngle : ℝ) (N : ℕ)
    (hN : 0 < N)
    (hRadius : mirror.radiusReadout = R)
    (hAligned : AlignedWithMirror mirror family)
    (hThreshold : IsReflectionThreshold mirror family dynamics N xN)
    (hFigure :
      Figure2cTo2eLimitingGeometry
        mirror family dynamics N xN limitingAngle) :
    xN =
        R * Real.sin
          (((2 * (N : ℝ) - 1) * Real.pi) / (4 * (N : ℝ) + 2)) ∧
      xN = R * Real.cos (Real.pi / (2 * (N : ℝ) + 1)) := by
  sorry

end IPhO2026Problems.IPhO2026_2_A_1
... [leading content omitted]
```

### Blueprint excerpt
```tex
l rays strike the inside of a half-cylindrical mirror of radius R.  For
an incident ray with transverse coordinate x, let N be its number of
reflections.  The positive threshold x\_N is the largest distance from the
optical axis for which a ray undergoes at most N reflections.  Use Figures
2c--2e for the mirror and limiting-ray geometry.

Current subquestion:
Find the general expression for the threshold x\_N in terms of R and the positive integer N.

\paragraph{Current subquestion.}
Find the general expression for the threshold x\_N in terms of R and the positive integer N.

\paragraph{Recorded answer/context.}
x\_N = R*sin((2*N - 1)*pi/(4*N + 2)) = R*cos(pi/(2*N + 1)).

\paragraph{Figure/image path.}
/root/proposal\_for\_physic/science-mango/ipho\_2026\_source/image/T2\_page-2.png

\paragraph{Formalization target.}
create a compiling Lean file with sorry bodies at `IPhO2026Problems/problem\_IPhO\_2026\_2\_A\_1.lean`. The Lean declarations must preserve the physical quantities, dimensions or dimensional roles, figure labels, governing-law hypotheses, and final relation expressed by this problem.
Use Mathlib/Physlib names found through LeanExplore where available. If a physics API is missing, introduce faithful local abstractions rather than scalar placeholder aliases.

\begin{theorem}[Physics formalization target]
\label{thm:physics:IPhO_2026_2_A_1:target}
The assigned autoformalize agent should translate this physics problem into Lean declarations in the covered file, with theorem and lemma proof bodies written as `by sorry`.
\end{theorem}
\begin{proof}
This is an autoformalization task, not a proof task. Produce statements that can later be proved by the physics prover without weakening the physical model.
\end{proof}
% --- Archon physics formalization source end ---
... [leading content omitted]
```

### Report excerpt: `IPhO2026Problems_problem_IPhO_2026_2_A_1.lean.md`
```markdown
and arc-membership
  condition prevent these from being unconstrained scalar placeholders.
- `IsReflectionThreshold` preserves the “largest distance allowing at most
  `N` reflections” role as a sharp aperture classification.
- `Figure2cTo2eLimitingGeometry` is the smallest local interface for the
  projection and total-turning relations supplied by the official figures.

## Grounding gaps and redraft requests

- Mathlib/PhysLean exposes Euclidean geometry and generic reflection
  constructions, but no ready-made multiple-reflection ray tracer for the
  interior of a half-cylindrical mirror.
- The blueprint theorem environment currently has no `\lean{...}` declaration
  name. The plan/review or marker-sync layer should associate it with
  `IPhO2026Problems.IPhO2026_2_A_1.threshold_formula`.
- Per the prover write-permission rules, the blueprint chapter was not edited;
  `\leanok` bookkeeping is left to the deterministic sync.

## Verification

- `mcp__archon_lean_lsp.lean_diagnostic_messages`: no errors; exactly one
  expected `declaration uses sorry` warning.
- `lake env lean IPhO2026Problems/problem_IPhO_2026_2_A_1.lean`: exit code 0,
  with exactly the expected `sorry` warning.
... [leading content omitted]
```

### Report excerpt: `physics-grounding-IPhO2026Problems_problem_IPhO_2026_2_A_1.md`
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

## 7. `IPhO2026Problems/problem_IPhO_2026_2_B_1.lean`

- Compile status: passed
- Open sorries: 2
- Direct-check seconds: 20.807
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_2_B_1.tex`
- Reports: `.archon/task_results/IPhO2026Problems_problem_IPhO_2026_2_B_1.lean.md`, `.archon/task_results/physics-grounding-IPhO2026Problems_problem_IPhO_2026_2_B_1.md`

### Lean excerpt
```lean
w :
    ∀ path, setup.isPhysicalPath path →
      path.reflectedSegments ≠ [] →
        setup.incidenceAngle path = setup.reflectionAngle path
  fully_absorbing_container :
    ∀ path, setup.isPhysicalPath path →
      setup.hitsContainer path → setup.absorbedByContainer path
  absorbed_paths_reflect_at_most_once :
    ∀ path, setup.isPhysicalPath path →
      setup.absorbedByContainer path →
        path.reflectionPoints.length ≤ 1
  thetaMax_admissible :
    IsAdmissibleIncidenceAngle setup.thetaMax
  thetaMax_is_upper_bound :
    ∀ path, setup.isPhysicalPath path →
      setup.absorbedByContainer path →
      path.reflectionPoints.length = 1 →
        setup.incidenceAngle path ≤ setup.thetaMax
  thetaMax_is_attained :
    ∃ path, setup.isPhysicalPath path ∧
      setup.absorbedByContainer path ∧
      path.reflectionPoints.length = 1 ∧
      setup.incidenceAngle path = setup.thetaMax
  limiting_tangent_path_exists :
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
  sorry

end IPhO2026Problems.IPhO2026_2_B_1
... [leading content omitted]
```

### Blueprint excerpt
```tex
er lies
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

\begin{theorem}[Physics formalization target]
\label{thm:physics:IPhO_2026_2_B_1:target}
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
ng gaps and redraft requests

- No ready-made Physlib half-cylindrical mirror, curved-mirror ray reflection,
  irradiance, or optical power API was found; the faithful local abstractions
  above fill those gaps.
- Read-only dependency navigation was unavailable because the advertised
  `archon` executable was not on `PATH` (`archon: command not found`). The
  source report independently confirms there are no previous-part
  dependencies.
- The blueprint target currently has no `\lean{...}` declaration name. The
  plan/review layer should attach
  `\lean{IPhO2026Problems.IPhO2026_2_B_1.problem_IPhO_2026_2_B_1}` so the
  deterministic sync can associate the statement. The prover did not edit the
  blueprint because prover write permissions explicitly forbid it.
- The assigned Lean file did not exist initially, so there was no
  file-specific `/- USER: ... -/` comment to apply.

## Verification

- `lake env lean IPhO2026Problems/problem_IPhO_2026_2_B_1.lean`: exit code 0,
  with exactly the two expected `declaration uses sorry` warnings.
- `mcp__archon_lean_lsp.lean_diagnostic_messages`: no errors or failed
  dependencies and exactly the same two expected warnings (lines 232 and 247).
... [leading content omitted]
```

### Report excerpt: `physics-grounding-IPhO2026Problems_problem_IPhO_2026_2_B_1.md`
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

## 8. `IPhO2026Problems/problem_IPhO_2026_2_B_2.lean`

- Compile status: passed
- Open sorries: 1
- Direct-check seconds: 21.31
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_2_B_2.tex`
- Reports: `.archon/task_results/IPhO2026Problems_problem_IPhO_2026_2_B_2.lean.md`, `.archon/task_results/physics-grounding-IPhO2026Problems_problem_IPhO_2026_2_B_2.md`

### Lean excerpt
```lean
o.absorbedByContainer ray

/-- A ray absorbed by the container has reflected from the mirror at most once. -/
def IsSingleReflectionRegime {g : Figure2fGeometry} (o : OpticalModel g) : Prop :=
  ∀ ray, o.absorbedByContainer ray → o.reflectionCount ray ≤ 1

/--
`thetaMax` is attained and bounds the mirror incidence angle of every reflected
ray that strikes the container.
-/
def IsLargestRelevantIncidenceAngle {g : Figure2fGeometry} (o : OpticalModel g) : Prop :=
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
  sorry

end IPhO2026_2_B_2
end IPhO2026Problems
... [leading content omitted]
```

### Blueprint excerpt
```tex
strike the container, and let P\_0 be the power the cylinder would
receive without the mirror.  See Figure 2f.

Current subquestion:
Express the power ratio P/P\_0 in terms of theta\_max.

\paragraph{Current subquestion.}
Express the power ratio P/P\_0 in terms of theta\_max.

\paragraph{Recorded answer/context.}
P/P\_0 = 1/(1 - cos(theta\_max)).

\paragraph{Figure/image path.}
/root/proposal\_for\_physic/science-mango/ipho\_2026\_source/image/T2\_page-3.png

\paragraph{Reusable previous-part conclusions.}
\begin{itemize}
\item Source B.1. Question: Given a = alpha*sin(theta\_max) + beta*sin(2*theta\_max), determine alpha and beta in terms of R. Reusable conclusions: alpha = R and beta = -R/2. Policy: natural\_language\_prerequisite\_only; do\_not\_import\_Lean\_output
\end{itemize}

\paragraph{Formalization target.}
create a compiling Lean file with sorry bodies at `IPhO2026Problems/problem\_IPhO\_2026\_2\_B\_2.lean`. The Lean declarations must preserve the physical quantities, dimensions or dimensional roles, figure labels, governing-law hypotheses, and final relation expressed by this problem.
Use Mathlib/Physlib names found through LeanExplore where available. If a physics API is missing, introduce faithful local abstractions rather than scalar placeholder aliases.

\begin{theorem}[Physics formalization target]
\label{thm:physics:IPhO_2026_2_B_2:target}
The assigned autoformalize agent should translate this physics problem into Lean declarations in the covered file, with theorem and lemma proof bodies written as `by sorry`.
\end{theorem}
\begin{proof}
This is an autoformalization task, not a proof task. Produce statements that can later be proved by the physics prover without weakening the physical model.
\end{proof}
% --- Archon physics formalization source end ---
... [leading content omitted]
```

### Report excerpt: `IPhO2026Problems_problem_IPhO_2026_2_B_2.lean.md`
```markdown
ce. Its
  predicates state the physical laws needed by the chapter.

## Grounding gaps and redraft requests

- No ready-made Physlib curved-mirror geometrical-optics, half-cylinder,
  optical-ray reflection, irradiance, or optical-power API matching Figure 2f
  was found. The local abstractions preserve those roles explicitly.
- The read-only dependency navigation command was unavailable in this prover
  environment (`archon: command not found`). This causes no imported
  dependency gap because the chapter explicitly requires B.1 to be restated
  only as a natural-language prerequisite.
- The blueprint target currently has no `\lean{...}` declaration name. The
  plan/review layer should attach
  `\lean{IPhO2026Problems.IPhO2026_2_B_2.problem_IPhO_2026_2_B_2}` so the sync
  can associate the formalized statement.
- The assigned Lean file did not exist initially, so there was no
  file-specific `/- USER: ... -/` comment to apply.

## Verification

- `mcp__archon_lean_lsp.lean_diagnostic_messages`: no errors and exactly one
  expected `declaration uses sorry` warning.
- `lake env lean IPhO2026Problems/problem_IPhO_2026_2_B_2.lean`: exit code 0
  with exactly the same expected warning.
... [leading content omitted]
```

### Report excerpt: `physics-grounding-IPhO2026Problems_problem_IPhO_2026_2_B_2.md`
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

## 9. `IPhO2026Problems/problem_IPhO_2026_2_B_3.lean`

- Compile status: passed
- Open sorries: 1
- Direct-check seconds: 18.97
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_2_B_3.tex`
- Reports: `.archon/task_results/IPhO2026Problems_problem_IPhO_2026_2_B_3.lean.md`, `.archon/task_results/physics-grounding-IPhO2026Problems_problem_IPhO_2026_2_B_3.md`

### Lean excerpt
```lean
The two equations `h_previous_B1_geometry` and `h_previous_B2_powerRatio`
faithfully expose the reusable conclusions of parts B.1 and B.2.  The
fivefold-power equation is the condition imposed by B.3; neither numerical
conclusion of B.3 is assumed.
-/
theorem radius_for_fivefold_power
    {Axis Ray : Type*}
    (setup : Figure2fSetup Axis)
    (Parallel : Axis → Axis → Prop)
    (IsUniformParallelIllumination :
      SunlightBeam Axis → HalfCylindricalMirror Axis → Prop)
    (IsOnMirrorSymmetryPlane :
      FullyAbsorbingCylinder Axis → HalfCylindricalMirror Axis → Prop)
    (IsAbsorbedBy : Ray → FullyAbsorbingCylinder Axis → Prop)
    (reflectionCount : Ray → ℕ)
    (IsLargestRelevantIncidenceAngle :
      ℝ → HalfCylindricalMirror Axis → FullyAbsorbingCylinder Axis → Prop)
    (IsNoMirrorBaselinePower :
      OpticalPower → FullyAbsorbingCylinder Axis → SunlightBeam Axis → Prop)
    (IsPowerAbsorbedWithMirror :
      OpticalPower → Figure2fSetup Axis → Prop)
    (thetaMax : ℝ)
    (P P₀ : OpticalPower)
    (h_axes_parallel :
      Parallel setup.mirror.axis setup.container.axis)
    (h_uniform_parallel_sunlight :
      IsUniformParallelIllumination setup.sunlight setup.mirror)
    (h_container_on_symmetry_plane :
      IsOnMirrorSymmetryPlane setup.container setup.mirror)
    (h_absorbed_rays_reflect_at_most_once :
      ∀ ray, IsAbsorbedBy ray setup.container → reflectionCount ray ≤ 1)
    (h_thetaMax_role :
      IsLargestRelevantIncidenceAngle thetaMax setup.mirror setup.container)
    (h_thetaMax_range : 0 ≤ thetaMax ∧ thetaMax ≤ Real.pi / 2)
    (h_figure2f_center_separation :
      lengthInMeters setup.centerSeparation =
        lengthInMeters setup.mirror.radius / 2)
    (h_mirror_radius :
      lengthInMeters setup.mirror.radius = 1)
    (h_baseline_power_role :
      IsNoMirrorBaselinePower P₀ setup.container setup.sunlight)
    (h_absorbed_power_role :
      IsPowerAbsorbedWithMirror P setup)
    (h_baseline_power_positive : 0 < powerInSI P₀)
    (h_previous_B1_geometry :
      lengthInMeters setup.container.radius =
        lengthInMeters setup.mirror.radius * Real.sin thetaMax -
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
  sorry

end IPhO2026Problems.IPhO2026_2_B_3
... [leading content omitted]
```

### Blueprint excerpt
```tex
ind a such that P = 5*P\_0, and report it in cm.

\paragraph{Recorded answer/context.}
cos(theta\_max) = 4/5 and a = 0.12 m = 12 cm.

\paragraph{Figure/image path.}
/root/proposal\_for\_physic/science-mango/ipho\_2026\_source/image/T2\_page-3.png

\paragraph{Reusable previous-part conclusions.}
\begin{itemize}
\item Source B.1. Question: Given a = alpha*sin(theta\_max) + beta*sin(2*theta\_max), determine alpha and beta in terms of R. Reusable conclusions: alpha = R and beta = -R/2. Policy: natural\_language\_prerequisite\_only; do\_not\_import\_Lean\_output
\item Source B.2. Question: Express the power ratio P/P\_0 in terms of theta\_max. Reusable conclusions: P/P\_0 = 1/(1 - cos(theta\_max)). Policy: natural\_language\_prerequisite\_only; do\_not\_import\_Lean\_output
\end{itemize}

\paragraph{Formalization target.}
create a compiling Lean file with sorry bodies at `IPhO2026Problems/problem\_IPhO\_2026\_2\_B\_3.lean`. The Lean declarations must preserve the physical quantities, dimensions or dimensional roles, figure labels, governing-law hypotheses, and final relation expressed by this problem.
Use Mathlib/Physlib names found through LeanExplore where available. If a physics API is missing, introduce faithful local abstractions rather than scalar placeholder aliases.

\begin{theorem}[Physics formalization target]
\label{thm:physics:IPhO_2026_2_B_3:target}
The assigned autoformalize agent should translate this physics problem into Lean declarations in the covered file, with theorem and lemma proof bodies written as `by sorry`.
\end{theorem}
\begin{proof}
This is an autoformalization task, not a proof task. Produce statements that can later be proved by the physics prover without weakening the physical model.
\end{proof}
% --- Archon physics formalization source end ---
... [leading content omitted]
```

### Report excerpt: `IPhO2026Problems_problem_IPhO_2026_2_B_3.lean.md`
```markdown
ons
  `Parallel`, `IsUniformParallelIllumination`, `IsOnMirrorSymmetryPlane`,
  `IsAbsorbedBy`, `IsLargestRelevantIncidenceAngle`,
  `IsNoMirrorBaselinePower`, and `IsPowerAbsorbedWithMirror` are explicit
  predicate interfaces.  This preserves their physical roles without
  inventing a false scalar encoding or importing unrelated Euclidean
  reflection APIs.

## Grounding gaps

- PhysLean currently exposes dimensional quantities and general Euclidean
  reflection infrastructure but no ready-made half-cylindrical
  geometrical-optics/ray-tracing model matching Figure 2f.
- No packaged optical-power/watt type was found; the correct physical
  dimension is assembled from PhysLean dimensions.
- The blueprint target currently has no `\lean{...}` declaration name.  The
  plan/review layer should attach
  `\lean{IPhO2026Problems.IPhO2026_2_B_3.radius_for_fivefold_power}` so the
  sync can associate and mark the formalized statement.

## Verification

- `mcp__archon_lean_lsp.lean_diagnostic_messages`: no errors; exactly one
  expected `declaration uses sorry` warning.
- `lake env lean IPhO2026Problems/problem_IPhO_2026_2_B_3.lean`: exit code 0,
  with exactly the expected `sorry` warning.
... [leading content omitted]
```

### Report excerpt: `physics-grounding-IPhO2026Problems_problem_IPhO_2026_2_B_3.md`
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

## 10. `IPhO2026Problems/problem_IPhO_2026_2_C_1.lean`

- Compile status: passed
- Open sorries: 1
- Direct-check seconds: 18.001
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_2_C_1.tex`
- Reports: `.archon/task_results/IPhO2026Problems_problem_IPhO_2026_2_C_1.lean.md`, `.archon/task_results/physics-grounding-IPhO2026Problems_problem_IPhO_2026_2_C_1.md`

### Lean excerpt
```lean
WithDim Dimension.L𝓭 ℝ
  radius_pos : 0 < radius

/-- A reflected ray represented in Figure 2g by `y = slope * x + intercept`.
Its direction angle is measured counterclockwise from the positive `x`-axis. -/
structure SlopeInterceptRay where
  slope : ℝ
  intercept : WithDim Dimension.L𝓭 ℝ
  directionAngle : ℝ

/-- A point lies on the upper semicircular mirror centered at the origin. -/
def OnUpperHalfMirror (mirror : HalfCylindricalMirror) (point : PlanePoint) : Prop :=
  point.x.val ^ 2 + point.y.val ^ 2 = mirror.radius.val ^ 2 ∧
    0 ≤ point.y.val

/-- Incidence of a point on the slope-intercept line supporting a ray. -/
def LiesOnRayLine (ray : SlopeInterceptRay) (point : PlanePoint) : Prop :=
  point.y.val = ray.slope * point.x.val + ray.intercept.val

/-- The equal-angle law of specular reflection, written in terms of oriented
direction angles and the tangent line at the impact point. -/
def ObeysSpecularReflection
    (incidentDirection tangentDirection reflectedDirection : ℝ) : Prop :=
  reflectedDirection = 2 * tangentDirection - incidentDirection

/-- For ray `A` in Figure 2g, specular reflection from the centered
half-cylindrical mirror gives the requested slope and length-valued intercept.

The hypotheses separate the physical law from the requested result:
* Figure 2g supplies the impact coordinates, vertical incident direction, and
  tangent direction.
* Specular reflection determines the outgoing direction.
* The slope is the tangent of that direction and the reflected line passes
  through the impact point.
-/
theorem rayA_slope_and_intercept
    (mirror : HalfCylindricalMirror)
    (θ incidentDirection tangentDirection : ℝ)
    (strike : PlanePoint)
    (rayA : SlopeInterceptRay)
    (hθ_pos : 0 < θ)
    (hθ_acute : θ < Real.pi / 2)
    (h_strike_on_mirror : OnUpperHalfMirror mirror strike)
    (h_strike_x :
      strike.x =
        (⟨mirror.radius.val * Real.sin θ⟩ : WithDim Dimension.L𝓭 ℝ))
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
  sorry

end IPhO2026_2_C_1
end IPhO2026Problems
... [leading content omitted]
```

### Blueprint excerpt
```tex
ical mirror of radius R, ray A is incident at angle theta
and its reflected line is y = m\_A*x + b\_A.  A neighboring parallel ray B is
incident at theta + Delta theta, with Delta theta much smaller than theta, and
its reflected line is y = m\_B*x + b\_B.  The envelope/intersection of neighboring
rays forms the caustic.  Use Figure 2g and its coordinate convention.

Current subquestion:
Write the slope m\_A and intercept b\_A of reflected ray A in terms of theta and R.

\paragraph{Current subquestion.}
Write the slope m\_A and intercept b\_A of reflected ray A in terms of theta and R.

\paragraph{Recorded answer/context.}
m\_A = cot(2*theta), and b\_A = R/(2*cos(theta)).

\paragraph{Figure/image path.}
/root/proposal\_for\_physic/science-mango/ipho\_2026\_source/image/T2\_page-4.png

\paragraph{Formalization target.}
create a compiling Lean file with sorry bodies at `IPhO2026Problems/problem\_IPhO\_2026\_2\_C\_1.lean`. The Lean declarations must preserve the physical quantities, dimensions or dimensional roles, figure labels, governing-law hypotheses, and final relation expressed by this problem.
Use Mathlib/Physlib names found through LeanExplore where available. If a physics API is missing, introduce faithful local abstractions rather than scalar placeholder aliases.

\begin{theorem}[Physics formalization target]
\label{thm:physics:IPhO_2026_2_C_1:target}
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
## Grounding gaps and redraft requests

- No PhysLean curved-mirror or geometrical-optics API matching specular
  reflection from a half-cylinder was found. Generic Euclidean reflection
  declarations concern points, subspaces, or unoriented rays and are not a
  faithful drop-in replacement.
- No packaged slope-intercept ray object was found; `AffineMap.lineMap`
  parameterizes an affine line and does not encode the Figure 2g
  dimensionless-slope/length-intercept split.
- The read-only DAG command advertised in the prompt was unavailable in this
  runtime (`archon: command not found`).
- The blueprint theorem has no `\lean{...}` name. The plan/review layer should
  attach
  `\lean{IPhO2026Problems.IPhO2026_2_C_1.rayA_slope_and_intercept}` so the
  synchronization phase can associate the declaration.
- The assigned Lean file did not previously exist, so it contained no
  file-specific `/- USER: ... -/` comment.

## Verification

- `mcp__archon_lean_lsp.lean_diagnostic_messages` reported no errors and
  exactly one expected `declaration uses sorry` warning.
- `lake env lean IPhO2026Problems/problem_IPhO_2026_2_C_1.lean` exited with
  code 0 and exactly the expected `sorry` warning.
... [leading content omitted]
```

### Report excerpt: `physics-grounding-IPhO2026Problems_problem_IPhO_2026_2_C_1.md`
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

## 11. `IPhO2026Problems/problem_IPhO_2026_2_C_2.lean`

- Compile status: passed
- Open sorries: 3
- Direct-check seconds: 19.599
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_2_C_2.tex`
- Reports: `.archon/task_results/IPhO2026Problems_problem_IPhO_2026_2_C_2.lean.md`, `.archon/task_results/physics-grounding-IPhO2026Problems_problem_IPhO_2026_2_C_2.md`

### Lean excerpt
```lean
ine of ray `A`. -/
def PreviousPartC1Result (setup : Figure2gSetup) : Prop :=
  (rayA setup).slope = Real.cot (2 * setup.incidenceAngleRad) ∧
  (rayA setup).interceptLengthReadout =
    setup.radiusLengthReadout / (2 * Real.cos setup.incidenceAngleRad)

/-- The first-order slope formula for neighboring ray `B`, with a remainder
bounded by a constant times `(Δθ)²` as `Δθ → 0`. -/
theorem rayB_slope_firstOrder
    (setup : Figure2gSetup)
    (reflectionLaw : HalfCylindricalReflectionLaw setup)
    (previousPart : PreviousPartC1Result setup) :
    (fun angularIncrementRad : ℝ =>
        (rayB setup angularIncrementRad).slope -
          (Real.cot (2 * setup.incidenceAngleRad) -
            2 * (Real.sin (2 * setup.incidenceAngleRad))⁻¹ ^ 2 *
              angularIncrementRad))
      =O[𝓝 0] (fun angularIncrementRad : ℝ => angularIncrementRad ^ 2) := by
  sorry

/-- The first-order intercept formula for neighboring ray `B`, with a
remainder bounded by a constant times `(Δθ)²` as `Δθ → 0`. -/
theorem rayB_intercept_firstOrder
    (setup : Figure2gSetup)
    (reflectionLaw : HalfCylindricalReflectionLaw setup)
    (previousPart : PreviousPartC1Result setup) :
    (fun angularIncrementRad : ℝ =>
        (rayB setup angularIncrementRad).interceptLengthReadout -
          (setup.radiusLengthReadout /
              (2 * Real.cos setup.incidenceAngleRad) *
            (1 + Real.tan setup.incidenceAngleRad * angularIncrementRad)))
      =O[𝓝 0] (fun angularIncrementRad : ℝ => angularIncrementRad ^ 2) := by
  sorry

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
          (rayB setup angularIncrementRad).interceptLengthReadout -
            (setup.radiusLengthReadout /
                (2 * Real.cos setup.incidenceAngleRad) *
              (1 + Real.tan setup.incidenceAngleRad * angularIncrementRad)))
        =O[𝓝 0] (fun angularIncrementRad : ℝ => angularIncrementRad ^ 2)) := by
  sorry

end IPhO2026_2_C_2
... [leading content omitted]
```

### Blueprint excerpt
```tex
pand m\_B and b\_B to first order in Delta theta.

\paragraph{Current subquestion.}
Expand m\_B and b\_B to first order in Delta theta.

\paragraph{Recorded answer/context.}
m\_B = cot(2*theta) - 2*csc(2*theta)\textasciicircum{}2*Delta theta; b\_B = [R/(2*cos(theta))]*(1 + tan(theta)*Delta theta), up to O(Delta theta\textasciicircum{}2).

\paragraph{Figure/image path.}
/root/proposal\_for\_physic/science-mango/ipho\_2026\_source/image/T2\_page-4.png

\paragraph{Reusable previous-part conclusions.}
\begin{itemize}
\item Source C.1. Question: Write the slope m\_A and intercept b\_A of reflected ray A in terms of theta and R. Reusable conclusions: m\_A = cot(2*theta), and b\_A = R/(2*cos(theta)). Policy: natural\_language\_prerequisite\_only; do\_not\_import\_Lean\_output
\end{itemize}

\paragraph{Formalization target.}
create a compiling Lean file with sorry bodies at `IPhO2026Problems/problem\_IPhO\_2026\_2\_C\_2.lean`. The Lean declarations must preserve the physical quantities, dimensions or dimensional roles, figure labels, governing-law hypotheses, and final relation expressed by this problem.
Use Mathlib/Physlib names found through LeanExplore where available. If a physics API is missing, introduce faithful local abstractions rather than scalar placeholder aliases.

\begin{theorem}[Physics formalization target]
\label{thm:physics:IPhO_2026_2_C_2:target}
The assigned autoformalize agent should translate this physics problem into Lean declarations in the covered file, with theorem and lemma proof bodies written as `by sorry`.
\end{theorem}
\begin{proof}
This is an autoformalization task, not a proof task. Produce statements that can later be proved by the physics prover without weakening the physical model.
\end{proof}
% --- Archon physics formalization source end ---
... [leading content omitted]
```

### Report excerpt: `IPhO2026Problems_problem_IPhO_2026_2_C_2.lean.md`
```markdown
retains the exact curved-mirror geometry as a
  governing-law predicate rather than encoding the requested approximation as
  an assumption.

## Grounding gaps

- The retrieved `RayVector`/`SameRay` API concerns generic vector rays and does
  not model specular reflection from a curved mirror.
- `EuclideanGeometry.reflection_reflection` concerns reflection of points in an
  affine subspace, not optical reflection of ray directions from a circular
  surface.
- No suitable PhysLean curved-mirror, caustic, or geometric-optics API was
  found. The local abstractions above therefore preserve only the physical
  roles and laws needed for this subquestion.
- The read-only DAG navigation command was unavailable in this prover
  environment (`archon: command not found`); the chapter itself specifies that
  C.1 is a natural-language prerequisite only.

## Verification

`lake env lean IPhO2026Problems/problem_IPhO_2026_2_C_2.lean` exits successfully
with exactly three expected `declaration uses 'sorry'` warnings, for the two
component expansion theorems and the combined blueprint target.

No file-specific `/- USER: ... -/` comment was present because the assigned
Lean file did not yet exist.
... [leading content omitted]
```

### Report excerpt: `physics-grounding-IPhO2026Problems_problem_IPhO_2026_2_C_2.md`
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

## 12. `IPhO2026Problems/problem_IPhO_2026_2_C_3.lean`

- Compile status: passed
- Open sorries: 1
- Direct-check seconds: 27.099
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_2_C_3.tex`
- Reports: `.archon/task_results/IPhO2026Problems_problem_IPhO_2026_2_C_3.lean.md`, `.archon/task_results/physics-grounding-IPhO2026Problems_problem_IPhO_2026_2_C_3.md`

### Lean excerpt
```lean
supporting line of a reflected ray. -/
def ReflectedRayLine.Contains
    (ray : ReflectedRayLine) (point : Figure2gPoint) : Prop :=
  point.yLengthReadout =
    ray.slopeRatio * point.xLengthReadout + ray.yInterceptLengthReadout

/-- A point is the intersection of the reflected ray at incidence angle `θ`
(ray A) and the reflected ray at the neighboring angle `θ + Δθ` (ray B). -/
def IsNeighboringReflectedIntersection
    (reflectedRayAtIncidenceAngle : ℝ → ReflectedRayLine)
    (θ Δθ : ℝ) (point : Figure2gPoint) : Prop :=
  (reflectedRayAtIncidenceAngle θ).Contains point ∧
    (reflectedRayAtIncidenceAngle (θ + Δθ)).Contains point

/-- For the half-cylindrical mirror of Figure 2g, the intersections of ray A
with neighboring reflected rays tend to the stated point of the caustic.

The two Big-O hypotheses are precisely the first-order ray-B data from part
C.2, expressed without choosing a particular nonzero `Δθ`. The two equalities
for ray A are the reusable conclusions of part C.1. -/
theorem limitingIntersectionCoordinates
    (mirror : Figure2gMirror)
    (θ : ℝ)
    (reflectedRayAtIncidenceAngle : ℝ → ReflectedRayLine)
    (neighboringIntersection : ℝ → Figure2gPoint)
    (hθ_pos : 0 < θ)
    (hθ_acute : θ < Real.pi / 2)
    (hRayA_slope :
      (reflectedRayAtIncidenceAngle θ).slopeRatio =
        Real.cot (2 * θ))
    (hRayA_intercept :
      (reflectedRayAtIncidenceAngle θ).yInterceptLengthReadout =
        mirror.radiusLengthReadout / (2 * Real.cos θ))
    (hRayB_slope_firstOrder :
      (fun Δθ : ℝ ↦
          (reflectedRayAtIncidenceAngle (θ + Δθ)).slopeRatio -
            (Real.cot (2 * θ) -
              2 * (Real.sin (2 * θ))⁻¹ ^ 2 * Δθ))
        =O[𝓝 0] (fun Δθ : ℝ ↦ Δθ ^ 2))
    (hRayB_intercept_firstOrder :
      (fun Δθ : ℝ ↦
          (reflectedRayAtIncidenceAngle
              (θ + Δθ)).yInterceptLengthReadout -
            ((mirror.radiusLengthReadout / (2 * Real.cos θ)) *
              (1 + Real.tan θ * Δθ)))
        =O[𝓝 0] (fun Δθ : ℝ ↦ Δθ ^ 2))
    (hNeighboringIntersection :
      ∀ᶠ Δθ in 𝓝[≠] (0 : ℝ),
        IsNeighboringReflectedIntersection
          reflectedRayAtIncidenceAngle θ Δθ (neighboringIntersection Δθ)) :
    Tendsto
        (fun Δθ ↦ (neighboringIntersection Δθ).xLengthReadout)
        (𝓝[≠] (0 : ℝ))
        (𝓝 (mirror.radiusLengthReadout * (Real.sin θ) ^ 3)) ∧
      Tendsto
        (fun Δθ ↦ (neighboringIntersection Δθ).yLengthReadout)
        (𝓝[≠] (0 : ℝ))
        (𝓝
          ((mirror.radiusLengthReadout / 2) * Real.cos θ *
            (2 - Real.cos (2 * θ)))) := by
  sorry

end IPhO2026Problems.IPhO2026_2_C_3
... [leading content omitted]
```

### Blueprint excerpt
```tex
agraph{Figure/image path.}
/root/proposal\_for\_physic/science-mango/ipho\_2026\_source/image/T2\_page-4.png

\paragraph{Reusable previous-part conclusions.}
\begin{itemize}
\item Source C.1. Question: Write the slope m\_A and intercept b\_A of reflected ray A in terms of theta and R. Reusable conclusions: m\_A = cot(2*theta), and b\_A = R/(2*cos(theta)). Policy: natural\_language\_prerequisite\_only; do\_not\_import\_Lean\_output
\item Source C.2. Question: Expand m\_B and b\_B to first order in Delta theta. Reusable conclusions: m\_B = cot(2*theta) - 2*csc(2*theta)\textasciicircum{}2*Delta theta; b\_B = [R/(2*cos(theta))]*(1 + tan(theta)*Delta theta), up to O(Delta theta\textasciicircum{}2). Policy: natural\_language\_prerequisite\_only; do\_not\_import\_Lean\_output
\end{itemize}

\paragraph{Formalization target.}
create a compiling Lean file with sorry bodies at `IPhO2026Problems/problem\_IPhO\_2026\_2\_C\_3.lean`. The Lean declarations must preserve the physical quantities, dimensions or dimensional roles, figure labels, governing-law hypotheses, and final relation expressed by this problem.
Use Mathlib/Physlib names found through LeanExplore where available. If a physics API is missing, introduce faithful local abstractions rather than scalar placeholder aliases.

\begin{theorem}[Physics formalization target]
\label{thm:physics:IPhO_2026_2_C_3:target}
The assigned autoformalize agent should translate this physics problem into Lean declarations in the covered file, with theorem and lemma proof bodies written as `by sorry`.
\end{theorem}
\begin{proof}
This is an autoformalization task, not a proof task. Produce statements that can later be proved by the physics prover without weakening the physical model.
\end{proof}
% --- Archon physics formalization source end ---
... [leading content omitted]
```

### Report excerpt: `IPhO2026Problems_problem_IPhO_2026_2_C_3.lean.md`
```markdown
caling classes of nonzero
  vectors, so it has no affine base point or intercept and cannot directly
  express the reflected lines in Figure 2g.
- No PhysLean API for specular reflection from a half-cylindrical mirror or
  for optical caustics was returned. The local interfaces above therefore
  encode only the exact figure and line relations used in this subquestion.
- No separate `Real.csc` API was needed; `csc(2θ)²` is represented as
  `(Real.sin (2 * θ))⁻¹ ^ 2`.
- The read-only DAG command was unavailable in this shell
  (`archon: command not found`). The chapter itself marks C.1 and C.2 as
  natural-language-only prerequisites.
- The blueprint target has no `\lean{...}` name. The plan/review layer should
  attach
  `\lean{IPhO2026Problems.IPhO2026_2_C_3.limitingIntersectionCoordinates}`.

## Verification

- `mcp__archon_lean_lsp.lean_diagnostic_messages`: no errors and exactly one
  expected `declaration uses sorry` warning.
- `lake env lean IPhO2026Problems/problem_IPhO_2026_2_C_3.lean`: exit code 0
  with exactly the expected `sorry` warning.
- No file-specific `/- USER: ... -/` comment was present because the assigned
  Lean file did not exist before this autoformalization.
... [leading content omitted]
```

### Report excerpt: `physics-grounding-IPhO2026Problems_problem_IPhO_2026_2_C_3.md`
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

## 13. `IPhO2026Problems/problem_IPhO_2026_2_C_4.lean`

- Compile status: passed
- Open sorries: 1
- Direct-check seconds: 17.864
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_2_C_4.tex`
- Reports: `.archon/task_results/IPhO2026Problems_problem_IPhO_2026_2_C_4.lean.md`, `.archon/task_results/physics-grounding-IPhO2026Problems_problem_IPhO_2026_2_C_4.md`

### Lean excerpt
```lean
usticY : ℝ → LengthReading

/--
The `x`-coordinate of the intersection of reflected ray `A`, incident at
angle `θ`, and neighboring reflected ray `B`, incident at `θ + Δθ`.
-/
def neighboringIntersectionX
    (system : Figure2gOpticalSystem) (θ Δθ : ℝ) : ℝ :=
  let rayA := system.reflectedLine θ
  let rayB := system.reflectedLine (θ + Δθ)
  (rayB.intercept.val - rayA.intercept.val) / (rayA.slope - rayB.slope)

/--
The `y`-coordinate of the same neighboring-ray intersection, obtained from
the reflected-line equation `y = m_A x + b_A`.
-/
def neighboringIntersectionY
    (system : Figure2gOpticalSystem) (θ Δθ : ℝ) : ℝ :=
  let rayA := system.reflectedLine θ
  rayA.slope * neighboringIntersectionX system θ Δθ + rayA.intercept.val

/--
The governing caustic-envelope law: the caustic point at angle `θ` is the
limit of intersections of reflected rays whose incidence-angle separation
`Δθ` tends to zero through nonzero values.
-/
def NeighboringReflectedRaysGenerateCaustic
    (system : Figure2gOpticalSystem) : Prop :=
  ∀ θ : ℝ,
    Tendsto (fun Δθ => neighboringIntersectionX system θ Δθ)
        (𝓝[≠] 0) (𝓝 (system.causticX θ).val) ∧
      Tendsto (fun Δθ => neighboringIntersectionY system θ Δθ)
        (𝓝[≠] 0) (𝓝 (system.causticY θ).val)

/--
The reusable conclusion of part C.3, stated directly rather than importing
that part's Lean output.
-/
def HasPreviousPartC3Coordinates
    (system : Figure2gOpticalSystem) : Prop :=
  ∀ θ : ℝ,
    (system.causticX θ).val = system.radius.val * Real.sin θ ^ 3 ∧
      (system.causticY θ).val =
        (system.radius.val / 2) * Real.cos θ * (2 - Real.cos (2 * θ))

/--
For small nonzero `θ`, the Figure 2g caustic has the leading-order cusp
`Y_c = v |X_c|^(p/q) + u`.  The `Tendsto` conclusion is the rigorous
leading-order interpretation: `(Y_c - u) / |X_c|^(p/q)` tends to `v`.

The theorem determines the two dimensioned coefficients and the two integer
exponents requested in part C.4.
-/
theorem determineSmallAngleCaustic
    (system : Figure2gOpticalSystem)
    (hEnvelope : NeighboringReflectedRaysGenerateCaustic system)
    (hC3 : HasPreviousPartC3Coordinates system) :
    ∃ (u : LengthReading) (v : CubeRootLengthReading) (p q : ℤ),
      u.val = system.radius.val / 2 ∧
      v.val =
        (3 / 4 : ℝ) * Real.rpow system.radius.val (1 / 3 : ℝ) ∧
      p = 2 ∧
      q = 3 ∧
      Tendsto
          (fun θ =>
            ((system.causticY θ).val - u.val) /
              Real.rpow |(system.causticX θ).val|
                ((p : ℝ) / (q : ℝ)))
          (𝓝[≠] 0) (𝓝 v.val) := by
  sorry

end

end IPhO2026Problems.IPhO2026_2_C_4
... [leading content omitted]
```

### Blueprint excerpt
```tex
Determine u, v, and the integers p,q.

\paragraph{Current subquestion.}
For theta << 1, put the caustic in the form Y\_c = v*|X\_c|\textasciicircum{}(p/q) + u. Determine u, v, and the integers p,q.

\paragraph{Recorded answer/context.}
u = R/2, v = (3/4)*R\textasciicircum{}(1/3), p = 2, and q = 3.

\paragraph{Figure/image path.}
/root/proposal\_for\_physic/science-mango/ipho\_2026\_source/image/T2\_page-4.png

\paragraph{Reusable previous-part conclusions.}
\begin{itemize}
\item Source C.3. Question: Find the limiting intersection coordinates (X\_c,Y\_c) of the neighboring reflected rays. Reusable conclusions: X\_c = R*sin(theta)\textasciicircum{}3; Y\_c = (R/2)*cos(theta)*(2 - cos(2*theta)). Policy: natural\_language\_prerequisite\_only; do\_not\_import\_Lean\_output
\end{itemize}

\paragraph{Formalization target.}
create a compiling Lean file with sorry bodies at `IPhO2026Problems/problem\_IPhO\_2026\_2\_C\_4.lean`. The Lean declarations must preserve the physical quantities, dimensions or dimensional roles, figure labels, governing-law hypotheses, and final relation expressed by this problem.
Use Mathlib/Physlib names found through LeanExplore where available. If a physics API is missing, introduce faithful local abstractions rather than scalar placeholder aliases.

\begin{theorem}[Physics formalization target]
\label{thm:physics:IPhO_2026_2_C_4:target}
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
igure2gOpticalSystem` preserves the mirror, reflected-ray family, coordinate
  convention, and caustic coordinate roles without treating a ray or mirror as
  a bare real number.
- `NeighboringReflectedRaysGenerateCaustic` supplies the missing
  geometrical-optics envelope interface as an actual neighboring-intersection
  limit, rather than assuming the requested cusp formula.

## Grounding gaps

- LeanExplore found general Euclidean reflection and ray declarations, but no
  ready-made half-cylindrical geometrical-optics caustic/envelope API matching
  Figure 2g.  The local line-family and envelope-limit abstractions fill this
  gap faithfully.
- The blueprint theorem environment has no `\lean{...}` declaration link.
  Prover permissions keep the chapter read-only, so the plan/review layer
  should attach
  `\lean{IPhO2026Problems.IPhO2026_2_C_4.determineSmallAngleCaustic}`; the
  deterministic sync can then manage `\leanok`.

## Verification

- `mcp__archon_lean_lsp.lean_diagnostic_messages`: no errors and exactly one
  expected `declaration uses sorry` warning.
- `lake env lean IPhO2026Problems/problem_IPhO_2026_2_C_4.lean`: exit code 0
  with exactly the expected `sorry` warning.
... [leading content omitted]
```

### Report excerpt: `physics-grounding-IPhO2026Problems_problem_IPhO_2026_2_C_4.md`
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

## 14. `IPhO2026Problems/problem_IPhO_2026_3_A_1.lean`

- Compile status: passed
- Open sorries: 1
- Direct-check seconds: 20.67
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_3_A_1.tex`
- Reports: `.archon/task_results/IPhO2026Problems_problem_IPhO_2026_3_A_1.lean.md`, `.archon/task_results/physics-grounding-IPhO2026Problems_problem_IPhO_2026_3_A_1.md`

### Lean excerpt
```lean
eabilityMagnitude)
    (state : ToroidalMagneticState) : Prop :=
  0 < siReadout μ₀ ∧
    siReadout state.fluxDensity =
      siReadout μ₀ * siReadout state.fieldStrength +
        siReadout μ₀ * siReadout state.magnetization

/--
The two current-dimensional quantities in Ampère's circuital law:
the circulation `∮_C H · dℓ` and the free current linked by `C`.
-/
structure ToroidalAmpereReadouts where
  fieldCirculation : ElectricCurrentMagnitude
  linkedFreeCurrent : ElectricCurrentMagnitude

/--
Ampère's circuital law and its two thin-torus evaluations.

The first conjunct is `∮_C H · dℓ = I_C`.  The second uses uniform `H` to
evaluate the circulation as `Hℓ`.  The third says that the curve links all
`N` turns, so its net free current is `NI`.
-/
def SatisfiesToroidalAmpereCircuitalLaw
    (torus : ParamagneticTorus)
    (winding : ToroidalWinding)
    (state : ToroidalMagneticState)
    (readouts : ToroidalAmpereReadouts) : Prop :=
  siReadout readouts.fieldCirculation =
      siReadout readouts.linkedFreeCurrent ∧
    siReadout readouts.fieldCirculation =
      siReadout state.fieldStrength *
        siReadout torus.meanAmperePathLength ∧
    siReadout readouts.linkedFreeCurrent =
      (winding.turnCount : ℝ) *
        siReadout state.instantaneousCurrent

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
  sorry

end IPhO2026Problems.IPhO2026_3_A_1
... [leading content omitted]
```

### Blueprint excerpt
```tex
ogeneous isotropic paramagnetic torus has mean radius R, inner radius r
with r << R, volume V, and cross-sectional area A.  An insulated conducting
wire is wound densely around it with N turns and instantaneous current I.
Fields H and B and magnetization M are approximately uniform in the torus.
Use B = mu\_0*H + mu\_0*M, Ampere's law, and the sign convention that work and
heat entering the paramagnetic torus are positive.

Current subquestion:
Write the field magnitude H inside the torus in terms of N, I, A, and V.

\paragraph{Current subquestion.}
Write the field magnitude H inside the torus in terms of N, I, A, and V.

\paragraph{Recorded answer/context.}
H = N*I*A/V.

\paragraph{Figure/image path.}
/root/proposal\_for\_physic/science-mango/ipho\_2026\_source/image/T3\_page-2.png

\paragraph{Formalization target.}
create a compiling Lean file with sorry bodies at `IPhO2026Problems/problem\_IPhO\_2026\_3\_A\_1.lean`. The Lean declarations must preserve the physical quantities, dimensions or dimensional roles, figure labels, governing-law hypotheses, and final relation expressed by this problem.
Use Mathlib/Physlib names found through LeanExplore where available. If a physics API is missing, introduce faithful local abstractions rather than scalar placeholder aliases.

\begin{theorem}[Physics formalization target]
\label{thm:physics:IPhO_2026_3_A_1:target}
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
ocal
  `Electromagnetism.ThreeDimension.ampereLaw` is the differential Maxwell
  equation for the vacuum-style `B` field. It does not state
  `∮ H · dℓ = I_free` in magnetic material, so it cannot replace the local
  circuital-law interface.
- No packaged Physlib types were found for physical volume, electric-current
  magnitude, material magnetic field strength `H`, magnetization magnitude,
  vacuum permeability, or flux-density magnitude. They are assembled from
  the grounded foundational dimensions.
- The blueprint theorem environment currently has no `\lean{...}` declaration
  name. The plan/review layer should attach
  `\lean{IPhO2026Problems.IPhO2026_3_A_1.fieldStrength_eq_turns_current_area_div_volume}`
  so deterministic marker synchronization can associate the statement.
- The read-only `archon dag-query` navigation command was unavailable on
  `PATH` in this prover environment, so no dependency-graph data were used.

## Verification

- `mcp__archon_lean_lsp.lean_diagnostic_messages`: no errors; exactly one
  expected `declaration uses sorry` warning.
- `lake env lean IPhO2026Problems/problem_IPhO_2026_3_A_1.lean`: exit code 0,
  with exactly the expected `sorry` warning.
... [leading content omitted]
```

### Report excerpt: `physics-grounding-IPhO2026Problems_problem_IPhO_2026_3_A_1.md`
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

## 15. `IPhO2026Problems/problem_IPhO_2026_3_A_2.lean`

- Compile status: passed
- Open sorries: 1
- Direct-check seconds: 29.172
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_3_A_2.tex`
- Reports: `.archon/task_results/IPhO2026Problems_problem_IPhO_2026_3_A_2.lean.md`, `.archon/task_results/physics-grounding-IPhO2026Problems_problem_IPhO_2026_3_A_2.md`

### Lean excerpt
```lean
:

`H = N I A / V`.
-/
def SatisfiesThinTorusAmpereLaw
    (g : TorusGeometry) (w : IdealToroidalWinding)
    (s : UniformMagneticState) : Prop :=
  ∀ u : UnitChoices,
    signedReadout s.fieldStrength u =
      (w.turnCount : ℝ) * signedReadout w.current u *
        magnitudeReadout g.crossSectionArea u /
          magnitudeReadout g.volume u

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
  sorry

end IPhO2026_3_A_2
end IPhO2026Problems
... [leading content omitted]
```

### Blueprint excerpt
```tex
M, Ampere's law, and the sign convention that work and
heat entering the paramagnetic torus are positive.

Current subquestion:
Find the work dW\_emf performed by the external voltage source when B changes by dB.

\paragraph{Current subquestion.}
Find the work dW\_emf performed by the external voltage source when B changes by dB.

\paragraph{Recorded answer/context.}
dW\_emf = V*H*dB.

\paragraph{Figure/image path.}
/root/proposal\_for\_physic/science-mango/ipho\_2026\_source/image/T3\_page-2.png

\paragraph{Reusable previous-part conclusions.}
\begin{itemize}
\item Source A.1. Question: Write the field magnitude H inside the torus in terms of N, I, A, and V. Reusable conclusions: H = N*I*A/V. Policy: natural\_language\_prerequisite\_only; do\_not\_import\_Lean\_output
\end{itemize}

\paragraph{Formalization target.}
create a compiling Lean file with sorry bodies at `IPhO2026Problems/problem\_IPhO\_2026\_3\_A\_2.lean`. The Lean declarations must preserve the physical quantities, dimensions or dimensional roles, figure labels, governing-law hypotheses, and final relation expressed by this problem.
Use Mathlib/Physlib names found through LeanExplore where available. If a physics API is missing, introduce faithful local abstractions rather than scalar placeholder aliases.

\begin{theorem}[Physics formalization target]
\label{thm:physics:IPhO_2026_3_A_2:target}
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
This keeps
  each physical role visible and leaves the requested relation to be proved.

## Grounding gaps

- Physlib's `Electromagnetism.MagneticField` is a spacetime-dependent
  Euclidean vector field, not the approximately uniform scalar `H` or `B`
  magnitude used in this problem.  It was therefore rejected as a semantic
  mismatch.
- LeanExplore found no ready-made Physlib interfaces for toroidal Ampère
  induction, paramagnetic magnetization, the constitutive law
  `B = μ₀(H + M)`, Faraday voltage impulse, or the source-work law.  Faithful
  local predicates were introduced instead.
- The read-only `archon dag-query` command advertised by the task was
  unavailable in this environment (`archon: command not found`).  The
  blueprint itself identifies A.1 as a natural-language prerequisite.
- No file-specific `/- USER: ... -/` hint was present because the assigned
  Lean file did not exist before this task.

## Verification

- `mcp__archon_lean_lsp.lean_diagnostic_messages` reports no errors and exactly
  one expected `declaration uses sorry` warning.
- `lake env lean IPhO2026Problems/problem_IPhO_2026_3_A_2.lean` exits
  successfully with exactly the expected `sorry` warning.
... [leading content omitted]
```

### Report excerpt: `physics-grounding-IPhO2026Problems_problem_IPhO_2026_3_A_2.md`
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

## 16. `IPhO2026Problems/problem_IPhO_2026_3_A_3.lean`

- Compile status: passed
- Open sorries: 1
- Direct-check seconds: 28.677
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_3_A_3.tex`
- Reports: `.archon/task_results/IPhO2026Problems_problem_IPhO_2026_3_A_3.lean.md`, `.archon/task_results/physics-grounding-IPhO2026Problems_problem_IPhO_2026_3_A_3.md`

### Lean excerpt
```lean
_A_per_m : ℝ
  vacuumCore_dFluxDensity_dBvac_T : ℝ

/-- Signed work readouts in joules, all using the convention that energy
entering the paramagnetic torus is positive.
-/
structure WorkIncrementReadouts where
  sourceWork_dWemf_J : ℝ
  vacuumCoreWork_dWvac_J : ℝ
  materialWork_dW_J : ℝ

/-- Governing laws, the A.2 result, and the figure/model readouts needed for
the A.3 work subtraction.

Crucially, this predicate does not contain the requested closed form for
`materialWork_dW_J`.
-/
structure SatisfiesWorkModel
    (toroid : ParamagneticToroid)
    (winding : DenseInsulatedWinding)
    (state : UniformMagneticState)
    (change : UniformMagneticIncrement)
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
  sorry

end IPhO2026_3_A_3
end IPhO2026Problems
... [leading content omitted]
```

### Blueprint excerpt
```tex
on that work and
heat entering the paramagnetic torus are positive.

Current subquestion:
Subtract the vacuum-core contribution and write the work dW done on the paramagnetic material.

\paragraph{Current subquestion.}
Subtract the vacuum-core contribution and write the work dW done on the paramagnetic material.

\paragraph{Recorded answer/context.}
dW = mu\_0*V*H*dM.

\paragraph{Figure/image path.}
/root/proposal\_for\_physic/science-mango/ipho\_2026\_source/image/T3\_page-2.png

\paragraph{Reusable previous-part conclusions.}
\begin{itemize}
\item Source A.2. Question: Find the work dW\_emf performed by the external voltage source when B changes by dB. Reusable conclusions: dW\_emf = V*H*dB. Policy: natural\_language\_prerequisite\_only; do\_not\_import\_Lean\_output
\end{itemize}

\paragraph{Formalization target.}
create a compiling Lean file with sorry bodies at `IPhO2026Problems/problem\_IPhO\_2026\_3\_A\_3.lean`. The Lean declarations must preserve the physical quantities, dimensions or dimensional roles, figure labels, governing-law hypotheses, and final relation expressed by this problem.
Use Mathlib/Physlib names found through LeanExplore where available. If a physics API is missing, introduce faithful local abstractions rather than scalar placeholder aliases.

\begin{theorem}[Physics formalization target]
\label{thm:physics:IPhO_2026_3_A_3:target}
The assigned autoformalize agent should translate this physics problem into Lean declarations in the covered file, with theorem and lemma proof bodies written as `by sorry`.
\end{theorem}
\begin{proof}
This is an autoformalization task, not a proof task. Produce statements that can later be proved by the physics prover without weakening the physical model.
\end{proof}
% --- Archon physics formalization source end ---
... [leading content omitted]
```

### Report excerpt: `IPhO2026Problems_problem_IPhO_2026_3_A_3.lean.md`
```markdown
l local governing-law interface because
  PhysLean has no packaged macroscopic magnetization/toroid-work API. It states
  the supplied physics laws directly and omits the current answer.

## Grounding gaps

- `Electromagnetism.MagneticField` is a spacetime-dependent Euclidean vector
  field. It is not the approximately uniform toroidal scalar magnitude used by
  this problem.
- No matching PhysLean declaration was found for macroscopic magnetization,
  the constitutive law `B = μ₀(H + M)`, Ampère's law for a toroidal magnetic
  material, or the vacuum/material work decomposition.
- The read-only `archon dag-query` command advertised by the task was
  unavailable in the shell (`archon: command not found`). The chapter itself
  identifies A.2 as a natural-language-only prerequisite.
- No file-specific `/- USER: ... -/` hint was present because the assigned Lean
  file did not exist before this autoformalization.

## Verification

- `mcp__archon_lean_lsp.lean_diagnostic_messages` reported no errors and
  exactly one expected `declaration uses sorry` warning.
- `lake env lean IPhO2026Problems/problem_IPhO_2026_3_A_3.lean` exited
  successfully with exactly the expected `sorry` warning.
... [leading content omitted]
```

### Report excerpt: `physics-grounding-IPhO2026Problems_problem_IPhO_2026_3_A_3.md`
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

## 17. `IPhO2026Problems/problem_IPhO_2026_3_B_1.lean`

- Compile status: passed
- Open sorries: 1
- Direct-check seconds: 22.366
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_3_B_1.tex`
- Reports: `.archon/task_results/IPhO2026Problems_problem_IPhO_2026_3_B_1.lean.md`, `.archon/task_results/physics-grounding-IPhO2026Problems_problem_IPhO_2026_3_B_1.md`

### Lean excerpt
```lean
(fun temperatureReadoutSI =>
          energyInJoules (internalEnergy temperatureReadoutSI))
        (heatCapacityAtConstantMagnetizationSI temperatureSI)
        temperatureSI
  magnetizationDifferentiable :
    ∀ (temperatureSI : ℝ),
      Differentiable ℝ (magnetizationMagnitudeSI temperatureSI)
  /--
  The previous-part magnetic-work law `dW = mu_0 * V * H dM`,
  integrated along an isothermal change from `H_i` to `H_f`.
  -/
  magneticWorkLaw :
    ∀ (temperatureSI initialFieldIntensitySI finalFieldIntensitySI : ℝ),
      energyInJoules
          (isothermalMagneticWorkInto temperatureSI
            initialFieldIntensitySI finalFieldIntensitySI) =
        ∫ fieldIntensitySI in initialFieldIntensitySI..finalFieldIntensitySI,
          torus.vacuumPermeabilitySI * torus.volumeSI * fieldIntensitySI *
            deriv (magnetizationMagnitudeSI temperatureSI) fieldIntensitySI
  /--
  The first law for an isothermal field change, with heat and work entering
  the torus taken as positive.
  -/
  isothermalFirstLaw :
    ∀ (temperatureSI initialFieldIntensitySI finalFieldIntensitySI : ℝ),
      energyInJoules (internalEnergy temperatureSI) -
          energyInJoules (internalEnergy temperatureSI) =
        energyInJoules
            (isothermalHeatInto temperatureSI
              initialFieldIntensitySI finalFieldIntensitySI) +
          energyInJoules
            (isothermalMagneticWorkInto temperatureSI
              initialFieldIntensitySI finalFieldIntensitySI)

/--
For the fixed-volume paramagnetic torus, the heat transferred into the torus
while the magnitude of `H` changes isothermally from `H_i` to `H_f` is

`Q = -(mu_0 * n * K / (2 * T)) * (H_f^2 - H_i^2)`.

The hypotheses that `H_i` and `H_f` are nonnegative record that they are
magnitudes.  No ordering is imposed: the oriented integral in the work law
also covers a decreasing field.
-/
theorem heatTransferredInto_isothermal
    (torus : ParamagneticTorus)
    (laws : ParamagneticTorusLaws torus)
    (temperatureSI initialFieldIntensitySI finalFieldIntensitySI : ℝ)
    (temperature_pos : 0 < temperatureSI)
    (initialFieldIntensity_nonneg : 0 ≤ initialFieldIntensitySI)
    (finalFieldIntensity_nonneg : 0 ≤ finalFieldIntensitySI) :
    energyInJoules
        (laws.isothermalHeatInto temperatureSI
          initialFieldIntensitySI finalFieldIntensitySI) =
      -(torus.vacuumPermeabilitySI * torus.amountMoles *
          torus.materialConstantKSI / (2 * temperatureSI)) *
        (finalFieldIntensitySI ^ 2 - initialFieldIntensitySI ^ 2) := by
  sorry

end

end IPhO2026_3_B_1
end IPhO2026Problems
... [leading content omitted]
```

### Blueprint excerpt
```tex
rent subquestion:
At fixed temperature T, H changes from H\_i to H\_f. Find the heat Q transferred into the torus.

\paragraph{Current subquestion.}
At fixed temperature T, H changes from H\_i to H\_f. Find the heat Q transferred into the torus.

\paragraph{Recorded answer/context.}
Q = -(mu\_0*n*K/(2*T))*(H\_f\textasciicircum{}2 - H\_i\textasciicircum{}2).

\paragraph{Figure/image path.}
/root/proposal\_for\_physic/science-mango/ipho\_2026\_source/image/T3\_page-3.png

\paragraph{Reusable previous-part conclusions.}
\begin{itemize}
\item Source A.3. Question: Subtract the vacuum-core contribution and write the work dW done on the paramagnetic material. Reusable conclusions: dW = mu\_0*V*H*dM. Policy: natural\_language\_prerequisite\_only; do\_not\_import\_Lean\_output
\end{itemize}

\paragraph{Formalization target.}
create a compiling Lean file with sorry bodies at `IPhO2026Problems/problem\_IPhO\_2026\_3\_B\_1.lean`. The Lean declarations must preserve the physical quantities, dimensions or dimensional roles, figure labels, governing-law hypotheses, and final relation expressed by this problem.
Use Mathlib/Physlib names found through LeanExplore where available. If a physics API is missing, introduce faithful local abstractions rather than scalar placeholder aliases.

\begin{theorem}[Physics formalization target]
\label{thm:physics:IPhO_2026_3_B_1:target}
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
nt readouts.
  Dimensionful energy quantities use Physlib's existing `DimEnergy` instead
  of a local wrapper.

## Grounding gaps and redraft requests

- No suitable Physlib declaration was found for magnetic field intensity
  `H`, magnetization magnitude `M`, paramagnetic equations of state, or the
  first law with the sign convention used here. The local law interface
  preserves exactly those roles.
- The read-only DAG navigation command was unavailable in this environment
  (`archon: command not found`). The blueprint itself identifies A.3 as the
  only prerequisite and forbids importing its Lean output.
- The blueprint target environment currently has no `\lean{...}` declaration
  mapping. A plan/review pass can map it to
  `IPhO2026Problems.IPhO2026_3_B_1.heatTransferredInto_isothermal` so the
  deterministic marker synchronizer can attach `\leanok`.
- No file-specific `/- USER: ... -/` hint was present because the assigned
  Lean file did not yet exist.

## Verification

Both the Lean LSP diagnostics and
`lake env lean IPhO2026Problems/problem_IPhO_2026_3_B_1.lean` succeed with
exactly one expected warning, for the deliberate `sorry` body of
`heatTransferredInto_isothermal`.
... [leading content omitted]
```

### Report excerpt: `physics-grounding-IPhO2026Problems_problem_IPhO_2026_3_B_1.md`
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

## 18. `IPhO2026Problems/problem_IPhO_2026_3_B_2.lean`

- Compile status: passed
- Open sorries: 1
- Direct-check seconds: 21.48
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_3_B_2.tex`
- Reports: `.archon/task_results/IPhO2026Problems_problem_IPhO_2026_3_B_2.lean.md`, `.archon/task_results/physics-grounding-IPhO2026Problems_problem_IPhO_2026_3_B_2.md`

### Lean excerpt
```lean
onstant *
          fieldStrengthAlongProcessInSI process τ
  heatCapacityEquation :
    ∀ τ ∈ Set.Icc (0 : ℝ) 1,
      heatCapacityInSI
          (process.heatCapacityAtConstantMagnetization τ) =
        torus.amountInMoles * lambdaInSI torus.lambda /
          (temperatureAlongProcessInKelvin process τ) ^ 2
  internalEnergyDifferential :
    ∀ τ ∈ Set.Ioo (0 : ℝ) 1,
      deriv (fun s => energyInJoules (process.internalEnergy s)) τ =
        heatCapacityInSI
            (process.heatCapacityAtConstantMagnetization τ) *
          deriv (temperatureAlongProcessInKelvin process) τ
  magneticWorkDifferential_previousA3 :
    ∀ τ ∈ Set.Ioo (0 : ℝ) 1,
      deriv (fun s => energyInJoules (process.workIntoMaterial s)) τ =
        vacuumPermeabilityInSI torus.vacuumPermeability *
              volumeInCubicMeters torus.volume *
            fieldStrengthAlongProcessInSI process τ *
          deriv (magnetizationAlongProcessInSI process) τ
  firstLaw_enteringPositive :
    ∀ τ ∈ Set.Ioo (0 : ℝ) 1,
      deriv (fun s => energyInJoules (process.internalEnergy s)) τ =
        deriv (fun s => energyInJoules (process.heatIntoMaterial s)) τ +
          deriv (fun s => energyInJoules (process.workIntoMaterial s)) τ
  adiabatic_noHeat :
    ∀ τ ∈ Set.Ioo (0 : ℝ) 1,
      deriv (fun s => energyInJoules (process.heatIntoMaterial s)) τ = 0

/--
For an adiabatic change of applied-field magnitude from `H_initial_SI` to
`H_final_SI`, beginning at `T_initial_K`, the final-minus-initial temperature
has the value stated in IPhO 2026 problem 3, part B.2.
-/
theorem adiabatic_temperature_change
    (torus : ParamagneticTorus)
    (process : ParamagneticTorusProcess)
    (laws : SatisfiesParamagneticTorusLaws torus process)
    (H_initial_SI H_final_SI T_initial_K : ℝ)
    (h_initial_field :
      fieldStrengthAlongProcessInSI process 0 = H_initial_SI)
    (h_final_field :
      fieldStrengthAlongProcessInSI process 1 = H_final_SI)
    (h_initial_temperature :
      temperatureAlongProcessInKelvin process 0 = T_initial_K) :
    temperatureAlongProcessInKelvin process 1 - T_initial_K =
      T_initial_K *
        (Real.sqrt
            ((lambdaInSI torus.lambda +
                vacuumPermeabilityInSI torus.vacuumPermeability *
                  curieConstantInSI torus.curieConstant *
                  H_final_SI ^ 2) /
              (lambdaInSI torus.lambda +
                vacuumPermeabilityInSI torus.vacuumPermeability *
                  curieConstantInSI torus.curieConstant *
                  H_initial_SI ^ 2)) -
          1) := by
  sorry

end IPhO2026Problems.IPhO2026_3_B_2
... [leading content omitted]
```

### Blueprint excerpt
```tex
r an adiabatic change H\_i -> H\_f starting at T\_i, determine Delta T = T\_f - T\_i.

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

\begin{theorem}[Physics formalization target]
\label{thm:physics:IPhO_2026_3_B_2:target}
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
mount of substance.

## Grounding gaps and redraft requests

- No Physlib API was found for a uniform paramagnetic material's field
  strength `H`, magnetization `M`, equation of state, signed magnetic work,
  or adiabatic first-law process. The local dimensionful state/process/law
  abstractions preserve those roles.
- Physlib's `Temperature` is a nonnegative scalar in an arbitrary
  zero-preserving unit choice. `Dimensionful (WithDim Θ𝓭 ℝ≥0)` was used
  instead so that the theorem can name the kelvin SI readout explicitly.
- `CanonicalEnsemble.heatCapacity` is a constant-volume statistical-ensemble
  derivative and is not the supplied constant-magnetization heat capacity.
- The blueprint theorem environment has no `\lean{...}` mapping. A plan/review
  pass should map it to
  `IPhO2026Problems.IPhO2026_3_B_2.adiabatic_temperature_change`.
- No file-specific `/- USER: ... -/` hint was present because the assigned
  Lean file did not previously exist.

## Verification

- Lean LSP diagnostics succeed with one expected warning for the deliberate
  `sorry` body.
- `lake env lean
  IPhO2026Problems/problem_IPhO_2026_3_B_2.lean` exits successfully with the
  same single expected warning.
... [leading content omitted]
```

### Report excerpt: `physics-grounding-IPhO2026Problems_problem_IPhO_2026_3_B_2.md`
```markdown
e Mathlib | **Target of a Path.** For a path $\gamma$ from $x$ to $y$ in a topological space, the value of the path at the endpoint of the unit interval, $\gamma(1)$, is equal to $y$.
- `semiformal_result` | module `Physlib.Meta.Informal.SemiFormal` | package PhysLean | A semiformal result is either a - definition in which the type is given but not the definition. - proof in which the proposition is given but not the proof. Semiformal results cannot be used in further code. They are...
- `stereographic_target` | module `Mathlib.Geometry.Manifold.Instances.Sphere` | package Mathlib | **Target of the Stereographic Projection.** For any unit vector $v$ in an inner product space, the target of the stereographic projection associated with $v$ is the entire codomain (the orthogonal complement of the su...

## Grounded Mathlib/PhysLean names

- `Real.sqrt` (Mathlib)
- `Real.coe_sqrt` (Mathlib)
- `Real.sqrt_lt'` (Mathlib)
- `Path.target` (Mathlib)
- `semiformal_result` (PhysLean)
- `stereographic_target` (Mathlib)

## Local abstractions introduced

- None detected from blueprint Lean references.

## Grounding gaps

- No unresolved LeanExplore grounding gaps were recorded by this preflight.
... [leading content omitted]
```

## 19. `IPhO2026Problems/problem_IPhO_2026_3_C_2.lean`

- Compile status: passed
- Open sorries: 1
- Direct-check seconds: 19.356
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_3_C_2.tex`
- Reports: `.archon/task_results/IPhO2026Problems_problem_IPhO_2026_3_C_2.lean.md`, `.archon/task_results/physics-grounding-IPhO2026Problems_problem_IPhO_2026_3_C_2.md`

### Lean excerpt
```lean
CubicMeterPerMole /
        (2 * readout.temperatureKelvin temperature)) *
      (readout.magneticFieldAmperePerMeter finalState.magneticFieldMagnitude ^ 2 -
        readout.magneticFieldAmperePerMeter initialState.magneticFieldMagnitude ^ 2)

/-- Entropy balance of a reversible Carnot refrigerator:
`Q꜀ / T꜀ = Qₕ / Tₕ`, where both heats are nonnegative magnitudes. -/
def SatisfiesReversibleCarnotHeatBalance {q : PhysicalQuantityTypes}
    (readout : SIReadout q) (cycle : CarnotCycle q) : Prop :=
  readout.heatJoule cycle.heatAbsorbedFromCold /
      readout.temperatureKelvin cycle.coldReservoirTemperature =
    readout.heatJoule cycle.heatDeliveredToHot /
      readout.temperatureKelvin cycle.hotReservoirTemperature

/-- All four vertices obey the same paramagnetic equation of state. -/
structure EquationOfStateAtVertices {q : PhysicalQuantityTypes}
    (readout : SIReadout q) (cycle : CarnotCycle q) : Prop where
  at_state1 :
    SatisfiesParamagneticEquationOfState readout cycle cycle.state1
  at_state2 :
    SatisfiesParamagneticEquationOfState readout cycle cycle.state2
  at_state3 :
    SatisfiesParamagneticEquationOfState readout cycle cycle.state3
  at_state4 :
    SatisfiesParamagneticEquationOfState readout cycle cycle.state4

/-- In the Carnot refrigeration cycle of Figure 3b, the magnitude at state `1`
is determined by the other three vertex magnitudes:

`M₁ = √(M₂² - M₃² + M₄²)`.

The assumptions contain the physical laws and figure readouts, but not this
magnetization identity. -/
theorem magnetization_state1_eq_sqrt {q : PhysicalQuantityTypes}
    (readout : SIReadout q) (cycle : CarnotCycle q)
    (hFigure : Figure3bReadout cycle)
    (hEquationOfState : EquationOfStateAtVertices readout cycle)
    (hColdIsotherm :
      SatisfiesIsothermalHeatLaw readout cycle
        cycle.coldReservoirTemperature cycle.state2 cycle.state3
        (readout.heatJoule cycle.heatAbsorbedFromCold))
    (hHotIsotherm :
      SatisfiesIsothermalHeatLaw readout cycle
        cycle.hotReservoirTemperature cycle.state4 cycle.state1
        (-readout.heatJoule cycle.heatDeliveredToHot))
    (hCarnotBalance : SatisfiesReversibleCarnotHeatBalance readout cycle) :
    readout.magnetizationAmperePerMeter cycle.state1.magnetizationMagnitude =
      Real.sqrt
        (readout.magnetizationAmperePerMeter cycle.state2.magnetizationMagnitude ^ 2 -
          readout.magnetizationAmperePerMeter cycle.state3.magnetizationMagnitude ^ 2 +
          readout.magnetizationAmperePerMeter cycle.state4.magnetizationMagnitude ^ 2) := by
  sorry

end IPhO2026_3_C_2
end IPhO2026Problems
... [leading content omitted]
```

### Blueprint excerpt
```tex
roposal\_for\_physic/science-mango/ipho\_2026\_source/image/T3\_page-3.png

\paragraph{Reusable previous-part conclusions.}
\begin{itemize}
\item Source B.1. Question: At fixed temperature T, H changes from H\_i to H\_f. Find the heat Q transferred into the torus. Reusable conclusions: Q = -(mu\_0*n*K/(2*T))*(H\_f\textasciicircum{}2 - H\_i\textasciicircum{}2). Policy: natural\_language\_prerequisite\_only; do\_not\_import\_Lean\_output
\item Source C.1. Question: Label T\_h and T\_c on Figure 3b and identify the processes on which Q\_h and Q\_c are transferred. Reusable conclusions: States 1 and 4 lie at T\_h; states 2 and 3 lie at T\_c. Q\_c is absorbed on 2->3, and Q\_h is delivered on 4->1. Policy: natural\_language\_prerequisite\_only; do\_not\_import\_Lean\_output
\end{itemize}

\paragraph{Formalization target.}
create a compiling Lean file with sorry bodies at `IPhO2026Problems/problem\_IPhO\_2026\_3\_C\_2.lean`. The Lean declarations must preserve the physical quantities, dimensions or dimensional roles, figure labels, governing-law hypotheses, and final relation expressed by this problem.
Use Mathlib/Physlib names found through LeanExplore where available. If a physics API is missing, introduce faithful local abstractions rather than scalar placeholder aliases.

\begin{theorem}[Physics formalization target]
\label{thm:physics:IPhO_2026_3_C_2:target}
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
gnetic equation-of-state,
  isothermal thermodynamics, and Carnot entropy interfaces directly rather
  than defining the requested answer.

## Grounding gaps

- `Electromagnetism.MagneticField` is a spacetime-dependent Euclidean vector
  field.  It is not the scalar field-strength magnitude `H` plotted against
  temperature in Figure 3b.
- No matching PhysLean type or ready-made law was found for paramagnetic
  magnetization magnitude, the equation `T M V = n K H`, the B.1 heat law, or
  a reversible magnetic Carnot cycle.  The local abstract interfaces above
  retain their physical meanings.
- The read-only `archon dag-query` command advertised by the task was
  unavailable in this environment (`archon: command not found`).  The chapter
  itself marks previous parts as natural-language prerequisites only.
- No file-specific `/- USER: ... -/` hint was present because the assigned
  Lean file did not yet exist.

## Verification

- `mcp__archon_lean_lsp.lean_diagnostic_messages` reported no errors and
  exactly one expected `declaration uses sorry` warning.
- `lake env lean IPhO2026Problems/problem_IPhO_2026_3_C_2.lean` exited
  successfully with exactly the expected `sorry` warning.
... [leading content omitted]
```

### Report excerpt: `physics-grounding-IPhO2026Problems_problem_IPhO_2026_3_C_2.md`
```markdown
e Mathlib | **Target of a Path.** For a path $\gamma$ from $x$ to $y$ in a topological space, the value of the path at the endpoint of the unit interval, $\gamma(1)$, is equal to $y$.
- `semiformal_result` | module `Physlib.Meta.Informal.SemiFormal` | package PhysLean | A semiformal result is either a - definition in which the type is given but not the definition. - proof in which the proposition is given but not the proof. Semiformal results cannot be used in further code. They are...
- `stereographic_target` | module `Mathlib.Geometry.Manifold.Instances.Sphere` | package Mathlib | **Target of the Stereographic Projection.** For any unit vector $v$ in an inner product space, the target of the stereographic projection associated with $v$ is the entire codomain (the orthogonal complement of the su...

## Grounded Mathlib/PhysLean names

- `Real.sqrt` (Mathlib)
- `Real.coe_sqrt` (Mathlib)
- `Real.sqrt_lt'` (Mathlib)
- `Path.target` (Mathlib)
- `semiformal_result` (PhysLean)
- `stereographic_target` (Mathlib)

## Local abstractions introduced

- None detected from blueprint Lean references.

## Grounding gaps

- No unresolved LeanExplore grounding gaps were recorded by this preflight.
... [leading content omitted]
```

## 20. `IPhO2026Problems/problem_IPhO_2026_3_C_3.lean`

- Compile status: passed
- Open sorries: 1
- Direct-check seconds: 20.176
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_3_C_3.tex`
- Reports: `.archon/task_results/IPhO2026Problems_problem_IPhO_2026_3_C_3.lean.md`, `.archon/task_results/physics-grounding-IPhO2026Problems_problem_IPhO_2026_3_C_3.md`

### Lean excerpt
```lean
s.torusAmountMol * s.molarCurieConstantK_m3_per_mol *
          (s.magneticFieldStrength i).val
  heliumCalorimetry :
    s.heatAbsorbedFromHelium.val =
      s.heliumDensity.val * s.heliumVolume.val *
        s.heliumSpecificHeatCapacity.val *
          (s.heliumInitialTemperature.val - s.heliumFinalTemperature.val)
  hotTemperaturePositive : 0 < s.hotReservoirTemperature.val
  coldTemperaturePositive : 0 < s.coldReservoirTemperature.val
  finalHeliumTemperatureNonnegative : 0 ≤ s.heliumFinalTemperature.val
  magnetizationNonnegative :
    ∀ i : CarnotState, 0 ≤ (s.magnetization i).val
  heatAbsorbedNonnegative : 0 ≤ s.heatAbsorbedFromHelium.val
  heatDeliveredNonnegative : 0 ≤ s.heatDeliveredToHotReservoir.val

/--
The two reusable results explicitly licensed by the blueprint: the part B.1
isothermal-heat relation on the cold leg `2 → 3`, and the nonnegative-magnitude
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
  sorry

end IPhO2026Problems.IPhO2026_3_C_3
... [leading content omitted]
```

### Blueprint excerpt
```tex
K.

\paragraph{Figure/image path.}
/root/proposal\_for\_physic/science-mango/ipho\_2026\_source/image/T3\_page-4.png

\paragraph{Reusable previous-part conclusions.}
\begin{itemize}
\item Source B.1. Question: At fixed temperature T, H changes from H\_i to H\_f. Find the heat Q transferred into the torus. Reusable conclusions: Q = -(mu\_0*n*K/(2*T))*(H\_f\textasciicircum{}2 - H\_i\textasciicircum{}2). Policy: natural\_language\_prerequisite\_only; do\_not\_import\_Lean\_output
\item Source C.2. Question: Express M\_1 in terms of M\_2, M\_3, and M\_4. Reusable conclusions: M\_1 = sqrt(M\_2\textasciicircum{}2 - M\_3\textasciicircum{}2 + M\_4\textasciicircum{}2), taking the nonnegative magnitude. Policy: natural\_language\_prerequisite\_only; do\_not\_import\_Lean\_output
\end{itemize}

\paragraph{Formalization target.}
create a compiling Lean file with sorry bodies at `IPhO2026Problems/problem\_IPhO\_2026\_3\_C\_3.lean`. The Lean declarations must preserve the physical quantities, dimensions or dimensional roles, figure labels, governing-law hypotheses, and final relation expressed by this problem.
Use Mathlib/Physlib names found through LeanExplore where available. If a physics API is missing, introduce faithful local abstractions rather than scalar placeholder aliases.

\begin{theorem}[Physics formalization target]
\label{thm:physics:IPhO_2026_3_C_3:target}
The assigned autoformalize agent should translate this physics problem into Lean declarations in the covered file, with theorem and lemma proof bodies written as `by sorry`.
\end{theorem}
\begin{proof}
This is an autoformalization task, not a proof task. Produce statements that can later be proved by the physics prover without weakening the physical model.
\end{proof}
% --- Archon physics formalization source end ---
... [leading content omitted]
```

### Report excerpt: `IPhO2026Problems_problem_IPhO_2026_3_C_3.lean.md`
```markdown
tant type
  was available.
- `Electromagnetism.MagneticField` is a spacetime-dependent vector magnetic
  field, whereas the problem supplies four scalar `H` field-strength
  readouts.  It is not a compatible replacement.
- `CanonicalEnsemble.heatCapacity` is a derivative in a statistical canonical
  ensemble, not the supplied macroscopic specific heat capacity of liquid
  helium.
- PhysLean's packaged `Temperature` wraps a nonnegative scalar in an arbitrary
  fixed unit.  The formalization instead uses `WithDim Dimension.Θ𝓭 ℝ` so
  temperature participates in the same explicit dimensional framework as
  volume, density, field strength, and energy; physical nonnegativity is
  stated in `GoverningLaws`.
- The `archon dag-query` executable requested by the prompt was not present on
  `PATH`.  This did not block the task because the chapter explicitly requires
  natural-language-only reuse of B.1 and C.2, which is restated locally.

## Verification

- `mcp__archon_lean_lsp.lean_diagnostic_messages`: no errors; exactly one
  expected `declaration uses sorry` warning.
- `lake env lean IPhO2026Problems/problem_IPhO_2026_3_C_3.lean`: exit code 0
  with exactly the expected `sorry` warning.
... [leading content omitted]
```

### Report excerpt: `physics-grounding-IPhO2026Problems_problem_IPhO_2026_3_C_3.md`
```markdown
e Mathlib | **Target of a Path.** For a path $\gamma$ from $x$ to $y$ in a topological space, the value of the path at the endpoint of the unit interval, $\gamma(1)$, is equal to $y$.
- `semiformal_result` | module `Physlib.Meta.Informal.SemiFormal` | package PhysLean | A semiformal result is either a - definition in which the type is given but not the definition. - proof in which the proposition is given but not the proof. Semiformal results cannot be used in further code. They are...
- `stereographic_target` | module `Mathlib.Geometry.Manifold.Instances.Sphere` | package Mathlib | **Target of the Stereographic Projection.** For any unit vector $v$ in an inner product space, the target of the stereographic projection associated with $v$ is the entire codomain (the orthogonal complement of the su...

## Grounded Mathlib/PhysLean names

- `Real.sqrt` (Mathlib)
- `Real.coe_sqrt` (Mathlib)
- `Real.sqrt_lt'` (Mathlib)
- `Path.target` (Mathlib)
- `semiformal_result` (PhysLean)
- `stereographic_target` (Mathlib)

## Local abstractions introduced

- None detected from blueprint Lean references.

## Grounding gaps

- No unresolved LeanExplore grounding gaps were recorded by this preflight.
... [leading content omitted]
```

## 21. `IPhO2026Problems/problem_IPhO_2026_3_C_4.lean`

- Compile status: passed
- Open sorries: 1
- Direct-check seconds: 17.622
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_3_C_4.tex`
- Reports: `.archon/task_results/IPhO2026Problems_problem_IPhO_2026_3_C_4.lean.md`, `.archon/task_results/physics-grounding-IPhO2026Problems_problem_IPhO_2026_3_C_4.md`

### Lean excerpt
```lean
to `T`, entirely below `Tₕ`. -/
def HasPhysicalOperatingRange (run : ContinuousCoolingRun) : Prop :=
  0 < run.bodyHeatCapacity.val ∧
    0 < run.inputPower.val ∧
    0 < (run.finalTemperature : ℝ) ∧
    (run.finalTemperature : ℝ) < (run.initialTemperature : ℝ) ∧
    (run.initialTemperature : ℝ) < (run.hotReservoirTemperature : ℝ) ∧
    0 < run.elapsedTime.val ∧
    run.bodyTemperature 0 = run.initialTemperature ∧
    run.bodyTemperature run.elapsedTime.val = run.finalTemperature ∧
    ContinuousOn (fun s : ℝ => (run.bodyTemperature s : ℝ))
      (Set.Icc (0 : ℝ) run.elapsedTime.val) ∧
    ∀ s ∈ Set.Icc (0 : ℝ) run.elapsedTime.val,
      0 < (run.bodyTemperature s : ℝ) ∧
        (run.bodyTemperature s : ℝ) < (run.hotReservoirTemperature : ℝ)

/-- Governing laws for the continuous limit of the repeated Carnot cycles.

The middle equality is exactly the source relation
`dQ꜀/dQₕ = T꜀/Tₕ`, expressed using heat-flow rates.  The final derivative is
the constant-heat-capacity law for the cooled body. -/
def ObeysContinuousCarnotCoolingLaws (run : ContinuousCoolingRun) : Prop :=
  ∀ s ∈ Set.Ioo (0 : ℝ) run.elapsedTime.val,
    0 < (run.coldHeatRate s).val ∧
      0 < (run.hotHeatRate s).val ∧
      (run.hotHeatRate s).val - (run.coldHeatRate s).val =
        run.inputPower.val ∧
      (run.coldHeatRate s).val / (run.hotHeatRate s).val =
        (run.bodyTemperature s : ℝ) /
          (run.hotReservoirTemperature : ℝ) ∧
      HasDerivAt (fun u : ℝ => (run.bodyTemperature u : ℝ))
        (-((run.coldHeatRate s).val / run.bodyHeatCapacity.val)) s

/-- Elapsed time for cooling the body from `T₀` to `T` with constant heat
capacity, constant refrigerator input power, and constant hot-reservoir
temperature. -/
theorem IPhO_2026_3_C_4_elapsedTime
    (cycle : ParamagneticCarnotCycle)
    (run : ContinuousCoolingRun)
    (h_sameUnits : run.unitChoice = cycle.unitChoice)
    (h_sameHotReservoir :
      run.hotReservoirTemperature = cycle.hotReservoirTemperature)
    (h_figure : FollowsFigureThreeB cycle)
    (h_equationOfState : ObeysParamagneticEquationOfState cycle)
    (h_operatingRange : HasPhysicalOperatingRange run)
    (h_carnotCooling : ObeysContinuousCarnotCoolingLaws run) :
    run.elapsedTime.val =
      (run.bodyHeatCapacity.val * (run.hotReservoirTemperature : ℝ) /
          run.inputPower.val) *
        (Real.log
            ((run.initialTemperature : ℝ) / (run.finalTemperature : ℝ)) -
          ((run.initialTemperature : ℝ) - (run.finalTemperature : ℝ)) /
            (run.hotReservoirTemperature : ℝ)) := by
  sorry

end

end IPhO2026Problems.IPhO2026_3_C_4
... [leading content omitted]
```

### Blueprint excerpt
```tex
de of heat
delivered to the hot reservoir and Q\_c is the magnitude absorbed from the cold
reservoir.  The equation of state is T*M*V = n*K*H and the isothermal heat
relation from part B may be reused.

Current subquestion:
A body of heat capacity C\_c is cooled from T\_0 to T while refrigerator input power P and hot-reservoir temperature T\_h remain constant. Determine the elapsed time.

\paragraph{Current subquestion.}
A body of heat capacity C\_c is cooled from T\_0 to T while refrigerator input power P and hot-reservoir temperature T\_h remain constant. Determine the elapsed time.

\paragraph{Recorded answer/context.}
t = (C\_c*T\_h/P)*[ln(T\_0/T) - (T\_0 - T)/T\_h].

\paragraph{Figure/image path.}
/root/proposal\_for\_physic/science-mango/ipho\_2026\_source/image/T3\_page-4.png

\paragraph{Formalization target.}
create a compiling Lean file with sorry bodies at `IPhO2026Problems/problem\_IPhO\_2026\_3\_C\_4.lean`. The Lean declarations must preserve the physical quantities, dimensions or dimensional roles, figure labels, governing-law hypotheses, and final relation expressed by this problem.
Use Mathlib/Physlib names found through LeanExplore where available. If a physics API is missing, introduce faithful local abstractions rather than scalar placeholder aliases.

\begin{theorem}[Physics formalization target]
\label{thm:physics:IPhO_2026_3_C_4:target}
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
nt scalar readouts in a chosen unit system. The
  lower-level `WithDim` API is used so the closed-form numerical relation can
  be stated without inventing unit-conversion equalities.
- Physlib's `Dimension` omits amount of substance, so the mole role of `n` and
  the per-mole role of `K` cannot both be encoded in its five-component
  dimension vector; the molar component is retained explicitly by names and
  `AmountOfSubstanceReadout`.
- No ready-made Carnot heat-ratio or continuous refrigerator law was found, so
  the exact official-source relations were stated locally.
- The advertised `archon dag-query` executable was unavailable on `PATH`
  (`archon: command not found`), so no dependency-graph result could be used.
- The assigned Lean file did not exist initially, so there was no file-specific
  `/- USER: ... -/` hint.
- The blueprint needs the `\lean{...}` name above for deterministic marker
  synchronization.

## Verification

- `mcp__archon_lean_lsp.lean_diagnostic_messages` reported no errors and only
  the expected `declaration uses sorry` warning.
- `lake env lean IPhO2026Problems/problem_IPhO_2026_3_C_4.lean` exited
  successfully with only the expected `sorry` warning.
... [leading content omitted]
```

### Report excerpt: `physics-grounding-IPhO2026Problems_problem_IPhO_2026_3_C_4.md`
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

## 22. `IPhO2026Problems/problem_IPhO_2026_3_C_5.lean`

- Compile status: passed
- Open sorries: 1
- Direct-check seconds: 19.582
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_3_C_5.tex`
- Reports: `.archon/task_results/IPhO2026Problems_problem_IPhO_2026_3_C_5.lean.md`, `.archon/task_results/physics-grounding-IPhO2026Problems_problem_IPhO_2026_3_C_5.md`

### Lean excerpt
```lean
Temperature` to
`finalTemperature`.
-/
structure CoolingRun where
  initialTemperature : Temperature
  finalTemperature : Temperature
  hotReservoirTemperature : Temperature
  cooledBodyHeatCapacityJoulePerKelvin : ℝ
  inputPowerWatt : ℝ
  elapsedTimeSecond : ℝ
  totalColdHeatJoule : ℝ
  totalInputWorkJoule : ℝ

/-- Overall refrigerator coefficient of performance, `COP = Q_c / W`. -/
noncomputable def coefficientOfPerformance (run : CoolingRun) : ℝ :=
  run.totalColdHeatJoule / run.totalInputWorkJoule

/--
The overall coefficient of performance of all cycles up to the elapsed time
computed in part C.4.

The C.4 elapsed-time relation is an explicit previous-part hypothesis. The
other two run relations are the constant-heat-capacity energy balance
`Q_c = C_c (T₀ - T)` and the constant-input-power work balance `W = P t`.
-/
theorem overallCoefficientOfPerformance
    (cycle : MagneticCarnotCycle)
    (run : CoolingRun)
    (hFigure : FollowsFigureThreeB cycle)
    (hEquationOfState : SatisfiesParamagneticEquationOfState cycle)
    (hIsothermalHeat : SatisfiesIsothermalHeatRelation cycle)
    (hCyclePhysical : HasPhysicalCycleParameters cycle)
    (hHotReservoir :
      cycle.hotReservoirTemperature = run.hotReservoirTemperature)
    (hFinalColdReservoir :
      cycle.coldReservoirTemperature = run.finalTemperature)
    (hInitialTemperaturePositive : 0 < run.initialTemperature.val)
    (hFinalTemperaturePositive : 0 < run.finalTemperature.val)
    (hCooling : run.finalTemperature.val < run.initialTemperature.val)
    (hHeatCapacityPositive : 0 < run.cooledBodyHeatCapacityJoulePerKelvin)
    (hPowerPositive : 0 < run.inputPowerWatt)
    (hElapsedTimeFromC4 :
      run.elapsedTimeSecond =
        (run.cooledBodyHeatCapacityJoulePerKelvin *
            run.hotReservoirTemperature.val / run.inputPowerWatt) *
          (Real.log
              (run.initialTemperature.val / run.finalTemperature.val) -
            (run.initialTemperature.val - run.finalTemperature.val) /
              run.hotReservoirTemperature.val))
    (hTotalColdHeat :
      run.totalColdHeatJoule =
        run.cooledBodyHeatCapacityJoulePerKelvin *
          (run.initialTemperature.val - run.finalTemperature.val))
    (hTotalInputWork :
      run.totalInputWorkJoule = run.inputPowerWatt * run.elapsedTimeSecond) :
    coefficientOfPerformance run =
      (run.hotReservoirTemperature.val /
            (run.initialTemperature.val - run.finalTemperature.val) *
          Real.log (run.initialTemperature.val / run.finalTemperature.val) -
        1)⁻¹ := by
  sorry

end IPhO2026Problems.IPhO2026_3_C_5
... [leading content omitted]
```

### Blueprint excerpt
```tex
me found in C4.

\paragraph{Current subquestion.}
Determine the overall coefficient of performance COP = Q\_c/W for all cycles up to the time found in C4.

\paragraph{Recorded answer/context.}
COP = [(T\_h/(T\_0 - T))*ln(T\_0/T) - 1]\textasciicircum{}(-1).

\paragraph{Figure/image path.}
/root/proposal\_for\_physic/science-mango/ipho\_2026\_source/image/T3\_page-4.png

\paragraph{Reusable previous-part conclusions.}
\begin{itemize}
\item Source C.4. Question: A body of heat capacity C\_c is cooled from T\_0 to T while refrigerator input power P and hot-reservoir temperature T\_h remain constant. Determine the elapsed time. Reusable conclusions: t = (C\_c*T\_h/P)*[ln(T\_0/T) - (T\_0 - T)/T\_h]. Policy: natural\_language\_prerequisite\_only; do\_not\_import\_Lean\_output
\end{itemize}

\paragraph{Formalization target.}
create a compiling Lean file with sorry bodies at `IPhO2026Problems/problem\_IPhO\_2026\_3\_C\_5.lean`. The Lean declarations must preserve the physical quantities, dimensions or dimensional roles, figure labels, governing-law hypotheses, and final relation expressed by this problem.
Use Mathlib/Physlib names found through LeanExplore where available. If a physics API is missing, introduce faithful local abstractions rather than scalar placeholder aliases.

\begin{theorem}[Physics formalization target]
\label{thm:physics:IPhO_2026_3_C_5:target}
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
constants are real-valued measured SI components with
  their units in the names. This follows the problem's scalar-readout use while
  retaining PhysLean's nonnegative absolute `Temperature` object.

## Grounding gaps and redraft requests

- LeanExplore exposed no ready-made Carnot refrigeration cycle or coefficient
  of performance API, so faithful local predicates were required.
- `DimEnergy` is unit-system dependent and does not directly match the source's
  requested scalar joule readouts without additional conversion infrastructure;
  it was therefore not used.
- The `archon` executable advertised for dependency-graph navigation was not
  available on `PATH` (`archon: command not found`). The chapter's
  natural-language-only C.4 policy was followed directly.
- The chapter currently has no `\lean{...}` declaration name. Marker sync or
  the plan/review agent should associate its target environment with
  `IPhO2026Problems.IPhO2026_3_C_5.overallCoefficientOfPerformance`.

## Verification

- LSP diagnostics: only the expected `declaration uses sorry` warning.
- `lake env lean IPhO2026Problems/problem_IPhO_2026_3_C_5.lean`: exit code 0,
  with only the expected `sorry` warning.
... [leading content omitted]
```

### Report excerpt: `physics-grounding-IPhO2026Problems_problem_IPhO_2026_3_C_5.md`
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

## 23. `IPhO2026Problems/problem_IPhO_2026_4_A_1.lean`

- Compile status: passed
- Open sorries: 1
- Direct-check seconds: 18.697
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_4_A_1.tex`
- Reports: `.archon/task_results/IPhO2026Problems_problem_IPhO_2026_4_A_1.lean.md`, `.archon/task_results/physics-grounding-IPhO2026Problems_problem_IPhO_2026_4_A_1.md`

### Lean excerpt
```lean
d uncertainty. -/
structure ScalarEstimate where
  centralValue : ℝ
  uncertainty : ℝ

/-- The reported `0.94 ± 0.02 g`, expressed in kilograms. -/
def officialMassEstimateKilograms : ScalarEstimate :=
  ⟨0.00094, 0.00002⟩

/-- The reported `3.24 mmol` with `0.7 mmol` uncertainty, expressed in moles. -/
def officialAmountEstimateMoles : ScalarEstimate :=
  ⟨0.00324, 0.0007⟩

/-- The reported `(1.95 ± 0.05) · 10²¹` molecules. -/
def officialMoleculeCountEstimate : ScalarEstimate :=
  ⟨1.95 * 10 ^ 21, 0.05 * 10 ^ 21⟩

/-- Whether a scalar readout lies within a stated experimental uncertainty. -/
def WithinEstimate (readout : ℝ) (estimate : ScalarEstimate) : Prop :=
  |readout - estimate.centralValue| ≤ estimate.uncertainty

/-- The proposition represented by the official numerical answer. -/
def MatchesOfficialSample (model : SubstanceCountingModel)
    (setup : IsochoricAirSetup model) : Prop :=
  WithinEstimate (siValue setup.confinedAirCA.mass)
      officialMassEstimateKilograms ∧
    WithinEstimate (model.amountInMoles setup.confinedAirCA.amount)
      officialAmountEstimateMoles ∧
    WithinEstimate (model.moleculeCount setup.confinedAirCA.molecules)
      officialMoleculeCountEstimate

/--
Part A.1: determine the mass, amount of substance, and molecular population of
the confined air column.

The three conclusions solve the governing relations in sequence: first for
`m` from density and Figure 17, then for `n` from the ideal-gas law, and finally
for `N` using the Avogadro conversion.
-/
theorem determineConfinedAirInventory
    (model : SubstanceCountingModel)
    (setup : IsochoricAirSetup model)
    (_readouts : SourceReadouts model setup)
    (_conditions : ExperimentalConditions model setup)
    (_admissible : PhysicalAdmissibility model setup)
    (_laws : GoverningLaws model setup) :
    siValue setup.confinedAirCA.mass =
        siValue setup.ambientAirDensity *
          cylindricalAirVolumeSI setup.geometry ∧
      model.amountInMoles setup.confinedAirCA.amount =
        siValue setup.confinedAirCA.pressure *
            cylindricalAirVolumeSI setup.geometry /
          (setup.universalGasConstantJPerMoleKelvin *
            siValue setup.confinedAirCA.absoluteTemperature) ∧
      model.moleculeCount setup.confinedAirCA.molecules =
        setup.avogadroConstantPerMole *
          (siValue setup.confinedAirCA.pressure *
              cylindricalAirVolumeSI setup.geometry /
            (setup.universalGasConstantJPerMoleKelvin *
              siValue setup.confinedAirCA.absoluteTemperature)) := by
  sorry

end IPhO2026Problems.IPhO2026_4_A_1
... [leading content omitted]
```

### Blueprint excerpt
```tex
linder.  Propylene glycol is introduced to h = 4.5 cm so the air volume is
fixed.  Use the cylinder dimensions in Figure 17, ambient air density
rho\_a = 1.12 kg/m\textasciicircum{}3, and the ideal-gas law P*V = n*R*T.  The outer-cylinder
water bath is heated while pressure and temperature are recorded.

Current subquestion:
Determine the mass m, amount n, and number N of molecules in the confined air column.

\paragraph{Current subquestion.}
Determine the mass m, amount n, and number N of molecules in the confined air column.

\paragraph{Recorded answer/context.}
Official sample: m = 0.94 +/- 0.02 g, n = 3.24 mmol (reported uncertainty 0.7 mmol), N = (1.95 +/- 0.05)e21.

\paragraph{Figure/image path.}
/root/proposal\_for\_physic/science-mango/ipho\_2026\_source/image/E1\_page-9.png

\paragraph{Formalization target.}
create a compiling Lean file with sorry bodies at `IPhO2026Problems/problem\_IPhO\_2026\_4\_A\_1.lean`. The Lean declarations must preserve the physical quantities, dimensions or dimensional roles, figure labels, governing-law hypotheses, and final relation expressed by this problem.
Use Mathlib/Physlib names found through LeanExplore where available. If a physics API is missing, introduce faithful local abstractions rather than scalar placeholder aliases.

\begin{theorem}[Physics formalization target]
\label{thm:physics:IPhO_2026_4_A_1:target}
The assigned autoformalize agent should translate this physics problem into Lean declarations in the covered file, with theorem and lemma proof bodies written as `by sorry`.
\end{theorem}
\begin{proof}
This is an autoformalization task, not a proof task. Produce statements that can later be proved by the physics prover without weakening the physical model.
\end{proof}
% --- Archon physics formalization source end ---
... [leading content omitted]
```

### Report excerpt: `IPhO2026Problems_problem_IPhO_2026_4_A_1.lean.md`
```markdown
modeling rules explicitly permit.

## Grounding gaps

- The only supplied source image, `E1_page-9.png`, contains part A and the
  `h = 4.5 cm`/density text but does not contain Figure 17. Consequently the
  cylinder dimensions remain symbolic; no numerical radius or usable height
  was guessed. Source curation should attach the official page containing
  Figure 17 if a later theorem relating the symbolic solution to
  `MatchesOfficialSample` is desired.
- The recorded values deserve source verification: `n = 3.24 mmol` and
  `N = 1.95·10²¹` agree through Avogadro's constant, while `m = 0.94 g` would
  imply about `0.29 kg/mol`, a factor-of-ten mismatch with ordinary air's
  molar mass. The file faithfully records the chapter's `0.94 g` rather than
  silently correcting it, and keeps this numerical sample out of the
  governing-law theorem.
- The `archon dag-query` helper was unavailable on `PATH` in this prover lane,
  so no dependency-graph declarations were used.

## Verification

- Lean LSP diagnostics: one expected `declaration uses sorry` warning, no
  errors.
- `lake env lean IPhO2026Problems/problem_IPhO_2026_4_A_1.lean`: exit code 0
  with the same single expected warning.
... [leading content omitted]
```

### Report excerpt: `physics-grounding-IPhO2026Problems_problem_IPhO_2026_4_A_1.md`
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

## 24. `IPhO2026Problems/problem_IPhO_2026_4_A_5.lean`

- Compile status: passed
- Open sorries: 1
- Direct-check seconds: 28.628
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_4_A_5.tex`
- Reports: `.archon/task_results/IPhO2026Problems_problem_IPhO_2026_4_A_5.lean.md`, `.archon/task_results/physics-grounding-IPhO2026Problems_problem_IPhO_2026_4_A_5.md`

### Lean excerpt
```lean
itive :
    0 < experiment.universalGasConstantJoulePerMolKelvin
  referencePressurePositive :
    0 < pressurePascal experiment.referenceState
  referenceTemperaturePositive :
    0 < temperatureKelvin experiment.referenceState
  nonzeroTemperatureChange :
    temperatureKelvin experiment.heatedRecordedState -
        temperatureKelvin experiment.initialRecordedState ≠ 0

/-- The measured pressure change `ΔP`, in pascals. -/
noncomputable def pressureChangePascal
    (experiment : IsochoricAirExperiment) : ℝ :=
  pressurePascal experiment.heatedRecordedState -
    pressurePascal experiment.initialRecordedState

/-- The measured absolute-temperature change `ΔT`, in kelvin. -/
noncomputable def temperatureChangeKelvin
    (experiment : IsochoricAirExperiment) : ℝ :=
  temperatureKelvin experiment.heatedRecordedState -
    temperatureKelvin experiment.initialRecordedState

/--
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
  sorry

end IPhO2026Problems.IPhO2026_4_A_5
... [leading content omitted]
```

### Blueprint excerpt
```tex
ta\_0 = (1/P\_0)*(Delta P/Delta T).

\paragraph{Current subquestion.}
Determine the constant-volume thermal pressure coefficient beta\_0 = (1/P\_0)*(Delta P/Delta T).

\paragraph{Recorded answer/context.}
Official sample: beta\_0 = 0.0034 +/- 0.0007 K\textasciicircum{}(-1); ideal-gas reference 1/273.15 K = 0.0037 K\textasciicircum{}(-1).

\paragraph{Figure/image path.}
/root/proposal\_for\_physic/science-mango/ipho\_2026\_source/image/E1\_page-9.png

\paragraph{Reusable previous-part conclusions.}
\begin{itemize}
\item Source A.3. Question: Plot pressure as a function of temperature from A2. Reusable conclusions: The expected isochoric ideal-gas plot is linear: P is proportional to absolute T. Policy: natural\_language\_prerequisite\_only; do\_not\_import\_Lean\_output
\end{itemize}

\paragraph{Formalization target.}
create a compiling Lean file with sorry bodies at `IPhO2026Problems/problem\_IPhO\_2026\_4\_A\_5.lean`. The Lean declarations must preserve the physical quantities, dimensions or dimensional roles, figure labels, governing-law hypotheses, and final relation expressed by this problem.
Use Mathlib/Physlib names found through LeanExplore where available. If a physics API is missing, introduce faithful local abstractions rather than scalar placeholder aliases.

\begin{theorem}[Physics formalization target]
\label{thm:physics:IPhO_2026_4_A_5:target}
The assigned autoformalize agent should translate this physics problem into Lean declarations in the covered file, with theorem and lemma proof bodies written as `by sorry`.
\end{theorem}
\begin{proof}
This is an autoformalization task, not a proof task. Produce statements that can later be proved by the physics prover without weakening the physical model.
\end{proof}
% --- Archon physics formalization source end ---
... [leading content omitted]
```

### Report excerpt: `IPhO2026Problems_problem_IPhO_2026_4_A_5.lean.md`
```markdown
with an explicit
  universal gas constant.
- Amount of substance and the gas constant are explicit scalar SI readouts
  with unit-bearing field names because Physlib's dimension system has no
  amount-of-substance base dimension.
- `PreviousPartA3Linearity` faithfully packages only the natural-language A.3
  result and does not import or depend on an earlier Lean output.

## Grounding gaps

- LeanExplore did not expose a dimensionful molar ideal-gas-law declaration
  compatible with `P V = n R T`; the local predicate above records the exact
  mismatch rather than guessing an API.
- The only authorized source image is page 9. It names the apparatus and gives
  the `4.5 cm` fill height but does not display Figure 17's numerical cylinder
  dimensions. Those quantities are therefore retained symbolically in
  `Figure17Geometry`; no values were invented.
- The `archon` executable was not available on `PATH`, so `dag-query` could not
  be run. The chapter independently specifies that A.3 is a
  natural-language-only prerequisite.

## Verification

`lake env lean IPhO2026Problems/problem_IPhO_2026_4_A_5.lean` exits successfully
with exactly the expected warning that `target` uses `sorry`.
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

## 25. `IPhO2026Problems/problem_IPhO_2026_4_B_4.lean`

- Compile status: passed
- Open sorries: 1
- Direct-check seconds: 20.908
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_4_B_4.tex`
- Reports: `.archon/task_results/IPhO2026Problems_problem_IPhO_2026_4_B_4.lean.md`, `.archon/task_results/physics-grounding-IPhO2026Problems_problem_IPhO_2026_4_B_4.md`

### Lean excerpt
```lean
essureInPascals referenceVaporPressure = 0
  measuredTotalPressure :
    pressureInPascals atmosphericPressure =
      pressureInPascals measuredDryAirPressure +
        pressureInPascals measuredVaporPressure
  dryAirIdealGasInvariant :
    pressureInPascals referenceDryAirPressure *
          volumeInCubicMeters geometry.referenceGasVolume /
        temperatureInKelvin referenceTemperature =
      pressureInPascals measuredDryAirPressure *
          volumeInCubicMeters geometry.measuredGasVolume /
        temperatureInKelvin measuredTemperature

/-- Parameters for the equilibrium vapor-pressure law quoted before part B. -/
structure ClausiusClapeyronData where
  referenceVaporPressure : DimPressure
  molarLatentHeatJPerMol : ℝ
  molarGasConstantJPerMolKelvin : ℝ
  molarLatentHeat_pos : 0 < molarLatentHeatJPerMol
  molarGasConstant_eq : molarGasConstantJPerMolKelvin = 8.31

/-- The Clausius--Clapeyron law from equation (3), kept separate from the B.4
zero-reference-vapor approximation. -/
def SatisfiesClausiusClapeyron
    (data : ClausiusClapeyronData)
    (referenceTemperature measuredTemperature : Temperature)
    (measuredVaporPressure : DimPressure) : Prop :=
  pressureInPascals measuredVaporPressure =
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
  sorry

end

end IPhO2026Problems.IPhO2026_4_B_4
... [leading content omitted]
```

### Blueprint excerpt
```tex
Assuming dry air plus water vapor and zero vapor pressure at T\_0, express P\_v using P\_atm, H\_0, H, T\_0, and T.

\paragraph{Current subquestion.}
Assuming dry air plus water vapor and zero vapor pressure at T\_0, express P\_v using P\_atm, H\_0, H, T\_0, and T.

\paragraph{Recorded answer/context.}
P\_v = P\_atm*[1 - (H\_0*T)/(H*T\_0)].

\paragraph{Figure/image path.}
/root/proposal\_for\_physic/science-mango/ipho\_2026\_source/image/E1\_page-12.png

\paragraph{Reusable previous-part conclusions.}
\begin{itemize}
\item Source B.3. Question: Extrapolate the B2 graph to determine H\_0 at 0 degrees Celsius. Reusable conclusions: Official sample: H\_0 = 5.9 cm, corresponding to V\_0 = 53.4 mL. Policy: natural\_language\_prerequisite\_only; do\_not\_import\_Lean\_output
\end{itemize}

\paragraph{Formalization target.}
create a compiling Lean file with sorry bodies at `IPhO2026Problems/problem\_IPhO\_2026\_4\_B\_4.lean`. The Lean declarations must preserve the physical quantities, dimensions or dimensional roles, figure labels, governing-law hypotheses, and final relation expressed by this problem.
Use Mathlib/Physlib names found through LeanExplore where available. If a physics API is missing, introduce faithful local abstractions rather than scalar placeholder aliases.

\begin{theorem}[Physics formalization target]
\label{thm:physics:IPhO_2026_4_B_4:target}
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
ure decomposition, fixed-dry-air ideal-gas behavior, the cylinder
  geometry, positivity, and the B.4 baseline approximation.
- `ClausiusClapeyronData` and `SatisfiesClausiusClapeyron` preserve equation
  (3) and its dimensional parameter roles without forcing that later-part law
  into the B.4 derivation.

## Grounding gaps

- PhysLean has no searched ready-made `DimLength` or `DimVolume` name.
- `IdealGas.ideal_gas_law` is specialized to a units-free statistical-mechanics
  model and does not expose the two-state experimental gas-sample interface
  needed here.
- PhysLean's `DimPressure` currently lacks same-dimension addition, so partial
  pressure addition is stated on injective SI readouts of the physical
  pressures.
- The blueprint theorem environment has no `\lean{...}` declaration mapping.
  An authorized blueprint phase should add the mapping listed above; this
  prover did not edit the protected blueprint chapter.

## Verification

- `archon-lean-lsp` diagnostics: one expected `declaration uses 'sorry'`
  warning and no errors.
- `lake env lean IPhO2026Problems/problem_IPhO_2026_4_B_4.lean`: successful
  with the same single expected warning.
- `git diff --check`: clean.
... [leading content omitted]
```

### Report excerpt: `physics-grounding-IPhO2026Problems_problem_IPhO_2026_4_B_4.md`
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

## 26. `IPhO2026Problems/problem_IPhO_2026_4_B_6.lean`

- Compile status: passed
- Open sorries: 1
- Direct-check seconds: 28.416
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_4_B_6.tex`
- Reports: `.archon/task_results/IPhO2026Problems_problem_IPhO_2026_4_B_6.lean.md`, `.archon/task_results/physics-grounding-IPhO2026Problems_problem_IPhO_2026_4_B_6.md`

### Lean excerpt
```lean
adout temperature →
      0 < siReadout (experiment.vaporPressurePvAt temperature) →
      0 < siReadout experiment.vaporPressureScalePv0 →
      Real.log
          (siReadout (experiment.vaporPressurePvAt temperature) /
            siReadout experiment.vaporPressureScalePv0) =
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
  sorry

end IPhO2026Problems.IPhO2026_4_B_6
... [leading content omitted]
```

### Blueprint excerpt
```tex
12.

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

\begin{theorem}[Physics formalization target]
\label{thm:physics:IPhO_2026_4_B_6:target}
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
e component. All available
  non-molar quantities use PhysLean's dimension-carrying types.
- `VaporizationExperiment` and its law/data interfaces retain the apparatus
  and thermodynamic roles without defining the requested answer.

## Grounding gaps and redraft requests

- LeanExplore found no ready-made molar mass, molar latent heat, or specific
  latent heat declaration. PhysLean's `Dimension` source confirms that amount
  of substance is not among its five foundational dimensions, necessitating
  the explicitly unit-named molar scalar readouts.
- The advertised `archon dag-query` executable was not available on `PATH`
  (`archon: command not found`), so dependency navigation could not be used.
  The chapter's natural-language-only B.5 policy was followed directly.
- The chapter currently lacks a `\lean{...}` name for its theorem environment;
  associate it with
  `IPhO2026Problems.IPhO2026_4_B_6.latentHeatPerUnitMass_from_molarEstimate`.

## Verification

- Archon Lean LSP diagnostics: only the expected `declaration uses sorry`
  warning at the target theorem.
- `lake env lean IPhO2026Problems/problem_IPhO_2026_4_B_6.lean`: exit code 0,
  with only the expected `sorry` warning.
... [leading content omitted]
```

### Report excerpt: `physics-grounding-IPhO2026Problems_problem_IPhO_2026_4_B_6.md`
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

## 27. `IPhO2026Problems/problem_IPhO_2026_4_C_6.lean`

- Compile status: passed
- Open sorries: 1
- Direct-check seconds: 26.782
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_4_C_6.tex`
- Reports: `.archon/task_results/IPhO2026Problems_problem_IPhO_2026_4_C_6.lean.md`, `.archon/task_results/physics-grounding-IPhO2026Problems_problem_IPhO_2026_4_C_6.md`

### Lean excerpt
```lean
cting apparatus heat capacity,
  `dQ/dt = c₀ m dT_IC/dt`;
* radial Fourier conduction,
  `dQ/dt = -λ A dT/dr`.

These are governing laws, not the C.6 resistance answer.
-/
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
  sorry

end IPhO2026Problems.IPhO2026_4_C_6
... [leading content omitted]
```

### Blueprint excerpt
```tex
termine the effective wall thermal resistance R\_Th from the C5 graph.

\paragraph{Current subquestion.}
Determine the effective wall thermal resistance R\_Th from the C5 graph.

\paragraph{Recorded answer/context.}
R\_Th = 1/(c\_0*m*slope). Official sample: R\_Th = 1.17 +/- 0.03 K/W.

\paragraph{Figure/image path.}
/root/proposal\_for\_physic/science-mango/ipho\_2026\_source/image/E1\_page-13.png

\paragraph{Reusable previous-part conclusions.}
\begin{itemize}
\item Source C.5. Question: Graph the finite-difference rate (T\_IC,j-T\_IC,j-1)/(t\_j-t\_j-1) against the corresponding average T\_OC-T\_IC. Reusable conclusions: The graph is linear, with slope 1/(c\_0*m*R\_Th) under the stated model. Policy: natural\_language\_prerequisite\_only; do\_not\_import\_Lean\_output
\end{itemize}

\paragraph{Formalization target.}
create a compiling Lean file with sorry bodies at `IPhO2026Problems/problem\_IPhO\_2026\_4\_C\_6.lean`. The Lean declarations must preserve the physical quantities, dimensions or dimensional roles, figure labels, governing-law hypotheses, and final relation expressed by this problem.
Use Mathlib/Physlib names found through LeanExplore where available. If a physics API is missing, introduce faithful local abstractions rather than scalar placeholder aliases.

\begin{theorem}[Physics formalization target]
\label{thm:physics:IPhO_2026_4_C_6:target}
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
ite-difference graph
  coordinates, and reported central values/uncertainties.

## Grounding gaps and redraft requests

- LeanExplore returned no ready-made thermal-resistance or radial Fourier
  conduction declaration; faithful dimensioned local abstractions were needed.
- The official source page specified for this task contains the C.5/C.6 text
  and the 10 cm, 15 cm, and 65 °C protocol values, but not Figure 17 itself or
  its numerical `r₁`, `r₂`, `h` dimensions. The model therefore preserves
  these labels abstractly instead of inventing values.
- The chapter contains no `\lean{...}` declaration name. Marker sync or the
  plan/review agent should associate the target environment with
  `IPhO2026Problems.IPhO2026_4_C_6.effectiveWallThermalResistance_from_C5Graph`.
- The advertised `archon` dependency-graph executable was unavailable on
  `PATH` (`archon: command not found`). This caused no dependency ambiguity
  because the chapter explicitly requires the C.5 result only as a
  natural-language prerequisite.

## Verification

- `lake env lean IPhO2026Problems/problem_IPhO_2026_4_C_6.lean` exited 0 with
  only the expected `declaration uses sorry` warning on the target theorem.
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

## 28. `IPhO2026Problems/problem_IPhO_2026_4_C_7.lean`

- Compile status: passed
- Open sorries: 1
- Direct-check seconds: 20.721
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_4_C_7.tex`
- Reports: `.archon/task_results/IPhO2026Problems_problem_IPhO_2026_4_C_7.lean.md`, `.archon/task_results/physics-grounding-IPhO2026Problems_problem_IPhO_2026_4_C_7.md`

### Lean excerpt
```lean
temperature :
    ∀ timeSeconds : ℝ,
      experiment.radialTemperatureKelvin timeSeconds
          (siValue experiment.geometry.outerRadius) =
        siValue (experiment.outerTemperature timeSeconds)
  radial_temperature_has_gradient :
    ∀ (timeSeconds radiusMeters : ℝ),
      radiusMeters ∈ Set.Icc
        (siValue experiment.geometry.innerRadius)
        (siValue experiment.geometry.outerRadius) →
      HasDerivAt
        (experiment.radialTemperatureKelvin timeSeconds)
        (experiment.radialTemperatureGradientKelvinPerMeter
          timeSeconds radiusMeters)
        radiusMeters
  heat_flow_relation :
    ∀ timeSeconds : ℝ,
      siValue (experiment.heatReceivedByInnerCylinder timeSeconds) =
        (siValue (experiment.outerTemperature timeSeconds) -
          siValue (experiment.innerTemperature timeSeconds)) /
        siValue experiment.previousPartC6.effectiveWallThermalResistance
  radial_orientation :
    ∀ timeSeconds : ℝ,
      siValue (experiment.signedOutwardRadialHeatFlow timeSeconds) =
        -siValue (experiment.heatReceivedByInnerCylinder timeSeconds)
  radial_fourier_law :
    ∀ (timeSeconds radiusMeters : ℝ),
      radiusMeters ∈ Set.Icc
        (siValue experiment.geometry.innerRadius)
        (siValue experiment.geometry.outerRadius) →
      siValue (experiment.signedOutwardRadialHeatFlow timeSeconds) =
        -siValue experiment.acrylicConductivity *
          cylindricalWallAreaMetersSquared experiment.geometry radiusMeters *
          experiment.radialTemperatureGradientKelvinPerMeter
            timeSeconds radiusMeters

/--
Combining the measured wall resistance with radial Fourier conduction gives
the acrylic thermal conductivity

`λ = log (r₂ / r₁) / (2 π h R_Th)`.
-/
theorem acrylicConductivity_from_radial_fourier
    (experiment : ThermalConductionExperiment)
    (figureReadout : Figure17AndProcedureReadout experiment.geometry)
    (previousPart : PreviousPartC6Result experiment.previousPartC6)
    (laws : CylindricalConductionLaws experiment)
    (observationTimeSeconds : ℝ)
    (temperatureDifference_nonzero :
      siValue (experiment.outerTemperature observationTimeSeconds) -
          siValue (experiment.innerTemperature observationTimeSeconds) ≠ 0) :
    siValue experiment.acrylicConductivity =
      Real.log
          (siValue experiment.geometry.outerRadius /
            siValue experiment.geometry.innerRadius) /
        (2 * Real.pi * siValue experiment.geometry.activeWallHeight *
          siValue experiment.previousPartC6.effectiveWallThermalResistance) := by
  sorry

end IPhO2026Problems.IPhO2026_4_C_7
... [leading content omitted]
```

### Blueprint excerpt
```tex
relation and radial Fourier law to determine acrylic conductivity lambda.

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

\begin{theorem}[Physics formalization target]
\label{thm:physics:IPhO_2026_4_C_7:target}
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
law. It states the actual
  heat-flow equations, radial geometry, derivative, and boundary conditions,
  not the requested final formula.
- `PreviousPartC6Result` preserves the natural-language prerequisite policy
  while keeping the graph result physically typed.

## Grounding gaps

- No Mathlib/Physlib declaration for cylindrical thermal conduction or
  thermal resistance was found.
- The chapter and its two listed source-page images do not provide numerical
  Figure 17 radius values. Therefore `r₁` and `r₂` are faithfully retained as
  positive ordered figure quantities. A future blueprint redraft should add
  the exact Figure 17 radius readouts if the official numerical
  `0.25 ± 0.01 W/(m*K)` sample is to become a separate formal conclusion.
- `archon dag-query` could not be run because `archon` was not available on
  this prover lane's `PATH`; the chapter's previous-part policy independently
  forbids importing the C.6 Lean output.

## Verification

- `archon-lean-lsp` diagnostics: only the expected declaration-uses-`sorry`
  warning.
- `lake env lean IPhO2026Problems/problem_IPhO_2026_4_C_7.lean`: success with
  the same single expected warning.
- `git diff --check`: clean.
... [leading content omitted]
```

### Report excerpt: `physics-grounding-IPhO2026Problems_problem_IPhO_2026_4_C_7.md`
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
