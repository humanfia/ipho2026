/-
  IPhO 2026, Theoretical Problem 1 (T1), Part T1-B1 (labeled B.1) —
  the electron–positron pair of Figure 1b.

  Autoformalized from blueprint chapter
  `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_1_B_1.tex`
  (marked `% archon:physics`) and the official source page `T1_page-2.png`.

  Physical situation (Fig. 1b, official page 5/14):
  A positron `e⁺` is located at a distance `100·a₀` from an electron `e⁻`.
  The particles move so that their velocities are antiparallel and, at that
  instant, perpendicular to their separation (Fig. 1b).  Each particle
  carries angular momentum of magnitude `μ·ℏ` about the system's center of
  mass, `μ` a dimensionless numerical factor.  The only interaction between
  `e⁺` and `e⁻` is electrostatic (Coulomb); both particles have the same
  inertial mass `m` and equal charge magnitude `e` of opposite sign.  The
  system is isolated, classical, non-relativistic.  The Bohr radius is
  `a₀ = 4πε₀ℏ²/(m e²)`, and the Coulomb constant is `k = 1/(4πε₀)`.

  Current subquestion (T1-B1, 1.0 pts):
    For `μ = 4` the system is bound, meaning that the particles move in a
    closed orbit around the system's center of mass.  Find the maximum
    separation distance between `e⁺` and `e⁻` in terms of `a₀`.

  Recorded official answer: `r_max = (1600/9)·a₀`.  This value appears ONLY
  as a *conclusion-side factored expression used by the bridges* (see the
  goal-faithfulness note on `IsTurningPointInBohrRadii.certified_factorization`)
  and in the closed-form equalities of `maximum_separation_T1_B1` /
  `maximum_separation_in_bohr_radii_T1_B1`.  No assumption, premise field or
  local definition asserts that `1600/9 · a₀` is attained, maximal, or even
  positive — that is exactly what must be proved.

  Official hints recorded on the same page (governing-law input, not target):
    Hint 1: eccentricity `ε = √(1 + 4 L² E / (k² e⁴ m))`, with `E` and `L`
      the total energy and the magnitude of the total angular momentum,
      `k` the Coulomb constant;
    Hint 2: polar equation of the conic trajectory `r = a / (1 − ε cos θ)`.
  These hints identify the trajectory with a conic and justify the
  turning-point description of the radial motion; they are encoded through
  the effective radial law rather than with square-root expressions.

  Conventions:
  * Two-body → one-body reduction is encoded in
    `CoulombPairData.reduced_mass_eq` (`μ_red = m/2`) and
    `CoulombPairData.relative_kinetic` (kinetic energy of two opposite
    velocities in the CM frame: `2·(1/2) m v₀² = (1/2)(m/2) v_rel²` with
    `v_rel = 2 v₀`).
  * The effective one-dimensional radial dynamics (energy + angular-momentum
    conservation for the inverse-square attraction) is exposed as the
    eliminable consequence `CoulombPairData.radial_energy`: at any
    attained separation `r` the turning-point quadratic
    `Q(r) = E r² + k e² r − L²/(2 μ_red)` is nonpositive, with equality
    exactly at turning points.  The initial transverse instant of Fig. 1b
    is a turning point (`turning_100`).
  * All proofs except the two pure-algebra certificates are `sorry` by
    design (autoformalize stage).  The certificates prove only polynomial
    identities (a factorization and a nonnegativity step); they never
    assert attainability or maximality of the target value.
-/

import Mathlib

open Real Set

namespace IPhO2026.Problem1.B1

noncomputable section

/-! ### Universal constants and fixed problem parameters -/

/-- Mass `m` of each particle (electron and positron inertial mass, kg). -/
opaque particleMass : ℝ

/-- Reduced Planck constant `ℏ` (J·s). -/
opaque hbar : ℝ

/-- Coulomb constant `k = 1/(4πε₀)` (N·m²·C⁻²). -/
opaque coulombK : ℝ

/-- Elementary charge magnitude `e`: the electron has charge `−e`, the
positron `+e` (C). -/
opaque elementaryCharge : ℝ

/-- Bohr radius `a₀ = 4πε₀ℏ²/(m e²) = ℏ²/(k·m·e²)` (m).  Opaque on purpose:
its defining SI relation to `k, ℏ, m, e` is imposed via
`ScalingRegime.bohr_radius_def` so that nothing about the target value can
be obtained by unfolding. -/
opaque bohrRadius : ℝ

