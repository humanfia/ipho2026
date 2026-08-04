# Prover result: IPhO 2026 Problem 1 B.2

## Status

Partial, with one focused `sorry` remaining in
`IPhO2026Problems.IPhO2026_1_B_2.IPhO_2026_1_B_2`.

`lake env lean IPhO2026Problems/problem_IPhO_2026_1_B_2.lean` succeeds and
reports only the expected `declaration uses sorry` warning. No axiom,
`sorryAx`, `admit`, `native_decide`, macro, or custom elaborator was added.

## Proven progress

The proof body now formally derives:

- positivity of every separation and of the conic denominator;
- orthogonality of the two frame directions and unit absolute oriented area;
- the positron/electron offsets from the center of mass;
- equality of the two signed angular momenta and
  `L = 2 * μ * ℏ`;
- the speed/angular-momentum relation and the initial speed formula;
- `m * k * e^2 * a₀ = ℏ^2` from the two supplied constant identities;
- the initial separation and both initial speed norms;
- `E = k * e^2 / (80 * a₀)`;
- `orbit.eccentricity = 7 / 2`;
- the Cartesian conic equation;
- convergence of the conic denominator to zero and of the asymptotic polar
  cosine to `2 / 7`.

Thus the remaining placeholder no longer hides the energy, angular-momentum,
eccentricity, or basic conic-limit algebra.

## Remaining blocker

The available conic laws determine the limiting **position** asymptote through
the normalized displacement-axis component. The conclusion concerns the
signed angle of the limiting **relative velocity** `uInfinity`. The current
contract contains `positionDerivative` and the separate velocity limit, but
does not provide an outgoing-asymptote theorem that:

1. turns those analytic hypotheses into convergence of the normalized
   displacement direction to `uInfinity / ‖uInfinity‖`, and
2. selects the outgoing (negative-angle) branch relative to
   `frame.initialPositronDirection`.

After that bridge, the final remaining analytic obligation is a certified
enclosure showing that
`-Real.arcsin (2 / 7) * 180 / Real.pi` lies within `1/200` degree of `-83/5`.

## Redraft needed

- Original problem: `IPhO_2026_1`, part B.2.
- Source report:
  `reports/ipho_2026/problem_IPhO_2026_1_B_2.source.json`.
- Theorem:
  `IPhO2026Problems.IPhO2026_1_B_2.IPhO_2026_1_B_2`.
- Issue: the frozen theorem requires a substantial unstated
  derivative-to-outgoing-asymptote branch theorem before the supplied polar
  conic law can control the signed limiting-velocity angle.
- Smallest faithful change: add a general (non-numerical) outgoing hyperbolic
  asymptote hypothesis, for example
  `frame.orientation.oangle (velocitySI motion .positron 0) uInfinity =
    ((-Real.arcsin (1 / orbit.eccentricity) : ℝ) : Real.Angle)`.
  This states the missing general scattering law without assuming the rounded
  answer. The already-proved `eccentricity = 7/2` then reduces the target to a
  standalone rigorous arcsine enclosure.

## Blueprint marker

The theorem proof is not ready for proof-block `\leanok`; the deterministic
sync should leave it unmarked while the focused `sorry` remains.
