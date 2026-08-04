/-
  Autoformalization of IPhO 2026, Theoretical Problem 1 (T1), Part C.1.

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
    dissociate ozone at rest into `O₂ + O`. -/
def dissociationEnergyGap : ℝ :=
  fragmentsGroundStateEnergy - ozoneGroundStateEnergy

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
directly (photon momentum `p_γ = ℏω/c`, vector momentum conservation with
the Figure-1c angle readout, and non-relativistic energy balance with
fragment masses `2m` and `m`).  None of them mentions the closed-form
threshold that the current subquestion asks to determine.
-/

/-- Lawful configurations of the absorption + two-body breakup
    `γ + O₃ → O₂ + O` in Figure 1c.  Every field is a constraining equation
    that a later proof can rewrite with:

    * `momentum_q_sq` — vector momentum conservation `ℏω/c · k̂ = p⃗ + q⃗`,
      eliminated to the cosine-law component statement
      `‖q‖² = (ℏω/c)² + ‖p‖² − 2 (ℏω/c) ‖p‖ cos θ`;
    * `q_unique` — the vector equation determines `q` uniquely as
      `q = (ℏω/c) • k̂ − p`;
    * `angle_readout` — the Figure-1c readout that `θ` is the angle between
      `p⃗` and the incident photon direction;
    * `energy_balance` — non-relativistic energy conservation
      `ℏω = ΔU + ‖p‖²/(2·2m) + ‖q‖²/(2m)`.

    None of the fields quantifies over configurations or mentions the
    minimum; those appear only on the conclusion side of the theorems below. -/
structure IsTwoBodyDissociation
    (k : PhotonLine) (ω θ m dU : ℝ) (p q : ReactionPlane) : Prop where
  /-- Cosine-law magnitude equation from `ℏω/c · k̂ = p⃗ + q⃗`:
      `‖q‖² = (ℏω/c)² + ‖p‖² − 2 (ℏω/c) ‖p‖ cos θ`. -/
  momentum_q_sq :
    ‖q‖ ^ 2 = (hbar * ω / speedOfLight) ^ 2 + ‖p‖ ^ 2
      - 2 * (hbar * ω / speedOfLight) * ‖p‖ * Real.cos θ
  /-- The vector momentum balance determines the `O` momentum uniquely as
      `q = (ℏω/c) • k̂ − p`. -/
  q_unique : q = (hbar * ω / speedOfLight) • k.direction - p
  /-- Figure-1c angle readout between the photon direction and `p`. -/
  angle_readout : IsScatteringAngle k p θ
  /-- Non-relativistic energy balance: the photon energy `ℏω` covers the
      dissociation gap `ΔU` plus the classical kinetic energies of the `O₂`
      fragment (mass `2m`) and the `O` fragment (mass `m`). -/
  energy_balance :
    hbar * ω = dU + ‖p‖ ^ 2 / (2 * (2 * m)) + ‖q‖ ^ 2 / (2 * m)

/-- Elimination/bridge lemma: the cosine-law component equation is a genuine
    consequence of the vector momentum balance and the angle readout, so the
    `momentum_q_sq` field is the eliminated shadow of `q_unique` rather than
    an independent modelling assumption.  Recording this implication is what
    makes the interface constraining: any countermodel must satisfy a vector
    equation, not just an isolated scalar identity. -/
