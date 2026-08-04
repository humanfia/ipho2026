# Prover result — `IPhO2026Problems/problem_IPhO_2026_3_B_1.lean` (iter-010)

**Outcome: no proof bodies changed. All 3 sorries are provably FALSE as stated; each
has a machine-checked countermodel. Signatures were left frozen; the file compiles
identically (0 errors, 3 `sorry` warnings). Redraft requested with minimal fixes.**

## What was verified (fresh `lake env lean` on copies of the file's own definitions)

1. `leg_mem_tracked_range` (L199) is **false**.
   Countermodel `badProc` (`p = ⟨0,1,2,1,0⟩`, `T=1`, `H_i=H_f=-1`, `M_of_H H = 2H`,
   EOS holds since `nK=2`): at `H=-1` the leg point `M=-1.5 ∈ uIcc 0 (M_of_H(-1))
   = Icc(-2) 0` but `-1.5 ∉ Icc (min 0 (min H_i H_f)) (max 0 (max H_i H_f))
   = Icc(-1) 0`. Wrong locus: the field-range `Icc(min..max)` can NEVER contain
   the leg `uIcc 0 (M_of_H H)` as soon as `|nK/(TV)|` maps the field range outside
   itself (`M_of_H(-1) = -2` vs range bound `-1`).
   Compiling negation proof: `.archon/task_results/witness_leg_mem_IS_FALSE.lean`.

2. `leg_work_integral_eval` (L215) is **false**.
   Countermodel `weirdProc` (`p = ⟨1,1,1,-2,0⟩`, `T=1`, `H_i=H_f=-2`,
   `M_of_H = if H ∈ Icc(-2) 0 then -2H else 0`, EOS holds on the whole field range
   `Icc(-2) 0`, `hV`: `V=1≠0`): at `H=-2`, LHS = `∫ M in 0..4, (1·1·M_of_H M) dM = 0`
   (the leg `uIcc 0 4` lies outside the field range where `M_of_H = 0`),
   RHS = `(1·1·(-2)/(2·1))·4² = -16`. Root cause identical to (1): `h_eos`
   constrains `M_of_H` only on the FIELD range `Icc(min 0 (min Hi Hf)) (max 0 (max Hi Hf))`,
   but the work integral sweeps MAGNETIZATION values `uIcc 0 (M_of_H H)`, over which
   `IsMagneticWorkDensity` samples `M_of_H` at those same numeric values as if they
   were fields — off-range and unconstrained.
   Compiling negation proof: `.archon/task_results/witness_leg_integral_eval_IS_FALSE.lean`.

3. `isothermal_heat_into_torus` (L257, the target) is **false**.
   Countermodel `linProc` (`p = ⟨1,1,1,-2,0⟩`, `T=1`, `H_i=-2`, `H_f=-1`,
   `M_of_H H = -2H` globally (EOS holds everywhere), `U ≡ 0` (heat-capacity law
   with `lambda=0`), `Q_in M = -∫₀..M (-2x)dx` — the honest leg-antiderivative,
   satisfying `h_ref` and the first law `ObeysFirstLawMagnetic` for the unique
   valid work density `wd M = -2M` (proved for all legs `(M₀,M_target)`):
   then `heatTransferredIntoTorus = -(∫₀..2) + (∫₀..4) = 4-16 = -12`, while
   `heat_into_torus_value = -(1·1·(-2)/(2·1))·((-1)²-(-2)²) = -3`. `-12 ≠ -3`.
   Compiling negation proof: `.archon/task_results/witness_target_IS_FALSE.lean`.
   Root cause: the target's hypotheses quantify the work integral over the
   MAGNETIZATION locus `∫ dM (μ₀ V M_of_H M)` — but physically `H_of_M` must be
   the field **as a function of magnetization** (so that on the EOS trajectory
   `H_of_M = H ∘ M^{-1}`), NOT `M_of_H` sampled at magnetization values.
   `IsMagneticWorkDensity p proc.M_of_H workDensity` silently substitutes
   `M_of_H` (field → magnetization) for `H_of_M` (magnetization → field),
   so the tracked density is the wrong function off the identity map and the
   M-space and H-space integrals disagree (missing Jacobian `dM/dH` factor).

## Redraft needed

- Original problem id: `IPhO_2026_3` part B.1; report `reports/ipho_2026_k3/problem_IPhO_2026_3_B_1.source.json`.
- `theorem leg_mem_tracked_range` — hopeless as stated (no physics fix; it confuses
  the field range with the magnetization locus). Recommend deleting it or
  restating to relate `M_of_H` at the two endpoint fields, not set-inclusion of
  the M-sweep inside the field range.
- `theorem leg_work_integral_eval` — replace by the H-parametrized identity
  `∫ H in Href..Ht, μ₀·V·(H)·(dM/dH) dH = μ₀·n·K/(2T)·(Ht² − Href²)` under a
  global-EOS hypothesis, or alternatively restate `IsMagneticWorkDensity` to take
  a genuine `H_of_M` supplied together with `∀ M, H_of_M M = M*(T*V)/(n*K)`.
- `theorem isothermal_heat_into_torus` — minimal faithful fix: add a hypothesis
  giving `M_of_H` on the magnetization locus the EOS value,
  e.g.
  ```
  h_eos_global : ∀ M : ℝ, SatisfiesEOS p ⟨proc.T, proc.M_of_H M, M⟩
  ```
  OR change `ObeysFirstLawMagnetic`/`IsMagneticWorkDensity` to parametrize work by
  the field (`∫ μ₀ V H (dM/dH) dH`). With `h_eos_global`, the leg lemma becomes
  provable (`wd M = μ₀ nK/T · M` pointwise everywhere) and the target follows by
  `integral_const_mul` + `integral_id` + `field_simp`; the H_i/H_f leg bounds are
  never needed. This keeps the physical conclusion and the first-law structure
  intact; only the (currently contradictory) range bookkeeping changes.
- Note for the review lane: three compiling witnesses above can be re-run as
  regression tests against any redraft (a sound redraft must make all three
  witnesses fail to typecheck against the new signature).

## Status
- File unchanged from iter-009 (byte-identical); `lake env lean`: 0 errors,
  3 `sorry` warnings at L201/L223/L263 (original placeholders retained per the
  "never revert to a bare sorry" rule — no partial progress exists that could
  close a false goal without dishonesty).
- `official_answer_value` (L285): already proved by `rfl`; unchanged.
- Blueprint: do NOT mark `\leanok` for `lem:...:LegMemTrackedRange`,
  `lem:...:LegWorkIntegralEval`, `thm:...:IsothermalHeatIntoTorus`; the chapter's
  proof sketches (case-analysis on `Set.uIcc` against the field-range bounds) are
  exactly the false step (1) above and need rewriting.
