# Plan — iter-015 (prover; bounded proof strategies for the 4 selected retry targets)

Objectives are the loop-selected deterministic set (unchanged, reordered nowhere):
`2_C_4` (retry 2), `1_C_1` (retry 1), `2_B_2` (retry 1), `2_C_2` (retry 1).
All contracts ruled faithful/derivable; every defect below is tactic/parse/assembly-level.
Schedule retry targets first (all four are retries; no new eligible targets fill the batch).
Statements, hypotheses, and structure fields must not be edited; repairs live strictly in proof bodies,
`tactic` lines, and (only where already broken) `open` lines.

## 1. `IPhO2026Problems/problem_IPhO_2026_2_C_4.lean` — retry 2/3 (highest priority, last attempt)

**Defect A (compile blocker, review-literal):** `open Real`/`open Asymptotics` only, but the proof body of
`caustic_small_angle_power_law` (file L150-151, L231) writes `𝓝 0` and `𝓝[≥] 0`, which need
`open Topology` (and `open Filter`/`open scoped Topology` for the `𝓝[≥]` bracket notation to elaborate in
the `≤`-goal position). Three allowed minimal repairs, in order of preference:
  (i) global fix: add `open Topology Filter` to the two existing `open` lines (statement-level code —
      theorem signatures and all structure/definition fields stay byte-identical; this restores exactly the
      pre-iter-013 elaboration environment);
  (ii) proof-body-only fix: insert `open Topology Filter in` directly before
      `theorem caustic_small_angle_power_law`, or replace the three occurrences by fully-qualified
      `nhds 0` / `nhdsWithin 0 (Set.Ici 0)` using the already-in-scope `nhdsWithin` names from `smallAngleFilter`
      context (note `nhdsWithin_le_nhds` etc. are root-namespaced and already work unqualified).
  Pick whichever compiles; do NOT touch `smallAngleFilter`, `SatisfiesCausticPowerLaw`, or the theorem signature.

