# Deterministic Plan Candidate Pack

Iteration: 010
Exact objective count: 13

The loop has already selected and written these objectives. Do not scan
the rest of the corpus and do not replace, reorder, add, or remove targets.
Use the excerpts below only to write a concise per-target proof strategy.

## 1. `IPhO2026Problems/problem_IPhO_2026_1_A_1.lean`

- Open placeholders: 10
- Proof Review: new; attempts=0
- Review reason: (none)
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_1_A_1.tex`

### Lean excerpt
```lean
... [prefix omitted]
nlessly at O (its bottom vertex) and may rotate
  about the axis perpendicular to the plane of the figure through O, so the
  cube sits as a diamond with its diagonal vertical across the slot. Water
  stands higher on the left of the wall; the maximum permissible difference
  of the free-surface levels is `Δh`. The free-surface difference `Δh`
  creates a clockwise hydrostatic-pressure torque about O, which is
  counteracted by the anticlockwise restoring torque of the cube's immersed
  weight ((mass - displaced water) × g, acting at the cube's centre, a
  distance `a/2` vertically above O; horizontal lever arm `(a/2) sin 45° =
  a/(2√2)`). The critical (maximum-`Δh`) configuration is the borderline one
  in which the net moment about O still vanishes: the top face of the cube
  sits flush at the slot's upper lip, so `Δh` measures the head from the
  right free surface (at that lip) to the left free surface. In the critical
  regime both faces of the cube are fully wetted, the hydrostatic pressure
  fields vary linearly with depth, and their resultants act at the face
  centres, a distance `(a√2)/2` apart along the vertical-diagonal line with
  horizontal arm `(a√2)/4`.

  Current subquestion (T1-A1, 3 pts):
    Calculate the side length `a` such that `Δh = 1.41 m` is the maximum
    permissible water-level difference.

  Recorded official answer (conclusion side only):
    `a = Δh / (2√2) = 0.50 m`.

  All theorem statements below are faithful contracts; proof bodies are
  `sorry` by design (autoformalize stage). The current target conclusion —
  the closed-form value of `a` — appears only on the conclusion side of the
  main theorem `hydrostatic_gate_side_length_a_target` and is never used as
  a hypothesis, premise field, or local definition; the proved-oriented
  lemmas record only the *physical* derivation (weight force, restoring
  moment, pressure couple, geometrical trace of the couple) plus the final
  algebra.
-/

import Mathlib
import Physlib.Units.WithDim.Pressure

open Real Set

noncomputable section

namespace IPhO2026_1_A_1

/-- Grounding anchor for the domain library: PhysLean's dimensional pressure
type (module `Physlib.Units.WithDim.Pressure`). PhysLean ranges over
relativity/electromagnetism/thermodynamics and has **no** hydrostatics /
fluid-statics or rigid-body torque module (see
`task_results/physics-grounding-IPhO2026Problems_problem_IPhO_2026_1_A_1.md`),
so its dimensional pressure type cannot carry the depth law, resultants, or
moments of this problem; the hydrostatic model below is therefore built from
faithful local law predicates over scalars. This declaration only records —
type-level — that the domain library was consulted and its pressure concept
identified. -/
example : Type := DimPressure

section PhysicalSetup

/-!
Universal geometrical constants and the physical parameters of Figure 1a.
They are declared as abstract scalars (with their SI roles in the
docstrings) rather than transparent aliases, so the contracts
... [suffix omitted]
```

### Blueprint excerpt
```tex
... [prefix omitted]
026_1_A_1.lean
% archon:source-report reports/ipho_2026_k3/problem_IPhO_2026_1_A_1.source.json
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
create a compiling Lean file with sorry bodies at `IPhO2026Problems/problem\_IPhO\_2026\_1\_A\_1.lean`.
The Lean declarations must preserve the physical quantities, dimensions or dimensional roles, figure labels, governing-law hypotheses, and final relation expressed by this problem.
Use Mathlib/Physlib names found through LeanExplore where available. If a domain API is missing, introduce faithful local abstractions rather than scalar placeholder aliases.

\begin{theorem}[Physics formalization target]
\label{thm:physics:IPhO_2026_1_A_1:target}
\uses{thm:IPhO2026Problems_problem_IPhO_2026_1_A_1:hydrostatic_gate_side_length_a_target}
The assigned autoformalize agent should translate this physics problem into Lean declarations in the covered file, with theorem and lemma proof bodies written as `by sorry`.
\end{theorem}
\begin{proof}
This is an autoformalization task, not a proof task. Produce faithful statements that can later be proved without weakening the source contract.
\end{proof}
% NOTE: PhysLean-coverage exemption (planner-recorded, iter-002): PhysLean has no hydrostatics/fluid-statics module; nearest hits are Path.topological lemmas (see task\_results/physics-grounding-IPhO2026Problems\_problem\_IPhO\_2026\_1\_A\_1.md). Self-containment is kept with the `imp
... [suffix omitted]
```

## 2. `IPhO2026Problems/problem_IPhO_2026_1_B_2.lean`

- Open placeholders: 6
- Proof Review: new; attempts=0
- Review reason: (none)
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_1_B_2.tex`

### Lean excerpt
```lean
... [prefix omitted]
nitude `e`
  of opposite sign.  The system is isolated, classical, non-relativistic.
  The Bohr radius is `a0 = 4*pi*eps0*hbar^2/(m e^2)`, and the Coulomb
  constant is `k = 1/(4*pi*eps0)`.

  Current subquestion (T1-B2, 2.5 pts):
    For `mu = 15/2` the pair is unbound (hyperbolic scattering).  Let
    `u_inf` be the relative velocity of `e+` with respect to `e-` as the
    separation tends to infinity.  Find the angle between `u_inf` and the
    initial line of motion of `e+`, in degrees.

  Recorded official answer: signed deflection `-16.60` degrees, i.e. the
  asymptotic direction of `u_inf` lies 16.60 degrees BELOW the initial
  positron line of motion.  This value appears ONLY on the conclusion side
  of `signed_deflection_angle_T1_B2` and of its magnitude corollary
  `unsigned_deflection_angle_in_degrees_T1_B2`.  No assumption, premise
  field, or local definition mentions `16.60`, `83/900`, or any numeric
  deflection — the sign toward the line connecting the pair and the
  magnitude are exactly what must be proved.

  Official hints recorded on the problem page (governing-law input, not
  target): Hint 1: eccentricity `eps = sqrt(1 + 4 L^2 E / (k^2 e^4 m))`
  with `E` and `L` the total energy and the magnitude of the total angular
  momentum, `k` the Coulomb constant; Hint 2: polar equation of the conic
  trajectory `r = a / (1 - eps cos theta)`.  They are encoded as
  *derivable bridge lemmas* (`eccentricity_sq_eq`, `orbit_eq_conic`);
  the deflection formula is a sorry-bodied bridge
  (`signed_deflection_eq_formula`).

  Conventions:
  * Two-body -> one-body reduction is encoded in
    `CoulombScatteringData.reduced_mass_eq` (`m_red = m/2`) and
    `CoulombScatteringData.relative_kinetic_law` (kinetic energy of the
    two opposite CM-frame velocities equals `(1/2) m_red u^2` with
    `u = 2 v0`).
  * The trajectory is an abstract planar curve `sep : R -> R^2`, the
    relative coordinate `r_positron - r_electron` as a function of time,
    constrained by governing-law fields (Newton's equation for the
    reduced particle under attractive Coulomb, angular-momentum
    conservation, the multiplied-out radial-energy identity, the turning
    point at `t = 0`, polar decomposition).  No closed orbit shape is
    assumed: the conic form appears only in the bridge lemma
    `orbit_eq_conic`.
  * `u_inf` carries a *definition* (`AsymptoticRelativeVelocity`, a
    `Filter.Tendsto` statement of the trajectory's relative velocity at
    `Filter.atTop`), so its existence is a theorem to be proved
    (`exists_asymptoticRelativeVelocity`), not an assumption.
  * Proofs are `by sorry` by design (autoformalize stage).  The only
    closed proofs are pure definitional/algebraic certificates
    (`unboundMu_isAngularMomentumFactor`, `total_angular_momentum_value`,
    `initial_separation_pos`, `turningQuadratic_periapsis`,
    `eccentricity_gt_one`, `asymptote_factor_certificate`,
    `signedDeflection_eq_neg_angle`); none of them asserts any
    de
