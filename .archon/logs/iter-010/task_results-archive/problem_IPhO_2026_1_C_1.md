# Task Result: IPhO2026Problems/problem_IPhO_2026_1_C_1.lean

## Status
- Compile: `lake env lean IPhO2026Problems/problem_IPhO_2026_1_C_1.lean` exits 0.
- Errors: 0.
- Warnings: exactly the 6 expected `declaration uses sorry` warnings (L184, L244, L255, L279, L293, L307 at audit time; same six declarations).
- Edit summary: **no source edit this iteration** — the file is already a compiling by-sorry formalization faithful to the chapter; only this task result is new.

## Assumption/target split

### Governing laws (modeled as hypothesis/structure data)
- Vector momentum conservation for `γ + O₃ → O₂ + O`: the photon momentum `p_γ = ℏω/c · k̂` equals the sum of fragment momenta `p⃗ + q⃗` (`IsTwoBodyDissociation.q_unique`, with the eliminated cosine-law shadow `IsTwoBodyDissociation.momentum_q_sq`).
- Non-relativistic energy balance: the photon energy `ℏω` covers the dissociation gap `ΔU` plus the classical kinetic energies of the `O₂` fragment (mass `2m`) and the `O` fragment (mass `m`) (`IsTwoBodyDissociation.energy_balance`).
- Photon momentum/angular-frequency relation `p_γ = ℏω/c` (used inside both law fields above).

### Previous-part results
- None used — C.1 is a self-contained subquestion (no `.uses` edge to an earlier subpart in the chapter).

### Figure/data readouts
- `IsScatteringAngle`: `θ` is the angle between the outgoing `O₂` momentum `p⃗` and the incident photon direction `k̂` (Figure 1c), exposed as the eliminable component equation `⟪k̂, p⟫ = ‖p‖ * cos θ` with `p ≠ 0`.
- `IsAngularRange`: `θ ∈ [0, π]`.
- `IsForwardBranch`: the `θ ≤ π/2` branch where the tangent-line critical configuration exists; `π/2 ≤ θ` is the backward branch (freeze at the `π/2` value).
- `ConstantRegime`: `ℏ > 0`, `c > 0`, `m > 0`, endothermic gap `ΔU > 0`.

### Current target conclusions (conclusion side only)
- `minimum_angular_frequency_T1_C1`: the candidate `Ω(m,c,ΔU,θ) = 3mc²(1 − √(1 − (ΔU/(3mc²))(2sin²θ+1))) / (ℏ(2sin²θ+1))` *is* the dissociation threshold (`IsDissociationThreshold`) at a nondegenerate forward angle `0 < θ ≤ π/2` with a real square root.
- `minimum_angular_frequency_backward_branch_T1_C1`: for `π/2 ≤ θ ≤ π` the threshold freezes at the forward candidate evaluated at `π/2`.
- `quadratic_characterization_of_threshold`: `ℏ·Ω` is the smallest positive root of `(2 − cos2θ)E² − 6mc²E + 6ΔUmc² = 0` (official derivation route carrier).
- `two_sin_sq_add_one_eq`: `2sin²θ + 1 = 2 − cos2θ` (trig helper).
- `momentum_q_sq_of_vector_balance`: the cosine-law magnitude equation is a consequence of the vector balance + angle readout (interface bridge).
- `hbarOmegaMin_pi_sub`: the candidate depends on `θ` only via `sin²θ`, hence is invariant under `θ ↦ π − θ`.

## Goal-faithfulness audit
- `hbarOmegaMin` is a bare scalar expression; it appears as a *value* argument inside the conclusions of the two threshold theorems and the quadratic-characterization lemma — never as a hypothesis, structure field, or local definition that a proof could unfold to close the goal.
- `ReachableFrequency` is an existential over lawful configurations (`∃ k p q, IsTwoBodyDissociation …`); `IsDissociationThreshold` couples reachability of `ω₀` with non-reachability of every strictly smaller positive frequency. Neither mentions the closed form.
- The law structure `IsTwoBodyDissociation` quantifies over a single configuration only; minimality lives exclusively in `IsDissociationThreshold` on the conclusion side.
- The square-root reality/discriminant side condition `hdisc` is a hypothesis of the main theorem, but it is a *nondegeneracy precondition*, not the answer; it does not determine which expression is minimal.
- No current target conclusion is restated as a `Satisfies…`/`Valid…` predicate or as a `Laws` field.

