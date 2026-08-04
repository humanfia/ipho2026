import Mathlib

/-!
# IPhO 2026, Problem 3 (paramagnetic-torus Carnot refrigerator), Subquestion C.3

Blueprint chapter: blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_3_C_3.tex
Source report:     reports/ipho_2026_k3/problem_IPhO_2026_3_C_3.source.json
Official page:     T3_page-4.png (Figure 3b, cycle 1 → 2 → 3 → 4 → 1 in the
                   H-versus-T plane; T3-C3 data block)

## Physical situation

The paramagnetic torus (Pm-T, potassium chromate) executes the Carnot
refrigeration cycle 1 → 2 → 3 → 4 → 1 of Figure 3b in the H-versus-T
plane.  T_h, T_c are the hot- and cold-reservoir temperatures; Q_h,
Q_c are the *magnitudes* of the heat delivered to the hot reservoir and
absorbed from the cold reservoir.  Governing laws (previous parts,
natural-language prerequisites only — no Lean imports across problem files):

* equation of state of the paramagnet: T * M * V = n * K * H;
* isothermal heat relation (part B.1): the heat *into* the torus when the
  applied field changes H_i → H_f at temperature T is
  Q = -(μ₀ * n * K / (2 * T)) * (H_f² - H_i²);
* Carnot heat ratio for the reversible cycle: Q_h * T_c = Q_c * T_h;
* Figure-3b vertex reading (part C.1): vertices 1,4 sit at T_h,
  vertices 2,3 sit at T_c; legs 1→2, 3→4 are isothermal and legs
  2→3, 4→1 are adiabatic.

## Current subquestion (C.3, 0.8 pts)

Cool 1.00 L of liquid helium initially at 1.00 K with a Pm-T made of
2.0 mol potassium chromate
(K = 1.87e-6 K·m³/mol, density 2730 kg/m³, molar mass 0.19 kg/mol),
executing one operating cycle with
H₁ = 411624 A/m, H₂ = 311306 A/m, H₃ = 204618 A/m, H₄ = 240446 A/m.
The helium has constant specific heat capacity c = 100 J/(kg·K) and
constant density ρ = 130 kg/m³.  Find the helium temperature after one
cycle.

Recorded official answer (appears only on the conclusion side below):

    Q_c = 1.29e-1 J,  |ΔT| = 9.92e-3 K,  T_final = 0.99008 K.

## Derivation route recorded for the proof phase

1. Volume (B-part result, V = m/ρ_source): the source density and molar
   mass give V = n * M_mol / ρ_source.
2. Cold isothermal leg 1 → 2 (B.1 law with T_1 = T_2 = T_c): the torus
   absorbs Q_c = -(μ₀ * n * K / (2 * T_c)) * (H₂² - H₁²) from the helium.
3. Hot isothermal leg 3 → 4 (B.1 law with T_3 = T_4 = T_h): the torus
   dumps Q_h = (μ₀ * n * K / (2 * T_h)) * (H₄² - H₃²) into the hot
   reservoir.
4. Carnot ratio (reversible cycle): combining the two leg identities with
   Q_h * T_c = Q_c * T_h yields
   (H₁² - H₂²) * T_h² = (H₄² - H₃²) * T_c², the exact relation that fixes
   T_h from T_c and the vertex fields; then Q_c follows from the cold-leg
   formula.  (No numeric value of the ratio is assumed.)
5. Calorimetry of the helium: Q_c = m_He * c * (T_initial - T_final)
   with m_He = ρ_He * V_He; the run *cools* the helium, so the drop branch
   is recorded explicitly.

This file is an autoformalization: every proof body is sorry by design, and
the recorded answer values appear only as conclusions of the target theorems.
-/

namespace IPhO2026.Problem3.C3

section Quantities

/-!
### Named quantities and dimensional roles

Physical scalars (SI units): temperatures in kelvin, heats in joules,
applied-field and magnetization magnitudes in ampere per metre, amount of
substance in moles, volumes in cubic metres, densities in kilograms per
cubic metre, specific heat capacity in joules per kilogram-kelvin, molar
mass in kilograms per mole.  These are recorded as real scalars (numerical
magnitudes); the material-specific *data* of the T3-C3 block are opaque
parameters (see below) so the contracts cannot be closed by unfolding. -/

