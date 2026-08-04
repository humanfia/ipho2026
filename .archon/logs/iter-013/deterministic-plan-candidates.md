# Deterministic Plan Candidate Pack

Iteration: 013
Exact objective count: 13

The loop has already selected and written these objectives. Do not scan
the rest of the corpus and do not replace, reorder, add, or remove targets.
Use the excerpts below only to write a concise per-target proof strategy.

## 1. `IPhO2026Problems/problem_IPhO_2026_2_C_4.lean`

- Open placeholders: 1
- Proof Review: retry; attempts=1
- Review reason: Main theorem body is still `by sorry` (line 145); contract is faithful and derivable, the gap is an unfinished hard asymptotic-analysis proof (tactics/assembly/budget), not a modeling defect.
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

## 2. `IPhO2026Problems/problem_IPhO_2026_1_A_1.lean`

- Open placeholders: 12
- Proof Review: retry; attempts=0
- Review reason: formalization redraft passed at iter 11; proof attempt budget reset
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_1_A_1.tex`

### Lean excerpt
```lean
... [prefix omitted]
resultant pressure force on each side face of the slot seal —
  effective area `a · (a/√2)` per unit hinge-axis length, the area of the
  opening — is `ΔF = ρ₀ g Δh · a²/√2` and acts at the centroid of the face,
  whose horizontal lever arm about O is `a/(2√2)`, the same special arm
  (from O, in the horizontal or the vertical direction) that the centre of
  the cube presents for the weight. This driving torque is
  counteracted by the anticlockwise restoring torque of the cube's immersed
  weight ((mass - displaced water) × g, acting at the cube's centre, a
  distance `a/2` vertically above O; horizontal lever arm `(a/2) sin 45° =
  a/(2√2)`). The critical (maximum-`Δh`) configuration is the borderline one
  in which the net moment about O still vanishes: the top face of the cube
  sits flush at the slot's upper lip, so `Δh` measures the head from the
  right free surface (at that lip) to the left free surface. In the critical
  regime both faces of the cube are fully wetted, the hydrostatic pressure
  fields vary linearly with depth, and their resultants act at the face
  centres on the vertical diagonal, a distance `a/2` from O with horizontal
  lever arm `a/(2√2)`.

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

## 3. `IPhO2026Problems/problem_IPhO_2026_1_B_2.lean`

- Open placeholders: 5
- Proof Review: retry; attempts=0
- Review reason: formalization redraft passed at iter 11; proof attempt budget reset
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_1_B_2.tex`

### Lean excerpt
```lean
... [prefix omitted]
6.60`, the exact value
  `arctan(2/sqrt 45)`, or any numeric deflection — the sign toward the
  line connecting the pair and the magnitude are exactly what must be
  proved.

  ITER-011 REDRAFT LOG (routed by Proof Review,
  wrong_or_weakened_target): the previous version stated the exact
  closed forms via the pair (`eps^2 = 67/4`, `2/sqrt 63`),
  `pi - 2 arctan(2/sqrt 63)` (≈ 151.71 deg) for the unsigned angle and
  its negation for the signed one.  That chain was false in principle:
  the governing-law fields evaluate `eps^2` to `49/4` exactly
  (machine-checked below in `eccentricity_sq_eq`), and the
  apocenter-referenced Rutherford formula is the wrong reference for
  this periapsis-referenced scenario.  The corrected, mutually
  consistent chain is `eps^2 = 49/4` → asymptote factor `2/sqrt 45`
  (proved in `asymptote_factor_certificate`) →
  `angleBetween = arctan(1/sqrt(eps^2-1))` (periapsis-referenced, in
  `signed_deflection_eq_formula`) → signed value
  `-arctan(2/sqrt 45) ≈ -16.6015°`, inside both rounding bands.

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
    `eccentricity_gt_one`, `eccentricity_sq_eq`,
    `asymptote_factor_certificate`, `signedDeflection_eq_neg_angle`);
    none
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

## 4. `IPhO2026Problems/problem_IPhO_2026_1_C_1.lean`

- Open placeholders: 3
- Proof Review: retry; attempts=0
- Review reason: formalization redraft passed at iter 11; proof attempt budget reset
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

## 5. `IPhO2026Problems/problem_IPhO_2026_2_B_2.lean`

- Open placeholders: 6
- Proof Review: retry; attempts=0
- Review reason: formalization redraft passed at iter 11; proof attempt budget reset
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_2_B_2.tex`

