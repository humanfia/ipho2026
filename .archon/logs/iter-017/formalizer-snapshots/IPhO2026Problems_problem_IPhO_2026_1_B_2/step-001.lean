/-
  IPhO 2026, Theoretical Problem 1 (T1), Part T1-B2 (labeled B.2) —
  the unbound electron–positron pair of Figure 1b: asymptotic relative
  velocity and signed deflection angle.

  Autoformalized from blueprint chapter
  `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_1_B_2.tex`
  (marked `% archon:physics`) and the official source page `T1_page-2.png`.

  Physical situation (Fig. 1b, official page 5/14 — same setting as B.1):
  A positron `e+` is located at a distance `100 * a0` from an electron `e-`.
  The particles move so that their velocities are antiparallel and, at that
  instant, perpendicular to their separation (Fig. 1b).  Each particle
  carries angular momentum of magnitude `mu * hbar` about the system's
  center of mass, `mu` a dimensionless numerical factor.  The only
  interaction between `e+` and `e-` is electrostatic (Coulomb); both
  particles have the same inertial mass `m` and equal charge magnitude `e`
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
  field, or local definition mentions `16.60`, the exact value
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
    none of them asserts any deflection-angle value.
  * The orientation convention for the signed answer: choosing the
    Fig.-1b frame with positive signed bracket
    `perp sep0 v0 > 0` (positron above the line connecting the pair,
    moving left, so the polar angle increases), the attraction bends
    the trajectory toward the line connecting the pair and
    `perp (initialDirection) u_inf < 0` — the clockwise case of
    `signedDeflection`, i.e. the official “16.60 degrees BELOW the
    initial line of motion”.
-/

import Mathlib

/- USER: This target received an explicit additional Review budget after the
first three formalization attempts.  Preserve the corrected physical chain
`eps^2 = 49/4` and signed deflection `-arctan (2 / sqrt 45)`; do not restore
the refuted `67/4`, `sqrt 63`, or approximately `-151.71` degree contract.
Concentrate the redraft/proof effort on the Kepler/Binet and limiting-velocity
bridges `orbit_eq_conic`, `exists_asymptoticRelativeVelocity`, and
`signed_deflection_eq_formula`. -/

open Real Set Filter

namespace IPhO2026.Problem1.B2

noncomputable section

/-! ### Planar vectors: dot product and perpendicular bracket -/

/-- The scattering plane (CM frame): `R^2` with its standard inner product. -/
abbrev Plane := EuclideanSpace ℝ (Fin 2)

/-- Dot product of two planar vectors. -/
def dot (v w : Plane) : ℝ := v 0 * w 0 + v 1 * w 1

/-- Planar perpendicular bracket `perp v w = v_x w_y - v_y w_x`: the signed
z-component of the 2D cross product.  Positive when `w` is reached from `v`
by a counterclockwise rotation of less than 180 degrees.  Used to express
angular momentum and the side (branch/orientation) of the deflection. -/
def perp (v w : Plane) : ℝ := v 0 * w 1 - v 1 * w 0

/-! ### Universal constants and fixed problem parameters -/

/-- Mass `m` of each particle (electron and positron inertial mass, kg). -/
opaque particleMass : ℝ

/-- Reduced Planck constant `ℏ` (J·s). -/
opaque hbar : ℝ

/-- Coulomb constant `k = 1/(4 pi eps0)` (N·m²·C⁻²). -/
opaque coulombK : ℝ

/-- Elementary charge magnitude `e`: the electron has charge `-e`, the
positron `+e` (C). -/
opaque elementaryCharge : ℝ

/-- Bohr radius `a0 = 4 pi eps0 ℏ²/(m e²) = ℏ²/(k·m·e²)` (m).  Opaque on
purpose: its defining SI relation to `k, ℏ, m, e` is imposed via
`ScalingRegime.bohr_radius_def` so that nothing about the target value
can be obtained by unfolding. -/
opaque bohrRadius : ℝ

/-- Positivity of the constants plus the defining relation of the Bohr
radius (`a0 = ℏ²/(k·m·e²)`, i.e. the page's `a0 = 4 pi eps0 ℏ²/(m e²)`
with `k = 1/(4 pi eps0)`). -/
structure ScalingRegime : Prop where
  particleMass_pos : 0 < particleMass
  hbar_pos : 0 < hbar
  coulombK_pos : 0 < coulombK
  elementaryCharge_pos : 0 < elementaryCharge
  bohrRadius_pos : 0 < bohrRadius
  bohr_radius_def : bohrRadius = hbar ^ 2 / (coulombK * particleMass * elementaryCharge ^ 2)

/-- The dimensionless angular-momentum factor `mu` of the statement: each
particle carries angular momentum `mu * ℏ` about the centre of mass. -/
def IsAngularMomentumFactor (μ : ℝ) : Prop :=
  0 < μ

/-- The value `mu = 15/2` of subquestion B.2 (unbound case). -/
def unboundMu : ℝ := 15 / 2

/-- `15/2` is a valid angular-momentum factor. -/
theorem unboundMu_isAngularMomentumFactor : IsAngularMomentumFactor unboundMu := by
  norm_num [unboundMu, IsAngularMomentumFactor]

/-! ### Two-body Coulomb scattering data and governing laws -/

/-- Data and governing laws of the isolated, classical, non-relativistic
electron–positron pair with purely electrostatic interaction, with the
two-body -> one-body (relative coordinate, reduced mass) reduction encoded.

`sep t` is the relative coordinate `r_e+(t) - r_e-(t)` in the centre-of-mass
plane (metres).  Energies are in joules, angular momenta in J·s, speeds in
m/s.  No field mentions the asymptotic velocity or any deflection angle:
those are conclusion-side concepts defined after this structure. -/
structure CoulombScatteringData (hR : ScalingRegime) where
  /-- Relative position `r_e+(t) - r_e-(t)` in the CM frame (m). -/
  sep : ℝ → Plane
  /-- Initial relative position at the recorded instant `t = 0` (m). -/
  sep0 : Plane
  /-- Initial CM-frame velocity of the positron (m/s); the electron's is
  `-v0` (equal masses, antiparallel velocities, CM at rest). -/
  v0 : Plane
  /-- A continuous polar angle of the relative coordinate (rad). -/
  polar_angle : ℝ → ℝ
  /-- Reduced inertial mass of the two equal masses (kg). -/
  reduced_mass : ℝ
  /-- Total angular momentum about the centre of mass, magnitude (J·s). -/
  total_angular_momentum : ℝ
  /-- Conserved total energy of the isolated system (J). -/
  total_energy : ℝ
  /-- Initial separation (Fig. 1b readout), in metres. -/
  initial_separation : ℝ
  /-- Initial CM-frame speed of each particle (m/s); the velocities are
  antiparallel, so the relative speed is `2 * initial_speed`. -/
  initial_speed : ℝ
  /-- The pair is never at zero separation (attractive Coulomb scattering
  with nonzero angular momentum). -/
  sep_ne_zero : ∀ t : ℝ, sep t ≠ 0
  /-- Regularity of the trajectory (Newtonian dynamics, twice continuously
  differentiable). -/
  smooth_sep : ContDiff ℝ 2 sep
  /-- The recorded instant `t = 0` has the Fig.-1b relative configuration
  and the antiparallel velocities: `sep 0 = sep0` and the relative
  velocity is `2 * v0`. -/
  initial_instant : sep 0 = sep0 ∧ deriv sep 0 = (2 : ℝ) • v0
  /-- Reduced mass of two equal point masses: `m_red = m/2`. -/
  reduced_mass_eq : reduced_mass = particleMass / 2
  /-- Fig. 1b readout: `r0 = 100 * a0`. -/
  initial_separation_value : initial_separation = 100 * bohrRadius
  /-- The relative position at `t = 0` has magnitude `r0`. -/
  initial_separation_is_norm : ‖sep0‖ = initial_separation
  /-- Nonzero initial motion; `v0` has magnitude `initial_speed`. -/
  initial_speed_value : v0 ≠ 0 ∧ ‖v0‖ = initial_speed
  /-- Angular momentum per particle about the centre of mass is `mu * ℏ`
  (given data): each particle orbits at radius `r0/2` with velocity
  perpendicular to its radius vector, so `m v0 (r0/2) = mu ℏ`. -/
  angular_momentum_per_particle :
    particleMass * initial_speed * (initial_separation / 2) = unboundMu * hbar
  /-- Total angular momentum is the sum of the two equal per-particle
  contributions (equal masses, antiparallel velocities, centre of mass at
  the midpoint): `L = 2 mu ℏ`. -/
  total_angular_momentum_eq :
    total_angular_momentum =
      2 * (particleMass * initial_speed * (initial_separation / 2))
  /-- Fig. 1b geometry and orientation: at `t = 0` the velocities are
  perpendicular to the separation, with the recorded left-handed
  orientation of the figure (positron above the line connecting the
  pair, moving left): the signed planar bracket of the separation with
  the positron velocity is `(+1) * r0 * v0` (`perp sep0 v0 = 0` would
  mean collinear, `perp sep0 v0 = -r0 v0` the mirrored figure). -/
  initial_transverse :
    perp sep0 v0 = initial_separation * initial_speed
  /-- Polar decomposition of the planar relative coordinate:
  `sep t = |sep t| * (cos θ(t), sin θ(t))`. -/
  polar_decomposition :
    ∀ t : ℝ, sep t 0 = ‖sep t‖ * Real.cos (polar_angle t) ∧
      sep t 1 = ‖sep t‖ * Real.sin (polar_angle t)
  /-- Angular-momentum conservation for the reduced one-body problem
  (the `r² θ' = L/m_red` law in bracket form): at every time the signed
  planar angular momentum per unit reduced mass is the constant
  `L / m_red`.  Sign consistency: at `t = 0`, combining
  `initial_instant`, `initial_transverse` and `reduced_mass_eq` gives
  `perp sep0 (2 · v0) = 2 r0 v0 = L / (m/2)`, i.e. exactly the stated
  RHS — the trajectory already starts on the increasing-angle branch. -/
  angular_momentum_law :
    ∀ t : ℝ, perp (sep t) (deriv sep t) = total_angular_momentum / reduced_mass
  /-- Relative-coordinate kinetic energy: the sum of the two Newtonian
  kinetic energies equals `(1/2) m_red u^2` with `u = 2 v0`. -/
  relative_kinetic_law :
    2 * ((1 / 2) * particleMass * initial_speed ^ 2) =
      (1 / 2) * reduced_mass * (2 * initial_speed) ^ 2
  /-- Coulomb's law: potential energy `U(r) = -k e²/r`; at the transverse
  initial instant the conserved total energy is kinetic plus Coulomb. -/
  coulomb_law :
    total_energy =
      2 * ((1 / 2) * particleMass * initial_speed ^ 2) -
        coulombK * elementaryCharge ^ 2 / initial_separation
  /-- Newton's equation for the reduced particle under the attractive
  Coulomb force (two-body reduction: acceleration of the reduced particle
  is `(m/2)⁻¹` times the Coulomb force along the separation), in VECTOR
  form: the acceleration is directed along `-sep` (attractive),
  `sep'' = -(k e² / (m_red r³)) • sep` with `m_red = m/2`, i.e. magnitude
  `k e² / (m_red r²) = 2 k e² / (m r²)`.  The CENTRAL (radial) character
  of the acceleration is what makes the specific angular momentum
  `perp (sep) (sep')` constant in time (see the proved certificate
  `perp_sep_is_const_of_central_force` below); a norm-only equation
  would lose the radial direction. -/
  newton_relative_law :
    ∀ t : ℝ, deriv (deriv sep) t =
      -(2 * (coulombK * elementaryCharge ^ 2 / particleMass)) •
        ((‖sep t‖ ^ 3)⁻¹ • sep t)
  /-- Energy + angular-momentum conservation for the inverse-square
  attraction, multiplied through by `r^2 > 0` (with `radial speed = r'`):
  `E r^2 = (1/2) m_red (r' r)^2 + L^2/(2 m_red) - k e^2 r`.  The left-hand
  rearrangement `E r^2 + k e^2 r - L^2/(2 m_red)` is the turning-point
  quadratic `turningQuadratic`; it vanishes exactly where the radial speed
  vanishes. -/
  radial_energy_law :
    ∀ t : ℝ,
      total_energy * ‖sep t‖ ^ 2 +
          coulombK * elementaryCharge ^ 2 * ‖sep t‖ -
        total_angular_momentum ^ 2 / (2 * reduced_mass) =
      (1 / 2) * reduced_mass * (deriv (fun s => ‖sep s‖) t * ‖sep t‖) ^ 2
  /-- The transverse initial instant of Fig. 1b is a turning point
  (velocities perpendicular to the separation, radial speed zero). -/
  turning_point_initial : deriv (fun s => ‖sep s‖) 0 = 0