/-- Kind of one leg of the cycle of Figure 3b: isothermal or adiabatic, with
the field direction (decreasing/increasing) recorded so the branch
information of the figure is preserved. -/
inductive ProcessKind where
  | isothermal (isFieldDecreasing : Bool)
  | adiabatic (isFieldDecreasing : Bool)

/-- Vertex labels of the cycle 1 → 2 → 3 → 4 → 1 in Figure 3b. -/
inductive Vertex where | v1 | v2 | v3 | v4

/-- Thermodynamic state of the torus at the four vertices of Figure 3b,
together with the process labels of the four legs. -/
structure CarnotCycle where
  /-- Temperature of the torus at each vertex (K). -/
  T : Vertex → ℝ
  /-- Magnitude of the applied field at each vertex (A/m). -/
  Hmag : Vertex → ℝ
  /-- Magnitude of the magnetization at each vertex (A/m). -/
  Mmag : Vertex → ℝ
  /-- Kind of the process 1 → 2 (isothermal, H decreasing). -/
  proc12 : ProcessKind
  /-- Kind of the process 2 → 3 (adiabatic, H decreasing). -/
  proc23 : ProcessKind
  /-- Kind of the process 3 → 4 (isothermal, H increasing). -/
  proc34 : ProcessKind
  /-- Kind of the process 4 → 1 (adiabatic, H increasing). -/
  proc41 : ProcessKind

/-- Physical parameters of the paramagnetic torus and its material
(potassium chromate in C.3).  Built with the anonymous constructor
⟨μ₀, n, K, V, hμ₀, hn, hK, hV⟩; the `TorusParams.mk` field order is
the order listed here. -/
structure TorusParams where
  /-- Vacuum permeability μ₀ (H/m). -/
  μ₀ : ℝ
  /-- Amount of paramagnetic ions, n (mol). -/
  n : ℝ
  /-- Material constant K of the equation of state T·M·V = n·K·H
  (K·m³/mol). -/
  K : ℝ
  /-- Fixed volume V of the torus (m³). -/
  V : ℝ
  μ₀_pos : 0 < μ₀
  n_pos : 0 < n
  K_pos : 0 < K
  V_pos : 0 < V

/-- The equation of state of the ideal paramagnet, T·M·V = n·K·H.
A governing law assumed about the model, not a local definition. -/
def EquationOfStateParamagnet (p : TorusParams) (T H M : ℝ) : Prop :=
  T * M * p.V = p.n * p.K * H

/-- Isothermal heat relation from part B.1 (governing law / previous-part
result, assumed — not proved — here): when the applied field changes from
H_i to H_f at constant temperature T, the heat transferred *into* the
torus is

    Q = -(μ₀·n·K / (2·T)) · (H_f² - H_i²).

The heat argument is signed (into the torus positive), so the transfer
direction is carried by the sign, not by the final answer. -/
def IsothermalHeatIntoTorus (p : TorusParams) (T Hi Hf Q : ℝ) : Prop :=
  Q = -(p.μ₀ * p.n * p.K / (2 * T)) * (Hf ^ 2 - Hi ^ 2)

/-- Carnot heat ratio for the reversible refrigeration cycle (second law
applied around the cycle: zero net entropy change and the adiabatic legs
carry no heat).  Qh, Qc are *magnitudes*, so the relation carries no
sign. -/
def CarnotHeatRatio (Th Tc Qh Qc : ℝ) : Prop :=
  Qh * Tc = Qc * Th

/-- The Figure-3b reading (part C.1 conclusion, natural-language
prerequisite): states 1,4 lie at T_h, states 2,3 lie at T_c, and the four
legs have the roles shown in the figure. -/
def Figure3bAssignment (cyc : CarnotCycle) (Th Tc : ℝ) : Prop :=
  cyc.T .v1 = Th ∧ cyc.T .v4 = Th ∧ cyc.T .v2 = Tc ∧ cyc.T .v3 = Tc ∧
  cyc.proc12 = .isothermal true ∧ cyc.proc23 = .adiabatic true ∧
  cyc.proc34 = .isothermal false ∧ cyc.proc41 = .adiabatic false

