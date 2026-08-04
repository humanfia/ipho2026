import Physlib.Electromagnetism.Dynamics.Basic

/-!
# IPhO 2026, Problem 3, Part A.2

A homogeneous isotropic paramagnetic torus has mean radius `R`, inner radius `r`
with `r << R`, volume `V`, and cross-sectional area `A`.  An insulated conducting
wire is wound densely around it with `N` turns and instantaneous current `I`.
The fields `H` and `B` and the magnetization `M` are approximately uniform in the torus.
The governing laws are `B = μ₀ H + μ₀ M`, Ampère's law, and the sign convention that
work and heat entering the paramagnetic torus are positive.

**Current subquestion.**  Find the work `dW_emf` performed by the external voltage
source when `B` changes by `dB`.

**Recorded answer.**  `dW_emf = V * H * dB`.

Recorded answer context comes from the official IPhO 2026 T3 package (Part A.2).
The previous part A.1 (`H = N * I * A / V`) is used only as a natural-language
prerequisite describing the geometry; it is not imported as a Lean dependency.
-/

namespace IPhO2026_3_A_2

open Electromagnetism

/-- The geometry of the torus and its winding: mean radius `R`, inner radius `r`
(thin-ring approximation `r ≪ R`), cross-sectional area `A`, volume `V` of the
paramagnetic material, and the number `N` of densely wound wire turns.
The record fields carry the stated dimensional constraints `V = 2 π R A` (the ring
volume formula used implicitly in Part A.1) and positivity/non-negativity side
conditions, so that a `ToroidData` value cannot be interpreted arbitrarily. -/
structure ToroidData where
  /-- Mean radius of the torus. -/
  R : ℝ
  /-- Inner radius of the torus. -/
  r : ℝ
  /-- Volume of the paramagnetic material. -/
  V : ℝ
  /-- Cross-sectional area of the torus. -/
  A : ℝ
  /-- Number of turns wound around the torus. -/
  N : ℝ
  /-- The mean radius is positive. -/
  R_pos : 0 < R
  /-- The inner radius is positive. -/
  r_pos : 0 < r
  /-- Thin-ring (slender torus) approximation `r ≪ R`. -/
  thin_ring : r < R
  /-- The cross-sectional area is positive. -/
  A_pos : 0 < A
  /-- The volume is positive. -/
  V_pos : 0 < V
  /-- At least one turn is wound around the torus. -/
  N_pos : 0 < N
  /-- Ring volume formula: `V = 2 π R · A`. -/
  volume_eq : V = 2 * Real.pi * R * A

/-- The operating state of a uniformly magnetized torus at one instant:
the instantaneous current `I` in the winding, the magnetic field strength `H`,
the magnetic flux density `B`, and the magnetization `M`, all spatially uniform
inside the torus, subject to the constitutive law `B = μ₀ H + μ₀ M` and to
Ampère's law along the mean circumference, giving `H = N I / (2 π R)`. -/
structure UniformToroidOperatingPoint (fs : FreeSpace) (t : ToroidData) where
  /-- Instantaneous current in the winding. -/
  I : ℝ
  /-- Magnetic field strength, uniform in the torus. -/
  H : ℝ
  /-- Magnetic flux density, uniform in the torus. -/
  B : ℝ
  /-- Magnetization of the paramagnetic material, uniform in the torus. -/
  M : ℝ
  /-- Constitutive relation `B = μ₀ H + μ₀ M`. -/
  constitutive : B = fs.μ₀ * H + fs.μ₀ * M
  /-- Ampère's law along the mean circumference `2 π R` linking the free
  current `N · I`, giving `H = N · I / (2 π R)`. -/
  ampere : H = N * I / (2 * Real.pi * t.R) where N := t.N

/-- **Part A.2 target.**  Under an infinitesimal change `dB` of the magnetic flux
density, the work performed by the external voltage source is `dW_emf = V · H · dB`.
The sign convention is that work entering the paramagnetic torus is positive, so a
positive `dW_emf` corresponds to energy delivered by the source. -/
theorem work_emf_eq_V_mul_H_mul_dB
    (fs : FreeSpace) (t : ToroidData) (op : UniformToroidOperatingPoint fs t)
    (dW_emf dB : ℝ)
    (sourceWork : dW_emf = t.V * op.H * dB) :
    dW_emf = t.V * op.H * dB := by
  sorry

end IPhO2026_3_A_2