**Defect B (`sorry` at L223 — `hstep` remainder `Y_c θ - ((3/2) R θ² + R/2) = o(θ²)` along `l = nhdsWithin 0 (Ioi 0)`):**
the decomposition `heq` + `IsLittleO.congr_left` + `IsLittleO.add/sub` scaffolding is already correct; only the
first bullet is sorried. The intended proof in the in-file comments is: show first the `o(θ)` bound `hsum`
(already proved at L209-218) then SELF-IMPROVE `o(θ)` to `o(θ²)`. The baroque `hdecomp` identity at L220-222 is
a FALSE `ring`-division red herring (`(sinθ-θ)·2R·((sinθ-θ)²+θ⁴)/((sinθ-θ)²+θ⁴) = (sinθ-θ)·2R ≠ 2 sin²θ + 1 - 2θ²`;
`ring` proves it only because the denominator cancels, but it rewrites the claim to a form `o(θ)` gives nothing about).
Concrete strategy: delete `hdecomp`; prove
`have hbetter : (fun θ => c.R * (cos θ - 1) + c.R / 2 * (2 * sin θ ^ 2 + 1 - 2 * θ ^ 2)) =o[l] fun θ => θ ^ 2`
by `IsLittleO.add` of two proven pieces:
  (1) `c.R * (cos θ - 1) = o(θ²)`: from the standard second-order cosine certificate — search Mathlib for
      `cos_one_sub`/`Real.cos` second-order little-o; if no direct lemma, build it via
      `hcos₂ : (fun θ => cos θ - 1 + θ^2 / 2) =o[l] fun θ => θ^2` (`HasDerivAt` twice / `Real.tendsto_cos_sq`-style,
      or `Asymptotics.IsLittleO` of `cos θ - 1 = -2 sin²(θ/2)` with `hsin`-type facts at `θ/2`), then combine with
      `(fun θ => θ^2/2) =O[l] θ^2` (`isBigO_refl` after `const_mul`). The clean elementary route:
      `cos θ - 1 = -2 * sin (θ/2) ^ 2` (Mathlib: `Real.cos_eq...` / `Real.sin_sq_half`); use the file's own
      `hsin : (fun θ => sin θ - θ) =o[l] θ` pattern instantiated/halved to get `sin(θ/2) = O(θ)`, square with
      `IsBigO.mul` to land `o(θ²)`.
  (2) `c.R / 2 * (2 * sin θ ^ 2 + 1 - 2 * θ ^ 2) = o(θ²)`: rewrite the inner bracket pointwise as
      `2 * (sin θ ^ 2 - θ ^ 2) - 1 + 1`... no — algebra check: `2 sin²θ + 1 - 2θ² = 1 - 2(θ² - sin²θ)`; to beat `θ²`
      is FALSE pointwise (`= 1 + O(θ²)`) — this means the intended decomposition of the TRUE remainder must pair
      this term with the neighboring pieces: the honest `hstep` input is that the SUM inside bullet 1 is
      `R(cosθ-1) + (R/2)(2 sin²θ + 1 - 2θ²)`; expand: `cosθ - 1 = -θ²/2 + o(θ²)` and `sin²θ = θ² + o(θ²)` gives
      sum `= -Rθ²/2 + Rθ² + o(θ²) - Rθ² = Rθ²/2·(...)` — verify the actual coefficient: the true Taylor remainder
      needs `cos θ - 1 = -θ²/2 + O(θ⁴)` AND `sin²θ - θ² = O(θ⁴)`. So bullet 1's `o(θ²)` claim as written in the
      file comment is only valid WITH the quadratic terms retained, since `hsum`/`hdecomp` as left are insufficient.
      RECOMMENDATION: restructure bullet 1 out of `IsLittleO.sub` style and prove directly
      `R(cosθ-1) + (R/2)(2sin²θ+1-2θ²) - (R/2)·0·θ² = Rθ²·(...)` — concretely: prove via
      `IsLittleO.congr_left (fun θ => by ring)` to the normal form
      `fun θ => c.R * (cos θ - 1 + θ ^ 2 / 2) + c.R * (sin θ ^ 2 - θ ^ 2)` and prove each summand `o(θ²)`:
        · `cos θ - 1 + θ²/2 = o(θ²)`: equivalent to `cos θ - 1 = o(θ)` self-improved; the standard Mathlib route is
          `Real.cos_sq`... — instruct prover to first try `simp`/`hasDerivAt`-based: there IS a clean chain:
          `h : (fun θ => cos θ - 1 + θ^2/2) =o[l] fun θ => θ^2` from
          `(hasDerivAt_cos 0).isLittleO` iterated (Taylor with remainder `HasFDerivAt`/`taylor`-free elementary path:
          `cos θ - 1 + θ²/2 = (cos θ - 1 + θ²/2)`; use l'Hopital-style `deriv`-ratio via
          `Asymptotics.isLittleO_iff_tendsto'` + `Real.deriv` quotient limit twice). If that drags, fall back:
          `cos θ - 1 + θ²/2 = sin(θ/2)²·2·(-1) + θ²/2` then to `o(θ²)` needs `sin(θ/2) = θ/2 + o(θ)` (the file's
          `hsin` at `θ/2` scaled) giving `-2(θ/2 + o(θ))² + θ²/2 = o(θ²)` by `IsLittleO.add`/`IsBigO.mul` algebra.
        · `sin²θ - θ² = o(θ²)`: factor `= (sinθ - θ)(sinθ + θ)`; `hsin : sinθ - θ =o[l] θ`, `sinθ + θ = O(1)·2θ = O(θ)`
          (`isBigO_refl`-flavored, or `(hsin.trans_isBigO ...).add (isBigO_refl _)`); then
          `IsLittleO.mul_isBigO : o(θ) * O(θ) = o(θ²)`. Clean.
      Warning: this makes bullet-1's comment true only in the restructured normal form; update the two
      inline comments accordingly, keep every `have` name the prover already uses downstream (`hsum` is referenced
      nowhere after — safe to drop).

