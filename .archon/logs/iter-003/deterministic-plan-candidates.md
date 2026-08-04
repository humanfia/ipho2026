# Deterministic Plan Candidate Pack

Iteration: 003
Exact objective count: 28

The loop has already selected and written these objectives. Do not scan
the rest of the corpus and do not replace, reorder, add, or remove targets.
Use the excerpts below only to write a concise per-target proof strategy.

## 1. `IPhO2026Problems/problem_IPhO_2026_1_A_1.lean`

- Open placeholders: 1
- Proof Review: new; attempts=0
- Review reason: (none)
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_1_A_1.tex`

### Lean excerpt
```lean
... [prefix omitted]
veWeightSI.val =
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
```

### Blueprint excerpt
```tex
... [prefix omitted]
O_2026_1_A_1.lean
% archon:source-report reports/ipho_2026/problem_IPhO_2026_1_A_1.source.json
% archon:problem-id IPhO_2026_1
% archon:part-id A.1

\chapter{Physics problem IPhO\_2026\_1\_A\_1}
\label{ch:IPhO2026Problems_problem_IPhO_2026_1_A_1}

\paragraph{Problem source.}
Two water reservoirs are separated by a vertical wall MN.  A square slot of
vertical size a*sqrt(2)/2 is sealed by a fully submerged solid cube of side a
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

\begin{definition}[LengthSI]
  \label{decl:physics:IPhO_2026_1_A_1:LengthSI}
  \lean{IPhO2026Problems.IPhO2026_1_A_1.LengthSI}
  A length read in metres.
\end{definition}
\begin{proof}
  This is the defining declaration; unfolding it gives the stated typed data or relation.
\end{proof}

\begin{definition}[AreaSI]
  \label{decl:physics:IPhO_2026_1_A_1:AreaSI}
  \lean{IPhO2026Problems.IPhO2026_1_A_1.AreaSI}
  An area read in square metres.
\end{definition}
\begin{proof}
  This is the defining declaration; unfolding it gives the stated typed data or relation.
\end{proof}

\begin{definition}[VolumeSI]
  \label{decl:physics:IPhO_2026_1_A_1:VolumeSI}
  \lean{IPhO2026Problems.IPhO2026_1_A_1.VolumeSI}
  A volume read in cubic metres.
\end{definition}
\begin{proof}
  This is the defining declaration; unfolding it gives
... [suffix omitted]
```

## 2. `IPhO2026Problems/problem_IPhO_2026_1_B_1.lean`

- Open placeholders: 5
- Proof Review: new; attempts=0
- Review reason: (none)
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_1_B_1.tex`

### Lean excerpt
```lean
... [prefix omitted]
it.totalAngularMomentumMagnitude
  initial_total_angular_momentum :
    scalarInSI orbit.totalAngularMomentumMagnitude =
      scalarInSI initial.positronAngularMomentumMagnitude +
        scalarInSI initial.electronAngularMomentumMagnitude
  eccentricity_law :
    orbit.eccentricity =
      Real.sqrt
        (1 +
          4 * scalarInSI orbit.totalAngularMomentumMagnitude ^ 2 *
              scalarInSI orbit.totalEnergy /
            (scalarInSI constants.coulombConstant ^ 2 *
              scalarInSI constants.elementaryChargeMagnitude ^ 4 *
              scalarInSI constants.mass))
  conic_parameter_law :
    scalarInSI orbit.conicParameter =
      2 * scalarInSI orbit.totalAngularMomentumMagnitude ^ 2 /
        (scalarInSI constants.mass *
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
    (constants : Phy
... [suffix omitted]
```

### Blueprint excerpt
```tex
... [prefix omitted]
hon:source-report reports/ipho_2026/problem_IPhO_2026_1_B_1.source.json
% archon:problem-id IPhO_2026_1
% archon:part-id B.1

\chapter{Physics problem IPhO\_2026\_1\_B\_1}
\label{ch:IPhO2026Problems_problem_IPhO_2026_1_B_1}

\paragraph{Problem source.}
At one instant a positron and an electron, each of mass m and charges of equal
magnitude and opposite sign, are separated by 100*a\_0.  Their velocities are
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

\begin{definition}[Space]
  \label{decl:physics:IPhO_2026_1_B_1:Space}
  \lean{IPhO2026Problems.IPhO2026_1_B_1.Space}
  Three-dimensional Euclidean space used for the Figure 1b geometry.
\end{definition}
\begin{proof}
  This is the defining declaration; unfolding it gives the stated typed data or relation.
\end{proof}

\begin{definition}[ScalarQuantity]
  \label{decl:physics:IPhO_2026_1_B_1:ScalarQuantity}
  \lean{IPhO2026Problems.IPhO2026_1_B_1.ScalarQuantity}
  A unit-independent scalar physical quantity of dimension “d”.
\end{definition}
\begin{proof}
  This is the defining declaration; unfolding it gives the stated typed data or relation.
\end{proof}

\begin{definition}[VectorQuantity]
  \label{decl:physics:IPhO_2026_1_B_1:VectorQuantity}
  \lean{IPhO2026Problems.IPhO2026_1_B_1.VectorQuantity}
  \uses{decl:
... [suffix omitted]
```

## 3. `IPhO2026Problems/problem_IPhO_2026_1_B_2.lean`

- Open placeholders: 1
- Proof Review: new; attempts=0
- Review reason: (none)
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_1_B_2.tex`

### Lean excerpt
```lean
... [prefix omitted]
nedDeflectionDegrees
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

## 4. `IPhO2026Problems/problem_IPhO_2026_1_C_1.lean`

- Open placeholders: 1
- Proof Review: new; attempts=0
- Review reason: (none)
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_1_C_1.tex`

### Lean excerpt
```lean
... [prefix omitted]
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
                2 * energyDifferenceSI p /
                    (3 * oxygenAtomMassSI p * (lightSpeedSI p) ^ 2) *
                  (2 * (Real.sin θ) ^ 2 + 1)))) /
          (reducedPlanckConstantSI p * (2 * (Real.sin θ) ^ 2 + 1))) ∧
    (Real.pi / 2 ≤ θ →
      scalarSI ωmin =
        (oxygenAtomMassSI p * (lightSpeedSI p) ^ 2 *
            (1 - Real.sqrt
              (1 -
                2 * energyDifferenceSI p /
                  (oxygenAtomMassSI p * (lightSpeedSI p) ^ 2)))) /
          reducedPlanckConstantSI p) := by
  sorry

end IPhO2026Problems.IPhO2026_1_C_1
```

### Blueprint excerpt
```tex
... [prefix omitted]
urrent subquestion:
Determine the minimum angular frequency omega\_min required for dissociation at outgoing O2 angle theta, in terms of hbar, c, theta, Delta U, and m.

\paragraph{Current subquestion.}
Determine the minimum angular frequency omega\_min required for dissociation at outgoing O2 angle theta, in terms of hbar, c, theta, Delta U, and m.

\paragraph{Recorded answer/context.}
The source-report transcription omits a factor \(2\) under the square root.
The conservation laws instead give, for \(A=2\sin^2\theta+1\) and
\(\theta\leq\pi/2\),
\[
\omega_{\min}=\frac{3mc^2}{\hbar A}
  \left(1-\sqrt{1-\frac{2A\Delta U}{3mc^2}}\right).
\]
For \(\theta\geq\pi/2\), use the constrained value at \(\theta=\pi/2\):
\[
\omega_{\min}=\frac{mc^2}{\hbar}
  \left(1-\sqrt{1-\frac{2\Delta U}{mc^2}}\right).
\]

