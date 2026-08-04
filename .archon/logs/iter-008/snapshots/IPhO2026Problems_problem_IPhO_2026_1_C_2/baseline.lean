/-
  IPhO 2026, Problem 1 (T1), Part C.2 — photodissociation of ozone.

  Autoformalized from blueprint chapter
  `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_1_C_2.tex`
  (marked `% archon:physics`).

  Physical model: a photon of angular frequency `ω` is absorbed by an O₃
  molecule at rest, dissociating it into O₂ and O.  `U_i` and `U_f` are the
  ground-state energies of O₃ and of the O₂ + O system, `ΔU = U_f − U_i`.
  Let `U_i` and `U_f` be the ground-state energies of O₃ and O₂ and define
  `ΔU = U_f − U_i`.  The outgoing O₂ momentum makes angle `θ` with the
  incident photon.  The oxygen fragments are classical and non-relativistic;
  the mass of one oxygen atom is `m`.  Photon momentum is
  `p_γ = E_γ / c = ℏ ω / c`.

  Current subquestion: for `θ = π/6`, `ΔU = 1.10 eV`, and `m = 16.0 amu`,
  calculate `ℏ ω_min − ΔU` in eV.  Recorded answer: `≈ 2.03e-11 eV`.

  Blueprint label: `thm:physics:IPhO_2026_1_C_2:target`.

  Conventions:
  * Fragment momenta and kinetic energies are scalars (`ℝ`): the setup states
    the outgoing O₂ momentum makes angle `θ` with the photon, so the geometry
    is captured by one angle and two momentum magnitudes; energy/momentum
    conservation then appears as decomposed scalar equations.  This keeps the
    physical laws as hypotheses instead of opaque scalar aliases.
  * All working quantities (momenta, energies, angles, masses) are real
    numbers in SI units; eV/amu appear only at the calibrated input readouts
    and at the final eV answer, through explicit conversion factors.
-/

import Mathlib
import Physlib

open Real

namespace IPhO2026_1_C_2

/-- Physical constants relevant to this problem.  The speed of light is the
PhysLean `SpeedOfLight` structure (a positive real in some unit system); the
SI value is recorded separately as `cSI` because `SpeedOfLight` deliberately
carries no numerical value.  `ℏ` is grounded in PhysLean's `Constants.ℏ`
(J·s).  `eV` and `amu` are the joule and kilogram values of the
electron-volt and the unified atomic mass unit.  The threshold formula
inherited from part C.1 is stated only in the dimensionless ratio
`ΔU / (3 m c²)`, so its use never needs `m` and `c` separately in SI. -/
structure PhotoDissociationConstants where
  /-- Speed of light, as a PhysLean typed positive real. -/
  c : SpeedOfLight
  /-- Speed of light in m·s⁻¹ (used to convert amu to kg). -/
  cSI : ℝ
  /-- One electron-volt in joules (exact SI value). -/
  eV : ℝ
  /-- One unified atomic mass unit in kilograms. -/
  amu : ℝ
  cSI_pos : 0 < cSI
  eV_pos : 0 < eV
  amu_pos : 0 < amu
  cSI_val : cSI = 299792458
  eV_val : eV = 1.602176634e-19
  amu_val : amu = 1.66053906660e-27

namespace PhotoDissociationConstants

/-- The trusted set of constants: PhysLean `SpeedOfLight` together with the
SI value of `c`, the exact joule value of the eV, and the kilogram value of
the amu.  `ℏ` is taken directly from PhysLean's `Constants.ℏ`. -/
noncomputable def trusted : PhotoDissociationConstants where
  c := ⟨299792458, by norm_num⟩
  cSI := 299792458
  eV := 1.602176634e-19
  amu := 1.66053906660e-27
  cSI_pos := by norm_num
  eV_pos := by norm_num
  amu_pos := by norm_num
  cSI_val := rfl
  eV_val := rfl
  amu_val := rfl

end PhotoDissociationConstants

/-- Kinematic state of the dissociation `γ + O₃ → O₂ + O` with the parent O₃
initially at rest.  The O₂ momentum makes angle `θ` with the incident photon;
fragment momenta are non-relativistic, with oxygen-atom mass `m`, so the O₂
molecule has mass `2m`, the oxygen atom `m`, and the parent O₃ mass `3m`.
All momenta are magnitudes/nonnegative components in `kg·m·s⁻¹`, energies in
joules, angles in radians, masses in kilograms, `ω` in `rad·s⁻¹`. -/
structure DissociationState where
  /-- Angular frequency of the incident photon (rad·s⁻¹). -/
  ω : ℝ
  /-- Magnitude of the outgoing O₂ momentum (kg·m·s⁻¹). -/
  P_O2 : ℝ
  /-- Momentum component of the O atom parallel to the photon direction. -/
  pOx : ℝ
  /-- Momentum component of the O atom perpendicular to the photon direction. -/
  pOy : ℝ
  /-- Angle between the outgoing O₂ momentum and the incident photon (rad). -/
  θ : ℝ
  /-- Ground-state energy of O₃ before absorption (joules). -/
  U_i : ℝ
  /-- Ground-state energy of the O₂ + O system after dissociation (joules). -/
  U_f : ℝ
  /-- Mass of one oxygen atom (kilograms). -/
  m : ℝ
  m_pos : 0 < m
  P_O2_nonneg : 0 ≤ P_O2

