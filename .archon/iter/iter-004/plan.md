# Iteration 004 bounded proof plan

## Batch policy

- Keep the exact five-objective order below. Each is mandatory proof-Review retry 2 of at most 3; do not add targets.
- Preserve every theorem signature and physical hypothesis. Validate each target independently with the Lean LSP or `lake env lean <file>`.
- Do not manufacture a velocity/asymptote or tangent-path/radius consequence that is absent from the hypotheses. If the frozen contract is underdetermined, retain one honest `sorry` and report the missing relation precisely.
- The supplied blueprint excerpts accurately describe the physical questions and need no Plan-stage correction.

## Per-target strategies

1. **`IPhO2026Problems/problem_IPhO_2026_1_B_2.lean`** — Normalize `mu`, establish the hyperbolic branch and the two supplied limits, then inspect only the existing `ConicOrbitLaws` projections for a theorem identifying the direction/branch of `uInfinity` with the outgoing conic asymptote. If such a projection exists, rewrite the signed-angle definition, solve the asymptotic conic equation, select the outgoing branch using the limit/unbound facts, and discharge the sign and nearest-hundredth bounds by `norm_num`/real arithmetic. The shown hypotheses otherwise determine only the asymptotic position angle and allow no conclusion about the limiting velocity direction; do not close that gap from `Tendsto` alone, and leave the precise blocker honest.

2. **`IPhO2026Problems/problem_IPhO_2026_2_B_1.lean`** — Retry the sole open helper `radiusAtIncidence_from_figure2f`. Unpack `Figure2fReadout`, the limiting-path witness, tangency, one-reflection count, and incidence equality, and use an existing geometric consequence only if one actually states the radius equation
   `a(θ) = (sin θ - 1/2 * sin (2θ)) R`.
   Once available, the already-written coefficient proof evaluates at `π/2` to get `α = R` and at `π/4` to isolate `β = -R/2`, using `WithDim.ext`, the standard sine values, and linear arithmetic. In the supplied contract the path predicates have no equation connecting them to `radiusAtIncidence`; if no omitted record field supplies it, retain the helper `sorry` and report this logical insufficiency rather than treating abstract predicates as geometry.

3. **`IPhO2026Problems/problem_IPhO_2026_3_B_2.lean`** — Add only the calculus imports required for product/quotient derivative rules and interval constancy. Differentiate the equation of state on `Ioo 0 1` and combine it algebraically with the established adiabatic energy balance to prove
   `(λ + μ₀ K H(τ)^2) * T'(τ) = μ₀ K H(τ) T(τ) H'(τ)`.
   Use the positivity laws to justify all divisions, prove that
   `T(τ)^2 / (λ + μ₀ K H(τ)^2)` has zero derivative, and apply the interval derivative-constancy/mean-value lemma to equate its endpoint values. Substitute the named endpoint temperatures and fields; clear positive denominators, use temperature positivity to select the positive square root, and finish the stated `ΔT` formula with `Real.sq_sqrt`, `field_simp`, and `nlinarith`.

4. **`IPhO2026Problems/problem_IPhO_2026_4_B_6.lean`** — This retry has no open placeholder. Recheck the existing proof unchanged: specialize the mass, molar-energy, and mass-energy laws at one mole, derive `L_v = Q_v / M₀` with `eq_div_iff` and positive molar mass, then substitute the B.5 central value and reference molar mass and normalize the absolute-value interval. Confirm that the theorem compiles and that the dimensioned SI-to-kJ/kg conversion is exactly `/ 1000`; do not introduce an unnecessary source edit merely to consume the retry.

5. **`IPhO2026Problems/problem_IPhO_2026_4_C_7.lean`** — Add the narrow calculus import exposing `Real.hasDerivAt_log` and the right-derivative equality/constancy lemma. On `[r₁,r₂]`, compare `profile r` with `coefficient * Real.log r`: convert `Real.hasDerivAt_log` using `r > 0`, scale it by `coefficient`, and combine it with `hprofile_deriv` to show their right derivatives agree on `Ico r₁ r₂`. Use `hprofile_cont` and continuity of `log` on the positive interval with `eq_of_has_deriv_right_eq` (or the equivalent interval constancy theorem) to obtain
   `profile r₂ - profile r₁ = coefficient * (log r₂ - log r₁)`.
   Rewrite with the boundary temperatures and `Real.log_div`, unfold `coefficient`, clear only the proved nonzero positive factors, and finish the conductivity formula by ring/linear arithmetic.
