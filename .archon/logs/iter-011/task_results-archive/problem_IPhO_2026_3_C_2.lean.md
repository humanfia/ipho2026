# Task result — IPhO2026Problems/problem_IPhO_2026_3_C_2.lean (iter-010, prover lane)

## Summary

The file now **compiles with zero errors** under a fresh
`lake env lean IPhO2026Problems/problem_IPhO_2026_3_C_2.lean` (exit 0; only
the 9 `declaration uses sorry` warnings remain). All 9 contracted sorries are
still present, each with a substantial honest partial proof in place and a
recorded blocker. No axioms, no `native_decide`, no statement/signature
changes (the only proof-adjacent edits are proof bodies plus renaming the
unused def-parameter `T` to `_T` in `IsothermalHeatQForm` to silence the
linter — its instantiation sites pass temperature arguments positionally and
the Prop equation itself is unchanged).

## Verdict: the C.2 contract is NOT provable as formalized — two semantic defects

I verified against the source figure `ipho_2026_source/image/T3_page-3.png`
(Figure 3b). The official cycle, read directly off the figure:

- `1→2` isothermal at Th (dT=0 by construction of the diagram; H decreasing),
- `2→3` adiabatic (H decreasing), `3→4` isothermal at Tc (H increasing),
  `4→1` adiabatic (H increasing).
- `Qc` (absorbed from the cold reservoir) occurs on the cold isotherm `3→4`;
  `Qh` (delivered to the hot reservoir) occurs on the hot isotherm `1→2`.
- Carnot: `−Qh/Th + Qc/Tc = 0`, i.e. `Qh·Tc = Qc·Th`.

Correct derivation (checked by hand): with `qi := Ti·Mi²`, B.1 + the equation
of state give on the leg `1→2` at Th: `−Qh = −(μ₀V²/(2nK))(q2−q1)`; on the
leg `3→4` at Tc: `+Qc = −(μ₀V²/(2nK))(q4−q3)`. Feeding into the Carnot ratio,
cancelling `μ₀V²/(2nK) > 0` and collecting:
`Tc·q1 = (Th−Tc)·q2 + Tc·q3 − Th·q4` … divided by Th and using
`qi = Ti·Mi²` with T1=T4=Th, T2=T3=Tc gives exactly
`M1² = M2² − M3² + M4²`. The official answer is consistent with the figure.

The formalized contract deviates in TWO ways that make its statements false:

### Defect A — isothermal legs / heat signs swapped relative to Figure 3b
- `heat_12 : IsothermalHeatIntoTorus p Tc (Hmag v1) (Hmag v2) Qc` puts the leg
  1→2 at **Tc** and identifies its heat with the absorbed-from-cold Qc; but
  `figure3b` gives `T v1 = Th`, so the B.1 isothermal law is applied to a leg
  whose endpoints sit at different temperatures (Th vs Tc) — physically
  inconsistent (Th ≠ Tc by `Tc_lt_Th`), and contradicting the official figure
  (1→2 is the hot isotherm). `heat_34` analogously puts 3→4 at **Th** with
  heat `−Qh`, while T3 = Tc. As a consequence `Qh_eq`/`Qc_eq` cannot be
  derived in any regime excluding Th=Tc, and the cross-vertex `q3−q2`
  difference in `Qc_eq`'s statement is never produced by an isothermal leg at
  all (isothermal at T produces vertex differences T·Mf²−T·Mi²).