/-- Torus-volume relation from the previous (B) part: the torus volume is
its mass over its source density, V = n · M_mol / ρ_source, with the mass
written as amount times molar mass.  A previous-part result, assumed here. -/
def TorusVolumeFromSource (p : TorusParams) (molarMass sourceDensity : ℝ) : Prop :=
  p.V = p.n * molarMass / sourceDensity

/-- Constant-heat-capacity calorimetry (meaning of the specific heat
capacity c): a body of mass m exchanging heat Q changes temperature by ΔT
with Q = m · c · ΔT.  A governing law of the cooled body, in the constant-c
regime stated by the problem. -/
def ConstantCapacityCalorimetry (m c Q ΔT : ℝ) : Prop :=
  Q = m * c * ΔT

end Quantities

section SuppliedData

/-!
### Supplied potassium-chromate and liquid-helium data (T3-C3 block)

These are calibrated data readouts from the official problem statement, so
they are recorded as opaque parameters with positivity certificates only —
the recorded *answer* is never baked into them.  Magnitudes:

* torus material: K = 1.87e-6 K·m³/mol, source density 2730 kg/m³,
  molar mass 0.19 kg/mol, amount n = 2.0 mol;
* cycle vertex fields: H₁ = 411624, H₂ = 311306, H₃ = 204618,
  H₄ = 240446 A/m (recorded in the structure below);
* liquid helium: volume 1.00 L = 1.00e-3 m³, initial temperature 1.00 K,
  specific heat capacity c = 100 J/(kg·K), density ρ = 130 kg/m³. -/

/-- The supplied potassium-chromate and liquid-helium material data,
bundled so that positivity is carried as structure fields (plain
hypotheses, no new axioms).  The components are opaque *data* readouts —
they cannot be unfolded to any answer value. -/
structure SuppliedMaterialData where
  /-- Amount of potassium-chromate paramagnetic ions (mol). -/
  amount : ℝ
  /-- Material constant K = 1.87e-6 K·m³/mol. -/
  materialK : ℝ
  /-- Source (material) density 2730 kg/m³. -/
  sourceDensity : ℝ
  /-- Molar mass 0.19 kg/mol. -/
  molarMass : ℝ
  /-- Liquid-helium density 130 kg/m³. -/
  heliumDensity : ℝ
  /-- Liquid-helium specific heat capacity 100 J/(kg·K). -/
  heliumSpecificHeat : ℝ
  amount_pos : 0 < amount
  materialK_pos : 0 < materialK
  sourceDensity_pos : 0 < sourceDensity
  molarMass_pos : 0 < molarMass
  heliumDensity_pos : 0 < heliumDensity
  heliumSpecificHeat_pos : 0 < heliumSpecificHeat

/-- The concrete supplied data record of the T3-C3 block (opaque: its
component values cannot be unfolded, matching the read-out-from-statement
character of the data).  The `Nonempty` witness is the tautological
centred instance; it constrains nothing because the positivity fields are
only ever used through the opaque `suppliedData`, never through the
witness. -/
opaque suppliedData : SuppliedMaterialData := by
  exact ⟨1, 1, 1, 1, 1, 1, by norm_num, by norm_num, by norm_num,
    by norm_num, by norm_num, by norm_num⟩

/-- Supplied data: amount of potassium-chromate paramagnetic ions (mol). -/
def pmtAmount : ℝ := suppliedData.amount
/-- The amount is the stated 2.0 mol, hence positive. -/
lemma pmtAmount_pos : 0 < pmtAmount := suppliedData.amount_pos
/-- Supplied data: material constant K = 1.87e-6 K·m³/mol. -/
def pmtMaterialK : ℝ := suppliedData.materialK
/-- The material constant is positive. -/
lemma pmtMaterialK_pos : 0 < pmtMaterialK := suppliedData.materialK_pos
/-- Supplied data: source (material) density 2730 kg/m³. -/
def pmtSourceDensity : ℝ := suppliedData.sourceDensity
/-- The source density is positive. -/
lemma pmtSourceDensity_pos : 0 < pmtSourceDensity := suppliedData.sourceDensity_pos
/-- Supplied data: molar mass 0.19 kg/mol. -/
def pmtMolarMass : ℝ := suppliedData.molarMass
/-- The molar mass is positive. -/
lemma pmtMolarMass_pos : 0 < pmtMolarMass := suppliedData.molarMass_pos
/-- Supplied data: liquid-helium density 130 kg/m³. -/
def heliumDensity : ℝ := suppliedData.heliumDensity
/-- The helium density is positive. -/
lemma heliumDensity_pos : 0 < heliumDensity := suppliedData.heliumDensity_pos
/-- Supplied data: liquid-helium specific heat capacity 100 J/(kg·K). -/
def heliumSpecificHeat : ℝ := suppliedData.heliumSpecificHeat
/-- The helium specific heat capacity is positive. -/
lemma heliumSpecificHeat_pos : 0 < heliumSpecificHeat :=
  suppliedData.heliumSpecificHeat_pos

