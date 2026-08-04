# Recommendations

- `IPhO2026Problems/problem_IPhO_2026_1_B_2.lean` — The theorem still depends on the active `sorry` proving `signedDeflectionDegrees motion frame uInfinity = -Real.arcsin (2 / 7) * 180 / Real.pi`, so the zero-sorry/zero-axiom-laundering requirement fails.
- `IPhO2026Problems/problem_IPhO_2026_2_B_1.lean` — One active `sorry` remains in radiusAtIncidence_from_figure2f, and the current abstract physics contract is insufficient to prove its numerical radius identity; therefore the reviewed theorem is not axiom-free.
- `IPhO2026Problems/problem_IPhO_2026_4_B_6.lean` — The theorem contract weakens the recorded '+/- 110 kJ/kg' uncertainty to mere membership of the central estimate in a fixed tolerance band; PreviousPartB5Result.molarLatentHeatUncertainty is semantically disconnected and unused.