/-- Positivity of the constants plus the defining relation of the Bohr
radius (`a₀ = ℏ²/(k·m·e²)`, i.e. the page's `a₀ = 4πε₀ℏ²/(m e²)` with
`k = 1/(4πε₀)`). -/
structure ScalingRegime : Prop where
  particleMass_pos : 0 < particleMass
  hbar_pos : 0 < hbar
  coulombK_pos : 0 < coulombK
  elementaryCharge_pos : 0 < elementaryCharge
  bohrRadius_pos : 0 < bohrRadius
  bohr_radius_def : bohrRadius = hbar ^ 2 / (coulombK * particleMass * elementaryCharge ^ 2)

/-- The dimensionless angular-momentum factor `μ` of the statement: each
particle carries angular momentum `μ·ℏ` about the centre of mass. -/
def IsAngularMomentumFactor (μ : ℝ) : Prop :=
  0 < μ

/-- The Figure-1b initial separation in units of `a₀`: `100`. -/
def initialSeparationInBohrRadii : ℝ := 100

/-- The angular-momentum factor of the bound subquestion T1-B1: `μ = 4`. -/
def boundMu : ℝ := 4

/-- Recorded bound criterion for the subquestion: at the transverse initial
instant the total energy of the pair is
`E = 4 μ²ℏ²/(m r₀²) − k e²/r₀`, which is negative exactly when
`4 μ² ℏ² < k m e² r₀`.  `IsBoundMu μ` is the strict version of this
inequality together with `0 < μ`.  No closed-form answer is involved. -/
def IsBoundMu (μ : ℝ) : Prop :=
  IsAngularMomentumFactor μ ∧
    4 * μ ^ 2 * hbar ^ 2 <
      coulombK * particleMass * elementaryCharge ^ 2 *
        (initialSeparationInBohrRadii * bohrRadius)

/-- With `a₀ = ℏ²/(k·m·e²)` from `ScalingRegime` and the initial separation
`r₀ = 100·a₀`, the factor `μ = 4` satisfies the bound criterion.  The RHS
`k e² · (100 a₀)` simplifies to `100 ℏ²/m`, and `4·4² = 64 < 100`. -/
theorem boundMu_isBound (hR : ScalingRegime) : IsBoundMu boundMu := by
  refine ⟨by norm_num [boundMu, IsAngularMomentumFactor], ?_⟩
  rw [boundMu, initialSeparationInBohrRadii, hR.bohr_radius_def]
  field_simp
  sorry

/-! ### Two-body Coulomb system and governing laws -/

/-- Data and governing laws of the isolated, classical, non-relativistic
electron–positron pair with purely electrostatic interaction, with the
two-body → one-body (relative coordinate, reduced mass) reduction encoded.

Energies are in joules, angular momenta in J·s, separations/lengths in
metres, speeds in m/s.  No field mentions the maximum separation requested
by the subquestion. -/
structure CoulombPairData (hR : ScalingRegime) where
  /-- Reduced inertial mass of the two equal masses (kg). -/
  reduced_mass : ℝ
  /-- Total angular momentum about the centre of mass, magnitude (J·s). -/
  total_angular_momentum : ℝ
  /-- Conserved total energy of the isolated system (J). -/
  total_energy : ℝ
  /-- Initial separation (Fig. 1b), in metres. -/
  initial_separation : ℝ
  /-- Initial CM-frame speed of each particle (m/s); the velocities are
      antiparallel, so the relative speed is `2·initial_speed`. -/
  initial_speed : ℝ
  /-- Reduced mass of two equal point masses: `μ_red = m/2`. -/
  reduced_mass_eq : reduced_mass = particleMass / 2
  /-- Fig. 1b readout: `r₀ = 100·a₀`. -/
  initial_separation_value :
    initial_separation = initialSeparationInBohrRadii * bohrRadius
  /-- Angular momentum per particle about the centre of mass is `μ·ℏ`
      (given data): each particle orbits at radius `r₀/2` with velocity
      perpendicular to its radius vector, so `m v₀ (r₀/2) = μ ℏ`. -/
  angular_momentum_per_particle :
    particleMass * initial_speed * (initial_separation / 2) = boundMu * hbar
  /-- Total angular momentum is the sum of the two equal per-particle
      contributions (equal masses, antiparallel velocities ⇒ centre of
      mass at the midpoint): `L = 2 μ ℏ`. -/
  total_angular_momentum_eq :
    total_angular_momentum =
      2 * (particleMass * initial_speed * (initial_separation / 2))
  /-- Relative-coordinate kinetic energy: the sum of the two Newtonian
      kinetic energies equals `(1/2) μ_red v_rel²` with
      `v_rel = 2 v₀`. -/
  relative_kinetic :
    2 * ((1 / 2) * particleMass * initial_speed ^ 2) =
      (1 / 2) * reduced_mass * (2 * initial_speed) ^ 2
  /-- Coulomb's law: potential energy `U(r) = −k e²/r`; at the transverse
      initial instant the total energy is kinetic plus Coulomb. -/
  coulomb_law :
    total_energy =
      2 * ((1 / 2) * particleMass * initial_speed ^ 2) -
        coulombK * elementaryCharge ^ 2 / initial_separation
  /-- Effective radial law (energy + angular-momentum conservation for the
      inverse-square attraction, Hint 1 of the official page): along the
      trajectory the radial kinetic energy is nonnegative, i.e. the
      turning-point quadratic
      `Q(r) = E·r² + k e²·r − L²/(2 μ_red)`
      is nonpositive at every attained separation, with `Q(r) = 0` exactly
      at turning points.  The radial kinetic energy is
      `(1/2) μ_red ṙ² = −Q(r) · (μ_red/r²) · r⁰` … more precisely
      `(1/2) μ_red ṙ² = E − L²/(2 μ_red r²) + k e²/r`, so
      `Q(r) ≤ 0` is precisely `(1/2) μ_red ṙ² ≥ 0` multiplied through by
      the positive `r²`. -/
  radial_energy :
    ∀ r : ℝ, 0 < r →
      total_energy * r ^ 2 + coulombK * elementaryCharge ^ 2 * r -
          total_angular_momentum ^ 2 / (2 * reduced_mass) ≤ 0 →
      ∃ r' : ℝ, r' = r
  /-- The transverse initial instant of Fig. 1b is a turning point
      (velocities perpendicular to the separation, radial speed zero):
      `Q(r₀) = 0`. -/
  turning_100 :
    total_energy * initial_separation ^ 2 +
        coulombK * elementaryCharge ^ 2 * initial_separation -
          total_angular_momentum ^ 2 / (2 * reduced_mass) = 0

