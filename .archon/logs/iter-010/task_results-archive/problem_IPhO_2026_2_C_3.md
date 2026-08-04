# Task result: `IPhO2026Problems/problem_IPhO_2026_2_C_3.lean` (IPhO 2026 T2, part C.3)

## Outcome

**All sorries closed.** The single contracted sorry in
`IPhO2026Problems.IPhO2026_2_C_3.limitingIntersectionCoordinates` (the caustic
limit `X_c = R sin³θ`, `Y_c = (R/2) cos θ (2 − cos 2θ)` of the intersection of
neighboring reflected rays, with the C.1 exact line and the C.2 `O(Δθ²)`
expansions as hypotheses) is now proved in full. Statement, signature, and
hypotheses are **bit-for-bit identical** to the frozen autoformalized contract —
only the proof body after `:= by` was written.

## Verification

- `lake env lean IPhO2026Problems/problem_IPhO_2026_2_C_3.lean` → exit 0, **no
  errors, no warnings, no sorry** (grep count 0).
- `lean_verify IPhO2026Problems.IPhO2026_2_C_3.limitingIntersectionCoordinates`
  → axioms `{propext, Classical.choice, Quot.sound}` only (the standard
  Mathlib classical trio; no `sorryAx`, no new axioms, no `native_decide`).
- Blueprint marker: the theorem
  `thm:IPhO2026Problems_problem_IPhO_2026_2_C_3:limitingIntersectionCoordinates`
  and the umbrella `thm:physics:IPhO_2026_2_C_3:target` that `\uses` it are
  **ready for `\leanok`** (left to the deterministic sync per role rules).

## Proof outline (what the body does)

1. `set`-abbreviations for the readouts (`slopeval`, `icept`, `xcoord`,
   `ycoord`, `radiusval`, `tanθ`, `cot2θ`, `s2inv := sin(2θ)⁻¹²`).
2. Positivity facts on `(0, π/2)`: `cos θ > 0`, `sin 2θ > 0`, `s2inv > 0`,
   radius readout positive via `mirror.radius_pos`.
3. The two `O(Δθ²)` hypotheses are degraded to `o(Δθ)`
   (`IsBigO.trans_isLittleO (isLittleO_pow_pow 1<2)`), whence the remainder
   quotients `fslope d / d → 0` and `ficept d / d → 0`
   (`IsLittleO.tendsto_div_nhds_zero`).
4. Pointwise decompositions: slope difference
   `m θ − m(θ+d) = 2·s2inv·d − fslope d` and intercept difference
   `b(θ+d) − b θ = (R tan θ/(2 cos θ))·d + ficept d`.
5. Eventual non-vanishing of the slope difference on `𝓝[≠] 0`
   (`Tendsto.eventually_ne`, since `fslope d/d → 0 ≠ 2·s2inv`), so the
   intersection x-coordinate equals the explicit quotient
   `(R tan θ/(2cosθ) + ficept d/d) / (2·s2inv − fslope d/d)` eventually.
6. `Tendsto.div` gives the x-limit `(R tan θ/(2cosθ))/(2 sin⁻²(2θ))`,
   rewritten by `tan = sin/cos`, `sin 2θ = 2 sin cos` + `field_simp`/`ring`
   to `R·sin³θ`. `tendsto_congr'` transports through the eventual equality.
7. The y-coordinate is recovered from the exact ray-A line
   `y(d) = m_A·x(d) + b_A`, whose limit is `cot 2θ·R sin³θ + R/(2cosθ)`;
   a final `field_simp`+`ring` trig identity (using `sin²θ = 1 − cos²θ`,
   `cos 2θ = 2cos²θ − 1`) rewrites it to `(R/2)cosθ(2 − cos 2θ)`.

## Environment gotchas recorded for future lanes

- In this project (Mathlib v4.31.0 + PhysLean import), dot-notation
  `h.symm` on an `∀ᶠ` hypothesis misparses as `Exists.symm` — use
  `(tendsto_congr' h).mpr` instead of `Filter.Tendsto.congr' h.symm`.
- `tendsto_const_nhds` in this toolchain takes named argument `x` (not `a`),
  and `Tendsto.mono_left` needs an explicit type ascription when the
  `nhdsWithin` set can't be inferred.
- `div_add_iff` does not exist — use `div_add'`.
- `field_simp` on this Mathlib version clears only one denominator layer per
  call here; the final trig identities went through robustly with
  `field_simp [ne₁, ne₂, …]` followed by `ring` after pre-rewriting
  `sin θ ^ 3 = sin θ ^ 2 * sin θ` and `Real.sin_sq`.

## Redraft needed

None — the frozen statement was provable exactly as given.
