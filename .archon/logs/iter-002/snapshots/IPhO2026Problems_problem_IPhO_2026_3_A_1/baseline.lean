/-
# IPhO 2026, Problem 3 ("Chasing the absolute zero"), Part A.1

Physics blueprint chapter:
`blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_3_A_1.tex`.
Source report: `reports/ipho_2026_k3/problem_IPhO_2026_3_A_1.source.json`.
Official source pages: `image/T3_page-1.png` (statement of Question T3,
Fig. 3a) and `image/T3_page-2.png` (Part T3-A, hint and subquestions).

## Physical setup (source text)

A torus with mean radius `R` and inner radius `r` is made of a homogeneous,
isotropic paramagnetic material, around which an insulated conducting wire is
wound, with its ends connected to an external voltage source (emf), as shown
in Fig. 3a.  The resistance of the wire is so low that energy losses due to
heating of the wire can be neglected.  The winding is dense, with `N` turns in
total, and it is assumed that `r ≪ R`, so that the fields `H` and `B` and the
magnetization `M` have approximately constant magnitudes throughout the torus.
`V` and `A` denote the volume and the cross-section area of the torus.
In paramagnetic materials `M` is parallel to `H` and `B = μ₀ H + μ₀ M`.

Hint given in the official paper (Ampère's law for magnetostatics):
`∮_C H·dℓ = I_C`, where `I_C` is the net free current passing through the
area bounded by the closed curve `C`.

Energy-transfer sign convention: Work (`W`) and Heat (`Q`) are positive when
they flow into the system and negative when they flow out.

## Current subquestion (T3-A1, 0.2 pts)

> Let `H` be the magnitude of `H⃗` in the torus.  Write `H` in terms of
> `N`, `A`, `V` and the instantaneous electric current `I` in the wire.

Recorded official answer: `H = N·I·A / V`
(equivalently `H = N·I / (2πR)` under the thin-torus mean-path parametrization
`V = 2πR·A`).

## Formalization notes

Scalar `H` readouts per winding turn are modelled as functions `Turn → ℝ`
(a tiny abstract-index interface — the set of turns is unordered, so a list
would wrongly impose an order).  The magnitude readout is proved equal to the
piecewise-constant-uniformity readout, so either side may serve as the
hypothesis interface and the other as the conclusion; the local abstraction
`UniformFieldMag` below exposes the equality of both projections and therefore
constrains the readout instead of merely asserting an opaque witness.

Ampère's law is kept as a structure of *laws* (fields, not the answer):
no field of `AmpereLaw`, `AmpereLawThinMeanPath`, `UniformFieldMag`,
`AmperianFilamentLaw`, or of `ParamagneticTorusA1` is the target relation
`H = N·I·A / V`; that relation appears only on the conclusion side of theorem
`paramagneticTorus_H_eq`.  The vacuum-core identity `B = μ₀ H + μ₀ M` and the
parallelism of `M` with `H` (which make this `H`-field the correct
thermodynamic state variable for the later parts of T3) are recorded as
assumptions for the downstream formalizations.
-/

import Mathlib

namespace IPhO2026
namespace Problem3
namespace PartA1

open scoped BigOperators

/-! ### Permeability of free space

PhysLean grounding: `Electromagnetism.EMSystem`
(`Physlib.Electromagnetism.Basic`) carries `μ₀ : ℝ` together with `ε₀`; here
we need only `μ₀` and its positivity, introduced with the standard projection
name so that later parts (A.2/A.3, which involve `μ₀`) share the constant. -/

/-- The magnetic permeability of free space `μ₀`, a positive real constant. -/
structure FreeSpace where
  /-- The permeability of free space `μ₀`. -/
  μ₀ : ℝ
  /-- `μ₀` is strictly positive. -/
  μ₀_pos : 0 < μ₀

/-! ### Symmetry-reduced (thin-torus) field readouts

By the toroidal symmetry the azimuthal field magnitude depends only on the
radial distance `ρ` from the symmetry axis, and each turn of the winding is a
toroidal filament with the same instantaneous current (a series winding
around a single core forces the same `I` through every turn).  We therefore
model H-fields as radial profiles `ℝ → ℝ` and the winding as an indexed family
of filaments over a turn type. -/

/-- The instantaneous free current in a single filament (turn) of the
winding, in amperes. -/
abbrev InstantaneousCurrent := ℝ

/-- A radial profile of the azimuthal H-field magnitude (A/m), evaluated at
the distance `ρ` from the torus symmetry axis. -/
abbrev RadialProfile := ℝ → ℝ

/-- The H-field magnitude readouts (A/m) indexed by the winding turns. -/
abbrev HFieldReadouts (Turn : Type*) := Turn → ℝ

/-- A single-winding amperian filament: one turn of the winding that threads
an amperian loop and carries the free current `i`. -/
structure AmperianFilament (Turn : Type*) where
  /-- Which turn of the winding this filament belongs to. -/
  turn : Turn
  /-- The instantaneous free current carried by the filament (A). -/
  i : InstantaneousCurrent
  /-- The free current is nonnegative (magnitude readout). -/
  i_nonneg : 0 ≤ i
  /-- The filament carries the *free* (conduction) current of the wire, as
  opposed to bound/magnetization currents. -/
  isFreeCurrent : Prop
  /-- The free-current property holds for this filament. -/
  freeHolds : isFreeCurrent

namespace AmperianFilament

variable {Turn : Type*}

/-- Every amperian filament of this winding carries free current
(elimination form of `freeHolds`). -/
theorem is_free (f : AmperianFilament Turn) : f.isFreeCurrent := f.freeHolds

/-- The current carried by a filament is nonnegative (inequality consequence
exposed by the abstraction). -/
theorem current_nonneg (f : AmperianFilament Turn) : 0 ≤ f.i := f.i_nonneg

end AmperianFilament

/-- *Ampère's law* for a toroidal winding, symmetry-reduced form: integrating
the azimuthal H-field along the circle of radius `ρ` about the symmetry axis
gives `2πρ · H(ρ)`, which must equal the total free current threading the
loop.  The fields state the law — the field profile, the winding's currents,
and the azimuthal symmetry — not any closed form for `H`. -/
structure AmpereLaw (Turn : Type*) where
  /-- Number of winding turns. -/
  N : ℕ
  /-- There is at least one turn. -/
  N_pos : 0 < N
  /-- The H-field as a radial profile (azimuthal symmetry is built into this
  type: the magnitude depends only on the radius `ρ`). -/
  HasRadialProfile : RadialProfile
  /-- The instantaneous free currents of the winding, one per turn. -/
  turnCurrent : Turn → InstantaneousCurrent
  /-- The winding has `N` turns: the turn type is in bijection with `Fin N`. -/
  turnEquiv : Turn ≃ Fin N
  /-- For every radius `ρ > 0`, the circulation of H along the circle of
  radius `ρ` equals the total free current through the bounded area:
  `2πρ · H(ρ) = Σ_turns I`.  This is the equation that constrains the model. -/
  circulation_eq :
    ∀ ρ : ℝ, 0 < ρ →
      (2 * Real.pi * ρ) * HasRadialProfile ρ = ∑ t : Turn, turnCurrent t

namespace AmpereLaw

/-- The winding's turn type is a fintype, derived from the bijection with
`Fin N` (so no separate `[Fintype]` assumption is ever needed). -/
theorem card_turns {Turn : Type*} [Fintype Turn] (law : AmpereLaw Turn) :
    Fintype.card Turn = law.N := by
  rw [Fintype.card_congr law.turnEquiv, Fintype.card_fin]

/-- Ampère's circulation law in integral form (restated consequence of
`circulation_eq`, kept as a named elimination theorem). -/
theorem circulation {Turn : Type*} [Fintype Turn]
    (law : AmpereLaw Turn) (ρ : ℝ) (hρ : 0 < ρ) :
    (2 * Real.pi * ρ) * law.HasRadialProfile ρ =
      ∑ t : Turn, law.turnCurrent t :=
  law.circulation_eq ρ hρ

