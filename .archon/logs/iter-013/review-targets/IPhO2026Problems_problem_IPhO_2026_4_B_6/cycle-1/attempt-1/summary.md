# Review: IPhO2026Problems/problem_IPhO_2026_4_B_6.lean — latent_heat_per_unit_mass_target

**Route: solved.** The iter-11 redraft fixed the iter-10 `underdetermined_contract` finding:
`Lv_reported_central_eq : Lv_reported.central_kJ_per_kg = catalogQvValue / catalogMolarMassWaterValue`
pins the reported scalar, removing the countermodel `central = 10000`.

- Preflight (authoritative): compiles true, rc 0, sorry_count 0; only an unused-`input` linter warning (322:5). No admit/axiom laundering.
- Band conjunct proved via `rw [withinUncertainty, Lv_reported_central_eq]`, `abs_le`, `norm_num`: |39/18.0e-3 − 2190| ≈ 23.3 ≤ 110.
- Conversion relation `IsSpecificLatentHeatOf` stays a genuine conclusion (witness magnitudes, `rfl` conversion_eq, `M0_pos` by norm_num); catalog conjuncts by `rfl`.
- Other four declarations close honestly (formula, computed value, B.5 bridge 39.057 within 39 ± 2, T₀ calibration).
- Semantics faithful to blueprint and official answer 2190 ± 110 kJ/kg; Lᵥ = Qᵥ/M₀ never assumed; added hypothesis records the B.6 readout per the blueprint proof sketch (data-presupposition, matching the documented contract).
- Caveat: iter-013 prover trace ends with a stale 1-sorry summary, superseded by the landed redraft the preflight measured; no matching task-result artifact exists — process warning only, not a proof defect.