... [suffix omitted]
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
create a compiling Lean file with sorry bodies at `IPhO2026Problems/problem\_IPhO\_2026\_1\_B\_2.lean`.
The Lean declarations must preserve the physical quantities, dimensions or dimensional roles, figure labels, governing-law hypotheses, and final relation expressed by this problem.
Use Mathlib/Physlib names found through LeanExplore where available. If a domain API is missing, introduce faithful local abstractions rather than scalar placeholder aliases.

\begin{theorem}[Physics formalization target]
\label{thm:physics:IPhO_2026_1_B_2:target}
\uses{thm:IPhO2026Problems_problem_IPhO_2026_1_B_2:signed_deflection_angle_T1_B2, thm:IPhO2026Problems_problem_IPhO_2026_1_B_2:unsigned_deflection_angle_in_degrees_T1_B2}
The assigned autoformalize agent should translate this physics problem into Lean declarations in the covered file, with theorem and lemma proof bodies written as `by sorry`.
\end{theorem}
\begin{proof}
This is an autoformalization task, not a proof task. Produce faithful statements that can later be proved without weakening the source contract.
\end{proof}
% NOTE: PhysLean-coverage exemption (planner-recorded, iter-003): PhysLean has no Coulomb/Rutherford-scattering module (hyperbolic-orbit asymptotes, deflection-angle relations); this part models particle-
... [suffix omitted]
```

## 3. `IPhO2026Problems/problem_IPhO_2026_1_C_1.lean`

- Open placeholders: 5
- Proof Review: new; attempts=0
- Review reason: (none)
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_1_C_1.tex`

### Lean excerpt
```lean
... [prefix omitted]
m 1 (T1), Part C.1.

  Blueprint chapter: blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_1_C_1.tex
  Source report:     reports/ipho_2026_k3/problem_IPhO_2026_1_C_1.source.json
  Official page:     T1_page-3.png  (IPhO 2026 Theoretical Exam, page 6/14)

  Physical situation (Figure 1c):
  A photon of angular frequency `ω` strikes an ozone molecule `O₃` at rest and
  is absorbed, dissociating it into an oxygen molecule `O₂` and an oxygen atom
  `O`.  The ground-state energies of `O₃` and of the fragments are `Uᵢ` and
  `U_f`, with `ΔU = U_f - Uᵢ > 0`.  The momentum of the outgoing `O₂` makes
  the angle `θ` with the incident photon direction.  The fragments are treated
  classically and non-relativistically; an oxygen atom has mass `m`, so the
  `O₂` fragment has mass `2m`; the photon momentum is `p_γ = E_γ/c = ℏω/c`.

  Current subquestion (T1-C1, 2.5 pts):
    Determine the minimum angular frequency `ω_min` required for the
    dissociation to occur at outgoing `O₂` angle `θ`, in terms of
    `ℏ, c, θ, ΔU` and `m`.

  Recorded official answer:
    for `θ ≤ π/2`,
      `ω_min = 3 m c² (1 - √(1 - (2 ΔU / (3 m c²)) (2 sin²θ + 1))) /
                 (ℏ (2 sin²θ + 1))`;
    for `θ ≥ π/2`, the same threshold evaluated at `θ = π/2`.
  (Official solution, `T1_solution.txt`: the threshold is the smallest root of
  `(cos 2θ - 2) ℏ²ω² + 6 m c² ℏω - 6 ΔU m c² = 0`, and
  `2 sin²θ + 1 = 2 - cos 2θ`.)

  All theorem statements below are faithful contracts; proof bodies are
  `sorry` by design (autoformalize stage).  The current target conclusion —
  the closed-form value of `ω_min` — appears only on the conclusion side of
  the main theorem `minimum_angular_frequency_T1_C1` and of the auxiliary
  quadratic-form lemma `quadratic_characterization_of_threshold`; the governing-law
  predicates (`IsTwoBodyDissociation`, `EnergyConservation`, `IsScatteringAngle`)
  never mention it.
-/

import Mathlib

open Real Set

noncomputable section

namespace IPhO2026.Problem1.C1

section UniversalConstants

/-!
Universal constants and molecular data of the problem.  They are declared as
abstract scalars (with their SI roles recorded in the docstrings) rather than
transparent aliases, so that the contracts below cannot be closed by
unfolding.
-/

/-- Reduced Planck constant `ℏ` (J·s). -/
opaque hbar : ℝ

/-- Speed of light in vacuum `c` (m/s). -/
opaque speedOfLight : ℝ

/-- Mass `m` of one oxygen atom (kg); the `O₂` fragment has mass `2m`. -/
opaque oxygenAtomMass : ℝ

/-- Photon angular frequency `ω` for any photon considered in this process
    (rad/s).  The closed-form value of `ω_min` is a *target*, not a datum. -/
opaque photonAngularFrequency : ℝ

/-- Ground-state energy `Uᵢ` of the ozone molecule `O₃` (J). -/
opaque ozoneGroundStateEnergy : ℝ

/-- Ground-state energy `U_f` of the photofragments `O₂ + O` (J). -/
opaque fragmentsGroundStateEnergy : ℝ

/-- Energy gap `ΔU = U_f − Uᵢ` (J): the energy that must be supplied to
    dissociate ozone at rest into `
... [suffix omitted]
```

### Blueprint excerpt
```tex
... [prefix omitted]
ga is absorbed by an ozone molecule O3 at rest,
dissociating it into O2 and O.  Let U\_i and U\_f be the ground-state energies of
O3 and O2 and define Delta U = U\_f - U\_i.  The outgoing O2 momentum makes angle
theta with the incident photon.  Treat the oxygen fragments classically and
non-relativistically, take the mass of an oxygen atom to be m, and use photon
momentum p\_gamma = E\_gamma/c = hbar*omega/c.

Current subquestion:
Determine the minimum angular frequency omega\_min required for dissociation at outgoing O2 angle theta, in terms of hbar, c, theta, Delta U, and m.

\paragraph{Current subquestion.}
Determine the minimum angular frequency omega\_min required for dissociation at outgoing O2 angle theta, in terms of hbar, c, theta, Delta U, and m.

\paragraph{Recorded answer/context.}
For theta <= pi/2, omega\_min = 3*m*c\textasciicircum{}2*[1 - sqrt(1 - (Delta U/(3*m*c\textasciicircum{}2))*(2*sin(theta)\textasciicircum{}2 + 1))]/[hbar*(2*sin(theta)\textasciicircum{}2 + 1)]. For theta >= pi/2 use the same threshold evaluated at theta = pi/2.

\paragraph{Figure/image path.}
/root/proposal\_for\_physic/science-mango/ipho\_2026\_source/image/T1\_page-3.png

\paragraph{Formalization target.}
create a compiling Lean file with sorry bodies at `IPhO2026Problems/problem\_IPhO\_2026\_1\_C\_1.lean`.
The Lean declarations must preserve the physical quantities, dimensions or dimensional roles, figure labels, governing-law hypotheses, and final relation expressed by this problem.
Use Mathlib/Physlib names found through LeanExplore where available. If a domain API is missing, introduce faithful local abstractions rather than scalar placeholder aliases.

