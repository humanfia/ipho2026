# Deterministic Review Candidate Pack

Iteration: 001
Exact review target count: 6

Review only these targets. Direct Lean compilation was already run in
parallel by the orchestrator; use the recorded result instead of rerunning it.

## 1. `IPhO2026Problems/problem_IPhO_2026_1_A_1.lean`

- Compile status: passed
- Open sorries: 10
- Direct-check seconds: 9.245
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_1_A_1.tex`
- Reports: `.archon/task_results/IPhO2026Problems_problem_IPhO_2026_1_A_1.md`, `.archon/task_results/physics-grounding-IPhO2026Problems_problem_IPhO_2026_1_A_1.md`

### Lean excerpt
```lean
ot's
vertical size `(a√2)/2`, i.e. it lies `4·((a√2)/4) = a√2` under the left
free surface along the vertical diagonal, matching the heads `Δh` and
`(a√2)/2 - Δh` split of the slot in Figure 1a. This is the purely
geometrical trace of where the pressure couple acts; it records that the
critical configuration puts the top vertex flush with the right free
surface. -/
lemma pressure_couple_position_trace (ha : 0 < a) :
    4 * (a * Real.sqrt 2 / 4) = a * Real.sqrt 2 := by
  sorry

/-- **Step 7 (algebra).** From the critical balance equation and positivity
of the parameters, `a = Δh/(2√2)` follows by cancelling `ρ₀·g·a³` and using
`√2² = 2`. -/
lemma side_length_eq_delta_h_over (hp : 0 < rho0) (ha : 0 < a)
    (hΔ : 0 < DeltaH) (hg : 0 < g)
    (hbal : rho0 * g * a ^ 4 / Real.sqrt 2 = rho0 * g * DeltaH * a ^ 3 / 4) :
    a = DeltaH / (2 * Real.sqrt 2) := by
  sorry

/-- **Numerical evaluation.** For the design value `Δh = 1.41 m`, the closed
form gives `a = 0.50 m` to the stated precision; this records the
arithmetic final readout `a ≈ 0.50`. -/
lemma numerical_value (hp : 0 < rho0) (ha : 0 < a) (hg : 0 < g)
    (hΔ : DeltaH = 1.41)
    (ha_eq : a = DeltaH / (2 * Real.sqrt 2)) :
    a = 0.50 ∨ |a - 0.50| < 1 / 200 := by
  sorry

end DerivationBridges

section MainTheorem

/-- **Target (T1-A1).** For the hydrostatic gate of Figure 1a in its
critical (maximum-`Δh`) configuration — all parameters positive, the
hydrostatic pressure law on the wetted faces, the Figure-1a pressure
couple readout, and the frictionless-hinge torque balance
`IsCriticalTorqueBalance` holding with the net immersed weight — the side
length of the cubic block is

`a = Δh / (2√2) = 0.50 m` for `Δh = 1.41 m`.

The recorded official answer appears only here, on the conclusion side.

Blueprint: `thm:physics:IPhO_2026_1_A_1:target`. -/
theorem hydrostatic_gate_side_length_a_target (S : HydrostaticGateSetup)
    (hΔ : DeltaH = 1.41)
    (hbal : restoringMoment = pressureCoupleMagnitude) :
    a = DeltaH / (2 * Real.sqrt 2) ∧ |a - 0.50| < 1 / 200 := by
  sorry

/-- Balance-law consistency: the existence hypothesis bundled in
`HydrostaticGateSetup` indeed gives the scalar moment balance used by the
target theorem (it only re-expresses the law `IsCriticalTorqueBalance`
with the derived force magnitude; the substantive case split of the target
is unaffected). -/
lemma torque_balance_contract (S : HydrostaticGateSetup)
    (hbal : restoringMoment = pressureCoupleMagnitude) :
    IsCriticalTorqueBalance pressureCoupleMagnitude netImmersedWeight := by
  sorry

end MainTheorem

end IPhO2026_1_A_1

end
... [leading content omitted]
```

### Blueprint excerpt
```tex
)/2 is sealed by a fully submerged solid cube of side a
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
create a compiling Lean file with sorry bodies at `IPhO2026Problems/problem\_IPhO\_2026\_1\_A\_1.lean`.
The Lean declarations must preserve the physical quantities, dimensions or dimensional roles, figure labels, governing-law hypotheses, and final relation expressed by this problem.
Use Mathlib/Physlib names found through LeanExplore where available. If a domain API is missing, introduce faithful local abstractions rather than scalar placeholder aliases.

