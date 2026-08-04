# Directive — `blueprint-writer` subagent `1-b-2-entries`

## Scope
Blueprint chapter `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_1_B_2.tex`
(covers Lean file `IPhO2026Problems/problem_IPhO_2026_1_B_2.lean`). You write ONLY this .tex file.

## Why
33 live Lean declarations (the full Coulomb-scattering formalization layer) have NO blueprint
entry (leandag `unmatched` bucket). Coverage-debt rule: every non-private decl gets a chapter
block with `\label`, `\lean{full.Name}`, accurate `\uses{}`, ≥1-line informal proof.

## Source of truth (MANDATORY first step)
READ `IPhO2026Problems/problem_IPhO_2026_1_B_2.lean` first-hand, in full (545 lines). The names
below were planner-grep-verified this iter; the file's docstrings carry the physical units and
the assumption/target split — restate them faithfully. Namespace `IPhO2026.Problem1.B2`.
The file compiles clean with exactly 5 sorries (`total_energy_pos`, `eccentricity_sq_eq`,
`exists_asymptoticRelativeVelocity`, `signed_deflection_eq_formula`,
`signed_deflection_angle_T1_B2`, `unsigned_deflection_angle_in_degrees_T1_B2` — recount: the
compiled sorry warnings number 5 lines; `orbit_eq_conic`, `eccentricity_sq_eq` also sorry —
the count on disk is authoritative).

## Decl inventory with informal content (dependency order)
1. `Plane` (abbrev) + `dot`, `perp` (defs): ambient 2D Euclidean plane; scalar product; oriented
   planar bracket `perp a b = a_x·b_y − a_y·b_x` carrying the rotation sense of the deflection.
2. Opaques `particleMass`, `hbar`, `coulombK`, `elementaryCharge`, `bohrRadius`; structure
   `ScalingRegime`: positivity certificates for all constants; `a₀ = 4πε₀ℏ²/(m e²)`.
3. `IsAngularMomentumFactor` (def): predicate that a real `μ` makes per-particle angular momentum
   `μℏ > 0`; `unboundMu` (def `:= 15/2`); `unboundMu_isAngularMomentumFactor` (theorem, PROVED:
   `15/2 > 0`).
4. `CoulombScatteringData` (structure): the B.1-style two-body record — CM-frame relative curve
   `sep : ℝ → Plane`, initial data (`r₀ = 100·a₀`, antiparallel velocities ⊥ separation,
   relative speed `2 v₀`, per-particle angular momentum `μℏ`), reduced mass `m/2`, total `L`, `E`,
   governing-law fields (Coulomb Newton equation, angular-momentum conservation, radial-energy
   identity multiplied out, turning point at `t=0`, regularity, `sep ≠ 0`). No orbit shape /
   asymptotic velocity / deflection among fields.
5. Fields/lemmas:
   - `CoulombScatteringData.initial_separation_pos` (theorem, PROVED): `0 < r₀` from `100·a₀`, `a₀ > 0`.
   - `CoulombScatteringData.total_angular_momentum_value` (theorem, PROVED): `L = 2·(μℏ) = 15ℏ`.
   - `CoulombScatteringData.turningQuadratic` (def): `Q(r) = E r² + k e² r − L²/(2 m_red)`.
   - `CoulombScatteringData.turningQuadratic_periapsis` (theorem, PROVED): `Q(r₀) = 0` — radial energy at `t=0`.
   - `CoulombScatteringData.semilatusRectum` (def): `p = L²/(m_red·k·e²)`.
   - `CoulombScatteringData.eccentricitySq` (def): `ε² = 1 + 2 E L²/(m_red (k e²)²)` = Hint-1 `1 + 4EL²/(k²e⁴m)` for equal masses.
6. Unboundness family:
   - `total_energy_pos` (theorem, sorry): `E = μ²/2500 − 1/200` in units `ℏ²/(m a₀²)` = `7/400 > 0`
     (energy law at `t=0`, `r₀ = 100a₀`, Bohr-radius identity; NO angle content).
   - `eccentricity_gt_one` (theorem, PROVED): the added Hint-1 term positive ⇒ `ε² > 1`.
   - `eccentricity_sq_eq` (theorem, sorry): evaluate ⇒ `ε² = 67/4`.
   - `orbit_eq_conic` (theorem, sorry): Hint-2 polar conic `r = p/(1 − ε cos θ)` from Binet's
     equation + the periapsis condition. Bridge lemma, not assumed orbit shape.
7. Asymptotic-velocity layer:
   - `RelativeVelocityVector` (structure): planar vector record.
   - `initialDirection` (noncomputable def): unit direction of the positron's initial velocity.
   - `IsAsymptoticRelativeVelocity` (structure): `u.vec` is the `atTop` limit of `deriv sep`,
     `u.vec ≠ 0`, branch `perp initialDirection u.vec ≤ 0` (deflection toward the line connecting
     the pair — the "below the initial line of motion" sign carrier).
   - `exists_asymptoticRelativeVelocity` (theorem, sorry): existence on the outward hyperbolic branch.
