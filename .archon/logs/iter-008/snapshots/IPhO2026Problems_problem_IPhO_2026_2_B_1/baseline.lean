/-
IPhO 2026, Theoretical Problem 2 (Solar Cooker), Part B.1 — autoformalization.

Physical situation (Figure 2f, official source page `T2_page-3.png`). A
half-hollow-cylinder mirror of radius `R` (mirrored on the inside) is
illuminated by uniform parallel sunlight arriving along the mirror's optical
axis. A fully absorbing cylindrical container of radius `a` has its axis
parallel to the mirror axis; the container's centre lies `R / 2` from the
mirror centre on the system's symmetry plane. Every absorbed ray reflects
from the mirror at most once. `θ_max` is the maximum angle of incidence on
the mirror (measured against the normal at the point of incidence) among all
reflected rays striking the container, and `P₀` is the power the cylinder
would receive without the mirror.

Current subquestion (T2-B1): the container radius satisfies
`a = α * sin θ_max + β * sin (2 * θ_max)`; write `α` and `β` in terms of `R`.

Recorded official answer: `α = R` and `β = -R / 2` (kept strictly
conclusion-side in the target theorem; not fed into any structure field or
hypothesis).

This file is a by-`sorry` formalization: faithful declarations with proof
bodies left as `sorry`. The physics is modelled on a transverse
cross-section (the system is translationally invariant along the cylinder
axes), so points and direction vectors are pairs of real coordinates
carrying the dimension of length (directions are unit, hence dimensionless).

Cross-sectional frame (fixed by Figure 2f and cross-checked against the
official B.2/B.3 answers): mirror centre `C = (0, 0)`; the cross-sectional
image of the symmetry plane is the `y`-axis (the bisector of the
half-cylinder, perpendicular to the aperture diameter); the container
centre is `A = (0, -R / 2)`, i.e. `R / 2` from `C` along the symmetry axis
toward the mirrored belly (downstream of the sunlight); sunlight arrives
along direction `(0, -1)` onto the lower half-circle `y ≤ 0`, the open
aperture facing `y > 0`. The ray with impact parameter `x` strikes the
mirror at `(x, -√(R² - x²))`; by the symmetry of the configuration about
the `y`-axis the absorbed columns form a centred contiguous fan
`|x| ≤ x★`, whose extremal columns `±x★` are exactly the rays tangent to
the container circle. `θ_max = arcsin (x★ / R)`.

Governing physical laws (kept as hypotheses, never redefined locally):
specular reflection on the circular mirror profile (`reflection_law`),
absorption by the container disc (`absorbed_law`), the container-offset
geometry (`A_coord`), and the single-bounce contiguous-fan ray bookkeeping
(`no_gap`, `hit_branch`).

Key determinacy bridge: at an extremal column `x★` the reflected ray is
tangent to the container circle. `reflection_law` at column `x` is a
two-by-two linear system on the reflected-line scalars `(m x, b x)` with
nonzero determinant (the incoming axial ray is fully reversed in the
tangent direction by the circular-profile specular law), whose solution is
`b = -R² / (2 √(R² - x²))` — always negative with `|b| ≥ R / 2` — and the
tangency distance condition `|distToLine (line x) A| = a` then evaluates
(both mirror-image branches, via `|x|`) to the B.1 geometric identity
`a = R * sin θ_max - (R / 2) * sin (2 * θ_max)`. No sign branch is lost:
the signed-distance numerator `-R / 2 - b` is strictly positive for every
extremal column, so the absolute value resolves without extra case data.
The coefficient pair is then fixed because the given ansatz is a family
identity: the same `α, β` apply at the extremal angle of every cooker of
the same mirror radius (the later parts of the problem use exactly this),
and two distinct extremal angles give an invertible two-by-two linear
system for `(α - R, β + R / 2)`.
-/

import Mathlib

open Real Set

noncomputable section

namespace IPhO2026_2_B_1

/-- Points and vectors of the transverse cross-sectional plane: pairs of
real coordinates carrying the dimension of length. A plain pair type (not a
scalar alias) keeps the two-dimensional geometry of Figure 2f intact. -/
abbrev Vec : Type := ℝ × ℝ

/-- Euclidean norm of a cross-sectional vector; a length (or dimensionless
for unit direction vectors). -/
def vnorm (v : Vec) : ℝ := Real.sqrt (v.1 ^ 2 + v.2 ^ 2)