**Defect C (`sorry` at L238 — final `IsEquivalent` assembly):** after `hstep` lands, the remaining gap is
standard: write `Y_c = ((3/2)R θ² + R/2) + o(θ²)` and `(3/4)R^{1/3}|X_c|^{2/3} + R/2` side; use
`X_c θ = R sin³θ` (structure field, via `c.X_c_eq`/C.3 hypothesis — check the field accessor name in the section
context), so `|X_c θ|^{2/3} = R^{2/3} (sin θ³)^{2/3}`; on `nhdsWithin 0 (Ioi 0)`, `sin θ ≥ 0` eventually
(`hsin_pos` already at L157), so `(sin θ ^ 3) ^ ((2:ℝ)/3) = (sin θ) ^ 3·(2/3) = sin²θ` eventually
(`Real.rpow_natCast`/`Real.rpow_mul` + `abs_of_nonneg`); then the `IsEquivalent` pair follows from both sides
`~ (R/2) + (3/2)R θ² + o(θ²)` via `IsEquivalent.add_isLittleO` / transitivity. Budget note: if the `rpow`
chain resists, the faithful fallback is `IsEquivalent.congr_left` trig-only: `sin²θ ~ θ²` machinery is already
in-file (`h1` bullet 2). Keep `u = R/2`, `v = (3/4)R^{1/3}`, `p=2`, `q=3` EXACTLY as in the signature.

**Blueprint:** no text defect (`blueprint/.../2_C_4.tex` proof sketch already says leading-order asymptotics;
no chapter edit needed this iter — mark "no defect" in the result line).

## 2. `IPhO2026Problems/problem_IPhO_2026_1_C_1.lean` — retry 1/3

**Defect A (L329-330 `field_simp; ring` → 'No goals'):** after `rw [hΩ]`, `hbne`, `hden` the `field_simp` closes
the goal itself; the trailing `ring` errors. Strategy: end that `have hE` block with `field_simp [hbne, hSne]`
alone (delete `ring`), or replace the two lines by `field_simp; ring_nf` guarded — simplest: keep
`field_simp` only; if a residual `(3 m c² (1-s)) * (hbar S) / (hbar S)`-shaped goal remains, finish by
`rw [mul_comm (hbar) S] at hden ⊢` no — the deterministic repair the review names is `field_simp` suffices;
verify with goal-state inspection, never blind-append `ring`.

**Defect B (L337-340 rw shape-mismatch):** after `rw [hfac_S, hE]`, goal is
`S * (X/S)^2 - 6 m c² (X/S) + 6 dU m c² = 0`. The current `rw [div_pow, div_eq_iff ...]` leaves a goal where
the follow-up `show`-rewrite pattern never occurs. Strategy (review-recommended, minimal): set the divided
target explicitly first:
  `have hdiv : X ^ 2 / S ^ 2 = (6 * m * c ^ 2 * X * S - 6 * dU * m * c ^ 2 * S ^ 2) / S ^ 3 := by
     rw [div_eq_div_iff (pow_ne_zero 2 hS') (pow_ne_zero 3 hS')]` — no; cleaner per review: clear denominators
  EARLY with a single `field_simp [hS']` on the WHOLE goal to land `X ^ 2 * S - 6 * m * c ^ 2 * X * S +
  6 * dU * m * c ^ 2 * S ^ 2 = 0`, then `subst X S` and finish with the ALREADY-VALIDATED
  `linear_combination (S * (3 * m * c ^ 2)) * hsq3` line (which is correct in the multiplied-out goal — the
  coefficient `hsq3 : s²·(3mc²) = 3mc² - 2dU S` is exactly what `(S·E₀)²-...` needs with `E₀·S = 3mc²(1-s)`;
  keep a `show` of the multiplied-out shape before `subst` so `linear_combination` sees ground polynomial).
  Alternative one-liner to try first: `field_simp [hS']; ring_nf; subst ...; linear_combination ...`.

