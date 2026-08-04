# Deterministic Review Candidate Pack

Iteration: 002
Exact review target count: 7

Review only these targets. Direct Lean compilation was already run in
parallel by the orchestrator; use the recorded result instead of rerunning it.

## 1. `IPhO2026Problems/problem_IPhO_2026_1_C_1.lean`

- Compile status: passed
- Open sorries: 1
- Direct-check seconds: 4.643
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_1_C_1.tex`
- Reports: `.archon/task_results/problem_IPhO_2026_1_C_1.lean.md`, `.archon/task_results/physics-grounding-IPhO2026Problems_problem_IPhO_2026_1_C_1.md`

### Lean excerpt
```lean
radians per second, producing the two fragments at
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

### Report excerpt: `problem_IPhO_2026_1_C_1.lean.md`
```markdown
d `momentumSI` expose explicit SI readouts;
  `dot2` and `magnitude2` then state the measured planar geometry.
- `DissociationAt` and `IsMinimumDissociationFrequency` are local,
  problem-specific physical predicates. Physlib supplies unit-aware
  quantities but no ozone photodissociation/minimization interface; these
  predicates preserve the relevant conservation and least-feasibility
  meanings without assuming the answer.

## Grounding gaps and verification

- No generic Physlib declaration packages this specific two-fragment
  photodissociation conservation model or its constrained frequency
  minimization, so the faithful local predicates are retained.
- The requested `archon dag-query` navigation could not be run because the
  `archon` executable was not present on this prover process's `PATH`; the
  blueprint itself has no theorem ancestors beyond the declarations listed in
  its `\uses`.
- Lean LSP diagnostics report only the expected `declaration uses sorry`
  warning at `minimumAngularFrequency_eq`.
- `lake env lean IPhO2026Problems/problem_IPhO_2026_1_C_1.lean` exits
  successfully with the same single expected warning.
- `lake build IPhO2026Run` completes successfully.
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

## 2. `IPhO2026Problems/problem_IPhO_2026_1_C_2.lean`

- Compile status: passed
- Open sorries: 1
- Direct-check seconds: 9.749
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_1_C_2.tex`
- Reports: `.archon/task_results/IPhO2026Problems_problem_IPhO_2026_1_C_2.lean.md`, `.archon/task_results/physics-grounding-IPhO2026Problems_problem_IPhO_2026_1_C_2.md`

### Lean excerpt
```lean
s.oxygenMoleculeMass s.workingUnits) +
        momentumSquaredNorm s.outgoingOxygenAtomMomentum /
          (2 * scalarInUnits s.oxygenAtomMass s.workingUnits)
  omegaMin_is_threshold :
    IsLeast
      {ω : ℝ | DissociationAt s s.theta ω}
      (scalarInUnits s.omegaMin s.workingUnits)

/--
The corrected threshold angular-frequency expression quoted in the blueprint from part C.1.

The factor `2` in the radicand is the conservation-law correction supplied by C.1.
-/
noncomputable def quotedC1ThresholdExpression
    (s : OzonePhotodissociationSetup) (angle : ℝ) : ℝ :=
  let angularFactor := 2 * (Real.sin angle) ^ 2 + 1
  let restEnergyScale :=
    3 * siScalar s.atomMass * (siScalar DimSpeed.speedOfLight) ^ 2
  restEnergyScale *
      (1 - Real.sqrt
        (1 -
          2 * angularFactor * siScalar s.deltaU / restEnergyScale)) /
    (siScalar reducedPlanckConstant * angularFactor)

/--
The reusable corrected C.1 conclusion supplied by the blueprint. For backward angles, the
threshold is the same corrected expression evaluated at `π/2`.
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
out. The search found
  `MassUnit`, but not a reusable dimensionful unified-atomic-mass constant.
- `MakesAngle`, `DissociationAt`, `OzonePhotodissociationSetup`, and
  `ValidOzonePhotodissociationPhysics` are the smallest local interfaces retaining the
  Figure 1c geometry and conservation laws.
- `QuotedPreviousPartC1Result` isolates the permitted natural-language prerequisite
  without importing the C.1 Lean output.
- `C2NumericalInputs` and `RoundsTo` separate supplied measurements from the numerical
  conclusion.

## Grounding gaps

- Physlib has no directly matching general-purpose angular-frequency/action aliases or
  dimensionful unified atomic mass constant in the LeanExplore results. The local
  dimension-carrying declarations preserve those physical roles without reducing them
  to bare real scalars.
- No redraft request remains.

## Verification

- Lean LSP diagnostics after the correction report only the expected
  `declaration uses 'sorry'` warning on `problem_IPhO_2026_1_C_2`.
- `lake env lean IPhO2026Problems/problem_IPhO_2026_1_C_2.lean` succeeds with
  that same single expected warning.
- `git diff --check` reports no whitespace errors in either owned output file.
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

## 3. `IPhO2026Problems/problem_IPhO_2026_2_A_1.lean`

- Compile status: passed
- Open sorries: 1
- Direct-check seconds: 9.246
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_2_A_1.tex`
- Reports: `.archon/task_results/IPhO2026Problems_problem_IPhO_2026_2_A_1.lean.md`, `.archon/task_results/physics-grounding-IPhO2026Problems_problem_IPhO_2026_2_A_1.md`

