# Directive — `blueprint-writer` subagent `1-c-2-rest`

## Scope
Blueprint chapter `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_1_C_2.tex`
(covers Lean file `IPhO2026Problems/problem_IPhO_2026_1_C_2.lean`). You write ONLY this .tex file.

## Why
Follow-up to subagent `1-c-2-structures` (which landed the three structure entries correctly —
leandag re-verified `IPhO2026_1_C_2.PhotoDissociationConstants`, `.DissociationState`,
`.IsOzonePhotodissociation` and their folded projections as matched). 8 live Lean declarations
REMAIN unmatched; transcribe them now.

## On-disk decl inventory (planner-verified iter-008; namespace `IPhO2026_1_C_2`; read the file
lines 197–310 first-hand — docstrings carry units and the assumption/target split)
1. `hbarOmegaMin` (def): the angular-frequency threshold `ω_min(θ)` of the photodissociation as a
   function of the emission direction angle `θ` of `O` relative to the photon beam — from energy
   + momentum conservation (the minimum-photon-energy condition). Definition from the calibrated
   data; carries NO numeric value.
2. `C2CalibratedData` (structure): the calibrated constants of part C.2 — the recorded
   dissociation threshold, the reference photon values, the fragment data — with the certificates
   that keep every use non-degenerate (read the fields from disk).
3. `angular_factor_at_pi_div_six` (theorem, sorry or proved — disk is authoritative): the angular
   factor `cos θ`-style multiplier at `θ = π/6` from the momentum-direction geometry.
4. `hbarOmegaMinAtPiDivSix` (def): the threshold angular frequency specialized at `θ = π/6`.
5. `hbarOmegaMin_at_pi_div_six` (theorem, PROVED on disk per iter-002 review): the value of the
   threshold at `π/6` in the calibrated form — the bridge between the def and its evaluation.
6. `ThresholdRealizable` (def Prop): the threshold is physically realizable — there exists a
   photon of the computed minimum energy and the conservation laws hold with equality at
   threshold (minimum-energy condition).
7. `excess_photon_energy_at_threshold` (theorem): the excess kinetic energy of the fragments at
   threshold photon energy is ZERO (minimum condition). Logical deps: the threshold def +
   conservation laws.
8. `excess_photon_energy_pi_div_six_form` (theorem): the `θ = π/6` specialization — the excess
   energy vanishes at the calibrated threshold; bridges the C.2 official answer (the recorded
   `π/6`-calibrated threshold value `4.85 eV`-scale — CHECK the exact recorded value in the
   chapter "Recorded answer/context" paragraph; keep every official numeric conclusion-side only).

## Task
1. KEEP everything now in the chapter (source paragraphs, target theorem, the iter-008 structure
   entries from `1-c-2-structures`, the exemption NOTE).
2. ADD a `\subsection*{Threshold calibration and the π/6 official value}` block with the 8 blocks
   in the dependency order:
   `C2CalibratedData` FIRST (data layer) → `hbarOmegaMin` → `angular_factor_at_pi_div_six` →
   `hbarOmegaMinAtPiDivSix` → `hbarOmegaMin_at_pi_div_six` → `ThresholdRealizable` →
   `excess_photon_energy_at_threshold` → `excess_photon_energy_pi_div_six_form`.
   Each: `\label{def|lem|thm:IPhO2026Problems_problem_IPhO_2026_1_C_2:<exact decl name>}`,
   `\lean{IPhO2026_1_C_2.<exact name>}`, `\uses{}` of real deps, 1–3 line statement, 1–3 line
   mathematical proof (no tactic names):
   - threshold from conservation: energy `ℏω = ΔU + T_{O₂} + T_O` and momentum `ℏω/c = p` fix the
     minimum at collinear emission; differentiating the two-body energy at fixed momentum gives
     the minimum-energy (threshold) condition.
   - the `π/6` forms substitute the calibrated `cos(π/6) = √3/2`.
   - the excess-at-threshold theorems are the "remaining kinetic energy is zero at minimum
     photon energy" restatements used to identify the recorded official threshold.
3. Do NOT alter the three iter-008 structure entries or any existing block's `\lean{}` pins; the
   new blocks may `\uses{}` the structure labels (`PhotoDissociationConstants`,
   `DissociationState`, `IsOzonePhotodissociation`) where the dependency is real.
4. Wire `thm:physics:IPhO_2026_1_C_2:target`'s `\uses{}` to add the
   `thm:…:excess_photon_energy_pi_div_six_form` label (the official-answer carrier).
5. Do NOT touch other files or markers.

## Report
`.archon/task_results/blueprint-writer-1-c-2-rest.md`: blocks added + final pins.
