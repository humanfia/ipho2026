# Task result: `IPhO2026Problems/problem_IPhO_2026_3_C_1.lean` (prover, physics mode, iter-017)

Status: **complete — all 10 sorries closed.** Fresh `lake env lean` on the file:
exit 0, 0 errors, 0 warnings, 0 `sorry` (grep-verified). `lean_verify` on the main
theorem `IPhO2026.Problem3.C1.CarnotRefrigeratorModel.figure3b_labeling` reports
axioms `[propext, Classical.choice, Quot.sound]` only — no `sorryAx`, no new axioms.

The contract (iter-017 autoformalization) was provable exactly as stated; **no
signature changes, no redraft needed for this file.**

## Proofs landed (all in namespace `IPhO2026.Problem3.C1.CarnotRefrigeratorModel`)

| Declaration | Proof route (as planned in docstrings) |
|---|---|
| `Q23_pos` | `heat23` unfolded via `show … from m.heat23`; prefactor `μ₀nK/(2T₂) > 0` by `div_pos`/`mul_pos` over `p.μ₀_pos, p.n_pos, p.K_pos, m.T_pos .v2`; `H₃² < H₂²` by `(sq_lt_sq₀ (H_nonneg v3) _).mpr m.H3_lt_H2`; close with `neg_pos.mpr (mul_neg_of_pos_of_neg …)` after `rw [neg_mul]`. |
| `Q41_neg` | symmetric: `H₄² < H₁²` from `m.H4_lt_H1`, `sub_pos`, `mul_pos`, `neg_lt_zero.mpr`. |
| `leg23_cold` | `rcases m.leg23_exchange`; hot branch gives `Q23 = -Qh ≤ 0` (`neg_nonpos.mpr m.Qh_nonneg`), contradicting `Q23_pos m` via `not_le.mpr`. |
| `leg41_hot` | symmetric: cold branch gives `0 ≤ Q41`, contradicting `Q41_neg m`. |
| `temperature_labels` | `leg23_cold.1`/`leg41_hot.1` extended by figure readouts `m.T1_eq_T4` (`rw`) and `m.T2_eq_T3` (`rw [← …]`). |
| `Qc_absorbed_on_23` | `⟨(leg23_cold m).2, Q23_pos m⟩`. |
| `Qh_delivered_on_41` | `⟨(leg41_hot m).2, Q41_neg m⟩`. |
| `adiabatic_legs_transfer_no_heat` | `⟨m.heat12_zero, m.heat34_zero⟩`. |
| `reservoir_heat_magnitudes` | `abs_of_pos (Q23_pos m)` then `(leg23_cold m).2`; `abs_of_neg (Q41_neg m)`, `rw [(leg41_hot m).2]`, `neg_neg`. |
| `figure3b_labeling` (main) | `⟨temperature_labels m, Qc_absorbed_on_23 m, Qh_delivered_on_41 m, adiabatic_legs_transfer_no_heat m⟩`. |

## Tactic notes for the memory file

- **`sq_lt_sq₀` in this Mathlib is an iff**: `0 ≤ a → 0 ≤ b → (a^2 < b^2 ↔ a < b)`.
  Use `(sq_lt_sq₀ ha hb).mpr hab` (with `hb := ha.trans hab.le`). The docstring's
  cited form `sq_lt_sq₀ ha hab : a^2 < b^2` no longer exists.
- `rcases` on a structure field whose type is a `def … : Prop := _ ∨ _` works
  directly (whnf sees through `ReservoirExchange`); no `unfold` needed.
- `show <eq> from m.heat23` coerces the def-typed field to its unfolded equation —
  cleaner than `unfold … at` on a projection.

## Blueprint / markers

- Chapter `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_3_C_1.tex`
  still contains only the autoformalization placeholder
  `thm:physics:IPhO_2026_3_C_1:target` (no per-declaration `\lean{...}` blocks).
  All declarations in the file realize it; **ready for `\leanok`** — left to the
  deterministic sync per AGENTS.md (blueprint untouched by this lane). The plan
  agent may flesh the chapter out; suggested `\lean{...}` names (from the
  formalize-lane report, still accurate):
  `…CarnotRefrigeratorModel.temperature_labels`, `….Qc_absorbed_on_23`,
  `….Qh_delivered_on_41`, `….figure3b_labeling`.

## Redraft needed

- **None for `3_C_1`** — statement faithful and now fully proved.
- **Sibling redraft request stands (unchanged from formalize-lane report, also in
  ARCHON_MEMORY):** `problem_IPhO_2026_3_C_2.lean`'s `Figure3bAssignment` has the
  process kinds swapped vs. the official T3 solution (isothermal legs are 2→3 @ Tc
  and 4→1 @ Th; C.2 has 1→2/3→4 isothermal). This file's now-proved contract
  (`leg23_cold`, `leg41_hot`, `figure3b_labeling`) is the reference to redraft
  C.2 against. No compile dependency between the files.

## Grounding gaps

None. No PhysLean imports needed; no missing Mathlib infrastructure.