\begin{theorem}[Physics formalization target]
\label{thm:physics:IPhO_2026_1_C_1:target}
\uses{thm:IPhO2026Problems_problem_IPhO_2026_1_C_1:minimum_angular_frequency_T1_C1, thm:IPhO2026Problems_problem_IPhO_2026_1_C_1:hbarOmegaMin_pi_sub}
The assigned autoformalize agent should translate this physics problem into Lean declarations in the covered file, with theorem and lemma proof bodies written as `by sorry`.
\end{theorem}
\begin{proof}
This is an autoformalization task, not a proof task. Produce faithful statements that can later be proved without weakening the source contract.
\end{proof}
% NOTE: PhysLean-coverage exemption (planner-recorded, iter-002): PhysLean has no module for relativistic two-body photodissociation kinematics (see this file's physics-grounding log for the near-miss query results). Self-con
... [suffix omitted]
```

## 4. `IPhO2026Problems/problem_IPhO_2026_2_C_2.lean`

- Open placeholders: 2
- Proof Review: new; attempts=0
- Review reason: (none)
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_2_C_2.tex`

### Lean excerpt
```lean
... [prefix omitted]
is the derivative identity
`(d/dθ) cot (2 * θ) = -2 * csc (2 * θ) ^ 2` applied to the smooth ray
family; it is a target conclusion of the subquestion, not an assumption. -/
theorem ray_B_slope_first_order :
    (fun Δθ : ℝ ↦
        s.m_B s.θ Δθ - (cot (2 * s.θ) - 2 * (sin (2 * s.θ))⁻¹ ^ 2 * Δθ))
      =o[𝓝 0] fun Δθ : ℝ ↦ Δθ := by
  -- Unpack the smooth-governing-law interface (slope side): some slope
  -- `dm` linearizes `M` about `θ`.
  obtain ⟨dm, hdm⟩ := s.M_first_order
  -- The C.1 recorded value fixes the zeroth order.
  have hM : s.M s.θ = cot (2 * s.θ) := by rw [← s.m_A_eq, s.m_A_formula]
  -- Ray-B family membership rewrites the target defect against `hdm`.
  apply hdm.congr' _ (EventuallyEq.refl _ _)
  refine Eventually.of_forall fun Δθ ↦ ?_
  -- Remaining identification: the interface slope `dm` is the derivative
  -- value `(d/dθ) cot (2θ) = -2 csc(2θ)²`.  The frozen existential
  -- interface underdetermines this coefficient for an arbitrary family
  -- (see task result / redraft note), so the coefficient step is isolated
  -- here with the rest of the argument fully formalized.
  have hdmval : dm = -2 * (sin (2 * s.θ))⁻¹ ^ 2 := by
    -- BLOCKED (honest gap, redraft requested — see task result):
    -- this is a `deriv`-value identity `(d/dθ) cot (2θ) = -2 csc(2θ)²`
    -- applied to the hidden interface slope; the frozen existential
    -- regularity interface does not determine `dm` for an arbitrary
    -- family, so this step is not derivable as stated.
    sorry
  change s.M (s.θ + Δθ) - s.M s.θ - dm * Δθ
      = s.m_B s.θ Δθ - (cot (2 * s.θ) - 2 * (sin (2 * s.θ))⁻¹ ^ 2 * Δθ)
  calc s.M (s.θ + Δθ) - s.M s.θ - dm * Δθ
      = s.M (s.θ + Δθ) - cot (2 * s.θ) - -2 * (sin (2 * s.θ))⁻¹ ^ 2 * Δθ := by
        rw [hM, hdmval]
    _ = s.m_B s.θ Δθ - (cot (2 * s.θ) - 2 * (sin (2 * s.θ))⁻¹ ^ 2 * Δθ) := by
        rw [s.m_B_eq]; ring

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
  -- Unpack the smooth-governing-law interface (intercept side).
  obtain ⟨db, hdb⟩ := s.B_first_order
  -- The C.1 recorded value fixes the zeroth order.
  have hB : s.B s.θ = s.R / (2 * cos s.θ) := by rw [← s.b_A_eq, s.b_A_formula]
  apply hdb.congr' _ (EventuallyEq.refl _ _)
  refine Eventually.of_forall fun Δθ ↦ ?_
  -- Remaining identification: the interface slope `db` is the derivative
  -- value `(d/dθ) (R / (2 cos θ)) = (R / (2 cos θ)) tan θ`.  The frozen
  -- existential interface underdetermines this coefficient for an
  -- arbitrary family (see task result / redraft note); the
... [suffix omitted]
```

### Blueprint excerpt
```tex
... [prefix omitted]
mirror of radius R, ray A is incident at angle theta
and its reflected line is y = m\_A*x + b\_A.  A neighboring parallel ray B is
incident at theta + Delta theta, with Delta theta much smaller than theta, and
its reflected line is y = m\_B*x + b\_B.  The envelope/intersection of neighboring
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
create a compiling Lean file with sorry bodies at `IPhO2026Problems/problem\_IPhO\_2026\_2\_C\_2.lean`.
The Lean declarations must preserve the physical quantities, dimensions or dimensional roles, figure labels, governing-law hypotheses, and final relation expressed by this problem.
Use Mathlib/Physlib names found through LeanExplore where available. If a domain API is missing, introduce faithful local abstractions rather than scalar placeholder aliases.

\begin{theorem}[Physics formalization target]
\label{thm:physics:IPhO_2026_2_C_2:target}
\uses{thm:IPhO2026Problems_problem_IPhO_2026_2_C_2:ray_B_first_order_expansion}
The assigned autoformalize agent should translate this physics problem into Lean declarations in the covered file, with theorem and lemma proof bodies written as `by sorry`.
\end{theorem}
\begin{proof}
This is an autoformalization task, not a proof task. Produce faithful statements that can later be proved without weakening the source contract.
\end{proof}
% NOTE: PhysLean-coverage exemption (planner-recorded, iter-002): PhysLean has no geometric-optics/asymptotic-expansion module for the first-order mirror regime; the formalization uses Mathlib `Asymptotics.IsLittleO` contracts (see the physics-grounding log for this file). Self-containment is k
... [suffix omitted]
```

## 5. `IPhO2026Problems/problem_IPhO_2026_2_C_4.lean`

- Open placeholders: 1
- Proof Review: new; attempts=0
- Review reason: (none)
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_2_C_4.tex`

### Lean excerpt
```lean
... [prefix omitted]
austic). All
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
create a compiling Lean file with sorry bodies at `IPhO2026Problems/problem\_IPhO\_2026\_2\_C\_4.lean`.
The Lean declarations must preserve the physical quantities, dimensions or dimensional roles, figure labels, governing-law hypotheses, and final relation expressed by this problem.
Use Mathlib/Physlib names found through LeanExplore where available. If a domain API is missing, introduce faithful local abstractions rather than scalar placeholder aliases.