/-- Non-vertical lines `Y = m * X + b` in the cross-sectional plane: slope
`m` (dimensionless) and intercept `b` (a length). -/
structure Line2D where
  m : ℝ
  b : ℝ

/-- Signed distance from the point `q` to the line `r`: a length.
`distToLine r q = 0` means `q` lies on `r`. -/
def distToLine (r : Line2D) (q : Vec) : ℝ :=
  (q.2 - r.m * q.1 - r.b) / Real.sqrt (r.m ^ 2 + 1)

/-- Dimensionful parameters of the cooker of Figure 2f: mirror radius `R`
and container radius `a` (both lengths, hence positive). -/
structure CookerParams where
  R : ℝ
  a : ℝ
  hR : 0 < R
  ha : 0 < a

/-- Specular bookkeeping for the Figure-2f cooker: the parallel ray with
impact parameter `x` (its signed distance from the symmetry axis, a length)
strikes the half-cylinder mirror of radius `R` and the reflected
(non-vertical) line is recorded as `reflectedLine x`. All fields state
physical laws or figure readouts; none of them states the current
subquestion's coefficient answer. -/
structure CookerB1 (p : CookerParams) where
  /-- Mirror centre `C` of the cross-section. -/
  C : Vec
  /-- Container centre `A` of the cross-section. -/
  A : Vec
  /-- The Figure-2f frame: mirror centre at the origin; container centre on
  the symmetry axis (the cross-sectional image of the symmetry plane), at
  distance `R / 2` from `C` toward the mirrored belly. -/
  C_coord : C = (0, 0)
  A_coord : A = (0, -(p.R / 2))
  /-- The cross-sectional profile of the half-cylinder mirror: the half of
  the circle of radius `R` about `C` facing the incoming sunlight
  (`v.2 ≤ C.2`; the open aperture faces `v.2 > C.2`). -/
  mirrorSet : Set Vec
  mirrorSet_eq : mirrorSet =
    {v : Vec | vnorm (v.1 - C.1, v.2 - C.2) = p.R ∧ v.2 ≤ C.2}
  /-- The absorbing container cross-section: the closed disc of radius `a`
  about `A`. -/
  containerSet : Set Vec
  containerSet_eq : containerSet =
    {v : Vec | vnorm (v.1 - A.1, v.2 - A.2) ≤ p.a}
  /-- Reflected line `Y = (m x) * X + (b x)` of the absorbed ray with impact
  parameter `x`. Slopes and intercepts are records, not computed answers;
  the specular law below constrains them physically. -/
  reflectedLine : ℝ → Line2D
  /-- Impact parameters of the rays that are absorbed by the container
  after exactly one reflection at the mirror. -/
  hitSet : Set ℝ
  /-- Every absorbed ray reflects on the half-mirror arc: its mirror point
  has norm `R` on the sunlit half. -/
  on_mirror : ∀ x ∈ hitSet, (x, -Real.sqrt (p.R ^ 2 - x ^ 2)) ∈ mirrorSet
  /-- Law of specular reflection on the circular mirror profile (governing
  physical law, stated as incidence data rather than as a solved formula):
  the reflected line passes through the mirror point, and the specular
  reflection of the incoming axial direction `(0, -1)` in the tangent line
  at the mirror point `(x, y)`, `y = -√(R² - x²)` — the direction
  `(2 * x * y, y ^ 2 - x ^ 2)` — is a direction vector of the reflected
  line: `(2 * x * y) * m = y ^ 2 - x ^ 2`, here with the sign resolution
  `y = -√(R² - x²)` already applied. -/
  reflection_law : ∀ x ∈ hitSet,
    -Real.sqrt (p.R ^ 2 - x ^ 2) =
        (reflectedLine x).m * x + (reflectedLine x).b ∧
      (x ^ 2 - Real.sqrt (p.R ^ 2 - x ^ 2) ^ 2) =
        (reflectedLine x).m * (2 * x * Real.sqrt (p.R ^ 2 - x ^ 2))
  /-- Absorption law: every ray of the family reaches the container disc —
  its reflected line passes through `containerSet`. -/
  absorbed_law : ∀ x ∈ hitSet,
    ∃ q ∈ containerSet,
      q.2 = (reflectedLine x).m * q.1 + (reflectedLine x).b
  /-- Ray-family branch: all absorbed impact parameters lie inside the open
  aperture `(-R, R)`. -/
  hit_branch : ∀ x ∈ hitSet, x ∈ Set.Ioo (-p.R) p.R
  /-- The absorbed columns form a contiguous fan centred on the symmetry
  axis (Figure 2f is symmetric under `x ↦ -x`): no gaps between the axial
  ray and any absorbed ray. -/
  no_gap : ∀ x₁ x₂ : ℝ, x₁ ∈ hitSet → |x₂| ≤ |x₁| → x₂ ∈ hitSet

