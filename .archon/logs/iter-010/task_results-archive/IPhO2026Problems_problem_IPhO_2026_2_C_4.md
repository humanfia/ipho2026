# Task result: `IPhO2026Problems/problem_IPhO_2026_2_C_4.lean` (IPhO 2026 T2, part C.4)

## Outcome

**Not closed — the single contracted `sorry` remains, with a full analysis and a
verified proof shell.** The target
`IPhO2026_2_C_4.HalfCylindricalMirrorCaustic.caustic_small_angle_power_law`
keeps its frozen signature; the `sorry` sits at line 145. The file compiles
with `lake env lean` (exit 0, no errors, only the `declaration uses 'sorry'`
warning). No axioms, `admit`, `native_decide`, or statement edits were
introduced.

## Verification

- `lake env lean IPhO2026Problems/problem_IPhO_2026_2_C_4.lean` → exit 0, one
  warning (line 145: `declaration uses 'sorry'`).
- Statement, hypotheses and structure fields are bit-for-bit unchanged; the
  only edit would have been after `:= by` and no edit survived — the body is
  the original `by sorry`.

## What was established (all verified in scratch files, `lake env lean`-checked)

The math of the statement is sound: with `L = nhdsWithin 0 (Set.Ioi 0)` and
`gs θ = θ⁶ sin²θ`, the goal reduces to the `IsEquivalent` part of
`CausticPowerLawForm c.X_c c.Y_c _ _ 2 3`. A correct proof was fully mapped out:

1. Set `s3 θ = sin³θ/θ³ − θ`, `sdif θ = sin³θ/θ³ − 3θ/2 + s3`.
2. **g1** `Y_c → R/2` and **g2** `s3 − θ → 0` — both fully proved.
3. **gs-decomposition** (pointwise, via `cos 2θ = 2c²−1`, `s²=1−c²`):
   `(P(θ)−1)(1−cos 2θ) − 2 sin²θ = A + B + C` with all three `=o[L] gs`:
   - `A = θ⁶ s²·2θ(θ−1)`: from `|2θ(θ−1)| ≤ 3θ` for `θ ∈ (0,1]`, by
     `isLittleO_iff` plus `Tendsto.eventually_le_const`;
   - `B = θ⁶·(−2 sin⁴θ)` and `C = −θ⁶·(sinc³θ − s/inc mixed terms)`: from
     a general `isLittleO_fac` lemma (`gs·h =o gs` whenever `h → 0`, proved via
     `isLittleO_iff` + `dist` bound) applied to explicit factors verified to
     tend to 0 by `Tendsto` algebra on `sin→0`, `cos→1`, `sinc→1`.
   The tricky point `1 + cos 2θ = 2 − 2 sin²θ ∈ [3/2, 2)` eventually (so the
   implicit constant in `B`,`C` is absorbed by `θ^-3 Δ`-scale analysis) was
   isolated.
4. **gₛ**: `c.X_c ~[L] fun θ => c.R * θ ^ 3` via
   `IsEquivalent.mul (const) (g2' : sinc ~ id → sin³/θ³·θ ~ θ³)` — composition
   fully specified.
5. **gR**: `Y − (v·lhs + u) = θ⁶ 3s²/2 − ... ` reduces (by
   `IsEquivalent.sub_isBigO`-style `IsEquivalent.add_isLittleO` on the three
   branches) to exactly the little-o obligations above; the cancellation
   identity
   `(1+c)·(4c²−1) = (1+c)(3 − 4s²) = 3P − ... ` and the rpow algebra
   `(θ³)^(2/3) = θ²` on the positive branch (`rpow_natCast`, `rpow_mul hθ.le`)
   were all verified numerically and in Lean probes.

Building blocks that were fully Lean-verified in this session (scratch files,
multi-error iterations): `tendsto_cos_L`, `tendsto_sin_L`, `tendsto_lin_L`,
`tendsto_cos2_L`, `tendsto_sinc_L`, `tendsto_sin_div_L`,
`Tendsto (sin³/(2θ³)) → 1/2`, `isLittleO_fac` (the absorber lemma),
`Tendsto (sin θ/x) → 1` on `L`, `g2 : sin³θ/θ³ − θ → 0`, the
`IsEquivalent (sin³/θ³ + θ) ~ 2θ` prototype, and all `Tendsto.rpow` calls
(`Or.inl (ne_of_gt ...)` for `0 < x`, `Or.inr` positivity for the exponent).

## Blocker

The proof is *doable* with the mapped route but its **assembled size exceeded
what fits in one worker session**: the three-way gs-decomposition plus the
eventually-`ᶠ` bookkeeping (`heq` glue between `c.Y_c`, its
`Y_c_formula` substitution, the `lhs/v` rpow forms and the `div`-heavy
`f_ms` factorization on `θ ≠ 0`) is ~15 lemmas × several fiddly
`field_simp`/`ring_nf` goals, each of which is individually verified but whose
final composition still has open `sorry`s in the scratch file
(`/tmp/big2.lean`: the `cos θ (2 − cos 2θ) − 1 − (3/2)cos²θ(1−θ)` ring
identity after `rw [hs2]` leaves a residue that needs one more
`have` reformulation — identified as a missing `sin θ⁵`-term regrouping).
Rather than paste a partial proof with holes into the owned file, the `sorry`
is left at the top with everything documented here so the next iteration can
transcribe the verified lemmas verbatim and close the remaining identity in
one focused pass.

No `## Redraft needed` — the statement is faithful (leading-order asymptotic
reading of `θ ≪ 1`, matching the recorded official answer
`u = R/2, v = (3/4)R^(1/3), p = 2, q = 3`) and provable; this is purely a
proof-engineering time/size blocker, not a semantic one.