\begin{theorem}[Physics formalization target]
\label{thm:physics:IPhO_2026_2_C_4:target}
\uses{thm:IPhO2026Problems_problem_IPhO_2026_2_C_4:caustic_small_angle_power_law}
The assigned autoformalize agent should translate this physics problem into Lean declarations in the covered file, with theorem and lemma proof bodies written as `by sorry`.
\end{theorem}
\begin{proof}
This is an autoformalization task, not a proof task. Produce faithful statements that can later be proved without weakening the source contract.
\end{proof}
% NOTE: PhysLean-coverage exemption (planner-recorded, iter-002): PhysLean has no caustic/power-law asymptotics module for the small-angle caustic part (see this file's physics-grounding log). Self-containment is kept with the `import Mathlib` baseline; no irrelevant Physlib import is added.
... [suffix omitted]
```

## 6. `IPhO2026Problems/problem_IPhO_2026_3_A_1.lean`

- Open placeholders: 1
- Proof Review: new; attempts=0
- Review reason: (none)
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_3_A_1.tex`

### Lean excerpt
```lean
... [prefix omitted]
m_eq
  have hD : 2 * Real.pi * T.meanRadius ≠ 0 :=
    mul_ne_zero (mul_ne_zero (ne_of_gt two_pos) (ne_of_gt Real.pi_pos))
      (ne_of_gt T.meanRadius_pos)
  have hN : (T.numTurns : ℝ) ≠ 0 := by
    exact_mod_cast ne_of_gt T.numTurns_pos
  have hsteps : (T.numTurns : ℝ) * (2 * Real.pi * T.meanRadius * T.fieldMagnitude)
      = (T.numTurns : ℝ) * T.wireCurrent.readout :=
    calc (T.numTurns : ℝ) * (2 * Real.pi * T.meanRadius * T.fieldMagnitude)
        = 2 * Real.pi * T.meanRadius
            * ((T.numTurns : ℝ) * T.fieldMagnitude) := by ring
      _ = (T.numTurns : ℝ) * T.wireCurrent.readout := key
  have hF : 2 * Real.pi * T.meanRadius * T.fieldMagnitude
      = T.wireCurrent.readout := mul_left_cancel₀ hN hsteps
  rw [eq_div_iff hD]
  -- goal: fieldMagnitude * (2πR) = N * I
  -- NOTE (countermodel check): as stated, `key : (2πR)·(N·H) = N·I` forces
  -- `(2πR)·H = I` (cancelling N), hence H·(2πR) = I — NOT N·I (e.g.
  -- 2πR=2, N=2, H=1, I=2 satisfies key but not the goal).  The goal as
  -- stated is therefore not a consequence of the bundled laws; this is a
  -- redraft candidate recorded in the task result.  The reduction to the
  -- cancelled law `hF` is kept; the remaining gap is exactly the step
  -- where the physics model's factor N re-enters.
  calc T.fieldMagnitude * (2 * Real.pi * T.meanRadius)
      = 2 * Real.pi * T.meanRadius * T.fieldMagnitude :=
        mul_comm _ _
    _ = T.wireCurrent.readout := hF
    _ = (T.numTurns : ℝ) * T.wireCurrent.readout := by sorry

/-- Bridge 3 — geometry bridge: `2πR = V / A`, rewriting the mean-path
length in terms of the torus volume and cross-sectional area. -/
theorem mean_circumference_eq (T : ParamagneticTorusA1) :
    2 * Real.pi * T.meanRadius = T.volume / T.crossSectionArea := by
  have hA : T.crossSectionArea ≠ 0 := ne_of_gt T.crossSectionArea_pos
  rw [T.volume_eq]
  field_simp

/-- Bridge 4 — the figure parametrization of the answer along the mean
path: `N·I/(2πR) = N·I·A/V`. -/
theorem meanRadius_form_eq_volume_form (T : ParamagneticTorusA1) :
    (T.numTurns : ℝ) * T.wireCurrent.readout / (2 * Real.pi * T.meanRadius)
      = (T.numTurns : ℝ) * T.wireCurrent.readout * T.crossSectionArea
          / T.volume := by
  have hR : 2 * Real.pi * T.meanRadius ≠ 0 :=
    mul_ne_zero (mul_ne_zero (ne_of_gt two_pos) (ne_of_gt Real.pi_pos))
      (ne_of_gt T.meanRadius_pos)
  have hV : T.volume ≠ 0 := ne_of_gt T.volume_pos
  have hA : T.crossSectionArea ≠ 0 := ne_of_gt T.crossSectionArea_pos
  rw [T.mean_circumference_eq]
  field_simp

end ParamagneticTorusA1

/-! ### Main target theorem (T3-A1) -/

/-- **Part A.1 target**: the magnitude `H` of the field `H⃗` inside the
paramagnetic torus, expressed in terms of `N`, `A`, `V` and the
instantaneous current `I` in the wire, is

`H = N·I·A / V`.

Derivation route (informal): by Ampère's law `∮ H·dℓ = I_C` applied to the
mean amperian loop of length `2πR`, and by the uniformity of the field
magnitude in the thin torus, `2πR·(N·H) = N·I`; solving for
... [suffix omitted]
```

### Blueprint excerpt
```tex
... [prefix omitted]
on physics formalization source begin ---
% archon:physics
% archon:covers IPhO2026Problems/problem_IPhO_2026_3_A_1.lean
% archon:source-report reports/ipho_2026_k3/problem_IPhO_2026_3_A_1.source.json
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
create a compiling Lean file with sorry bodies at `IPhO2026Problems/problem\_IPhO\_2026\_3\_A\_1.lean`.
The Lean declarations must preserve the physical quantities, dimensions or dimensional roles, figure labels, governing-law hypotheses, and final relation expressed by this problem.
Use Mathlib/Physlib names found through LeanExplore where available. If a domain API is missing, introduce faithful local abstractions rather than scalar placeholder aliases.

\begin{theorem}[Physics formalization target]
\label{thm:physics:IPhO_2026_3_A_1:target}
\uses{thm:IPhO2026Problems_problem_IPhO_2026_3_A_1:paramagneticTorus_H_eq_meanRadius}
The assigned autoformalize agent should translate this physics problem into Lean declarations in the covered file, with theorem and lemma proof bodies written as `by sorry`.
\end{theorem}
\begin{proof}
This is an autoformalization task, not a proof task. Produce faithful statements that can later be proved without weakening the source contract.
\end{proof}
% NOTE: PhysLean-coverage exemption (planner-recorded, iter-003): PhysLean's electromagnetism modules have no Ampere-circulation / toroid H-field assembly API for this part's current-operating-point model (see this file's physics-grounding log); the typed `InstantaneousCurrent` amount+dim
... [suffix omitted]
```

## 7. `IPhO2026Problems/problem_IPhO_2026_3_B_1.lean`

- Open placeholders: 3
- Proof Review: new; attempts=0
- Review reason: (none)
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_3_B_1.tex`

### Lean excerpt
```lean
import Mathlib

/-!
# IPhO 2026, Problem 3, Part B.1 — Paramagnetic torus: isothermal heat transfer

A paramagnetic material fills a torus of fixed volume `V` and amount `n` (moles).
Governing laws (given in the problem statement):

* Equation of state (paramagnet): `T * M * V = n * K * H`, with `K` a material
  constant of the paramagnet.
* Heat capacity at constant magnetization: `C_M T = n * lambda / T^2`,
  with `dU = C_M T * dT` at constant `M` (internal energy depends on `T` alone).
* Magnetic work done **on** the material (result of part A.3):
  `dW = μ₀ * V * H * dM` along quasistatic processes.
* First law of thermodynamics with the source sign convention
  ("work and heat entering the torus are positive"):
  `Q = ΔU - W_on` for each quasistatic process, and along an isothermal
  process `ΔU = 0` because `dU = C_M dT`, so `Q = -W_on` there.

Current subquestion: at fixed temperature `T`, `H` changes from `H_i` to `H_f`;
find the heat `Q` transferred into the torus.

Recorded official answer:
`Q = -(μ₀ * n * K / (2 * T)) * (H_f^2 - H_i^2)`.

This file is an autoformalization: all proof bodies are `by sorry`.
-/

namespace IPhO2026.Problem3.B1

open Real

/-- Constant parameters of the paramagnetic torus experiment.  `K` is the
material constant of the paramagnet appearing in the equation of state
`T * M * V = n * K * H` (it absorbs Curie-type constants); `lambda` is the
coefficient of the heat capacity `C_M = n * lambda / T^2` at constant
magnetization.  All fields are physical scalars; positivity/regularity
constraints are stated separately as hypotheses where they are needed. -/
structure TorusParams where
  /-- Permeability of free space, in SI units. -/
  mu0 : ℝ
  /-- Fixed volume of the torus. -/
  V : ℝ
  /-- Amount of paramagnetic material, in moles. -/
  n : ℝ
  /-- Material constant of the paramagnet in the equation of state. -/
  K : ℝ
  /-- Heat-capacity coefficient: `C_M = n * lambda / T^2`. -/
  lambda : ℝ

/-- State variables that vary along a quasistatic process of the torus:
temperature `T`, magnetization `M`, and applied magnetic field strength `H`.
The volume is fixed and therefore lives in `TorusParams`, not here. -/
structure TorusState where
  /-- Thermodynamic temperature. -/
  T : ℝ
  /-- Magnetization of the material (magnetic moment per unit volume). -/
  M : ℝ
  /-- Applied magnetic field strength. -/
  H : ℝ

/-- The magnetic equation of state of the torus material:
`T * M * V = n * K * H`.  This is a governing law, not the current target. -/
def SatisfiesEOS (p : TorusParams) (s : TorusState) : Prop :=
  s.T * s.M * p.V = p.n * p.K * s.H

/-- The heat capacity at constant magnetization as given by the problem:
`C_M T = n * lambda / T^2`. -/
noncomputable def heatCapacityConstM (p : TorusParams) (T : ℝ) : ℝ :=
  p.n * p.lambda / T ^ 2

/-- Characterization of the material's internal energy: at constant
magnetization `dU = C_M dT`, i.e. `U` depends on temperature alone and is
differentiable with derivative `C_M
... [suffix omitted]
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
create a compiling Lean file with sorry bodies at `IPhO2026Problems/problem\_IPhO\_2026\_3\_B\_1.lean`.
The Lean declarations must preserve the physical quantities, dimensions or dimensional roles, figure labels, governing-law hypotheses, and final relation expressed by this problem.
Use Mathlib/Physlib names found through LeanExplore where available. If a domain API is missing, introduce faithful local abstractions rather than scalar placeholder aliases.

\begin{theorem}[Physics formalization target]
\label{thm:physics:IPhO_2026_3_B_1:target}
\uses{thm:IPhO2026Problems_problem_IPhO_2026_3_B_1:OfficialAnswerValue}
The assigned autoformalize agent should translate this physics problem into Lean declarations in the covered file, with theorem and lemma proof bodies written as `by sorry`.
\end{theorem}
\begin{proof}
This is an autoformalization task, not a proof task. Produce faithful statements that can later be proved without weakening the source contract.
\end{proof}
% NOTE: PhysLean-coverage exemption (planner-recorded, iter-002): PhysLean's thermodynamics modules do not cover this paramagnetic-torus magnetic-work/isothermal-first-law model (see this file's physics-grounding log). Self-containment is kept with the `import Mathlib` baseline; no irrelevant Physlib i
... [suffix omitted]
```

## 8. `IPhO2026Problems/problem_IPhO_2026_3_B_2.lean`

- Open placeholders: 3
- Proof Review: new; attempts=0
- Review reason: (none)
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_3_B_2.tex`

### Lean excerpt
```lean
... [prefix omitted]
(∀ t, Cm t = params.n * params.lam / (p t).temperature ^ 2) ∧
    (∀ t, w t = params.mu0 * params.V * (p t).field * deriv
      (fun s => (p s).magnetization) t) ∧
    ∀ t,
      Cm t * deriv (fun s => (p s).temperature) t = -w t

/-- The adiabatic invariant of the process: `T²·(λ + μ₀·K·H²)`, conserved
along any adiabatic path of the torus. -/
noncomputable def adiabaticInvariant (params : TorusParameters)
    (T H : ℝ) : ℝ :=
  T ^ 2 * (params.lam + params.mu0 * params.K * H ^ 2)

/-- Initial data of the adiabatic ramp: the path passes through field `Hi`
at temperature `Ti`, with `Hi ≥ 0` and `Ti > 0` (matching the physical
setup in which the signed ramp starts from a nonnegative field). -/
structure AdiabaticEndpoints (p : StatePath) (Hi Ti : ℝ) : Prop where
  Hi_nonneg : 0 ≤ Hi
  Ti_pos : 0 < Ti
  initial : ∃ t0, (p t0).field = Hi ∧ (p t0).temperature = Ti

/-- **Bridge lemma 1 — the integrated adiabat.**
From the governing laws (`ParamagneticTorusLaws`) and the adiabatic
first-law balance (`IsAdiabaticPath`), any two states of one adiabatic path
share the same value of `T²·(λ + μ₀·K·H²)`.  Carrier of the
integration step `dT/T = −(μ₀K/λ)·H dH`. -/
theorem adiabatic_invariant_along_path (params : TorusParameters)
    (p : StatePath) (laws : ParamagneticTorusLaws params p)
    (hadiabatic : IsAdiabaticPath params p laws) (t₁ t₂ : ℝ) :
    adiabaticInvariant params (p t₁).temperature (p t₁).field
      = adiabaticInvariant params (p t₂).temperature (p t₂).field := by
  sorry

/-- **Bridge lemma 2 — endpoint to endpoint.**
Specialized to the recorded endpoints `(H_i, T_i)` and `(H_f, T_f)` of the
ramp, the invariant equality gives
`T_f²·(λ + μ₀·K·H_f²) = T_i²·(λ + μ₀·K·H_i²)`. -/
theorem endpoint_relation (params : TorusParameters) (p : StatePath)
    (laws : ParamagneticTorusLaws params p)
    (hadiabatic : IsAdiabaticPath params p laws)
    {Hi Hf Ti Tf : ℝ}
    (hendpoints : AdiabaticEndpoints p Hi Ti)
    (hfinal : ∃ tf, (p tf).field = Hf ∧ (p tf).temperature = Tf) :
    Tf ^ 2 * (params.lam + params.mu0 * params.K * Hf ^ 2)
      = Ti ^ 2 * (params.lam + params.mu0 * params.K * Hi ^ 2) := by
  sorry

/-- Positive bracket: `λ + μ₀·K·H² > 0` for the positive parameters of the
problem and any signed field `H` — records why the square root and the
quotient in the final answer are well-defined for either ramp direction. -/
theorem lam_add_mu0_K_sq_pos (params : TorusParameters) (H : ℝ) :
    0 < params.lam + params.mu0 * params.K * H ^ 2 := by
  have hK : 0 < params.K := params.K_pos
  have hmu : 0 < params.mu0 := params.mu0_pos
  have hlam : 0 < params.lam := params.lam_pos
  positivity

/-- **Main target (B.2).**  For an adiabatic change `H_i → H_f` of the
paramagnetic torus starting at temperature `T_i`, the temperature change is
    `ΔT = T_f − T_i
        = T_i·(√((λ + μ₀·K·H_f²)/(λ + μ₀·K·H_i²)) − 1)`.

The final relation is only on the conclusion side: the hypotheses are the
governing laws (`ParamagneticTorusLaws`), the first-law adia
... [suffix omitted]
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
create a compiling Lean file with sorry bodies at `IPhO2026Problems/problem\_IPhO\_2026\_3\_B\_2.lean`.
The Lean declarations must preserve the physical quantities, dimensions or dimensional roles, figure labels, governing-law hypotheses, and final relation expressed by this problem.
Use Mathlib/Physlib names found through LeanExplore where available. If a domain API is missing, introduce faithful local abstractions rather than scalar placeholder aliases.

\begin{theorem}[Physics formalization target]
\label{thm:physics:IPhO_2026_3_B_2:target}
\uses{thm:IPhO2026Problems_problem_IPhO_2026_3_B_2:adiabatic_temperature_change}
The assigned autoformalize agent should translate this physics problem into Lean declarations in the covered file, with theorem and lemma proof bodies written as `by sorry`.
\end{theorem}
\begin{proof}
This is an autoformalization task, not a proof task. Produce faithful statements that can later be proved without weakening the source contract.
\end{proof}
% NOTE: PhysLean grounding reconciliation (planner-recorded, iter-004): positive targeted-import case — the covered file genuinely uses `Physlib.Electromagnetism.Dynamics.Basic` (the `FreeSpace` structure, `mu0`, in the magnetic constitutive laws of the paramagnetic torus), alongside `Mathlib.
... [suffix omitted]
```

## 9. `IPhO2026Problems/problem_IPhO_2026_3_C_2.lean`

- Open placeholders: 9
- Proof Review: new; attempts=0
- Review reason: (none)
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_3_C_2.tex`

### Lean excerpt
```lean
... [prefix omitted]
IntoTorus`; it does not use
the C.2 conclusion. -/
lemma heat_isothermal_via_q (si sf : ParamagnetState p) {Q : ℝ}
    (hT : si.T = sf.T)
    (h : IsothermalHeatIntoTorus p si.T si.H sf.H Q) :
    Q = (p.μ₀ * p.V / 2) * (sf.T * sf.M ^ 2 - si.T * si.M ^ 2) := by
  obtain ⟨Ti, Hi, Mi, hTi, hHi, hMi, heosi⟩ := si
  obtain ⟨Tf, Hf, Mf, hTf, hHf, hMf, heosf⟩ := sf
  dsimp only at hT h ⊢
  subst hT
  rw [IsothermalHeatIntoTorus] at h
  have hnK : p.n * p.K ≠ 0 := mul_ne_zero (ne_of_gt p.n_pos) (ne_of_gt p.K_pos)
  have hef : Ti * Mf * p.V = p.n * p.K * Hf := heosf
  have hei : Ti * Mi * p.V = p.n * p.K * Hi := heosi
  have hfsq : Hf ^ 2 = (Ti * Mf * p.V / (p.n * p.K)) ^ 2 := by
    have hH : Hf = Ti * Mf * p.V / (p.n * p.K) := by
      rw [eq_div_iff hnK]
      linear_combination -hef
    rw [hH]
  have hisq : Hi ^ 2 = (Ti * Mi * p.V / (p.n * p.K)) ^ 2 := by
    have hH : Hi = Ti * Mi * p.V / (p.n * p.K) := by
      rw [eq_div_iff hnK]
      linear_combination -hei
    rw [hH]
  rw [h, hfsq, hisq]
  have hTpos : Ti ≠ 0 := ne_of_gt hTi
  have hn : p.n ≠ 0 := ne_of_gt p.n_pos
  have hK : p.K ≠ 0 := ne_of_gt p.K_pos
  -- The remaining identity is the pure real-algebra computation
  --
  --   $-\frac{\mu_0 n K}{2T}\Big[\Big(\frac{T M_f V}{nK}\Big)^2 - \Big(\frac{T M_i V}{nK}\Big)^2\Big]
  --     = \frac{\mu_0 V}{2}\big(T M_f^2 - T M_i^2\big)$,
  --
  -- valid for $nK \ne 0$ and $T \ne 0$.  The computation is recorded in the
  -- task result; the final algebraic step stays open here.
  sorry
  rw [e3]
  ring

/-- Along the heating leg $3\to4$: $Q_h = \tfrac12\mu_0 V (q_4 - q_3)$.
Carrier: `heat_34` + `heat_isothermal_via_q` (with `figure3b` giving
$T_3 = T_4 = T_h$). -/
lemma Qh_eq : m.Qh = (p.μ₀ * p.V / 2) * (m.q .v4 - m.q .v3) := by
  obtain ⟨-, hT4, -, hT3, -⟩ := m.figure3b
  have hrel : IsothermalHeatIntoTorus p m.Th (m.cyc.Hmag .v3) (m.cyc.Hmag .v4) (-m.Qh) :=
    m.heat_34
  rw [IsothermalHeatIntoTorus] at hrel
  have heos3 : m.cyc.T .v3 * m.cyc.Mmag .v3 * p.V = p.n * p.K * m.cyc.Hmag .v3 := m.eos .v3
  have heos4 : m.cyc.T .v4 * m.cyc.Mmag .v4 * p.V = p.n * p.K * m.cyc.Hmag .v4 := m.eos .v4
  have hnK : p.n * p.K ≠ 0 := mul_ne_zero (ne_of_gt p.n_pos) (ne_of_gt p.K_pos)
  have hH3 : m.cyc.Hmag .v3 ^ 2 = (m.cyc.T .v3 * m.cyc.Mmag .v3 * p.V / (p.n * p.K)) ^ 2 := by
    have hdiv : m.cyc.Hmag .v3 = m.cyc.T .v3 * m.cyc.Mmag .v3 * p.V / (p.n * p.K) := by
      rw [eq_div_iff hnK]
      linear_combination -heos3
    rw [hdiv]
  have hH4 : m.cyc.Hmag .v4 ^ 2 = (m.cyc.T .v4 * m.cyc.Mmag .v4 * p.V / (p.n * p.K)) ^ 2 := by
    have hdiv : m.cyc.Hmag .v4 = m.cyc.T .v4 * m.cyc.Mmag .v4 * p.V / (p.n * p.K) := by
      rw [eq_div_iff hnK]
      linear_combination -heos4
    rw [hdiv]
  rw [hT3] at heos3 hH3
  rw [hT4] at heos4 hH4
  -- The B.1 law on the leg $3\to4$ at $T_h$ gives
  -- $-Q_h = \tfrac12\mu_0 V (T_h M_4^2 - T_h M_3^2)$; the contracted
  -- statement asks for the *cold* expression $\tfrac12\mu_0 V (q_4 - q_3)$
  -- with $q_3, q_4$ at $T_c$, which the
... [suffix omitted]
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
create a compiling Lean file with sorry bodies at `IPhO2026Problems/problem\_IPhO\_2026\_3\_C\_2.lean`.
The Lean declarations must preserve the physical quantities, dimensions or dimensional roles, figure labels, governing-law hypotheses, and final relation expressed by this problem.
Use Mathlib/Physlib names found through LeanExplore where available. If a domain API is missing, introduce faithful local abstractions rather than scalar placeholder aliases.

\begin{theorem}[Physics formalization target]
\label{thm:physics:IPhO_2026_3_C_2:target}
\uses{def:IPhO2026Problems_problem_IPhO_2026_3_C_2:CarnotMagnetizationModel, thm:IPhO2026Problems_problem_IPhO_2026_3_C_2:m1_eq_sqrt}
The assigned autoformalize agent should translate this physics problem into Lean declarations in the covered file, with theorem and lemma proof bodies written as `by sorry`.
\end{theorem}
\begin{proof}
This is an autoformalization task, not a proof task. Produce faithful statements that can later be proved without weakening the source contract.
\end{proof}
% NOTE: PhysLean-coverage exemption (planner-recorded, iter-002): PhysLean has no Carnot-cycle-on-(M,H,T) module for this magnetization-relation part (see this file's physics-grounding log). Self-containment is kept with the `import Mathlib`
... [suffix omitted]
```

## 10. `IPhO2026Problems/problem_IPhO_2026_3_C_4.lean`

- Open placeholders: 2
- Proof Review: new; attempts=0
- Review reason: (none)
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_3_C_4.tex`

### Lean excerpt
```lean
... [prefix omitted]
cooled from `T_0` to `T` while the
refrigerator input power `P` and the hot-reservoir temperature `T_h` remain
constant.  Determine the elapsed time.

Recorded official answer (appears only on the conclusion side below):

    t = (C_c * T_h / P) * (ln (T_0 / T) - (T_0 - T) / T_h).

## Physical model of the cooling run

The cold end of the refrigerator is the body being cooled, so the
cold-reservoir temperature tracks the body's instantaneous temperature `T'`,
decreasing from `T_0` at `s = 0` to `T` at `s = t`.  Per infinitesimal
Carnot cycle executed at cold temperature `T'` (all "densities" below are
per unit temperature drop of the body, since the infinitesimal cycles are
indexed by the control temperature):

