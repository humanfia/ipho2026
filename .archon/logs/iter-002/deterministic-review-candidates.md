# Deterministic Review Candidate Pack

Iteration: 002
Exact review target count: 11

Review only these targets. Direct Lean compilation was already run in
parallel by the orchestrator; use the recorded result instead of rerunning it.

## 1. `IPhO2026Problems/problem_IPhO_2026_1_B_1.lean`

- Compile status: passed
- Open sorries: 5
- Direct-check seconds: 10.764
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_1_B_1.tex`
- Reports: `.archon/task_results/problem_IPhO_2026_1_B_1.md`, `.archon/task_results/physics-grounding-IPhO2026Problems_problem_IPhO_2026_1_B_1.md`

### Lean excerpt
```lean
bPairData.orbit_support`; it is NOT assumed by
any other declaration. -/
theorem orbitBound_T1_B1 {hR : ScalingRegime} (D : CoulombPairData hR)
    (hv : D.AnchoredValues) (hb : IsBoundMu boundMu)
    {r : ℝ} (hr : r ∈ D.attainedSeparations) :
    r ≤ (1600 / 9) * bohrRadius := by
  sorry

/-- Certified-root attainability (conclusion-side first use of the
recorded value): the upper turning-point separation `(1600/9)·a₀` is
realized along the bound orbit (the apogee of the elliptic motion of Hint
2).  Its proof is a bridge obligation (continuity of the radial motion
between the two turning points, Intermediate Value Theorem for the
separation as a function of time); it is NOT assumed by any other
declaration. -/
theorem apogee_attained_T1_B1 {hR : ScalingRegime} (D : CoulombPairData hR)
    (hv : D.AnchoredValues) (hb : IsBoundMu boundMu) :
    (1600 / 9) * bohrRadius ∈ D.attainedSeparations := by
  sorry

/-- **Main target (T1-B1, 1.0 pt).**  Under the two-body Coulomb model of
Fig. 1b with `μ = 4` (bound case), there exists a maximal attained
separation between `e⁺` and `e⁻`, and its value is exactly
`(1600/9)·a₀`.  The recorded official value first becomes *asserted as the
answer* here, on the conclusion side: attainability (`apogee_attained_T1_B1`)
and the certified support bound (`orbitBound_T1_B1`), whose conjunction is
exactly the greatest-element statement, are conclusion-side lemmas proved
from the governing laws — nothing in the hypothesis list mentions the
value `1600/9`.  The proof combines `orbitBound_T1_B1`,
`apogee_attained_T1_B1` and `IsMaxSeparationAlongOrbit`. -/
theorem maximum_separation_T1_B1 {hR : ScalingRegime} (D : CoulombPairData hR)
    (hv : D.AnchoredValues) (hb : IsBoundMu boundMu) :
    ∃ r_max : ℝ,
      IsMaxSeparationAlongOrbit D r_max ∧ r_max = (1600 / 9) * bohrRadius := by
  refine ⟨(1600 / 9) * bohrRadius, ⟨⟨?_, ?_⟩, rfl⟩⟩
  · exact apogee_attained_T1_B1 D hv hb
  · intro r' hr'
    exact orbitBound_T1_B1 D hv hb hr'

/-- The numeric readout requested by the subquestion (“in terms of `a₀`”):
the maximum separation in units of `a₀` is exactly `1600/9`.  Corollary
form of `maximum_separation_T1_B1` with the division by `a₀ > 0` made
explicit. -/
theorem maximum_separation_in_bohr_radii_T1_B1 {hR : ScalingRegime}
    (D : CoulombPairData hR)
    (hv : D.AnchoredValues) (hb : IsBoundMu boundMu) :
    ∃ x_max : ℝ,
      IsMaxSeparationAlongOrbit D (x_max * bohrRadius) ∧ x_max = 1600 / 9 := by
  exact ⟨1600 / 9,
    ⟨apogee_attained_T1_B1 D hv hb, fun _ hr' => orbitBound_T1_B1 D hv hb hr'⟩, rfl⟩

end

end IPhO2026.Problem1.B1
... [leading content omitted]
```

### Blueprint excerpt
```tex
r about the center of mass.  The system is isolated,
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
create a compiling Lean file with sorry bodies at `IPhO2026Problems/problem\_IPhO\_2026\_1\_B\_1.lean`.
The Lean declarations must preserve the physical quantities, dimensions or dimensional roles, figure labels, governing-law hypotheses, and final relation expressed by this problem.
Use Mathlib/Physlib names found through LeanExplore where available. If a domain API is missing, introduce faithful local abstractions rather than scalar placeholder aliases.

\begin{theorem}[Physics formalization target] % STALE-LEANOK iter-001: marker does not vouch (4 sorries open; redraft in iter-002 repair wave) — deterministic sync owns future marker state
\label{thm:physics:IPhO_2026_1_B_1:target}
The assigned autoformalize agent should translate this physics problem into Lean declarations in the covered file, with theorem and lemma proof bodies written as `by sorry`.
\end{theorem}
\begin{proof}
This is an autoformalization task, not a proof task. Produce faithful statements that can later be proved without weakening the source contract.
\end{proof}
% --- Archon physics formalization source end ---
... [leading content omitted]
```

### Report excerpt: `problem_IPhO_2026_1_B_1.md`
```markdown
ElectromagneticPotential.electricField` (PhysLean) — all near misses for a
two-body *Coulomb scattering/orbit* model (no two-body Kepler/Coulomb-orbit
API exists in PhysLean), so the file keeps the reconciled `import Mathlib`
baseline with no Physlib import (matching review-retry rulings for 1_A_1
et al.; the chapter `% NOTE:` exemption pattern applies).  Mathlib names used:
`Set.IsGreatest`, `Set.Nonempty.mono`, `mul_pos`, `Classical.choose` /
`Classical.choose_spec`, `field_simp`, `ring`, `nlinarith`, `positivity`.

## Grounding gaps

- No Mathlib/PhysLean formalization of two-body Coulomb (Kepler) orbits,
  turning-point quadratics, or scattering support sets — hence the local
  `CoulombPairData` + `orbit_support` abstraction (faithful, eliminable).