### Lean excerpt
```lean
... [prefix omitted]
P / P₀` in terms of `θ_max`.

Recorded official answer: `P / P₀ = 1 / (1 - cos θ_max)`.

Physical resolution used by this formalization (root cause of the iter-010
review countermodel). Parametrize an incoming ray by its transverse impact
parameter `y` (offset along the in-plane normal `n`, perpendicular to the
light-travel axis `e`). For the ray reflected at mirror point `m` with
incidence angle `α`, the offset is `y = R sin α`; the reflected ray's
nearest-approach distance to the container centre `A = C + (R/2) • e` is
`R (sin α - (1/2) sin 2α)`, strictly increasing in `α ∈ (0, π/2)`. Hence the
absorbed rays form a TWO-SIDED contiguous band of impact parameters
`(-R sin θ_max, R sin θ_max)` around the axis: every ray with incidence
below `θ_max` passes closer to `A` than the (tangent) extreme ray and is
absorbed, and the extreme rays at `± θ_max` attain the maximum. The
collected transverse width is therefore `2 R sin θ_max`, and the
uniform-intensity accounting gives

  P / P₀ = (I · 2 R sin θ_max) / (I · 2 a)
         = 1 / (1 - cos θ_max)

by the B.1 calibration `a = R sin θ_max - (R / 2) sin (2 θ_max)`
(`= R sin θ_max (1 - cos θ_max)` after the double-angle identity) — the
recorded answer, valid for the whole θ_max family (consistency check with
B.3: `cos θ_max = 4/5` gives `2R·(3/5) / (2·3R/25) = 5` ✓).
The earlier one-sided `collectedWidth = R` model is physically wrong for
this configuration and is what made the previous contract underdetermined.

This file is a by-`sorry` formalization: faithful declarations with proof
bodies left as `sorry`. Modelled on a transverse cross-section (the problem
is translationally invariant along the cylinder axes), so the configuration
lives in `EuclideanSpace ℝ (Fin 2)` and every "power" below is a
power-per-unit-axis-length quantity; the common incoming intensity and the
common axial length cancel in the ratio `P / P₀`.

Governing physical laws (kept as hypotheses, never redefined locally):
specular reflection on the circular mirror profile, the offset container
geometry, single-bounce two-sided ray bookkeeping, the previous-part (B.1)
calibration, and the uniform-intensity width accounting for `P` and `P₀`.
-/

import Mathlib

open Real Set

noncomputable section

namespace IPhO2026_2_B_2

/-- Transverse cross-sectional plane of the cooker. The physical system is
translationally invariant along the cylinder axes, so a single cross-section
captures all the geometry; points have units of length. -/
abbrev Plane := EuclideanSpace ℝ (Fin 2)

/-- Dimensionful parameters of the cooker: mirror radius `R` and container
radius `a` (both lengths, hence positive). -/
structure CookerParams where
  R : ℝ
  a : ℝ
  hR : 0 < R
  ha : 0 < a