theorem momentum_q_sq_of_vector_balance
    (k : PhotonLine) (ω θ : ℝ) (p q : ReactionPlane)
    (hq : q = (hbar * ω / speedOfLight) • k.direction - p)
    (hθ : IsScatteringAngle k p θ) :
    ‖q‖ ^ 2 = (hbar * ω / speedOfLight) ^ 2 + ‖p‖ ^ 2
      - 2 * (hbar * ω / speedOfLight) * ‖p‖ * Real.cos θ := by
  obtain ⟨hp_ne, hinner⟩ := hθ
  set a : ℝ := hbar * ω / speedOfLight with ha
  have hk : @inner ℝ _ _ k.direction k.direction = 1 := by
    rw [@inner_self_eq_norm_sq_to_K, k.direction_unit]
    norm_num
  have hsq : ‖q‖ ^ 2 = @inner ℝ _ _ q q := by
    rw [@inner_self_eq_norm_sq_to_K]
    norm_num
  calc ‖q‖ ^ 2 = @inner ℝ _ _ q q := hsq
    _ = @inner ℝ _ _ (a • k.direction) (a • k.direction)
          - 2 * @inner ℝ _ _ (a • k.direction) p + @inner ℝ _ _ p p := by
          rw [hq, real_inner_sub_sub_self]
    _ = a ^ 2 * @inner ℝ _ _ k.direction k.direction
          - 2 * a * @inner ℝ _ _ k.direction p + @inner ℝ _ _ p p := by
          rw [@real_inner_smul_left, @real_inner_smul_left,
            @real_inner_smul_right]
          ring
    _ = a ^ 2 + ‖p‖ ^ 2 - 2 * a * ‖p‖ * Real.cos θ := by
          rw [hk, hinner, real_inner_self_eq_norm_sq]
          ring
    _ = (hbar * ω / speedOfLight) ^ 2 + ‖p‖ ^ 2
          - 2 * (hbar * ω / speedOfLight) * ‖p‖ * Real.cos θ := by
          rw [ha]

end GoverningLaws

section ThresholdContracts

/-!
Reachable frequencies and the threshold contracts.  The recorded closed-form
value of `ω_min` occurs ONLY on the conclusion side of the main theorems
below: `ReachableFrequency` and `IsDissociationThreshold` are pure
minimality statements over lawful configurations, and the candidate formula
`hbarOmegaMin` is a bare scalar expression that, by itself, asserts nothing
about dissociation.  The main theorem `minimum_angular_frequency_T1_C1`
bridges the two.
-/

/-- `ω` is reachable at outgoing `O₂` angle `θ` (with oxygen-atom mass `m`
    and dissociation gap `dU`) iff some lawful dissociation configuration
    realizes that photon frequency.  This is a physical reachability
    statement — an existential over geometry and fragment momenta — not a
    formula. -/
def ReachableFrequency (m dU θ ω : ℝ) : Prop :=
  ∃ (k : PhotonLine) (p q : ReactionPlane), IsTwoBodyDissociation k ω θ m dU p q

/-- `ω₀` is *a* dissociation threshold at angle `θ` iff it is reachable and
    no strictly smaller positive frequency is reachable.  This is a
    minimality property over `ReachableFrequency`; the numerical value of
    the threshold is left completely open. -/
def IsDissociationThreshold (m dU θ ω₀ : ℝ) : Prop :=
  ReachableFrequency m dU θ ω₀ ∧
    ∀ ω : ℝ, 0 < ω → ω < ω₀ → ¬ ReachableFrequency m dU θ ω

/-- The candidate closed-form forward-branch threshold, in terms of the
    oxygen-atom mass `m`, the speed of light `c`, the dissociation gap `ΔU`,
    and the scattering angle `θ`:

    `Ω(m, c, ΔU, θ) = 3 m c² (1 − √(1 − (2 ΔU/(3 m c²)) (2 sin²θ + 1)))
                      / (ℏ (2 sin²θ + 1))`.

    This is only a bare real-valued expression — the recorded official
    answer.  By itself it asserts nothing about the dissociation; the
    physical claim that it *is* the minimum reachable frequency is exactly
    the content of `minimum_angular_frequency_T1_C1` below.  The official
    solution also notes `2 sin²θ + 1 = 2 − cos 2θ`, and that the same value
    is the smallest positive root of
    `(2 − cos 2θ)(ℏω)² − 6 m c² (ℏω) + 6 ΔU m c² = 0`. -/
def hbarOmegaMin (m c dU θ : ℝ) : ℝ :=
  3 * m * c ^ 2 * (1 - Real.sqrt (1 - (2 * dU / (3 * m * c ^ 2)) * (2 * Real.sin θ ^ 2 + 1))) /
    (hbar * (2 * Real.sin θ ^ 2 + 1))