- Bridge #9 (`apogee_attained_T1_B1`) is the single genuinely open physics
  step (requires IVT on the radial motion); it is kept conclusion-side with a
  `sorry`, exactly as mandated ("leave attainability as `sorry`-bodied bridge
  lemmas").
- Redraft request to review agent: please re-audit goal-faithfulness under the
  new hypothesis lists — every `1600/9` occurrence is now conclusion-side or
  inside proved polynomial identities.
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

## 2. `IPhO2026Problems/problem_IPhO_2026_1_B_2.lean`

- Compile status: passed
- Open sorries: 7
- Direct-check seconds: 10.26
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_1_B_2.tex`
- Reports: `.archon/task_results/problem_IPhO_2026_1_B_2.md`, `.archon/task_results/physics-grounding-IPhO2026Problems_problem_IPhO_2026_1_B_2.md`

### Lean excerpt
```lean
`e+` equals
the exact value `-(pi - 2 * arctan(2 / sqrt 63))` radians, whose degree
reading rounds to the official `-16.60` degrees.  The negative sign
(“16.60 degrees BELOW the initial line of motion”) is carried by the
branch condition `perp u0 u_inf ≤ 0` inside
`IsAsymptoticRelativeVelocity.direction_toward_pair` together with the
closed form.  The recorded official value first appears here,
conclusion-side; every hypothesis is a governing law, a figure readout,
or a derivable bridge. -/
theorem signed_deflection_angle_T1_B2 {hR : ScalingRegime}
    (S : CoulombScatteringData hR) (hμ : IsAngularMomentumFactor unboundMu) :
    ∃ u : RelativeVelocityVector, ∃ delta : ℝ,
      IsAsymptoticRelativeVelocity S u ∧
        delta = signedDeflection (S := S) u ∧
        delta = -(Real.pi - 2 * Real.arctan (2 / Real.sqrt 63)) ∧
        roundsToOfficialDegrees (radiansToDegrees delta) := by
  sorry

/-- Algebraic certificate for the equal-mass eccentricity value: the
hyperbola `eps² = 67/4` makes the scattering asymptote factor
`1/sqrt(eps²-1) = 2/sqrt(63)`, so the exact signed deflection in
`signed_deflection_angle_T1_B2` has the stated closed form.  Pure
algebra up to the square-root identity `sqrt(63/4) = sqrt 63 / 2`. -/
theorem asymptote_factor_certificate :
    1 / Real.sqrt ((67 / 4 : ℝ) - 1) = 2 / Real.sqrt 63 := by
  have h634 : (63 / 4 : ℝ) = (Real.sqrt 63 / 2) ^ 2 := by
    rw [div_pow, Real.sq_sqrt (by norm_num)]
    norm_num
  have halg : (67 / 4 : ℝ) - 1 = 63 / 4 := by norm_num
  rw [halg, h634, Real.sqrt_sq (by positivity)]
  field_simp

/-- A real `x` rounds to the official magnitude `16.60` degrees, i.e. to
two decimal places in the sense of the official marking scheme:
`16.595 ≤ x < 16.615`. -/
def roundsToOfficialDegreesAbs (x : ℝ) : Prop :=
  (16595 : ℝ) / 1000 ≤ x ∧ x < (16615 : ℝ) / 1000

/-- Magnitude corollary: the unsigned deflection angle between `u_inf` and
the initial line of motion of `e+` equals the exact value
`pi - 2 * arctan(2 / sqrt 63)` radians, whose degree reading rounds to
the official `16.60` degrees below the initial line of motion. -/
theorem unsigned_deflection_angle_in_degrees_T1_B2 {hR : ScalingRegime}
    (S : CoulombScatteringData hR) (hμ : IsAngularMomentumFactor unboundMu) :
    ∃ u : RelativeVelocityVector,
      IsAsymptoticRelativeVelocity S u ∧
        angleBetween (initialDirection (S := S)) u.vec =
          Real.pi - 2 * Real.arctan (2 / Real.sqrt 63) ∧
        roundsToOfficialDegreesAbs
          (radiansToDegrees (angleBetween (initialDirection (S := S)) u.vec)) := by
  sorry

end

end IPhO2026.Problem1.B2
... [leading content omitted]
```

### Blueprint excerpt
```tex
The system is isolated,
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
create a compiling Lean file with sorry bodies at `IPhO2026Problems/problem\_IPhO\_2026\_1\_B\_2.lean`.
The Lean declarations must preserve the physical quantities, dimensions or dimensional roles, figure labels, governing-law hypotheses, and final relation expressed by this problem.
Use Mathlib/Physlib names found through LeanExplore where available. If a domain API is missing, introduce faithful local abstractions rather than scalar placeholder aliases.

\begin{theorem}[Physics formalization target]
\label{thm:physics:IPhO_2026_1_B_2:target}
The assigned autoformalize agent should translate this physics problem into Lean declarations in the covered file, with theorem and lemma proof bodies written as `by sorry`.
\end{theorem}
\begin{proof}
This is an autoformalization task, not a proof task. Produce faithful statements that can later be proved without weakening the source contract.
\end{proof}
% --- Archon physics formalization source end ---
... [leading content omitted]
```

### Report excerpt: `problem_IPhO_2026_1_B_2.md`
```markdown
b two-body trajectory
  object; fields carry units/roles and laws as equations (no scalar-fallback:
  vectors stay in `Plane`, not split into reals; the abstract type is the
  smallest one preserving the two-body reduction plus planar orientation).
- `IsAsymptoticRelativeVelocity` + `RelativeVelocityVector`: keeps `u_inf` a
  defined (limit-based) physical concept rather than a hypothesized constant.
- `orbit_eq_conic` as a theorem (not a structure field): Hint 2 stays
  derivable, as the chapter demands.
- `roundsToOfficialDegrees(Abs)`: honest “official printed value” semantics for
  a decimal-rounded exam answer.

## Grounding gaps / redraft requests

- No blocking gaps. Later-stage note: closing `signed_deflection_angle_T1_B2`
  needs (a) a real Kepler derivation from `newton_relative_law` (large), and
  (b) `Real.lt_tan`-grade estimates to extract the `±0.005°` rounding bound
  from `pi - 2 arctan(2/sqrt 63)`. Both are flagged as bridge entries 3 and 8.
- Blueprint chapter already exists and is adequate (umbrella autoformalize
  source); no redraft request. Planner may later wire `\lean{}` pins to
  `IPhO2026.Problem1.B2.signed_deflection_angle_T1_B2` once decl sets stabilize.
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

## 3. `IPhO2026Problems/problem_IPhO_2026_1_C_1.lean`

- Compile status: passed
- Open sorries: 6
- Direct-check seconds: 9.465
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_1_C_1.tex`
- Reports: `.archon/task_results/problem_IPhO_2026_1_C_1.md`, `.archon/task_results/physics-grounding-IPhO2026Problems_problem_IPhO_2026_1_C_1.md`

### Lean excerpt
```lean
* c ^ 2)) * (2 * Real.sin θ ^ 2 + 1)) :
    let E₀ := hbar * hbarOmegaMin m c dU θ
    0 < E₀ ∧
      (2 - Real.cos (2 * θ)) * E₀ ^ 2 - 6 * m * c ^ 2 * E₀ + 6 * dU * m * c ^ 2 = 0 ∧
      ∀ E : ℝ, 0 < E →
        (2 - Real.cos (2 * θ)) * E ^ 2 - 6 * m * c ^ 2 * E + 6 * dU * m * c ^ 2 = 0 →
        E₀ ≤ E := by
  sorry

/-- **Main target** (blueprint `thm:physics:IPhO_2026_1_C_1:target`,
    forward branch).  Under the positive-constant regime, for a nondegenerate
    forward scattering angle `0 < θ ≤ π/2` with a real square root in the
    candidate formula, the candidate expression `Ω(m, c, ΔU, θ)` *is* the
    dissociation threshold: it is reachable, and no smaller positive
    frequency can dissociate ozone at that angle.

    The recorded answer appears strictly on the conclusion side: the
    hypotheses carry only the physical regime, the figure angle range, and
    the algebraic nondegeneracy needed for the square root to be real. -/
theorem minimum_angular_frequency_T1_C1
    (reg : ConstantRegime) (θ : ℝ)
    (hrange : IsAngularRange θ) (hfwd : IsForwardBranch θ) (hθpos : 0 < θ)
    (hdisc : 0 ≤ 1 - (dissociationEnergyGap /
        (3 * oxygenAtomMass * speedOfLight ^ 2)) * (2 * Real.sin θ ^ 2 + 1)) :
    IsDissociationThreshold oxygenAtomMass dissociationEnergyGap θ
      (hbarOmegaMin oxygenAtomMass speedOfLight dissociationEnergyGap θ) := by
  sorry

/-- **Main target, backward branch.**  For `θ ≥ π/2` the official solution
    records that the threshold freezes at its `θ = π/2` value: the minimum
    angular frequency for dissociation at a backward angle `θ` equals the
    forward-branch threshold evaluated at `π/2`.  Again the answer occurs
    only in the conclusion. -/
theorem minimum_angular_frequency_backward_branch_T1_C1
    (reg : ConstantRegime) (θ : ℝ)
    (hrange : IsAngularRange θ) (hbwd : Real.pi / 2 ≤ θ)
    (hdisc : 0 ≤ 1 - dissociationEnergyGap /
        (3 * oxygenAtomMass * speedOfLight ^ 2)) :
    IsDissociationThreshold oxygenAtomMass dissociationEnergyGap θ
      (hbarOmegaMin oxygenAtomMass speedOfLight dissociationEnergyGap (Real.pi / 2)) := by
  sorry

/-- The forward-branch threshold formula is invariant under the
    reflection `θ ↦ π - θ`: it depends on `θ` only through `sin²θ`, and
    `sin(π - θ) = sin θ`.  This pure-math symmetry is what justifies the
    backward-branch freeze recorded in
    `minimum_angular_frequency_backward_branch_T1_C1`. -/
theorem hbarOmegaMin_pi_sub (m c dU θ : ℝ) :
    hbarOmegaMin m c dU (Real.pi - θ) = hbarOmegaMin m c dU θ := by
  sorry

end ThresholdContracts

end IPhO2026.Problem1.C1
... [leading content omitted]
```

### Blueprint excerpt
```tex
<= pi/2, omega\_min = 3*m*c\textasciicircum{}2*[1 - sqrt(1 - (Delta U/(3*m*c\textasciicircum{}2))*(2*sin(theta)\textasciicircum{}2 + 1))]/[hbar*(2*sin(theta)\textasciicircum{}2 + 1)]. For theta >= pi/2 use the same threshold evaluated at theta = pi/2.

\paragraph{Figure/image path.}
/root/proposal\_for\_physic/science-mango/ipho\_2026\_source/image/T1\_page-3.png

\paragraph{Formalization target.}
create a compiling Lean file with sorry bodies at `IPhO2026Problems/problem\_IPhO\_2026\_1\_C\_1.lean`.
The Lean declarations must preserve the physical quantities, dimensions or dimensional roles, figure labels, governing-law hypotheses, and final relation expressed by this problem.
Use Mathlib/Physlib names found through LeanExplore where available. If a domain API is missing, introduce faithful local abstractions rather than scalar placeholder aliases.