\begin{theorem}[Physics formalization target]
\label{thm:physics:IPhO_2026_1_A_1:target}
The assigned autoformalize agent should translate this physics problem into Lean declarations in the covered file, with theorem and lemma proof bodies written as `by sorry`.
\end{theorem}
\begin{proof}
This is an autoformalization task, not a proof task. Produce faithful statements that can later be proved without weakening the source contract.
\end{proof}
% --- Archon physics formalization source end ---
... [leading content omitted]
```

### Report excerpt: `IPhO2026Problems_problem_IPhO_2026_1_A_1.md`
```markdown
` — the frictionless hinge at point O with axis perpendicular to the figure plane (figure label).
- Law predicates listed above — each states a *physical law relation* with eliminable equations, none restates the final formula.
- `cubeMass/displacedWaterMass/slotVerticalSize/weightHorizontalLeverArm` — derived geometric/mass quantities from the figure, not the answer.

## Grounding gaps / notes

- No hydrostatics (pressure-vs-depth, Archimedes, torque about a hinge) exists in Mathlib/PhysLean — recorded as a grounding gap and encoded locally as law predicates, per the physics modeling rules.
- Environment quirk worth memory: this toolchain's term parser rejects Unicode `−` (U+2212 MINUS SIGN) in *code* (fine in comments); ASCII `-` required. Related: the wave-1 `problem_IPhO_2026_1_C_1.lean` currently on disk does **not** `lake env lean`-compile (`ℏannotated`/`where`-in-field parse errors) — flagging to the plan agent, out of my lane to fix.
- Redraft requests: none. The blueprint chapter is minimal but sufficient (context + answer + figure pointer); the plan agent may flesh out the informal derivation later (weight/buoyancy torque-balance steps B1–B7 above are the informal chain).
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
- Open sorries: 4
- Direct-check seconds: 10.804
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_1_B_1.tex`
- Reports: `.archon/task_results/problem_IPhO_2026_1_B_1.md`, `.archon/task_results/physics-grounding-IPhO2026Problems_problem_IPhO_2026_1_B_1.md`

### Lean excerpt
```lean
r' ∈ D.attainedSeparations) : r' ≤ r :=
  hmax.2 hr'

/-- Support bound from the radial law: every attained separation satisfies
`Q(r) ≤ 0`, hence lies between the two certified turning-point roots of
the `μ = 4` case.  This is the bridge lemma connecting the effective
radial law to the ordering of separations; its proof uses
`attainedSeparations`, `turningQuadratic_eq_zero_iff`, and
`certified_factorization`. -/
theorem attainedSeparations_subset_Icc {hR : ScalingRegime}
    (D : CoulombPairData hR) {r : ℝ} (hr : r ∈ D.attainedSeparations)
    (hfact : ∀ x : ℝ, 0 < x →
      D.turningQuadratic (x * bohrRadius) ≤ 0 → 100 ≤ x ∧ x ≤ 1600 / 9) :
    100 * bohrRadius ≤ r ∧ r ≤ (1600 / 9) * bohrRadius := by
  rcases hr with ⟨hr_pos, hrQ⟩
  have ha := hR.bohrRadius_pos
  rcases hr_pos with hr_pos'
  obtain ⟨x, rfl : r = x * bohrRadius, hx⟩ : ∃ x : ℝ, r = x * bohrRadius ∧ 0 < x :=
    ⟨r / bohrRadius, by field_simp, by positivity⟩
  have hx' : 0 < x := hx
  have hxQ : D.turningQuadratic (x * bohrRadius) ≤ 0 := hrQ
  rcases hfact x hx' hxQ with ⟨h1, h2⟩
  constructor
  · nlinarith [ha]
  · nlinarith [ha]

/-- **Main target (T1-B1, 1.0 pt).**  Under the two-body Coulomb model of
Fig. 1b with `μ = 4` (bound case), there exists a maximal attained
separation between `e⁺` and `e⁻`, and its value is exactly
`(1600/9)·a₀`.  The recorded official value first becomes *asserted as the
answer* here, on the conclusion side; every bridge above is either a
governing law, a definitional expansion, or pure polynomial algebra. -/
theorem maximum_separation_T1_B1 {hR : ScalingRegime} (D : CoulombPairData hR)
    (hb : IsBoundMu boundMu)
    (ha_max_attained :
      (1600 / 9) * bohrRadius ∈ D.attainedSeparations)
    (hfact : ∀ x : ℝ, 0 < x →
      D.turningQuadratic (x * bohrRadius) ≤ 0 → 100 ≤ x ∧ x ≤ 1600 / 9) :
    ∃ r_max : ℝ,
      IsMaxSeparationAlongOrbit D r_max ∧ r_max = (1600 / 9) * bohrRadius := by
  sorry

/-- The numeric readout requested by the subquestion (“in terms of `a₀`”):
the maximum separation in units of `a₀` is exactly `1600/9`.  Corollary
form of `maximum_separation_T1_B1` with the division by `a₀ > 0` made
explicit. -/
theorem maximum_separation_in_bohr_radii_T1_B1 {hR : ScalingRegime}
    (D : CoulombPairData hR)
    (hb : IsBoundMu boundMu)
    (ha_max_attained :
      (1600 / 9) * bohrRadius ∈ D.attainedSeparations)
    (hfact : ∀ x : ℝ, 0 < x →
      D.turningQuadratic (x * bohrRadius) ≤ 0 → 100 ≤ x ∧ x ≤ 1600 / 9) :
    ∃ x_max : ℝ,
      IsMaxSeparationAlongOrbit D (x_max * bohrRadius) ∧ x_max = 1600 / 9 := by
  sorry

end

end IPhO2026.Problem1.B1
... [leading content omitted]
```

