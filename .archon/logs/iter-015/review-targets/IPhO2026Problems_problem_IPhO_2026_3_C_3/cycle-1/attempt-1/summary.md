# Review: problem_IPhO_2026_3_C_3 — status: solved

- Preflight: compiles=true, 0 errors, sorry_count=0 (20.2s); no axiom/sorry/native_decide laundering found in source.
- Contract faithful to blueprint + official T3-C3: governing laws (EOS, signed B.1 isothermal heat, Carnot ratio, calorimetry) sit on the assumption side of `PotassiumChromateCoolingRun`; official answer values appear only in theorem conclusions.
- Targets: `absorbed_heat_value` |Qc−1.29e-1|<5e-4, `temperature_drop_value` |drop−9.92e-3|<5e-5, `final_temperature_value` |TFinal−0.99008|<5e-5; all reduced via `Qc_cold_leg` at supplied data and closed with `nlinarith` + certified pi bounds (Real.pi_gt_d4/pi_lt_d4).
- Independent numeric check: Qc=0.12934593 J (band ok), drop=9.9497e-3 K (band ok), TFinal=0.9900503 K (band ok).
- Signed-heat convention honest: heat_23 assigns +Qc, heat_41 −Qh; cooling branch certified by `helium_cools` (TFinal<TInitial), not assumed.
- `reservoir_temperature_consistency` derives (H1²−H4²)Tc²=(H2²−H3²)Th² from carnot_ratio + legs; consistent with official T_h fixing (numerically Th≈2.03 K from supplied fields).
- Blueprint ledger prose writes the relation with legacy vertex labels (H1,H2 vs H4,H3); the Lean proof uses the correct supplied fields — blueprint-only notation wart, preflight-green, not a proof defect.
- Process warning (non-blocking): iter-015 prover JSONL and task result for this target are absent (aborted session); primary evidence is Lean source + deterministic preflight per instructions.
- Root cause classification: not applicable — all five review checks pass; route=solved.