/-- Trigonometric helper from the official solution: the angular factor of
    the threshold formula equals `2 − cos 2θ`.  Pure Mathlib content,
    isolated so that both the quadratic-root form and the displayed
    `ω_min` form of the answer can share it. -/
theorem two_sin_sq_add_one_eq (θ : ℝ) :
    2 * Real.sin θ ^ 2 + 1 = 2 - Real.cos (2 * θ) := by
  have h : Real.cos (2 * θ) = 2 * Real.cos θ ^ 2 - 1 := Real.cos_two_mul θ
  have h' := Real.sin_sq_add_cos_sq θ
  linarith

/-- Quadratic characterization of the candidate threshold (official
    solution): in the positive regime (including `ℏ > 0`, needed since the
    candidate `Ω` carries a `1/ℏ` factor), for forward angles and a
    nondegenerate angular factor, `E₀ = ℏ · Ω(m, c, ΔU, θ)` is the smallest
    positive root of
    `(2 − cos 2θ) E² − 6 m c² E + 6 ΔU m c² = 0`.  Stating the equivalence
    here (rather than only the displayed closed form) keeps the official
    derivation route — minimization of the energy/momentum balance reduces to
    this quadratic — available to later proof steps. -/
theorem quadratic_characterization_of_threshold
    (m c dU θ : ℝ)
    (hm : 0 < m) (hc : 0 < c) (hdU : 0 < dU) (hb : 0 < hbar)
    (hθ : IsForwardBranch θ) (hθpos : 0 < θ)
    (hfac : (2:ℝ) - Real.cos (2 * θ) ≠ 0)
    (hdisc : 0 ≤ 1 - (2 * dU / (3 * m * c ^ 2)) * (2 * Real.sin θ ^ 2 + 1)) :
    let E₀ := hbar * hbarOmegaMin m c dU θ
    0 < E₀ ∧
      (2 - Real.cos (2 * θ)) * E₀ ^ 2 - 6 * m * c ^ 2 * E₀ + 6 * dU * m * c ^ 2 = 0 ∧
      ∀ E : ℝ, 0 < E →
        (2 - Real.cos (2 * θ)) * E ^ 2 - 6 * m * c ^ 2 * E + 6 * dU * m * c ^ 2 = 0 →
        E₀ ≤ E := by
  show 0 < hbar * hbarOmegaMin m c dU θ ∧ _ ∧ _
  have hmc : (0:ℝ) < 3 * m * c ^ 2 := by positivity
  have hmcne : (3:ℝ) * m * c ^ 2 ≠ 0 := ne_of_gt hmc
  set S : ℝ := 2 * Real.sin θ ^ 2 + 1 with hSdef
  have hS : (1:ℝ) ≤ S := by
    rw [hSdef]
    have hss := sq_nonneg (Real.sin θ)
    linarith
  have hSpos : (0:ℝ) < S := lt_of_lt_of_le one_pos hS
  have hSne : S ≠ 0 := ne_of_gt hSpos
  set D : ℝ := 1 - (2 * dU / (3 * m * c ^ 2)) * S with hDdef
  set s : ℝ := Real.sqrt D with hsdef
  have hs_nonneg : 0 ≤ s := Real.sqrt_nonneg D
  have hs_sq : s ^ 2 = D := Real.sq_sqrt hdisc
  have hfracS : (2 * dU / (3 * m * c ^ 2)) * (3 * m * c ^ 2) = 2 * dU := by
    field_simp [hmcne]
  have hsq3 : s ^ 2 * (3 * m * c ^ 2) = 3 * m * c ^ 2 - 2 * dU * S := by
    linear_combination (3 * m * c ^ 2) * hs_sq - S * hfracS
  have hfrac : (0:ℝ) < 2 * dU / (3 * m * c ^ 2) := by positivity
  have hDlt : (0:ℝ) < 1 - D := by
    have hmul : (0:ℝ) < (2 * dU / (3 * m * c ^ 2)) * S := mul_pos hfrac hSpos
    rw [hDdef]
    linarith
  have hsq_lt : s ^ 2 < (1:ℝ) ^ 2 := by
    rw [hs_sq]
    linarith [hDlt]
  have hs_lt_one : s < 1 := by
    have h1 := abs_lt_of_sq_lt_sq hsq_lt (by norm_num : (0:ℝ) ≤ 1)
    exact (abs_lt.mp h1).2
  have hone_sub : (0:ℝ) < 1 - s := by linarith
  have hfac_S : (2:ℝ) - Real.cos (2 * θ) = S := (two_sin_sq_add_one_eq θ).symm
  set X : ℝ := 3 * m * c ^ 2 * (1 - s) with hXdef
  have hΩ : hbarOmegaMin m c dU θ = X / (hbar * S) := rfl
  have hE : hbar * hbarOmegaMin m c dU θ = X / S := by
    rw [hΩ]
    have hbne : hbar ≠ 0 := ne_of_gt hb
    have hden : hbar * S ≠ 0 := mul_ne_zero hbne hSne
    field_simp
  refine ⟨?_, ?_, ?_⟩
  · rw [hE]
    exact div_pos (mul_pos hmc hone_sub) hSpos
  · rw [hfac_S, hE]
    have hS2ne : (S:ℝ) ^ 2 ≠ 0 := pow_ne_zero 2 hSne
    have h1 : S ^ 2 * (X / S) ^ 2 = X ^ 2 := by
      rw [div_pow, ← mul_div_assoc]
      exact mul_div_cancel_left₀ (X ^ 2) hS2ne
    have h2 : (X / S) * S = X := div_mul_cancel₀ X hSne
    have key : (S * (X / S) ^ 2 - 6 * m * c ^ 2 * (X / S) + 6 * dU * m * c ^ 2) * S ^ 2
        = S * X ^ 2 - 6 * m * c ^ 2 * S * X + 6 * dU * m * c ^ 2 * S ^ 2 := by
      linear_combination S * h1 - 6 * m * c ^ 2 * S * h2
    have hroot : S * X ^ 2 - 6 * m * c ^ 2 * S * X + 6 * dU * m * c ^ 2 * S ^ 2 = 0 := by
      rw [hXdef]
      linear_combination (S * (3 * m * c ^ 2)) * hsq3
    have hprod : (S * (X / S) ^ 2 - 6 * m * c ^ 2 * (X / S) + 6 * dU * m * c ^ 2) * S ^ 2
        = 0 := by rw [key]; exact hroot
    rcases mul_eq_zero.mp hprod with h | h'
    · exact h
    · exact absurd h' hS2ne
  · intro E _hEpos hEroot
    rw [hfac_S] at hEroot
    have hfactor :
        (S * E - 3 * m * c ^ 2 * (1 - s)) * (S * E - 3 * m * c ^ 2 * (1 + s)) = 0 := by
      linear_combination S * hEroot - (3 * m * c ^ 2) * hsq3
    rcases mul_eq_zero.mp hfactor with h1 | h2
    · have hE1 : E = 3 * m * c ^ 2 * (1 - s) / S := by
        rw [eq_div_iff hSne]
        linarith
      rw [hE, hE1]
    · have hE2 : E = 3 * m * c ^ 2 * (1 + s) / S := by
        rw [eq_div_iff hSne]
        linarith
      rw [hE, hE2]
      have hB : 3 * m * c ^ 2 * (1 - s) ≤ 3 * m * c ^ 2 * (1 + s) := by nlinarith
      exact (div_le_div_iff_of_pos_right hSpos).mpr hB


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
    (hdisc : 0 ≤ 1 - (2 * dissociationEnergyGap /
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
    (hdisc : 0 ≤ 1 - 2 * dissociationEnergyGap /
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
  unfold hbarOmegaMin
  rw [Real.sin_pi_sub]

end ThresholdContracts

end IPhO2026.Problem1.C1