/-- Supplied data: liquid-helium bath volume (m³); the statement gives
1.00 L = 1.00e-3 m³.  This is a plain unit-conversion constant, not a
physical law, so a transparent definition is faithful. -/
def heliumBathVolume : ℝ := 1.00e-3

/-- The Pm-T torus built from the supplied potassium-chromate data:
V = n · M_mol / ρ_source (the B-part volume formula).  The physical
*content* (that this is the torus volume) is carried by the p_volume field
of the run structure below; this definition only packages the supplied
numbers.  Defined by the anonymous constructor so the projections
reduce definitionally, with the equalities exposed as `rfl` lemmas
below. -/
noncomputable def potassiumChromateTorus (μ₀ : ℝ) (hμ₀ : 0 < μ₀) : TorusParams :=
  ⟨μ₀, pmtAmount, pmtMaterialK, pmtAmount * pmtMolarMass / pmtSourceDensity,
    hμ₀, pmtAmount_pos, pmtMaterialK_pos,
    div_pos (mul_pos pmtAmount_pos pmtMolarMass_pos) pmtSourceDensity_pos⟩

/-- Projections of the packaged potassium-chromate torus (definitional
equalities, exposed for rewriting). -/
lemma potassiumChromateTorus_n (μ₀ : ℝ) (hμ₀ : 0 < μ₀) :
    (potassiumChromateTorus μ₀ hμ₀).n = pmtAmount := rfl
/-- Material-constant projection. -/
lemma potassiumChromateTorus_K (μ₀ : ℝ) (hμ₀ : 0 < μ₀) :
    (potassiumChromateTorus μ₀ hμ₀).K = pmtMaterialK := rfl
/-- Volume projection. -/
lemma potassiumChromateTorus_V (μ₀ : ℝ) (hμ₀ : 0 < μ₀) :
    (potassiumChromateTorus μ₀ hμ₀).V =
      pmtAmount * pmtMolarMass / pmtSourceDensity := rfl

end SuppliedData

section CoolingRun