### Blueprint excerpt
```tex
*a\_0.  Their velocities are
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
create a compiling Lean file with sorry bodies at `IPhO2026Problems/problem\_IPhO\_2026\_1\_B\_1.lean`.
The Lean declarations must preserve the physical quantities, dimensions or dimensional roles, figure labels, governing-law hypotheses, and final relation expressed by this problem.
Use Mathlib/Physlib names found through LeanExplore where available. If a domain API is missing, introduce faithful local abstractions rather than scalar placeholder aliases.

\begin{theorem}[Physics formalization target]\leanok
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
me`): keep dimensions/roles without scalar
  alias collapse; definition relations carried as `Prop` fields.
- `CoulombPairData`: smallest structure preserving two-body reduction,
  Coulomb law, per-particle angular momentum, and the effective radial
  law — all as constraining equations/inequalities.
- `attainedSeparations`/`IsMaxSeparationAlongOrbit`: abstract
  maximum-of-support notion with an `IsGreatest`-based elimination
  theorem.
- `IsTurningPointInBohrRadii`, `IsBoundMu`: equation/inequality-carrying
  predicates preserving physical meaning (turning-point set, bound branch).

## Grounding gaps

- Mathlib/PhysLean contain no classical Kepler/Coulomb two-body radial
  dynamics, no reduced-mass reduction API, and no conic-orbit
  turning-point framework → encoded via the faithful local abstractions
  above; the eccentricity hint (Hint 1) and polar conic equation (Hint 2)
  are represented through the equivalent turning-point quadratic, avoiding
  otherwise-ungrounded square-root/trigonometric commitments.
- Remaining `sorry`s (4) are recorded per declaration above; the main one
  is the continuity/IVT-style attainability plus `IsGreatest` assembly
  left for the prover stage.
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

## 3. `IPhO2026Problems/problem_IPhO_2026_2_A_1.lean`

- Compile status: passed
- Open sorries: 5
- Direct-check seconds: 8.866
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_2_A_1.tex`
- Reports: `.archon/task_results/IPhO2026Problems_problem_IPhO_2026_2_A_1.md`, `.archon/task_results/physics-grounding-IPhO2026Problems_problem_IPhO_2026_2_A_1.md`

### Lean excerpt
```lean
nt is exactly the number of odd multiples
  of `α` not exceeding `π`, an impact exactly on the rim angle `π`
  included. The left-half count is fixed by the mirror symmetry
  `N_refl_abs`. -/
  reflection_count_law : ∀ α : ℝ, α ∈ Set.Ioc 0 (π / 2) →
    N_refl (R * cos α) = Set.ncard {k : ℕ | (2 * (k : ℝ) + 1) * α ≤ π}

namespace HalfCylindricalMirror

variable (s : HalfCylindricalMirror)

/-- The limiting ray: the ray whose first impact has polar angle
`α = π / (2 N + 1)` strikes the mirror at the odd multiples
`π / (2 N + 1), 3 π / (2 N + 1), …, (2 N + 1) π / (2 N + 1) = π`, so its
`(N + 1)`-st impact is exactly the rim point and it undergoes exactly
`N + 1` reflections. Bridge lemma from the reflection-count law to the
threshold: the odd-multiples count of `π / (2 N + 1)` up to `π` is `N + 1`. -/
theorem limiting_ray_reflection_count (n : ℕ) :
    s.N_refl (s.R * cos (π / (2 * ((n : ℝ) + 1) + 1))) = n + 2 := by
  sorry