### Lean excerpt
```lean
orDynamics mirror) (ray : GeometricRay) : ℕ :=
  (dynamics.trace ray).numberOfReflections

/-- Figure 2e's threshold meaning: within the open aperture `|x| < R`, a ray
has at most `N` reflections exactly when its distance from the optical axis is
at most the positive threshold `xN`. -/
def IsReflectionThreshold (mirror : HalfCylindricalMirror)
    (family : ParallelIncidentRayFamily) (dynamics : MirrorDynamics mirror)
    (N : ℕ) (xN : PhysicalLength) : Prop :=
  0 < lengthCoordinate xN ∧
    lengthCoordinate xN < lengthCoordinate mirror.radius ∧
    ∀ x, |x| < lengthCoordinate mirror.radius →
      (reflectionCount dynamics (family.rayAt x) ≤ N ↔
        |x| ≤ lengthCoordinate xN)

/-- Figure-derived limiting-ray relations used before solving for `xN`.

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
  sorry

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
lest explicit curved-mirror ray-tracing interface needed by the source.
  They retain impact points, normals, directions, the semicircular boundary,
  and the physical reflection law rather than collapsing optics to scalars.
- `Figure2cTo2eLimitingGeometry` preserves the figure-derived projection and
  turning relations as assumptions while leaving the requested solution on the
  theorem's conclusion side.

## Grounding gaps

- Physlib/PhysLean provides dimensionful physical quantities but no dedicated
  half-cylindrical geometrical-optics or finite multi-reflection trace API.
- Mathlib's `EuclideanGeometry.reflection` concerns reflection of points in a
  fixed affine subspace, so it is a near miss for direction reflection at a
  varying tangent plane. The explicit vector specular law is therefore kept.
- No blueprint edits were made because prover write permissions reserve
  `\leanok` management for the deterministic sync.

## Verification

- `mcp__archon_lean_lsp.lean_diagnostic_messages`: no errors and exactly one
  expected `declaration uses sorry` warning.
- `lake env lean IPhO2026Problems/problem_IPhO_2026_2_A_1.lean`: exit code 0,
  with exactly the expected `sorry` warning.
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

## 4. `IPhO2026Problems/problem_IPhO_2026_2_C_2.lean`

- Compile status: passed
- Open sorries: 3
- Direct-check seconds: 4.493
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_2_C_2.tex`
- Reports: `.archon/task_results/IPhO2026Problems_problem_IPhO_2026_2_C_2.lean.md`, `.archon/task_results/physics-grounding-IPhO2026Problems_problem_IPhO_2026_2_C_2.md`

### Lean excerpt
```lean
igure2gLengthReadout setup.coordinateUnits setup.radius /
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
          figure2gLengthReadout setup.coordinateUnits
              (rayB setup angularIncrementRad).intercept -
            (figure2gLengthReadout setup.coordinateUnits setup.radius /
                (2 * Real.cos setup.incidenceAngleRad) *
              (1 + Real.tan setup.incidenceAngleRad * angularIncrementRad)))
        =O[𝓝 0] (fun angularIncrementRad : ℝ => angularIncrementRad ^ 2)) := by
  sorry

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
eflectedRayReadout`, `Figure2gSetup`, and
  `HalfCylindricalReflectionLaw` remain the smallest local optical interface
  needed to represent the half-cylinder ray family and its exact specular
  geometry.