\paragraph{Figure/image path.}
/root/proposal\_for\_physic/science-mango/ipho\_2026\_source/image/T1\_page-3.png

\paragraph{Formalization target.}
Redraft the existing compiling scaffold so its conclusion contains the corrected
factor \(2\), while preserving the dimensioned masses, energy gap, action,
frequency, momenta, Figure 1c angle, conservation laws, feasibility predicate,
and minimum-frequency meaning.  Leave proof bodies as `by sorry`.

\begin{definition}[MassQuantity]
  \label{decl:physics:IPhO_2026_1_C_1:MassQuantity}
  \lean{IPhO2026Problems.IPhO2026_1_C_1.MassQuantity}
  The dimensionful mass of one oxygen atom.
\end{definition}
\begin{proof}
  This is the defining declaration; unfolding it gives the stated typed data or relation.
\end{proof}

\begin{definition}[ActionQuantity]
  \label{decl:physics:IPhO_2026_1_C_1:ActionQuantity}
  \lean{IPhO2026Problems.IPhO2026_1_C_1.ActionQuantity}
  A dimensionful action, used for the reduced Planck constant.
\end{definition}
\begin{proof}
  This is the defining declaration; unfolding it gives the stated typed data or relation.
\end{proof}

\begin{definition}[AngularFrequencyQuantity]
  \label{decl:physics:IPhO_2026_1_C_1:AngularFrequencyQuantity}
  \lean{IPhO2026Problems.IPhO2026_1_C_1.AngularFrequencyQuantity}
  A dimensionful angular frequency.
\end{definition}
\begin{proof}
  This is the defining declaration; unfolding it gives the stated typed data or relation.
\end{proof}

\begin{definition}[MomentumQuantity2]
  \label{decl:physics:IPhO_2026_1_C_1:MomentumQuantity2}
  \lean{IPhO2026Problems.IPhO2026_1_C_1.MomentumQuantity2}
  A dimensionful two-dimensional momentum used for Figure 1c.
\end{definition}
\beg
... [suffix omitted]
```

## 5. `IPhO2026Problems/problem_IPhO_2026_1_C_2.lean`

- Open placeholders: 1
- Proof Review: new; attempts=0
- Review reason: (none)
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_1_C_2.tex`

### Lean excerpt
```lean
... [prefix omitted]
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
```

### Blueprint excerpt
```tex
... [prefix omitted]
ygen fragments classically and
non-relativistically, take the mass of an oxygen atom to be m, and use photon
momentum p\_gamma = E\_gamma/c = hbar*omega/c.

Current subquestion:
For theta = pi/6, Delta U = 1.10 eV, and m = 16.0 amu, calculate hbar*omega\_min - Delta U in eV.

\paragraph{Current subquestion.}
For theta = pi/6, Delta U = 1.10 eV, and m = 16.0 amu, calculate hbar*omega\_min - Delta U in eV.

\paragraph{Recorded answer/context.}
hbar*omega\_min - Delta U = 2.03e-11 eV.

\paragraph{Figure/image path.}
/root/proposal\_for\_physic/science-mango/ipho\_2026\_source/image/T1\_page-3.png

\paragraph{Reusable previous-part conclusions.}
\begin{itemize}
\item Source C.1, corrected by conservation-law consistency: for
  \(A=2\sin^2\theta+1\) and \(\theta\leq\pi/2\),
  \(\omega_{\min}=3mc^2(1-\sqrt{1-2A\Delta U/(3mc^2)})/(\hbar A)\).
  Policy: natural\_language\_prerequisite\_only; do\_not\_import\_Lean\_output.
\end{itemize}

\paragraph{Formalization target.}
Redraft the existing scaffold so its quoted C.1 prerequisite uses the corrected
factor \(2\).  Preserve the dimensioned constants and momenta, the threshold
meaning, the specified angle, energy and mass data, and the explicit rounding
tolerance.  Leave proof bodies as `by sorry`.

\begin{definition}[DimMass]
  \label{decl:physics:IPhO_2026_1_C_2:DimMass}
  \lean{IPhO2026Problems.IPhO2026_1_C_2.DimMass}
  A mass with no preferred system of units.
\end{definition}
\begin{proof}
  This is the defining declaration; unfolding it gives the stated typed data or relation.
\end{proof}

\begin{definition}[AngularFrequency]
  \label{decl:physics:IPhO_2026_1_C_2:AngularFrequency}
  \lean{IPhO2026Problems.IPhO2026_1_C_2.AngularFrequency}
  An angular frequency, with physical dimension “T⁻¹”, and no preferred system of units.
\end{definition}
\begin{proof}
  This is the defining declaration; unfolding it gives the stated typed data or relation.
\end{proof}

\begin{definition}[DimAction]
  \label{decl:physics:IPhO_2026_1_C_2:DimAction}
  \lean{IPhO2026Problems.IPhO2026_1_C_2.DimAction}
  An action, with physical dimension “M L² T⁻¹”, and no preferred system of units.
\end{definition}
\begin{proof}
  This is the defining declaration; unfolding it gives the stated typed data or relation.
\end{proof}

\begin{definition}[atomicMassUnit]
  \label{decl:physics:IPhO_2026_1_C_2:atomicMassUnit}
  \lean{IPhO2026Problems.IPhO2026_1_C_2.atomicMassUnit}
  \uses{decl:physics:IPhO_2026_1_C_2:DimMass}
  One unified atomic mass u
... [suffix omitted]
```

## 6. `IPhO2026Problems/problem_IPhO_2026_2_A_1.lean`

- Open placeholders: 1
- Proof Review: new; attempts=0
- Review reason: (none)
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_2_A_1.tex`

### Lean excerpt
```lean
... [prefix omitted]
tingGeometry
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
  sorry

end IPhO2026Problems.IPhO2026_2_A_1
```

### Blueprint excerpt
```tex
... [prefix omitted]
hO_2026_2_A_1}

\paragraph{Problem source.}
Parallel rays strike the inside of a half-cylindrical mirror of radius R.  For
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
Redraft the existing scaffold under an explicit Physlib/PhysLean import.  The
mirror radius and threshold are physical lengths with a named projection to the
single coordinate unit used by the Euclidean cross-section; angles remain
dimensionless.  Preserve Figures 2c--2e, specular reflection, the threshold
meaning and limiting-ray relation.  Leave proof bodies as `by sorry`.

\begin{definition}[CrossSectionPoint]
  \label{decl:physics:IPhO_2026_2_A_1:CrossSectionPoint}
  \lean{IPhO2026Problems.IPhO2026_2_A_1.CrossSectionPoint}
  The Euclidean cross-section perpendicular to the cylinder axis.
\end{definition}
\begin{proof}
  This is the defining declaration; unfolding it gives the stated typed data or relation.
\end{proof}

\begin{definition}[FigureLabel]
  \label{decl:physics:IPhO_2026_2_A_1:FigureLabel}
  \lean{IPhO2026Problems.IPhO2026_2_A_1.FigureLabel}
  The official figure labels used to read the mirror and limiting-ray geometry.
\end{definition}
\begin{proof}
  This is the defining declaration; unfolding it gives the stated typed data or relation.
\end{proof}

\begin{definition}[HalfCylindricalMirror]
  \label{decl:physics:IPhO_2026_2_A_1:HalfCylindricalMirror}
  \lean{IPhO2026Problems.IPhO2026_2_A_1.HalfCylindricalMirror}
  \uses{decl:physics:IPhO_2026_2_A_1:CrossSectionPoint}
  A half-cylindrical mirror, represented by its semicircular cross-section.
\end{definition}
\begin{proof}
  This is the defining declaration; unfolding it gives the stated typed data or relation.