/-- Geometry of the cross-section (Figure 2f): mirror centre `C`, container
centre `A`, unit vector `e` along the optical axis pointing from `C` into
the bowl towards the container (sunlight travels along `+ e`, parallel to
the optical axis), and in-plane unit normal `n` (`n ⊥ e
... [suffix omitted]
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
create a compiling Lean file with sorry bodies at `IPhO2026Problems/problem\_IPhO\_2026\_2\_B\_2.lean`.
The Lean declarations must preserve the physical quantities, dimensions or dimensional roles, figure labels, governing-law hypotheses, and final relation expressed by this problem.
Use Mathlib/Physlib names found through LeanExplore where available. If a domain API is missing, introduce faithful local abstractions rather than scalar placeholder aliases.

\begin{theorem}[Physics formalization target]
\label{thm:physics:IPhO_2026_2_B_2:target}
\uses{thm:IPhO2026Problems_problem_IPhO_2026_2_B_2:power_ratio_in_terms_of_theta_max}
The assigned autoformalize agent should translate this physics problem into Lean declarations in the covered file, with theorem and lemma proof bodies written as `by sorry`.
\end{theorem}
\begin{proof}
This is an autoformalization task, not a proof task. Produce faithful statements that can later be proved without weakening the source contract.
\end{proof}
% --- Archon physics formalization source end ---

% --- Archon named-quantities coverage (blueprint-writer 2-b-2-entries; restored planner-side iter-009 after the chapter body was found truncated back to the 51-line iter-002 skeleton) ---
% NOTE: import policy (mirrors the iter-002 PhysL
... [suffix omitted]
```

## 6. `IPhO2026Problems/problem_IPhO_2026_2_C_2.lean`

- Open placeholders: 2
- Proof Review: retry; attempts=0
- Review reason: formalization redraft passed at iter 11; proof attempt budget reset
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_2_C_2.tex`

### Lean excerpt
```lean
... [prefix omitted]
against (nearest search hits are lattice
`Submodule.reflection` and Euclidean `EuclideanGeometry.reflection`, which
are isometries of an ambient space, not optical reflection-with-reversal on
a curve); the asymptotic content is grounded on Mathlib
`Asymptotics.IsLittleO`.  The blueprint chapter records the exemption NOTE
(planner-recorded, iter-002).

Iter-011 redraft note: Proof Review routed this file to statement redraft
(`underdetermined_contract`).  The previous governing-law regularity
interface exposed only an existential little-o slope
`∃ dm, (fun Δθ ↦ M (θ + Δθ) - M θ - dm * Δθ) =o[𝓝 0] fun Δθ ↦ Δθ`,
whose witness `dm` is unconstrained for an arbitrary family, so the
coefficient identifications `dm = -2 csc(2θ)²` and
`db = (R/(2 cos θ)) tan θ` were underivable.  The regularity interface is
now expressed as `HasDerivAt M dm θ` / `HasDerivAt B db θ`: by
`HasDerivAt.deriv` and `DifferentiableAt.hasDerivAt` this is exactly the
same little-o expansion, but it pins `dm = deriv M θ` (and
`db = deriv B θ`) on a family that is differentiable at the base point.
The bridge hypothesis `M_differentiable` records the physical smoothness of
the specular ray family; the two bridge lemmas `slope_deriv_value` /
`intercept_deriv_value` expose the specular derivative identities
`(d/dθ) cot (2θ) = -2 csc(2θ)²` and
`(d/dθ) (R / (2 cos θ)) = (R / (2 cos θ)) tan θ` (derived inside by the
Mathlib chain rule).  With those carriers the two C.2 target theorems now
close fully (they contain no `sorry`).
-/

open Real Asymptotics Filter Topology

namespace IPhO2026_2_C_2

/-- The physical setup of IPhO 2026 Problem 2, Part C.2: the half-cylindrical
mirror of radius `R` (Figure 2g), the reflected slope–intercept family of the
axial (parallel-to-the-`y`-axis) rays parametrized by the incidence angle,
and the branch data fixing the Figure 2g configuration.  All coordinates are
Cartesian coordinates in the plane of Figure 2g, hence real scalars; `R` and
the intercepts carry the dimension of length, the slopes and the angles are
dimensionless. -/
structure NeighboringRayExpansion where
  /-- Radius `R` of the half-cylindrical mirror (a length). -/
  R : ℝ
  /-- The mirror radius is positive. -/
  R_pos : 0 < R
  /-- Slope `M φ` of the line reflected from the axial ray incident at angle
  `φ` (dimensionless).  Ray A of Figure 2g is the member `φ = θ`, and the
  neighboring parallel ray B is the member `φ = θ + Δθ`. -/
  M : ℝ → ℝ
  /-- Intercept `B φ` of that reflected line (a length). -/
  B : ℝ → ℝ
  /-- Slope of the reflected line of ray A at incidence angle `θ`
  (dimensionless); notation `m_A θ`. -/
  m_A : ℝ → ℝ
  /-- Intercept of the reflected line of ray A (a length); notation `b_A θ`. -/
  b_A : ℝ → ℝ
  /-- Slope of the reflected line of the neighboring parallel ray B, incident
  at `θ + Δθ` (dimensionless); notation `m_B θ Δθ`. -/
  m_B : ℝ → ℝ → ℝ
  /-- Intercept of the reflected line of ray B (a length); notation
  `b_B θ Δθ`. -/
  b_B : ℝ → ℝ → ℝ
  /-- The bas
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

## 7. `IPhO2026Problems/problem_IPhO_2026_3_A_1.lean`

- Open placeholders: 0
- Proof Review: retry; attempts=0
- Review reason: formalization redraft passed at iter 11; proof attempt budget reset
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_3_A_1.tex`

### Lean excerpt
```lean
... [prefix omitted]
ere.R) * T.ampere.HPerimeter := by
        rw [T.ampere_R, T.ampere_HPerimeter, T.perimeter_eq_interior]
    _ = (T.numTurns : ℝ) * T.wireCurrent.readout := key

