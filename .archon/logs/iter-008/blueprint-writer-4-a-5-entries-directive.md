# Directive — `blueprint-writer` subagent `4-a-5-entries`

## Scope
Blueprint chapter `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_4_A_5.tex`
(covers Lean file `IPhO2026Problems/problem_IPhO_2026_4_A_5.lean`). You write ONLY this .tex file.

## Why
22 live Lean declarations (the full ideal-gas / isochoric-thermometry layer) have NO blueprint
entry (leandag `unmatched` bucket), including 5 structure-field projections and the 4 target
theorems. Coverage-debt rule: every non-private decl gets a chapter block. The file's review
certificate is PASSED (iter-007, gate 2/3), so the statements on disk are the frozen contract —
transcribe, never redesign.

## Source of truth (MANDATORY first step)
READ `IPhO2026Problems/problem_IPhO_2026_1_B_2.lean` — NO. READ
`IPhO2026Problems/problem_IPhO_2026_4_A_5.lean` in full (353 lines) first-hand. Namespace
`IPhO2026_4_A_5`; imports `Mathlib`, `Physlib.Thermodynamics.Basic`,
`Physlib.Thermodynamics.Temperature.Basic`,
`Physlib.StatisticalMechanics.MicroCanonicalEnsemble.IdealGas` (typed `Temperature`/`absTemp`).
Compiles clean, exactly 10 sorries (L124/128/132/140/154/180/287/302/321/349 at last audit).

## Decl inventory (dependency order; grep-verified names)
1. `ambientAirDensity` (opaque/def): Bucaramanga time-averaged ambient air density `1.12 kg/m³`
   (figure readout, keeping its recorded value as data).
2. `pgHeight` (opaque/def): mercury-gauge height sealing the CA gas column (`0.045 m`, Figure 18).
3. `referenceAbsTemperature` (opaque/def): reference absolute temperature `273.15 K`
   (reference-constants table).
4. `absTemp` + `absTemp_eq_toReal` (lemma, sorry) + `absTemp_nonneg` (lemma, sorry): the typed
   PhysLean absolute-temperature projection to `ℝ` and its nonnegativity/value bridges.
5. `IsIdealGasLaw` (structure Prop): Eq. (1) `P·V = n·R·T` statewise on the sealed isochoric air
   column CA, `n, V > 0` built in, `R` a free positive parameter (A.4 decalibration note);
   field projections `IsIdealGasLaw.pressure_pos_of_temp_pos` (lemma, sorry) and
   `IsIdealGasLaw.pressure_ratio_eq_temp_pos` — CHECK the exact on-disk name; the scan shows
   `pressure_ratio_eq_temp_ratio` — two derived projection lemmas (the isochoric consequence
   `P₂/P₁ = T₂/T₁`; sorried).
6. `IsReferenceState` (structure Prop): reference state `(T₀, P₀)` with `T₀ = 273.15 K`,
   `P₀ > 0` certificate (`hP₀`); projections `IsReferenceState.referenceTemperature`,
   `IsReferenceState.referencePressure` (def projections — fold into parent entry).
7. `IsIsochoricLinear` (structure Prop): the A.3 linear isochore `P = offset + slope·T`,
   `slope > 0`; projections `IsIsochoricLinear.slope_eq_div` (slope = finite-difference
   quotient `ΔP/ΔT`; lemma) and `IsIsochoricLinear.thermalPressureCoefficient`
   (def `(1/P₀)(ΔP/ΔT)` — the Eq. (2) definition, NOT the value `1/T₀`).
8. `IsochoricReadout` (structure): the sparse A.2 two-readout dataset about the reference
   state — the measured pre/post pressures `measured_hP₁`, `measured_hP₂` — PLUS the
   non-degeneracy field `hT12 : T₁ ≠ T₂` added iter-007 (source-warranted by the A.2
   finite-difference protocol; record it, it closes the degenerate countermodel).
9. `IsochoricProcess` (structure): the process packaging (reference state + readouts +
   deviation bound `hdev`).
10. `idealThermalPressureCoefficient` (def) + `idealThermalPressureCoefficient_value` (lemma,
    sorry `:= by sorry`): `1/T₀ K⁻¹` as the ideal-gas prediction of Eq. (2) and its numeric
    value `≈ 0.0037 K⁻¹` at `T₀ = 273.15 K`.
11. Target theorems (CONCLUSION-side; each sorry):
    - `beta0_close_to_ideal`: measured Eq.-(2) coefficient equals the ideal value `β₀ = 1/T₀`
      (bridge from Eq. (1) + linear isochore).
    - `beta0_eq_ideal_of_linear`: the finite-difference consistency
      `slope·(T₂−T₁) = β₀·P₀·(T₂−T₁)` ⇒ `β₀ = 1/T₀` under the ideal law.
    - `beta0_uncertainty_bound`: propagated bound `|β₀ − 1/T₀| ≤ σ` from the readout deviation
      `hdev`; closure algebra: deviation `= P₀·|T₂−T₁|·|β₀ − 1/T₀|` and `P₀·|T₂−T₁| > 0`
      cancels via `IsReferenceState.hP₀` + `IsochoricReadout.hT12`.
    - `main`: the conjunction (`β₀ = 1/T₀` ideal value `0.0037 K⁻¹`, the finite-difference
      bridge, the uncertainty bound with the official band `0.0034 ± 0.0007 K⁻¹` reported
      A.5-band-side only).
12. ALSO ensure the pre-existing two NOTEs (PhysLean grounding reconciliation iter-004,
    Statement reconciliation iter-007 hT12) stay verbatim at the file end.

## Task
1. KEEP the existing skeleton + both NOTEs verbatim.
2. ADD `\subsection*` blocks in dependency order
   (`Recorded constants and the temperature projection`, `Governing laws: ideal gas and isochore`,
   `The two-readout dataset (A.2 protocol)`, `Official answer (conclusion side only)`), one
   `definition`/`lemma`/`theorem` block per declaration, field projections FOLDED into their
   parent structure entry as extra `\lean{}` lines (one per exact full name).
   - `\label{def|lem|thm:IPhO2026Problems_problem_IPhO_2026_4_A_5:<name>}`,
     `\lean{IPhO2026_4_A_5.<exact name>}` (watch `pressure_ratio_eq_temp_ratio`,
     `referenceTemperature`, `referencePressure`, `slope_eq_div`,
     `thermalPressureCoefficient`, `pressure_pos_of_temp_pos` — pin all projections you fold).
   - `\uses{}` real deps (`beta0_uncertainty_bound` uses the readout + reference-state +
     isochore entries + `beta0_eq_ideal_of_linear`; `main` uses all three component theorems).
   - 1–3 line informal statements and proofs; the uncertainty-bound block's proof is the
     cancellation algebra above; `beta0_eq_ideal`'s is "subtract the ideal increment, the
     measured increment equals `β₀·P₀·ΔT` by the two readout equalities, divide by `P₀·ΔT ≠ 0`."
3. Wire `thm:physics:IPhO_2026_4_A_5:target`'s `\uses{}` to the `main` label.
4. Physical-fidelity answers check: `1/T₀`, `0.0037`, `0.0034 ± 0.0007` ONLY in conclusions of
   the four target theorems; Eq. (1), Eq. (2) definition, A.3 isochore, A.2 readouts are
   assumption-side; the decalibrated `R` freedom and the `hT12` guard must be described in
   their entries.
5. Do NOT touch other files or markers.

## Report
`.archon/task_results/blueprint-writer-4-a-5-entries.md`: list of blocks + final pins.