## Derivability and bridge obligations
- Bridge 1 — source claim: vector momentum balance implies the cosine-law magnitude equation for `q`. Carrier: `momentum_q_sq_of_vector_balance` (sorried proof). Status: covered — route is `q_unique` substitution, norm/inner expansion with `k.direction_unit` and the `IsScatteringAngle` component equation.
- Bridge 2 — source claim: reachability at forward angle reduces to the official quadratic in `E = ℏω`, whose smallest positive root is `ℏ·Ω`. Carrier: `quadratic_characterization_of_threshold` (sorried proof). Status: covered — route recorded in the docstring (angular-factor identity `two_sin_sq_add_one_eq` + quadratic formula with the minus-sign root ordered first).
- Bridge 3 — source claim: the candidate expression is the minimum reachable angular frequency at a nondegenerate forward angle. Carrier: `minimum_angular_frequency_T1_C1` (sorried proof). Status: covered — contract stated as `IsDissociationThreshold … (hbarOmegaMin …)`; bridge from law fields to reachability/minimality is the sorried body (eliminate `‖p‖` between `energy_balance` and `momentum_q_sq`, then apply Bridge 2).
- Bridge 4 — source claim: for `θ ≥ π/2` the threshold freezes at the `π/2` value. Carrier: `minimum_angular_frequency_backward_branch_T1_C1` (sorried). Status: covered — route uses the forward theorem at `π/2` plus `hbarOmegaMin_pi_sub`; the binding-constraint transfer is the sorried body documented in the chapter proof block.
- Bridge 5 — source claim: the candidate is reflection-symmetric. Carrier: `hbarOmegaMin_pi_sub` (sorried proof). Status: covered — pure-math lemma; route `sin(π−θ) = sin θ`.
- Bridge 6 — source claim: `2sin²θ + 1 = 2 − cos2θ`. Carrier: `two_sin_sq_add_one_eq` (sorried proof). Status: covered — pure Mathlib trig (`Real.cos_two_mul`, `Real.sin_sq`).

## Abstraction sufficiency and countermodel audit
- `PhotonLine` (structure): `direction : ReactionPlane` with `direction_unit : ‖direction‖ = 1` — a usable equation for norm/inner rewrites; not interpretable as an arbitrary vector.
- `IsScatteringAngle` (Prop): conjunction of `p ≠ 0` with the component equation `⟪k̂, p⟫ = ‖p‖ * cos θ` — fixes the angle up to the cosine law; a countermodel cannot choose `θ` independently of the geometry while keeping the field true.
- `IsTwoBodyDissociation` (structure of 4 equation fields): `q_unique` fixes `q` as a function of `(ω, p, k̂)`; `momentum_q_sq` is its eliminated shadow (proved by Bridge 1); `energy_balance` ties `ℏω` to `ΔU` and the two kinetic energies with masses `2m` and `m`. A model that arbitrarily reinterprets the fields breaks at least one equation.
- `ReachableFrequency` (Prop): existential over the constrained class above — inherits the constraints.
- `IsDissociationThreshold` (Prop): `ReachableFrequency ω₀ ∧` a universal non-reachability clause for `0 < ω < ω₀` — an order/minimality elimination principle; two different values cannot both satisfy it at the same angle (any reachable `ω₁ < ω₀` contradicts the second conjunct), so the predicate pins the threshold value.
- `ConstantRegime` (structure): pure positivity certificates (`hbar_pos`, `speedOfLight_pos`, `oxygenAtomMass_pos`, `gap_pos`) — supplies the side-conditions the prover-stage algebra (division, sqrt) needs.
- `IsAngularRange`/`IsForwardBranch` (Props): interval memberships; constrain the branch on the hypothesis side.
- Countermodel sanity check: with the constants opaque and all law/geometry fields equation-constrained, the only freedom left is the actual solution set of the energy/momentum system; the threshold predicate is minimality, so a wrong candidate value fails either reachability (if below the true threshold) or the no-smaller-frequency clause (if above). No hypothesis-true/conclusion-false instance was identified.

## Uncertainty and branch coverage
- Uncertainty: **not applicable** — the source subquestion asks for an exact symbolic threshold; no `value ± uncertainty` pair occurs in the chapter or source report, so there is nothing to propagate.
- Branch coverage: **covered** — forward (`IsForwardBranch`, `θ ≤ π/2`) and backward (`π/2 ≤ θ`) branches are separate hypothesis-side predicates feeding two separate theorems; the freeze direction (backward uses the forward candidate at `π/2`) is fixed by the chapter's tangent-line existence argument, and the reflection-symmetry carrier `hbarOmegaMin_pi_sub` is declared.