\end{proof}

\begin{definition}[OnReflectingArc]
  \label{decl:physics:IPhO_2026_2_A_1:OnReflectingArc}
  \lean{IPhO20
... [suffix omitted]
```

## 7. `IPhO2026Problems/problem_IPhO_2026_2_B_1.lean`

- Open placeholders: 2
- Proof Review: new; attempts=0
- Review reason: (none)
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_2_B_1.tex`

### Lean excerpt
```lean
... [prefix omitted]
Container path →
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

## 8. `IPhO2026Problems/problem_IPhO_2026_2_B_2.lean`

- Open placeholders: 1
- Proof Review: new; attempts=0
- Review reason: (none)
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_2_B_2.tex`

### Lean excerpt
```lean
... [prefix omitted]
lluminated projected area.

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
```

### Blueprint excerpt
```tex
... [prefix omitted]
al mirror of radius R illuminates a fully absorbing cylindrical
container of radius a.  Their axes are parallel, and the container center lies
R/2 from the mirror center on the symmetry plane.  Uniform parallel sunlight
arrives along the optical axis.  Any ray absorbed by the container reflects at
most once.  Let theta\_max be the largest incidence angle on the mirror among
rays that strike the container, and let P\_0 be the power the cylinder would
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

\begin{definition}[LengthQuantity]
  \label{decl:physics:IPhO_2026_2_B_2:LengthQuantity}
  \lean{IPhO2026Problems.IPhO2026_2_B_2.LengthQuantity}
  A real-valued length in a common coherent system of units.
\end{definition}
\begin{proof}
  This is the defining declaration; unfolding it gives the stated typed data or relation.
\end{proof}

\begin{definition}[powerDimension]
  \label{decl:physics:IPhO_2026_2_B_2:powerDimension}
  \lean{IPhO2026Problems.IPhO2026_2_B_2.powerDimension}
  The physical dimension “mass * length\textasciicircum{}2 / time\textasciicircum{}3” of power.
\end{definition}
\begin{proof}
  This is the defining declaration; unfolding it gives the stated typed data or relation.
\end{proof}

\begin{definition}[PowerQuantity]
  \label{decl:physics:IPhO_2026_2_B_2:PowerQuantity}
  \lean{IPhO2026Prob
... [suffix omitted]
```

## 9. `IPhO2026Problems/problem_IPhO_2026_2_B_3.lean`

- Open placeholders: 1
- Proof Review: new; attempts=0
- Review reason: (none)
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_2_B_3.tex`

### Lean excerpt
```lean
... [prefix omitted]
setup.mirror.axis setup.container.axis)
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
```

### Blueprint excerpt
```tex
... [prefix omitted]
is.  Any ray absorbed by the container reflects at
most once.  Let theta\_max be the largest incidence angle on the mirror among
rays that strike the container, and let P\_0 be the power the cylinder would
receive without the mirror.  See Figure 2f.

Current subquestion:
For R = 1.0 m, find a such that P = 5*P\_0, and report it in cm.

\paragraph{Current subquestion.}
For R = 1.0 m, find a such that P = 5*P\_0, and report it in cm.

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

\begin{definition}[PhysicalLength]
  \label{decl:physics:IPhO_2026_2_B_3:PhysicalLength}
  \lean{IPhO2026Problems.IPhO2026_2_B_3.PhysicalLength}
  A physical length, represented independently of the choice of units.
\end{definition}
\begin{proof}
  This is the defining declaration; unfolding it gives the stated typed data or relation.
\end{proof}

\begin{definition}[OpticalPower]
  \label{decl:physics:IPhO_2026_2_B_3:OpticalPower}
  \lean{IPhO2026Problems.IPhO2026_2_B_3.OpticalPower}
  A physical power.
\end{definition}
\begin{proof}
  This is the defining declaration; unfolding it gives the stated typed data or relation.
\end{proof}

\begin{definition}[centimeterUnits]
  \label{decl:physics:IPhO_2026_2_B_3:centimeterUnits}
  \lean{IPhO2026Problems.IPhO2026_2_B_3.centimeterUnits}
  Unit choices obtained from SI
... [suffix omitted]
```

## 10. `IPhO2026Problems/problem_IPhO_2026_2_C_1.lean`

- Open placeholders: 1
- Proof Review: new; attempts=0
- Review reason: (none)
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_2_C_1.tex`

### Lean excerpt
```lean
... [prefix omitted]
- incidentDirection

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
```

### Blueprint excerpt
```tex
... [prefix omitted]
ormalization source begin ---
% archon:physics
% archon:covers IPhO2026Problems/problem_IPhO_2026_2_C_1.lean
% archon:source-report reports/ipho_2026/problem_IPhO_2026_2_C_1.source.json
% archon:problem-id IPhO_2026_2
% archon:part-id C.1

\chapter{Physics problem IPhO\_2026\_2\_C\_1}
\label{ch:IPhO2026Problems_problem_IPhO_2026_2_C_1}

\paragraph{Problem source.}
For the half-cylindrical mirror of radius R, ray A is incident at angle theta
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

\begin{definition}[PlanePoint]
  \label{decl:physics:IPhO_2026_2_C_1:PlanePoint}
  \lean{IPhO2026Problems.IPhO2026_2_C_1.PlanePoint}
  A point in the Cartesian coordinate convention of Figure 2g.
\end{definition}
\begin{proof}
  This is the defining declaration; unfolding it gives the stated typed data or relation.
\end{proof}

\begin{definition}[HalfCylindricalMirror]
  \label{decl:physics:IPhO_2026_2_C_1:HalfCylindricalMirror}
  \lean{IPhO2026Problems.IPhO2026_2_C_1.HalfCylindricalMirror}
  The half-cylindrical mirror in Figure 2g, represented by the radius of its upper semicircular cross-section.
\end{definition}
\begin{proof}
  This is the defining declaration; unfolding it gives the stated typed data or relation.
\end{proof}

\begin{definition}[SlopeInterceptRay]
  \label{decl:physics:IPhO_2026_2_C_1:Slope
... [suffix omitted]
```

## 11. `IPhO2026Problems/problem_IPhO_2026_2_C_2.lean`

- Open placeholders: 3
- Proof Review: new; attempts=0
- Review reason: (none)
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_2_C_2.tex`

### Lean excerpt
```lean
... [prefix omitted]
ngle. It is
the exact relation to be Taylor-expanded; it does not assert either requested
first-order expansion. -/
def HalfCylindricalReflectionLaw (setup : Figure2gSetup) : Prop :=
  ∀ angleRad : ℝ, 0 < angleRad → angleRad < Real.pi / 2 →
    (setup.reflectedRayReadoutAt angleRad).slope = Real.cot (2 * angleRad) ∧
    figure2gLengthReadout setup.coordinateUnits
        (setup.reflectedRayReadoutAt angleRad).intercept =
      figure2gLengthReadout setup.coordinateUnits setup.radius /
        (2 * Real.cos angleRad)

