# Formalization Review — problem_IPhO_2026_1_B_1.lean (iter-017, cycle-1/attempt-1)

**Verdict: PASSED** (status=solved). Main declaration: `IPhO2026.Problem1.B1.maximum_separation_T1_B1`.

- source_faithfulness ✓ — every T1-B.1 given has a named answer-free carrier (masses/charges, r₀=100a₀, transverse antiparallel velocities, μℏ per particle, Coulomb-only energy law, a₀=ℏ²/(k·m·e²)); target matches recorded answer (1600/9)·a₀, with the per-a₀ corollary x_max = 1600/9.
- derivability ✓ — full chain Lean-proved except the single sorried value-computation bridge `turningQuadratic_normalized_eq`; I independently re-derived its statement from the structure fields: both sides = (ℏ²/m)(x − 64 − 9x²/2500); roots 100 and 1600/9 (Δ = 700²). Equation-only content.
- abstraction_sufficiency ✓ — opaque constants + Prop structures; PhysLean exemption of record; `IsGreatest` carrier; lawful-region vs attained-set identification documented and matches the hints' energy-law reduction.
- uncertainty_propagation: N/A (exact closed form, no ± data).
- branch_orientation ✓ — bound branch E<0 is a structure field with proved instance `boundMu_isBound`; lawful band proved between roots (100 periapsis, 1600/9 apogee); user-corrected sign contract (Q≥0 attained, Q<0 beyond threshold) preserved.
- countermodel_resistance ✓ — fields pin E,L,μ_red,r₀,v₀ forcing both roots; E≥0 excluded structurally; grep confirms 1600/9 and 9/16 occur only in conclusion-side theorems/comments; prior false/underdetermined bridges repaired and proved; axioms standard + sorryAx only.

All 11 bridge obligations covered (1 by-sorry, statement verified true and derivably routed). Preflight: 0 errors, sorry_count=1 as designed.