\begin{theorem}[Physics formalization target]
\label{thm:physics:IPhO_2026_1_C_1:target}
The assigned autoformalize agent should translate this physics problem into Lean declarations in the covered file, with theorem and lemma proof bodies written as `by sorry`.
\end{theorem}
\begin{proof}
This is an autoformalization task, not a proof task. Produce faithful statements that can later be proved without weakening the source contract.
\end{proof}
% NOTE: PhysLean-coverage exemption (planner-recorded, iter-002): PhysLean has no module for relativistic two-body photodissociation kinematics (see this file's physics-grounding log for the near-miss query results). Self-containment is kept with the `import Mathlib` baseline; no irrelevant Physlib import is added. This documents the resolved import policy (iter-001 review ruling) for the blueprint-doctor `missing-physlib-import` check.
% --- Archon physics formalization source end ---
... [leading content omitted]
```

### Report excerpt: `problem_IPhO_2026_1_C_1.md`
```markdown
locks definition-unfolding closures.
- `ReactionPlane` as `EuclideanSpace ℝ (Fin 2)` + `PhotonLine` unit vector —
  keeps angle/momentum laws intrinsic vector equations rather than scalar
  placeholders.
- `IsTwoBodyDissociation` — smallest law-carrying interface (vector momentum
  balance + cosine law + angle readout + NR energy balance) needed by the
  statement; no PhysLean near miss was closer, so the local structure is the
  faithful option.

## Grounding gaps / redraft requests

- PhysLean gap (no photodissociation/two-body-breakup kinematics module):
  recorded in chapter `% NOTE:`; no redraft needed.
- Toolchain gotcha worth memory: the U+2212 (minus-sign) token IS the term
  parser's subtraction identifier in this Lean v4.31.0 + Mathlib setup, but
  ONLY when NOT preceded by whitespace (any space before it makes the parser
  fail with `expected token`); ASCII `-` was used in all term positions here.
  Doc-comment U+2212 is safe.
- A bare `end` with `noncomputable section` active closes the innermost named
  *section* name only; with named `namespace`/`section` pairs, close each with
  its full dotted name (file ends `end ThresholdContracts` /
  `end IPhO2026.Problem1.C1`).
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

## 4. `IPhO2026Problems/problem_IPhO_2026_1_C_2.lean`

- Compile status: passed
- Open sorries: 2
- Direct-check seconds: 10.611
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_1_C_2.tex`
- Reports: `.archon/task_results/problem_IPhO_2026_1_C_2.md`, `.archon/task_results/physics-grounding-IPhO2026Problems_problem_IPhO_2026_1_C_2.md`

### Lean excerpt
```lean
v_six
  unfold hbarOmegaMin hbarOmegaMinAtPiDivSix
  rw [hf]
  ring

/-- The minimum photon energy `ℏ ω_min` (joules) is physically realizable:
there is a lawful dissociation state at the C.2 calibration data whose photon
energy equals the C.1 threshold value.  (Existence/matching side of the C.1
optimization — the threshold was derived precisely by minimizing over
states satisfying `IsOzonePhotodissociation`.) -/
def ThresholdRealizable (K : PhotoDissociationConstants)
    (d : C2CalibratedData K) (E : ℝ) : Prop :=
  ∃ s : DissociationState, IsOzonePhotodissociation K s ∧
    s.θ = d.θ ∧ s.m = d.m_kg ∧ s.ΔU = d.ΔU_J ∧ Constants.ℏ.val * s.ω = E

/-- **Main target** (blueprint `thm:physics:IPhO_2026_1_C_2:target`).

Assume the trusted constants, the C.2 calibration data, the smallness of the
dimensionless threshold parameter (so the square root in the C.1 formula is
real), and physical realizability of the C.1 threshold at these data.  Then
the minimum photon energy in excess of the dissociation threshold, expressed
in eV, is the tiny positive value recorded in the problem:

`ℏ ω_min − ΔU ≈ 2.03e-11 eV`, certified here by the rigorous two-sided
enclosure `2.02e-11 < (ℏ ω_min − ΔU)/eV < 2.04e-11`.

The conclusion is asserted, not assumed: none of the hypotheses mentions the
numerical value of `ℏ ω_min − ΔU`. -/
theorem excess_photon_energy_at_threshold
    (K : PhotoDissociationConstants) (hK : K = PhotoDissociationConstants.trusted)
    (d : C2CalibratedData K)
    (h_small : d.ratio < 2 / 3)
    (h_ratio_pos : 0 < d.ratio)
    (h_real : ThresholdRealizable K d
      (hbarOmegaMin (d.m_kg * K.cSI ^ 2) d.ΔU_J d.θ)) :
    let gap_eV := (hbarOmegaMin (d.m_kg * K.cSI ^ 2) d.ΔU_J d.θ - d.ΔU_J) / K.eV
    0 < gap_eV ∧ |gap_eV - 2.03e-11| < 5e-14 := by
  sorry

/-- Helper form of the main target using the simplified `θ = π/6` threshold:
with `r = ΔU/(3mc²)`, the excess in eV is
`(2 m c² (1 − √(1 − 3r/2)) − ΔU) / eV ≈ 2.03e-11`.  Proof route: rewrite the
C.1 formula via `hbarOmegaMin_at_pi_div_six`, linearize
`1 − √(1 − ε) ≈ ε/2 + ε²/8` at `ε = 3r/2 ≈ 2.44e-11`, and confirm the
surviving `ε²/8` term contributes `≈ 2.03·10⁻¹¹ eV` after dividing by the eV
the eV-in-joules factor. -/
theorem excess_photon_energy_pi_div_six_form
    (K : PhotoDissociationConstants) (hK : K = PhotoDissociationConstants.trusted)
    (d : C2CalibratedData K)
    (h_small : d.ratio < 2 / 3)
    (h_ratio_pos : 0 < d.ratio) :
    let gap_eV := (hbarOmegaMinAtPiDivSix (d.m_kg * K.cSI ^ 2) d.ratio - d.ΔU_J) / K.eV
    0 < gap_eV ∧ |gap_eV - 2.03e-11| < 5e-14 := by
  sorry

end IPhO2026_1_C_2
... [leading content omitted]
```

### Blueprint excerpt
```tex
f hbar, c, theta, Delta U, and m. Reusable conclusions: For theta <= pi/2, omega\_min = 3*m*c\textasciicircum{}2*[1 - sqrt(1 - (Delta U/(3*m*c\textasciicircum{}2))*(2*sin(theta)\textasciicircum{}2 + 1))]/[hbar*(2*sin(theta)\textasciicircum{}2 + 1)]. For theta >= pi/2 use the same threshold evaluated at theta = pi/2. Policy: natural\_language\_prerequisite\_only; do\_not\_import\_Lean\_output
\end{itemize}

\paragraph{Formalization target.}
create a compiling Lean file with sorry bodies at `IPhO2026Problems/problem\_IPhO\_2026\_1\_C\_2.lean`.
The Lean declarations must preserve the physical quantities, dimensions or dimensional roles, figure labels, governing-law hypotheses, and final relation expressed by this problem.
Use Mathlib/Physlib names found through LeanExplore where available. If a domain API is missing, introduce faithful local abstractions rather than scalar placeholder aliases.

\begin{theorem}[Physics formalization target]
\label{thm:physics:IPhO_2026_1_C_2:target}
The assigned autoformalize agent should translate this physics problem into Lean declarations in the covered file, with theorem and lemma proof bodies written as `by sorry`.
\end{theorem}
\begin{proof}
This is an autoformalization task, not a proof task. Produce faithful statements that can later be proved without weakening the source contract.
\end{proof}
% NOTE: PhysLean-coverage exemption (planner-recorded, iter-002): PhysLean has no module for this photodissociation-threshold regime (see this file's physics-grounding log). Self-containment is kept with the `import Mathlib` baseline; no irrelevant Physlib import is added. This documents the resolved import policy (iter-001 review ruling) for the blueprint-doctor `missing-physlib-import` check.
% --- Archon physics formalization source end ---
... [leading content omitted]
```

### Report excerpt: `problem_IPhO_2026_1_C_2.md`
```markdown
= pi/6` (`theta_val`), not only in
  the final conclusion; the `theta >= pi/2` branch is irrelevant at these
  data.

## Declarations and blueprint labels

- `IPhO2026_1_C_2.hbarOmegaMin_at_pi_div_six` — now fully proved (the repair
  target); supports `thm:physics:IPhO_2026_1_C_2:target`.
- `IPhO2026_1_C_2.excess_photon_energy_at_threshold` — main umbrella target
  `thm:physics:IPhO_2026_1_C_2:target`, still `by sorry` by design.
- All other declarations unchanged from the iter-002 baseline snapshot.

## LeanExplore / grounding

No new LeanExplore queries were needed for this one-line algebraic repair
(`ring` from Mathlib's tactic suite). Prior grounding log:
`.archon/task_results/physics-grounding-IPhO2026Problems_problem_IPhO_2026_1_C_2.md`
records Mathlib `Real.sqrt`, `Real.sin_pi_div_six`; PhysLean `SpeedOfLight`,
`Constants.hbar`. The file retains its pre-existing blanket `import Physlib` —
left as-is to avoid churn beyond the assigned repair; the chapter `% NOTE:`
records the PhysLean-coverage exemption.

## Grounding gaps / redraft requests

None. The file is ready for the deterministic per-file gate; the two remaining
`sorry`s are the intended autoformalize-stage targets.
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

## 5. `IPhO2026Problems/problem_IPhO_2026_2_C_4.lean`

- Compile status: passed
- Open sorries: 1
- Direct-check seconds: 9.353
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_2_C_4.tex`
- Reports: `.archon/task_results/problem_IPhO_2026_2_C_4.md`, `.archon/task_results/physics-grounding-IPhO2026Problems_problem_IPhO_2026_2_C_4.md`

### Lean excerpt
```lean
ilter: the set of angles satisfying `InSmallAngleRegime` is a neighborhood
of `0` within the positive angles, so statements eventually true along
`smallAngleFilter` apply to it (proved, not assumed). -/
theorem smallAngleRegime_mem_filter :
    {θ : ℝ | InSmallAngleRegime θ} ∈ smallAngleFilter := by
  rw [smallAngleFilter, mem_nhdsWithin]
  exact ⟨Set.Iio 1, isOpen_Iio, by simp, fun θ hθ => ⟨hθ.2, hθ.1⟩⟩

/-- The `θ ≪ 1` power-law form of a parametric plane curve `θ ↦ (X θ, Y θ)`:
the coordinate functions have a well-defined positive leading-order balance
as `θ → 0⁺`, i.e. they are asymptotically equivalent
(`Asymptotics.IsEquivalent`, `f ~[l] g`) along the small-angle filter:
`Y θ ~ v * X θ ^ (p / q) + u` and `X θ ~ w * θ ^ q` for some positive scale
`w`. The exponent is a positive rational; `u`, `v` carry the dimension of
length and `p / q` is dimensionless. This is the genuine asymptotic content
of the subquestion: the two sides agree to leading order without being
required to coincide exactly (they do not for the mirror caustic). All
quantities are parameters of the definition, so nothing here is specialized
to the recorded answer. -/
def CausticPowerLawForm (X Y : ℝ → ℝ) (u v : ℝ) (p q : ℕ) : Prop :=
  0 < p ∧ 0 < q ∧
  (fun θ : ℝ => Y θ) ~[smallAngleFilter]
    (fun θ => v * X θ ^ ((p : ℝ) / (q : ℝ)) + u) ∧
  ∃ w : ℝ, 0 < w ∧
    (fun θ : ℝ => X θ) ~[smallAngleFilter] (fun θ => w * θ ^ q)

/-- The power-law form with the recorded constants of subquestion C.4 made
explicit: the vertical shift `u` and the prefactor `v` are the ones determined
from the mirror geometry, with exponent `p / q = 2 / 3`. -/
def SatisfiesCausticPowerLaw (X Y : ℝ → ℝ) (R u v : ℝ) : Prop :=
  u = R / 2 ∧
  v = (3 / 4) * R ^ ((1 : ℝ) / 3) ∧
  CausticPowerLawForm X Y u v 2 3

namespace HalfCylindricalMirrorCaustic

variable (c : HalfCylindricalMirrorCaustic)

/-- Main formalization target for C.4: in the small-angle regime `θ ≪ 1`, the
caustic of the half-cylindrical mirror has the power-law form
`Y_c = v * |X_c| ^ (p / q) + u` with the recorded constants
`u = R / 2`, `v = (3 / 4) * R ^ (1 / 3)`, `p = 2`, `q = 3`, read as
asymptotic agreement to leading order as `θ → 0⁺`. The `|X_c|` of the source
statement is subsumed by the positive-angle branch encoded in
`smallAngleFilter`, where `X_c θ = R * sin θ ^ 3` is positive. All recorded
constants appear on the conclusion side only. -/
theorem caustic_small_angle_power_law :
    SatisfiesCausticPowerLaw c.X_c c.Y_c c.R (c.R / 2)
      ((3 / 4) * c.R ^ ((1 : ℝ) / 3)) := by
  sorry

end HalfCylindricalMirrorCaustic

end IPhO2026_2_C_4
... [leading content omitted]
```

### Blueprint excerpt
```tex
age-4.png

\paragraph{Reusable previous-part conclusions.}
\begin{itemize}
\item Source C.3. Question: Find the limiting intersection coordinates (X\_c,Y\_c) of the neighboring reflected rays. Reusable conclusions: X\_c = R*sin(theta)\textasciicircum{}3; Y\_c = (R/2)*cos(theta)*(2 - cos(2*theta)). Policy: natural\_language\_prerequisite\_only; do\_not\_import\_Lean\_output
\end{itemize}

\paragraph{Formalization target.}
create a compiling Lean file with sorry bodies at `IPhO2026Problems/problem\_IPhO\_2026\_2\_C\_4.lean`.
The Lean declarations must preserve the physical quantities, dimensions or dimensional roles, figure labels, governing-law hypotheses, and final relation expressed by this problem.
Use Mathlib/Physlib names found through LeanExplore where available. If a domain API is missing, introduce faithful local abstractions rather than scalar placeholder aliases.

\begin{theorem}[Physics formalization target]
\label{thm:physics:IPhO_2026_2_C_4:target}
The assigned autoformalize agent should translate this physics problem into Lean declarations in the covered file, with theorem and lemma proof bodies written as `by sorry`.
\end{theorem}
\begin{proof}
This is an autoformalization task, not a proof task. Produce faithful statements that can later be proved without weakening the source contract.
\end{proof}
% NOTE: PhysLean-coverage exemption (planner-recorded, iter-002): PhysLean has no caustic/power-law asymptotics module for the small-angle caustic part (see this file's physics-grounding log). Self-containment is kept with the `import Mathlib` baseline; no irrelevant Physlib import is added. This documents the resolved import policy (iter-001 review ruling) for the blueprint-doctor `missing-physlib-import` check.
% --- Archon physics formalization source end ---
... [leading content omitted]
```

### Report excerpt: `problem_IPhO_2026_2_C_4.md`
```markdown
lter`, `Set.Ioi`.
- PhysLean: none — chapter carries the iter-002 `% NOTE:` PhysLean-coverage
  exemption (no caustic/power-law asymptotics module); `import Mathlib`
  baseline kept.

## Local abstractions (why faithful)

- `CausticPowerLawForm` uses Mathlib's real asymptotic-equivalence API rather
  than inventing a bespoke `∃ δ`-identity, because the exact-identity reading
  is false; the abstract `u v p q` parameters keep it answer-free.
- Structure fields for `m_A b_A m_B b_B` keep the Figure 2g ray data
  physically present even though only their envelope limit enters C.4.

## Grounding gaps / redraft requests

- None blocking. Note for the future prover lane: the proof of the main
  target will need `sin θ ~ θ` / `cos θ = 1 − θ²/2 + o(θ²)` asymptotics
  along `nhdsWithin 0 (Ioi 0)` plus `IsEquivalent` congruence under
  `rpow`-powers — standard but nontrivial; the statement is now true and
  proof-ready.
- Blueprint chapter: unchanged by me (not permitted). The informal text's
  "put the caustic in the form" should be read asymptotically; planner may
  want to add a one-line note that the exact-identity reading is false.
  `\leanok` markers are left to the deterministic sync.
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

## 6. `IPhO2026Problems/problem_IPhO_2026_3_A_1.lean`

- Compile status: passed
- Open sorries: 6
- Direct-check seconds: 9.845
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_3_A_1.tex`
- Reports: `.archon/task_results/problem_IPhO_2026_3_A_1.md`, `.archon/task_results/physics-grounding-IPhO2026Problems_problem_IPhO_2026_3_A_1.md`

### Lean excerpt
```lean
elation until the
final theorem assembles them.  In this autoformalization stage their bodies
are `sorry`. -/

/-- Bridge 1 — Ampère's law in the uniform regime:
`2πR · (N · H) = N · I` (the circulation of the uniform magnitude along the
mean path equals the total free current readout `N·I` threading the loop). -/
theorem ampere_uniform_eq (T : ParamagneticTorusA1) :
    2 * Real.pi * T.meanRadius * ((T.numTurns : ℝ) * T.fieldMagnitude)
      = (T.numTurns : ℝ) * T.wireCurrent.readout := by
  sorry

/-- Bridge 2 — solve the circulation equation for `H` along the mean path:
`H = N·I / (2πR)` (uses `N ≠ 0`, `R > 0`, `π > 0`). -/
theorem fieldMagnitude_eq_meanRadius_form (T : ParamagneticTorusA1) :
    T.fieldMagnitude
      = (T.numTurns : ℝ) * T.wireCurrent.readout
          / (2 * Real.pi * T.meanRadius) := by
  sorry

/-- Bridge 3 — geometry bridge: `2πR = V / A`, rewriting the mean-path
length in terms of the torus volume and cross-sectional area. -/
theorem mean_circumference_eq (T : ParamagneticTorusA1) :
    2 * Real.pi * T.meanRadius = T.volume / T.crossSectionArea := by
  sorry

/-- Bridge 4 — the figure parametrization of the answer along the mean
path: `N·I/(2πR) = N·I·A/V`. -/
theorem meanRadius_form_eq_volume_form (T : ParamagneticTorusA1) :
    (T.numTurns : ℝ) * T.wireCurrent.readout / (2 * Real.pi * T.meanRadius)
      = (T.numTurns : ℝ) * T.wireCurrent.readout * T.crossSectionArea
          / T.volume := by
  sorry

end ParamagneticTorusA1

/-! ### Main target theorem (T3-A1) -/

/-- **Part A.1 target**: the magnitude `H` of the field `H⃗` inside the
paramagnetic torus, expressed in terms of `N`, `A`, `V` and the
instantaneous current `I` in the wire, is

`H = N·I·A / V`.

Derivation route (informal): by Ampère's law `∮ H·dℓ = I_C` applied to the
mean amperian loop of length `2πR`, and by the uniformity of the field
magnitude in the thin torus, `2πR·(N·H) = N·I`; solving for `H` and using
the torus geometry `V = 2πR·A` gives `H = N·I/(2πR) = N·I·A/V`. -/
theorem paramagneticTorus_H_eq (T : ParamagneticTorusA1) :
    T.fieldMagnitude
      = (T.numTurns : ℝ) * T.wireCurrent.readout * T.crossSectionArea
          / T.volume := by
  sorry

/-- Equivalent mean-radius form of the Part A.1 answer:
`H = N·I / (2πR)`, the form one obtains directly from Ampère's law before
substituting the torus geometry `V = 2πR·A`. -/
theorem paramagneticTorus_H_eq_meanRadius (T : ParamagneticTorusA1) :
    T.fieldMagnitude
      = (T.numTurns : ℝ) * T.wireCurrent.readout
          / (2 * Real.pi * T.meanRadius) := by
  sorry

end PartA1
end Problem3
end IPhO2026
... [leading content omitted]
```

### Blueprint excerpt
```tex
ource.}
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
create a compiling Lean file with sorry bodies at `IPhO2026Problems/problem\_IPhO\_2026\_3\_A\_1.lean`.
The Lean declarations must preserve the physical quantities, dimensions or dimensional roles, figure labels, governing-law hypotheses, and final relation expressed by this problem.
Use Mathlib/Physlib names found through LeanExplore where available. If a domain API is missing, introduce faithful local abstractions rather than scalar placeholder aliases.

\begin{theorem}[Physics formalization target]
\label{thm:physics:IPhO_2026_3_A_1:target}
The assigned autoformalize agent should translate this physics problem into Lean declarations in the covered file, with theorem and lemma proof bodies written as `by sorry`.
\end{theorem}
\begin{proof}
This is an autoformalization task, not a proof task. Produce faithful statements that can later be proved without weakening the source contract.
\end{proof}
% --- Archon physics formalization source end ---
... [leading content omitted]
```

### Report excerpt: `problem_IPhO_2026_3_A_1.md`
```markdown
grounded and used: `Fintype.card_congr`, `Fintype.card_fin`, `Finset.card_univ`,
  `Finset.sum_const`, `Finset.sum_congr`, `nsmul_eq_mul`, `Real.pi`, `Real.pi_pos`, `two_pos`, `mul_pos`,
  `ne_of_gt`, `div_mul_cancel₀`, `field_simp`, `congrArg`.

## Local abstractions (why they preserve physical meaning)

`FiniteWinding` keeps the winding genuinely finite and counted; `InstantaneousCurrent` keeps the quantity
typed with an explicit scalar projection; `AmpereLaw*` structures state the *law* (circulation equation),
not the answer; `UniformFieldMag` states the source uniformity as equations; `VacuumCoreIdentity`
records the paramagnetic constitutive law for downstream T3 parts. All expose equations/inequalities/
eliminations usable by later proofs (see countermodel audit).

## Grounding gaps / redraft requests

- No PhysLean import attached: no near module exists for toroidal magnetostatics/Ampère-law windings
  (checked `Physlib/Electromagnetism` tree); the import-policy exemption for this problem is recorded
  planner-side in the chapter `% NOTE:` convention per the iter-002 reconciliation.
- No redraft requests; the file is self-contained (`import Mathlib` only, no cross-imports).
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

## 7. `IPhO2026Problems/problem_IPhO_2026_3_A_2.lean`

- Compile status: passed
- Open sorries: 2
- Direct-check seconds: 9.26
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_3_A_2.tex`
- Reports: `.archon/task_results/problem_IPhO_2026_3_A_2.md`, `.archon/task_results/physics-grounding-IPhO2026Problems_problem_IPhO_2026_3_A_2.md`

### Lean excerpt
```lean
by `A · dB`, so the source supplies `emf · dt = N · A · dB` against the
induced EMF.  The field is an equation, so it eliminates to a usable constraint
in proofs; it is the physical law of induction, not the Part A.2 answer (the
answer expresses the work as `V · H · dB`, which does not appear here). -/
structure InducedEMFChange (t : ToroidData) where
  /-- Electromotive force across the winding during the change. -/
  emf : ℝ
  /-- Elapsed (short) time of the change. -/
  dt : ℝ
  /-- Change of the magnetic flux density inside the torus. -/
  dB : ℝ
  /-- The elapsed time is strictly positive. -/
  dt_pos : IsPositive dt
  /-- Faraday's law integrated over the change: `emf · dt = N · A · dB`. -/
  faraday : emf * dt = t.N * t.A * dB

/-- Energy amount delivered by the external voltage source to the torus
circuit, as a typed scalar quantity with its sign convention: positive means
work entering the paramagnetic torus (the IPhO T3 convention).  The wrapper
distinguishes this physical energy readout from a bare real number; `val` is
the documented scalar projection.  No nonnegativity invariant is bundled:
withdrawal of energy (`dW < 0`), as when `B` decreases, is physical. -/
structure WorkOnSource where
  /-- The scalar energy readout, positive when work enters the torus. -/
  val : ℝ

/-- The work performed by the external voltage source over an induced-EMF
change at operating point `op`: the electrical power `emf · I` integrated
over the elapsed time `dt`.  This is the energy-balance law of a voltage
source (`P = ε · I`); by itself it does not state the Part A.2 answer. -/
noncomputable def sourceWork (fs : FreeSpace) (t : ToroidData)
    (op : UniformToroidOperatingPoint fs t) (e : InducedEMFChange t) :
    WorkOnSource :=
  ⟨e.emf * op.I * e.dt⟩

/-- **Part A.2 target.**  Under an infinitesimal change `dB` of the magnetic
flux density, the work performed by the external voltage source is
`dW_emf = V · H · dB` (recorded official answer, conclusion-side only).
The sign convention is that work entering the paramagnetic torus is positive,
so a positive `dW_emf` corresponds to energy delivered by the source.
The conclusion is not among the hypotheses: the assumptions are the governing
laws (constitutive relation, Ampère's law, Faraday's law, ring-volume law,
source power law), and reaching `V · H · dB` still requires combining them. -/
theorem work_emf_eq_V_mul_H_mul_dB
    (fs : FreeSpace) (t : ToroidData) (op : UniformToroidOperatingPoint fs t)
    (e : InducedEMFChange t) :
    sourceWork fs t op e = ⟨t.V * op.H * e.dB⟩ := by
  sorry

end IPhO2026_3_A_2
... [leading content omitted]
```

### Blueprint excerpt
```tex
_0*H + mu\_0*M, Ampere's law, and the sign convention that work and
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
create a compiling Lean file with sorry bodies at `IPhO2026Problems/problem\_IPhO\_2026\_3\_A\_2.lean`.
The Lean declarations must preserve the physical quantities, dimensions or dimensional roles, figure labels, governing-law hypotheses, and final relation expressed by this problem.
Use Mathlib/Physlib names found through LeanExplore where available. If a domain API is missing, introduce faithful local abstractions rather than scalar placeholder aliases.

\begin{theorem}[Physics formalization target]
\label{thm:physics:IPhO_2026_3_A_2:target}
The assigned autoformalize agent should translate this physics problem into Lean declarations in the covered file, with theorem and lemma proof bodies written as `by sorry`.
\end{theorem}
\begin{proof}
This is an autoformalization task, not a proof task. Produce faithful statements that can later be proved without weakening the source contract.
\end{proof}
% --- Archon physics formalization source end ---
... [leading content omitted]
```

### Report excerpt: `problem_IPhO_2026_3_A_2.md`
```markdown
cture, fields `ε₀ μ₀`, positivity) — via
  `import Physlib.Electromagnetism.Dynamics.Basic` (the ONE allowed targeted
  Physlib import; genuinely used for `fs.μ₀`).