/-- The reusable result of part C.1 for the line of ray `A`. -/
def PreviousPartC1Result (setup : Figure2gSetup) : Prop :=
  (rayA setup).slope = Real.cot (2 * setup.incidenceAngleRad) ∧
  figure2gLengthReadout setup.coordinateUnits (rayA setup).intercept =
    figure2gLengthReadout setup.coordinateUnits setup.radius /
      (2 * Real.cos setup.incidenceAngleRad)

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
        figure2gLengthReadout setup.coordinateUnits
            (rayB setup angularIncrementRad).intercept -
          (figure2gLengthReadout setup.coordinateUnits setup.radius /
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
          figure2gLengthReadout setup.co
... [suffix omitted]
```

### Blueprint excerpt
```tex
... [prefix omitted]
hboring
rays forms the caustic.  Use Figure 2g and its coordinate convention.

Current subquestion:
Expand m\_B and b\_B to first order in Delta theta.

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
Redraft the existing scaffold under an explicit Physlib/PhysLean import.  Store
the mirror radius and intercept as physical lengths with a named projection to
the common Figure 2g coordinate unit; keep slopes and angles dimensionless.
Retain the filter-local \(O(\Delta\theta^2)\) contracts.  Leave proof bodies as
`by sorry`.

\begin{definition}[ReflectedRayReadout]
  \label{decl:physics:IPhO_2026_2_C_2:ReflectedRayReadout}
  \lean{IPhO2026_2_C_2.ReflectedRayReadout}
  The scalar data of a reflected ray in the coordinate convention of Figure 2g.
\end{definition}
\begin{proof}
  This is the defining declaration; unfolding it gives the stated typed data or relation.
\end{proof}

\begin{definition}[ReflectedRayReadout.yCoordinateLengthReadout]
  \label{decl:physics:IPhO_2026_2_C_2:ReflectedRayReadout:yCoordinateLengthReadout}
  \lean{IPhO2026_2_C_2.ReflectedRayReadout.yCoordinateLengthReadout}
  \uses{decl:physics:IPhO_2026_2_C_2:ReflectedRayReadout}
  The equation “y = m * x + b” used for the reflected rays in Figure 2g.
\end{definition}
\begin{proof}
  This is the defining declaration; unfolding it gives the stated typed data or relation.
\end{proof}

\begin{definition}[Figure2gSetup]
  \label{decl:physics:IPhO_2026_2_C_2:Figure2gSetup}
  \lean{IPhO2026_2_C_2.Figure2gSetup}
  \uses{decl:physics:IPhO_2026_2_C_2:ReflectedRayReadout}
  Physical and figure data for the half-cylindrical mirror.
\end{definition}
\begin{proof}
  This is the defining declaration; unfolding it gives the stated typed data or relation.
\end{proof}

\begin{definition}[rayA]
... [suffix omitted]
```

## 12. `IPhO2026Problems/problem_IPhO_2026_2_C_3.lean`

- Open placeholders: 1
- Proof Review: new; attempts=0
- Review reason: (none)
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_2_C_3.tex`

### Lean excerpt
```lean
... [prefix omitted]
eAngle θ).slopeRatio =
        Real.cot (2 * θ))
    (hRayA_intercept :
      lengthProjection.readout
          (reflectedRayAtIncidenceAngle θ).yIntercept =
        lengthProjection.readout mirror.radius / (2 * Real.cos θ))
    (hRayB_slope_firstOrder :
      (fun Δθ : ℝ ↦
          (reflectedRayAtIncidenceAngle (θ + Δθ)).slopeRatio -
            (Real.cot (2 * θ) -
              2 * (Real.sin (2 * θ))⁻¹ ^ 2 * Δθ))
        =O[𝓝 0] (fun Δθ : ℝ ↦ Δθ ^ 2))
    (hRayB_intercept_firstOrder :
      (fun Δθ : ℝ ↦
          lengthProjection.readout
              (reflectedRayAtIncidenceAngle (θ + Δθ)).yIntercept -
            ((lengthProjection.readout mirror.radius /
                (2 * Real.cos θ)) *
              (1 + Real.tan θ * Δθ)))
        =O[𝓝 0] (fun Δθ : ℝ ↦ Δθ ^ 2))
    (hNeighboringIntersection :
      ∀ᶠ Δθ in 𝓝[≠] (0 : ℝ),
        IsNeighboringReflectedIntersection
          lengthProjection reflectedRayAtIncidenceAngle
          θ Δθ (neighboringIntersection Δθ)) :
    Tendsto
        (fun Δθ ↦
          lengthProjection.readout
            (neighboringIntersection Δθ).xCoordinate)
        (𝓝[≠] (0 : ℝ))
        (𝓝
          (lengthProjection.readout mirror.radius *
            (Real.sin θ) ^ 3)) ∧
      Tendsto
        (fun Δθ ↦
          lengthProjection.readout
            (neighboringIntersection Δθ).yCoordinate)
        (𝓝[≠] (0 : ℝ))
        (𝓝
          ((lengthProjection.readout mirror.radius / 2) * Real.cos θ *
            (2 - Real.cos (2 * θ)))) := by
  sorry

end IPhO2026Problems.IPhO2026_2_C_3
```

### Blueprint excerpt
```tex
... [prefix omitted]
context.}
X\_c = R*sin(theta)\textasciicircum{}3; Y\_c = (R/2)*cos(theta)*(2 - cos(2*theta)).

\paragraph{Figure/image path.}
/root/proposal\_for\_physic/science-mango/ipho\_2026\_source/image/T2\_page-4.png

\paragraph{Reusable previous-part conclusions.}
\begin{itemize}
\item Source C.1. Question: Write the slope m\_A and intercept b\_A of reflected ray A in terms of theta and R. Reusable conclusions: m\_A = cot(2*theta), and b\_A = R/(2*cos(theta)). Policy: natural\_language\_prerequisite\_only; do\_not\_import\_Lean\_output
\item Source C.2. Question: Expand m\_B and b\_B to first order in Delta theta. Reusable conclusions: m\_B = cot(2*theta) - 2*csc(2*theta)\textasciicircum{}2*Delta theta; b\_B = [R/(2*cos(theta))]*(1 + tan(theta)*Delta theta), up to O(Delta theta\textasciicircum{}2). Policy: natural\_language\_prerequisite\_only; do\_not\_import\_Lean\_output
\end{itemize}

\paragraph{Formalization target.}
Redraft the existing scaffold under an explicit Physlib/PhysLean import.  The
mirror radius, point coordinates and ray intercepts are physical lengths with a
named projection to the common Figure 2g coordinate unit.  Keep the neighboring
intersection and punctured-neighborhood limit structure.  Leave proof bodies as
`by sorry`.

\begin{definition}[Figure2gMirror]
  \label{decl:physics:IPhO_2026_2_C_3:Figure2gMirror}
  \lean{IPhO2026Problems.IPhO2026_2_C_3.Figure2gMirror}
  The half-cylindrical mirror in the coordinate system of Figure 2g.
\end{definition}
\begin{proof}
  This is the defining declaration; unfolding it gives the stated typed data or relation.
\end{proof}

\begin{definition}[Figure2gPoint]
  \label{decl:physics:IPhO_2026_2_C_3:Figure2gPoint}
  \lean{IPhO2026Problems.IPhO2026_2_C_3.Figure2gPoint}
  A point represented by its two Figure 2g coordinate readouts.
\end{definition}
\begin{proof}
  This is the defining declaration; unfolding it gives the stated typed data or relation.
\end{proof}

\begin{definition}[Figure2gMirror.OnReflectingSurface]
  \label{decl:physics:IPhO_2026_2_C_3:Figure2gMirror:OnReflectingSurface}
  \lean{IPhO2026Problems.IPhO2026_2_C_3.Figure2gMirror.OnReflectingSurface}
  \uses{decl:physics:IPhO_2026_2_C_3:Figure2gMirror, decl:physics:IPhO_2026_2_C_3:Figure2gPoint}
  The reflecting upper semicircle shown in Figure 2g.
\end{definition}
\begin{proof}
  This is the defining declaration; unfolding it gives the stated typed data or relation.
\end{proof}

\begin{definition}[ReflectedRayLine]
  \label{decl:physics:IPhO
... [suffix omitted]
```

## 13. `IPhO2026Problems/problem_IPhO_2026_2_C_4.lean`

- Open placeholders: 1
- Proof Review: new; attempts=0
- Review reason: (none)
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_2_C_4.tex`

### Lean excerpt
```lean
... [prefix omitted]
n Δθ => neighboringIntersectionX system θ Δθ)
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
```

### Blueprint excerpt
```tex
... [prefix omitted]
_A*x + b\_A.  A neighboring parallel ray B is
incident at theta + Delta theta, with Delta theta much smaller than theta, and
its reflected line is y = m\_B*x + b\_B.  The envelope/intersection of neighboring
rays forms the caustic.  Use Figure 2g and its coordinate convention.