namespace CoulombScatteringData

variable {hR : ScalingRegime} (S : CoulombScatteringData hR)

/-- Initial separation is positive (Fig. 1b readout `100 * a0`, `a0 > 0`). -/
theorem initial_separation_pos : 0 < S.initial_separation := by
  rw [S.initial_separation_value]
  exact mul_pos (by norm_num) hR.bohrRadius_pos

/-- The total angular momentum has the value `2 * mu * ℏ = 15 ℏ` for
`mu = 15/2`. -/
theorem total_angular_momentum_value :
    S.total_angular_momentum = 2 * (unboundMu * hbar) := by
  rw [S.total_angular_momentum_eq, S.angular_momentum_per_particle]

/-- The turning-point quadratic of the effective radial dynamics,
`Q(r) = E r^2 + k e^2 r - L^2/(2 m_red)`: the radial-energy identity
multiplied by `r^2 > 0`; `Q(r) = (1/2) m_red r'^2 r^2` along the
trajectory, so `Q(r) = 0` exactly at turning points. -/
def turningQuadratic (r : ℝ) : ℝ :=
  S.total_energy * r ^ 2 + coulombK * elementaryCharge ^ 2 * r -
    S.total_angular_momentum ^ 2 / (2 * S.reduced_mass)

/-- The initial separation is a turning point (the periapsis of the
unbound orbit): `Q(r0) = 0`, from `radial_energy_law` at `t = 0` and
`turning_point_initial`.  Pure rearrangement of governing-law fields. -/
theorem turningQuadratic_periapsis : S.turningQuadratic S.initial_separation = 0 := by
  have h1 := S.radial_energy_law 0
  rw [S.initial_instant.1, S.turning_point_initial, S.initial_separation_is_norm,
    zero_mul, zero_pow (two_ne_zero : (2 : ℕ) ≠ 0), mul_zero] at h1
  rw [CoulombScatteringData.turningQuadratic]
  exact h1

/-- Semilatus rectum `p = L^2 / (m_red k e^2)` of the reduced one-body
problem (m): the geometric scale of the conic in Hint 2. -/
def semilatusRectum : ℝ :=
  S.total_angular_momentum ^ 2 /
    (S.reduced_mass * coulombK * elementaryCharge ^ 2)

/-- Dimensionless squared eccentricity of Hint 1 for equal masses
(`m_red = m/2` reconciles `2 m_red` in the denominator with the page's
`m`): `eps^2 = 1 + 2 E L^2 / (m_red (k e^2)^2) = 1 + 4 E L^2 / (k^2 e^4 m)`. -/
def eccentricitySq : ℝ :=
  1 + 2 * S.total_energy * S.total_angular_momentum ^ 2 /
    (S.reduced_mass * (coulombK * elementaryCharge ^ 2) ^ 2)

end CoulombScatteringData

/-! ### Unboundness at `mu = 15/2` -/

/-- The total energy is the Figure-1b value `mu²/2500 - 1/200` in units of
`ℏ²/(m a0²)`; for `mu = 15/2` this is `7/400 > 0`: the pair is unbound
(hyperbolic scattering).  Derivable from `coulomb_law`,
`angular_momentum_per_particle`, `initial_separation_value`,
`bohr_radius_def` and `relative_kinetic_law`; the proof is pure algebra
once those laws are granted, and contains no angle information. -/
theorem total_energy_pos {hR : ScalingRegime} (S : CoulombScatteringData hR)
    (_hμ : IsAngularMomentumFactor unboundMu) : 0 < S.total_energy := by
  have hm : (0:ℝ) < particleMass := hR.particleMass_pos
  have ha0 : (0:ℝ) < bohrRadius := hR.bohrRadius_pos
  have hh : (0:ℝ) < hbar := hR.hbar_pos
  have hk : (0:ℝ) < coulombK := hR.coulombK_pos
  have he : (0:ℝ) < elementaryCharge := hR.elementaryCharge_pos
  have hke : (0:ℝ) < coulombK * elementaryCharge ^ 2 := mul_pos hk (pow_pos he 2)
  -- Initial speed from the angular-momentum datum `m v0 (r0/2) = mu hbar`
  -- with `r0 = 100 a0`:  `v0 = 2 mu hbar / (m * (100 a0))`.
  have hv0 : S.initial_speed = 2 * unboundMu * hbar / (particleMass * (100 * bohrRadius)) := by
    have hperp := S.angular_momentum_per_particle
    rw [S.initial_separation_value] at hperp
    have hd : particleMass * (100 * bohrRadius) ≠ 0 :=
      mul_ne_zero (ne_of_gt hm) (mul_ne_zero (by norm_num) (ne_of_gt ha0))
    have h2 : particleMass * (100 * bohrRadius) * S.initial_speed =
        2 * (unboundMu * hbar) := by
      have e : particleMass * (100 * bohrRadius) * S.initial_speed =
          2 * (particleMass * S.initial_speed * (100 * bohrRadius / 2)) := by ring
      rw [e, hperp]
    have h2'' : particleMass * (100 * bohrRadius) * S.initial_speed
        = 2 * unboundMu * hbar := by
      have e : (2:ℝ) * unboundMu * hbar = 2 * (unboundMu * hbar) := by ring
      rw [e, h2]
    rw [eq_div_iff hd, mul_comm S.initial_speed (particleMass * (100 * bohrRadius))]
    exact h2''
  rw [S.coulomb_law, S.initial_separation_value, hv0, hR.bohr_radius_def]
  -- Everything over the common unit `hbar^2/(m a0^2)` is the rational
  -- computation `4 mu^2/100^2 - 1/100 = 1/80 > 0` at `mu = 15/2`.
  have hmu : unboundMu = 15 / 2 := rfl
  rw [hmu]
  have hkene : coulombK * elementaryCharge ^ 2 ≠ 0 := ne_of_gt hke
  field_simp [ne_of_gt hm, ne_of_gt ha0, ne_of_gt hh, hkene]
  have h125 : (0:ℝ) < 15 ^ 2 - 100 := by norm_num
  nlinarith [mul_pos hm hke, hke, h125, sq_pos_of_pos hh]

