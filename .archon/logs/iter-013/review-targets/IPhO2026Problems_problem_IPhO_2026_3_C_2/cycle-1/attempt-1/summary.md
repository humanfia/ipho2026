# Proof Review: problem_IPhO_2026_3_C_2.lean (iter 13)

- Route: `needs_redraft` (underdetermined_contract); status `blocked`.
- Compiles rc=0 with exactly one active `sorry` (line 423, body of `q_relation`); no axiom/admit/native_decide.
- Main target `m1_eq_sqrt` (official answer, signature unchanged) is fully proved from the adiabatic-leg laws alone via `m1_sq`; its chain has no sorry and no answer-as-assumption.
- Iter-10 defects (wrong leg temperatures, wrong q-form prefactor) are fixed in the iter-11 redraft and verified here.
- Root cause: under Figure 3b (T1=T4=Th, T2=T3=Tc) the adiabatic log-law collapses to 0=0 giving only M1^2=M4^2 and M3^2=M2^2; the Carnot ratio then reduces to the tautology M4^2=M4^2, while `q_relation` reduces to Th*M4^2=Tc*M2^2 (isentropy amplitude of legs 1->2/3->4) — determined by no model field. A concrete countermodel (prover trace, session_end) satisfies all fields yet violates `q_relation`, so the sorry is unclosable without a contract change.
- Repair: add one model field, e.g. `q_leg12 : T v1 * Mmag v1^2 = T v2 * Mmag v2^2` (common-q/isentropy of leg 1->2); then `q_relation` closes by `linear_combination` from `hratio` with `hcold`/`hhot`. Blueprint's `q_relation` proof sketch ("cancel prefactor, collect linearly") is wrong and must be amended.
- Process warnings: no newest matching task-result artifact was supplied in the review packet (empty list); the iter-13 trace references `.archon/task_results/problem_IPhO_2026_3_C_2.md` with a "## Redraft needed" section consistent with this review.