## Grounding gaps and redraft requests

- LeanExplore returned generic mathematical rays and affine reflections
  (`RayVector`, `Module.Ray`, `EuclideanGeometry.reflection`) but no
  half-cylindrical specular-reflection model matching Figure 2g. The local
  exact-law predicate is therefore retained.
- If full one-environment-per-declaration blueprint coverage is desired, the
  plan agent should add environments for `PhysicalLength` and
  `figure2gLengthReadout`. No change to the target statement is requested.
- The advertised `archon dag-query` executable was unavailable on this
  prover lane's `PATH`, so no dependency-graph result was consumed.

## Verification

`archon-lean-lsp` diagnostics report no errors and exactly three expected
`declaration uses sorry` warnings, at `rayB_slope_firstOrder`,
`rayB_intercept_firstOrder`, and `IPhO_2026_2_C_2`. A final
`lake env lean IPhO2026Problems/problem_IPhO_2026_2_C_2.lean` check produced
the same three warnings and exited successfully.
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

## 5. `IPhO2026Problems/problem_IPhO_2026_2_C_3.lean`

- Compile status: passed
- Open sorries: 1
- Direct-check seconds: 9.198
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_2_C_3.tex`
- Reports: `.archon/task_results/IPhO2026Problems_problem_IPhO_2026_2_C_3.lean.md`, `.archon/task_results/physics-grounding-IPhO2026Problems_problem_IPhO_2026_2_C_3.md`

### Lean excerpt
```lean
on)
    (reflectedRayAtIncidenceAngle : ℝ → ReflectedRayLine)
    (θ Δθ : ℝ) (point : Figure2gPoint) : Prop :=
  (reflectedRayAtIncidenceAngle θ).Contains projection point ∧
    (reflectedRayAtIncidenceAngle (θ + Δθ)).Contains projection point

/-- For the half-cylindrical mirror of Figure 2g, the intersections of ray A
with neighboring reflected rays tend to the stated point of the caustic.

The two Big-O hypotheses are precisely the first-order ray-B data from part
C.2, expressed without choosing a particular nonzero `Δθ`. The two equalities
for ray A are the reusable conclusions of part C.1. Every length occurring in
these assumptions and in the conclusion is read through the same
`lengthProjection`. -/
theorem limitingIntersectionCoordinates
    (lengthProjection : Figure2gLengthProjection)
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
026_2_C_3.PhysicalLength` — Physlib-backed physical
  length abbreviation used by the existing blueprint declarations.
- `IPhO2026Problems.IPhO2026_2_C_3.Figure2gLengthProjection` — the named common
  coordinate-unit projection required by the redraft objective.
- `IPhO2026Problems.IPhO2026_2_C_3.Figure2gLengthProjection.readout` — projects
  a physical length to the common Figure 2g scalar coordinate.

The planner/reviewer should add definition environments for these three
supporting declarations if strict one-to-one Lean/blueprint coverage is
required.

## Grounding gaps and redraft requests

- LeanExplore's generic `SameRay` and `AffineMap.lineMap` candidates do not
  encode the Figure 2g slope/intercept convention together with dimensioned
  intercepts and a chosen unit projection. The faithful local ray structures
  were therefore retained.
- No further statement redraft is requested. The only follow-up is the
  blueprint-entry bookkeeping listed above.

## Verification

- `archon-lean-lsp` diagnostics: no errors; exactly one expected
  `declaration uses sorry` warning at `limitingIntersectionCoordinates`.
- No `axiom`, `admit`, or additional proof escape hatch was introduced.
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

## 6. `IPhO2026Problems/problem_IPhO_2026_3_C_3.lean`

- Compile status: passed
- Open sorries: 1
- Direct-check seconds: 9.036
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
nt, and molar mass are faithful
  explicitly unit-named real readouts rather than `WithDim` quantities.
- No library Carnot-cycle object matching the four problem-specific labelled
  states was found; the local finite state type is the minimal faithful model.
- The `archon dag-query` executable advertised by the task was not available
  on this prover process's `PATH`; the blueprint itself fully specifies the
  licensed B.1/C.2 dependencies.
- No blueprint redraft is requested. In accordance with prover permissions,
  the chapter was not edited; marker synchronization is left to the project
  automation.

## Verification

- `mcp__archon_lean_lsp.lean_diagnostic_messages`: no errors and exactly one
  expected `declaration uses sorry` warning.
- `lake env lean IPhO2026Problems/problem_IPhO_2026_3_C_3.lean`: exit code
  `0`, with exactly the expected `sorry` warning.
- A module-specific `lake build
  IPhO2026Problems.problem_IPhO_2026_3_C_3` check is unavailable because the
  Lake configuration exposes only the `IPhO2026Run` library target; Lake
  reported that module name as an unknown target. The direct Lake-environment
  Lean compilation above is therefore the scoped compile check.
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

## 7. `IPhO2026Problems/problem_IPhO_2026_4_A_1.lean`

- Compile status: passed
- Open sorries: 1
- Direct-check seconds: 9.131
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_4_A_1.tex`
- Reports: `.archon/task_results/IPhO2026Problems_problem_IPhO_2026_4_A_1.lean.md`, `.archon/task_results/physics-grounding-IPhO2026Problems_problem_IPhO_2026_4_A_1.md`