/-- The two recorded forms of the answer agree: for every positive integer
`N`, `R * sin ((2 N − 1) * π / (4 N + 2)) = R * cos (π / (2 N + 1))`
(with `N = n + 1` in `0`-based indexing), because
`(2 N − 1) * π / (4 N + 2) = π / 2 − π / (2 N + 1)` and
`sin (π / 2 − θ) = cos θ`. Pure trigonometric bridge step. -/
theorem threshold_forms_agree (n : ℕ) :
    s.R * sin ((2 * ((n : ℝ) + 1) - 1) * π / (4 * ((n : ℝ) + 1) + 2)) =
      s.R * cos (π / (2 * ((n : ℝ) + 1) + 1)) := by
  sorry

/-- Main formalization target for A.1 (recorded answer, cosine form): the
threshold sequence of Figure 2e is
`x_N = R * cos (π / (2 N + 1))` for every positive integer `N`
(`N = n + 1` in `0`-based indexing). This is a target conclusion of the
subquestion, not an assumption. -/
theorem threshold_x_N_cos (n : ℕ) :
    s.x_NAt n = s.R * cos (π / (2 * ((n : ℝ) + 1) + 1)) := by
  sorry

/-- Recorded answer to A.1 (sine form): the threshold sequence is
`x_N = R * sin ((2 N − 1) * π / (4 N + 2))` for every positive integer `N`
(`N = n + 1` in `0`-based indexing). This is a target conclusion of the
subquestion, not an assumption. -/
theorem threshold_x_N_sin (n : ℕ) :
    s.x_NAt n =
      s.R * sin ((2 * ((n : ℝ) + 1) - 1) * π / (4 * ((n : ℝ) + 1) + 2)) := by
  sorry

/-- Combined recorded answer to T2-A1: both closed forms of the general
threshold agree,
`x_N = R * sin ((2 N − 1) * π / (4 N + 2)) = R * cos (π / (2 N + 1))`. -/
theorem threshold_x_N (n : ℕ) :
    s.x_NAt n =
        s.R * sin ((2 * ((n : ℝ) + 1) - 1) * π / (4 * ((n : ℝ) + 1) + 2)) ∧
      s.x_NAt n = s.R * cos (π / (2 * ((n : ℝ) + 1) + 1)) := by
  sorry

end HalfCylindricalMirror

end IPhO2026_2_A_1
... [leading content omitted]
```

### Blueprint excerpt
```tex
rce.}
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
create a compiling Lean file with sorry bodies at `IPhO2026Problems/problem\_IPhO\_2026\_2\_A\_1.lean`.
The Lean declarations must preserve the physical quantities, dimensions or dimensional roles, figure labels, governing-law hypotheses, and final relation expressed by this problem.
Use Mathlib/Physlib names found through LeanExplore where available. If a domain API is missing, introduce faithful local abstractions rather than scalar placeholder aliases.

\begin{theorem}[Physics formalization target]
\label{thm:physics:IPhO_2026_2_A_1:target}
The assigned autoformalize agent should translate this physics problem into Lean declarations in the covered file, with theorem and lemma proof bodies written as `by sorry`.
\end{theorem}
\begin{proof}
This is an autoformalization task, not a proof task. Produce faithful statements that can later be proved without weakening the source contract.
\end{proof}
% --- Archon physics formalization source end ---
... [leading content omitted]
```

### Report excerpt: `IPhO2026Problems_problem_IPhO_2026_2_A_1.md`
```markdown
ror + ray family + staircase, faithful because it
  keeps `R` as a length, `N_refl` as the physical reflection-count function, and `x_NAt` as the
  threshold sequence defined by its extremal property, with the reflection law stated as a law.
- The odd-multiples counting set `{k : ℕ | (2 * (k:ℝ) + 1) * α ≤ π}`: the geometric content of
  repeated specular reflection (constant angular step `2α`), chosen over an angle-recursion
  `def` so the file is parameterized by the first impact angle `α` (the physically natural
  variable; `x = R * cos α` is the Figure 2d readout).

## Grounding gaps / redraft requests

- None blocking. Optional future strengthening: reformulate `reflection_count_law` as an inductive
  polar-angle recursion (impact sequence) if the prover stage wants a term-level witness for the
  impact sequence; the current `Set.ncard` form is already sufficient to derive both target forms.
- Sibling-file note: `problem_IPhO_2026_2_C_1.lean` uses the *incidence-angle* parameterization
  (`P θ = (R sin θ, R cos θ)`); this file uses the *standard polar angle* `α` (`x = R cos α`).
  They are related by `θ = π/2 − α`; both are local and self-contained per the no-cross-import rule.
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

## 4. `IPhO2026Problems/problem_IPhO_2026_2_B_1.lean`