/-- Bridge 2 — solve the circulation equation for `H` along the mean path:
`H = N·I / (2πR)` (uses `R > 0`, `π > 0`). -/
theorem fieldMagnitude_eq_meanRadius_form (T : ParamagneticTorusA1) :
    T.fieldMagnitude
      = (T.numTurns : ℝ) * T.wireCurrent.readout
          / (2 * Real.pi * T.meanRadius) := by
  have key := T.ampere_uniform_eq
  have hD : 2 * Real.pi * T.meanRadius ≠ 0 :=
    mul_ne_zero (mul_ne_zero (ne_of_gt two_pos) (ne_of_gt Real.pi_pos))
      (ne_of_gt T.meanRadius_pos)
  rw [eq_div_iff hD, mul_comm T.fieldMagnitude]
  exact key

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
magnitude in the thin torus, `2πR·(N·H) = N·I`; solving for `H` and using
the torus geometry `V = 2πR·A` gives `H = N·I/(2πR) = N·I·A/V`. -/
theorem paramagneticTorus_H_eq (T : ParamagneticTorusA1) :
    T.fieldMagnitude
      = (T.numTurns : ℝ) * T.wireCurrent.readout * T.crossSectionArea
          / T.volume := by
  exact T.fieldMagnitude_eq_meanRadius_form.trans T.meanRadius_form_eq_volume_form

/-- Equivalent mean-radius form of the Part A.1 answer:
`H = N·I / (2πR)`, the form one obtains directly from Ampère's law before
substituting the torus geometry `V = 2πR·A`. -/
theorem paramagneticTorus_H_eq_meanRadius (T : ParamagneticTorusA1) :
    T.fieldMagnitude
      = (T.numTurns : ℝ) * T.wireCurrent.readout
          / (2 * Real.pi * T.meanRadius) := by
  exact T.fieldMagnitude_eq_meanRadius_form

end PartA1
end Problem3
end IPhO2026
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

## 8. `IPhO2026Problems/problem_IPhO_2026_3_B_1.lean`

- Open placeholders: 7
- Proof Review: retry; attempts=0
- Review reason: formalization redraft passed at iter 11; proof attempt budget reset
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_3_B_1.tex`

### Lean excerpt
```lean
... [prefix omitted]
rk and heat entering the torus are positive"):
  `Q = ΔU - W_on` for each quasistatic process leg; along an isothermal leg
  the `U`-bracket vanishes, so the heat in equals minus the work on.

Current subquestion: at fixed temperature `T`, `H` changes from `H_i` to `H_f`;
find the heat `Q` transferred into the torus.

Recorded official answer:
`Q = -(μ₀ * n * K / (2 * T)) * (H_f^2 - H_i^2)`.

**Iter-011 redraft (proof-review `underdetermined_contract`).**  The previous
iter-002 model parametrized the work density by the magnetization via
`workDensity(M) = μ₀ * V * M_of_H M`, which substituted the magnetization
function for the true field-as-a-function-of-magnetization and lost the
`dM/dH` Jacobian; the shipped countermodel
`task_results/witness_target_IS_FALSE.lean` (with `M(H) = -2H`, `K = -2`,
`Q_in(M) = -∫₀..M (-2x) dx`) satisfied every hypothesis yet gave
`Q = -12 ≠ -3`.  The present redraft parametrizes the work law by the
**applied field**: the work-on density is
`workOnDensity(H) = μ₀ * V * H * dM/dH(H)` (i.e. `dW = μ₀ V H dM` read along
the tracked EOS branch), the EOS is enforced on **every** applied field with
`V ≠ 0` as a structure hypothesis, the internal energy is assumed `C^1`, and
the first law supplies per-leg balances `Q_in(H₁) - Q_in(H₀) = -∫_{H₀}^{H₁}`.
The countermodel above is excluded because `μ₀ V H dM/dH = -2μ₀ V H` cannot
equal the stored `Q_in`-density `-2M(H) = 4H`.