/-- The model for subquestion C.3: one operating cycle of the Pm-T Carnot
refrigerator absorbing heat from a constant-capacity liquid-helium bath.
The target conclusions of C.3 (Q_c ≈ 1.29e-1 J, |ΔT| ≈ 9.92e-3 K,
T_final ≈ 0.99008 K) do *not* occur among these fields: they stay on the
conclusion side of the target theorems. -/
structure PotassiumChromateCoolingRun where
  /-- The potassium-chromate torus parameters. -/
  p : TorusParams
  /-- The torus uses the supplied amount and material constant. -/
  p_amount : p.n = pmtAmount
  p_K : p.K = pmtMaterialK
  /-- Torus volume from the supplied source density and molar mass
  (previous-part B result). -/
  p_volume : TorusVolumeFromSource p pmtMolarMass pmtSourceDensity
  /-- The cycle of Figure 3b executed by the torus. -/
  cyc : CarnotCycle
  /-- Hot-reservoir temperature T_h (K). -/
  Th : ℝ
  /-- Cold-reservoir = helium temperature during the cycle T_c (K). -/
  Tc : ℝ
  /-- Magnitude of heat delivered to the hot reservoir (J). -/
  Qh : ℝ
  /-- Magnitude of heat absorbed from the helium bath (J). -/
  Qc : ℝ
  /-- Mass of the liquid-helium bath (kg). -/
  heliumMass : ℝ
  /-- Helium temperature before the cycle (K). -/
  TInitial : ℝ
  /-- Helium temperature after the cycle (K). -/
  TFinal : ℝ
  Th_pos : 0 < Th
  Tc_pos : 0 < Tc
  /-- Refrigerating orientation: the cold reservoir is colder. -/
  Tc_lt_Th : Tc < Th
  /-- The cycle genuinely pumps heat to the hot reservoir. -/
  Qh_pos : 0 < Qh
  /-- The cycle genuinely absorbs heat from the helium. -/
  Qc_pos : 0 < Qc
  heliumMass_pos : 0 < heliumMass
  TInitial_pos : 0 < TInitial
  TFinal_pos : 0 < TFinal
  /-- The cycle runs with the helium initially at 1.00 K, which is the
  cold-reservoir temperature of the cycle. -/
  initial_is_Tc : TInitial = Tc ∧ TInitial = 1.00
  /-- Bath-mass readout: m_He = ρ_He · V_He with the supplied density and
  the 1.00 L bath volume. -/
  bath_mass : heliumMass = heliumDensity * heliumBathVolume
  /-- Vertex fields are the supplied operating-cycle values (A/m). -/
  vertex_fields :
    cyc.Hmag .v1 = 411624 ∧ cyc.Hmag .v2 = 311306 ∧
    cyc.Hmag .v3 = 204618 ∧ cyc.Hmag .v4 = 240446
  /-- Figure-3b reading: which vertex sits at which temperature, and which
  leg is which. -/
  figure3b : Figure3bAssignment cyc Th Tc
  /-- Field and magnetization magnitudes are nonnegative at the vertices. -/
  H_nonneg : ∀ v, 0 ≤ cyc.Hmag v
  M_nonneg : ∀ v, 0 ≤ cyc.Mmag v
  /-- Equation of state T·M·V = n·K·H at each vertex of the cycle. -/
  eos : ∀ v, EquationOfStateParamagnet p (cyc.T v) (cyc.Hmag v) (cyc.Mmag v)
  /-- Isothermal heat relation (B.1) on the cold leg 1 → 2: the heat into
  the torus is +Qc (heat enters the torus since H₂ < H₁). -/
  heat_12 : IsothermalHeatIntoTorus p Tc (cyc.Hmag .v1) (cyc.Hmag .v2) Qc
  /-- Isothermal heat relation (B.1) on the hot leg 3 → 4: the heat into
  the torus is -Qh (heat leaves the torus since H₄ > H₃). -/
  heat_34 : IsothermalHeatIntoTorus p Th (cyc.Hmag .v3) (cyc.Hmag .v4) (-Qh)
  /-- Carnot heat ratio Qh/Qc = Th/Tc (reversible cycle). -/
  carnot_ratio : CarnotHeatRatio Th Tc Qh Qc
  /-- Calorimetry of the helium bath: the heat removed from the helium
  equals m·c·(T_initial − T_final).  The temperature-drop form records
  the *cooling* branch explicitly — the final state is colder. -/
  helium_calorimetry :
    ConstantCapacityCalorimetry heliumMass heliumSpecificHeat Qc
      (TInitial - TFinal)

namespace PotassiumChromateCoolingRun

variable (r : PotassiumChromateCoolingRun)

/-- The vertex applied-field magnitudes of the operating cycle (A/m). -/
abbrev H1 : ℝ := r.cyc.Hmag .v1
abbrev H2 : ℝ := r.cyc.Hmag .v2
abbrev H3 : ℝ := r.cyc.Hmag .v3
abbrev H4 : ℝ := r.cyc.Hmag .v4

/-- Torus-volume value forced by the supplied data:
V = n · M_mol / ρ_source.  Carrier: p_volume + p_amount
(definition unfolding of TorusVolumeFromSource only — a naming
certificate, not a substantive C.3 conclusion). -/
lemma torus_volume_value :
    r.p.V = pmtAmount * pmtMolarMass / pmtSourceDensity := by
  have h : r.p.V = r.p.n * pmtMolarMass / pmtSourceDensity := r.p_volume
  rw [r.p_amount] at h
  exact h

/-- Cold-leg (B.1) heat balance in explicit operating-cycle form: the heat
absorbed from the helium is

    Q_c = (μ₀·n·K / (2·T_c)) · (H₁² − H₂²).

