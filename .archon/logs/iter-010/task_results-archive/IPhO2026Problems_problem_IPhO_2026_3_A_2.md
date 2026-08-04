# Prover task result: IPhO2026Problems/problem_IPhO_2026_3_A_2.lean

Iteration: 010 (prover stage, physics mode)
Assigned file: `IPhO2026Problems/problem_IPhO_2026_3_A_2.lean`
Blueprint chapter: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_3_A_2.tex`

## Outcome

**Both contracted sorries closed; the file is now sorry-free and compiles with 0 errors.**

- `IPhO2026_3_A_2.fieldStrength_eq_N_mul_I_mul_A_div_V` (bridge lemma, H = N*I*A/V) -- proved.
- `IPhO2026_3_A_2.work_emf_eq_V_mul_H_mul_dB` (Part A.2 target, dW_emf = V*H*dB) -- proved.

No statement/signature/hypothesis changes; only proof bodies after `:= by` were edited.

## Proof sketches (as implemented)

- `fieldStrength_eq_N_mul_I_mul_A_div_V`: derive
  `h2pR : 2*pi*R = V/A` from the bundled ring-volume law
  `t.volume_eq : V = 2*pi*R*A` cleared by
  `mul_div_cancel_righto _ (ne_of_gt t.A_pos.1)`; then
  `rw [op.ampere, h2pR, div_div_eq_mul_div]` turns `N*I/(2*pi*R)` into `N*I*A/V`.
- `work_emf_eq_V_mul_H_mul_dB`: first derive `key : N*I*A = V*H` via the bridge
  lemma and `mul_div_cancelo _ (ne_of_gt t.V_pos.1)` (i.e. `V*(NIA/V) = NIA`);
  then `unfold sourceWork`, `congr 1` reduces the `WorkOnSource` structure
  equality to the scalar identity, closed by
  `linear_combination key * e.dB + e.faraday * op.I`
  (exact antecedent: `(NIA - V*H)*dB + (emf*dt - N*A*dB)*I = emf*I*dt - V*H*dB`,
  i.e. Faraday's law times I plus the A.1 bridge times dB -- matching the
  blueprint informal proof).

Implementation note: no `rcases` on the `IsPositive` fields is needed; they
project via `.1` (e.g. `t.A_pos.1 : 0 < t.A`).

## Verification

- Fresh `lake env lean IPhO2026Problems/problem_IPhO_2026_3_A_2.lean`: 0 errors,
  0 warnings, no `sorry` remaining (grep exit 1).
- `lake build`: completed successfully (4 jobs).
- `#print axioms` (MCP `lean_verify`) for both theorems:
  `[propext, Classical.choice, Quot.sound]` only -- no `sorryAx`, no new axioms,
  no `native_decide`, no metaprogramming tricks.

## Blueprint

`\leanok` added to the two proved environments per the prover prompt:
- `lem:IPhO2026Problems_problem_IPhO_2026_3_A_2:fieldStrength_eq_N_mul_I_mul_A_div_V`
- `thm:IPhO2026Problems_problem_IPhO_2026_3_A_2:work_emf_eq_V_mul_H_mul_dB`

(If the review gate prefers deterministic `sync_leanok` ownership of these
markers, they can be reverted; sync should converge to the same state since the
file is sorry-free.)

## Redraft needed

None. The formalization is faithful and provable as stated: the recorded
official answer `dW_emf = V*H*dB` is derived honestly from the bundled
governing laws. (The constitutive law B = mu0*H + mu0*M is correctly unused
for A.2, as expected physically.)

## Mathlib API notes (for other lanes, v4.31.0)

- `mul_div_cancel_righto : (a : M0) -> b != 0 -> a * b / b = a` -- first
  argument is EXPLICIT in this Mathlib version; use `mul_div_cancel_righto _ hA`.
- `mul_div_cancelo : b != 0 -> b * (a / b) = a` (CommGroupWithZero) -- the
  dividend argument is explicit: `mul_div_cancelo _ hV`.
- `mul_div_cancel'` does NOT exist here; do not use it.