/-- Incidence angle of the ray with impact parameter `x` on the circular
mirror profile, measured against the radial normal at the mirror point:
`arcsin (|x| / R)`. Dimensionless. -/
def incidenceAngle (p : CookerParams) (x : ℝ) : ℝ :=
  Real.arcsin (|x| / p.R)

/-- Specification of `θ_max`: attained by a ray of the absorbed family,
bounding the incidence angles of all absorbed rays, and lying on the acute
branch `0 < θ_max < π / 2` seen in Figure 2f. -/
def IsThetaMax (p : CookerParams) (s : CookerB1 p) (θ : ℝ) : Prop :=
  θ ∈ Set.Ioo 0 (Real.pi / 2) ∧
    (∃ x ∈ s.hitSet, incidenceAngle p x = θ) ∧
      (∀ x ∈ s.hitSet, incidenceAngle p x ≤ θ)

/-- Inside the open aperture the impact-parameter magnitude is recovered
from the incidence angle as `|x| = R * sin θ`; the absolute value absorbs
the two mirror-image branches `±|x|` of Figure 2f. -/
lemma impactParam_eq_sin (p : CookerParams) {x θ : ℝ}
    (hx : x ∈ Set.Ioo (-p.R) p.R) (hθ : incidenceAngle p x = θ) :
    |x| = p.R * Real.sin θ := by
  sorry

/-- Positivity flashpoint for `sin (2 θ)` on the acute branch
`θ ∈ (0, π / 2)`, used to keep the coefficient identification
nondegenerate. -/
lemma sin_two_pos {θ : ℝ} (hθ : θ ∈ Set.Ioo 0 (Real.pi / 2)) :
    0 < Real.sin (2 * θ) := by
  sorry

/-- Extremality and tangency bookkeeping at a limiting ray (a ray attaining
`θ_max`). The extremal column belongs to the absorbed family, realizes the
extremal angle, is off the symmetry axis (the two mirror-image tangent
columns `±|x|` of Figure 2f, the absolute value in `incidenceAngle`
absorbing the branch), and its reflected line is tangent to the container
circle: it stays a signed-distance magnitude `a` from the container centre.
Together with `reflection_law` — a two-by-two linear system of nonzero
determinant — the tangency condition determines the container radius from
the extremal column, so this interface cannot be filled with arbitrary
line data. -/
structure ExtremalRaySpec (p : CookerParams) (s : CookerB1 p) (θ : ℝ) where
  x : ℝ
  hx : x ∈ s.hitSet
  hθ : incidenceAngle p x = θ
  /-- The extremal ray is off-axis: `θ_max > 0` columns are mirror-image
  pairs `±|x|` tangent to opposite silhouette generators of the container. -/
  off_axis : x ≠ 0
  /-- Tangency distance: the limiting reflected line passes exactly one
  container radius `a` from the container centre. -/
  tangent_dist : |distToLine (s.reflectedLine x) s.A| = p.a

/-- The given ansatz of the subquestion, in the sense the problem intends
and itself uses in the later parts (where `θ_max` varies with the container
size at fixed mirror radius `R`): one coefficient pair `α, β` expresses the
container radius at every extremal (tangent) configuration of the
Figure-2f cooker family of that same mirror radius. The real scalars `α, β`
parametrize the given ansatz — the specification never evaluates them. -/
def CoeffSpec (p : CookerParams) (α β : ℝ) : Prop :=
  ∀ (q : CookerParams), q.R = p.R → ∀ (s : CookerB1 q) (θ₁ : ℝ),
    IsThetaMax q s θ₁ →
    (∀ _e : ExtremalRaySpec q s θ₁, q.a = α * Real.sin θ₁ + β * Real.sin (2 * θ₁))

/-- A second extremal configuration in the same mirror-radius family: the
cooker family of Figure 2f contains configurations with a different
extremal angle (the later parts of the problem vary the container size at
fixed `R`). Its existence is a readout of the physical family, not of the
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