/-- The dissociation energy threshold `ΔU = U_f − U_i`: the difference of the
ground-state energies of the O₂ + O system and of O₃, in joules. -/
def DissociationState.ΔU (s : DissociationState) : ℝ := s.U_f - s.U_i

/-- Governing physical laws of the model (assumptions of the formalization):

* `photon_energy` / `photon_momentum`: Planck–Einstein photon relations
  `E_γ = ℏ ω` and `p_γ = ℏ ω / c`;
* `momentum_parallel` / `momentum_perp`: momentum conservation with the
  parent O₃ at rest, decomposed along and across the incident photon
  direction, with `θ` the angle of the outgoing O₂ momentum;
* `energy_conservation`: energy conservation with classical non-relativistic
  fragment kinetic energies (O₂ of mass `2m`, O of mass `m`);
* `deltaU_nonneg_needed`: dissociation energy is nonnegative.

Each field is an equation/inequality a later proof can rewrite with, so the
interface constrains the model (see the elimination lemma
`IsOzonePhotodissociation.rest_energy_gap_pos`). -/
structure IsOzonePhotodissociation (K : PhotoDissociationConstants)
    (s : DissociationState) : Prop where
  photon_energy : Constants.ℏ.val * s.ω = (Constants.ℏ.val * s.ω / (K.c : ℝ)) * (K.c : ℝ)
  photon_momentum : 0 ≤ Constants.ℏ.val * s.ω / (K.c : ℝ)
  momentum_parallel : Constants.ℏ.val * s.ω / (K.c : ℝ) =
    s.P_O2 * Real.cos s.θ + s.pOx
  momentum_perp : 0 = s.P_O2 * Real.sin s.θ + s.pOy
  energy_conservation : Constants.ℏ.val * s.ω + s.U_i =
    s.U_f + s.P_O2 ^ 2 / (2 * (2 * s.m)) + (s.pOx ^ 2 + s.pOy ^ 2) / (2 * s.m)
  deltaU_nonneg_needed : 0 ≤ s.U_f - s.U_i

namespace IsOzonePhotodissociation

/-- Bridge: the photon energy in the state is `ℏ ω`, positive whenever
`ω > 0`, and the photon momentum magnitude is `ℏ ω / c`.  Exposes the
equations behind `photon_energy`/`photon_momentum` in a reusable form. -/
theorem photon_energy_pos_of_omega_pos {K : PhotoDissociationConstants}
    {s : DissociationState} (h : IsOzonePhotodissociation K s)
    (hω : 0 < s.ω) : 0 < Constants.ℏ.val * s.ω := by
  have hℏ : (0:ℝ) < Constants.ℏ.val := Constants.ℏ.property
  exact mul_pos hℏ hω

/-- Bridge: in any lawful dissociation state, the kinetic energy released
beyond the threshold, `ℏ ω − ΔU`, equals the total non-relativistic fragment
kinetic energy, hence is nonnegative.  This is the energy-side shadow of the
minimization underlying `ω_min` and constrains any countermodel. -/
theorem rest_energy_gap_nonneg {K : PhotoDissociationConstants}
    {s : DissociationState} (h : IsOzonePhotodissociation K s) :
    0 ≤ Constants.ℏ.val * s.ω - s.ΔU := by
  have hm : (0:ℝ) < 2 * s.m := by linarith [s.m_pos]
  have hT1 : 0 ≤ s.P_O2 ^ 2 / (2 * (2 * s.m)) := by
    apply div_nonneg (sq_nonneg _) ; linarith
  have hT2 : 0 ≤ (s.pOx ^ 2 + s.pOy ^ 2) / (2 * s.m) := by
    apply div_nonneg (add_nonneg (sq_nonneg _) (sq_nonneg _)) ; linarith
  have := h.energy_conservation
  unfold DissociationState.ΔU
  linarith

/-- Elimination theorem: the fragment momenta satisfy the ellipse-like
relation obtained by eliminating the angle of the O atom between the
momentum-conservation equations.  This is the key constraint equation from
which the C.1 minimization — and therefore `ω_min` — is derived; it makes
the interface mathematically constraining rather than a mere witness
assertion.  With photon momentum `pγ = ℏ ω / c`,
`(pγ − P_O2 cos θ)² + (−P_O2 sin θ)² = pOx² + pOy²`. -/
theorem momentum_balance_sq {K : PhotoDissociationConstants}
    {s : DissociationState} (h : IsOzonePhotodissociation K s) :
    (Constants.ℏ.val * s.ω / (K.c : ℝ) - s.P_O2 * Real.cos s.θ) ^ 2
      + (s.P_O2 * Real.sin s.θ) ^ 2
    = s.pOx ^ 2 + s.pOy ^ 2 := by
  have hx : s.pOx = Constants.ℏ.val * s.ω / (K.c : ℝ) - s.P_O2 * Real.cos s.θ := by
    linarith [h.momentum_parallel]
  have hy : s.pOy = - s.P_O2 * Real.sin s.θ := by
    linarith [h.momentum_perp]
  rw [hx, hy]
  ring

