# Directive — `blueprint-writer` subagent `1-c-2-structures`

## Scope
Blueprint chapter `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_1_C_2.tex`
(covers Lean file `IPhO2026Problems/problem_IPhO_2026_1_C_2.lean`). You write ONLY this .tex file.

## Why
7 live Lean declarations from the ozone-photodissociation modeling structures have NO blueprint
entry (leandag `unmatched` bucket; the chapter already has entries for the calibrated-data /
threshold theorems, this fills the missing structure layer). Includes 1 auto-generated
structure-field projection (`DissociationState.ΔU`).

## What exists on disk (planner-verified this iter; file compiles clean, 2 sorries)
Namespace `IPhO2026_1_C_2` — use the exact names:

| Lean name | Kind | Content |
|---|---|---|
| `IPhO2026_1_C_2.PhotoDissociationConstants` | structure | The physical constants bundle for the C.2 scenario (photon angular frequency scale, dissociation threshold, rest energies / masses of `O₂`, `O`, atomic oxygen speed data, Planck constant `ℏ`, etc. — read the actual fields from the file, lines ~48–68, and restate each with its physical unit from the docstrings). |
| `IPhO2026_1_C_2.PhotoDissociationConstants.trusted` | def (projection decl) | The trust/positivity certificate bundle of the constants; fold into the parent entry. |
| `IPhO2026_1_C_2.DissociationState` | structure | The energy-accounting record of `O₃ → O₂ + O`: fields incl. photon frequency `ω`, the internal-energy change `ΔU` (as a Lean function field, see below), and the momentum/energy data of both fragments. |
| `IPhO2026_1_C_2.DissociationState.ΔU` | projection decl | The internal-energy-change field function; fold into the parent entry. |
| `IPhO2026_1_C_2.IsOzonePhotodissociation` | structure | The reaction predicate: ozone photodissociates given sufficient photon energy — fields enforce energy conservation and momentum conservation between photon + `O₃` and the `O₂` + `O` fragments (read the file lines ~127–142). |
| `IPhO2026_1_C_2.IsOzonePhotodissociation.photon_energy_pos_of_omega_pos` | projection lemma (proved on disk) | `ω > 0 → ℏω > 0`. |
| `IPhO2026_1_C_2.IsOzonePhotodissociation.rest_energy_gap_nonneg` | projection lemma (proved) | The rest-energy gap `ΔU ≥ 0`-style field consequence (exact statement from disk). |
| `IPhO2026_1_C_2.IsOzonePhotodissociation.momentum_balance_sq` | projection lemma (proved) | The squared momentum-balance identity used downstream (exact statement from disk). |

READ the Lean file first-hand (lines ~48–200) and restate each field faithfully — units come
from the docstrings (`/-- ... -/`); the file is the source of truth.

## Task
1. KEEP all existing chapter content (source paragraphs, target theorem, any existing
   `C2CalibratedData`/`hbarOmegaMin*`/threshold entries, the exemption NOTE).
2. ADD a `\subsection*{Reaction-energy structures}` block ordered:
   `PhotoDissociationConstants` (fold `trusted`) → `DissociationState` (fold `ΔU`) →
   `IsOzonePhotodissociation` (fold the 3 projection lemmas as extra `\lean{}` lines in the
   SAME entry OR as three separate one-line `lemma` entries `\uses{}`-ing the parent — pick
   the single-entry folding if the projection statements are literally field restatements;
   separate entries if they carry proof content).
   Each: `\label{def:IPhO2026Problems_problem_IPhO_2026_1_C_2:<short>}`, `\lean{<exact full name>}`,
   `\uses{}` of logical deps, 1–3 line statement, 1–2 line proof.
3. Assumption/target discipline: `ℏω ≥ ΔU + (kinetic terms)` constraints are the ASSUMED
   conservation laws; the numeric threshold (`hbarOmegaMin` values, the `at_pi_div_six`
   calibration) stays conclusion-side in the pre-existing entries — do not move it.
4. Wire `\uses{}` so the pre-existing calibration entries that consume these structures
   point at the new labels (only if the dependency is real).
5. Do NOT touch other files or markers.

## Report
`.archon/task_results/blueprint-writer-1-c-2-structures.md`: added blocks + final pins.
