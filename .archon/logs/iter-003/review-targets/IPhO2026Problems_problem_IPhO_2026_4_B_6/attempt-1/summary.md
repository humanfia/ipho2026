# Review: IPhO 2026 problem 4 B.6
Status: **partial**.
The supplied preflight compiles with zero sorries, and the trace shows no suspicious axioms.
The final signature matches the trace's original sorry-bearing contract.
The proof correctly derives `L_v = Q_v / M₀` from the one-mole mass/energy laws.
Its dimensions and J/kg-to-kJ/kg scaling are physically consistent.
The numerical center is `39000 / 0.018 = 2166.67 kJ/kg`, within the stated band.
But `±110` is encoded only as that broad center-value band.
The supplied `±2 kJ/mol` hypothesis is unused, so uncertainty is not propagated.
Repair: state `δL_v = δQ_v/M₀ = 1000/9 kJ/kg` and its rounding to `110 kJ/kg`.
The newest task result agrees with the trace on compilation, but overclaims uncertainty faithfulness.