* calorimetry (meaning of the heat capacity `C_c`): the heat drawn from the
  body per unit temperature drop is `C_c`;
* Carnot heat ratio at cold temperature `T'`: `δQ_h = δQ_c * T_h / T'`;
* first law (work–heat balance over one cycle): `δW = δQ_h - δQ_c`;
* constant input power: `δW = P * δs`, i.e. the residence-time density is
  the work density divided by `P`.

Hence `δs / ΔT' = (C_c / P) * (T_h / T' - 1)` with `ΔT' > 0` the width of the
infinitesimal temperature window crossed at `T'` (the run cools, so `dT' < 0`
along the run; densities per unit *drop* record the cooling branch
explicitly), and

    t = ∫_{T}^{T_0} (C_c / P) * (T_h / T' - 1) dT'
      = (C_c * T_h / P) * (ln (T_0 / T) - (T_0 - T) / T_h).

This file is an autoformalization: every proof body is `sorry` by design, and
the recorded answer appears only as the conclusion of the target theorems.
-/

namespace IPhO2026.Problem3.C4

open MeasureTheory

section Quantities

/-!
### Named quantities

Physical scalars (SI units): temperatures in kelvin, heats and work in
joules, power in watts, times in seconds, heat capacity in joules per kelvin,
magnetization and applied field in ampere per metre, amount of substance in
moles, volume in cubic metres.  Result/recorded quantities are `opaque`
parameters rather than transparent aliases so the contracts cannot be closed
by unfolding; the varying control temperature `T'` of the run stays a bound
variable, so the instantaneous laws below range over it quantificationally.
-/

/-- Hot-reservoir temperature `T_h`, constant throughout the run (K). -/
opaque tempHot : ℝ

/-- Body's initial temperature `T_0` (K): the cold-reservoir temperature at
    `s = 0`. -/
opaque tempInitial : ℝ

/-- Body's final temperature `T` (K): the cold end of the cooling process,
    with `T < T_0`. -/
opaque tempFinal : ℝ

/-- Constant heat capacity `C_c` of the cooled body (J/K). -/
opaque heatCapacityBody : ℝ

/-- Constant mechanical input power `P` drawn by the refrigerator (W). -/
opaque inputPower : ℝ

/-- Elapsed time `t` of the cooling run from `T_0` to `T` (s); the quantity
    the subquestion asks to determine.  Its *value* (the recorded answer) is
    only ever a conclusion below. -/
opaque elapsedTime : ℝ

/-- Constant parameters of the paramagne
... [suffix omitted]
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
create a compiling Lean file with sorry bodies at `IPhO2026Problems/problem\_IPhO\_2026\_3\_C\_4.lean`.
The Lean declarations must preserve the physical quantities, dimensions or dimensional roles, figure labels, governing-law hypotheses, and final relation expressed by this problem.
Use Mathlib/Physlib names found through LeanExplore where available. If a domain API is missing, introduce faithful local abstractions rather than scalar placeholder aliases.

\begin{theorem}[Physics formalization target]
\label{thm:physics:IPhO_2026_3_C_4:target}
\uses{thm:IPhO2026Problems_problem_IPhO_2026_3_C_4:c4_elapsed_time}
The assigned autoformalize agent should translate this physics problem into Lean declarations in the covered file, with theorem and lemma proof bodies written as `by sorry`.
\end{theorem}
\begin{proof}
This is an autoformalization task, not a proof task. Produce faithful statements that can later be proved without weakening the source contract.
\end{proof}
% NOTE: PhysLean-coverage exemption (planner-recorded, iter-002): PhysLean's thermodynamics modules do not cover this paramagnetic-torus infinitesimal-cycle (M,H,T) model; the formalization uses the local `CoolingRun` density-formulation with Mathlib interval-integral anchors (see the physics-grounding log
... [suffix omitted]
```

## 11. `IPhO2026Problems/problem_IPhO_2026_4_A_5.lean`

- Open placeholders: 1
- Proof Review: new; attempts=0
- Review reason: (none)
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_4_A_5.tex`

### Lean excerpt
```lean
... [prefix omitted]
lycol (PG) to height `h = 4.5 cm`,
undergoes an isochoric (constant-volume) process while the outer-cylinder
(OC) water bath is heated. The gas obeys the ideal-gas equation of state
`P * V = n * R * T` (Eq. (1) of the source). After recording `P(T)` (A.2)
and plotting it (A.3, linear isochore), this subquestion asks for the
constant-volume thermal pressure coefficient

```
beta0 = (1 / P0) * (Delta P / Delta T)      (Eq. (2) of the source)
```

where `P0` is the system pressure at the reference temperature `T0`,
together with its experimental uncertainty (official sample
`beta0 = 0.0034 ± 0.0007 K^-1`; ideal-gas reference
`1 / 273.15 K = 0.0037 K^-1`, which the reported band covers).

## Layout of the assumptions

* Governing law: `IsIdealGasLaw` (Eq. (1), `P V = n R T` statewise, with
  `n` and `V` constant for the sealed isochoric CA).
* Previous-part result (A.3, natural-language prerequisite only):
  `IsIsochoricLinear` (`P` is affine in the absolute temperature).
* Figure/data readouts: `pgHeight` (`h = 0.045 m`, volume fix),
  `ambientAirDensity` (`rho = 1.12 kg/m^3`, time-averaged).
* Sparse readout data: `IsochoricReadout` (two pre/post readouts `T1`,
  `T2` around the reference temperature with the corresponding pressure
  values, consistent with the recorded increments).

The current target conclusion (the value of `beta0` and its uncertainty
relation) appears only on the conclusion side of `main`, never as a
hypothesis.

All proof bodies are intentionally left as `sorry`: this is the
autoformalization stage.
-/

import Mathlib
import Physlib.Thermodynamics.Basic
import Physlib.Thermodynamics.Temperature.Basic
import Physlib.StatisticalMechanics.MicroCanonicalEnsemble.IdealGas

namespace IPhO2026_4_A_5

open Temperature

noncomputable section

/-! ## Physical setup parameters (apparatus and ambient data) -/

/-- The absolute temperature as a real number.

Projection of PhysLean's `Temperature` (an arbitrary-unit absolute
temperature type wrapping nonnegative reals) to its real-number value.
Zero is absolute zero in any such unit system. -/
def absTemp : Temperature → ℝ := Temperature.toReal

/-- Height of propylene glycol (PG) introduced into the inner cylinder (IC),
in metres. Introducing PG to `h = 4.5 cm` and closing valves D and E fixes
(seals) the volume of the air column CA, enabling the isochoric process. -/
def pgHeight : ℝ := 0.045

/-- Time-averaged ambient air density in Bucaramanga, `rho = 1.12 kg/m^3`
(the source notes that the density varies with local temperature and
pressure and prescribes the time-averaged value throughout Part A). -/
def ambientAirDensity : ℝ := 1.12

/-- The reference absolute temperature `T0` used in the definition of `beta0`
(source: "P0 is the pressure of the system at the reference temperature T0
as indicated in the reference constants and values"). For air the ideal-gas
reference is `T0 = 273.15 K`, so that `1 / T0 = 0.0037 K^-1`. -/
def referenceAbsTemperature : ℝ := 273.15

/-- An isochoric (co
... [suffix omitted]
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
create a compiling Lean file with sorry bodies at `IPhO2026Problems/problem\_IPhO\_2026\_4\_A\_5.lean`.
The Lean declarations must preserve the physical quantities, dimensions or dimensional roles, figure labels, governing-law hypotheses, and final relation expressed by this problem.
Use Mathlib/Physlib names found through LeanExplore where available. If a domain API is missing, introduce faithful local abstractions rather than scalar placeholder aliases.

\begin{theorem}[Physics formalization target]
\label{thm:physics:IPhO_2026_4_A_5:target}
\uses{thm:IPhO2026Problems_problem_IPhO_2026_4_A_5:main}
The assigned autoformalize agent should translate this physics problem into Lean declarations in the covered file, with theorem and lemma proof bodies written as `by sorry`.
\end{theorem}
\begin{proof}
This is an autoformalization task, not a proof task. Produce faithful statements that can later be proved without weakening the source contract.
\end{proof}

% NOTE: PhysLean grounding reconciliation (planner-recorded, iter-004): positive targeted-import case — the covered file genuinely uses `Physlib.Thermodynamics.Basic`, `Physlib.Thermodynamics.Temperature.Basic` (typed `Temperature`/`absTemp`) and `Physlib.StatisticalMechanics.MicroCanonicalEnsemble.IdealGas` (ideal-
... [suffix omitted]
```

## 12. `IPhO2026Problems/problem_IPhO_2026_4_B_6.lean`

- Open placeholders: 1
- Proof Review: new; attempts=0
- Review reason: (none)
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_4_B_6.tex`

### Lean excerpt
```lean
... [prefix omitted]
clusion — witnessed by
`IsSpecificLatentHeatOf Lv Qv M0` together with the catalog matching
conditions `Qv_magnitude = 39 kJ/mol`, `M0_magnitude = 18.0 × 10⁻³ kg/mol` —
and the uncertainty `±110 kJ/kg` is preserved through
`SpecificLatentHeatValue.withinUncertainty`. -/
theorem latent_heat_per_unit_mass_target
    (input : PartB6Input)
    (Qv : MolarEnergy) (M0 : MolarMass) (Lv : SpecificLatentHeat)
    (Lv_reported : SpecificLatentHeatValue) :
    ∃ witness : IsSpecificLatentHeatOf Lv Qv M0,
      witness.Qv_magnitude_kJ_per_mol = catalogQvValue ∧
      witness.M0_magnitude_kg_per_mol = catalogMolarMassWaterValue ∧
      Lv_reported.withinUncertainty officialSpecificLatentHeatValue := by
  refine ⟨⟨catalogQvValue, catalogMolarMassWaterValue,
      catalogQvValue / catalogMolarMassWaterValue, rfl, by
        rw [catalogMolarMassWaterValue]; norm_num⟩,
    rfl, rfl, ?_⟩
  -- Remaining obligation:
  --   `Lv_reported.withinUncertainty officialSpecificLatentHeatValue`,
  -- i.e. `|Lv_reported.central_kJ_per_kg - 2190| ≤ 110`.
  -- This is NOT provable as stated: `Lv_reported` is universally quantified
  -- and unconstrained, so e.g. `Lv_reported.central_kJ_per_kg = 10000` is a
  -- countermodel. The honest reported value
  -- `Lv_reported.central_kJ_per_kg = 39/18.0e-3 ≈ 2166.7` would give
  -- `|2166.7 - 2190| ≈ 23.3 ≤ 110` (proved below in
  -- `computed_value_within_official_uncertainty`). See the redraft request
  -- in the iter-010 task result (`.archon/task_results/`).
  sorry

/-- **B.6 formula (explicit scalar form).** For the catalog central values,
the specific latent heat of vaporization of water is the molar latent heat
divided by the molar mass of water,

`Lᵥ = Qᵥ / M₀ = 39 kJ/mol / (18.0 × 10⁻³ kg/mol) ≈ 2190 kJ/kg`,

within the official uncertainty `±110 kJ/kg`. This is the formula the
subquestion asks to state. -/
theorem latent_heat_per_unit_mass_formula :
    ∃ Lv Qv M0 : ℝ,
      Qv = catalogQvValue ∧
      M0 = catalogMolarMassWaterValue ∧
      Lv = Qv / M0 ∧
      |Lv - officialSpecificLatentHeatValue.central_kJ_per_kg| ≤
        officialSpecificLatentHeatValue.uncertainty_kJ_per_kg := by
  refine ⟨catalogQvValue / catalogMolarMassWaterValue, catalogQvValue,
    catalogMolarMassWaterValue, rfl, rfl, rfl, ?_⟩
  show |(catalogQvValue / catalogMolarMassWaterValue : ℝ) - 2190| ≤ 110
  rw [catalogQvValue, catalogMolarMassWaterValue, abs_le]
  constructor <;> norm_num

/-- **Uncertainty preservation (B.6).** The uncertainty propagated to `Lᵥ`
from the B.5 uncertainty `Qᵥ = 39 ± 2 kJ/mol` (relative uncertainty
`2/39 ≈ 5.1%`, with `M₀` treated as exact) is `±110 kJ/kg` about the central
value `2190 kJ/kg`: the computed central value
`Lᵥ = 39 kJ/mol / 18.0 × 10⁻³ kg/mol ≈ 2167 kJ/kg` lies within the official
interval `2190 ± 110 kJ/kg`. -/
theorem computed_value_within_official_uncertainty :
    |(catalogQvValue / catalogMolarMassWaterValue) -
        officialSpecificLatentHeatValue.central_kJ_per_kg| ≤
      officialSpecificLatentHeat
... [suffix omitted]
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
create a compiling Lean file with sorry bodies at `IPhO2026Problems/problem\_IPhO\_2026\_4\_B\_6.lean`.
The Lean declarations must preserve the physical quantities, dimensions or dimensional roles, figure labels, governing-law hypotheses, and final relation expressed by this problem.
Use Mathlib/Physlib names found through LeanExplore where available. If a domain API is missing, introduce faithful local abstractions rather than scalar placeholder aliases.

\begin{theorem}[Physics formalization target]
\label{thm:physics:IPhO_2026_4_B_6:target}
\uses{thm:IPhO2026Problems_problem_IPhO_2026_4_B_6:latent_heat_per_unit_mass_target}
The assigned autoformalize agent should translate this physics problem into Lean declarations in the covered file, with theorem and lemma proof bodies written as `by sorry`.
\end{theorem}
\begin{proof}
This is an autoformalization task, not a proof task. Produce faithful statements that can later be proved without weakening the source contract.
\end{proof}
% NOTE: PhysLean grounding reconciliation (planner-recorded, iter-004): positive targeted-import case — the covered file genuinely uses `Physlib.Thermodynamics.Basic` and `Physlib.Thermodynamics.Temperature.Basic` (typed `Temperature` quantities for the measured temperature process); the b
... [suffix omitted]
```

## 13. `IPhO2026Problems/problem_IPhO_2026_4_C_7.lean`

- Open placeholders: 4
- Proof Review: new; attempts=0
- Review reason: (none)
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_4_C_7.tex`

### Lean excerpt
```lean
... [prefix omitted]
er temperatures `T_IC` and `T_OC` as functions of
time. Two governing relations are given in the problem text:

* Equation (4) (lumped heat-flow model): `dQ/dt = (T_OC − T_IC) / R_Th`,
  where `R_Th` is the effective thermal resistance of the wall (its value
  `R_Th = 1.17 ± 0.03 K/W` was determined in part C.6 from the C5 graph).
* Equation (6) (Fourier's law for radial conduction through a slim
  cylindrical wall): `dQ/dt = −λ·A·dT/dr`, where `A` is the area of the
  wall, `λ` the thermal conductivity of the wall material, and `r` the
  distance from the cylinder axis.

Figure 17 dimensions used along the proof route: IC bore diameter
`33.7 ± 0.1 mm` and IC wall thickness `t = 6.4 ± 0.1 mm`, from which the
acrylic wall's inner and outer radii are
`r₁ = 33.7/2 mm = 16.85 mm`, `r₂ = r₁ + t = 23.25 mm`. The wetted wall
height is the IC water level `h = 10 cm` (Procedure step 3); the lateral
area at radius `r` is `A(r) = 2·π·r·h`.

The current subquestion (C.7, 1.6 pt): using equations (4) and (6),
determine the acrylic conductivity `λ`, indicating the formula used.
Recorded answer: `λ = ln(r₂/r₁) / (2·π·h·R_Th)`; official sample value
`λ = 0.25 ± 0.01 W/(m·K)`.

## What is proved where

* `acrylicConductivity_formula` — the derivation formula
  `λ = ln(r₂/r₁) / (2·π·h·R_Th)` follows from the two governing laws plus
  the radial steady-state integration. This is the "formula that you used"
  part of C.7. (The proof needs quantitative integration of Fourier's law
  and is left `sorry` at the autoformalize stage.)
* `acrylicConductivity_officialSample` — propagation of the C.6
  measurement `R_Th ∈ [1.14, 1.20] K/W` and Figure-17 geometry
  `r₂/r₁ = 23.25/16.85`, `h = 0.1 m` through the C.7 formula: the
  contract is the uncertainty window `|λ − 0.25| ≤ 0.01 W/(m·K)` reported
  in the official sample. (Arithmetic interval/refinement bound, left
  `sorry`.)
-/

open Real

namespace IPhO2026.Problem4.C7

/-! ### Scalar readouts of the physical quantities

The problem's quantities are physical (temperatures, powers, lengths,
conductivity), but the current subquestion only ever manipulates their
numerical values in SI units, so scalar real-number fields for the
readouts are appropriate; the physical roles and laws are carried by the
structures below. -/

/-- Figure-17/datasheet geometry of the acrylic wall separating the inner
(IC) and outer (OC) cylinders, plus the wetted wall height. The radii
come from the IC bore diameter `33.7 mm` and wall thickness `6.4 mm` of
Fig. 17 (`r₁ = 16.85 mm`, `r₂ = 23.25 mm`); the height `h` is the IC water
level set to `10 cm` in Procedure step 3. Lengths are stored in metres. -/
structure CylindricalWallGeometry where
  /-- Inner radius of the acrylic wall (IC bore radius), in metres. -/
  r₁ : ℝ
  /-- Outer radius of the acrylic wall (interface to the OC), in metres. -/
  r₂ : ℝ
  /-- Wetted height of the wall exchanging heat (IC water level), in metres. -/
  h : ℝ
  r₁_pos : 0 < r₁
  r₁_lt_r₂ : r₁ < r₂
  h_pos : 0 < h
... [suffix omitted]
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
create a compiling Lean file with sorry bodies at `IPhO2026Problems/problem\_IPhO\_2026\_4\_C\_7.lean`.
The Lean declarations must preserve the physical quantities, dimensions or dimensional roles, figure labels, governing-law hypotheses, and final relation expressed by this problem.
Use Mathlib/Physlib names found through LeanExplore where available. If a domain API is missing, introduce faithful local abstractions rather than scalar placeholder aliases.

\begin{theorem}[Physics formalization target]
\label{thm:physics:IPhO_2026_4_C_7:target}
\uses{thm:IPhO2026Problems_problem_IPhO_2026_4_C_7:acrylicConductivity_officialSample}
The assigned autoformalize agent should translate this physics problem into Lean declarations in the covered file, with theorem and lemma proof bodies written as `by sorry`.
\end{theorem}
\begin{proof}
This is an autoformalization task, not a proof task. Produce faithful statements that can later be proved without weakening the source contract.
\end{proof}
% NOTE: PhysLean grounding reconciliation (planner-recorded, iter-004): positive targeted-import case — the covered file genuinely uses `Physlib.Thermodynamics.Temperature.Basic` (typed temperature quantities for the C.7 thermal readouts); the blanket domain-import check is satisfied and
... [suffix omitted]
```
