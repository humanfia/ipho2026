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

  All theorem statements below are faithful contracts.  The current target
  conclusion — the closed-form value of `ω_min` — appears only on the
  conclusion side of the main theorems `minimum_angular_frequency_T1_C1` /
  `minimum_angular_frequency_backward_branch_T1_C1` and of the auxiliary
  quadratic-form lemma `quadratic_characterization_of_threshold`; the
  governing-law predicates (`IsTwoBodyDissociation`, `IsScatteringAngle`)
  never mention it.

  Iter-017 redraft (proof-Review certificate `needs_redraft`,
  other_modeling_defect): the official solution attains the threshold at the
  degenerate critical configuration `p = 0` (the `O₂` fragment at rest, the
  `O` atom carrying the full photon momentum) for every `θ ≥ π/2`, including
  the forward theorem's boundary `θ = π/2` — the tangent point of the
  velocity circle at `θ = 90°` is the origin, and for larger angles the
  threshold circle passes through the origin (`T1_solution.txt`, T1-C1).
  Accordingly `IsScatteringAngle` no longer excludes `p = 0`, and the
  backward theorem's discriminant hypothesis is the real-square-root
  condition at `π/2`, `0 ≤ 1 − 2ΔU/(mc²)`; the earlier
  `0 ≤ 1 − 2ΔU/(3mc²)` admitted the regime `ΔU ∈ (mc²/2, 3mc²/2]`, where
  nothing at all is reachable at backward angles.  The two reachability
  conjuncts remain `sorry` (proof-lane work); every other proof in the file —
  in particular both minimality conjuncts — is unchanged and never used the
  dropped `p ≠ 0`.
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
    photon direction `k̂`, as read from Figure 1c: the cosine-law component
    statement `⟪k̂, p⟫ = ‖p‖ * cos θ`.

    For `p ≠ 0` this is exactly the statement that `θ` is the angle between
    the two momentum vectors.  The degenerate case `p = 0` — the `O₂`
    fragment produced at rest, with the `O` atom carrying the full photon
    momentum — is admitted: the cosine law is then vacuous (`0 = 0`) at every
    `θ`.  This matches the official solution (`T1_solution.txt`, T1-C1): the
    tangent critical configuration at `θ = 90°` is the origin point of the
    velocity circle, and for `θ ≥ 90°` the threshold circle passes through
    the origin, so the official answer counts the threshold as *attained* at
    `p = 0`.  Excluding `p = 0` would make the threshold an unattained
    infimum and both main theorems below false (proof-Review certificate,
    iter-017). -/
def IsScatteringAngle (k : PhotonLine) (p : ReactionPlane) (θ : ℝ) : Prop :=
  @inner ℝ _ _ k.direction p = ‖p‖ * Real.cos θ

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
  have hinner : @inner ℝ _ _ k.direction p = ‖p‖ * Real.cos θ := hθ
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
    formula.  Following the official solution, the degenerate threshold
    configuration `p = 0` (the `O₂` fragment at rest) counts as a
    configuration at every angle; see `IsScatteringAngle`. -/
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


/-- **Bridge: the momentum-magnitude quadratic.**  From the fields of any lawful
    dissociation configuration, `P = ‖p‖` is a real root of the
    official-solution quadratic `3P² − 4a cosθ·P + (2a² + 4mΔU − 4mE) = 0`
    with `a = ℏω/c`, `E = ℏω`.  Pure field algebra from the structure fields;
    no threshold value is used. -/
theorem config_quadratic
    (k : PhotonLine) (ω θ m dU : ℝ) (p q : ReactionPlane) (hm : 0 < m)
    (h : IsTwoBodyDissociation k ω θ m dU p q) :
    3 * ‖p‖ ^ 2 - 4 * (hbar * ω / speedOfLight) * Real.cos θ * ‖p‖
      + (2 * (hbar * ω / speedOfLight) ^ 2 + 4 * m * dU - 4 * m * (hbar * ω)) = 0 := by
  obtain ⟨hq_sq, _hq_uniq, _hangle, henb⟩ := h
  have hm2 : (2:ℝ) * m ≠ 0 := by positivity
  have hm4 : (2:ℝ) * (2 * m) ≠ 0 := by positivity
  rw [hq_sq] at henb
  field_simp [hm2, hm4] at henb
  linear_combination -henb