8. Angle layer:
   - `angleBetween` (noncomputable def): `arccos(⟨a,b⟩/(‖a‖‖b‖)) ∈ [0,π]`.
   - `signed_deflection_eq_formula` (theorem, sorry): `‖u∞‖ = √(2E/m_red)` ∧
     `angleBetween u₀ u∞ = π − 2·arctan(1/√(ε²−1))` — magnitude from energy at infinity;
     direction from hyperbola asymptote geometry. Orientation input but NO numeric deflection.
   - `signedDeflection` (noncomputable def): `± angleBetween` by the branch sign.
   - `radiansToDegrees` (def): `θ·180/π`.
   - `signedDeflection_eq_neg_angle` (theorem, PROVED): strict branch `perp u₀ u∞ < 0` ⇒
     `signedDeflection = −angleBetween` (definitional if_neg).
9. Official-answer layer (conclusion-side ONLY):
   - `roundsToOfficialDegrees` (def): `[−16.605, −16.595)` band; `roundsToOfficialDegreesAbs`:
     `[16.595, 16.615)` band.
   - `asymptote_factor_certificate` (theorem, PROVED): `1/√(67/4 − 1) = 2/√63` (algebra +
     `√(63/4) = √63/2`).
   - `signed_deflection_angle_T1_B2` (theorem, sorry): **T1-B2 MAIN TARGET** — ∃ `u∞` with signed
     deflection `= −(π − 2·arctan(2/√63))` rad, degree reading rounds to `−16.60`.
   - `unsigned_deflection_angle_in_degrees_T1_B2` (theorem, sorry): magnitude corollary rounding
     to `16.60`.

## Task
1. KEEP the existing chapter skeleton verbatim (source paragraphs,
   `thm:physics:IPhO_2026_1_B_2:target`, the iter-003 PhysLean-exemption NOTE).
2. ADD `\subsection*` blocks in the 9-layer dependency order above
   (e.g. `Ambient plane and constants`, `Scattering data and governing laws`,
   `Unboundness and conic bridges`, `Asymptotic relative velocity`, `Deflection angle`,
   `Official answer (conclusion side only)`), one `definition`/`lemma`/`theorem` block per
   declaration. Rules:
   - `\label{def|lem|thm:IPhO2026Problems_problem_IPhO_2026_1_B_2:<name>}`;
     `\lean{IPhO2026.Problem1.B2.<exact name>}` (note: `IPhO2026.Problem1.B2`, NOT `IPhO2026_T1_B2`).
   - `\uses{}` = real logical deps (mirror the list above: e.g. `turningQuadratic_periapsis`
     uses the `turningQuadratic` and the data entries; `orbit_eq_conic` uses `semilatusRectum` +
     the turning/lemmas; the main target uses existence + formula + neg-angle + `ε²=67/4` +
     asymptote certificate + rounding-band def).
   - 1–3 line informal statement; 1–4 line informal proof — mathematical, no tactic names.
     For the PROVED-on-disk ones the proof can be descriptive ("rewrites …; positivity").
     For the sorry ones give the derivation sketch as in the list.
   - Multi-`\lean{}` folding ONLY for genuinely atomic bundles: `Plane`+`dot`+`perp` in one
     entry; the 5 opaques + `ScalingRegime` certificates in one entry each is fine but the
     opaques must all be pinned (one `\lean{}` per name inside the entry).
3. Target theorem block: `\label{thm:IPhO2026Problems_problem_IPhO_2026_1_B_2:signed_deflection_angle_T1_B2}`,
   full `\uses{}` per above, 3–5 line informal proof (existence ⇒ formula with `ε² = 67/4` ⇒
   asymptote factor `2/√63` ⇒ branch sign ⇒ radians→degrees ⇒ interval membership ⇒ rounds to
   `−16.60`). The numeric `−16.60`, `83/900`-style constants appear ONLY here and in the
   rounding-band definitions.
4. Wire `thm:physics:IPhO_2026_1_B_2:target`'s `\uses{}` to include the main target label
   (and optionally the magnitude corollary).
5. Physical-fidelity: Hint 1 (`ε` formula) and Hint 2 (conic) are explicitly OFFICIAL HINTS
   recorded on the problem page — mark them as derivable bridge lemmas, not assumed laws;
   the branch condition "deflection toward the line connecting the pair" is a figure/body
   assumption recorded in `IsAsymptoticRelativeVelocity`; every numeric answer value is
   conclusion-side.
6. Do NOT touch other files or markers.

## Report
`.archon/task_results/blueprint-writer-1-b-2-entries.md`: list of blocks + final pins.