This file is an autoformalization: all proof bodies requiring real content
are `by sorry`.
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
  /-- Fixed (nonzero) volume of the torus. -/
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
`T * M * V = n * K * H`.  This is a governing law recorded from the problem
statement, not a target. -/
def SatisfiesEOS (p : TorusParams) (s : TorusState) : Prop :=
  s.T
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

## 9. `IPhO2026Problems/problem_IPhO_2026_3_B_2.lean`

- Open placeholders: 3
- Proof Review: retry; attempts=0
- Review reason: formalization redraft passed at iter 12; proof attempt budget reset
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

## 10. `IPhO2026Problems/problem_IPhO_2026_3_C_2.lean`

- Open placeholders: 1
- Proof Review: retry; attempts=0
- Review reason: formalization redraft passed at iter 11; proof attempt budget reset
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_3_C_2.tex`

### Lean excerpt
```lean
... [prefix omitted]
^2$ (Figure 3b) and collect terms.
  have hratio : m.Qh * m.Tc = m.Qc * m.Th := m.carnot_ratio
  have hne : (p.μ₀ * p.V ^ 2 / (2 * p.n * p.K)) ≠ 0 := by
    have hA : (0:ℝ) < (2:ℝ) * p.n := mul_pos two_pos p.n_pos
    have hB : (0:ℝ) < (2:ℝ) * p.n * p.K := mul_pos hA p.K_pos
    have hC : (0:ℝ) < p.μ₀ * p.V ^ 2 := mul_pos p.μ₀_pos (pow_pos p.V_pos 2)
    exact ne_of_gt (div_pos hC hB)
  rw [m.Qh_eq, m.Qc_eq] at hratio
  obtain ⟨hT1, hT4, -, hT3, -⟩ := m.figure3b
  have hq1 : m.q .v1 = m.Th * m.M1 ^ 2 := by
    change m.cyc.T .v1 * m.cyc.Mmag .v1 ^ 2 = _
    rw [hT1]
  have hq4 : m.q .v4 = m.Th * m.M4 ^ 2 := by
    change m.cyc.T .v4 * m.cyc.Mmag .v4 ^ 2 = _
    rw [hT4]
  have hq3 : m.q .v3 = m.Tc * m.M3 ^ 2 := by
    change m.cyc.T .v3 * m.cyc.Mmag .v3 ^ 2 = _
    rw [hT3]
  rw [hq1, hq4, hq3]
  -- Honest partial progress: after substitution of the leg identities the
  -- Carnot heat ratio reads (with $A = \mu_0 V^2/(2nK) \ne 0$)
  --   $A\,(T_h M_4^2 - T_h M_3^2)\,T_c
  --     = -A\,(T_c M_2^2 - T_c M_1^2)\,T_h$;
  -- cancelling $A$ (via `hne`) yields the linear relation
  --   $(T_h M_4^2 - T_h M_3^2)T_c + (T_c M_2^2 - T_c M_1^2)T_h = 0$.
  -- The contracted form
  --   $T_c (T_h M_1^2) = (T_c - T_h) \cdot T_h M_4^2 + T_h \cdot T_c M_3^2$
  -- differs from it by the collision term
  --   $T_h\,T_c\,(M_3^2 - M_2^2)$, which is exactly the cold-adiabat
  -- square-difference of `q3_eq`; the contraction is recorded for the
  -- proof phase (see `q3_eq` and the task result).
  sorry

/-- Adiabatic-leg book-keeping at $4\to1$: with Figure 3b ($T_1 = T_4 =
T_h$) the leg law `heat_leg41_adiabatic` collapses the lattice term
($\log(T_h/T_h) = 0$) and leaves the hot-side square-difference

$\frac{\mu_0 V^2}{2 n K}\,(M_1^2 - M_4^2) = 0$.

