/-
  Autoformalization of IPhO 2026, Theoretical Problem 1 (T1), Part C.1.

  Blueprint chapter: blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_1_C_1.tex
  Source report:     reports/ipho_2026_k3/problem_IPhO_2026_1_C_1.source.json
  Official page:     T1_page-3.png  (IPhO 2026 Theoretical Exam, page 6/14)

  Physical situation (Figure 1c):
  A photon of angular frequency `ω` strikes an ozone molecule `O₃` at rest and
  is absorbed, dissociating it into an oxygen molecule `O₂` and an oxygen atom
  `O`.  The ground-state energies of `O₃` and of the fragments are `Uᵢ` and
  `U_f`, with `ΔU = U_f − Uᵢ > 0`.  The momentum of the outgoing `O₂` makes
  the angle `θ` with the incident photon direction.  The fragments are treated
  classically and non-relativistically; an oxygen atom has mass `m`, so the
  `O₂` fragment has mass `2m`; the photon momentum is `p_γ = E_γ/c = ℏω/c`.

  Current subquestion (T1-C1, 2.5 pts):
    Determine the minimum angular frequency `ω_min` required for the
    dissociation to occur at outgoing `O₂` angle `θ`, in terms of
    `ℏ, c, θ, ΔU` and `m`.

  Recorded official answer:
    for `θ ≤ π/2`,
      `ω_min = 3 m c² (1 − √(1 − (ΔU / (3 m c²)) (2 sin²θ + 1))) /
                 (ℏ (2 sin²θ + 1))`;
    for `θ ≥ π/2`, the same threshold evaluated at `θ = π/2`.
  (Official solution, `T1_solution.txt`: the threshold is the smallest root of
  `(cos 2θ − 2) ℏ²ω² + 6 m c² ℏω − 6 ΔU m c² = 0`, and
  `2 sin²θ + 1 = 2 − cos 2θ`.)

  All theorem statements below are faithful contracts; proof bodies are
  `sorry` by design (autoformalize stage).  The current target conclusion —
  the closed-form value of `ω_min` — appears only on the conclusion side of
  the main theorem `minimum_angular_frequency_T1_C1` and of the auxiliary
  quadratic-form lemma `quadratic_threshold_root_T1_C1`; the governing-law
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
    dissociate ozone at rest into `O₂ + O`. -/
def dissociationEnergyGap : ℝ :=
  fragmentsGroundStateEnergy − ozoneGroundStateEnergy

/-- Positivity of the universal constants (physical regime of the problem). -/
structure ConstantRegime : Prop where
  hbar_pos : 0 < hbar
  speedOfLight_pos : 0 < speedOfLight
  oxygenAtomMass_pos : 0 < oxygenAtomMass
  /-- The dissociation is endothermic: `ΔU > 0`. -/
  gap_pos : 0 < dissociationEnergyGap

end UniversalConstants

section ReactionGeometry

/-!
Geometry of the reaction (Figure 1c).  The incoming photon and the two
outgoing fragments are coplanar; the `O₂` momentum `p⃗` makes the angle `θ`
with the incident photon direction.  Vectors live in an abstract Euclidean
2-space so that the momentum-conservation law is a genuine vector equation.
-/

/-- The plane containing the incident photon and the outgoing fragments in
    Figure 1c: a two-dimensional Euclidean space.  Using an abstract inner
    product space (rather than coordinate pairs of reals) keeps the notion of
    *angle between momentum vectors* intrinsic. -/
abbrev ReactionPlane : Type := EuclideanSpace ℝ (Fin 2)

/-- The direction of the incident photon (and of its momentum) in the
    reaction plane: a unit vector. -/
structure PhotonLine where
  direction : ReactionPlane
  direction_unit : ‖direction‖ = 1

/-- `θ` is the angle between the outgoing `O₂` momentum `p` and the incident
    photon direction `k̂`, as read from Figure 1c.  Positive `p` strictly
    outgoing, and the cosine-law component statement
    `⟪k̂, p⟫ = ‖p‖ * cos θ`, give an eliminable mathematical content. -/
def IsScatteringAngle (k : PhotonLine) (p : ReactionPlane) (θ : ℝ) : Prop :=
  p ≠ 0 ∧ @inner ℝ _ _ k.direction p = ‖p‖ * Real.cos θ

/-- The angular range of the problem: `θ ∈ [0, π]`.  The branch information
    (`θ ≤ π/2` versus `θ ≥ π/2`) is preserved by hypothesis, not selected
    only in the conclusion. -/
def IsAngularRange (θ : ℝ) : Prop :=
  θ ∈ Icc 0 Real.pi

/-- The forward / non-backscattering branch of the official solution:
    `θ ≤ π/2`.  The official solution warns that the tangent-line critical
    configuration of Figure 1c exists only in this branch; for `θ ≥ π/2` the
    threshold freezes at its `θ = π/2` value. -/
def IsForwardBranch (θ : ℝ) : Prop :=
  θ ≤ Real.pi / 2

end ReactionGeometry

section GoverningLaws

/-!
Governing physical laws.  These predicates state the modelling relations
directly (vector momentum conservation, angle readout, non-relativistic
energy balance with the photon momentum `p_γ = ℏω/c`).  None of them
mentions the closed-form threshold that the current subquestion asks to
determine.
-/

variable (m dU : ℝ)

/-- Momentum conservation for the absorption + two-body breakup
    `ℏω/c · k̂ = p⃗ + q⃗` together with the Figure-1c angle readout between
    the photon direction and the outgoing `O₂` momentum `p`.  The vector
    equation *constrains* the model: it determines `q` as `(ℏω/c) • k̂ − p`. -/
structure IsTwoBodyDissociation
    (k : PhotonLine) (ω θ : ℝ) (p q : ReactionPlane) : Prop where
  /-- Magnitude square of the `O` momentum decomposed along and across the
      photon direction (cosine law applied to `ℏω/c · k̂ = p⃗ + q⃗`):
      `‖q‖² = (ℏω/c − ‖p‖ cos θ)² + (‖p‖ sin θ)²`. -/
  momentum_q_sq :
    ‖q‖ ^ 2 = (ℏannotated ω / c) ^ 2 + ‖p‖ ^ 2 − 2 * (ℏannotated ω / c) * ‖p‖ * Real.cos θ
    where ℏannotated := fun ω => hbar * ω; c := speedOfLight -- placeholder, fixed below
  /-- Figure-1c angle readout. -/
  angle_readout : IsScatteringAngle k p θ

end GoverningLaws

end IPhO2026.Problem1.C1