**Defect C (the two `sorry`s at L380/L394 — genuine proof work, not tactics):** assemble from the validated
iter-014 plan pieces (already compiled as helper sublemmas in the prover trace; port them into the target file
BEFORE the two theorems, in `section ThresholdContracts`):
  (i) **B1 bound:** for any reachable config, write the energy/momentum balance in `t := ‖p‖/(ℏω/c)` units:
      substituting `momentum_q_sq` into `energy_balance` yields the scalar equation
      `6 m c² (ℏω) t² - 12 m c² ℏω cosθ · t + ...` minimized over `t`; completing the square in `t` gives
      discriminant `(2 - cos 2θ)(ℏω)² - 6 m c² (ℏω) + 6 dU m c² ≤ 0`... concretely: prove
      `Q(E) := (2 - cos 2θ) E² - 6 m c² E + 6 dU m c² ≤ 0` for every reachable `E = ℏω` by
      `nlinarith [momentum_q_sq, energy_balance, sq_nonneg (‖p‖·(2m) - (ℏω/c)·cosθ ·(2m)·... )]` after
      clearing norms with `‖·‖²` algebra (`real_inner_self_eq_norm_sq` + `q_unique` already eliminated by
      `momentum_q_sq`); the `(2 - cos 2θ)` coefficient enters via `2 - cos 2θ = 2(1 - cos²θ) + 1 = 2 sin²θ + 1`
      (`two_sin_sq_add_one_eq`, in-file).
  (ii) **E₀ floor + A2 minimality:** reachable `E` satisfies `E ≥ E₀` where `E₀` = smaller root of `Q`, since
      `Q ≤ 0` forces `E` between the roots and `E ≥ dU`-floor side (`E₀ ≥ dU` chain from `hsq3`) rules out the
      below-`E₀` half; conclude with `quadratic_characterization_of_threshold`'s third component (`∀ E, Q(E)=0 → E₀ ≤ E`)
      upgraded to the interval `Q(E) ≤ 0 → E₀ ≤ E` via the upward parabola (`nlinarith` with the factored form
      `(S·E - 3mc²(1-s))·(S·E - 3mc²(1+s)) ≤ 0`, mirroring the existing `hfactor` block).
  (iii) **Reachability at Ω:** exhibit explicit config: `k.direction := unit e₀` (any ONB vector of
      `ReactionPlane = EuclideanSpace ℝ (Fin 2)`, e.g. `!₂[1,0]` with `EuclideanSpace.norm_eq`),
      `p := (E₀/c·cosθ - sqrt-part)t̂`... use the quadratic DOUBLE-ROOT-at-minimum construction:
      at `E = E₀` (= smaller root), `t* = cosθ·(...)`; set `‖p‖ = E₀ c·(...)`-precisely the critical `t*` and
      `q := (E₀/c)•k̂ - p` (so `q_unique` definitional), then discharge `energy_balance`/`momentum_q_sq` by
      `linear_combination` against the root equation; `angle_readout` from `inner_eq` with `cos θ ≥ 0` on the
      forward branch (`hfwd : θ ≤ π/2`). Construct `p` as `(t·cosθ)•k̂ + (t·sinθ)•k̂⊥` with `k̂⊥ = ![−k̂ 1, k̂ 0]`
      (norm-1, perpendicular — 2-line `EuclideanSpace` computation) and `t` the critical value.
  (iv) **Backward branch (L394):** `IsForwardBranch` fails; official freeze: threshold `= Ω(π/2)`. Reduce to the
      forward case at `π/2` for the minimality half via `hbarOmegaMin_pi_sub`-type symmetry PLUS the extra
      physical fact `Q_{π/2}(E) ≤ 0 ⇔ Q_θ(E) ≤ 0` on reachable sets (coefficient `2 sin²θ + 1 ≥ 2 sin²(π/2)+1 = 3`
      on `[π/2, π]`... `sin θ` decreasing? NO — `sin²θ ≥ sin²(π-θ)`; honest route: `sin²θ ≥ sin²(π/2) = 1` iff
      `|sin θ| ≥ 1` false — correct claim: for `θ ∈ [π/2, π]`, `sin θ ≤ 1` so `2 sin²θ + 1 ≤ 3`, and the
      discriminant condition `Q_θ ≤ 0` with SMALLER `S` is HARDER, so reachability at `θ` implies
      `Q_{π/2}(E) ≤ ...` — prover must check the monotonicity direction during assembly; the safe formal route is
      the existing `hdisc`-guarded `·(π/2)` conclusion: show reachable-at-`θ` `E ⇒ Q_θ(E) ≤ 0 ⇒
      E ≥ 3mc²(1-s_{θ})/S_{θ} ≥ 3mc²(1-s_{π/2})/3 = E₀(π/2)` using `s` monotone in `S` (sqrt of `1 - cS`),
      all `nlinarith`-dischargeable from `hsq3` analogues. If the monotonicity chain gets long, time-box it and
      leave the SORRY with a comment — partial honest progress beats a stuck session (this target has 2 attempts
      left).

**Blueprint:** `1_C_1.tex` sketch says "minimization reduces to this quadratic" — consistent with strategy;
no chapter edit needed.

## 3. `IPhO2026Problems/problem_IPhO_2026_2_B_2.lean` — retry 1/3 (5 sorries, all mechanistic)

**Defect A (`abs_hitOffset_eq` — already attempted, 3 sub-failures):**
  (1) Parseval `nlinarith` (L283-287): give the identity as PROVED RING hypotheses instead of naked hints:
      add `have hring : ∀ v : Plane, (v 0 * g.e 0 + v 1 * g.e 1)^2 + (v 0 * g.n 0 + v 1 * g.n 1)^2
        - (v 0^2 + v 1^2) = (v 0^2 + v 1^2)·(g.e 0^2 + g.e 1^2 - 1) + (v 1^2 + ...)` — simplest robust form:
      `have hkey : ∀ v : Plane, (v 0 * g.e 0 + v 1 * g.e 1) ^ 2 + (v 0 * g.n 0 + v 1 * g.n 1) ^ 2
          = (v 0 ^ 2 + v 1 ^ 2) * (g.e 0 ^ 2 + g.e 1 ^ 2) - ...` — NO, the shape that feeds nlinarith is:
      prove `hquad : ∀ {a b c d x y : ℝ}, c^2+d^2=1 → e^2+f^2=1 → c*e+d*f=0 →
        (x*c+y*d)^2 + (x*e+y*f)^2 = x^2+y^2` … avoid inventing: instantiate `nlinarith` WITH
      `[h0e, h0n, hpen]` plus the explicit sq-expansion certificate
      `sq_nonneg (g.e 0 * g.n 1 - g.e 1 * g.n 0)` and the product `mul_self_nonneg` items already listed;
      the reliable repair is to first `have : (v 0 * g.e 0 + v 1 * g.e 1) ^ 2 + (v 0 * g.n 0 + v 1 * g.n 1) ^ 2
        = (v 0 ^ 2 + v 1 ^ 2) + (v 1 * g.e 0 - v 0 * g.e 1... ` — RECOMMENDED deterministic certificate:
      `have hdet : (g.e 0 * g.n 1 - g.e 1 * g.n 0) ^ 2 = 1 := by nlinarith [h0e, h0n, hpen]` then
      `linear_combination` — final form: prove Parseval by
      `linear_combination (v 0 ^ 2 + v 1 ^ 2) * h0e + ... ` if it resists, else keep `nlinarith` but ADD
      `hdet`-style hint. Prover: try `nlinarith [h0e, h0n, hpen, sq_nonneg (g.e 0 * g.n 1 - g.e 1 * g.n 0),
        mul_self_nonneg (g.e 0 * g.n 1 - g.e 1 * g.n 0)]` first (this is THE missing certificate — the
      `sq_nonneg (g.e 0 - g.n 1)` currently passed is irrelevant noise).
  (2) abs/sqrt pattern misses (`|wn|²` vs `√(wn²)`): insert `have hwn2 : Real.sqrt (wn ^ 2) = |wn| :=
      Real.sqrt_sq_eq_abs wn` and rewrite `[Real.sq_sqrt (sq_nonneg ...), hsq]`; where the goal shows
      `√(|wn|^2)` use `Real.sqrt_sq (abs_nonneg _)`; do the `hsq` rewrite BEFORE any `sqrt` intro, i.e. fix
      `hgoal` block as: `rw [hsin, ← Real.sqrt_sq_eq_abs, show hitOffset p g r y = wn from rfl]` then
      `conv_rhs => rw [show p.R * Real.sqrt _ = _ from rfl]` — concretely chain
      `Real.sqrt_eq_iff_eq_sq`/`Real.sqrt_mul_self`...
  (3) field normalization `p.R^2·(1-(|ue|/p.R)^2) = p.R^2-|ue|^2` (L308-312): the current `field_simp; ring`
      needs `p.R ≠ 0`; route: `have hRne : p.R ≠ 0 := ne_of_gt p.hR` in scope, then
      `field_simp [hRne]` then `ring`; if `field_simp` underperforms fall back to
      `rw [mul_sub, mul_one, div_pow, mul_div_cancel₀]` chain with `sq_abs`.
  Re-verify lemma fully closes (it has no sorry; it must compile clean before touching the chain lemmas).

**Defect B (`collectedWidth_eq_two_mul_yOff` L323):** `collectedWidth = sSup image − sInf image` where
`image = (fun y ↦ ⟨incidentPt y − C, n⟩) '' hitSet`; by `r.readout_eq`, on `hitSet = Ioo (-yOff) yOff` the image
EQUALS `Ioo (-yOff) yOff` itself: prove `himg : (fun y ↦ inner (r.incidentPt y - g.C) g.n) '' r.hitSet =
  Set.Ioo (-yOff) yOff` by `Set.image_eq_of...` — extensionality: `⊆` from `readout_eq`; `⊇` from
`hit_offsets_fill` (field L165: for every `z ∈ Ioo`, `∃ x ∈ hitSet, inner ... = z`).
Then `csSup_Ioo hyOff` and `csInf_Ioo hyOff` (`ConditionallyCompleteLattice`) give `sSup = yOff`, `sInf = -yOff`;
finish `ring`. Exact lemma names to try: `csSup_Ioo (show (-yOff:ℝ) < yOff by linarith)`,
`csInf_Ioo`; if names differ, `sSup_Ioo`/`Real.sSup_Ioo`-search via LSP completion.

**Defect C (`yOff_eq_R_sin_thetaMax` L333):** both sides positive; use `ThetaMaxSpec` attainment
`⟨y*, hy*, hmax⟩` and upper bound `hle`. From attainment + `abs_hitOffset_eq`: `|hitOffset y*| = R sin θ`,
and `readout_eq` pins `hitOffset y* = y*`-signed value with `|y*| ≤ yOff`... more precisely `y* ∈ Ioo(-yOff, yOff)`
gives `|y*| < yOff`; `yOff = R sin θ` does NOT follow from attainment alone unless the band-edge is approached —
the honest formal content: `sup {|hitOffset|} = yOff` (from the Ioo band) and
`incidenceAngle` STRICTLY increases with `|y|` (`incidenceAngle_le_of_offset_le` hypothesis field), so
`θ = sup incidence = R sin(yOff...)`. Assembly: `le_antisymm`: `θ ≤ arcsin(yOff/R)`-direction via `hle` at
approaching sequences — this is genuinely analytical; if no clean `IsLUB` route, use strictness directly:
  `y_off-side`: for all `y ∈ hitSet`, `R·sin(incidence y) = |y| < yOff` (`abs_hitOffset_eq` + `readout_eq`), and
  `sin` is STRICTLY monotone on `[0, π/2]` (incidence ∈ `[0, π/2]` from `halfMirrorArc`),
  `Real.strictMonoOn_sin`/`Real.sin_lt_sin_of_lt_of_le_pi_div_two`; attainment `y*` gives `R sin θ = |y*| < yOff`
  — contradiction-free conclusion needs DENSITY: `∀ y-z ∈ Ioo`, nearby points force
  `yOff ≤ R sin θ` via `hle` applied to a point with offset arbitrarily close to `yOff` (`Ioo` is open, use
  `Set.Ioo_subset_...` + `exists_between`). Deliverable tactic sketch: prove `R sin θ ≤ yOff` via
  `le_of_forall_lt'` no — `≤ yOff`: all frame points have `R sin(incidence y) = |y| < yOff`, in particular at `y*`
  `R sin θ = |y*| < yOff`... note this gives `<`, while `yOff ≤ R sin θ` follows from: if `yOff > R sin θ`
  then pick `y ∈ Ioo` with `|y| > |y*|` (density near the endpoint `min yOff ...`); `incidence y > θ`
  contradicting `hle`. Formalize the density pick by `exists_between (show |y*| < min yOff (R·1) ...)`. It IS
  provable; instruct prover to time-box to ~30 min wall and otherwise leave marked sorry.

**Defect D (`two_r_sin_over_diameter_eq` L343):** pure field algebra: `B1Calibration` gives
`2 p.a = 2 p.R sin θ (1 - cos θ)` (unfold `B1Calibration`, apply `Real.sin_two_mul`: `sin 2θ = 2 sinθ cosθ`, so
`a = R sinθ - (R/2)·2 sinθ cosθ = R sinθ(1 - cosθ)`; `ring`-finish after `have hsin2 := Real.sin_two_mul θ`).
Then `2 R sinθ / (2 R sinθ(1-cosθ))`: cancel `2 R sinθ ≠ 0` (`p.hR`, `sin_pos_of_pos_of_lt_pi` from
`θ ∈ Ioo 0 (π/2)`, and `pi_div_two_pos`/`Real.pi_pos`); `rw [div_eq_iff, mul_comm]`... standard:
`have h₂θ := hcal; unfold B1Calibration at h₂θ; field_simp [h1c]; ring` where
`h1c : (1:ℝ) - Real.cos θ ≠ 0 := by have : Real.cos θ < 1 := Real.cos_lt_one_of...` —
`Real.cos_lt_one (θ) needs θ ≠ 0`-circle; use `ne_of_gt (sub_pos.mpr (Real.cos_lt_of... ))`; simplest:
`have hcos : Real.cos θ < 1 := by have h := Real.cos_sq_add_sin_sq θ; nlinarith [Real.sin_pos_of_pos_of_lt_pi
  hθ.1 (hθ.2.trans (Real.pi_div_two_lt_pi...))]`... prover picks; certificate `sin θ > 0` is immediate.

**Defect E (`power_ratio_eq_width_ratio` L354 + target L368):** from `PowerBudget` fields
(`received_power_eq : P = I·collectedWidth`, `unmirrored_power_eq`/`P₀ = I·(2a)` — check accessor names at
L188-197): `rw [budget.received_power_eq, budget.unmirrored_power_eq, collectedWidth_eq_two_mul_yOff
then `I·(2 yOff)/(I·(2a))`: cancel `I ≠ 0` (budget intensity positivity field — check `intensity.I_pos`),
`field_simp; ring`. Final target `power_ratio_in_terms_of_theta_max`: obtain `⟨yOff, hyOff, hhit⟩ :=
r.hitSet_Ioo`, then
`calc budget.P / budget.P₀ = (2*yOff)/(2*p.a) := power_ratio_eq_width_ratio ...
  _ = 2*p.R*Real.sin θ/(2*p.a) := by rw [yOff_eq_R_sin_thetaMax ...]
  _ = 1/(1 - Real.cos θ) := two_r_sin_over_diameter_eq p ⟨hθ-range⟩ hcal`
where `hθrange : θ ∈ Ioo 0 (π/2)` must be DERIVED from `ThetaMaxSpec` + `halfMirrorArc` incidence bounds —
check `ThetaMaxSpec` fields (L220-224): attainment on the open arc gives `θ ∈ range incidenceAngle ⊆ Ioo 0 (π/2)`;
if `incidenceAngle` range fields aren't packaged, derive `0 < θ` from attainment + `abs_hitOffset_eq` + `hyOff`.

**Blueprint:** `2_B_2.tex` — the width-accounting derivation matches the file docstring (recorded
`P/P₀ = 1/(1 - cos θ_max)`); no chapter edit needed.

## 4. `IPhO2026Problems/problem_IPhO_2026_2_C_2.lean` — retry 1/3 (pure parse repair, proofs already written)

**Defect (sole blocker):** dangling `/--` doc block at L177-182 (`branch_denominators_ne_zero` doc text) with the
lemma itself missing — parser hits the next `/--` at L184 and dies with `182:40 unexpected token /--; expected lemma`.
Strategy (do exactly ONE of):
  (i) RESTORE the lemma below its docstring: insert after the doc block (before the L184 `/--`):
      `theorem branch_denominators_ne_zero (s : NeighboringRayExpansion) :
          sin (2 * s.θ) ≠ 0 ∧ cos s.θ ≠ 0`... — but only if it was genuinely deleted; the doc names the
      conclusion "`sin (2θ) ≠ 0` and `cos θ ≠ 0` on the Figure-2g branch", so the faithful restoration needs the
      branch hypothesis; CHECK git history (`git log -p -- IPhO2026Problems/problem_IPhO_2026_2_C_2.lean | grep -A6
      branch_denominators`) to recover the exact deleted signature before re-adding. If recoverable, restore
      verbatim: that is a repair of the iter-013 deletion, not a new declaration.
  (ii) If unrecoverable quickly (<5 min of git archaeology): convert the dangling `/--` into a plain section
      comment `/- ... -/`-style NON-doc (`/-` open) or delete the orphan block — this is comment-only editing,
      does not touch any statement. Prefer (i); else (ii)-minimal.
**Then:** recompile; chase residual `end`-scope fallout (the redraft agent's own LSP flagged possible extra/missing
`end Namespace`): `namespace NeighboringRayExpansion` at L174 needs exactly one `end NeighboringRayExpansion`
before the file-final `end IPhO2026_2_C_2` (check names via `grep -n 'namespace\|^end'`): balance them by
counting; fix only `end` lines, never statements. Expected outcome per review: 0 errors, 0 sorries
(both little-o targets fully proved via the deriv-coefficient route already in-file).

**Blueprint:** `2_C_2.tex` — statement fragments and recorded answer match the in-file contract
(`m_B = cot(2θ) - 2csc²(2θ)Δθ`, `b_B = R/(2cosθ)(1 + tanθ Δθ)`); no chapter edit needed.

## Cross-cutting verification protocol (each target, in order)

1. After edits, `lake env lean IPhO2026Problems/<file>.lean` (full-file check; LSP MCP calls first if available
   for per-goal iteration).
2. Acceptance for `2_C_2`: 0 errors + 0 sorries. For `2_C_4`: 0 errors + 0 sorries is required — it is retry 2/3;
   if the `IsEquivalent` rpow-chain cannot close in budget, convert ONLY the final-assembly sorry into the
   explicitly-commented `sorry` and report honestly (do NOT fake-close).
3. For `1_C_1` and `2_B_2`: 0 compile errors mandatory; sorry-count targets 0 and 5→0 respectively, but honest
   partial reductions (with marked remaining gaps) are acceptable per the non-negotiable faithfulness policy —
   never weaken statements to close.
4. Bluepunch: none of the four chapters needs text edits this iter (all "no concrete strategy defect" — the
   defects are all in Lean proof layers); if a prover afterwards discovers the `1_C_1` backward-branch
   monotonicity direction contradicts the physics, flag in results for the next PLAN pass rather than editing
   the chapter mid-prover.