Carrier: heat_12 (the signed B.1 law with heat into torus = +Q_c) with
negations cancelled; positivity comes from H₂ < H₁ (the field-decreasing
leg recorded in figure3b plus vertex_fields). -/
lemma Qc_cold_leg :
    r.Qc = (r.p.μ₀ * r.p.n * r.p.K / (2 * r.Tc)) * (r.H1 ^ 2 - r.H2 ^ 2) := by
  sorry

/-- Hot-leg (B.1) heat in explicit operating-cycle form:

    Q_h = (μ₀·n·K / (2·T_h)) · (H₄² − H₃²).

Carrier: heat_34 with negations cancelled; positive because H₄ > H₃. -/
lemma Qh_hot_leg :
    r.Qh = (r.p.μ₀ * r.p.n * r.p.K / (2 * r.Th)) * (r.H4 ^ 2 - r.H3 ^ 2) := by
  sorry

/-- Consistency of the supplied vertex data with the reversible cycle:
combining the two leg identities with the Carnot heat ratio gives

    (H₁² − H₂²) · T_h² = (H₄² − H₃²) · T_c²,

the exact relation that fixes T_h from T_c and the vertex fields.
Carrier: Qc_cold_leg, Qh_hot_leg, carnot_ratio and pure algebra with
T_h, T_c ≠ 0, Q_c ≠ 0 (a *consequence* of the assumed laws — no numeric
answer value is used). -/
lemma reservoir_temperature_consistency :
    (r.H1 ^ 2 - r.H2 ^ 2) * r.Th ^ 2 = (r.H4 ^ 2 - r.H3 ^ 2) * r.Tc ^ 2 := by
  sorry

/-- Calorimetry in explicit temperature form: the helium temperature after
one cycle is

    T_final = T_initial − Q_c / (m·c)

(so the magnitude of the temperature drop is Q_c / (m·c)).  Carrier:
helium_calorimetry with m, c ≠ 0 (heliumMass_pos,
heliumSpecificHeat_pos). -/
lemma TFinal_from_calorimetry :
    r.TFinal = r.TInitial - r.Qc / (r.heliumMass * heliumSpecificHeat) := by
  sorry

/-- The helium *cools* (branch certificate): T_final < T_initial, since
Q_c > 0 on a genuinely refrigerating cycle and m, c > 0.  Carrier:
TFinal_from_calorimetry, Qc_pos, heliumMass_pos, heliumSpecificHeat_pos. -/
lemma helium_cools : r.TFinal < r.TInitial := by
  sorry

end PotassiumChromateCoolingRun

end CoolingRun

section OfficialAnswer

/-!
### Official numeric answer — conclusion side only

The recorded official answer Q_c = 1.29e-1 J, |ΔT| = 9.92e-3 K,
T_final = 0.99008 K appears ONLY as the conclusions of the theorems in
this section; nothing in PotassiumChromateCoolingRun assumes any of these
values.  The bands record the official rounding of the marked answer, so
they too stay conclusion-side. -/

/-- **Subquestion C.3 target (i): value of the absorbed heat.**
One operating cycle absorbs Q_c ≈ 1.29e-1 J from the helium bath
(band = official rounding of Q_c = 1.29e-1 J). -/
theorem absorbed_heat_value (r : PotassiumChromateCoolingRun) :
    |r.Qc - 1.29e-1| < 5.0e-4 := by
  sorry

/-- **Subquestion C.3 target (ii): value of the helium temperature drop.**
The helium temperature drops by |ΔT| ≈ 9.92e-3 K in one cycle. -/
theorem temperature_drop_value (r : PotassiumChromateCoolingRun) :
    |(r.TInitial - r.TFinal) - 9.92e-3| < 5.0e-5 := by
  sorry

/-- **Subquestion C.3 target (iii): final helium temperature.**
After one operating cycle the liquid helium is at T_final ≈ 0.99008 K
(officially T_final = 0.99008 K). -/
theorem final_temperature_value (r : PotassiumChromateCoolingRun) :
    |r.TFinal - 0.99008| < 5.0e-5 := by
  sorry

end OfficialAnswer

end IPhO2026.Problem3.C3