/-- At `mu = 15/2` the squared eccentricity strictly exceeds `1`
(hyperbola, not ellipse): the added term
`2 E L^2 / (m_red (k e²)²)` is strictly positive. -/
theorem eccentricity_gt_one {hR : ScalingRegime} (S : CoulombScatteringData hR)
    (hμ : IsAngularMomentumFactor unboundMu) : 1 < S.eccentricitySq := by
  have hE : 0 < S.total_energy := total_energy_pos S hμ
  have hm : 0 < S.reduced_mass := by
    rw [S.reduced_mass_eq]
    exact div_pos hR.particleMass_pos (by norm_num)
  have hL : S.total_angular_momentum ≠ 0 := by
    rw [S.total_angular_momentum_value]
    exact mul_ne_zero (by norm_num)
      (mul_ne_zero (by norm_num [unboundMu]) (ne_of_gt hR.hbar_pos))
  have hke : coulombK * elementaryCharge ^ 2 ≠ 0 :=
    mul_ne_zero (ne_of_gt hR.coulombK_pos)
      (pow_ne_zero 2 (ne_of_gt hR.elementaryCharge_pos))
  have hpos :
      0 < 2 * S.total_energy * S.total_angular_momentum ^ 2 /
        (S.reduced_mass * (coulombK * elementaryCharge ^ 2) ^ 2) :=
    div_pos (mul_pos (mul_pos (by norm_num) hE) (sq_pos_of_ne_zero hL))
      (mul_pos hm (sq_pos_of_ne_zero hke))
  have hdef : S.eccentricitySq =
      1 + 2 * S.total_energy * S.total_angular_momentum ^ 2 /
        (S.reduced_mass * (coulombK * elementaryCharge ^ 2) ^ 2) := rfl
  rw [hdef]
  linarith

/-- Value of Hint 1 for this scenario: the squared eccentricity equals
`49/4` (so `eps = 7/2 > 1`).  Derivable from the same laws as
`total_energy_pos`; conclusion-free of angle data. -/
theorem eccentricity_sq_eq {hR : ScalingRegime} (S : CoulombScatteringData hR)
    (hμ : IsAngularMomentumFactor unboundMu) : S.eccentricitySq = 49 / 4 := by
  have hm : (0 : ℝ) < particleMass := hR.particleMass_pos
  have ha0 : (0 : ℝ) < bohrRadius := hR.bohrRadius_pos
  have hk : (0 : ℝ) < coulombK := hR.coulombK_pos
  have hec : (0 : ℝ) < elementaryCharge := hR.elementaryCharge_pos
  have h1 : particleMass ≠ 0 := ne_of_gt hm
  have h3 : coulombK ≠ 0 := ne_of_gt hk
  have h4 : elementaryCharge ≠ 0 := ne_of_gt hec
  have h5 : bohrRadius ≠ 0 := ne_of_gt ha0
  have hX : (coulombK * elementaryCharge ^ 2) ≠ 0 :=
    mul_ne_zero h3 (pow_ne_zero 2 h4)
  have hmred' : S.reduced_mass ≠ 0 := by
    rw [S.reduced_mass_eq]; exact div_ne_zero h1 two_ne_zero
  have hbohr2 :
      particleMass * bohrRadius * (coulombK * elementaryCharge ^ 2) = hbar ^ 2 := by
    have hb := hR.bohr_radius_def
    field_simp at hb ⊢
    linear_combination hb
  have hv0 : S.initial_speed =
      2 * unboundMu * hbar / (particleMass * (100 * bohrRadius)) := by
    have hperp := S.angular_momentum_per_particle
    rw [S.initial_separation_value] at hperp
    have hd : particleMass * (100 * bohrRadius) ≠ 0 :=
      mul_ne_zero h1 (mul_ne_zero (by norm_num) h5)
    have e2 : particleMass * (100 * bohrRadius) * S.initial_speed =
        2 * (unboundMu * hbar) := by
      have e1 : particleMass * (100 * bohrRadius) * S.initial_speed =
          2 * (particleMass * S.initial_speed * (100 * bohrRadius / 2)) := by ring
      rw [e1, hperp]
    rw [eq_div_iff hd,
      show 2 * unboundMu * hbar = 2 * (unboundMu * hbar) from by ring,
      mul_comm S.initial_speed _]
    exact e2
  have hmu : unboundMu = 15 / 2 := rfl
  have hLe : S.total_angular_momentum = 15 * hbar := by
    rw [S.total_angular_momentum_eq, S.angular_momentum_per_particle, hmu]
    ring
  have hEunit : S.total_energy * (80 * bohrRadius) =
      coulombK * elementaryCharge ^ 2 := by
    rw [S.coulomb_law, hv0, hmu, S.initial_separation_value]
    field_simp
    ring_nf
    nlinarith [hbohr2]
  have hden : S.reduced_mass * (coulombK * elementaryCharge ^ 2) ^ 2 ≠ 0 :=
    mul_ne_zero hmred' (pow_ne_zero 2 hX)
  have hA : S.total_angular_momentum ^ 2 = 225 * hbar ^ 2 := by
    rw [hLe]; ring
  have s1 : 2 * S.total_energy * S.total_angular_momentum ^ 2 =
      450 * S.total_energy * hbar ^ 2 := by rw [hA]; ring
  have s2 : 450 * S.total_energy * hbar ^ 2 = 450 * S.total_energy *
      (particleMass * bohrRadius * (coulombK * elementaryCharge ^ 2)) := by
    rw [← hbohr2]
  have s4 : 900 * S.total_energy * S.reduced_mass * bohrRadius *
        (coulombK * elementaryCharge ^ 2) =
      (45 / 4) * S.reduced_mass * (coulombK * elementaryCharge ^ 2) ^ 2 := by
    rw [← hEunit]; ring_nf
  have hfrac : 2 * S.total_energy * S.total_angular_momentum ^ 2 /
      (S.reduced_mass * (coulombK * elementaryCharge ^ 2) ^ 2) = 45 / 4 := by
    rw [div_eq_iff hden]
    calc 2 * S.total_energy * S.total_angular_momentum ^ 2 =
        450 * S.total_energy *
          (particleMass * bohrRadius * (coulombK * elementaryCharge ^ 2)) := by
            linear_combination s1 + s2
      _ = 900 * S.total_energy * S.reduced_mass * bohrRadius *
            (coulombK * elementaryCharge ^ 2) := by
          rw [S.reduced_mass_eq]; ring
      _ = (45 / 4) * (S.reduced_mass * (coulombK * elementaryCharge ^ 2) ^ 2) := by
          linear_combination s4
  unfold CoulombScatteringData.eccentricitySq
  rw [hfrac]
  norm_num

end

/-! ### Initial line of motion of the positron -/

/-- The initial line of motion of `e+`: the unit vector along the initial
positron velocity `v0` (Fig. 1b).  The reference direction of the asked
angle. -/
noncomputable def initialDirection {hR : ScalingRegime} (S : CoulombScatteringData hR) : Plane :=
  ‖S.v0‖⁻¹ • S.v0

/-! ### The conic bridge (Hint 2) -/

noncomputable section

/-! #### Proved infrastructure for the Kepler/Binet bridge