- `Real.pi` — via Mathlib baseline.

## Local abstractions and why they preserve meaning

- `IsPositive`, `WorkOnSource` — typed roles without fake physics.
- `InducedEMFChange.faraday`, `ToroidData.volume_eq`, `…ampere`,
  `…constitutive` — law equations, not answer-rewrites.
Scalar `ℝ` readouts (`emf, dt, dB, I, H, B, M, R, r, A, V, N`) are fine per
the modeling rules (measured scalar components); no `abbrev X := ℝ` aliases.

## Grounding gaps

- PhysLean has no circuit-level Faraday/EMF declaration or energy/work type
  near `Electromagnetism.Dynamics` — local laws used instead (see query log
  above). Preflight grounding log
  (`physics-grounding-IPhO2026Problems_problem_IPhO_2026_3_A_2.md`) contains
  only unrelated `Physics formalization target` hits — no usable candidates.

## Verification

```
lake env lean IPhO2026Problems/problem_IPhO_2026_3_A_2.lean
  96:6  warning: declaration uses sorry   (fieldStrength_eq_N_mul_I_mul_A_div_V)
  150:8 warning: declaration uses sorry   (work_emf_eq_V_mul_H_mul_dB)
exit 0
```
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

## 8. `IPhO2026Problems/problem_IPhO_2026_3_B_1.lean`