- Note the blueprint's own "Reusable previous-part conclusions" paragraph
  (copied from C.1's natural-language source) also states the wrong legs
  ("Qc absorbed on 2→3, Qh delivered on 4→1"); those are the adiabatic legs
  in Figure 3b. This root-caused the autoformalizer's swapped fields. The
  plan agent should re-read the figure or the official T3-C1 marking.

### Defect B — false "$q$-form" prefactor in `IsothermalHeatQForm`/`heat_isothermal_via_q`
Substituting H = TMV/(nK) into the B.1 law gives, at fixed T,
`Q = −(μ₀V²/(2nK))(T·Mf² − T·Mi²)` — the prefactor is `−μ₀V²/(2nK)` with a
**MINUS sign** and V²/(nK), not the contracted `+μ₀V/2` of
`IsothermalHeatQForm`. Proof below.

## Progress per declaration (each body retains the partial attempt + `sorry`)

| Decl | Status | What is proved in-place | Remaining gap |
|---|---|---|---|
| `heat_isothermal_via_q` | blocked (Defect B) | full endpoint EOS substitutions + `htrue` (see below) | conclusion as stated is false |
| `Qh_eq` | blocked (Defect A/B) | EOS squares hH3/hH4, temp rewrites | leg-temperature contradiction (Th=Tc regime) + prefactor |
| `Qc_eq` | blocked (Defect A/B) | `hrel` (B.1 unfolded at leg 1→2), `heos1`/`heos2` | needs T1=Tc contradicting figure3b; cross-vertex q3−q2 unreachable |
| `q_relation` | blocked upstream | `hratio` from `carnot_ratio`, prefactor ≠ 0 | needs `Qh_eq`,`Qc_eq` |
| `q4_eq_adiabatic_41` | blocked upstream | `hq4 : q v4 = Th·M4²` | needs correct legs; also no adiabatic (B.2) law is a model field |
| `q3_eq` | blocked upstream | `hq3 : q v3 = Tc·M3²` | needs adiabatic law 2→3 (not formalized) |
| `m1_sq` | blocked upstream | `hq1`,`hq4` defs, `hTh : Th ≠ 0` (its linarith/linear_combination finish is recorded in a comment) | upstream chain |
| `m1_eq_sqrt` | blocked upstream | `hM1 : 0 ≤ M1`; finish = `Real.sqrt_sq hM1` ∘ `m1_sq` | `m1_sq` |
| `m1_sq_arg_nonneg` | blocked upstream | `hM1sq : 0 ≤ M1²` | rewrite by `m1_sq` |

## Proved intermediate (evidence for Defect B)

Inside `heat_isothermal_via_q` (all hypotheses `Ti≠0, n≠0, K≠0` available):
```
have htrue : -(p.μ₀ * p.n * p.K / (2 * Ti)) *
      ((Ti * Mf * p.V / (p.n * p.K)) ^ 2 - (Ti * Mi * p.V / (p.n * p.K)) ^ 2)
    = -(p.μ₀ * p.V ^ 2 / (2 * p.n * p.K)) * (Ti * Mf ^ 2 - Ti * Mi ^ 2) := by
  field_simp
```
`field_simp` closes this standalone (verified in isolation; a trailing
`ring`/`ring_nf` errors with "No goals", matching the memory note about
field_simp fully clearing such goals). The contracted statement instead asks
for `+ (μ₀V/2)·(T Mf² − T Mi²)`; the two prefactors agree only when
`V = −nK` (excluded by `V_pos`,`n_pos`,`K_pos`) — and even then the sign of
the true form is negative while the contracted one is positive, so for
`Mf > Mi` the two sides have opposite signs. Hence the statement as written
is false in the intended regime.

## Redraft needed

- Original problem id: **IPhO_2026_3 / C.2**; report path:
  `reports/ipho_2026_k3/problem_IPhO_2026_3_C_2.source.json` (and the sibling
  C.1 source, whose natural-language leg assignment the blueprint quotes).
- Theorems/blocks affected: every `sorry`-carrying lemma above (the whole
  lemma chain `heat_isothermal_via_q` → `Qh_eq`/`Qc_eq` → `q_relation`,
  `q3_eq`/`q4_eq_adiabatic_41`; the three value theorems are downstream-only
  and fine once the chain is repaired).
- Why not provable: (A) `heat_12`/`heat_34` attach the B.1 law to the wrong
  temperatures/heats (contradicting `figure3b` + `Tc_lt_Th` and the official
  Figure 3b); (B) `IsothermalHeatQForm`'s `Q = (μ₀V/2)(qf−qi)` is not the
  EOS-substituted B.1 law (true: `Q = −(μ₀V²/(2nK))(qf−qi)` at fixed T).
- Smallest faithful, provable change (frozen-signature candidates):
  1. `heat_12 : IsothermalHeatIntoTorus p Th (cyc.Hmag .v1) (cyc.Hmag .v2) (-Qh)`
     and `heat_34 : IsothermalHeatIntoTorus p Tc (cyc.Hmag .v3) (cyc.Hmag .v4) (Qc)`.
  2. `IsothermalHeatQForm ... := Q = -(p.μ₀ * p.V ^ 2 / (2 * p.n * p.K)) * (qf - qi)`
     (same for the conclusion of `heat_isothermal_via_q` and the leg
     identities `Qh_eq : m.Qh = (p.μ₀ * p.V ^ 2 / (2 * p.n * p.K)) * (m.q .v1 - m.q .v2)`,
     `Qc_eq : m.Qc = (p.μ₀ * p.V ^ 2 / (2 * p.n * p.K)) * (m.q .v3 - m.q .v4)`).
  3. Restate the downstream chain to match the figure: replace
     `q_relation` by `m.Tc * m.q .v1 = (m.Th - m.Tc) * m.q .v2 + m.Tc * m.q .v3 - m.Th * m.q .v4`
     (proof: substitute the two leg identities into `carnot_ratio`, cancel
     the common positive `μ₀V²/(2nK)`, collect — pure `linear_combination`/
     `field_simp`); keep `q3_eq`'s statement but its proof then needs an
     added adiabatic-law field, e.g. `adiabatic_law : ∀ {vi vf}, ProcessKind-of-leg = adiabatic → cyc.T vi / cyc.Hmag vi = cyc.T vf / cyc.Hmag vf`
     (the T3-B2 result T·∝1/H along adiabats, currently NOT a model field);
     with it `q3_eq` follows from `T2/H2 = T3/H3` + EOS, and
     `q4_eq_adiabatic_41` becomes redundant/derivable. `m1_sq` then closes by
     dividing `q_relation` by `Th` and rewriting `q_i = T_i M_i²`; the last
     two value theorems need no change.
- Blueprint chapter: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_3_C_2.tex`
  needs its leg-identity/q-relation lemma blocks restated to match (and the
  "Reusable C.1 conclusions" bullets corrected: Qh on 1→2 at Th, Qc on 3→4
  at Tc). NOT marked `\leanok` anywhere — all 9 declarations still carry
  `sorry`.

## Notes for the reviewer

- Carried-over compile errors from the interrupted iter-010 session are
  repaired (the `(m := m)` named-argument misuse in `Qc_eq`, the stranded
  `rw [e3]; ring` after `sorry` in `heat_isothermal_via_q`, the misplaced
  `hT1` rewrite trying to turn `Th` into `Tc`). The file compiles at 0
  errors; remaining sorry count (9) matches the PROGRESS audit (10 was
  listed — recount under the fresh run shows 9 warnings, matching the 9
  sorry sites; no new sorries were added and none were removed).