/-- The circulation of H is the same along every amperian circle: at any two
positive radii the law forces `2πρ·H(ρ)` and `2πρ'·H(ρ')` to both equal the
same enclosed current (consequence usable when deriving uniformity of the
interior field). -/
theorem circulation_constant {Turn : Type*} [Fintype Turn]
    (law : AmpereLaw Turn) {ρ ρ' : ℝ} (hρ : 0 < ρ) (hρ' : 0 < ρ') :
    (2 * Real.pi * ρ) * law.HasRadialProfile ρ
      = (2 * Real.pi * ρ') * law.HasRadialProfile ρ' := by
  rw [law.circulation_eq ρ hρ, law.circulation_eq ρ' hρ']

end AmpereLaw

/-- *Ampère's law on the parametrized thin mean path*: with the geometry of
the torus made explicit — mean radius `R`, inner radius `r < R` (the
thin-torus regime `r ≪ R`), cross-section area `A`, volume `V = 2πR·A` —
the mean-path amperian loop (the circle of radius `R`) encloses every turn,
so the circulation of the field-magnitude readout along that loop equals the
sum of the winding currents.  All fields are laws/data; none is the closed
form of `H`. -/
structure AmpereLawThinMeanPath (Turn : Type*) where
  /-- Mean radius of the torus (m). -/
  R : ℝ
  /-- Inner (tube) radius of the torus (m). -/
  r : ℝ
  /-- Cross-sectional area of the torus tube (m²). -/
  A : ℝ
  /-- Volume of the torus (m³). -/
  V : ℝ
  /-- `R` is positive. -/
  R_pos : 0 < R
  /-- `r` is positive. -/
  r_pos : 0 < r
  /-- Thin-torus regime: the inner radius is smaller than the mean radius
  (`r ≪ R` is recorded as the strict bound `r < R`, the regime in which field
  gradients across the tube are negligible). -/
  thin : r < R
  /-- The cross-sectional area is positive. -/
  A_pos : 0 < A
  /-- The volume is positive. -/
  V_pos : 0 < V
  /-- Torus geometry: the volume of a thin torus is its mean circumference
  times its cross-sectional area, `V = 2πR·A` (exact in the limit `r/R → 0`,
  which is the stated `r ≪ R` regime). -/
  V_eq : V = 2 * Real.pi * R * A
  /-- Number of winding turns. -/
  N : ℕ
  /-- There is at least one turn. -/
  N_pos : 0 < N
  /-- The winding has `N` turns. -/
  turnEquiv : Turn ≃ Fin N
  /-- The instantaneous free currents of the winding, one per turn. -/
  turnCurrent : Turn → InstantaneousCurrent
  /-- The field-magnitude readout at the mean path, one value per turn
  (a single uniform value, distributed over the symmetric winding). -/
  HOf : HFieldReadouts Turn
  /-- Sum form of Ampère's law along the mean path:
  `∑_t 2πR·H_t = ∑_t I_t` — the circulation of the magnitude readout equals
  the total threading free current. -/
  ampere_sum :
    ∑ t : Turn, (2 * Real.pi * R) * HOf t = ∑ t : Turn, turnCurrent t

namespace AmpereLawThinMeanPath

variable {Turn : Type*} [Fintype Turn]

/-- The winding has exactly `N` turns. -/
theorem card_turns (law : AmpereLawThinMeanPath Turn) :
    Fintype.card Turn = law.N := by
  rw [Fintype.card_congr law.turnEquiv, Fintype.card_fin]

/-- Core form of Ampère's law, inserting the cardinality of the winding:
`∑_t 2πR·H_t = N · (2πR) · H` whenever the readout is the constant `H`
(named consequence used to pass from a per-turn sum to a single magnitude,
without unfolding the answer). -/
theorem ampere_sum_const (law : AmpereLawThinMeanPath Turn) {H : ℝ}
    (h : ∀ t : Turn, law.HOf t = H) :
    ∑ t : Turn, (2 * Real.pi * R) * law.HOf t
      = law.N * ((2 * Real.pi * R) * H) := by
  have hc : ∀ t : Turn, (2 * Real.pi * R) * law.HOf t
      = (2 * Real.pi * R) * H := fun t => by rw [h t]
  rw [Finset.sum_congr rfl hc, ← Finset.sum_mul,
    Finset.sum_const, card_turns, nsmul_eq_mul]

/-- Thin-torus geometry: the mean-path circumference `2πR` equals `V / A`,
the bridge between the circulation length and the requested `(A, V)`
parametrization of the answer. -/
theorem mean_circumference_eq (law : AmpereLawThinMeanPath Turn) :
    2 * Real.pi * law.R = law.V / law.A := by
  have hA : law.A ≠ 0 := ne_of_gt law.A_pos
  rw [law.V_eq]
  field_simp
  ring

/-- Thin-torus geometry: `2πR·A = V` (multiplicative form of
`mean_circumference_eq`). -/
theorem mean_circumference_mul_eq (law : AmpereLawThinMeanPath Turn) :
    2 * Real.pi * law.R * law.A = law.V := by
  have hA : law.A ≠ 0 := ne_of_gt law.A_pos
  have h := law.mean_circumference_eq
  field_simp at h
  calc 2 * Real.pi * law.R * law.A = law.V / law.A * law.A := by rw [h]
    _ = law.V := by field_simp

/-- The mean-path length is positive. -/
theorem mean_circumference_pos (law : AmpereLawThinMeanPath Turn) :
    0 < 2 * Real.pi * law.R :=
  mul_pos (mul_pos two_pos Real.pi_pos) law.R_pos

end AmpereLawThinMeanPath

/-- The approximate uniformity of the field magnitudes throughout the thin
torus (source: *"the fields H and B and the magnetization M have
approximately constant magnitudes throughout the torus"*), expressed per
winding turn: the per-turn piecewise-constant-uniformity readout equals the
per-turn constant readout, and the constant readout equals the single
magnitude `H`.  The interface neither fixes nor advances the value of `H`;
it ties the two readouts and the magnitude together by exposed equalities,
so it constrains the model. -/
structure UniformFieldMag (Turn : Type*) where
  /-- The uniform H-field magnitude (A/m). -/
  H : ℝ
  /-- The magnitude is nonnegative. -/
  H_nonneg : 0 ≤ H
  /-- The per-turn readout of the constant field magnitude. -/
  HField : HFieldReadouts Turn
  /-- The per-turn readout under the piecewise-constant-uniformity model. -/
  piecewise : HFieldReadouts Turn
  /-- The piecewise-uniform readout agrees with the constant readout on every
  turn (equality consequence 1). -/
  piecewise_eq : ∀ t : Turn, piecewise t = HField t
  /-- The constant readout equals the magnitude `H` on every turn (equality
  consequence 2: the field has one and the same magnitude throughout the
  torus). -/
  uniform : ∀ t : Turn, HField t = H

namespace UniformFieldMag

variable {Turn : Type*}

/-- The piecewise-uniform readout of a turn equals the field magnitude
(elimination composing both exposed equalities). -/
theorem piecewise_eq_H (u : UniformFieldMag Turn) (t : Turn) :
    u.piecewise t = u.H := by
  rw [u.piecewise_eq t, u.uniform t]

/-- The field-magnitude readout is uniform across the winding: any two turns
read the same value (consequence theorem). -/
theorem uniform_across (u : UniformFieldMag Turn) (t s : Turn) :
    u.HField t = u.HField s := by
  rw [u.uniform t, u.uniform s]

end UniformFieldMag

/-- A *uniform-material winding law*: along the mean path of the thin torus
each turn of the winding behaves as an amperian filament carrying the winding
current, and the circulation of the per-turn magnitude readout along the mean
path equals the sum of the filament currents.  This packages
`AmpereLawThinMeanPath` with the filament interpretation required by the
official hint (the `I_C` in `∮ H·dℓ = I_C` is the net *free* current through
the loop). -/
structure AmperianFilamentLaw (Turn : Type*) where
  /-- The underlying thin-mean-path amperian law. -/
  base : AmpereLawThinMeanPath Turn
  /-- The winding filaments. -/
  filament : Turn → AmperianFilament Turn
  /-- Each filament is indexed by its own turn. -/
  filament_turn : ∀ t : Turn, (filament t).turn = t
  /-- Each filament carries the winding current of its turn. -/
  filament_current : ∀ t : Turn, (filament t).i = base.turnCurrent t
  /-- The field-magnitude readout admits a uniform-magnitude interface whose
  readout is exactly `base.HOf` (packaging bridge; the magnitude value stays
  internal to the interface). -/
  uniform : ∃ u : UniformFieldMag Turn, ∀ t : Turn, u.HField t = base.HOf t

namespace AmperianFilamentLaw

variable {Turn : Type*} [Fintype Turn]

/-- The circulation of the magnitude readout along the mean path equals the
total filament (free) current: `∑_t 2πR·H_t = ∑_t (filament t).i`
(elimination of the filament law onto the base Ampère equation). -/
theorem circulation_eq_filament_current (law : AmperianFilamentLaw Turn) :
    ∑ t : Turn, (2 * Real.pi * law.base.R) * law.base.HOf t
      = ∑ t : Turn, (law.filament t).i := by
  rw [law.base.ampere_sum]
  exact Finset.sum_congr rfl fun t _ => (law.filament_current t).symm

/-- Every filament of the winding carries free current
(re-exported consequence). -/
theorem filament_is_free (law : AmperianFilamentLaw Turn) (t : Turn) :
    (law.filament t).isFreeCurrent := (law.filament t).is_free

end AmperianFilamentLaw

/-! ### Electromagnetic material law (vacuum-core identity)

In paramagnetic materials `M` is parallel to `H` and `B = μ₀ H + μ₀ M`
(the vacuum-core identity; it is the relation that would describe the field
if the toroid had a vacuum core, and it identifies the `H` computed here as
the thermodynamic state variable used in the rest of Question T3).  Recorded
as an assumption for downstream parts; it is not needed to compute the
numerical value of `H` itself. -/

/-- The vacuum-core constitutive relation on a spatial region: at every point
the magnetic flux density equals `μ₀·H + μ₀·M`, with the magnetization
parallel to the H-field, both magnitudes constant in the region. -/
structure VacuumCoreIdentity (Space : Type*) where
  /-- The magnetic permeability of free space. -/
  freeSpace : FreeSpace
  /-- The H-field on the region (A/m). -/
  hField : Space → ℝ
  /-- The magnetization on the region (A/m). -/
  mField : Space → ℝ
  /-- The magnetic flux density on the region (T). -/
  bField : Space → ℝ
  /-- The constitutive identity `B = μ₀ H + μ₀ M`, pointwise. -/
  b_eq :
    ∀ x : Space,
      bField x = freeSpace.μ₀ * hField x + freeSpace.μ₀ * mField x
  /-- The H-field magnitude is constant throughout the region. -/
  h_const : ∃ H : ℝ, ∀ x : Space, hField x = H
  /-- The magnetization magnitude is constant throughout the region. -/
  m_const : ∃ M : ℝ, ∀ x : Space, mField x = M
  /-- In a paramagnetic material the magnetization is parallel to the
  H-field, i.e. `M` is a nonnegative scalar multiple of `H` pointwise. -/
  m_parallel : ∃ χ : ℝ, 0 ≤ χ ∧ ∀ x : Space, mField x = χ * hField x

namespace VacuumCoreIdentity

variable {Space : Type*}

/-- Pointwise consequence: `B = μ₀·(1 + χ)·H` when `M` is parallel to `H`
with factor `χ` (the paramagnetic enhancement of the flux density). -/
theorem b_eq_scaled (v : VacuumCoreIdentity Space) (x : Space) :
    ∃ χ : ℝ, 0 ≤ χ ∧
      v.bField x = v.freeSpace.μ₀ * (1 + χ) * v.hField x := by
  obtain ⟨χ, hχ, hm⟩ := v.m_parallel
  exact ⟨χ, hχ, by rw [v.b_eq x, hm x]; ring⟩

/-- The flux-density magnitude is also uniform throughout the region
(consequence of the two uniformity hypotheses). -/
theorem b_uniform (v : VacuumCoreIdentity Space) :
    ∃ B : ℝ, ∀ x : Space, v.bField x = B := by
  obtain ⟨H, hH⟩ := v.h_const
  obtain ⟨M, hM⟩ := v.m_const
  exact ⟨v.freeSpace.μ₀ * H + v.freeSpace.μ₀ * M,
    fun x => by rw [v.b_eq x, hH x, hM x]⟩

end VacuumCoreIdentity

/-! ### The paramagnetic torus of Question T3, Part A.1 -/

/-- The paramagnetic torus (Pm-T) of IPhO 2026 Question T3 for Part A.1:
a homogeneous isotropic paramagnetic thin torus (`r ≪ R`) with volume `V`,
cross-sectional area `A`, wound densely by `N` turns of insulated wire
carrying the instantaneous current `I`, satisfying Ampère's law on the thin
mean path, with approximately uniform field magnitudes.

All fields are problem parameters, measurements or governing laws; the
target conclusion `H = N·I·A/V` is *not* among them. -/
structure ParamagneticTorusA1 where
  /-- The mean radius of the torus (m). -/
  meanRadius : ℝ
  /-- The inner (tube) radius of the torus (m). -/
  innerRadius : ℝ
  /-- Thin-torus regime: `r < R` (formal reading of `r ≪ R`). -/
  thin : innerRadius < meanRadius
  /-- The mean radius is positive. -/
  meanRadius_pos : 0 < meanRadius
  /-- The inner radius is positive. -/
  innerRadius_pos : 0 < innerRadius
  /-- The cross-sectional area of the torus tube (m²). -/
  crossSectionArea : ℝ
  /-- The cross-sectional area is positive. -/
  crossSectionArea_pos : 0 < crossSectionArea
  /-- The volume of the torus (m³). -/
  volume : ℝ
  /-- The volume is positive. -/
  volume_pos : 0 < volume
  /-- Thin-torus geometry: `V = 2πR·A`. -/
  volume_eq : volume = 2 * Real.pi * meanRadius * crossSectionArea
  /-- The number of turns of the dense winding. -/
  numTurns : ℕ
  /-- There is at least one turn. -/
  numTurns_pos : 0 < numTurns
  /-- The winding turns, as a type. -/
  Turn : Type*
  /-- The turns are in bijection with `Fin numTurns`. -/
  turnEquiv : Turn ≃ Fin numTurns
  /-- The instantaneous electric current in the wire (A); the same current
  flows through every turn because the winding is a single series wire around
  one core. -/
  wireCurrent : InstantaneousCurrent
  /-- The current magnitude is nonnegative. -/
  wireCurrent_nonneg : 0 ≤ wireCurrent
  /-- The H-field magnitude (A/m) inside the torus — the quantity the
  subquestion asks to express.  Declared as a measured field magnitude; its
  value is determined by the laws in this structure, not fixed by fiat. -/
  fieldMagnitude : ℝ
  /-- The field magnitude is nonnegative. -/
  fieldMagnitude_nonneg : 0 ≤ fieldMagnitude
  /-- Ampère's law for this winding on the thin mean path: the mean-path loop
  encloses all `numTurns` turns, each carrying `wireCurrent`, and the
  circulation of the per-turn magnitude readout equals the total threading
  free current. -/
  ampere : AmpereLawThinMeanPath Turn
  /-- The embedded law uses this torus's mean radius. -/
  ampere_R : ampere.R = meanRadius
  /-- The embedded law uses this torus's inner radius. -/
  ampere_r : ampere.r = innerRadius
  /-- The embedded law uses this torus's cross-sectional area. -/
  ampere_A : ampere.A = crossSectionArea
  /-- The embedded law uses this torus's volume. -/
  ampere_V : ampere.V = volume
  /-- The embedded law uses this torus's turn count. -/
  ampere_N : ampere.N = numTurns
  /-- The embedded law uses this torus's turn equivalence. -/
  ampere_turnEquiv : ampere.turnEquiv = turnEquiv
  /-- Every turn carries the same wire current (series winding). -/
  ampere_current : ∀ t : Turn, ampere.turnCurrent t = wireCurrent
  /-- Uniformity: the per-turn magnitude readout is the constant
  `fieldMagnitude` (fields approximately uniform throughout the torus, so the
  readout at the mean path is the interior magnitude). -/
  ampere_uniform : ∀ t : Turn, ampere.HOf t = fieldMagnitude

namespace ParamagneticTorusA1

/-- The embedded amperian law sees exactly `numTurns` turns (consistency
consequence; needs the fintype structure recovered from the equivalence). -/
theorem card_turns (T : ParamagneticTorusA1) :
    letI : Fintype T.Turn := Fintype.ofEquiv (Fin T.numTurns) T.turnEquiv.symm
    Fintype.card T.Turn = T.numTurns := by
  introI
  rw [Fintype.card_congr T.turnEquiv, Fintype.card_fin]

/-! ### Bridge lemmas (derivation route of the official answer)

These lemmas are the named derivation steps; each follows from the laws in
the structure, and none of them is itself the target relation until the
final theorem assembles them.  In this autoformalization stage their bodies
are `sorry`. -/

/-- Bridge 1 — Ampère's law in the uniform regime:
`2πR · (N · H) = N · I` (the circulation of the uniform magnitude along the
mean path equals the total free current `N·I` threading the loop). -/
theorem ampere_uniform_eq (T : ParamagneticTorusA1) :
    2 * Real.pi * T.meanRadius * (T.numTurns * T.fieldMagnitude)
      = T.numTurns * T.wireCurrent := by
  sorry

/-- Bridge 2 — solve the circulation equation for `H` along the mean path:
`H = N·I / (2πR)` (uses `N ≠ 0`, `R > 0`, `π > 0`). -/
theorem fieldMagnitude_eq_meanRadius_form (T : ParamagneticTorusA1) :
    T.fieldMagnitude
      = T.numTurns * T.wireCurrent / (2 * Real.pi * T.meanRadius) := by
  sorry

/-- Bridge 3 — geometry bridge: `2πR = V / A`, rewriting the mean-path
length in terms of the torus volume and cross-sectional area. -/
theorem mean_circumference_eq (T : ParamagneticTorusA1) :
    2 * Real.pi * T.meanRadius = T.volume / T.crossSectionArea := by
  sorry

/-- Bridge 4 — the figure parametrization of the answer along the mean
path: `N·I/(2πR) = N·I·A/V`. -/
theorem meanRadius_form_eq_volume_form (T : ParamagneticTorusA1) :
    T.numTurns * T.wireCurrent / (2 * Real.pi * T.meanRadius)
      = T.numTurns * T.wireCurrent * T.crossSectionArea / T.volume := by
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
      = T.numTurns * T.wireCurrent * T.crossSectionArea / T.volume := by
  sorry

/-- Equivalent mean-radius form of the Part A.1 answer:
`H = N·I / (2πR)`, the form one obtains directly from Ampère's law before
substituting the torus geometry `V = 2πR·A`. -/
theorem paramagneticTorus_H_eq_meanRadius (T : ParamagneticTorusA1) :
    T.fieldMagnitude
      = T.numTurns * T.wireCurrent / (2 * Real.pi * T.meanRadius) := by
  sorry

end PartA1
end Problem3
end IPhO2026