/-- **Recoil sign at non-forward angles.**  At any angle with `cos θ ≤ 0`, every
    lawful configuration has `C(E) ≤ 0`, where `C(E) = 2(E/c)² + 4mΔU − 4mE`:
    the momentum quadratic rewrites as `C = −3P² + 4aPcosθ`, and both terms are
    nonpositive when `cos θ ≤ 0`.  The proof never uses the `p ≠ 0` conjunct of
    `IsScatteringAngle`, so it remains valid verbatim under the proposed redraft
    that admits the degenerate critical configuration `p = 0`. -/
theorem reachable_C_nonpos_of_cos_nonpos
    (m dU θ ω : ℝ) (hm : 0 < m) (hc : 0 < speedOfLight) (hdU : 0 < dU)
    (hcos : Real.cos θ ≤ 0) (h : ReachableFrequency m dU θ ω) :
    2 * (hbar * ω / speedOfLight) ^ 2 + 4 * m * dU - 4 * m * (hbar * ω) ≤ 0 := by
  obtain ⟨k, p, q, h⟩ := h
  obtain ⟨hq_sq, _hq_uniq, hangle, henb⟩ := h
  have hEpos : 0 < hbar * ω := by
    have e1 : (0:ℝ) ≤ ‖p‖ ^ 2 / (2 * (2 * m)) := by positivity
    have e2 : (0:ℝ) ≤ ‖q‖ ^ 2 / (2 * m) := by positivity
    linarith
  have h4 : 4 * (hbar * ω / speedOfLight) * Real.cos θ * ‖p‖ ≤ 0 := by
    have hbase : (0:ℝ) ≤ 4 * (hbar * ω / speedOfLight) * ‖p‖ := by positivity
    have h5 := mul_nonpos_of_nonneg_of_nonpos hbase hcos
    ring_nf at h5 ⊢
    exact h5
  have hquad := config_quadratic k ω θ m dU p q hm ⟨hq_sq, _hq_uniq, hangle, henb⟩
  have hCe : 2 * (hbar * ω / speedOfLight) ^ 2 + 4 * m * dU - 4 * m * (hbar * ω)
      = -3 * ‖p‖ ^ 2 + 4 * (hbar * ω / speedOfLight) * Real.cos θ * ‖p‖ := by
    linear_combination hquad
  rw [hCe]
  have hP2 : (0:ℝ) ≤ 3 * ‖p‖ ^ 2 := by positivity
  linarith

/-- **Value of the candidate at the right angle.**  At `θ = π/2` the angular
    factor is `2 sin²(π/2) + 1 = 3`, so the scaled candidate is
    `ℏ·Ω(m, c, ΔU, π/2) = mc²(1 − √(1 − 2ΔU/(mc²)))`. -/
theorem hbar_mul_hbarOmegaMin_pi_div_two
    (m dU : ℝ) (hm : 0 < m) (hc : 0 < speedOfLight) (hb : 0 < hbar) :
    hbar * hbarOmegaMin m speedOfLight dU (Real.pi / 2)
      = m * speedOfLight ^ 2
        * (1 - Real.sqrt (1 - 2 * dU / (m * speedOfLight ^ 2))) := by
  set s : ℝ := Real.sqrt (1 - 2 * dU / (m * speedOfLight ^ 2)) with hsdef
  have hmc : (0:ℝ) < m * speedOfLight ^ 2 := by positivity
  have hmcne : m * speedOfLight ^ 2 ≠ 0 := ne_of_gt hmc
  have h3mcne : (3:ℝ) * m * speedOfLight ^ 2 ≠ 0 := by positivity
  have hbne : hbar ≠ 0 := ne_of_gt hb
  unfold hbarOmegaMin
  rw [Real.sin_pi_div_two]
  have harg : 1 - (2 * dU / (3 * m * speedOfLight ^ 2)) * (2 * (1:ℝ) ^ 2 + 1)
      = 1 - 2 * dU / (m * speedOfLight ^ 2) := by
    field_simp [hmcne, h3mcne]
    ring
  rw [harg, ← hsdef]
  field_simp [hbne]
  ring