The statement is eliminable and does not mention the C.2 combination
$M_2^2 - M_3^2 + M_4^2$. -/
lemma q4_eq_adiabatic_41 :
    (p.μ₀ * p.V ^ 2 / (2 * p.n * p.K)) * (m.M1 ^ 2 - m.M4 ^ 2) = 0 := by
  have h41 : AdiabaticLegStateLaw p (m.cyc.T .v4) (m.cyc.T .v1)
      (m.cyc.Mmag .v4) (m.cyc.Mmag .v1) := m.heat_leg41_adiabatic
  rw [AdiabaticLegStateLaw] at h41
  obtain ⟨hT1, hT4, -, -, -⟩ := m.figure3b
  rw [hT1, hT4] at h41
  rw [div_self (ne_of_gt m.Th_pos), Real.log_one, mul_zero] at h41
  exact h41.symm

/-- Cold-vertex book-keeping at $2\to3$: with Figure 3b ($T_2 = T_3 =
T_c$) the leg law `heat_leg23_adiabatic` collapses the lattice term and
leaves the cold-side square-difference

$\frac{\mu_0 V^2}{2 n K}\,(M_3^2 - M_2^2) = 0$.

Since $M_2, M_3$ are magnitudes this expresses $M_3$ in terms of $M_2$
along the adiabatic leg $2\to3$.  The statement is eliminable and does
not mention the C.2 combination. -/
lemma q3_eq :
    (p.μ₀ * p.V ^ 2 / (2 * p.n * p.K)) * (m.M3 ^ 2 - m.M2 ^ 2) = 0 := by
  have h23 : AdiabaticLegStateLaw p (m.cyc.T .v2) (m.cyc.T .v3)
      (m.cyc.Mmag .v2) (m.cyc.Mmag .v3) := m.heat_leg23_adiabatic
  rw [AdiabaticLegStateLaw] at h23
  obtain ⟨-, -, hT2, hT3, -⟩ := m.figure3b
  rw [hT2, hT3] at h23
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

## 11. `IPhO2026Problems/problem_IPhO_2026_3_C_4.lean`

- Open placeholders: 0
- Proof Review: retry; attempts=0
- Review reason: formalization redraft passed at iter 11; proof attempt budget reset
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

## 12. `IPhO2026Problems/problem_IPhO_2026_4_A_5.lean`

