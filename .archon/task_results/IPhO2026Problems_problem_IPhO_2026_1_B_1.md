# Prover task result — `IPhO2026Problems/problem_IPhO_2026_1_B_1.lean` (iter-017)

## Outcome

**COMPLETE.** The file's single `sorry` — the value-computation bridge
`CoulombPairData.turningQuadratic_normalized_eq` — is now proved. The whole
file is sorry-free and compiles clean.

- Fresh `lake env lean IPhO2026Problems/problem_IPhO_2026_1_B_1.lean`: exit 0, no output (0 errors, 0 warnings).
- `grep -c sorry`: 0.
- Axiom check (`lean_verify`) on both
  `IPhO2026.Problem1.B1.CoulombPairData.turningQuadratic_normalized_eq` and
  `IPhO2026.Problem1.B1.maximum_separation_T1_B1`:
  axioms = `[propext, Classical.choice, Quot.sound]` only. No `sorryAx`, no
  new axioms, no laundering. (Pre-existing `opaque` constants warnings are
  the file's intentional anti-unfolding design, unchanged.)

## What was proved and how

`turningQuadratic_normalized_eq` (frozen signature, unchanged) states the
explicit normalization of the turning-point quadratic in the `μ = 4` bound
case. The proof is pure algebra from the governing fields, exactly along the
route recorded in the theorem's docstring:

1. Anchored values: `L = 8ℏ` (from `hv.total_angular_momentum_value`,
   `boundMu = 4`), `r₀ = 100·a₀` (from `D.initial_separation_value`).
2. Bohr relation multiplied out: `ℏ² = k·m·e²·a₀` (from
   `hR.bohr_radius_def`, `field_simp`), hence `L² = 64·k·m·e²·a₀`.
3. Speed readout: from `hv.speed_value` + `r₀ = 100·a₀`, the monomial
   `m·v₀·a₀ = 2ℏ/25` (`linear_combination (1/50) * h`), hence
   `v₀ = 2ℏ/(25·m·a₀)` (`eq_div_iff`) and `m·v₀² = 4ℏ²/(625·m·a₀²)`.
4. Energy value: `E = 4ℏ²/(625·m·a₀²) − k·e²/(100·a₀)` (from
   `D.coulomb_law`; `linear_combination hkin` — a direct `rw [hkin]` fails
   because `1/2 * m * v₀^2` parses left-associatively, so the pattern
   `m * v₀^2` does not occur syntactically).
5. The two coefficient matches (each closed by `field_simp`/`ring` after
   substituting steps 1–3):
   - quadratic: `E = −(9/16)·L²/(2·μ_red·r₀²)`
     (numerically `−(9/2500)·k·e²/a₀` on both sides);
   - linear: `k·e² = (25/16)·L²/(2·μ_red·r₀)`.
6. Assembly: `rw [turningQuadratic, hquad, hlin, hr0]` reduces the goal to a
   pure rational identity in `L, μ_red, a₀, x` (using
   `100/x = r₀/(x·a₀)`); `field_simp [hM, ha, hx']; ring` closes it.

Also updated the file-header bridge-inventory comment (lines 67–73), which
still described this bridge as "the ONLY remaining `sorry`" — now records
that every bridge is proved. No declaration, signature, hypothesis, or
statement was touched; only proof bodies and that comment.

## Marker readiness (for sync_leanok / review agent)

Per AGENTS.md the prover does not touch blueprint markers; flagging instead:

- `CoulombPairData.turningQuadratic_normalized_eq` — statement and proof now
  complete (was the last open `sorry`): ready for `\leanok` on its proof.
- Every downstream declaration that consumed it
  (`turningQuadratic_nonneg_iff`, `turningPoint_value_cases`,
  `orbitBound_T1_B1`, `apogee_attained_T1_B1`, `maximum_separation_T1_B1`,
  `maximum_separation_in_bohr_radii_T1_B1`) now has a fully closed
  dependency chain: ready for proof-block `\leanok` per the sync's
  determination.
- The blueprint chapter `IPhO2026Problems_problem_IPhO_2026_1_B_1.tex` is
  still the minimal autoformalize-source chapter (carries the
  `% STALE-LEANOK iter-001` annotation and no declaration inventory); the
  coverage-debt bookkeeping in PROGRESS (`unmatched` 42, incl. 39
  `1_B_1`-family nodes) is unchanged by this lane — the chapter still needs
  its post-redraft prose/inventory pass from plan/writer lanes, following
  the repaired `quadratic_nonneg_of_orbit` / `quadratic_neg_of_large`
  contract (never the false `quadratic_pos_of_large`).

## Redraft needed

None. The statement was faithful and provable as given; the reversed
radial-inequality repair from the user-authorized redraft held up — no
contract change requested.

## Notes / hazards for future lanes

- Tactic gotcha worth remembering: rewriting a monomial pattern like
  `m * v₀^2` into a goal containing `2 * (1/2 * m * v₀^2)` fails because of
  left-associative parsing; use `linear_combination` with the monomial
  equation instead (one-line fix, no `conv` needed).
- `hb : IsBoundMu boundMu` is hypothesis-interface only for this bridge
  (the bound value `μ = 4` is already baked into the anchored field
  equations); referenced via `have _ := hb` to keep the linter quiet.
- USER-hint sign contract respected: `Q(r) ≥ 0` on realized motion,
  `Q(r) < 0` beyond the energy threshold — untouched and still provable.