- Compile status: passed
- Open sorries: 3
- Direct-check seconds: 9.39
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_3_B_1.tex`
- Reports: `.archon/task_results/problem_IPhO_2026_3_B_1.md`, `.archon/task_results/physics-grounding-IPhO2026Problems_problem_IPhO_2026_3_B_1.md`

### Lean excerpt
```lean
the initial and
final states of the isothermal field change: the difference of the tracked
cumulative heat readout.  This is the quantity the target theorem
characterizes; the recorded answer is its closed form, which must still be
derived — nothing asserts it in advance. -/
noncomputable def heatTransferredIntoTorus (p : TorusParams)
    (proc : IsothermalFieldChange p) : ℝ :=
  proc.Q_in (proc.M_of_H proc.H_f) - proc.Q_in (proc.M_of_H proc.H_i)

/-- **Target.** Along an isothermal field change of the paramagnetic torus
satisfying the equation of state, with the magnetic work `dW = μ₀ V H dM`
of part A.3 (recorded in the first-law density below) and the first law of
thermodynamics, the heat transferred into the torus
(`heatTransferredIntoTorus`, the difference of the tracked heat readout
between the final and initial states) equals the recorded closed form

`Q = -(μ₀ * n * K / (2 * T)) * (H_f^2 - H_i^2)`