- Open placeholders: 0
- Proof Review: retry; attempts=0
- Review reason: formalization redraft passed at iter 11; proof attempt budget reset
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_4_A_5.tex`

### Lean excerpt
```lean
... [prefix omitted]
= IsReferenceState.referenceTemperature proc ref)
    (hT₀pos : 0 < T₀)
    (hβ₀ : β₀ = IsIsochoricLinear.thermalPressureCoefficient proc linear ref) :
    ∀ T₁ T₂ : ℝ,
      linear.slope * (T₂ - T₁) =
        β₀ * IsReferenceState.referencePressure proc ref * (T₂ - T₁) := by
  intro T₁ T₂
  rw [hβ₀, IsIsochoricLinear.thermalPressureCoefficient]
  have hP₀ : 0 < IsReferenceState.referencePressure proc ref := ref.hP₀
  rw [div_mul_cancel₀ _ hP₀.ne']

/-- Component of `main`: uncertainty propagation. If the two-readout
pressure increment deviates from the ideal-gas increment
`P0 * Delta T / T0` by at most `P0 * |Delta T| * sigma`, then the measured
coefficient satisfies the propagated bound `|beta0 - 1 / T0| <= sigma`.
Formalizes the official sample statement `beta0 = 0.0034 ± 0.0007 K^-1`
covering the ideal-gas reference `0.0037 K^-1`. -/
theorem beta0_uncertainty_bound
    (proc : IsochoricProcess)
    (law : IsIdealGasLaw proc)
    (linear : IsIsochoricLinear proc)
    (ref : IsReferenceState proc)
    (T₀ β₀ : ℝ)
    (hT₀ : T₀ = IsReferenceState.referenceTemperature proc ref)
    (hT₀pos : 0 < T₀)
    (hβ₀ : β₀ = IsIsochoricLinear.thermalPressureCoefficient proc linear ref)
    (readouts : IsochoricReadout
      (IsReferenceState.referencePressure proc ref) T₀ β₀)
    (σ : ℝ) (hσ : 0 < σ)
    (hdev :
      |(readouts.measuredPressure readouts.T₂ (Or.inr rfl)) -
          (readouts.measuredPressure readouts.T₁ (Or.inl rfl)) -
        IsReferenceState.referencePressure proc ref *
          (readouts.T₂ - readouts.T₁) / T₀|
        ≤ IsReferenceState.referencePressure proc ref *
            |readouts.T₂ - readouts.T₁| * σ) :
    |β₀ - 1 / T₀| ≤ σ := by
  have hP₀ : 0 < IsReferenceState.referencePressure proc ref := ref.hP₀
  have hdev_eq :
      |(readouts.measuredPressure readouts.T₂ (Or.inr rfl)) -
          (readouts.measuredPressure readouts.T₁ (Or.inl rfl)) -
        IsReferenceState.referencePressure proc ref *
          (readouts.T₂ - readouts.T₁) / T₀|
        = IsReferenceState.referencePressure proc ref *
            |readouts.T₂ - readouts.T₁| * |β₀ - 1 / T₀| := by
    rw [readouts.measured_hP₂, readouts.measured_hP₁]
    have hfactor :
        IsReferenceState.referencePressure proc ref + β₀ *
            IsReferenceState.referencePressure proc ref * (readouts.T₂ - T₀) -
          (IsReferenceState.referencePressure proc ref + β₀ *
            IsReferenceState.referencePressure proc ref * (readouts.T₁ - T₀)) -
        IsReferenceState.referencePressure proc ref * (readouts.T₂ - readouts.T₁) / T₀
        = IsReferenceState.referencePressure proc ref * (readouts.T₂ - readouts.T₁) *
            (β₀ - 1 / T₀) := by
      field_simp
      ring
    rw [hfactor, abs_mul, abs_mul, abs_of_pos hP₀]
  have hfac : 0 < IsReferenceState.referencePressure proc ref * |readouts.T₂ - readouts.T₁| :=
    mul_pos hP₀ (abs_pos.mpr (sub_ne_zero.mpr readouts.hT12.symm))
  rw [hdev_eq] at hdev
  exact le_of_mul_le_mul_left hdev hfac

end

end IPhO2026_4_A_5
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

## 13. `IPhO2026Problems/problem_IPhO_2026_4_B_6.lean`

- Open placeholders: 2
- Proof Review: retry; attempts=0
- Review reason: formalization redraft passed at iter 11; proof attempt budget reset
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_4_B_6.tex`

### Lean excerpt
```lean
... [prefix omitted]
official result `Lᵥ = 2190 ± 110 kJ/kg`, i.e., the reported specific latent
heat lies within the official uncertainty interval.

The formula itself is in the conclusion — witnessed by
`IsSpecificLatentHeatOf Lv Qv M0` together with the catalog matching
conditions `Qv_magnitude = 39 kJ/mol`, `M0_magnitude = 18.0 × 10⁻³ kg/mol` —
and the uncertainty `±110 kJ/kg` is preserved through
`SpecificLatentHeatValue.withinUncertainty`, with the reported scalar value
tied to the conversion by the added conjunct
`Lv_reported.central_kJ_per_kg = witness.Lv_magnitude_kJ_per_kg` (the reported
central value IS the converted magnitude `Qᵥ/M₀`), so no universally
quantified scalar is left unconstrained. -/
theorem latent_heat_per_unit_mass_target
    (input : PartB6Input)
    (Qv : MolarEnergy) (M0 : MolarMass) (Lv : SpecificLatentHeat)
    (Lv_reported : SpecificLatentHeatValue) :
    ∃ witness : IsSpecificLatentHeatOf Lv Qv M0,
      witness.Qv_magnitude_kJ_per_mol = catalogQvValue ∧
      witness.M0_magnitude_kg_per_mol = catalogMolarMassWaterValue ∧
      Lv_reported.central_kJ_per_kg = witness.Lv_magnitude_kJ_per_kg ∧
      Lv_reported.withinUncertainty officialSpecificLatentHeatValue := by
  refine ⟨⟨catalogQvValue, catalogMolarMassWaterValue,
      catalogQvValue / catalogMolarMassWaterValue, rfl, by
        rw [catalogMolarMassWaterValue]; norm_num⟩,
    rfl, rfl, ?_, ?_⟩
  · -- The reported central value is the converted magnitude
    -- `Qᵥ/M₀ = 39 kJ/mol / (18.0 × 10⁻³ kg/mol)`.
    sorry
  · -- Band membership `|Lv_reported.central − 2190| ≤ 110` follows from the
    -- previous conjunct together with
    -- `computed_value_within_official_uncertainty`.
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
theorem computed_val
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