end IsOzonePhotodissociation

/-- Previous-part result (C.1, `θ ≤ π/2` branch), taken as a natural-language
prerequisite: the minimum photon energy `ℏ ω_min` required for dissociation at
outgoing O₂ angle `θ`, written in `ΔE = ℏ ω_min` form to keep `ℏ` outside the
quotient — for `θ ≤ π/2`,

`ΔE_min = 3 m c² · (1 − √(1 − (ΔU / (3mc²))·(2 sin²θ + 1))) / (2 sin²θ + 1)`.

This is a formula (function of physical parameters), not the current
subquestion's numerical answer; the current target (the numeric value of
`ΔE_min − ΔU` in eV at the C.2 data) remains on the conclusion side of the
main theorem. -/
noncomputable def hbarOmegaMin (mc2 ΔU θ : ℝ) : ℝ :=
  3 * mc2 * (1 - Real.sqrt (1 - (ΔU / (3 * mc2)) * (2 * Real.sin θ ^ 2 + 1))) /
    (2 * Real.sin θ ^ 2 + 1)

/-- Calibrated SI data readouts for part C.2: `θ = π/6`, `ΔU = 1.10 eV`,
`m = 16.0 amu`, together with the derived dimensionless threshold parameter
of the C.1 formula, `ΔU / (3 m c²)`.  These are figure/data readouts
(problem-given inputs), not conclusions. -/
structure C2CalibratedData (K : PhotoDissociationConstants) where
  /-- Scattering angle of the outgoing O₂, `θ = π/6` (radians). -/
  θ : ℝ
  /-- Dissociation energy in eV, `ΔU = 1.10 eV` (readout). -/
  ΔU_eV : ℝ
  /-- Oxygen atom mass in amu, `m = 16.0 amu` (readout). -/
  m_amu : ℝ
  /-- Dissociation energy in joules. -/
  ΔU_J : ℝ
  /-- Oxygen atom mass in kilograms. -/
  m_kg : ℝ
  /-- Dimensionless ratio `ΔU / (3 m c²)` appearing in the C.1 threshold. -/
  ratio : ℝ
  θ_val : θ = Real.pi / 6
  ΔU_eV_val : ΔU_eV = 1.10
  m_amu_val : m_amu = 16.0
  ΔU_J_def : ΔU_J = ΔU_eV * K.eV
  m_kg_def : m_kg = m_amu * K.amu
  ratio_def : ratio = ΔU_J / (3 * m_kg * K.cSI ^ 2)

/-- Bridge obligation: at `θ = π/6`, the angular factor of the C.1 threshold
formula is `2 sin²(π/6) + 1 = 3/2`.  A pure Mathlib computation, isolated so
the main numeric evaluation can rewrite the C.1 formula to the compact form
`ℏ ω_min(π/6) = 2 mc² (1 − √(1 − 3·ratio/2))`. -/
theorem angular_factor_at_pi_div_six :
    2 * Real.sin (Real.pi / 6) ^ 2 + 1 = 3 / 2 := by
  have hs : Real.sin (Real.pi / 6) = 1 / 2 := Real.sin_pi_div_six
  rw [hs]
  norm_num

/-- Simplified C.1 threshold at `θ = π/6`, as a function of the dimensionless
ratio `r = ΔU / (3 m c²)`.

`ℏ ω_min = 2 m c² · (1 − √(1 − 3r/2))`,

written with `(1:ℝ) / (3/2) * (3 * mc2)` kept explicit so the algebra leading
to it is visible; the equality is a routine normalization. -/
noncomputable def hbarOmegaMinAtPiDivSix (mc2 r : ℝ) : ℝ :=
  (1:ℝ) / (3 / 2) * (3 * mc2) * (1 - Real.sqrt (1 - r * (3 / 2)))

/-- Bridge: the specialized formula above equals the C.1 formula evaluated at
`θ = π/6`, provided `3 m c² ≠ 0` (the denominators are nonzero since
`sin(π/6) ≠ 0`). -/
theorem hbarOmegaMin_at_pi_div_six (mc2 ΔU : ℝ) (hmc2 : 3 * mc2 ≠ 0) :
    hbarOmegaMin mc2 ΔU (Real.pi / 6) = hbarOmegaMinAtPiDivSix mc2 (ΔU / (3 * mc2)) := by
  have hf : (2:ℝ) * Real.sin (Real.pi / 6) ^ 2 + 1 = 3 / 2 := angular_factor_at_pi_div_six
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