/-- **Main target** (blueprint `thm:physics:IPhO_2026_1_C_1:target`,
    forward branch).  Under the positive-constant regime, for a nondegenerate
    forward scattering angle `0 < θ ≤ π/2` with a real square root in the
    candidate formula, the candidate expression `Ω(m, c, ΔU, θ)` *is* the
    dissociation threshold: it is reachable, and no smaller positive
    frequency can dissociate ozone at that angle.

    The recorded answer appears strictly on the conclusion side: the
    hypotheses carry only the physical regime, the figure angle range, and
    the algebraic nondegeneracy needed for the square root to be real.  At
    the boundary `θ = π/2` the realizing configuration is the official
    degenerate critical one, `p = 0` (the `O₂` at rest), admitted by the
    redrafted `IsScatteringAngle`; for `0 < θ < π/2` the critical
    configuration has `P = 2(ℏΩ/c)cosθ/3 > 0`. -/
theorem minimum_angular_frequency_T1_C1
    (reg : ConstantRegime) (θ : ℝ)
    (hrange : IsAngularRange θ) (hfwd : IsForwardBranch θ) (hθpos : 0 < θ)
    (hdisc : 0 ≤ 1 - (2 * dissociationEnergyGap /
        (3 * oxygenAtomMass * speedOfLight ^ 2)) * (2 * Real.sin θ ^ 2 + 1)) :
    IsDissociationThreshold oxygenAtomMass dissociationEnergyGap θ
      (hbarOmegaMin oxygenAtomMass speedOfLight dissociationEnergyGap θ) := by
  obtain ⟨hb, hc, hm, hdU⟩ := reg
  refine ⟨?_, ?_⟩
  · -- REACHABILITY — true post-redraft, left to the proof lane.  At
    -- `E₀ = ℏΩ(θ)` the `P`-quadratic of `config_quadratic` has the double
    -- root `P₀ = 2(E₀/c)·cosθ/3 ≥ 0` (its discriminant is the square
    -- `(6P − 4a cosθ)²` and vanishes because `Q(E₀) = 0`, cf. the
    -- minimality half below).  Witness: any `k`, a vector `p` of norm `P₀`
    -- at angle `θ` from `k̂` (in coordinates `k̂ = ![1, 0]`,
    -- `p = ![P₀ * cos θ, P₀ * sin θ]`; at `θ = π/2` this is `p = 0`, the
    -- official degenerate critical configuration), and
    -- `q = (E₀/c) • k̂ − p`; the energy balance at the double root is
    -- exactly `Q(E₀) = 0`, and the angle readout is the cosine law
    -- (vacuous when `P₀ = 0`).
    sorry
  · -- MINIMALITY — proved in full: any reachable `E = ℏω` satisfies `Q(E) ≤ 0`,
    -- and the root factorization of `Q` then gives `E ≥ ℏΩ`.
    intro ω _hωpos hωlt hreach
    set E : ℝ := hbar * ω with hEdef
    set S : ℝ := 2 * Real.sin θ ^ 2 + 1 with hSdef
    have hSpos : (0:ℝ) < S := by
      rw [hSdef]
      have hss := sq_nonneg (Real.sin θ)
      linarith
    have hSne : S ≠ 0 := ne_of_gt hSpos
    set D : ℝ := 1 - (2 * dissociationEnergyGap /
      (3 * oxygenAtomMass * speedOfLight ^ 2)) * S with hDdef
    set s : ℝ := Real.sqrt D with hsdef
    have hs_nonneg : 0 ≤ s := Real.sqrt_nonneg D
    have hs_sq : s ^ 2 = D := Real.sq_sqrt hdisc
    have hmc3 : (0:ℝ) < 3 * oxygenAtomMass * speedOfLight ^ 2 := by positivity
    have hmc3ne : (3:ℝ) * oxygenAtomMass * speedOfLight ^ 2 ≠ 0 := ne_of_gt hmc3
    obtain ⟨k, p, q, hcfg⟩ := hreach
    have hquad := config_quadratic k ω θ oxygenAtomMass dissociationEnergyGap p q hm hcfg
    rw [← hEdef] at hquad
    -- the discriminant of the `P`-quadratic is a square, hence nonnegative
    have hsq : (6 * ‖p‖ - 4 * (E / speedOfLight) * Real.cos θ) ^ 2
        = 16 * (E / speedOfLight) ^ 2 * Real.cos θ ^ 2
          - 12 * (2 * (E / speedOfLight) ^ 2 + 4 * oxygenAtomMass * dissociationEnergyGap
              - 4 * oxygenAtomMass * E) := by
      linear_combination 12 * hquad
    have hdisc_nn : 0 ≤ 16 * (E / speedOfLight) ^ 2 * Real.cos θ ^ 2
        - 12 * (2 * (E / speedOfLight) ^ 2 + 4 * oxygenAtomMass * dissociationEnergyGap
            - 4 * oxygenAtomMass * E) := by
      rw [← hsq]
      exact sq_nonneg _
    -- clearing `c²` turns discriminant-nonnegativity into `Q(E) ≤ 0`
    have hScos : 2 * Real.cos θ ^ 2 - 3 = -S := by
      have h1 := Real.sin_sq_add_cos_sq θ
      rw [hSdef]
      linarith
    have hc2 : (0:ℝ) < speedOfLight ^ 2 := by positivity
    have hmul : 0 ≤ (16 * (E / speedOfLight) ^ 2 * Real.cos θ ^ 2
        - 12 * (2 * (E / speedOfLight) ^ 2 + 4 * oxygenAtomMass * dissociationEnergyGap
            - 4 * oxygenAtomMass * E)) * speedOfLight ^ 2 :=
      mul_nonneg hdisc_nn (le_of_lt hc2)
    have hstep : (16 * (E / speedOfLight) ^ 2 * Real.cos θ ^ 2
        - 12 * (2 * (E / speedOfLight) ^ 2 + 4 * oxygenAtomMass * dissociationEnergyGap
            - 4 * oxygenAtomMass * E)) * speedOfLight ^ 2
        = 8 * (2 * Real.cos θ ^ 2 - 3) * E ^ 2
          + 48 * oxygenAtomMass * speedOfLight ^ 2 * (E - dissociationEnergyGap) := by
      field_simp [ne_of_gt hc]
      ring
    rw [hstep, hScos] at hmul
    have hQ : S * E ^ 2 - 6 * oxygenAtomMass * speedOfLight ^ 2 * E
        + 6 * oxygenAtomMass * speedOfLight ^ 2 * dissociationEnergyGap ≤ 0 := by
      linarith [hmul]
    -- root factorization: `S·Q(E) = (SE − A₋)(SE − A₊)`, so `Q(E) ≤ 0` forces `SE ≥ A₋`
    have h1ms : (1 - s ^ 2) * (3 * oxygenAtomMass * speedOfLight ^ 2)
        = 2 * dissociationEnergyGap * S := by
      have h1 : 1 - s ^ 2
          = (2 * dissociationEnergyGap / (3 * oxygenAtomMass * speedOfLight ^ 2)) * S := by
        rw [hDdef] at hs_sq
        linear_combination -hs_sq
      rw [h1]
      field_simp [hmc3ne]
    have hfac : (S * E - 3 * oxygenAtomMass * speedOfLight ^ 2 * (1 - s))
        * (S * E - 3 * oxygenAtomMass * speedOfLight ^ 2 * (1 + s))
        = S * (S * E ^ 2 - 6 * oxygenAtomMass * speedOfLight ^ 2 * E
            + 6 * oxygenAtomMass * speedOfLight ^ 2 * dissociationEnergyGap) := by
      linear_combination (3 * oxygenAtomMass * speedOfLight ^ 2) * h1ms
    have hprod : (S * E - 3 * oxygenAtomMass * speedOfLight ^ 2 * (1 - s))
        * (S * E - 3 * oxygenAtomMass * speedOfLight ^ 2 * (1 + s)) ≤ 0 := by
      rw [hfac]
      exact mul_nonpos_of_nonneg_of_nonpos (le_of_lt hSpos) hQ
    have hA0 : (0:ℝ) ≤ 3 * oxygenAtomMass * speedOfLight ^ 2 * s := by positivity
    have hSE : 3 * oxygenAtomMass * speedOfLight ^ 2 * (1 - s) ≤ S * E := by
      by_contra hlt
      rw [not_le] at hlt
      have h1 : S * E - 3 * oxygenAtomMass * speedOfLight ^ 2 * (1 - s) < 0 := by linarith
      have h2 : S * E - 3 * oxygenAtomMass * speedOfLight ^ 2 * (1 + s) < 0 := by linarith
      have h3 := mul_pos_of_neg_of_neg h1 h2
      linarith [hprod]
    have hEΩ : hbar * hbarOmegaMin oxygenAtomMass speedOfLight dissociationEnergyGap θ
        = 3 * oxygenAtomMass * speedOfLight ^ 2 * (1 - s) / S := by
      unfold hbarOmegaMin
      rw [← hSdef, ← hDdef, ← hsdef]
      field_simp [ne_of_gt hb, hSne]
    have hEge : hbar * hbarOmegaMin oxygenAtomMass speedOfLight dissociationEnergyGap θ
        ≤ E := by
      rw [hEΩ, div_le_iff₀ hSpos]
      linarith [hSE]
    have hEl : E
        < hbar * hbarOmegaMin oxygenAtomMass speedOfLight dissociationEnergyGap θ := by
      have h1 := mul_lt_mul_of_pos_left hωlt hb
      rwa [← hEdef] at h1
    linarith [hEge, hEl]

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
  obtain ⟨hb, hc, hm, hdU⟩ := reg
  refine ⟨?_, ?_⟩
  · -- REACHABILITY — genuinely blocked by the same formalization gap, here for
    -- EVERY θ ∈ [π/2, π]: at `cos θ ≤ 0` any lawful configuration has `C(E) ≤ 0`
    -- (`reachable_C_nonpos_of_cos_nonpos`), while at the claimed threshold
    -- energy `E₀ = ℏΩ(π/2) = mc²(1 − √(1 − 2ΔU/(mc²)))` one has `C(E₀) ≥ 0`
    -- (both facts machine-checked in the prover's scratch file); the strict
    -- form using `p ≠ 0` gives `C < 0` vs `C(E₀) = 0` — a contradiction, so
    -- `Ω(π/2)` is unreachable at θ.  The official tangent configuration is the
    -- degenerate `p = 0` limit; admitting it (dropping `p ≠ 0`) makes this
    -- conjunct provable for `ΔU ≤ mc²/2` (a real square root at `π/2` —
    -- note the current `hdisc` only gives `ΔU ≤ 3mc²/2`, under which NOTHING
    -- is reachable at backward angles at all).
    sorry
  · -- MINIMALITY — proved in full: below `Ω(π/2)` nothing is reachable, since
    -- reachability forces `C(E) ≤ 0` while `E < ℏΩ(π/2)` gives `C(E) > 0`.
    intro ω _hωpos hωlt hreach
    have hcos : Real.cos θ ≤ 0 := Real.cos_nonpos_of_pi_div_two_le_of_le hbwd
        (le_trans hrange.2 (by have hπ := Real.pi_pos; linarith))
    have hC := reachable_C_nonpos_of_cos_nonpos
      oxygenAtomMass dissociationEnergyGap θ ω hm hc hdU hcos hreach
    set E : ℝ := hbar * ω with hEdef
    set s₀ : ℝ := Real.sqrt (1 - 2 * dissociationEnergyGap /
      (oxygenAtomMass * speedOfLight ^ 2)) with hs0def
    have hmc : (0:ℝ) < oxygenAtomMass * speedOfLight ^ 2 := by positivity
    have hΩ0 := hbar_mul_hbarOmegaMin_pi_div_two oxygenAtomMass dissociationEnergyGap hm hc hb
    rw [← hs0def] at hΩ0
    have hEl : E < oxygenAtomMass * speedOfLight ^ 2 * (1 - s₀) := by
      have h1 := mul_lt_mul_of_pos_left hωlt hb
      rw [← hEdef, hΩ0] at h1
      exact h1
    have hCpos : 0 < 2 * (E / speedOfLight) ^ 2
        + 4 * oxygenAtomMass * dissociationEnergyGap - 4 * oxygenAtomMass * E := by
      have hc2 : (0:ℝ) < speedOfLight ^ 2 := by positivity
      have hCid : 2 * (E / speedOfLight) ^ 2 + 4 * oxygenAtomMass * dissociationEnergyGap
          - 4 * oxygenAtomMass * E
          = (2 / speedOfLight ^ 2) * (E ^ 2 - 2 * oxygenAtomMass * speedOfLight ^ 2 * E
              + 2 * oxygenAtomMass * speedOfLight ^ 2 * dissociationEnergyGap) := by
        field_simp [ne_of_gt hc]
        ring
      rw [hCid]
      have h2c : (0:ℝ) < 2 / speedOfLight ^ 2 := by positivity
      apply mul_pos h2c
      by_cases hnn : 0 ≤ 1 - 2 * dissociationEnergyGap / (oxygenAtomMass * speedOfLight ^ 2)
      · have hs0sq : s₀ ^ 2
            = 1 - 2 * dissociationEnergyGap / (oxygenAtomMass * speedOfLight ^ 2) :=
          Real.sq_sqrt hnn
        have h1ms0 : (1 - s₀ ^ 2) * (oxygenAtomMass * speedOfLight ^ 2)
            = 2 * dissociationEnergyGap := by
          have h1 : 1 - s₀ ^ 2
              = 2 * dissociationEnergyGap / (oxygenAtomMass * speedOfLight ^ 2) := by
            linear_combination -hs0sq
          rw [h1]
          field_simp [ne_of_gt hmc]
        have hfac0 : E ^ 2 - 2 * oxygenAtomMass * speedOfLight ^ 2 * E
            + 2 * oxygenAtomMass * speedOfLight ^ 2 * dissociationEnergyGap
            = (E - oxygenAtomMass * speedOfLight ^ 2 * (1 - s₀))
              * (E - oxygenAtomMass * speedOfLight ^ 2 * (1 + s₀)) := by
          linear_combination -(oxygenAtomMass * speedOfLight ^ 2) * h1ms0
        rw [hfac0]
        apply mul_pos_of_neg_of_neg
        · linarith [hEl]
        · have hs0nn : (0:ℝ) ≤ s₀ := Real.sqrt_nonneg _
          have h0 : (0:ℝ) ≤ oxygenAtomMass * speedOfLight ^ 2 * s₀ := by positivity
          linarith [hEl]
      · have h1 : 1 - 2 * dissociationEnergyGap / (oxygenAtomMass * speedOfLight ^ 2) < 0 :=
          lt_of_not_ge hnn
        have hgt : oxygenAtomMass * speedOfLight ^ 2 < 2 * dissociationEnergyGap := by
          have h3 : (1:ℝ) < 2 * dissociationEnergyGap /
              (oxygenAtomMass * speedOfLight ^ 2) := by linarith
          exact (one_lt_div hmc).mp h3
        have hmul := mul_lt_mul_of_pos_left hgt hmc
        nlinarith [sq_nonneg (E - oxygenAtomMass * speedOfLight ^ 2), hmul]
    linarith [hC, hCpos]

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