(`heat_into_torus_value`).  No hypothesis states this closed form: the
first-law hypothesis only supplies leg balances `Q_in M_target - Q_in M₀ =
(U T − U T) − ∫ M₀..M_target workDensity` against the demagnetized
reference, and deriving the value of the integral is the proof obligation:
`leg_work_integral_eval` (built on `magnetization_eq_eos_solution` +
`leg_mem_tracked_range` + `intervalIntegral.integral_congr` +
`intervalIntegral.integral_const_mul` + `integral_id`) evaluates each leg,
then `magnetization_eq_eos_solution` at `H_i, H_f` and `field_simp`/`ring`
reduce the difference to the closed form.

Blueprint label: `thm:physics:IPhO_2026_3_B_1:target`. -/
theorem isothermal_heat_into_torus (p : TorusParams) (U : ℝ → ℝ)
    (proc : IsothermalFieldChange p)
    (hU : HasHeatCapacityLaw p U)
    (hV : p.V ≠ 0)
    (h_first_law : ∀ (workDensity : ℝ → ℝ),
      IsMagneticWorkDensity p proc.M_of_H workDensity →
      ObeysFirstLawMagnetic p U proc.T workDensity proc.Q_in)
    (Q : ℝ) (hQ : Q = heatTransferredIntoTorus p proc) :
    Q = heat_into_torus_value p proc := by
  sorry

/-- **Recorded official answer (checking form).** The heat
`heat_into_torus_value p proc` carried by the target theorem equals the
closed form recorded in the answer key,

`Q = -(μ₀ * n * K / (2 * T)) * (H_f^2 - H_i^2)`.

This is conclusion-side only: it pins the closed form of
`heat_into_torus_value`, it is not used as a hypothesis of any theorem. -/
theorem official_answer_value (p : TorusParams)
    (proc : IsothermalFieldChange p) :
    heat_into_torus_value p proc =
      -(p.mu0 * p.n * p.K / (2 * proc.T)) * (proc.H_f ^ 2 - proc.H_i ^ 2) :=
  rfl
end IPhO2026.Problem3.B1
... [leading content omitted]
```

### Blueprint excerpt
```tex
ngo/ipho\_2026\_source/image/T3\_page-3.png

\paragraph{Reusable previous-part conclusions.}
\begin{itemize}
\item Source A.3. Question: Subtract the vacuum-core contribution and write the work dW done on the paramagnetic material. Reusable conclusions: dW = mu\_0*V*H*dM. Policy: natural\_language\_prerequisite\_only; do\_not\_import\_Lean\_output
\end{itemize}

\paragraph{Formalization target.}
create a compiling Lean file with sorry bodies at `IPhO2026Problems/problem\_IPhO\_2026\_3\_B\_1.lean`.
The Lean declarations must preserve the physical quantities, dimensions or dimensional roles, figure labels, governing-law hypotheses, and final relation expressed by this problem.
Use Mathlib/Physlib names found through LeanExplore where available. If a domain API is missing, introduce faithful local abstractions rather than scalar placeholder aliases.

\begin{theorem}[Physics formalization target]
\label{thm:physics:IPhO_2026_3_B_1:target}
The assigned autoformalize agent should translate this physics problem into Lean declarations in the covered file, with theorem and lemma proof bodies written as `by sorry`.
\end{theorem}
\begin{proof}
This is an autoformalization task, not a proof task. Produce faithful statements that can later be proved without weakening the source contract.
\end{proof}
% NOTE: PhysLean-coverage exemption (planner-recorded, iter-002): PhysLean's thermodynamics modules do not cover this paramagnetic-torus magnetic-work/isothermal-first-law model (see this file's physics-grounding log). Self-containment is kept with the `import Mathlib` baseline; no irrelevant Physlib import is added. This documents the resolved import policy (iter-001 review ruling) for the blueprint-doctor `missing-physlib-import` check.
% --- Archon physics formalization source end ---
... [leading content omitted]
```

### Report excerpt: `problem_IPhO_2026_3_B_1.md`
```markdown
name only;
  `heatTransferredIntoTorus` — the physical readout the theorem speaks
  about; the proof obligation is their equality.

## Grounding gaps / redraft requests

- PhysLean has no ready paramagnet EOS / magnetic-work / thermodynamic
  first-law module at the searched revision (queries above); local law
  abstractions used — matches the chapter's PhysLean-coverage exemption
  (`% NOTE:`, planner-recorded iter-002).
- Preflight grounding log
  (`.archon/task_results/physics-grounding-IPhO2026Problems_problem_IPhO_2026_3_B_1.md`)
  contains only `Physics formalization target` noise hits — no usable
  candidates.
