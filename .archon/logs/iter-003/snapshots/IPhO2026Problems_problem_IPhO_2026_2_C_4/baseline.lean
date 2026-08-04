import Mathlib.Analysis.SpecialFunctions.Pow.Real
import Mathlib.Analysis.SpecialFunctions.Trigonometric.Basic
import Mathlib.Topology.Defs.Filter
import Physlib.Units.WithDim.Basic

/-!
# IPhO 2026, theoretical problem 2, part C.4

This file models the small-angle cusp of the caustic produced by the
half-cylindrical mirror in Figure 2g.  Scalar values are read in one fixed
length unit, while `WithDim` records their physical dimensions.
-/

namespace IPhO2026Problems.IPhO2026_2_C_4

open Filter
open scoped Topology

noncomputable section

/-- A scalar reading of a physical length. -/
abbrev LengthReading := WithDim Dimension.L𝓭 ℝ

/-- The dimension of the coefficient multiplying a length to the power `2 / 3`. -/
abbrev CubeRootLengthReading :=
  WithDim (Dimension.L𝓭 ^ (1 / 3 : ℚ)) ℝ

/--
The slope and intercept of a reflected ray in the Cartesian coordinate frame
of Figure 2g.  The slope is dimensionless and the intercept has length
dimension.
-/
structure ReflectedLineReadout where
  slope : ℝ
  intercept : LengthReading

/--
The optical data used in part C.4.

The angle parameter is dimensionless.  `causticX` and `causticY` are readings
in the Figure 2g frame: its origin is the center of the mirror's diameter, its
horizontal axis is that diameter, and the half-cylindrical mirror lies above
the axis.
-/
structure Figure2gOpticalSystem where
  radius : LengthReading
  radius_pos : 0 < radius.val
  reflectedLine : ℝ → ReflectedLineReadout
  causticX : ℝ → LengthReading
  causticY : ℝ → LengthReading

/--
The `x`-coordinate of the intersection of reflected ray `A`, incident at
angle `θ`, and neighboring reflected ray `B`, incident at `θ + Δθ`.
-/
def neighboringIntersectionX
    (system : Figure2gOpticalSystem) (θ Δθ : ℝ) : ℝ :=
  let rayA := system.reflectedLine θ
  let rayB := system.reflectedLine (θ + Δθ)
  (rayB.intercept.val - rayA.intercept.val) / (rayA.slope - rayB.slope)

/--
The `y`-coordinate of the same neighboring-ray intersection, obtained from
the reflected-line equation `y = m_A x + b_A`.
-/
def neighboringIntersectionY
    (system : Figure2gOpticalSystem) (θ Δθ : ℝ) : ℝ :=
  let rayA := system.reflectedLine θ
  rayA.slope * neighboringIntersectionX system θ Δθ + rayA.intercept.val

/--
The governing caustic-envelope law: the caustic point at angle `θ` is the
limit of intersections of reflected rays whose incidence-angle separation
`Δθ` tends to zero through nonzero values.
-/
def NeighboringReflectedRaysGenerateCaustic
    (system : Figure2gOpticalSystem) : Prop :=
  ∀ θ : ℝ,
    Tendsto (fun Δθ => neighboringIntersectionX system θ Δθ)
        (𝓝[≠] 0) (𝓝 (system.causticX θ).val) ∧
      Tendsto (fun Δθ => neighboringIntersectionY system θ Δθ)
        (𝓝[≠] 0) (𝓝 (system.causticY θ).val)

/--
The reusable conclusion of part C.3, stated directly rather than importing
that part's Lean output.
-/
def HasPreviousPartC3Coordinates
    (system : Figure2gOpticalSystem) : Prop :=
  ∀ θ : ℝ,
    (system.causticX θ).val = system.radius.val * Real.sin θ ^ 3 ∧
      (system.causticY θ).val =
        (system.radius.val / 2) * Real.cos θ * (2 - Real.cos (2 * θ))

/--
For small nonzero `θ`, the Figure 2g caustic has the leading-order cusp
`Y_c = v |X_c|^(p/q) + u`.  The `Tendsto` conclusion is the rigorous
leading-order interpretation: `(Y_c - u) / |X_c|^(p/q)` tends to `v`.

The theorem determines the two dimensioned coefficients and the two integer
exponents requested in part C.4.
-/
theorem determineSmallAngleCaustic
    (system : Figure2gOpticalSystem)
    (hEnvelope : NeighboringReflectedRaysGenerateCaustic system)
    (hC3 : HasPreviousPartC3Coordinates system) :
    ∃ (u : LengthReading) (v : CubeRootLengthReading) (p q : ℤ),
      u.val = system.radius.val / 2 ∧
      v.val =
        (3 / 4 : ℝ) * Real.rpow system.radius.val (1 / 3 : ℝ) ∧
      p = 2 ∧
      q = 3 ∧
      Tendsto
          (fun θ =>
            ((system.causticY θ).val - u.val) /
              Real.rpow |(system.causticX θ).val|
                ((p : ℝ) / (q : ℝ)))
          (𝓝[≠] 0) (𝓝 v.val) := by
  sorry

end

end IPhO2026Problems.IPhO2026_2_C_4
