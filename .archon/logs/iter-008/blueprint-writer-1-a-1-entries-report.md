# Blueprint Writer Report: 1-a-1-entries
**Status:** COMPLETE

## Changes
- Chapter `.tex`: all skeleton content kept verbatim (source paragraphs, `thm:physics:IPhO_2026_1_A_1:target`, iter-002 PhysLean-exemption NOTE). Only addition to skeleton: `\uses{thm:...:hydrostatic_gate_side_length_a_target}` on the physics target theorem (directive item 4).
- Added `\section*{Declaration ledger}` with the three directive-mandated subsections:
  - `\subsection*{Setup: parameters and figure constants}` — def blocks for `GatePlane`, `rho0`, `a`, `DeltaH`, `g`, `PhysicalParameters`, `cubeMass`, `displacedWaterMass`, `slotVerticalSize` (figure readout), `HingeAxis` (figure content, assumed).
  - `\subsection*{Governing laws (assumption side)}` — def blocks for `IsWeightForce`, `IsUniformGravityField`, `IsHydrostaticPressure`, `IsBuoyantForce`, `IsNetImmersedWeight`, `weightHorizontalLeverArm` (figure readout), `PressureMomentReadout` (figure readout, assumed), `IsCriticalTorqueBalance` (assumed), `HydrostaticGateSetup`. Each marked as carrying governing-law/figure content per physical-fidelity rule.
  - `\subsection*{Derivation chain to the official value}` — def blocks `netImmersedWeight`, `restoringMoment`, `pressureCoupleMagnitude`; lemma blocks `net_immersed_weight_eq` … `numerical_value` (8 lemmas, one-line algebra proofs, no tactic names); `torque_balance_contract`; theorem block `hydrostatic_gate_side_length_a_target` with `\uses` = bridges 1–5,7,8 + setup structures and a 4-line assemble proof.

## Pins
- 32/32 live Lean decls now have blocks (28 newly matched + 1 physics target); every block: `\label{def|lem|thm:IPhO2026Problems_problem_IPhO_2026_1_A_1:<name>}`, `\lean{IPhO2026_1_A_1.<name>}` (grep-verified exact names), 1–3-line statement, 1–3-line proof ("Definition; no claim." for def blocks).
- `\uses{}` all resolve in-chapter (python script: 0 unknown uses); begin/end envs balanced (22 def / 9 lem / 2 thm incl. physics target / 33 proof).
- Closed forms `\Delta h/(2\sqrt2)` / `0.50` confined to `side_length_eq_delta_h_over`, `numerical_value`, target theorem conclusions (and skeleton's recorded-answer paragraph, kept verbatim).
- 45° readouts (`\sin(\pi/4)`, `a\sqrt2/2`, `a\sqrt2/4`) explicitly labelled figure readouts in their blocks.
- `leandag` CLI not on PATH in this worker; DAG edges verified by scripted label/uses cross-check instead.
- Markers untouched; no other files modified.