Current subquestion:
For theta << 1, put the caustic in the form Y\_c = v*|X\_c|\textasciicircum{}(p/q) + u. Determine u, v, and the integers p,q.

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

\begin{definition}[LengthReading]
  \label{decl:physics:IPhO_2026_2_C_4:LengthReading}
  \lean{IPhO2026Problems.IPhO2026_2_C_4.LengthReading}
  A scalar reading of a physical length.
\end{definition}
\begin{proof}
  This is the defining declaration; unfolding it gives the stated typed data or relation.
\end{proof}

\begin{definition}[CubeRootLengthReading]
  \label{decl:physics:IPhO_2026_2_C_4:CubeRootLengthReading}
  \lean{IPhO2026Problems.IPhO2026_2_C_4.CubeRootLengthReading}
  The dimension of the coefficient multiplying a length to the power “2 / 3”.
\end{definition}
\begin{proof}
  This is the defining declaration; unfolding it gives the stated typed data or relation.
\end{proof}

\begin{definition}[ReflectedLineReadout]
  \label{decl:physics:IPhO_2026_2_C_4:ReflectedLineReadout}
  \lean{IPhO2026Problems.I
... [suffix omitted]
```

## 14. `IPhO2026Problems/problem_IPhO_2026_3_A_1.lean`

- Open placeholders: 1
- Proof Review: new; attempts=0
- Review reason: (none)
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_3_A_1.tex`

### Lean excerpt
```lean
... [prefix omitted]
eldCirculation =
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
```

### Blueprint excerpt
```tex
... [prefix omitted]
rchon physics formalization source begin ---
% archon:physics
% archon:covers IPhO2026Problems/problem_IPhO_2026_3_A_1.lean
% archon:source-report reports/ipho_2026/problem_IPhO_2026_3_A_1.source.json
% archon:problem-id IPhO_2026_3
% archon:part-id A.1

\chapter{Physics problem IPhO\_2026\_3\_A\_1}
\label{ch:IPhO2026Problems_problem_IPhO_2026_3_A_1}

\paragraph{Problem source.}
A homogeneous isotropic paramagnetic torus has mean radius R, inner radius r
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

\begin{definition}[electricCurrentDimension]
  \label{decl:physics:IPhO_2026_3_A_1:electricCurrentDimension}
  \lean{IPhO2026Problems.IPhO2026_3_A_1.electricCurrentDimension}
  The dimension of electric current, charge divided by time.
\end{definition}
\begin{proof}
  This is the defining declaration; unfolding it gives the stated typed data or relation.
\end{proof}

\begin{definition}[magneticFieldStrengthDimension]
  \label{decl:physics:IPhO_2026_3_A_1:magneticFieldStrengthDimension}
  \lean{IPhO2026Problems.IPhO2026_3_A_1.magneticFieldStrengthDimension}
  \uses{decl:physics:IPhO_2026_3_A_1:electricCurrentDimension}
  The dimension of magnetic field strength “H”, electric current per length.
\end{definition}
\begin{proof}
  This is the defining declaration; unfolding it gives the stated typed data or relation
... [suffix omitted]
```

## 15. `IPhO2026Problems/problem_IPhO_2026_3_A_2.lean`

- Open placeholders: 1
- Proof Review: new; attempts=0
- Review reason: (none)
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_3_A_2.tex`

### Lean excerpt
```lean
... [prefix omitted]
by the problem's sign convention.
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
```

### Blueprint excerpt
```tex
... [prefix omitted]
oblems_problem_IPhO_2026_3_A_2}

\paragraph{Problem source.}
A homogeneous isotropic paramagnetic torus has mean radius R, inner radius r
with r << R, volume V, and cross-sectional area A.  An insulated conducting
wire is wound densely around it with N turns and instantaneous current I.
Fields H and B and magnetization M are approximately uniform in the torus.
Use B = mu\_0*H + mu\_0*M, Ampere's law, and the sign convention that work and
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

\begin{definition}[DimLengthMagnitude]
  \label{decl:physics:IPhO_2026_3_A_2:DimLengthMagnitude}
  \lean{IPhO2026Problems.IPhO2026_3_A_2.DimLengthMagnitude}
  A nonnegative length magnitude, used for the radii shown in Fig.
\end{definition}
\begin{proof}
  This is the defining declaration; unfolding it gives the stated typed data or relation.
\end{proof}

\begin{definition}[DimVolumeMagnitude]
  \label{decl:physics:IPhO_2026_3_A_2:DimVolumeMagnitude}
  \lean{IPhO2026Problems.IPhO2026_3_A_2.DimVolumeMagnitude}
  A nonnegative volume magnitude.
\end{definition}
\begin{proof}
  This is the defining declaration; unfolding it gives the stated typed data or relation.
\end{proof}

\begin{definition}[DimElectricCurrent]
  \label{decl:physics:IPhO_2026_3_A_2:DimElectricCurrent}
  \lean{IPhO2026Problems.IPhO2026_3_A_2.Di
... [suffix omitted]
```

## 16. `IPhO2026Problems/problem_IPhO_2026_3_A_3.lean`

- Open placeholders: 1
- Proof Review: new; attempts=0
- Review reason: (none)
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_3_A_3.tex`

### Lean excerpt
```lean
... [prefix omitted]
th_dH_A_per_m
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
```

### Blueprint excerpt
```tex
... [prefix omitted]
graph{Problem source.}
A homogeneous isotropic paramagnetic torus has mean radius R, inner radius r
with r << R, volume V, and cross-sectional area A.  An insulated conducting
wire is wound densely around it with N turns and instantaneous current I.
Fields H and B and magnetization M are approximately uniform in the torus.
Use B = mu\_0*H + mu\_0*M, Ampere's law, and the sign convention that work and
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

\begin{definition}[ScaleSeparation]
  \label{decl:physics:IPhO_2026_3_A_3:ScaleSeparation}
  \lean{IPhO2026Problems.IPhO2026_3_A_3.ScaleSeparation}
  A dimensionless small-parameter witness for the approximation “small ≪ large”.
\end{definition}
\begin{proof}
  This is the defining declaration; unfolding it gives the stated typed data or relation.
\end{proof}

\begin{definition}[ParamagneticToroid]
  \label{decl:physics:IPhO_2026_3_A_3:ParamagneticToroid}
  \lean{IPhO2026Problems.IPhO2026_3_A_3.ParamagneticToroid}
  \uses{decl:physics:IPhO_2026_3_A_3:ScaleSeparation}
  The homogeneous isotropic paramagnetic torus shown in Fig.
\end{definition}
\begin{proof}
  This is the defining declaration; unfolding it gives the stated typed data or relation.
\end{proof}

\begin{definition}[DenseInsulatedWinding]
  \label{de
... [suffix omitted]
```

## 17. `IPhO2026Problems/problem_IPhO_2026_3_B_1.lean`

- Open placeholders: 1
- Proof Review: new; attempts=0
- Review reason: (none)
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_3_B_1.tex`

### Lean excerpt
```lean
... [prefix omitted]
ureSI initialFieldIntensitySI finalFieldIntensitySI : ℝ),
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
```

### Blueprint excerpt
```tex
... [prefix omitted]
_1}
\label{ch:IPhO2026Problems_problem_IPhO_2026_3_B_1}