The following lemmas supply the calculus layer that the Review
certificate (`redraft_kind: missing_foundational_bridge`) identified as
missing between the raw `ContDiff`/`deriv` fields and the conic orbit:
coordinate-wise differentiation on the Euclidean plane, the planar
Lagrange identity, differentiability of the radial coordinate away from
the origin, the Leibniz rule for the specific angular momentum, and —
the physical core — its conservation under a central-force acceleration
(`newton_relative_law`, upgraded this redraft to the faithful vector form
of Newton's equation for the attractive Coulomb force).  Two
consistency certificates connect the field set: the initial value of
`perp (sep) (deriv sep)` (from `initial_instant` and
`initial_transverse`) is exactly the stated conserved value of
`angular_momentum_law`, and `newton_relative_law` implies the old
norm-form magnitude equation.  None of these declarations mentions the
deflection angle, the eccentricity value `49/4`, or the asymptotic
velocity: they are reusable bridges, not the target. -/

/-- Coordinate-wise derivative: differentiating a differentiable planar
curve and reading off a coordinate equals differentiating the coordinate
function. -/
theorem hasDerivAt_apply_coord {f : ℝ → Plane} (hf : Differentiable ℝ f)
    (t : ℝ) (i : Fin 2) :
    HasDerivAt (fun s => f s i) (deriv f t i) t := by
  haveI : Fact (1 ≤ (2 : ENNReal)) := ⟨by norm_num⟩
  have hg : HasFDerivAt (fun g : Plane => g i)
      (PiLp.proj (p := (2 : ENNReal)) (β := fun _ : Fin 2 => ℝ) i) (f t) :=
    (PiLp.hasFDerivAt_apply (𝕜 := ℝ) (ι := Fin 2) (E := fun _ => ℝ)
      (p := (2 : ENNReal)) (f t) i)
  have h1 : HasDerivAt f (deriv f t) t := (hf t).hasDerivAt
  have hcomp := hg.comp_hasDerivAt t h1
  rw [show (PiLp.proj (p := (2 : ENNReal)) (β := fun _ : Fin 2 => ℝ) i) (deriv f t)
      = deriv f t i from rfl] at hcomp
  exact hcomp

/-- A twice continuously differentiable trajectory has a differentiable
velocity field. -/
theorem differentiable_deriv_of_contDiff_two {f : ℝ → Plane}
    (hf : ContDiff ℝ 2 f) : Differentiable ℝ (deriv f) := by
  have h1 : ContDiff ℝ 1 (deriv f) := by
    have h := hf
    rw [show (2 : WithTop ℕ∞) = 1 + 1 from by norm_num] at h
    exact (contDiff_succ_iff_deriv.mp h).2.2
  exact h1.differentiable (by norm_num)

/-- The planar bracket is homogeneous in the right argument. -/
theorem perp_smul_right (c : ℝ) (a b : Plane) :
    perp a (c • b) = c * perp a b := by
  simp only [perp, PiLp.smul_apply, smul_eq_mul]; ring

/-- The planar bracket is homogeneous in the left argument. -/
theorem perp_smul_left (c : ℝ) (a b : Plane) :
    perp (c • a) b = c * perp a b := by
  simp only [perp, PiLp.smul_apply, smul_eq_mul]; ring

/-- The planar bracket of a vector with itself vanishes. -/
theorem perp_self (a : Plane) : perp a a = 0 := by
  simp only [perp]; ring

/-- Planar Lagrange identity in coordinates:
`(v·w)² + (v×z w)² = |v|² |w|²`. -/
theorem lagrange_coord (v w : Plane) :
    dot v w ^ 2 + perp v w ^ 2 =
      (v 0 ^ 2 + v 1 ^ 2) * (w 0 ^ 2 + w 1 ^ 2) := by
  simp only [dot, perp]; ring

/-- The squared norm of a planar vector is the sum of its squared
coordinates. -/
theorem norm_sq_coord (v : Plane) :
    ‖v‖ ^ 2 = v 0 ^ 2 + v 1 ^ 2 := by
  rw [EuclideanSpace.norm_sq_eq, Fin.sum_univ_two]
  simp [sq_abs]

/-- Planar Lagrange identity with norms:
`(v·w)² + (v×z w)² = ‖v‖² ‖w‖²`. -/
theorem lagrange_norm (v w : Plane) :
    dot v w ^ 2 + perp v w ^ 2 = ‖v‖ ^ 2 * ‖w‖ ^ 2 := by
  rw [norm_sq_coord, norm_sq_coord, lagrange_coord]

/-- Squared norm is differentiable along a differentiable planar curve. -/
theorem norm_sq_differentiable {f : ℝ → Plane} (hf : Differentiable ℝ f) :
    Differentiable ℝ (fun s => ‖f s‖ ^ 2) := by
  have key : (fun s => ‖f s‖ ^ 2) = fun s => (f s 0) ^ 2 + (f s 1) ^ 2 := by
    funext s
    exact norm_sq_coord (f s)
  rw [key]
  have h0 : Differentiable ℝ (fun s => f s 0) := fun s =>
    (hasDerivAt_apply_coord hf s 0).differentiableAt
  have h1 : Differentiable ℝ (fun s => f s 1) := fun s =>
    (hasDerivAt_apply_coord hf s 1).differentiableAt
  exact (h0.pow 2).add (h1.pow 2)

/-- The radial coordinate `t ↦ ‖f t‖` of a differentiable planar curve
that never hits the origin is differentiable. -/
theorem norm_differentiable_of_ne_zero {f : ℝ → Plane} (hf : Differentiable ℝ f)
    (hne : ∀ s, f s ≠ 0) :
    Differentiable ℝ (fun s => ‖f s‖) := by
  have hs : Differentiable ℝ (fun s => ‖f s‖ ^ 2) := norm_sq_differentiable hf
  have key : (fun s => ‖f s‖) = fun s => Real.sqrt (‖f s‖ ^ 2) := by
    funext s
    rw [Real.sqrt_sq (norm_nonneg _)]
  rw [key]
  intro s
  have hpos : ‖f s‖ ^ 2 ≠ 0 := pow_ne_zero 2 (norm_ne_zero_iff.mpr (hne s))
  exact ((hasDerivAt_sqrt hpos).comp s ((hs s).hasDerivAt)).differentiableAt

/-- Leibniz rule for the specific angular momentum:
`(perp (f) (f'))' = perp (f) (f'')` — the `perp (f') (f')` term
drops out by `perp_self`. -/
theorem perp_sep_hasDerivAt {f : ℝ → Plane} (hf : ContDiff ℝ 2 f) (t : ℝ) :
    HasDerivAt (fun s => perp (f s) (deriv f s))
      (perp (f t) (deriv (deriv f) t)) t := by
  have hf1 : Differentiable ℝ f := hf.differentiable (by norm_num)
  have hf2 : Differentiable ℝ (deriv f) := differentiable_deriv_of_contDiff_two hf
  have h0 : HasDerivAt (fun s => f s 0) (deriv f t 0) t :=
    hasDerivAt_apply_coord hf1 t 0
  have h1 : HasDerivAt (fun s => f s 1) (deriv f t 1) t :=
    hasDerivAt_apply_coord hf1 t 1
  have h0' : HasDerivAt (fun s => deriv f s 0) (deriv (deriv f) t 0) t :=
    hasDerivAt_apply_coord hf2 t 0
  have h1' : HasDerivAt (fun s => deriv f s 1) (deriv (deriv f) t 1) t :=
    hasDerivAt_apply_coord hf2 t 1
  have hA : HasDerivAt (fun s => (f s 0) * (deriv f s 1))
      (deriv f t 0 * deriv f t 1 + f t 0 * deriv (deriv f) t 1) t :=
    h0.mul h1'
  have hB : HasDerivAt (fun s => (f s 1) * (deriv f s 0))
      (deriv f t 1 * deriv f t 0 + f t 1 * deriv (deriv f) t 0) t :=
    h1.mul h0'
  have hC := hA.sub hB
  rw [show deriv f t 0 * deriv f t 1 + f t 0 * deriv (deriv f) t 1 -
        (deriv f t 1 * deriv f t 0 + f t 1 * deriv (deriv f) t 0)
      = perp (f t) (deriv (deriv f) t) from by unfold perp; ring] at hC
  exact hC

/-- Conservation of the specific angular momentum under a central-force
acceleration: the torque of a radial acceleration vanishes
(`perp a (c • a) = c * perp a a = 0`), so
`t ↦ perp (sep t) (deriv sep t)` is constant.  This theorem is the
derivable root of the governing-law field
`CoulombScatteringData.angular_momentum_law`; the field is kept as the
primary contract because its multiplier form `perp = L / m_red` (not
merely "constant") is what the conic integration consumes. -/
theorem perp_sep_is_const_of_central_force
    (sep : ℝ → Plane) (hsmooth : ContDiff ℝ 2 sep) (q : ℝ)
    (hnewton : ∀ t : ℝ, deriv (deriv sep) t = q • ((‖sep t‖ ^ 2)⁻¹ • sep t))
    (t s : ℝ) :
    perp (sep t) (deriv sep t) = perp (sep s) (deriv sep s) := by
  have hdiff : Differentiable ℝ (fun τ => perp (sep τ) (deriv sep τ)) := fun τ =>
    (perp_sep_hasDerivAt hsmooth τ).differentiableAt
  have hzero : ∀ τ : ℝ,
      deriv (fun σ => perp (sep σ) (deriv sep σ)) τ = 0 := fun τ => by
    rw [(perp_sep_hasDerivAt hsmooth τ).deriv, hnewton τ, smul_smul,
      perp_smul_right, perp_self]
    ring
  exact is_const_of_deriv_eq_zero hdiff hzero t s

/-! #### Field-level consistency certificates (proved)

The next two certificates verify that the upgraded governing-law field
set is internally consistent: the conserved value of
`angular_momentum_law` is exactly the bracket value forced by
`initial_instant` + `initial_transverse` at `t = 0`, and the vector
`newton_relative_law` specializes to the former norm-form equation.
Neither mentions the deflection angle or any answer value. -/

namespace CoulombScatteringData

/-- The central-force Newton equation of `newton_relative_law` has the
stated magnitude: taking norms gives
`‖(1/2) • sep''‖ = k e² / (m ‖sep‖²)`, i.e. `m_red * |sep''| = k e² / r²`
with `m_red = m/2`.  Proved by direct simplification of the norm of the
scaled separation vector (`|scalar • sep| = scalar * r`, the `r⁻³`
times `r` leaving the `r⁻²` force law). -/
theorem newton_relative_law_norm {hR : ScalingRegime}
    (S : CoulombScatteringData hR) (t : ℝ) :
    ‖(1 / 2 : ℝ) • (deriv (deriv S.sep)) t‖ =
      coulombK * elementaryCharge ^ 2 / (particleMass * ‖S.sep t‖ ^ 2) := by
  rw [S.newton_relative_law t]
  have hr : ‖S.sep t‖ ≠ 0 := norm_ne_zero_iff.mpr (S.sep_ne_zero t)
  have hc1 : (0 : ℝ) ≤ (1 : ℝ) / 2 := by norm_num
  have hm1 : particleMass ≠ 0 := ne_of_gt hR.particleMass_pos
  rw [show -(2 * (coulombK * elementaryCharge ^ 2 / particleMass)) •
        ((‖S.sep t‖ ^ 3)⁻¹ • S.sep t) =
      (-(2 * (coulombK * elementaryCharge ^ 2 / particleMass)) *
        (‖S.sep t‖ ^ 3)⁻¹) • S.sep t from smul_smul _ _ _]
  rw [norm_smul, Real.norm_of_nonneg hc1, norm_smul]
  have hnorm : ‖-(2 * (coulombK * elementaryCharge ^ 2 / particleMass)) *
        (‖S.sep t‖ ^ 3)⁻¹‖ =
      2 * (coulombK * elementaryCharge ^ 2 / particleMass) *
        (‖S.sep t‖ ^ 3)⁻¹ := by
    have hpos : 0 < coulombK * elementaryCharge ^ 2 :=
      mul_pos hR.coulombK_pos (pow_pos hR.elementaryCharge_pos 2)
    have h : -(2 * (coulombK * elementaryCharge ^ 2 / particleMass)) *
        (‖S.sep t‖ ^ 3)⁻¹ =
        -(2 * (coulombK * elementaryCharge ^ 2 / particleMass) *
          (‖S.sep t‖ ^ 3)⁻¹) := by ring
    rw [h, norm_neg, Real.norm_of_nonneg (by
      have : (0:ℝ) ≤ 2 * (coulombK * elementaryCharge ^ 2 / particleMass) *
          (‖S.sep t‖ ^ 3)⁻¹ := by
        apply mul_nonneg (mul_nonneg (by norm_num)
          (div_nonneg (le_of_lt hpos) (le_of_lt hR.particleMass_pos)))
        exact inv_nonneg.mpr (pow_nonneg (norm_nonneg _) 3)
      exact this)]
  rw [hnorm]
  field_simp [hm1, hr]

/-- The initial value of the specific angular momentum bracket, computed
from the figure readouts: at `t = 0`,
`perp (sep 0) (deriv sep 0) = 2 * r0 * v0`.  Consistency certificate for
`angular_momentum_law`: the conserved value `L / m_red` equals this
initial value (see `angular_momentum_conserved_value`); the bracket
identity itself is a direct rearrangement of `initial_instant` and
`initial_transverse` via `perp_smul_right`. -/
theorem perp_sep_initial {hR : ScalingRegime}
    (S : CoulombScatteringData hR) :
    perp (S.sep 0) (deriv S.sep 0) =
      2 * S.initial_separation * S.initial_speed := by
  rw [S.initial_instant.1, S.initial_instant.2, perp_smul_right,
    S.initial_transverse]
  ring

/-- The stated conserved value `L / m_red` of `angular_momentum_law`
and the figure-forced initial bracket value of `perp_sep_initial`
coincide: both equal `2 * r0 * v0`.  This is the figure-side datum that
fixes the constant in the `t ↦ perp (sep t) (deriv sep t)` constancy of
`perp_sep_is_const_of_central_force`; the conservation itself is the
content of the field, not of this certificate. -/
theorem angular_momentum_conserved_value {hR : ScalingRegime}
    (S : CoulombScatteringData hR) :
    S.total_angular_momentum / S.reduced_mass =
      2 * S.initial_separation * S.initial_speed := by
  rw [S.total_angular_momentum_eq, S.reduced_mass_eq]
  rw [div_eq_iff (show (particleMass : ℝ) / 2 ≠ 0 from by
    have := hR.particleMass_pos; positivity)]
  linarith [S.angular_momentum_per_particle]

end CoulombScatteringData

/-- Hint 2 made derivable: the trajectory `|sep|` as a function of its
own polar angle `polar_angle` is a conic.  For the unbound case
`eps > 1` the physical branch near the periapsis has denominator
`eps * cos θ - 1 > 0`.  `θ0` is the (a priori unknown) direction of the
symmetry axis of the hyperbola; nothing here fixes its value. -/
theorem orbit_eq_conic {hR : ScalingRegime} (S : CoulombScatteringData hR)
    (hμ : IsAngularMomentumFactor unboundMu) :
    ∃ eps θ0 : ℝ, eps = Real.sqrt S.eccentricitySq ∧ 1 < eps ∧
      ∀ t : ℝ, 0 < eps * Real.cos (S.polar_angle t - θ0) - 1 ∧
        ‖S.sep t‖ =
          S.semilatusRectum / (eps * Real.cos (S.polar_angle t - θ0) - 1) := by
  -- Blocked: this is the full Kepler-equation/Binet-ODE content
  -- (differentiate L·θ' = u²/p·(1+e cos) via the radial-energy law and
  -- integrate with `polar_angle` monotone by `angular_momentum_law`).
  -- Provable in principle, but a multi-hundred-line project on the raw
  -- `ContDiff`/`deriv` fields; no Mathlib Kepler API exists.  Left as
  -- `sorry` per the physics-proof workflow (missing infrastructure noted).
  sorry

/-! ### Asymptotic relative velocity `u_inf` -/

/-- A candidate asymptotic relative-velocity vector (m/s): plain data,
to which the predicate `IsAsymptoticRelativeVelocity` then assigns the
physical role of `u_inf`. -/
structure RelativeVelocityVector where
  /-- The planar vector (m/s). -/
  vec : Plane

/-- The asymptotic relative velocity `u_inf` of `e+` with respect to `e-`
as the separation tends to infinity: `u.vec` is a nonzero planar vector
that is the limit of the relative velocity `deriv sep` at `Filter.atTop`
(energy conservation keeps the speed bounded, so future time infinity and
infinite separation coincide for the unbound orbit).  The orientation
field `direction_toward_pair` records the rolling branch: the deflection
rotates the initial line of motion toward the line connecting the pair
(clockwise in the Fig.-1b orientation), so the signed planar bracket of
the initial direction with `u.vec` is nonpositive.  Constraining: the
`tendsto` field is a genuine limit equation, so the predicate can hold of
at most one vector; existence is a theorem to be proved
(`exists_asymptoticRelativeVelocity`), not an assumption. -/
structure IsAsymptoticRelativeVelocity {hR : ScalingRegime}
    (S : CoulombScatteringData hR) (u : RelativeVelocityVector) : Prop where
  /-- `u.vec` is the limit of the relative velocity as `t -> +∞`. -/
  tendsto : Filter.Tendsto (deriv S.sep) Filter.atTop (nhds u.vec)
  /-- The asymptotic motion is nontrivial (scattering, not capture). -/
  u_inf_ne_zero : u.vec ≠ 0
  /-- Rolling branch: the deflection bends the trajectory toward the line
  connecting the pair, so `(initial direction) ×z u.vec ≤ 0`. -/
  direction_toward_pair : perp (initialDirection (S := S)) u.vec ≤ 0

/-- Existence of the asymptotic relative velocity for the unbound orbit
(`mu = 15/2`, `E > 0`): the hyperbolic scattering trajectory has a
well-defined limiting relative velocity on the outward (post-periapsis)
branch.  This is the definitionally-grounded meaning of `u_inf` in the
subquestion; the proof derives the limit from the conic form of
`orbit_eq_conic` together with energy conservation. -/
theorem exists_asymptoticRelativeVelocity {hR : ScalingRegime}
    (S : CoulombScatteringData hR) (hμ : IsAngularMomentumFactor unboundMu) :
    ∃ u : RelativeVelocityVector, IsAsymptoticRelativeVelocity S u := by
  -- Blocked: constructing `u∞` requires the integrated velocity formula of
  -- the hyperbolic orbit (via `orbit_eq_conic` + energy conservation), plus
  -- the `Filter.Tendsto` limit argument for `deriv S.sep`.  Dependent on
  -- the same missing Kepler-layer infrastructure as `orbit_eq_conic`.
  sorry

/-- The angle (rad) between two nonzero planar vectors, via the standard
`Real.arccos` characterization (values in `[0, pi]`). -/
noncomputable def angleBetween (a b : Plane) : ℝ :=
  Real.arccos (dot a b / (‖a‖ * ‖b‖))

/-- Unit speed of the asymptotic relative motion: `u_inf` has magnitude
the asymptotic relative speed `sqrt(2 E / m_red)`, and its direction makes
the ACUTE angle `delta = arctan(1 / sqrt(eps^2 - 1))` with the initial
line of motion: the recorded instant is the PERIAPSIS of the hyperbolic
orbit (`turningQuadratic_periapsis`), the tangent at periapsis is
perpendicular to the symmetry axis, and the asymptote directions of the
conic `r = p/(eps cos θ - 1)` satisfy `cos θ_asym = 1/eps`, so
`angleBetween = pi/2 - arccos(1/eps) = arctan(1/sqrt(eps^2-1))`.
(ITER-011 REDRAFT: the previous conclusion
`pi - 2 arctan(1/sqrt(eps^2-1))` was the apocenter-referenced
Rutherford turning angle, physically wrong for this
periapsis-referenced scenario and inconsistent with the official
`16.60 deg` rounding band.)  Bridges Hint 1 (`eccentricity_sq_eq`),
Hint 2 (`orbit_eq_conic`), and the definition of `u_inf`
(`exists_asymptoticRelativeVelocity`) to the numeric answer; contains
the sign/orientation input but NO numeric deflection value. -/
theorem signed_deflection_eq_formula {hR : ScalingRegime}
    (S : CoulombScatteringData hR) (u : RelativeVelocityVector)
    (hu : IsAsymptoticRelativeVelocity S u)
    (hμ : IsAngularMomentumFactor unboundMu) :
    ‖u.vec‖ = Real.sqrt (2 * S.total_energy / S.reduced_mass) ∧
      angleBetween (initialDirection (S := S)) u.vec =
        Real.arctan (1 / Real.sqrt (S.eccentricitySq - 1)) := by
  -- Kepler-layer bridge (still to be proved):
  -- * norm component: energy conservation at vanishing Coulomb
  --   potential gives `‖u∞‖ = sqrt(2E/m_red)`;
  -- * angle component: from the conic of `orbit_eq_conic`, asymptote
  --   angle `θ∞ = arccos(1/eps)` off the symmetry axis; the initial
  --   transverse velocity is perpendicular to that axis, giving
  --   `angleBetween = pi/2 - arccos(1/eps) = arctan(1/sqrt(eps^2-1))`.
  -- The full `deriv`-limit argument shares the missing Kepler-layer
  -- infrastructure of `orbit_eq_conic` / `exists_asymptoticRelativeVelocity`;
  -- recorded as a `sorry`.
  sorry

/-- The oriented (signed) deflection angle of the scattering, in radians:
`theta_sign * angleBetween (initialDirection) u_inf`, where `theta_sign`
is `+1` when the deflection is counterclockwise from the initial line of
motion of `e+` and `-1` when it is clockwise.  The Fig.-1b orientation
(captured by `IsAsymptoticRelativeVelocity.direction_toward_pair`) selects
the clockwise case. -/
noncomputable def signedDeflection {hR : ScalingRegime}
    (S : CoulombScatteringData hR) (u : RelativeVelocityVector) : ℝ :=
  (if 0 ≤ perp (initialDirection (S := S)) u.vec then (1 : ℝ) else -1) *
    angleBetween (initialDirection (S := S)) u.vec

/-- Radians-to-degrees conversion. -/
noncomputable def radiansToDegrees (θ : ℝ) : ℝ := θ * (180 / Real.pi)

/-- Under the branch condition of Fig. 1b (`perp u0 u_inf ≤ 0`), the
signed deflection is the negated unsigned angle.  Definitional bridge
(`if_neg`); the degenerate zero-deflection case is discharged by the
physics side (`direction_toward_pair` together with the nonzero
deflection from `signed_deflection_eq_formula` excludes it, so the
remaining branch is strict). -/
theorem signedDeflection_eq_neg_angle {hR : ScalingRegime}
    (S : CoulombScatteringData hR) (u : RelativeVelocityVector)
    (_hu : IsAsymptoticRelativeVelocity S u)
    (hnondeg : perp (initialDirection (S := S)) u.vec < 0) :
    signedDeflection (S := S) u =
      -angleBetween (initialDirection (S := S)) u.vec := by
  unfold signedDeflection
  rw [if_neg (not_le.mpr hnondeg)]
  ring

/-! ### Rounding band for the official value (proved) -/

/-- The polynomial squeeze for `arctan` on `[0,1]`:
`x - x³/3 + x⁵/5 - x⁷/7 ≤ arctan x ≤ x - x³/3 + x⁵/5`,
from the alternating geometric-series bounds
`1 - x² + x⁴ - x⁶ ≤ (1+x²)⁻¹ ≤ 1 - x² + x⁴` (valid for all `x`, since
`(1 - x² + x⁴ - x⁶)(1+x²) = 1 - x⁸ ≤ 1` and
`1 ≤ 1 + x⁶ = (1 - x² + x⁴)(1+x²)`) integrated against
`arctan b = ∫₀ᵇ (1+x²)⁻¹ dx` (`integral_inv_one_add_sq`). -/
theorem arctan_poly_squeeze (b : ℝ) (hb0 : 0 ≤ b) :
    (b - b^3/3 + b^5/5 - b^7/7 ≤ Real.arctan b) ∧
      (Real.arctan b ≤ b - b^3/3 + b^5/5) := by
  have key3 : ∀ x : ℝ, (0:ℝ) < 1 + x ^ 2 := fun x => by positivity
  have key1 : ∀ x : ℝ, 1 - x^2 + x^4 - x^6 ≤ (1 + x^2 : ℝ)⁻¹ := by
    intro x
    rw [inv_eq_one_div]
    rcases le_total (0:ℝ) (1 - x^2 + x^4 - x^6) with hnn | hneg
    · rw [le_div_iff₀ (key3 x)]
      nlinarith [sq_nonneg (x^4), pow_nonneg (sq_nonneg x) 2, sq_nonneg (x*x)]
    · exact le_trans hneg (by positivity)
  have key2 : ∀ x : ℝ, (1 + x^2 : ℝ)⁻¹ ≤ 1 - x^2 + x^4 := by
    intro x
    rw [inv_eq_one_div, div_le_iff₀ (key3 x)]
    nlinarith [sq_nonneg (x^3)]
  have hIval : (∫ x : ℝ in (0:ℝ)..b, (1 + x ^ 2 : ℝ)⁻¹) = Real.arctan b := by
    rw [integral_inv_one_add_sq, Real.arctan_zero, sub_zero]
  have hI1 : (∫ x : ℝ in (0:ℝ)..b, (1 - x^2 + x^4 - x^6)) =
      b - b^3/3 + b^5/5 - b^7/7 := by
    have hI12 : (∫ x : ℝ in (0:ℝ)..b, (1 - x^2 + x^4)) = b - b^3/3 + b^5/5 := by
      have e : (fun x : ℝ => 1 - x^2 + x^4) = fun x => (1 - x^2) + x^4 := by
        ext x; ring
      rw [e, intervalIntegral.integral_add
        (Continuous.intervalIntegrable (by fun_prop : Continuous fun x : ℝ => 1 - x^2) _ _)
        (Continuous.intervalIntegrable (by fun_prop : Continuous fun x : ℝ => x^4) _ _)]
      have h1 : (∫ x : ℝ in (0:ℝ)..b, (1 - x^2)) = b - b^3/3 := by
        simp_rw [sub_eq_add_neg]
        rw [intervalIntegral.integral_add
          (Continuous.intervalIntegrable (by fun_prop : Continuous fun _ : ℝ => (1:ℝ)) _ _)
          (Continuous.intervalIntegrable (by fun_prop : Continuous fun x : ℝ => -(x^2)) _ _)]
        rw [intervalIntegral.integral_const, intervalIntegral.integral_neg, integral_pow]
        ring_nf
      have h2 : (∫ x : ℝ in (0:ℝ)..b, x^4) = b^5/5 := by
        rw [integral_pow]; ring_nf
      rw [h1, h2]
    have e1 : (fun x : ℝ => 1 - x^2 + x^4 - x^6) =
        fun x => (1 - x^2 + x^4) - x^6 := by
      ext x; ring
    rw [e1, intervalIntegral.integral_sub
      (Continuous.intervalIntegrable (by fun_prop : Continuous fun x : ℝ => 1 - x^2 + x^4) _ _)
      (Continuous.intervalIntegrable (by fun_prop : Continuous fun x : ℝ => x^6) _ _)]
    have h6 : (∫ x : ℝ in (0:ℝ)..b, x^6) = b^7/7 := by
      rw [integral_pow]; ring_nf
    rw [hI12, h6]
  have hmnI : (∫ x : ℝ in (0:ℝ)..b, (1 - x^2 + x^4 - x^6)) ≤
      ∫ x : ℝ in (0:ℝ)..b, (1 + x ^ 2 : ℝ)⁻¹ :=
    intervalIntegral.integral_mono hb0
      (Continuous.intervalIntegrable (by fun_prop : Continuous fun x : ℝ => 1 - x^2 + x^4 - x^6) _ _)
      intervalIntegral.intervalIntegrable_inv_one_add_sq key1
  rw [hI1, hIval] at hmnI
  have hI2 : (∫ x : ℝ in (0:ℝ)..b, (1 - x^2 + x^4)) = b - b^3/3 + b^5/5 := by
    have e : (fun x : ℝ => 1 - x^2 + x^4) = fun x => (1 - x^2) + x^4 := by
      ext x; ring
    rw [e, intervalIntegral.integral_add
      (Continuous.intervalIntegrable (by fun_prop : Continuous fun x : ℝ => 1 - x^2) _ _)
      (Continuous.intervalIntegrable (by fun_prop : Continuous fun x : ℝ => x^4) _ _)]
    have h1 : (∫ x : ℝ in (0:ℝ)..b, (1 - x^2)) = b - b^3/3 := by
      simp_rw [sub_eq_add_neg]
      rw [intervalIntegral.integral_add
        (Continuous.intervalIntegrable (by fun_prop : Continuous fun _ : ℝ => (1:ℝ)) _ _)
        (Continuous.intervalIntegrable (by fun_prop : Continuous fun x : ℝ => -(x^2)) _ _)]
      rw [intervalIntegral.integral_const, intervalIntegral.integral_neg, integral_pow]
      ring_nf
    have h2 : (∫ x : ℝ in (0:ℝ)..b, x^4) = b^5/5 := by
      rw [integral_pow]; ring_nf
    rw [h1, h2]
  have hmnJ : (∫ x : ℝ in (0:ℝ)..b, (1 + x ^ 2 : ℝ)⁻¹) ≤
      ∫ x : ℝ in (0:ℝ)..b, (1 - x^2 + x^4) :=
    intervalIntegral.integral_mono hb0 intervalIntegral.intervalIntegrable_inv_one_add_sq
      (Continuous.intervalIntegrable (by fun_prop : Continuous fun x : ℝ => 1 - x^2 + x^4) _ _)
      key2
  rw [hI2, hIval] at hmnJ
  exact ⟨hmnI, hmnJ⟩

/-- **Rounding-band lemma (proved).**  The degree reading of the exact
deflection `arctan (2 / √45)` falls strictly inside both official rounding
bands.  With `b = 2/√45 ∈ [15456/51841, 36385/122039] ⊂ [0,1]` the
polynomial squeeze (`arctan_poly_squeeze`) gives rational bounds on the
deflection; the rational bounds `244078/36385 ≤ √45 ≤ 51841/7728`
(i.e. `b ∈ [15456/51841, 36385/122039]`), and `3.1415 < π < 3.1416`
(`Real.pi_gt_d4`, `Real.pi_lt_d4`) close the arithmetic
(`arctan (2/√45)·180/π ≈ 16.6015`). -/
theorem arctan_deg_band :
    (16595 : ℝ) / 1000 < Real.arctan (2 / Real.sqrt 45) * (180 / Real.pi) ∧
      Real.arctan (2 / Real.sqrt 45) * (180 / Real.pi) < (16605 : ℝ) / 1000 := by
  have hsqrt_lo : (244078 : ℝ) / 36385 ≤ Real.sqrt 45 :=
    Real.le_sqrt_of_sq_le (by norm_num)
  have hsqrt_hi : Real.sqrt 45 ≤ (51841 : ℝ) / 7728 := by
    rw [Real.sqrt_le_iff]
    norm_num
  have hs_pos : (0 : ℝ) < Real.sqrt 45 := Real.sqrt_pos.2 (by norm_num)
  have hb_lo : (15456 : ℝ) / 51841 ≤ 2 / Real.sqrt 45 := by
    rw [div_le_div_iff₀ (by norm_num : (0:ℝ) < 51841) hs_pos]
    nlinarith [mul_le_mul_of_nonneg_left hsqrt_hi (by norm_num : (0:ℝ) ≤ 2)]
  have hb_hi : 2 / Real.sqrt 45 ≤ (36385 : ℝ) / 122039 := by
    rw [div_le_div_iff₀ hs_pos (by norm_num : (0:ℝ) < 122039)]
    nlinarith [mul_le_mul_of_nonneg_left hsqrt_lo (by norm_num : (0:ℝ) ≤ 2)]
  have hb_nonneg : 0 ≤ 2 / Real.sqrt 45 := by positivity
  obtain ⟨hAlo, hAhi⟩ := arctan_poly_squeeze (2 / Real.sqrt 45) hb_nonneg
  have hp3d : (2 / Real.sqrt 45)^3 ≤ ((36385:ℝ)/122039)^3 :=
    pow_le_pow_left₀ hb_nonneg hb_hi 3
  have hUp : Real.arctan (2 / Real.sqrt 45) ≤
      1092902077830836361941069151394447223982/3771493059023825276852101550664179561879 := by
    refine le_trans hAhi ?_
    have hp5u : (2 / Real.sqrt 45)^5 ≤ ((36385:ℝ)/122039)^5 :=
      pow_le_pow_left₀ hb_nonneg hb_hi 5
    have hm3 : -((2 / Real.sqrt 45)^3) ≤ -((15456:ℝ)/51841)^3 := by
      have hq := pow_le_pow_left₀ (by norm_num : (0:ℝ) ≤ 15456/51841) hb_lo 3
      linarith
    have hle : 2 / Real.sqrt 45 - (2 / Real.sqrt 45)^3/3 + (2 / Real.sqrt 45)^5/5 ≤
        (36385:ℝ)/122039 - ((15456:ℝ)/51841)^3/3 + ((36385:ℝ)/122039)^5/5 := by
      linarith
    refine le_trans hle ?_
    norm_num
  have hLo : 4592717556334867190359693743344173135138246790814426045285454/15850633827946446283524867136569677061732804006599780468555295
      ≤ Real.arctan (2 / Real.sqrt 45) := by
    refine le_trans ?_ hAlo
    have hp5l : ((15456:ℝ)/51841)^5 ≤ (2 / Real.sqrt 45)^5 :=
      pow_le_pow_left₀ (by norm_num) hb_lo 5
    have hp7u : (2 / Real.sqrt 45)^7 ≤ ((36385:ℝ)/122039)^7 :=
      pow_le_pow_left₀ hb_nonneg hb_hi 7
    have hle : (15456:ℝ)/51841 - ((36385:ℝ)/122039)^3/3 + ((15456:ℝ)/51841)^5/5 -
          ((36385:ℝ)/122039)^7/7 ≤
        2 / Real.sqrt 45 - (2 / Real.sqrt 45)^3/3 + (2 / Real.sqrt 45)^5/5 -
          (2 / Real.sqrt 45)^7/7 := by
      linarith
    refine le_trans ?_ hle
    norm_num
  have hpi_lo := Real.pi_gt_d4
  have hpi_hi := Real.pi_lt_d4
  have hpi_pos := Real.pi_pos
  have hLo_deg : (3319:ℝ)/200 * Real.pi < Real.arctan (2 / Real.sqrt 45) * 180 := by
    nlinarith [hLo, hpi_hi]
  have hUp_deg : Real.arctan (2 / Real.sqrt 45) * 180 < (3321:ℝ)/200 * Real.pi := by
    nlinarith [hUp, hpi_lo]
  have hrew : Real.arctan (2 / Real.sqrt 45) * (180 / Real.pi) =
      Real.arctan (2 / Real.sqrt 45) * 180 / Real.pi := by
    rw [mul_div_assoc]
  rw [hrew]
  constructor
  · rw [div_lt_div_iff₀ (by norm_num) hpi_pos]
    nlinarith
  · rw [div_lt_div_iff₀ hpi_pos (by norm_num)]
    nlinarith

/-! ### Main target (T1-B2, 2.5 pts) -/

/-- A real `x` rounds to the official printed value `-16.60` degrees,
i.e. to two decimal places in the sense of the official marking scheme:
`-16.605 ≤ x < -16.595`. -/
def roundsToOfficialDegrees (x : ℝ) : Prop :=
  -(16605 : ℝ) / 1000 ≤ x ∧ x < -(16595 : ℝ) / 1000

/-- Helper for the main assembly: once an asymptotic relative velocity
`u∞` with the physical deflection formula and a strict branch exists,
the signed target follows from proved certificates only.  The remaining
`sorry` inside the main theorem below is precisely the Kepler-layer
existence plus deflection-evaluation step (the
`exists_asymptoticRelativeVelocity` + `signed_deflection_eq_formula`
content). -/
theorem signed_deflection_certificate {hR : ScalingRegime}
    {S : CoulombScatteringData hR} {u : RelativeVelocityVector}
    (hu : IsAsymptoticRelativeVelocity S u)
    (hbranch : perp (initialDirection (S := S)) u.vec < 0)
    (hdelta : signedDeflection (S := S) u = -Real.arctan (2 / Real.sqrt 45)) :
    roundsToOfficialDegrees
      (radiansToDegrees (signedDeflection (S := S) u)) := by
  obtain ⟨hb_lo, hb_hi⟩ := arctan_deg_band
  have hpi_pos := Real.pi_pos
  rw [hdelta]
  unfold roundsToOfficialDegrees radiansToDegrees
  rw [show (-Real.arctan (2 / Real.sqrt 45)) * (180 / Real.pi) =
      -(Real.arctan (2 / Real.sqrt 45) * (180 / Real.pi)) by ring]
  constructor
  · have hb_hi' : Real.arctan (2 / Real.sqrt 45) * (180 / Real.pi) ≤ (16605:ℝ)/1000 := by
      rw [mul_div_assoc', div_le_iff₀ hpi_pos]
      rw [mul_div_assoc', div_lt_iff₀ hpi_pos] at hb_hi
      linarith
    linarith
  · have hb_lo' : (16595:ℝ)/1000 < Real.arctan (2 / Real.sqrt 45) * (180 / Real.pi) := by
      rw [mul_div_assoc', lt_div_iff₀ hpi_pos]
      rw [mul_div_assoc', lt_div_iff₀ hpi_pos] at hb_lo
      exact hb_lo
    linarith

/-- **Main target (T1-B2, 2.5 pts).**  Under the two-body Coulomb model
of Fig. 1b with `mu = 15/2` (unbound case), there exists an asymptotic
relative velocity `u_inf` of `e+` with respect to `e-`, and its signed
deflection `delta` from the initial line of motion of `e+` equals
the exact value `-arctan(2 / sqrt 45)` radians, whose degree reading
rounds to the official `-16.60` degrees.  The negative sign
("16.60 degrees BELOW the initial line of motion") is carried by the
branch condition `perp u0 u_inf ≤ 0` inside
`IsAsymptoticRelativeVelocity.direction_toward_pair` together with the
sharp branch, `signedDeflection_eq_neg_angle`.  The recorded official
value first appears here, conclusion-side; every hypothesis is a
governing law, a figure readout, or a derivable bridge.
(ITER-011 REDRAFT: the previous exact value
`-(pi - 2 arctan(2/sqrt 63))` (≈ -151.71 deg) was false for the
periapsis-referenced scenario and inconsistent with the band below;
`-arctan(2/sqrt 45)` ≈ -16.6015 deg is the `eps^2 = 49/4` value.) -/
theorem signed_deflection_angle_T1_B2 {hR : ScalingRegime}
    (S : CoulombScatteringData hR) (hμ : IsAngularMomentumFactor unboundMu) :
    ∃ u : RelativeVelocityVector, ∃ delta : ℝ,
      IsAsymptoticRelativeVelocity S u ∧
        delta = signedDeflection (S := S) u ∧
        delta = -Real.arctan (2 / Real.sqrt 45) ∧
        roundsToOfficialDegrees (radiansToDegrees delta) := by
  -- Assembly: existence of `u∞` and the exact signed value are precisely
  -- the Kepler-layer bridges (`exists_asymptoticRelativeVelocity` for the
  -- limit, `signed_deflection_eq_formula` with `eccentricity_sq_eq`
  -- (proved: `eps² = 49/4`) and the periapsis-referenced asymptote
  -- identity `1/√(eps²-1) = 2/√45` (proved in
  -- `asymptote_factor_certificate` below), the strict branch via the
  -- positive arctangent, and `signedDeflection_eq_neg_angle` (proved) for
  -- the sign).  The rounding band is `signed_deflection_certificate`,
  -- proved above from `arctan_deg_band`.  This last sorry is exactly the
  -- un-relaxed Kepler-layer gap (existence of `u∞` with its formula); no
  -- algebraic/numeric gap remains.
  obtain ⟨u, hu⟩ := exists_asymptoticRelativeVelocity S hμ
  obtain ⟨_, hform⟩ := signed_deflection_eq_formula S u hu hμ
  have hE : S.eccentricitySq = 49 / 4 := eccentricity_sq_eq S hμ
  have hs45 : Real.sqrt (S.eccentricitySq - 1) = Real.sqrt 45 / 2 := by
    rw [hE]
    have h454 : (49 / 4 : ℝ) - 1 = (Real.sqrt 45 / 2) ^ 2 := by
      rw [div_pow, Real.sq_sqrt (by norm_num)]
      norm_num
    rw [h454, Real.sqrt_sq (by positivity)]
  have hangle : angleBetween (initialDirection (S := S)) u.vec =
      Real.arctan (2 / Real.sqrt 45) := by
    rw [hform, hs45]
    congr 1
    field_simp
  have hA_pos : (0:ℝ) < Real.arctan (2 / Real.sqrt 45) :=
    Real.arctan_pos.mpr (by positivity)
  have hbranch : perp (initialDirection (S := S)) u.vec < 0 := by
    have hne : perp (initialDirection (S := S)) u.vec ≠ 0 := by
      intro hz
      have ha_ne : initialDirection (S := S) ≠ 0 := by
        dsimp [initialDirection]
        obtain ⟨hv0, _⟩ := S.initial_speed_value
        intro hzero
        exact hv0 (by simpa using hzero)
      have hu_ne : u.vec ≠ 0 := hu.u_inf_ne_zero
      have ha_norm : (0:ℝ) < ‖initialDirection (S := S)‖ :=
        norm_pos_iff.mpr ha_ne
      have hu_norm : (0:ℝ) < ‖u.vec‖ := norm_pos_iff.mpr hu_ne
      have hL : dot (initialDirection (S := S)) u.vec ^ 2 +
          perp (initialDirection (S := S)) u.vec ^ 2 =
          ‖initialDirection (S := S)‖ ^ 2 * ‖u.vec‖ ^ 2 := by
        have hu0s : ‖initialDirection (S := S)‖ ^ 2 =
            ((initialDirection (S := S)) 0) ^ 2 +
              ((initialDirection (S := S)) 1) ^ 2 := by
          rw [EuclideanSpace.norm_sq_eq, Fin.sum_univ_two]
          simp [sq_abs]
        have huvs : ‖u.vec‖ ^ 2 = (u.vec 0) ^ 2 + (u.vec 1) ^ 2 := by
          rw [EuclideanSpace.norm_sq_eq, Fin.sum_univ_two]
          simp [sq_abs]
        have hring : dot (initialDirection (S := S)) u.vec ^ 2 +
            perp (initialDirection (S := S)) u.vec ^ 2 =
            (((initialDirection (S := S)) 0) ^ 2 +
              ((initialDirection (S := S)) 1) ^ 2) *
            ((u.vec 0) ^ 2 + (u.vec 1) ^ 2) := by
          simp only [dot, perp]
          ring
        rw [hring, hu0s, huvs]
      rw [hz] at hL
      simp only [ne_eq, OfNat.ofNat_ne_zero, not_false_eq_true, zero_pow,
        add_zero] at hL
      have hratio_sq : (dot (initialDirection (S := S)) u.vec /
          (‖initialDirection (S := S)‖ * ‖u.vec‖)) ^ 2 = 1 := by
        rw [div_pow]
        field_simp [ha_norm.ne', hu_norm.ne']
        exact hL
      have hratio : dot (initialDirection (S := S)) u.vec /
          (‖initialDirection (S := S)‖ * ‖u.vec‖) = 1 ∨
          dot (initialDirection (S := S)) u.vec /
            (‖initialDirection (S := S)‖ * ‖u.vec‖) = -1 :=
        sq_eq_one_iff.mp hratio_sq
      have hlt : Real.arctan (2 / Real.sqrt 45) < Real.pi / 2 :=
        Real.arctan_lt_pi_div_two _
      have hform2 : Real.arccos (dot (initialDirection (S := S)) u.vec /
          (‖initialDirection (S := S)‖ * ‖u.vec‖)) =
          Real.arctan (2 / Real.sqrt 45) := by
        have h3 := hangle
        rw [angleBetween] at h3
        exact h3
      cases hratio with
      | inl h1 =>
        rw [h1, Real.arccos_one] at hform2
        linarith
      | inr h1 =>
        rw [h1, Real.arccos_neg_one] at hform2
        linarith [Real.pi_pos]
    exact lt_of_le_of_ne hu.direction_toward_pair hne
  refine ⟨u, signedDeflection (S := S) u, hu, rfl, ?_,
    signed_deflection_certificate hu hbranch ?_⟩
  · exact (signedDeflection_eq_neg_angle S u hu hbranch).trans (by rw [hangle])
  · exact (signedDeflection_eq_neg_angle S u hu hbranch).trans (by rw [hangle])

/-- Algebraic certificate for the equal-mass eccentricity value: the
hyperbola `eps^2 = 49/4` makes the scattering asymptote factor
`1/sqrt(eps^2-1) = 2/sqrt(45)`, so the exact signed deflection in
`signed_deflection_angle_T1_B2` has the stated closed form.  Pure
algebra up to the square-root identity `sqrt(45/4) = sqrt 45 / 2`.
(ITER-011 REDRAFT: previously the false `67/4` / `2/sqrt 63` pair.) -/
theorem asymptote_factor_certificate :
    1 / Real.sqrt ((49 / 4 : ℝ) - 1) = 2 / Real.sqrt 45 := by
  have h454 : (45 / 4 : ℝ) = (Real.sqrt 45 / 2) ^ 2 := by
    rw [div_pow, Real.sq_sqrt (by norm_num)]
    norm_num
  have halg : (49 / 4 : ℝ) - 1 = 45 / 4 := by norm_num
  rw [halg, h454, Real.sqrt_sq (by positivity)]
  field_simp

/-- A real `x` rounds to the official magnitude `16.60` degrees, i.e. to
two decimal places in the sense of the official marking scheme:
`16.595 ≤ x < 16.615`. -/
def roundsToOfficialDegreesAbs (x : ℝ) : Prop :=
  (16595 : ℝ) / 1000 ≤ x ∧ x < (16615 : ℝ) / 1000

/-- Magnitude corollary: the unsigned deflection angle between `u_inf` and
the initial line of motion of `e+` equals the exact value
`arctan(2 / sqrt 45)` radians, whose degree reading rounds to the
official `16.60` degrees below the initial line of motion.
(ITER-011 REDRAFT: previously the false `pi - 2 arctan(2/sqrt 63)`
value ≈ 151.71 deg, which its own band excluded.) -/
theorem unsigned_deflection_angle_in_degrees_T1_B2 {hR : ScalingRegime}
    (S : CoulombScatteringData hR) (hμ : IsAngularMomentumFactor unboundMu) :
    ∃ u : RelativeVelocityVector,
      IsAsymptoticRelativeVelocity S u ∧
        angleBetween (initialDirection (S := S)) u.vec =
          Real.arctan (2 / Real.sqrt 45) ∧
        roundsToOfficialDegreesAbs
          (radiansToDegrees (angleBetween (initialDirection (S := S)) u.vec)) := by
  -- Same shape as the signed target: the rounding band is
  -- `arctan_deg_band` (proved); the remaining sorry is the Kepler-layer
  -- existence plus deflection evaluation (`exists_asymptoticRelativeVelocity`
  -- and `signed_deflection_eq_formula` with the proved certificates
  -- `eccentricity_sq_eq` and `asymptote_factor_certificate`).
  obtain ⟨u, hu⟩ := exists_asymptoticRelativeVelocity S hμ
  obtain ⟨_, hform⟩ := signed_deflection_eq_formula S u hu hμ
  have hE : S.eccentricitySq = 49 / 4 := eccentricity_sq_eq S hμ
  have hs45 : Real.sqrt (S.eccentricitySq - 1) = Real.sqrt 45 / 2 := by
    rw [hE]
    have h454 : (49 / 4 : ℝ) - 1 = (Real.sqrt 45 / 2) ^ 2 := by
      rw [div_pow, Real.sq_sqrt (by norm_num)]
      norm_num
    rw [h454, Real.sqrt_sq (by positivity)]
  have hangle : angleBetween (initialDirection (S := S)) u.vec =
      Real.arctan (2 / Real.sqrt 45) := by
    rw [hform, hs45]
    congr 1
    field_simp
  obtain ⟨hb_lo, hb_hi⟩ := arctan_deg_band
  have hpi_pos := Real.pi_pos
  refine ⟨u, hu, hangle, ?_⟩
  rw [hangle]
  unfold roundsToOfficialDegreesAbs radiansToDegrees
  have hrew : Real.arctan (2 / Real.sqrt 45) * (180 / Real.pi) =
      Real.arctan (2 / Real.sqrt 45) * 180 / Real.pi := by
    rw [mul_div_assoc]
  rw [hrew] at hb_lo hb_hi ⊢
  constructor
  · apply le_of_lt
    rw [div_lt_div_iff₀ (by norm_num) hpi_pos] at hb_lo ⊢
    nlinarith [hb_lo]
  · rw [div_lt_div_iff₀ hpi_pos (by norm_num)] at hb_hi ⊢
    nlinarith [hb_hi]

end

end IPhO2026.Problem1.B2