- No redraft requests; no missing bridges remain: the two unproved bridges
  are statement-faithful and their proof routes are recorded (bridge table
  #6/#7).

## Verification

```
lake env lean IPhO2026Problems/problem_IPhO_2026_3_B_1.lean
  201:8  warning: declaration uses `sorry`   (leg_mem_tracked_range)
  223:8  warning: declaration uses `sorry`   (leg_work_integral_eval)
  263:8  warning: declaration uses `sorry`   (isothermal_heat_into_torus)
exit 0
```
LSP diagnostics (`lean_diagnostic_messages`) return exactly the same three
sorry warnings and no other items.
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

## 9. `IPhO2026Problems/problem_IPhO_2026_3_C_2.lean`

- Compile status: passed
- Open sorries: 10
- Direct-check seconds: 9.343
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_3_C_2.tex`
- Reports: `.archon/task_results/problem_IPhO_2026_3_C_2.md`, `.archon/task_results/physics-grounding-IPhO2026Problems_problem_IPhO_2026_3_C_2.md`

### Lean excerpt
```lean
.Qc = (p.μ₀ * p.V / 2) * (m.q .v3 - m.q .v2) := by
  sorry

/-- The Carnot heat ratio combined with the two leg identities `Qh_eq`,
`Qc_eq` gives the scalar relation
$T_c\,q_1 = (T_c - T_h)\,q_4 + T_h\,q_3$
among the state-function values at the vertices.  Here
$q_3 = q_2 = T_c M_2^2$ on the shared adiabat is what turns the right-hand
side into the C.2 numerator in the next lemmas. -/
lemma q_relation : m.Tc * m.q .v1 = (m.Tc - m.Th) * m.q .v4 + m.Th * m.q .v3 := by
  sorry

/-- Adiabatic-leg book-keeping: the state function at vertex $4$ equals
$q_4 = T_c M_2^2$ (the common value of $q$ on the adiabat through states
$2$ and $3$).

Physical content: the adiabatic legs $2\to3$ and $4\to1$ transfer no heat
and retrace the same adiabat between the same two field endpoints, so
$q_3 = q_2$ and $q_4$ sits at that same value.  Formally this equation is
derived from `Qh_eq`, `Qc_eq`, `q_relation`, and $q_3 = T_c M_2^2$ (which
uses $T_2 = T_3$, i.e. states $2,3$ sharing the adiabat's cold end); it is
*stated as an equation* so it can be rewritten with, and it is eliminable —
it does not mention $M_1$, so it cannot unfold to the C.2 answer. -/
lemma q4_eq_adiabatic_41 : m.q .v4 = m.Tc * m.M2 ^ 2 := by
  sorry

/-- The values of $q$ at the cold vertices coincide with the magnetization
data: $q_3 = T_c M_2^2$ (since states $2,3$ lie on the same adiabat) and is
also equal to $T_c M_3^2$ — the two express $M_3$ in terms of $M_2$ along the
adiabatic leg $2\to3$.  Formally: $q_3 = T_c M_3^2$ (definition of $q$ with
$T_3 = T_c$) and $q_3 = q_2 = T_c M_2^2$ (common adiabat). -/
lemma q3_eq : m.q .v3 = m.Tc * m.M2 ^ 2 := by
  sorry

/-- The squared vertex-1 magnetization:
$M_1^2 = M_2^2 - M_3^2 + M_4^2$.
Carrier: `q_relation` divided by $T_h$, with `q4_eq_adiabatic_41`, `q3_eq`,
and $q_1 = T_h M_1^2$, $q_4 = T_h M_4^2$ (definitions of $q$ with
$T_1 = T_4 = T_h$). -/
theorem m1_sq : m.M1 ^ 2 = m.M2 ^ 2 - m.M3 ^ 2 + m.M4 ^ 2 := by
  sorry

/-- **Subquestion C.2 (main target).**
The magnitude of $\vec M$ at vertex $1$ of the Carnot refrigeration cycle is

$M_1 = \sqrt{M_2^2 - M_3^2 + M_4^2}$,

with the nonnegative square root selected because $M_1$ is a magnitude. -/
theorem m1_eq_sqrt : m.M1 = Real.sqrt (m.M2 ^ 2 - m.M3 ^ 2 + m.M4 ^ 2) := by
  sorry

/-- The quantity under the root is nonnegative, as it must be for a physical
magnetization magnitude: $0 \le M_2^2 - M_3^2 + M_4^2$.
Carrier: `m1_sq` together with `M_nonneg .v1` ($0 \le M_1^2$). -/
theorem m1_sq_arg_nonneg : 0 ≤ m.M2 ^ 2 - m.M3 ^ 2 + m.M4 ^ 2 := by
  sorry

end CarnotMagnetizationModel

end IPhO2026.Problem3.C2
... [leading content omitted]
```

### Blueprint excerpt
```tex
\_only; do\_not\_import\_Lean\_output
\item Source C.1. Question: Label T\_h and T\_c on Figure 3b and identify the processes on which Q\_h and Q\_c are transferred. Reusable conclusions: States 1 and 4 lie at T\_h; states 2 and 3 lie at T\_c. Q\_c is absorbed on 2->3, and Q\_h is delivered on 4->1. Policy: natural\_language\_prerequisite\_only; do\_not\_import\_Lean\_output
\end{itemize}

\paragraph{Formalization target.}
create a compiling Lean file with sorry bodies at `IPhO2026Problems/problem\_IPhO\_2026\_3\_C\_2.lean`.
The Lean declarations must preserve the physical quantities, dimensions or dimensional roles, figure labels, governing-law hypotheses, and final relation expressed by this problem.
Use Mathlib/Physlib names found through LeanExplore where available. If a domain API is missing, introduce faithful local abstractions rather than scalar placeholder aliases.

\begin{theorem}[Physics formalization target]
\label{thm:physics:IPhO_2026_3_C_2:target}
The assigned autoformalize agent should translate this physics problem into Lean declarations in the covered file, with theorem and lemma proof bodies written as `by sorry`.
\end{theorem}
\begin{proof}
This is an autoformalization task, not a proof task. Produce faithful statements that can later be proved without weakening the source contract.
\end{proof}
% NOTE: PhysLean-coverage exemption (planner-recorded, iter-002): PhysLean has no Carnot-cycle-on-(M,H,T) module for this magnetization-relation part (see this file's physics-grounding log). Self-containment is kept with the `import Mathlib` baseline; no irrelevant Physlib import is added. This documents the resolved import policy (iter-001 review ruling) for the blueprint-doctor `missing-physlib-import` check.
% --- Archon physics formalization source end ---
... [leading content omitted]
```

### Report excerpt: `problem_IPhO_2026_3_C_2.md`
```markdown
`Vertex`, `CarnotCycle`, `TorusParams`,
    `EquationOfStateParamagnet`, `ParamagnetState`,
    `IsothermalHeatIntoTorus`, `CarnotHeatRatio`, `Figure3bAssignment`,
    `CarnotMagnetizationModel` (+ `M1..M4`, `q`, `vertex_T_pos`,
    `heat_isothermal_via_q`, `Qh_eq`, `Qc_eq`, `q_relation`,
    `q4_eq_adiabatic_41`, `q3_eq`, `m1_sq`, `m1_eq_sqrt`,
    `m1_sq_arg_nonneg`).
  - `\leanok`: owned by the deterministic sync — left untouched (chapter was
    not edited; per AGENTS.md the sync applies markers).

## LeanExplore grounding

  - Reused from preflight log
    `.archon/task_results/physics-grounding-IPhO2026Problems_problem_IPhO_2026_3_C_2.md`:
    `Real.sqrt` (Mathlib, `Mathlib.Analysis.Real.Sqrt`) grounded and used in
    `m1_eq_sqrt`. No new names invented this iter. PhysLean has no
    Carnot-on-(M,H,T) module; the chapter `% NOTE:` (planner, iter-002)
    records the missing-physlib-import exemption — `import Mathlib` baseline
    kept, no Physlib import bolted on.

## Grounding gaps / redraft requests

  - None. File passes the per-file gate: `lake env lean` clean, only the 10
    expected `sorry` warnings remain (all `by sorry`, per the
    by-sorry formalization contract).
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

## 10. `IPhO2026Problems/problem_IPhO_2026_3_C_3.lean`

- Compile status: passed
- Open sorries: 8
- Direct-check seconds: 9.731
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_3_C_3.tex`
- Reports: `.archon/task_results/IPhO2026Problems_problem_IPhO_2026_3_C_3.md`, `.archon/task_results/physics-grounding-IPhO2026Problems_problem_IPhO_2026_3_C_3.md`

### Lean excerpt
```lean
2 * r.Th)) * (r.H4 ^ 2 - r.H3 ^ 2) := by
  sorry

/-- Consistency of the supplied vertex data with the reversible cycle:
combining the two leg identities with the Carnot heat ratio gives

    (H₁² − H₂²) · T_h² = (H₄² − H₃²) · T_c²,

the exact relation that fixes T_h from T_c and the vertex fields.
Carrier: Qc_cold_leg, Qh_hot_leg, carnot_ratio and pure algebra with
T_h, T_c ≠ 0, Q_c ≠ 0 (a *consequence* of the assumed laws — no numeric
answer value is used). -/
lemma reservoir_temperature_consistency :
    (r.H1 ^ 2 - r.H2 ^ 2) * r.Th ^ 2 = (r.H4 ^ 2 - r.H3 ^ 2) * r.Tc ^ 2 := by
  sorry

/-- Calorimetry in explicit temperature form: the helium temperature after
one cycle is

    T_final = T_initial − Q_c / (m·c)

(so the magnitude of the temperature drop is Q_c / (m·c)).  Carrier:
helium_calorimetry with m, c ≠ 0 (heliumMass_pos,
heliumSpecificHeat_pos). -/
lemma TFinal_from_calorimetry :
    r.TFinal = r.TInitial - r.Qc / (r.heliumMass * heliumSpecificHeat) := by
  sorry

/-- The helium *cools* (branch certificate): T_final < T_initial, since
Q_c > 0 on a genuinely refrigerating cycle and m, c > 0.  Carrier:
TFinal_from_calorimetry, Qc_pos, heliumMass_pos, heliumSpecificHeat_pos. -/
lemma helium_cools : r.TFinal < r.TInitial := by
  sorry

end PotassiumChromateCoolingRun

end CoolingRun

section OfficialAnswer

/-!
### Official numeric answer — conclusion side only

The recorded official answer Q_c = 1.29e-1 J, |ΔT| = 9.92e-3 K,
T_final = 0.99008 K appears ONLY as the conclusions of the theorems in
this section; nothing in PotassiumChromateCoolingRun assumes any of these
values.  The bands record the official rounding of the marked answer, so
they too stay conclusion-side. -/

/-- **Subquestion C.3 target (i): value of the absorbed heat.**
One operating cycle absorbs Q_c ≈ 1.29e-1 J from the helium bath
(band = official rounding of Q_c = 1.29e-1 J). -/
theorem absorbed_heat_value (r : PotassiumChromateCoolingRun) :
    |r.Qc - 1.29e-1| < 5.0e-4 := by
  sorry

/-- **Subquestion C.3 target (ii): value of the helium temperature drop.**
The helium temperature drops by |ΔT| ≈ 9.92e-3 K in one cycle. -/
theorem temperature_drop_value (r : PotassiumChromateCoolingRun) :
    |(r.TInitial - r.TFinal) - 9.92e-3| < 5.0e-5 := by
  sorry

/-- **Subquestion C.3 target (iii): final helium temperature.**
After one operating cycle the liquid helium is at T_final ≈ 0.99008 K
(officially T_final = 0.99008 K). -/
theorem final_temperature_value (r : PotassiumChromateCoolingRun) :
    |r.TFinal - 0.99008| < 5.0e-5 := by
  sorry

end OfficialAnswer

end IPhO2026.Problem3.C3
... [leading content omitted]
```

### Blueprint excerpt
```tex
al = 0.99008 K.

\paragraph{Figure/image path.}
/root/proposal\_for\_physic/science-mango/ipho\_2026\_source/image/T3\_page-4.png

\paragraph{Reusable previous-part conclusions.}
\begin{itemize}
\item Source B.1. Question: At fixed temperature T, H changes from H\_i to H\_f. Find the heat Q transferred into the torus. Reusable conclusions: Q = -(mu\_0*n*K/(2*T))*(H\_f\textasciicircum{}2 - H\_i\textasciicircum{}2). Policy: natural\_language\_prerequisite\_only; do\_not\_import\_Lean\_output
\item Source C.2. Question: Express M\_1 in terms of M\_2, M\_3, and M\_4. Reusable conclusions: M\_1 = sqrt(M\_2\textasciicircum{}2 - M\_3\textasciicircum{}2 + M\_4\textasciicircum{}2), taking the nonnegative magnitude. Policy: natural\_language\_prerequisite\_only; do\_not\_import\_Lean\_output
\end{itemize}

\paragraph{Formalization target.}
create a compiling Lean file with sorry bodies at `IPhO2026Problems/problem\_IPhO\_2026\_3\_C\_3.lean`.
The Lean declarations must preserve the physical quantities, dimensions or dimensional roles, figure labels, governing-law hypotheses, and final relation expressed by this problem.
Use Mathlib/Physlib names found through LeanExplore where available. If a domain API is missing, introduce faithful local abstractions rather than scalar placeholder aliases.

\begin{theorem}[Physics formalization target]
\label{thm:physics:IPhO_2026_3_C_3:target}
The assigned autoformalize agent should translate this physics problem into Lean declarations in the covered file, with theorem and lemma proof bodies written as `by sorry`.
\end{theorem}
\begin{proof}
This is an autoformalization task, not a proof task. Produce faithful statements that can later be proved without weakening the source contract.
\end{proof}
% --- Archon physics formalization source end ---
... [leading content omitted]
```

### Report excerpt: `IPhO2026Problems_problem_IPhO_2026_3_C_3.md`
```markdown
sing `T·M·V = n·K·H` into
  solved-for forms.
- `IsothermalHeatIntoTorus`, `CarnotHeatRatio`,
  `ConstantCapacityCalorimetry`, `TorusVolumeFromSource`: the four governing
  laws as functional equations (each eliminates to a rewrite-ready
  equation), avoiding opaque witness-only relations.
- `SuppliedMaterialData` + `opaque suppliedData`: calibrated readouts kept
  unfold-proof per the memory rule on data records, with positivity as
  structure fields (no axioms).
- `PotassiumChromateCoolingRun`: the C.3 model; the official answer is
  conspicuously absent from its fields.

## Grounding gaps

- PhysLean has no module for classical paramagnet thermodynamic cycles
  (Curie-style EOS, magnetic-work/heat relations) — consistent with the
  iter-001 review reconciliation (hydrostatics/reflection/Coulomb/thermo
  cycles exempted). The chapter's `% NOTE:` records the PhysLean-coverage
  exemption; no irrelevant import was bolted on.
- No `\lean{}` pins exist in the chapter; planner-side bookkeeping (memory)
  owns adding them once decl sets are stable.
- Redraft request: none. The chapter content is sufficient; no plan-agent
  action needed for this file beyond the existing umbrella entry.
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

## 11. `IPhO2026Problems/problem_IPhO_2026_4_C_6.lean`

- Compile status: passed
- Open sorries: 3
- Direct-check seconds: 13.617
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_4_C_6.tex`
- Reports: `.archon/task_results/physics-formalize-IPhO2026Problems_problem_IPhO_2026_4_C_6.md`, `.archon/task_results/physics-grounding-IPhO2026Problems_problem_IPhO_2026_4_C_6.md`

### Lean excerpt
```lean
Capacity_pos`. Multiplied through, this is
the equivalent form `c₀·m·s·R_Th = 1` recorded in the source. -/
theorem wall_thermal_resistance_from_C5 (E : ExperimentC) :
    E.RTh.valSI.val =
      1 / ((innerHeatCapacitySI E.c₀ E.m).valSI.val * E.slopeC5.valSI.val) := by
  sorry

/-- **Exact-key certificate for the C.6 inversion (pure real algebra).** The
central model value `R₀ = 1/(c₀·m·s)` obeys the recorded identity
`c₀·m·s·R₀ = 1` exactly; this separates the exact algebraic content of the
C.6 conclusion from the uncertainty band of the actual measurement. -/
theorem cooling_model_inversion_key {cms s : ℝ} (hcms : cms ≠ 0) (hs : s ≠ 0) :
    cms * s * (1 / (cms * s)) = 1 := by
  rw [one_div, mul_inv_cancel₀ (mul_ne_zero hcms hs)]

/-- **Uncertainty propagation to C.6 (recorded answer `R_Th = 1.17 ± 0.03 K/W`).**
For `R_Th = 1/(c₀·m·s)` the relative uncertainties add in quadrature-free,
worst-case (single-sided) form:

    |δR/R| = |δs/s| + |δc₀/c₀| + |δm/m|.

The theorem isolates the inversion step: a measurand `q` (the central value of
the heat capacity `c₀·m`) known within the strict relative half-width
`uq = |δc/c| + |δm/m|` (each summand `< 1/2`, so `uq < 1`), inverted jointly
with the slope `s` (known within `us = |δs/s| < 1/2`), determines the model
value `1/(q·s)` within the relative band `us + uq` of the central resistance
`R = 1/(c·m·s)`. The proof in the prover stage uses
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
answer is `R_Th = 1.17 ± 0.03 K/W` (K/W = s³·K·m⁻²·kg⁻¹ as a dimension). For
the central slope readout `s = 7.3e-4 1/(K·s)` and inner-cylinder calibration
`c₀·m = 2.3·10³ J/K` (c₀ = 4186 J/(kg·K), m = 0.55 kg), the model value
`1/(c₀·m·s)` lies inside the official band `1.17 ± 0.03 K/W`. The numerical
evaluation is left to the prover stage with certified interval arithmetic. -/
theorem official_sample_value :
    ∃ (R : DimThermalResistance) (δ : ℝ),
      R.valSI.val = 1.17 ∧ δ = 0.03 ∧
        |R.valSI.val - 1 / ((4186 : ℝ) * (0.55 : ℝ) * (7.3e-4 : ℝ))| ≤ δ := by
  sorry

end IPhO2026_4_C_6
... [leading content omitted]
```

### Blueprint excerpt
```tex
bquestion:
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
create a compiling Lean file with sorry bodies at `IPhO2026Problems/problem\_IPhO\_2026\_4\_C\_6.lean`.
The Lean declarations must preserve the physical quantities, dimensions or dimensional roles, figure labels, governing-law hypotheses, and final relation expressed by this problem.
Use Mathlib/Physlib names found through LeanExplore where available. If a domain API is missing, introduce faithful local abstractions rather than scalar placeholder aliases.

\begin{theorem}[Physics formalization target]
\label{thm:physics:IPhO_2026_4_C_6:target}
The assigned autoformalize agent should translate this physics problem into Lean declarations in the covered file, with theorem and lemma proof bodies written as `by sorry`.
\end{theorem}
\begin{proof}
This is an autoformalization task, not a proof task. Produce faithful statements that can later be proved without weakening the source contract.
\end{proof}
% --- Archon physics formalization source end ---
... [leading content omitted]
```

### Report excerpt: `physics-formalize-IPhO2026Problems_problem_IPhO_2026_4_C_6.md`
```markdown
nok` was applied by me —
left to the deterministic sync/review per policy.

## LeanExplore / grounding

Grounded PhysLean APIs (verified by reading sources in
`.lake/packages/PhysLean` and by compile): `Dimension`
(`L𝓭,T𝓭,M𝓭,Θ𝓭` + `*`, `⁻¹`, `^`), `WithDim d ℝ` (HMul/HDiv instances,
`WithDim.cast`), `Temperature` (`toReal`), `Time` (`val`, `⟨s⟩`),
`deriv`. Mathlib: `Finset.range` sums in `IsLeastSquaresLine`,
`mul_inv_cancel₀`, `one_div`. No new LeanExplore queries were needed beyond
the iter-001 preflight log; the physlib modules actually imported are
`Physlib.Units.{Basic,Dimension,WithDim.Basic}`,
`Physlib.Thermodynamics.Temperature.{Basic,TemperatureUnits}`,
`Physlib.SpaceAndTime.Time.Basic` — every import is used by the declarations.

## Grounding gaps / redraft requests

- None blocking. Note for the bookkeeping lane: `DimC5Slope` deliberately
  records the graph readout slope `(K/s)/K` (`T𝓭⁻¹`); the action dimension
  `J·s` of `1/s` is certified by
  `slope_inversion_is_dimensionally_correct`. If a future prover wants the
  full `M⁻¹L⁻²T⁻¹Θ⁻¹` dimensional slope type, extend with a second typed
  view — the SI real values agree either way, so the main theorem is
  unaffected.
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
