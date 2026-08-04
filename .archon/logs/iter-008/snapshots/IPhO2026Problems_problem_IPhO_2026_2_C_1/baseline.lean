import Mathlib

/-!
# IPhO 2026, Problem 2, Part C.1 — Slope and intercept of the reflected ray

Physical model (blueprint chapter
`blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_2_C_1.tex`,
Figure 2g on official source page `T2_page-4.png`):

* A half-cylindrical mirror of radius `R`, with the Figure 2g coordinate
  convention: the cylinder axis is the `y`-axis, the mirror cross-section is
  the upper half-circle `x ^ 2 + y ^ 2 = R ^ 2`, `y > 0`, and the `x`-axis
  marks the mirror diameter from `-R` to `R`.
* Ray A travels parallel to the `y`-axis and strikes the mirror at the point
  `P θ = (R * sin θ, R * cos θ)`, where the incidence angle `θ` is the angle
  between the ray and the inward radial normal at `P θ` (Figure 2g).
* Upon reflection the outgoing ray is the line `y = m_A θ * x + b_A θ`.
* A neighboring parallel ray B is incident at `θ + Δθ`, with `Δθ ≪ θ`; its
  reflected line is `y = m_B θ Δθ * x + b_B θ Δθ`.  The envelope of the
  reflected rays is the caustic (ray-B data is setup context for C.2–C.4).

Current subquestion (C.1, the proof target):
  `m_A θ = cot (2 * θ)`  (dimensionless slope), and
  `b_A θ = R / (2 * cos θ)`  (a length).
-/

open Real

namespace IPhO2026_2_C_1

/-- The physical setup of IPhO 2026 Problem 2, Part C.1: the half-cylindrical
mirror of radius `R`, the Figure 2g reflection point of the axial
(parallel-to-the-`y`-axis) ray A at incidence angle `θ`, and the
slope–intercept data of the reflected rays of ray A and of the neighboring
parallel ray B. All coordinates are Cartesian coordinates in the plane of
Figure 2g, hence real scalars; `R` and `b` carry the dimension of length,
the slopes and `θ` are dimensionless. -/
structure HalfCylindricalMirrorReflection where
  /-- Radius `R` of the half-cylindrical mirror (a length). -/
  R : ℝ
  /-- The mirror radius is positive. -/
  R_pos : 0 < R
  /-- X-coordinate of the point where the axial ray A strikes the mirror,
  as a function of the incidence angle `θ` (a length). -/
  P_x : ℝ → ℝ
  /-- Y-coordinate of that reflection point (a length). -/
  P_y : ℝ → ℝ
  /-- Slope `m_A θ` of the line reflected from ray A (dimensionless). -/
  m_A : ℝ → ℝ
  /-- Intercept `b_A θ` of the line reflected from ray A (a length). -/
  b_A : ℝ → ℝ
  /-- Slope `m_B θ Δθ` of the line reflected from the neighboring parallel
  ray B, incident at angle `θ + Δθ` with `Δθ ≪ θ` (dimensionless). -/
  m_B : ℝ → ℝ → ℝ
  /-- Intercept `b_B θ Δθ` of the line reflected from ray B (a length). -/
  b_B : ℝ → ℝ → ℝ
  /-- The incidence angle is confined to the acute branch of Figure 2g,
  where the axial ray hits the upper right quarter of the mirror. -/
  θ_branch : ∀ θ : ℝ, θ ∈ Set.Ioo 0 (π / 2)
  /-- Figure-2g coordinate readout: the axial ray A strikes the mirror at
  `(R * sin θ, R * cos θ)`, so the incidence angle `θ` coincides with the
  polar angle of the reflection point measured from the `y`-axis. -/
  P_eq : ∀ θ : ℝ, P_x θ = R * sin θ ∧ P_y θ = R * cos θ
  /-- Law of reflection on the half-cylindrical mirror at incidence angle
  `θ`, expressed in the Cartesian coordinates of Figure 2g. It fixes the
  geometry of the reflected line up to its two scalar invariants — the
  slope and the intercept — without exposing those invariants (extracting
  them is the content of the present subquestion). The unit outward radial
  normal at the reflection point is `(P_x θ, P_y θ) / R`, and
  `d θ = (1, m_A θ)` is a (unnormalized) direction vector of the reflected
  line `y = m_A θ * x + b_A θ`, with norm `Real.sqrt (m_A θ ^ 2 + 1)`:

  * the reflected line passes through the reflection point
    `(P_x θ, P_y θ)` (the ray strikes the mirror there);
  * the incoming ray direction `(0, 1)` (parallel to the `y`-axis) makes
    with the outward radial normal the angle labelled `θ` in Figure 2g:
    `P_y θ / R = cos θ`;
  * the outgoing ray makes the same angle `θ` with the outward radial
    normal (angle of reflection equals angle of incidence):
    `d θ · (P_x θ, P_y θ) / (R * |d θ|) = P_y θ / R`;
  * the tangential component of the outgoing ray along the clockwise unit
    tangent `(P_y θ, -P_x θ) / R` is the negative of that of the incoming
    ray (specular reversal), and on the Figure-2g branch it equals
    `P_x θ / R`. -/
  reflection_law :
    ∀ θ : ℝ,
      P_y θ = m_A θ * P_x θ + b_A θ ∧
      P_y θ / R = cos θ ∧
      (P_x θ + m_A θ * P_y θ) /
          (R * Real.sqrt (m_A θ ^ 2 + 1)) = P_y θ / R ∧
      (P_y θ - m_A θ * P_x θ) /
          (R * Real.sqrt (m_A θ ^ 2 + 1)) = P_x θ / R
  /-- Ray-B reflection law (the same specular law applied to the neighboring
  parallel ray, incident at angle `θ + Δθ` with `0 < Δθ ≪ θ`): its reflected
  line obeys the same four geometric constraints about its own reflection
  point `(P_x (θ + Δθ), P_y (θ + Δθ))`, with direction vector
  `(1, m_B θ Δθ)`. This records that the neighboring ray B is part of the
  same mirrored family, as stipulated in the setup. -/
  ray_B_reflection_law :
    ∀ θ Δθ : ℝ, 0 < Δθ → Δθ < θ →
      P_y (θ + Δθ) = m_B θ Δθ * P_x (θ + Δθ) + b_B θ Δθ ∧
      P_y (θ + Δθ) / R = cos (θ + Δθ) ∧
      (P_x (θ + Δθ) + m_B θ Δθ * P_y (θ + Δθ)) /
          (R * Real.sqrt (m_B θ Δθ ^ 2 + 1)) = P_y (θ + Δθ) / R ∧
      (P_y (θ + Δθ) - m_B θ Δθ * P_x (θ + Δθ)) /
          (R * Real.sqrt (m_B θ Δθ ^ 2 + 1)) = P_x (θ + Δθ) / R

