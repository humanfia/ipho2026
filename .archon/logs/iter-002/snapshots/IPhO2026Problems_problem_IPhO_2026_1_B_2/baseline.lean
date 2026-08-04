import Physlib

/-!
# IPhO 2026, Problem 1 (T1), Part B.2 — Electron-positron scattering angle

## Physical setting

At one instant a positron `e+` and an electron `e-`, each of mass `m` and
charges of equal magnitude `e` and opposite sign, are separated by `100 * a0`,
where `a0 = 4 * pi * eps0 * hbar^2 / (m * e^2)` is the Bohr radius. Their
velocities are antiparallel and perpendicular to their separation
(Fig. 1b of the exam), and each particle carries angular momentum of
magnitude `mu * hbar` about the common center of mass. The system is
isolated, classical, non-relativistic, and the only interaction is the
electrostatic Coulomb attraction with constant `k = 1 / (4 * pi * eps0)`.

## Current subquestion (B.2)

For `mu = 15/2` the pair is unbound (hyperbolic scattering). Let `u_inf` be
the relative velocity of `e+` with respect to `e-` as the separation tends
to infinity. Find the angle between `u_inf` and the initial line of motion
of `e+`, in degrees. (Official answer: signed deflection `-16.60` degrees,
i.e. 16.60 degrees below the initial line of motion.)

## Formalization notes

* Because the particles have equal masses and opposite velocities, the
  motion reduces exactly (no approximation) to the planar Coulomb/Kepler
  problem for the relative coordinate `r_rel = r_positron - r_electron`
  with effective mass `m/2`. The structure `ElectronPositronScenario`
  packages the physical assumptions (governing law = attractive Coulomb
  Newton equation, initial geometry from Fig. 1b, per-particle angular
  momentum `mu * hbar`, unboundness).
* The exam hints `eps = sqrt(1 + 4 L^2 E / (k^2 e^4 m))` and the conic
  equation `r = a / (1 - eps cos theta)` enter only as *derivable* bridge
  lemmas (`totalEnergy_tendsto_atTop`, `orbit_is_conic`,
  `eccentricity_eq`, `asymptotic_deflection_angle_formula`) leading to the
  main theorem `signed_deflection_angle_eq`; they are not assumed.
-/

open Constants Filter Real

