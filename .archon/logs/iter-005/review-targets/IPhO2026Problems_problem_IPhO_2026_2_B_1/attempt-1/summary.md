# Proof review: IPhO 2026 2 B.1
Status: partial.
The supplied preflight compiles the file but reports one active `sorry`.
That `sorry` is in `radiusAtIncidence_from_figure2f`; the final theorem depends on it.
The current physics fields provide limiting/tangent path facts but no law yielding the claimed radius formula.
The downstream evaluations at π/2 and π/4 correctly recover α = R and β = -R/2.
The theorem signature, dimensioned lengths, exact answer, and blueprint semantics are preserved.
No numerical tolerance is relevant, and no other escape hatch or laundering construct appears.
The iteration-5 trace and newest matching task result support this partial verdict.
Repair the governing geometry contract, close the helper without `sorry`, and re-run zero-sorry preflight.
