# Directive — `blueprint-writer` subagent `3-a-3-entries`

## Scope
Blueprint chapter `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_3_A_3.tex`
(covers Lean file `IPhO2026Problems/problem_IPhO_2026_3_A_3.lean`). You write ONLY this .tex file.

## Why
The leandag `unmatched` scan reports 12 live Lean declarations in `problem_IPhO_2026_3_A_3.lean`
with NO blueprint entry, and the coverage-debt bookkeeping rule (prompts/plan.md "Lean ↔ blueprint
1-to-1") requires every non-private Lean decl to have a chapter block. Additionally the
chapter's physics-formalization target theorem must be faithfully transcribed.

## What exists on disk (verified by the planner this iter, grep + `lake env lean`)
The file declares everything inside `namespace IPhO2026.T3A3` (NOT bare names — several prior
bare-name references in review material drifted; the real Lean names are the full dotted ones):

| Lean name | Kind | One-line content |
|---|---|---|
| `IPhO2026.T3A3.PmTTorus` | structure | Geometry of the thin paramagnetic torus: mean radius `R`, winding radius `r ≪ R`, cross-section `A`, volume `V`, positivity fields, thin-torus identity `V = 2πR·A`. |
| `IPhO2026.T3A3.PmTWinding` | structure | Dense winding: `N` turns (`N ≥ 1`), instantaneous current `I` (signed real, A). |
| `IPhO2026.T3A3.AmpereLawTorus` | def | Ampère's-law predicate for the torus: `H = (N:ℝ) * I * A / V` (the `∮H·dℓ = N I` specialization). |
| `IPhO2026.T3A3.meanCircumference_eq` | lemma (sorry) | `2πR = V/A` — the geometric bridge from the loop form of Ampère's law to the `V/A` form (immediate from `V = 2πR·A`, `A > 0`). |
| `IPhO2026.T3A3.PmTFieldState` | structure | Instantaneous uniform core state: `H`, `B`, `M` (A/m, T, A/m). |
| `IPhO2026.T3A3.ConstitutiveBH` | def | Constitutive law `B = 𝓕.μ₀·H + 𝓕.μ₀·M` (with PhysLean `Electromagnetism.FreeSpace` `𝓕`). |
| `IPhO2026.T3A3.PmTVariation` | structure | Admissible infinitesimal process: state + increments `dB, dH, dM` with the linearized constitutive law `dB = μ₀·dH + μ₀·dM`; hypothesis fields `H_ampere`, `BH`, `dBH`. |
| `IPhO2026.T3A3.dB_of_vacuum_core` | lemma (sorry) | Vacuum-core bridge: `dB = μ₀·dH + μ₀·0 → dB = μ₀·dH` (trivial algebra). |
| `IPhO2026.T3A3.PmTWorkBudget` | structure | The licensed A.3 inputs: `dW_emf = V·H·dB` (part A.2 result), `dW_emf = dW_vac + dW` (problem statement split), `dW_vac = μ₀·V·H·dH` (vacuum-core contribution). |
| `IPhO2026.T3A3.dW_eq_sub_vac` | lemma (sorry) | `dW = dW_emf − dW_vac` (one rewrite of the `split` field). |
| `IPhO2026.T3A3.dW_eq_VH_dB_sub_mu0_dH` | lemma (sorry) | `dW = V·H·(dB − μ₀·dH)` (substitute `emf_source` and `vacuum_part` into `dW_eq_sub_vac`; one ring step). |
| `IPhO2026.T3A3.dW_eq_mu0_V_H_dM` | theorem (sorry) | **A.3 target**: `dW = 𝓕.μ₀ * V * H * dM` — combine the previous lemma with `dB = μ₀·dH + μ₀·dM`; the official answer `dW = α·V·μ₀·H·dM` at `α = 1`. |

The file compiles clean with exactly 5 sorry-bodied proofs (`meanCircumference_eq`,
`dB_of_vacuum_core`, `dW_eq_sub_vac`, `dW_eq_VH_dB_sub_mu0_dH`, `dW_eq_mu0_V_H_dM`).
It imports `Mathlib` and `Physlib.Electromagnetism.Dynamics.Basic` (typed `FreeSpace`/`μ₀`).

## Task
1. KEEP the existing chapter skeleton (source paragraphs, `thm:physics:IPhO_2026_3_A_3:target`
   block, the iter-era PhysLean targeted-import NOTE if present) verbatim where possible.
2. ADD after the target-theorem block a `\subsection*{Named quantities and governing-law
   hypotheses}` (or similar) with ONE `definition`/`lemma` environment per row of the table
   above, in dependency order (structures/defs first, then the algebraic bridges, target LAST):
   - `\begin{definition}[<human name>]\label{def:IPhO2026Problems_problem_IPhO_2026_3_A_3:<short>}
     \lean{<FULL dotted name exactly as in the table>}\uses{<labels of the blocks it logically
     relies on — mirror the hypothesis fields and the informal dependencies>}` … one- to
     three-line informal statement … `\end{definition}` (+ `\begin{proof}` 1–2 lines
     `\end{proof}` — for defs the proof can be "Packaging/definition; nothing derived.").
   - For lemmas/theorems use `\label{lem:…}` / `\label{thm:IPhO2026Problems_problem_IPhO_2026_3_A_3:dW_eq_mu0_V_H_dM}`
     and give a 1–3 line mathematical proof sketch (NO Lean tactic names). The A.3 target proof:
     `dW = V·H·(dB − μ₀·dH)` minus nothing else: substitute `dB = μ₀·dH + μ₀·dM`
     (the `dBH` field) and distribute/cancel `V·H·μ₀·dH`.
   - `\uses{}` guidance: `PmTVariation` uses the `PmTTorus`,`PmTWinding`,`AmpereLawTorus`,
     `PmTFieldState`,`ConstitutiveBH` entries; `PmTWorkBudget` uses `PmTVariation`;
     `dW_eq_sub_vac` uses `PmTWorkBudget`; `dW_eq_VH_dB_sub_mu0_dH` uses `dW_eq_sub_vac`;
     `dW_eq_mu0_V_H_dM` uses `dW_eq_VH_dB_sub_mu0_dH` + the `ConstitutiveBH`/variation entry.
3. UPDATE the umbrella target theorem `thm:physics:IPhO_2026_3_A_3:target` so its `\uses{}`
   includes the final target label (the A.3 value theorem) — wire the graph, do not invent deps.
4. Physical-fidelity rules: keep every hypothesis/conclusion split exactly as on disk; `V ≈ 2πR·A`,
   `B = μ₀(H+M)`, part-A.2 law `dW_emf = V·H·dB`, and the vacuum-core subtraction are ASSUMED
   inputs; `dW = μ₀·V·H·dM` is CONCLUSION-only. Note once (in the target entry or the variation
   entry) that the increments are formal differentials packaged as reals, a named scalar
   projection of the one-form language — this is the documented modeling choice.
5. Do NOT touch any other file. Do NOT add/remove `\leanok`/`\mathlibok` markers.

## Report
Write your self-contained report to `.archon/task_results/blueprint-writer-3-a-3-entries.md`
(the wrapper also archives it): list every block added with its label, and state the final
`\lean{}` pins verbatim.