- Compile status: passed
- Open sorries: 4
- Direct-check seconds: 8.951
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_2_B_1.tex`
- Reports: `.archon/task_results/problem_IPhO_2026_2_B_1.md`, `.archon/task_results/physics-grounding-IPhO2026Problems_problem_IPhO_2026_2_B_1.md`

### Lean excerpt
```lean
eadout of the physical family, not of the
answer; it is what makes the coefficient pair of the given ansatz unique:
the identity holding at two distinct extremal angles cuts a two-by-two
linear system with determinant `2 * (cos θ' - cos θ) ≠ 0`. -/
structure SecondExtremalConfig (p : CookerParams) (θ' : ℝ) where
  q : CookerParams
  qR : q.R = p.R
  t : CookerB1 q
  hθ' : IsThetaMax q t θ'
  e' : ExtremalRaySpec q t θ'

/-- Tangency relation for the limiting ray (the B.1 geometric identity):
at an extremal angle `θ`, specular reflection at the mirror point
`(|x|, -√(R² - |x|²))` with `|x| = R * sin θ`, the container offset
`A = (0, -R / 2)`, and the tangency data of `ExtremalRaySpec` force the
container radius to be `a = R * sin θ - (R / 2) * sin (2 * θ)`.

This is the load-bearing bridge of the subquestion: its proof is the
two-by-two linear solve for `(m x, b x)` given by `reflection_law` at the
extremal column (determinant `-(2 * x) * (x ^ 2 + y ^ 2) ≠ 0`), giving
`b = -R ^ 2 / (2 * √(R² - x²))`, followed by the tangency distance
evaluation — where the signed-distance numerator `-R / 2 - b` is strictly
positive, so no sign branch is lost — and the double-angle elimination. -/
theorem container_radius_at_extremal_angle (p : CookerParams)
    (s : CookerB1 p) {θ : ℝ} (hθ : θ ∈ Set.Ioo 0 (Real.pi / 2))
    (e : ExtremalRaySpec p s θ) :
    p.a = p.R * Real.sin θ - (p.R / 2) * Real.sin (2 * θ) := by
  sorry

/-- Main formalization target (T2-B1; blueprint
`thm:physics:IPhO_2026_2_B_1:target`). For the Figure-2f cooker with
extremal absorbed ray `e` at maximum incidence angle `θ_max`, the
coefficient pair `(α, β)` of the given family ansatz
`a = α * sin θ_max + β * sin (2 * θ_max)` is `α = R`, `β = -R / 2`.

Proof route: `container_radius_at_extremal_angle` at the configurations
`e` and `cfg₂.e'` gives the tangency identity at the two distinct extremal
angles `θ ≠ θ'`; `hcoef` at the same configurations gives the ansatz
there; subtraction yields
`(α - R) * sin θ' + (β + R / 2) * sin (2 θ') = 0` at both angles, a
two-by-two linear system in `(α - R, β + R / 2)` whose determinant
`2 * sin θ * sin θ' * (cos θ' - cos θ)` is nonzero by `strictAntiOn cos`
on `(0, π / 2)` — forcing the recorded values. The coefficient
identification is a conclusion, not an assumption. -/
theorem alpha_beta_in_terms_of_R (p : CookerParams) (s : CookerB1 p)
    {θ θ' α β : ℝ}
    (hθ : IsThetaMax p s θ) (hcoef : CoeffSpec p α β)
    (e : ExtremalRaySpec p s θ)
    (cfg₂ : SecondExtremalConfig p θ') (hdist : θ' ≠ θ) :
    α = p.R ∧ β = -p.R / 2 := by
  sorry

end IPhO2026_2_B_1

end
... [leading content omitted]
```

### Blueprint excerpt
```tex
ontainer center lies
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
create a compiling Lean file with sorry bodies at `IPhO2026Problems/problem\_IPhO\_2026\_2\_B\_1.lean`.
The Lean declarations must preserve the physical quantities, dimensions or dimensional roles, figure labels, governing-law hypotheses, and final relation expressed by this problem.
Use Mathlib/Physlib names found through LeanExplore where available. If a domain API is missing, introduce faithful local abstractions rather than scalar placeholder aliases.

\begin{theorem}[Physics formalization target]
\label{thm:physics:IPhO_2026_2_B_1:target}
The assigned autoformalize agent should translate this physics problem into Lean declarations in the covered file, with theorem and lemma proof bodies written as `by sorry`.
\end{theorem}
\begin{proof}
This is an autoformalization task, not a proof task. Produce faithful statements that can later be proved without weakening the source contract.
\end{proof}
% --- Archon physics formalization source end ---
... [leading content omitted]
```

### Report excerpt: `problem_IPhO_2026_2_B_1.md`
```markdown
ℝ` (abbrev, not scalar alias): keeps the 2-D cross-sectional geometry of Figure 2f; chosen over `EuclideanSpace ℝ (Fin 2)` only to keep coordinate equations tactic-light for the next (prover) stage — physically equivalent, units documented in docstrings.
- `Line2D` + `distToLine`: non-vertical reflected lines (verticality never occurs off-axis here; the `±π/2` columns are excluded by `hit_branch`) with the standard signed distance — the tangency/point-line language of the source.
- `CookerB1`, `ExtremalRaySpec`, `CoeffSpec`, `SecondExtremalConfig`: see the countermodel audit; each preserves a distinct physical role (setup/laws, extremal tangency, given ansatz, family nondegeneracy) and none hides the answer.

## Grounding gaps / redraft requests

- No PhysLean geometric-optics reflection API (gap on the Physlib side, worked around with explicit Cartesian incidence equations).
- No blueprint chapter changes requested; the chapter's umbrella `theorem` correctly describes this as an autoformalization task. Plan agent may wish to add a one-line informal derivation of `a = R sin θ_max − (R/2) sin 2θ_max` (tangent-ray solve sketched in this file's header) when the chapter is fleshed out.
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

## 5. `IPhO2026Problems/problem_IPhO_2026_2_C_2.lean`

- Compile status: passed
- Open sorries: 3
- Direct-check seconds: 9.235
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_2_C_2.tex`
- Reports: `.archon/task_results/problem_IPhO_2026_2_C_2.md`, `.archon/task_results/physics-grounding-IPhO2026Problems_problem_IPhO_2026_2_C_2.md`

### Lean excerpt
```lean
mainder `o(Δθ)`. -/
  B_first_order :
    ∃ db : ℝ, (fun Δθ : ℝ ↦ B (θ + Δθ) - B θ - db * Δθ) =o[𝓝 0]
      fun Δθ : ℝ ↦ Δθ

namespace NeighboringRayExpansion

variable (s : NeighboringRayExpansion)

/-- The quantities of the subquestion are well-formed on the Figure-2g
branch: `sin (2 * θ) ≠ 0` and `cos θ ≠ 0`, so `csc (2 * θ)`, `cot (2 * θ)`,
`tan θ`, and the C.1 intercept `R / (2 * cos θ)` are all defined with
nonzero denominators.  This is a bridge lemma exposing the branch
information, not a target conclusion. -/
theorem branch_denominators_ne_zero :
    sin (2 * s.θ) ≠ 0 ∧ cos s.θ ≠ 0 := by
  sorry

/-- First-order expansion of the neighboring-ray slope (recorded answer to
C.2, slope half): as `Δθ → 0`,
`m_B θ Δθ = cot (2 * θ) - 2 * csc (2 * θ) ^ 2 * Δθ + o(Δθ)`.
This is the derivative identity
`(d/dθ) cot (2 * θ) = -2 * csc (2 * θ) ^ 2` applied to the smooth ray
family; it is a target conclusion of the subquestion, not an assumption. -/
theorem ray_B_slope_first_order :
    (fun Δθ : ℝ ↦
        s.m_B s.θ Δθ - (cot (2 * s.θ) - 2 * (sin (2 * s.θ))⁻¹ ^ 2 * Δθ))
      =o[𝓝 0] fun Δθ : ℝ ↦ Δθ := by
  sorry

/-- First-order expansion of the neighboring-ray intercept (recorded answer
to C.2, intercept half): as `Δθ → 0`,
`b_B θ Δθ = (R / (2 * cos θ)) * (1 + tan θ * Δθ) + o(Δθ)`.
This is the derivative identity
`(d/dθ) (R / (2 * cos θ)) = (R / (2 * cos θ)) * tan θ` applied to the
smooth ray family; it is a target conclusion of the subquestion, not an
assumption. -/
theorem ray_B_intercept_first_order :
    (fun Δθ : ℝ ↦
        s.b_B s.θ Δθ -
          (s.R / (2 * cos s.θ)) * (1 + tan s.θ * Δθ))
      =o[𝓝 0] fun Δθ : ℝ ↦ Δθ := by
  sorry

/-- Main formalization target for C.2 (blueprint label
`thm:physics:IPhO_2026_2_C_2:target`): the reflected line
`y = m_B θ Δθ * x + b_B θ Δθ` of the neighboring parallel ray B, incident
at `θ + Δθ` with `Δθ ≪ θ`, expands to first order in `Δθ` as

  `m_B θ Δθ = cot (2 * θ) - 2 * csc (2 * θ) ^ 2 * Δθ + o(Δθ)`,
  `b_B θ Δθ = (R / (2 * cos θ)) * (1 + tan θ * Δθ) + o(Δθ)`.

Both remainders are little-o of `Δθ` as `Δθ → 0`, which is the faithful
first-order content of the official `+ O(Δθ ^ 2)` phrasing. -/
theorem ray_B_first_order_expansion :
    ((fun Δθ : ℝ ↦
          s.m_B s.θ Δθ - (cot (2 * s.θ) - 2 * (sin (2 * s.θ))⁻¹ ^ 2 * Δθ))
        =o[𝓝 0] fun Δθ : ℝ ↦ Δθ) ∧
      ((fun Δθ : ℝ ↦
          s.b_B s.θ Δθ -
            (s.R / (2 * cos s.θ)) * (1 + tan s.θ * Δθ))
        =o[𝓝 0] fun Δθ : ℝ ↦ Δθ) := by
  exact ⟨s.ray_B_slope_first_order, s.ray_B_intercept_first_order⟩

end NeighboringRayExpansion

end IPhO2026_2_C_2
... [leading content omitted]
```

### Blueprint excerpt
```tex
bquestion:
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
create a compiling Lean file with sorry bodies at `IPhO2026Problems/problem\_IPhO\_2026\_2\_C\_2.lean`.
The Lean declarations must preserve the physical quantities, dimensions or dimensional roles, figure labels, governing-law hypotheses, and final relation expressed by this problem.
Use Mathlib/Physlib names found through LeanExplore where available. If a domain API is missing, introduce faithful local abstractions rather than scalar placeholder aliases.

\begin{theorem}[Physics formalization target]
\label{thm:physics:IPhO_2026_2_C_2:target}
The assigned autoformalize agent should translate this physics problem into Lean declarations in the covered file, with theorem and lemma proof bodies written as `by sorry`.
\end{theorem}
\begin{proof}
This is an autoformalization task, not a proof task. Produce faithful statements that can later be proved without weakening the source contract.
\end{proof}
% --- Archon physics formalization source end ---
... [leading content omitted]
```

### Report excerpt: `problem_IPhO_2026_2_C_2.md`
```markdown
introduced

- `NeighboringRayExpansion` structure: one-parameter reflected-ray family
  `(M, B)` with family-membership equations for rays A/B, C.1 values as
  previous-part hypotheses, acute-branch hypothesis, and smoothness
  interfaces `M_first_order`/`B_first_order`. This preserves the physical
  meaning (same-mirror ray family, smooth in the incidence parameter)
  instead of hiding the law in a formula: the C.2 formulas remain
  theorems-to-be-proved, not definitions.

## Grounding gaps / redraft requests

- No blocking grounding gaps. Minor notes for later stages:
  - Mathlib has no `Real.csc`; the formalization uses `(Real.sin (2θ))⁻¹`
    (standard Mathlib idiom), matching the recorded `csc(2θ)²`.
  - `Real.cot` unfolds to `cos/sin`; the coefficient
    `-2 * (sin (2θ))⁻¹ ^ 2` equals `(d/dθ) cot (2θ)` via the quotient rule —
    routine but nontrivial derivative bookkeeping for the prover stage.
  - Remainder formalized as `o(Δθ)` (exact first-order content of the
    official `O(Δθ²)`); upgrade to `=O[Δ²]` would need twice
differentiability of the family, which the source does not state — flagging
    for the review agent rather than the blueprint (plan agent may note it).
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

## 6. `IPhO2026Problems/problem_IPhO_2026_3_C_4.lean`

- Compile status: passed
- Open sorries: 8
- Direct-check seconds: 8.884
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_3_C_4.tex`
- Reports: `.archon/task_results/problem_IPhO_2026_3_C_4.md`, `.archon/task_results/physics-grounding-IPhO2026Problems_problem_IPhO_2026_3_C_4.md`

### Lean excerpt
```lean
P) * (T_h / T' - 1).

    Carrier: `residenceDensity_eq` on `Set.Ioo`, upgraded to set-integral
    congruence (the endpoints form a measure-zero set). -/
theorem elapsedTime_eq_integral
    (regime : RegimeAssumptions)
    (run : CoolingRun) (hrun : IsCoolingRun run)
    (haccum : elapsedTime
      = ∫ T' in Set.Icc tempFinal tempInitial, run.residenceDensity T') :
    elapsedTime
      = ∫ T' in Set.Icc tempFinal tempInitial,
          (heatCapacityBody / inputPower) * (tempHot / T' - 1) := by
  sorry

/-- **Evaluation bridge (real analysis).**  The residence-time integral
    evaluates by the fundamental theorem of calculus
    (`∫ T_h/T' = T_h * ln (T_0/T)` off `0 < T ≤ T' ≤ T_0`, `∫ 1 = T_0 - T`):

        ∫_{[T, T_0]} (C_c / P) * (T_h / T' - 1)
          = (C_c / P) * (T_h * ln (T_0 / T) - (T_0 - T)).

    Carrier: Mathlib `intervalIntegral.integral_one_div` and constant
    integration (via the identity between set integrals over `Icc` and
    interval integrals). -/
theorem cooling_time_integral_eval (regime : RegimeAssumptions) :
    (∫ T' in Set.Icc tempFinal tempInitial,
        (heatCapacityBody / inputPower) * (tempHot / T' - 1))
      = (heatCapacityBody / inputPower) *
          (tempHot * Real.log (tempInitial / tempFinal)
            - (tempInitial - tempFinal)) := by
  sorry

/-- **Subquestion C.4 (main target).**

    The body of heat capacity `C_c` is cooled from `T_0` to `T` at constant
    input power `P` and constant hot-reservoir temperature `T_h` in elapsed
    time

        t = (C_c * T_h / P) * (ln (T_0 / T) - (T_0 - T) / T_h).

    The right-hand side (the recorded official answer) is purely
    conclusion-side: the hypotheses only bundle the per-cycle governing laws
    (`IsCoolingRun`, composed of the Carnot heat ratio, the first law, the
    constant-power law, and the calorimetric law) and the operational
    definition of the elapsed time (`haccum`).  Proof route:
    `elapsedTime_eq_integral` ∘ `cooling_time_integral_eval`, then the field
    algebra
    `(C_c/P) * (T_h ln(T_0/T) − (T_0−T)) = (C_c T_h/P) * (ln(T_0/T) − (T_0−T)/T_h)`.

    Blueprint label: `thm:physics:IPhO_2026_3_C_4:target`. -/
theorem c4_elapsed_time
    (regime : RegimeAssumptions)
    (run : CoolingRun) (hrun : IsCoolingRun run)
    (haccum : elapsedTime
      = ∫ T' in Set.Icc tempFinal tempInitial, run.residenceDensity T') :
    elapsedTime
      = (heatCapacityBody * tempHot / inputPower) *
          (Real.log (tempInitial / tempFinal)
            - (tempInitial - tempFinal) / tempHot) := by
  sorry

end PhysicsContracts

end IPhO2026.Problem3.C4
... [leading content omitted]
```

### Blueprint excerpt
```tex
s the magnitude of heat
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
create a compiling Lean file with sorry bodies at `IPhO2026Problems/problem\_IPhO\_2026\_3\_C\_4.lean`.
The Lean declarations must preserve the physical quantities, dimensions or dimensional roles, figure labels, governing-law hypotheses, and final relation expressed by this problem.
Use Mathlib/Physlib names found through LeanExplore where available. If a domain API is missing, introduce faithful local abstractions rather than scalar placeholder aliases.

\begin{theorem}[Physics formalization target]
\label{thm:physics:IPhO_2026_3_C_4:target}
The assigned autoformalize agent should translate this physics problem into Lean declarations in the covered file, with theorem and lemma proof bodies written as `by sorry`.
\end{theorem}
\begin{proof}
This is an autoformalization task, not a proof task. Produce faithful statements that can later be proved without weakening the source contract.
\end{proof}
% --- Archon physics formalization source end ---
... [leading content omitted]
```

### Report excerpt: `problem_IPhO_2026_3_C_4.md`
```markdown
m; the only faithful way to state "infinitesimal cycles at constant `P`" without ultrafilter-level infinitesimals; density formulation keeps every law an ordinary equation.
- `ParamagnetEOS`, `IsothermalHeatIntoTorus`, `CarnotHeatRatio`, `CycleWorkHeatBalance`, `ConstantPowerDensityLaw`, `BodyCalorimeterDensityLaw` — faithful governing-law predicates (equations), not answer-shaped definitions.
- `RegimeAssumptions` — physical regime ordering/positivity, separated so proofs can cite `T' ≠ 0`, `P ≠ 0`, `ln`-domain side goals.
- `opaque` scalars for `T_h, T_0, T, C_c, P, t` — prevent answer-by-unfolding; SI-scalar nature documented.

## Grounding gaps / redraft requests

- **Gap (recorded, non-blocking):** neither Mathlib nor PhysLean (pinned rev) ships a classical thermodynamics Carnot/refrigerator cycle API or a general "heat-capacity body cooled at constant power" development; the file therefore introduces the faithful local law predicates above, mirroring sibling files `problem_IPhO_2026_3_C_2.lean` / `problem_IPhO_2026_3_C_5.lean` house style (same idioms, no cross-import).
- No redraft requests; the file is self-contained (`import Mathlib` only) per `formalization_input_policy`.
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