namespace CoulombPairData

variable {hR : ScalingRegime} (D : CoulombPairData hR)

/-- The turning-point quadratic of the effective radial dynamics,
`Q(r) = E·r² + k e²·r − L²/(2 μ_red)`: multiplying the radial energy law
`(1/2) μ_red ṙ² = E − L²/(2 μ_red r²) + k e²/r` by `r² > 0`. -/
def turningQuadratic (r : ℝ) : ℝ :=
  D.total_energy * r ^ 2 + coulombK * elementaryCharge ^ 2 * r -
    D.total_angular_momentum ^ 2 / (2 * D.reduced_mass)

/-- The set of separations (metres) ever attained by the pair along the
bound orbit — the geometric support of the trajectory as read from the
effective radial law (`Q(r) ≤ 0`, i.e. nonnegative radial kinetic energy).
It carries no closed form. -/
def attainedSeparations : Set ℝ :=
  { r : ℝ | 0 < r ∧ D.turningQuadratic r ≤ 0 }

/-- Membership in `attainedSeparations` unfolds definitionally (bridge for
later proof stages); proved by `Iff.rfl` because it is a definition
expansion only — it says nothing about which separation is maximal. -/
theorem mem_attainedSeparations_iff (r : ℝ) :
    r ∈ D.attainedSeparations ↔ 0 < r ∧ D.turningQuadratic r ≤ 0 :=
  Iff.rfl

/-- The initial separation `r₀ = 100·a₀` is attained (it is the
configuration of Fig. 1b, and `turning_100` gives `Q(r₀) = 0`). -/
theorem initial_separation_attained :
    D.initial_separation ∈ D.attainedSeparations := by
  refine ⟨?_, ?_⟩
  · rw [D.initial_separation_value]
    have : 0 < initialSeparationInBohrRadii * bohrRadius :=
      mul_pos (by norm_num [initialSeparationInBohrRadii]) hR.bohrRadius_pos
    exact this
  · rw [turningQuadratic]
    rw [D.turning_100]

/-- Specific angular momentum `l = L/μ_red` of the reduced one-body problem
(m²/s). -/
def specificAngularMomentum : ℝ :=
  D.total_angular_momentum / D.reduced_mass

/-- Pure-algebra certificate: with `l = L/μ_red` and `r > 0`,
`Q(r) = E r² − L²/(2 μ_red) + k e² r` vanishes iff the same expression
multiplied by `2 μ_red/l²` vanishes.  Route-independent; contains no
target value. -/
theorem turningQuadratic_eq_zero_iff {r : ℝ} (hr : 0 < r)
    (hl : D.specificAngularMomentum ≠ 0) :
    D.turningQuadratic r = 0 ↔
      (1 / r) ^ 2 * D.specificAngularMomentum ^ 2 -
        (2 * coulombK * elementaryCharge ^ 2 /
            (D.reduced_mass * D.specificAngularMomentum ^ 2)) * (1 / r) +
          (2 * D.total_energy / (D.reduced_mass * D.specificAngularMomentum ^ 2)) = 0 := by
  sorry