## Declarations created (existing, audited this iteration) and blueprint labels
- `IPhO2026.Problem1.C1.hbar`, `speedOfLight`, `oxygenAtomMass`, `photonAngularFrequency`, `ozoneGroundStateEnergy`, `fragmentsGroundStateEnergy` (opaque constants; folded into the chapter's quantities subsection prose).
- `IPhO2026.Problem1.C1.dissociationEnergyGap` — `def:IPhO2026Problems_problem_IPhO_2026_1_C_1:dissociationEnergyGap`.
- `IPhO2026.Problem1.C1.ConstantRegime` — `def:IPhO2026Problems_problem_IPhO_2026_1_C_1:ConstantRegime`.
- `IPhO2026.Problem1.C1.ReactionPlane` — `def:IPhO2026Problems_problem_IPhO_2026_1_C_1:ReactionPlane`.
- `IPhO2026.Problem1.C1.PhotonLine`, `IsScatteringAngle`, `IsAngularRange`, `IsForwardBranch` — geometry-section definitions (labels in the chapter geometry subsection).
- `IPhO2026.Problem1.C1.IsTwoBodyDissociation` and `momentum_q_sq_of_vector_balance` — `lem:IPhO2026Problems_problem_IPhO_2026_1_C_1:momentum_q_sq_of_vector_balance` (law-structure label in the governing-laws subsection).
- `IPhO2026.Problem1.C1.ReachableFrequency`, `IsDissociationThreshold`, `hbarOmegaMin` — `def:IPhO2026Problems_problem_IPhO_2026_1_C_1:IsDissociationThreshold`, `def:IPhO2026Problems_problem_IPhO_2026_1_C_1:hbarOmegaMin`.
- `IPhO2026.Problem1.C1.two_sin_sq_add_one_eq` — `lem:IPhO2026Problems_problem_IPhO_2026_1_C_1:two_sin_sq_add_one_eq`.
- `IPhO2026.Problem1.C1.quadratic_characterization_of_threshold` — `lem:IPhO2026Problems_problem_IPhO_2026_1_C_1:quadratic_characterization_of_threshold`.
- `IPhO2026.Problem1.C1.minimum_angular_frequency_T1_C1` — `thm:IPhO2026Problems_problem_IPhO_2026_1_C_1:minimum_angular_frequency_T1_C1`.
- `IPhO2026.Problem1.C1.minimum_angular_frequency_backward_branch_T1_C1` — `thm:IPhO2026Problems_problem_IPhO_2026_1_C_1:minimum_angular_frequency_backward_branch_T1_C1`.
- `IPhO2026.Problem1.C1.hbarOmegaMin_pi_sub` — `thm:IPhO2026Problems_problem_IPhO_2026_1_C_1:hbarOmegaMin_pi_sub`.
- Marker readiness: all six sorried declarations are faithful contracts; the chapter still carries 0 `\leanok` markers, which matches the sync policy (bodies are `sorry`, so no `\leanok` should be applied yet).

## LeanExplore queries/candidates actually used
From the lane's recorded grounding log (`physics-grounding-IPhO2026Problems_problem_IPhO_2026_1_C_1.md`):
- `Real.sqrt square root` → `Real.sqrt` (used in `hbarOmegaMin`, `hdisc`).
- `EuclideanSpace vector components` → `EuclideanSpace` (used for `ReactionPlane = EuclideanSpace ℝ (Fin 2)`).
- `Scattering angle readout` → `Real.Angle`, `Orientation.oangle`, `EuclideanGeometry.angle` (evaluated as near-misses; the intrinsic inner-product formulation `@inner ℝ _ _ k.direction p = ‖p‖ * cos θ` was chosen instead — avoids quotient-type angle coercions while keeping the cosine-law content).
- `Angular range of the problem` → `Set.range` near-miss; `Set.Icc` used directly in `IsAngularRange`.
- PhysLean queries (`Space.fderiv_space_components`, `Lorentz.ContrMod.toSpace`, `MSSMACC.planeY₃B₃`) returned only near-misses for relativistic two-body photodissociation kinematics; mismatch recorded in the chapter's import-policy exemption NOTE.

## PhysLean/Mathlib names grounded
- `EuclideanSpace ℝ (Fin 2)` (Mathlib `Analysis.InnerProductSpace.PiL2`).
- `@inner ℝ _ _` and `‖·‖` on the Euclidean plane (Mathlib inner-product space API).
- `Real.cos`, `Real.sin`, `Real.sqrt`, `Real.pi` (Mathlib).
- `Set.Icc` for the angular range (via `open Real Set`).
- PhysLean: none grounded (recorded exemption; no suitable module exists).

## Local abstractions introduced and why they preserve physical meaning
- `opaque hbar / speedOfLight / oxygenAtomMass / ozoneGroundStateEnergy / fragmentsGroundStateEnergy`: role-bearing SI constants kept opaque so contracts cannot be closed by unfolding; positivity lives in `ConstantRegime`.
- `PhotonLine`: unit-vector photon direction keeps `k̂` intrinsic.
- `IsScatteringAngle`: component-equation form of the Figure-1c angle readout; eliminable for the cosine-law elimination.
- `IsTwoBodyDissociation`: the governing-law record — vector momentum balance, its cosine-law shadow, the figure angle readout, and non-relativistic energy balance with masses `2m`, `m`. None of its fields mentions the threshold candidate.
- `ReachableFrequency` / `IsDissociationThreshold`: existential reachability plus minimality — the physical content of "minimum angular frequency for dissociation" without any closed-form assumption.
- `hbarOmegaMin`: the bare recorded candidate expression; carrying it as a plain `def` (not an assumption) preserves the prove obligation.

## Grounding gaps and redraft requests
- Gap: PhysLean has no module for relativistic/two-body photodissociation kinematics; the file stays on the `import Mathlib` baseline per the chapter's recorded import-policy exemption NOTE.
- Review-gate ledger note: this lane's sole recorded retry reason is the generic `missing-physlib-import` check, which the chapter-level exemption NOTE already resolves; all six semantic review checks passed at iter-008. No redraft requested.
