# Prover result — IPhO2026Problems/problem_IPhO_2026_2_A_1.lean (iter-010)

## Outcome
All 5 contracted sorries proved. File compiles clean (fresh
`lake env lean IPhO2026Problems/problem_IPhO_2026_2_A_1.lean`, exit 0,
0 errors). No axioms introduced (`lean_verify` on every target theorem
returns only `propext`, `Classical.choice`, `Quot.sound`; no `sorryAx`).
Only residual diagnostics: 5 `push_neg` deprecation warnings (style linter
only, no semantics).

## Proved declarations (all sorries closed)
- `HalfCylindricalMirror.limiting_ray_reflection_count` (L121) — direct
  evaluation of the reflection-count law at `α = π/(2n+3)`: the cut set
  `{k | (2k+1)·π/(2n+3) ≤ π}` is shown to equal `Finset.Iic (n+1)` by an
  iff characterization and `mul_div_cancel₀`; card is `n+2` via
  `Set.ncard_coe_finset` + `Nat.card_Iic`.
- `HalfCylindricalMirror.threshold_forms_agree` (L167) — pure trig bridge:
  `(2N−1)π/(4N+2) = π/2 − π/(2N+1)` via `field_simp`/`ring`, then
  `sin_pi_div_two_sub`.
- `HalfCylindricalMirror.threshold_x_N_cos` (L273) — squeezed via the two
  threshold clauses against internal points `y = (x_NAt n + x*)/2` /
  `(x* + x_NAt n)/2`. The geometric side reparametrizes `y = R cos αy`
  with `αy = arccos (y/R)` (`cos_arccos`), moves the strict inequalities
  to angle space via `Real.cos_le_cos_of_nonneg_of_le_pi` /
  `cos_lt_cos_of_nonneg_of_le_pi`, and bounds the cut-set card with the two
  new support lemmas below. Contradiction by `omega` against
  `x_NAt_is_threshold`.
- `HalfCylindricalMirror.threshold_x_N_sin` (L406) — `rw` of the cosine
  form plus `threshold_forms_agree`.
- `HalfCylindricalMirror.threshold_x_N` (L411) — term-mode conjunction of
  the sine and cosine forms.

## Support lemmas added inside the namespace (proof infrastructure, no
contract change; stare-style signature-preserving)
- `cut_finite` (L181): the odd-multiple cut set is finite (bounded by any
  Archimedean `K > π/α`).
- `ncard_clip_le` (L206): if `(2m+1)α > π` then cut-set card `≤ m`
  (via `Finset.Iio m`, `Nat.card_Iio`).
- `ncard_clip_ge` (L228): if `(2m+1)α < π` then cut-set card `≥ m+1`
  (via `Finset.Iic m`, `Set.ncard_le_ncard`).
- `reflection_count_le_of_exceeds` (L248): packaging of `ncard_clip_le`
  through the structure's `reflection_count_law`.
- `arccos_Ioc_of_mem` (L257): `arccos (y/R) ∈ (0, π/2]` for `y ∈ (0, R)`
  (via `arccos_lt_arccos`/`arccos_le_arccos`, `arccos_one`, `arccos_zero`).

## Notes for downstream agents
- Statements/signatures frozen: no structure fields, hypotheses, or theorem
  statements were altered; only proof bodies after `:= by` (plus five
  private infrastructure lemmas inside the namespace, which strengthen the
  file without touching the contract).
- Cos-monotonicity direction required care: `cos_le_cos_of_nonneg_of_le_pi`
  takes `0 ≤ x`, `y ≤ π`, `x ≤ y ↦ cos y ≤ cos x` (arguments in that
  order); early iterations of this proof flipped the argument order and
  failed — resolved by explicitly instantiating `@cos_le_cos_of_nonneg_of_le_pi`.
- The threshold squeeze needs strict internal points (`y` midpoints), so
  `N_refl (x_NAt n) = n+2` (edge field) is consistent but was not the
  contradiction driver; both clauses of `x_NAt_is_threshold` are used.

## Blueprint markers (for review agent — do NOT mark yourself)
The following `\lean{...}` blocks in
`blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_2_A_1.tex` are
ready for `\leanok`:
- `def:...HalfCylindricalMirror` (definition, no proof obligation),
- `thm:...limiting_ray_reflection_count`,
- `thm:...threshold_forms_agree`,
- `thm:...threshold_x_N_cos`,
- `thm:...threshold_x_N_sin`,
- `thm:...threshold_x_N`.
The top umbrella `thm:physics:IPhO_2026_2_A_1:target` (autoformalize
target statement) is now discharged conclusion-side as well.

## Redraft needed
None.