\paragraph{Problem source.}
Continue with the paramagnetic torus.  Its equation of state is T*M*V = n*K*H,
its heat capacity at constant M is C\_M = n*lambda/T\textasciicircum{}2, and dU = C\_M*dT.
The volume is fixed and the magnetic work on the material is
dW = mu\_0*V*H*dM.  Work and heat entering the torus are positive.

Current subquestion:
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

\begin{definition}[energyInJoules]
  \label{decl:physics:IPhO_2026_3_B_1:energyInJoules}
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
  \lean{IPhO2026Problems.IPhO2026_3_B_1.Pa
... [suffix omitted]
```

## 18. `IPhO2026Problems/problem_IPhO_2026_3_B_2.lean`

- Open placeholders: 1
- Proof Review: new; attempts=0
- Review reason: (none)
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_3_B_2.tex`

### Lean excerpt
```lean
... [prefix omitted]
lEnergy s)) τ =
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

## 19. `IPhO2026Problems/problem_IPhO_2026_3_C_2.lean`

- Open placeholders: 1
- Proof Review: new; attempts=0
- Review reason: (none)
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_3_C_2.tex`

### Lean excerpt
```lean
... [prefix omitted]
onOfState readout cycle cycle.state2
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
```

### Blueprint excerpt
```tex
... [prefix omitted]
relation from part B may be reused.

Current subquestion:
Express M\_1 in terms of M\_2, M\_3, and M\_4.

\paragraph{Current subquestion.}
Express M\_1 in terms of M\_2, M\_3, and M\_4.

\paragraph{Recorded answer/context.}
M\_1 = sqrt(M\_2\textasciicircum{}2 - M\_3\textasciicircum{}2 + M\_4\textasciicircum{}2), taking the nonnegative magnitude.

\paragraph{Figure/image path.}
/root/proposal\_for\_physic/science-mango/ipho\_2026\_source/image/T3\_page-3.png

\paragraph{Reusable previous-part conclusions.}
\begin{itemize}
\item Source B.1. Question: At fixed temperature T, H changes from H\_i to H\_f. Find the heat Q transferred into the torus. Reusable conclusions: Q = -(mu\_0*n*K/(2*T))*(H\_f\textasciicircum{}2 - H\_i\textasciicircum{}2). Policy: natural\_language\_prerequisite\_only; do\_not\_import\_Lean\_output
\item Source C.1. Question: Label T\_h and T\_c on Figure 3b and identify the processes on which Q\_h and Q\_c are transferred. Reusable conclusions: States 1 and 4 lie at T\_h; states 2 and 3 lie at T\_c. Q\_c is absorbed on 2->3, and Q\_h is delivered on 4->1. Policy: natural\_language\_prerequisite\_only; do\_not\_import\_Lean\_output
\end{itemize}

\paragraph{Formalization target.}
create a compiling Lean file with sorry bodies at `IPhO2026Problems/problem\_IPhO\_2026\_3\_C\_2.lean`. The Lean declarations must preserve the physical quantities, dimensions or dimensional roles, figure labels, governing-law hypotheses, and final relation expressed by this problem.
Use Mathlib/Physlib names found through LeanExplore where available. If a physics API is missing, introduce faithful local abstractions rather than scalar placeholder aliases.

\begin{definition}[PhysicalQuantityTypes]
  \label{decl:physics:IPhO_2026_3_C_2:PhysicalQuantityTypes}
  \lean{IPhO2026Problems.IPhO2026_3_C_2.PhysicalQuantityTypes}
  Abstract physical roles used in the paramagnetic-torus model.
\end{definition}
\begin{proof}
  This is the defining declaration; unfolding it gives the stated typed data or relation.
\end{proof}

\begin{definition}[SIReadout]
  \label{decl:physics:IPhO_2026_3_C_2:SIReadout}
  \lean{IPhO2026Problems.IPhO2026_3_C_2.SIReadout}
  \uses{decl:physics:IPhO_2026_3_C_2:PhysicalQuantityTypes}
  Scalar readouts of the physical quantities in SI units.
\end{definition}
\begin{proof}
  This is the defining declaration; unfolding it gives the stated typed data or relation.
\end{proof}

\begin{definition}[TorusState]
  \label{decl:physics:IPhO_2026_3_C_2:TorusSt
... [suffix omitted]
```

## 20. `IPhO2026Problems/problem_IPhO_2026_3_C_3.lean`

- Open placeholders: 1
- Proof Review: new; attempts=0
- Review reason: (none)
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_3_C_3.tex`

### Lean excerpt
```lean
... [prefix omitted]
s.torusAmountMol *
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
```

### Blueprint excerpt
```tex
... [prefix omitted]
fter one cycle.

\paragraph{Recorded answer/context.}
Q\_c = 1.29e-1 J, so |Delta T| = 9.92e-3 K and T\_final = 0.99008 K.

\paragraph{Figure/image path.}
/root/proposal\_for\_physic/science-mango/ipho\_2026\_source/image/T3\_page-4.png

\paragraph{Reusable previous-part conclusions.}
\begin{itemize}
\item Source B.1. Question: At fixed temperature T, H changes from H\_i to H\_f. Find the heat Q transferred into the torus. Reusable conclusions: Q = -(mu\_0*n*K/(2*T))*(H\_f\textasciicircum{}2 - H\_i\textasciicircum{}2). Policy: natural\_language\_prerequisite\_only; do\_not\_import\_Lean\_output
\item Source C.2. Question: Express M\_1 in terms of M\_2, M\_3, and M\_4. Reusable conclusions: M\_1 = sqrt(M\_2\textasciicircum{}2 - M\_3\textasciicircum{}2 + M\_4\textasciicircum{}2), taking the nonnegative magnitude. Policy: natural\_language\_prerequisite\_only; do\_not\_import\_Lean\_output
\end{itemize}

\paragraph{Formalization target.}
Redraft the existing scaffold with an explicit Mathlib import in addition to its
Physlib units import.  Preserve the dimensioned thermodynamic and magnetic
quantities, Figure 3b states, supplied SI readouts, licensed B.1/C.2 relations,
calorimetry and numerical tolerances.  Leave proof bodies as `by sorry`.

\begin{definition}[CarnotState]
  \label{decl:physics:IPhO_2026_3_C_3:CarnotState}
  \lean{IPhO2026Problems.IPhO2026_3_C_3.CarnotState}
  The four vertices of the Carnot cycle “1 → 2 → 3 → 4 → 1”.
\end{definition}
\begin{proof}
  This is the defining declaration; unfolding it gives the stated typed data or relation.
\end{proof}

\begin{definition}[CarnotState.next]
  \label{decl:physics:IPhO_2026_3_C_3:CarnotState:next}
  \lean{IPhO2026Problems.IPhO2026_3_C_3.CarnotState.next}
  \uses{decl:physics:IPhO_2026_3_C_3:CarnotState}
  The oriented cycle order shown in Figure 3b.
\end{definition}
\begin{proof}
  This is the defining declaration; unfolding it gives the stated typed data or relation.
\end{proof}

\begin{definition}[Temperature]
  \label{decl:physics:IPhO_2026_3_C_3:Temperature}
  \lean{IPhO2026Problems.IPhO2026_3_C_3.Temperature}
  \uses{decl:physics:IPhO_2026_3_C_3:Volume}
  Absolute temperature, recorded in kelvin in the supplied-data hypotheses.
\end{definition}
\begin{proof}
  This is the defining declaration; unfolding it gives the stated typed data or relation.
\end{proof}

\begin{definition}[Volume]
  \label{decl:physics:IPhO_2026_3_C_3:Volume}
  \lean{IPhO2026Problems.IPhO2026_3_C_3.Volume}
  Volume, record
... [suffix omitted]
```

## 21. `IPhO2026Problems/problem_IPhO_2026_3_C_4.lean`

- Open placeholders: 1
- Proof Review: new; attempts=0
- Review reason: (none)
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_3_C_4.tex`

### Lean excerpt
```lean
... [prefix omitted]
n : ContinuousCoolingRun) : Prop :=
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
```

### Blueprint excerpt
```tex
... [prefix omitted]
rchon:problem-id IPhO_2026_3
% archon:part-id C.4

\chapter{Physics problem IPhO\_2026\_3\_C\_4}
\label{ch:IPhO2026Problems_problem_IPhO_2026_3_C_4}

\paragraph{Problem source.}
The paramagnetic torus executes the Carnot refrigeration cycle
1 -> 2 -> 3 -> 4 -> 1 shown in Figure 3b in the H-versus-T plane.  T\_h and T\_c
are the hot- and cold-reservoir temperatures; Q\_h is the magnitude of heat
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

\begin{definition}[energyDimension]
  \label{decl:physics:IPhO_2026_3_C_4:energyDimension}
  \lean{IPhO2026Problems.IPhO2026_3_C_4.energyDimension}
  The dimension of mechanical or thermal energy, “M L² T⁻²”.
\end{definition}
\begin{proof}
  This is the defining declaration; unfolding it gives the stated typed data or relation.
\end{proof}

\begin{definition}[volumeDimension]
  \label{decl:physics:IPhO_2026_3_C_4:volumeDimension}
  \lean{IPhO2026Problems.IPhO2026_3_C_4.volumeDimension}
  The dimension of volume, “L³”.
\end{definition}
\begin{proof}
  This is the defining declaration; unfolding it gives the stated typed data or relation.
\end{proof}

\begin{definition}[magneticIntensityDimension]
  \label{decl:physics:IPhO_2026_3_C_4:magneticIntensityDimension}
  \lean{IPhO2026Problems.IPhO2026_3_C_4.magneticInt
... [suffix omitted]
```

## 22. `IPhO2026Problems/problem_IPhO_2026_3_C_5.lean`

- Open placeholders: 1
- Proof Review: new; attempts=0
- Review reason: (none)
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_3_C_5.tex`

### Lean excerpt
```lean
... [prefix omitted]
at : SatisfiesIsothermalHeatRelation cycle)
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
```

### Blueprint excerpt
```tex
... [prefix omitted]
and T\_c
are the hot- and cold-reservoir temperatures; Q\_h is the magnitude of heat
delivered to the hot reservoir and Q\_c is the magnitude absorbed from the cold
reservoir.  The equation of state is T*M*V = n*K*H and the isothermal heat
relation from part B may be reused.

