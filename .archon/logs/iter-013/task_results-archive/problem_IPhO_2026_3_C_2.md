# Prover result: `IPhO2026Problems/problem_IPhO_2026_3_C_2.lean` (iter-013, physics mode)

## Status

- File compiles: YES — fresh `lake env lean IPhO2026Problems/problem_IPhO_2026_3_C_2.lean`
  exit 0, only the `declaration uses sorry` warning for `q_relation` (L370).
- Sorries: 1 open (`q_relation`), now with the maximal honest partial
  derivation in place and a concrete countermodel recorded below.
- Axioms / laundering: NONE introduced; no statements, signatures, or
  hypotheses were changed. No `native_decide`, no `admit`, no local re-defs.

## What was derived in `q_relation` (honest partial progress, in-file)

The body now honestly derives (inlined because a proof body cannot reference
later declarations):

- `hratio` — Carnot ratio with `Qh_eq`/`Qc_eq` substituted:
  $A\,(T_h M_4^2 - T_h M_3^2)\,T_c = -A\,(T_c M_2^2 - T_c M_1^2)\,T_h$;
- `hne` — the EOS prefactor $A = \mu_0 V^2/(2nK) \neq 0$;
- `hq1, hq3, hq4` — Figure-3b values of $q$;
- `hcold` — $M_3^2 = M_2^2$ (cold adiabat; log term collapses at $T_2=T_3=T_c$);
- `hhot` — $M_1^2 = M_4^2$ (hot adiabat; log term collapses at $T_1=T_4=T_h$).

Remaining gap (at the final `sorry`): only the amplitude equation below.

## Why it cannot be closed in the current model (algebraic fact)

Set $a=M_1^2$, $b=M_2^2$, $c=M_3^2$, $d=M_4^2$. In these square-difference
variables the model fields determine only:

- cold adiabat: $c = b$ (`hcold`)
- hot adiabat: $a = d$ (`hhot`)
- Carnot ratio + leg heats: $-a + b - c + d = 0$ (`hratio` / $A T_h T_c$)

while `q_relation` (via $c=b$) is equivalent to $T_h\,d = T_c\,b$ — linearly
independent of the three relations above. Concrete countermodel:

$T_h=2,\ T_c=1,\ A=1,\ b=c=1,\ a=d=3/2,\ Q_h=1/2,\ Q_c=1$

satisfies positivity, $T_c<T_h$, $Q_h,Q_c\ge 0$, both adiabatic leg laws
(both collapse to $0=0$ since $T_i=T_f$ on each adiabatic leg under
Figure 3b), both isothermal leg heats, the EOS (choose $H_v$ accordingly),
and the Carnot ratio ($\tfrac12\cdot 1 = 1\cdot \tfrac12$), yet violates
`q_relation` ($T_c q_1 = 3 \neq 7/2 = (T_c-T_h)q_4 + T_h q_3$).

Root cause, physically: with the Figure-3b temperatures the adiabatic-leg
laws collapse ($C_v\log(T_f/T_i)=0$), so they pin only square-**differences**;
the Carnot-ratio field is their algebraic shadow ($-a+b-c+d$) and adds
nothing; no field of `CarnotMagnetizationModel` determines the common
$q$-value ($q_1 = q_2$: isentropy of legs $1\to2$ / $3\to4$), which is
what `q_relation` encodes.

Consistency note: the **main target chain is sound** — `m1_sq` is proved
from the two leg laws alone ($a=d$, $c=b$ $\Rightarrow$ $a = b-c+d$ by
`ring`), and under the physical parameter fold (B.2 adiabatic first law
applied along legs 12/34) `q_relation` is derivable and consistent. The
failure is isolated in the eliminable bridge lemma `q_relation`.

## Redraft needed

- original problem id: IPhO_2026_3, part C.2
- report path: `reports/ipho_2026_k3/problem_IPhO_2026_3_C_2.source.json`
- theorem name: `IPhO2026.Problem3.C2.CarnotMagnetizationModel.q_relation`
- why not provable: underdetermined by the model fields (countermodel
  above; `carnot_ratio` is the algebraic shadow of the collapsed
  adiabatic-leg laws, no amplitude information).
- smallest faithful repair (any ONE of):
  1. (preferred, physical) Add one field to `CarnotMagnetizationModel`
     carrying the missing amplitude (B.2 adiabatic invariant):
     `q_leg12 : m.cyc.T .v1 * m.cyc.Mmag .v1 ^ 2 = m.cyc.T .v2 * m.cyc.Mmag .v2 ^ 2`
     (isentropy of leg $1\to2$, $q_1=q_2$). Then `q_relation` closes by
     `linear_combination` from `hq1, hq2, hq3, hq4`, `hcold` and that
     field, and the countermodel is excluded (it forces $T_h d = T_c b$).
  2. (minimal edit) Restate `q_relation` to what the model determines:
     the ratio-flattened form
     $(T_h M_4^2 - T_h M_3^2) T_c = -(T_c M_2^2 - T_c M_1^2) T_h$ after
     cancelling $A$ — provable today from `hratio` by `mul_left_cancel₀`.

## Blueprint marker recommendations (review agent / deterministic sync)

- `lem:...:q_relation` — NOT ready for `\leanok` (1 honest sorry).
- `lem:...:vertex_T_pos`, `lem:...:Qh_eq`, `lem:...:Qc_eq`,
  `lem:...:q4_eq_adiabatic_41`, `lem:...:q3_eq`,
  `thm:...:m1_sq`, `thm:...:m1_eq_sqrt`, `thm:...:m1_sq_arg_nonneg` —
  fully proved, ready for `\leanok`. `m1_sq`/`m1_eq_sqrt`/`m1_sq_arg_nonneg`
  do not depend on the sorried `q_relation` (their chain goes through the
  leg laws only), so their proofs are genuinely complete.

## Notes for the plan agent

- The iter-011 review record ("target chain fully proved; sole sorry
  `q_relation` not needed for the target") verified first-hand and
  sharpened: the previous vague "collision term" comment in the Lean body
  was replaced by the precise isolating derivation (`hcold`, `hhot`) plus
  the countermodel/linear-independence argument recorded here.
- If a redraft lane is scheduled: option 1 above is a one-field addition
  plus a ~6-line `linear_combination` finish; the blueprint chapter's
  `q_relation` proof sketch ("cancel the common positive factor and
  collect terms linearly") must then also be augmented — as written it
  wrongly suggests the cancellation alone closes the goal.