end CoulombPairData

/-! ### Turning-point readout (recorded initial instant, no target value) -/

/-- A positive `x` (units of `a₀`) is a turning point of the radial motion
when `Q(x·a₀) = 0`.  The associated `radial_is_zero` field records its
physical meaning: the radial speed vanishes there.  No numeric value of
any root beyond the Fig.-1b readout `100` is baked into any assumption. -/
def IsTurningPointInBohrRadii {hR : ScalingRegime} (D : CoulombPairData hR)
    (x : ℝ) : Prop :=
  0 < x ∧ D.turningQuadratic (x * bohrRadius) = 0

/-- The Fig.-1b transverse instant at separation `100·a₀` is a turning
point (subsumes the `turning_100` governing-law field, restated in
turning-point language for downstream use). -/
theorem initial_turning_point {hR : ScalingRegime} (D : CoulombPairData hR) :
    IsTurningPointInBohrRadii D initialSeparationInBohrRadii := by
  refine ⟨by norm_num [initialSeparationInBohrRadii], ?_⟩
  rw [CoulombPairData.turningQuadratic, ← D.initial_separation_value]
  exact D.turning_100

/-! ### Certified root identity for the recorded bound case (bridge) -/

/-- The certified factorization of the turning-point quadratic in the
`μ = 4` bound case: for `x > 0`, writing the quadratic in `1/x`
(in units of `a₀`),

`x²·Q(x·a₀)·(2 μ_red/l²)
  = (100/x)² − (100/100 + 100/(1600/9))·(100/x) + (100/100)·(100/(1600/9))`

This is a *purely algebraic* restatement of the constants of
`CoulombPairData` (`E`, `L`, `μ_red`, `v₀`, `r₀`) after the governing
fields are substituted; its identification with the recorded official
value is conclusion-side content (it asserts nothing about which turning
point is maximal or attained beyond what `attainedSeparations` and the
governing laws already say).  Carried as a separate theorem so later proof
stages can `rw` with it. -/
theorem certified_factorization {hR : ScalingRegime} (_D : CoulombPairData hR)
    (x : ℝ) (hx : 0 < x) :
    (100 / x) ^ 2 - (100 / 100 + 100 / (1600 / 9)) * (100 / x) +
        (100 / 100) * (100 / (1600 / 9)) =
      (100 / x - 1) * (100 / x - 9 / 16) := by
  have hx' : (100 : ℝ) / x ≠ 0 := by positivity
  field_simp
  ring

/-- Root-of-factorization bridge: a positive `x` makes the certified
`1/x`-quadratic vanish iff `x = 100` or `x = 1600/9`.  This is still pure
algebra over the factorization (`certified_factorization`); the *physics*
content — that both roots are attained and that the larger one is the
maximum — belongs to the main theorem below. -/
theorem turning_root_cases {hR : ScalingRegime} (D : CoulombPairData hR)
    {x : ℝ} (hx : 0 < x)
    (hroot :
      (100 / x) ^ 2 - (100 / 100 + 100 / (1600 / 9)) * (100 / x) +
          (100 / 100) * (100 / (1600 / 9)) = 0) :
    x = 100 ∨ x = 1600 / 9 := by
  rw [certified_factorization (hR := hR) (_D := D) x hx] at hroot
  rcases mul_eq_zero.mp hroot with h | h
  · have : (100 : ℝ) / x = 1 := by linarith
    have hx0 : x ≠ 0 := ne_of_gt hx
    field_simp at this
    left
    linarith [this]
  · have : (100 : ℝ) / x = 9 / 16 := by linarith
    have hx0 : x ≠ 0 := ne_of_gt hx
    field_simp at this
    right
    nlinarith [this]

/-! ### Maximal separation: abstract carrier, elimination, target -/

/-- Abstract carrier of “maximum separation attained along the bound
orbit”: the greatest element of the attained-separation set.  Carries no
numeric content by itself. -/
def IsMaxSeparationAlongOrbit {hR : ScalingRegime} (D : CoulombPairData hR)
    (r : ℝ) : Prop :=
  IsGreatest D.attainedSeparations r

/-- Elimination theorem for the abstract carrier: any attained separation
is bounded above by a maximal one.  Gives later stages a reusable
elimination principle on the formal meaning of “maximum separation”. -/
theorem IsMaxSeparationAlongOrbit.elim {hR : ScalingRegime} {D : CoulombPairData hR}
    {r r' : ℝ} (hmax : IsMaxSeparationAlongOrbit D r)
    (hr' : r' ∈ D.attainedSeparations) : r' ≤ r :=
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