namespace HalfCylindricalMirrorReflection

variable (s : HalfCylindricalMirrorReflection)

/-- The dimensions of the subquestion's answer: the intercept `b_A θ` is a
length, scaling linearly with the mirror radius `R` (the slope `m_A θ` is
dimensionless). -/
theorem intercept_is_length (θ : ℝ) :
    ∃ L : ℝ, L = s.R / (2 * cos θ) ∧ s.b_A θ = L := by
  sorry

/-- Reflected-ray slope (recorded answer to C.1): the slope of the line
reflected from ray A is `m_A θ = cot (2 * θ)`, a dimensionless quantity.
This is a target conclusion of the subquestion, not an assumption. -/
theorem reflected_ray_A_slope (θ : ℝ) :
    s.m_A θ = cot (2 * θ) := by
  sorry

/-- Reflected-ray intercept (recorded answer to C.1): the intercept of the
line reflected from ray A is `b_A θ = R / (2 * cos θ)`. This is a target
conclusion of the subquestion, not an assumption. -/
theorem reflected_ray_A_intercept (θ : ℝ) :
    s.b_A θ = s.R / (2 * cos θ) := by
  sorry

/-- Main formalization target for C.1: for the half-cylindrical mirror of
radius `R`, the line `y = m_A θ * x + b_A θ` reflected from the axial ray A
incident at angle `θ` (Figure 2g convention) has
`m_A θ = cot (2 * θ)` and `b_A θ = R / (2 * cos θ)`. -/
theorem reflected_ray_A_slope_and_intercept (θ : ℝ) :
    s.m_A θ = cot (2 * θ) ∧ s.b_A θ = s.R / (2 * cos θ) := by
  sorry

end HalfCylindricalMirrorReflection

end IPhO2026_2_C_1