### Lean excerpt
```lean
te where
  centralValue : ℝ
  uncertainty : ℝ

/--
The source-consistent corrected `0.094 ± 0.002 g`, expressed in kilograms.
-/
def officialMassEstimateKilograms : ScalarEstimate :=
  ⟨0.000094, 0.000002⟩

/-- The reported `3.24 mmol` with `0.7 mmol` uncertainty, expressed in moles. -/
def officialAmountEstimateMoles : ScalarEstimate :=
  ⟨0.00324, 0.0007⟩

/-- The reported `(1.95 ± 0.05) · 10²¹` molecules. -/
def officialMoleculeCountEstimate : ScalarEstimate :=
  ⟨1.95 * 10 ^ 21, 0.05 * 10 ^ 21⟩

/-- Whether a scalar readout lies within a stated experimental uncertainty. -/
def WithinEstimate (readout : ℝ) (estimate : ScalarEstimate) : Prop :=
  |readout - estimate.centralValue| ≤ estimate.uncertainty

/--
The source-grounded numerical inventory, using the corrected mass interval.
-/
def MatchesOfficialSample (model : SubstanceCountingModel)
    (setup : IsochoricAirSetup model) : Prop :=
  WithinEstimate (siValue setup.confinedAirCA.mass)
      officialMassEstimateKilograms ∧
    WithinEstimate (model.amountInMoles setup.confinedAirCA.amount)
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
ent SI projection
alongside all other dimensionful readouts. The dimension-tagged local
`AbsoluteTemperature` is therefore retained. `FluidDynamics.MassDensity` is a
spatial field, not the scalar ambient density needed here.

## Grounding gaps

- Physlib's current dimension basis has no amount-of-substance component.
  Therefore no library type can directly express molar mass or inverse moles;
  `SubstanceCountingModel` supplies faithful abstract types and explicit
  kg/mol and mol⁻¹ projections.
- No Mathlib/Physlib experimental uncertainty object matched the three
  symmetric scalar estimates, so the small local `ScalarEstimate` and
  `WithinEstimate` abstractions were retained.
- The `archon dag-query` executable advertised by the task was not available
  on this prover process's `PATH`. There are no previous-part dependencies for
  A.1, and the blueprint fully specifies the target.
- No blueprint redraft is requested.

## Verification

- `mcp__archon_lean_lsp.lean_diagnostic_messages`: no errors and exactly one
  expected `declaration uses sorry` warning.
- `lake env lean IPhO2026Problems/problem_IPhO_2026_4_A_1.lean`: exit code
  `0`, with exactly the expected `sorry` warning.
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