Current subquestion:
Determine the overall coefficient of performance COP = Q\_c/W for all cycles up to the time found in C4.

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

\begin{definition}[CycleState]
  \label{decl:physics:IPhO_2026_3_C_5:CycleState}
  \lean{IPhO2026Problems.IPhO2026_3_C_5.CycleState}
  The four labelled states of the magnetic Carnot cycle in Figure 3b.
\end{definition}
\begin{proof}
  This is the defining declaration; unfolding it gives the stated typed data or relation.
\end{proof}

\begin{definition}[CycleLeg]
  \label{decl:physics:IPhO_2026_3_C_5:CycleLeg}
  \lean{IPhO2026Problems.IPhO2026_3_C_5.CycleLeg}
  The directed legs of the cycle “1 → 2 → 3 → 4 → 1”.
\end{definition}
\begin{proof}
  This is the defining declaration; unfolding it gives the stated typed data or relation.
\end{proof}

\begin{definition}[CycleLeg.startState]
  \label{decl:physics:IPhO_2026_3_C_5:CycleLeg:startState}
  \lean{IPhO2026Problems.IPhO2026_3_C_5.CycleLeg.startState}
  \uses{de
... [suffix omitted]
```

## 23. `IPhO2026Problems/problem_IPhO_2026_4_A_1.lean`

- Open placeholders: 1
- Proof Review: new; attempts=0
- Review reason: (none)
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_4_A_1.tex`

### Lean excerpt
```lean
... [prefix omitted]
unt)
      officialAmountEstimateMoles ∧
    WithinEstimate (model.moleculeCount setup.confinedAirCA.molecules)
      officialMoleculeCountEstimate

/--
Part A.1: determine the volume, mass, amount of substance, and molecular
population of the confined air column.

The symbolic conclusions substitute Figure 17's diameter-based cylinder
volume into the primitive laws, solve the molar-mass relation for amount, and
put the Avogadro relation in the requested order. The final conjunct asserts
the corrected mass interval and the reported amount and molecule intervals.
-/
theorem determineConfinedAirInventory
    (model : SubstanceCountingModel)
    (setup : IsochoricAirSetup model)
    (_readouts : SourceReadouts model setup)
    (_conditions : ExperimentalConditions model setup)
    (_admissible : PhysicalAdmissibility model setup)
    (_laws : GoverningLaws model setup) :
    siValue setup.geometry.confinedAirVolume =
        cylindricalAirVolumeSI setup.geometry ∧
      siValue setup.confinedAirCA.mass =
        siValue setup.ambientAirDensity *
          cylindricalAirVolumeSI setup.geometry ∧
      model.amountInMoles setup.confinedAirCA.amount =
        siValue setup.confinedAirCA.mass /
          model.molarMassInKilogramsPerMole setup.airMolarMass ∧
      model.moleculeCount setup.confinedAirCA.molecules =
        model.amountInMoles setup.confinedAirCA.amount *
          model.avogadroConstantPerMole setup.avogadroConstant ∧
      MatchesOfficialSample model setup := by
  sorry

end IPhO2026Problems.IPhO2026_4_A_1
```

### Blueprint excerpt
```tex
... [prefix omitted]
{Current subquestion.}
Determine the mass m, amount n, and number N of molecules in the confined air column.

\paragraph{Recorded answer/context.}
Figure 17 gives inner-cylinder diameter \(33.7\pm0.1\) mm.  The official
solution gives \(H=9.5\pm0.1\) cm and \(V=85\pm2\) mL.  Thus
\(\rho_aV\approx0.095\) g.  The solution's printed \(0.94\pm0.02\) g is a
factor-of-ten typo: it conflicts with both the geometry and its own
\(n=3.24\) mmol and \(N=(1.95\pm0.05)\times10^{21}\).  The corrected mass
centre is \(0.094\) g (equivalently about \(0.095\) g from the rounded
geometry).

\paragraph{Figure/image path.}
/root/proposal\_for\_physic/science-mango/ipho\_2026\_source/image/E1\_page-7.png
(Figure 17 dimensions), and
/root/proposal\_for\_physic/science-mango/ipho\_2026\_source/image/E1\_page-9.png
(part A procedure).

\paragraph{Formalization target.}
Redraft the existing scaffold with an explicit Mathlib import and the current
Physlib units.  Add the Figure 17 inner diameter, the solution's air height,
the air molar mass \(28.96\) g/mol and Avogadro's constant as typed readouts.
Use the corrected \(0.094\) g mass centre, and extend the target from symbolic
formulas to the source-grounded numerical inventory.  Leave proof bodies as
`by sorry`.

\begin{definition}[Length]
  \label{decl:physics:IPhO_2026_4_A_1:Length}
  \lean{IPhO2026Problems.IPhO2026_4_A_1.Length}
  A physical length, represented independently of the choice of units.
\end{definition}
\begin{proof}
  This is the defining declaration; unfolding it gives the stated typed data or relation.
\end{proof}

\begin{definition}[Volume]
  \label{decl:physics:IPhO_2026_4_A_1:Volume}
  \lean{IPhO2026Problems.IPhO2026_4_A_1.Volume}
  A physical volume, with dimension “L³”.
\end{definition}
\begin{proof}
  This is the defining declaration; unfolding it gives the stated typed data or relation.
\end{proof}

\begin{definition}[Mass]
  \label{decl:physics:IPhO_2026_4_A_1:Mass}
  \lean{IPhO2026Problems.IPhO2026_4_A_1.Mass}
  A physical mass.
\end{definition}
\begin{proof}
  This is the defining declaration; unfolding it gives the stated typed data or relation.
\end{proof}

\begin{definition}[MassDensity]
  \label{decl:physics:IPhO_2026_4_A_1:MassDensity}
  \lean{IPhO2026Problems.IPhO2026_4_A_1.MassDensity}
  A mass density, with dimension “M L⁻³”.
\end{definition}
\begin{proof}
  This is the defining declaration; unfolding it gives the stated typed data or relation.
\end{proof}

\begin{definition}[AbsoluteTemperature
... [suffix omitted]
```

## 24. `IPhO2026Problems/problem_IPhO_2026_4_A_5.lean`

- Open placeholders: 1
- Proof Review: new; attempts=0
- Review reason: (none)
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_4_A_5.tex`

### Lean excerpt
```lean
... [prefix omitted]
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
```

### Blueprint excerpt
```tex
... [prefix omitted]
inder.  Propylene glycol is introduced to h = 4.5 cm so the air volume is
fixed.  Use the cylinder dimensions in Figure 17, ambient air density
rho\_a = 1.12 kg/m\textasciicircum{}3, and the ideal-gas law P*V = n*R*T.  The outer-cylinder
water bath is heated while pressure and temperature are recorded.

Current subquestion:
Determine the constant-volume thermal pressure coefficient beta\_0 = (1/P\_0)*(Delta P/Delta T).

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

\begin{definition}[Length]
  \label{decl:physics:IPhO_2026_4_A_5:Length}
  \lean{IPhO2026Problems.IPhO2026_4_A_5.Length}
  A physical length, independently of the units used to report it.
\end{definition}
\begin{proof}
  This is the defining declaration; unfolding it gives the stated typed data or relation.
\end{proof}

\begin{definition}[Volume]
  \label{decl:physics:IPhO_2026_4_A_5:Volume}
  \lean{IPhO2026Problems.IPhO2026_4_A_5.Volume}
  A physical volume, with dimension “L³”.
\end{definition}
\begin{proof}
  This is the defining declaration; unfolding it gives the stated typed data or relation.
\end{proof}

\begin{definition}[MassDensity]
  \label{decl:physics:IPhO_2026_4_A_5:MassDensity}
  \lean{IPhO2026Problems.IPhO2026_4_A_5.MassDensity}
  A mass density, with dimension “M L⁻³”.
\end{definition}
\begin{p
... [suffix omitted]
```

## 25. `IPhO2026Problems/problem_IPhO_2026_4_B_4.lean`

- Open placeholders: 1
- Proof Review: new; attempts=0
- Review reason: (none)
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_4_B_4.tex`

### Lean excerpt
```lean
... [prefix omitted]
iusClapeyronData)
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
```

### Blueprint excerpt
```tex
... [prefix omitted]
lus water vapor at total pressure
approximately P\_atm.  The water level is adjusted and its height H is recorded
as temperature T falls.  At T\_0 = 273.15 K, extrapolated height is H\_0 and the
water vapor pressure may be taken as zero.  Vapor pressure obeys
ln(P\_v/P\_v0) = -(Q\_v/R)*(1/T - 1/T\_0).  Use the experimental procedure and
geometry on pages 11--12.

Current subquestion:
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

\begin{definition}[DimLength]
  \label{decl:physics:IPhO_2026_4_B_4:DimLength}
  \lean{IPhO2026Problems.IPhO2026_4_B_4.DimLength}
  A physical length, independent of the chosen system of units.
\end{definition}
\begin{proof}
  This is the defining declaration; unfolding it gives the stated typed data or relation.
\end{proof}

\begin{definition}[DimVolume]
  \label{decl:physics:IPhO_2026_4_B_4:DimVolume}
  \lean{IPhO2026Problems.IPhO2026_4_B_4.DimVolume}
  A physical volume, independent of the chosen system of units.
\end{definition}
\begin{proof}
  This is the defining declaration; unfolding it gives the stated typed data or relation.
\end{proof}

\begin{definition}[pressureInPascals]
  \label{decl:physics:IPhO_2026_4_B_4:pressureInPascals}
  \lean{IPhO2026Problems.IPhO2026_4_B_4.pressureInPascals}
  The numeri
... [suffix omitted]
```

## 26. `IPhO2026Problems/problem_IPhO_2026_4_B_6.lean`

- Open placeholders: 1
- Proof Review: new; attempts=0
- Review reason: (none)
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_4_B_6.tex`

### Lean excerpt
```lean
... [prefix omitted]
ntHeatPerUnitMassLv *
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

## 27. `IPhO2026Problems/problem_IPhO_2026_4_C_6.lean`

- Open placeholders: 1
- Proof Review: new; attempts=0
- Review reason: (none)
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_4_C_6.tex`

### Lean excerpt
```lean
... [prefix omitted]
target and official sample metadata -/

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
```

### Blueprint excerpt
```tex
... [prefix omitted]
\paragraph{Problem source.}
Water in the inner and outer cylinders exchanges heat radially through an
acrylic cylindrical wall.  Record T\_IC and T\_OC versus time.  The heat-flow
model is dQ/dt = (T\_OC - T\_IC)/R\_Th.  For radial Fourier conduction,
dQ/dt = -lambda*A*dT/dr.  Ignore apparatus heat capacity where instructed and
use the dimensions in Figure 17.

Current subquestion:
Determine the effective wall thermal resistance R\_Th from the C5 graph.

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

\begin{definition}[energyDimension]
  \label{decl:physics:IPhO_2026_4_C_6:energyDimension}
  \lean{IPhO2026Problems.IPhO2026_4_C_6.energyDimension}
  Energy dimension, grounded by Physlib's “DimEnergy”.
\end{definition}
\begin{proof}
  This is the defining declaration; unfolding it gives the stated typed data or relation.
\end{proof}

\begin{definition}[powerDimension]
  \label{decl:physics:IPhO_2026_4_C_6:powerDimension}
  \lean{IPhO2026Problems.IPhO2026_4_C_6.powerDimension}
  \uses{decl:physics:IPhO_2026_4_C_6:energyDimension}
  Power, or heat-flow-rate, dimension.
\end{definition}
\begin{proof}
  This is the defining declaration; unfolding it gives the stated typed data or relation.
\end{proof}

\begin{definition}[thermalResistanceDimension]
  \label{decl:physics:IPhO_2026_4_C_6:thermalResistanceDimension}
... [suffix omitted]
```

## 28. `IPhO2026Problems/problem_IPhO_2026_4_C_7.lean`

- Open placeholders: 1
- Proof Review: new; attempts=0
- Review reason: (none)
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_4_C_7.tex`

### Lean excerpt
```lean
... [prefix omitted]
ReceivedByInnerCylinder timeSeconds)
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
