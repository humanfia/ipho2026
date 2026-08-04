import Mathlib

/-!
# IPhO 2026, Problem 3 (Pm-T paramagnetic torus), Subquestion C.2

Carnot refrigeration cycle $1 \to 2 \to 3 \to 4 \to 1$ of the paramagnetic
torus (Pm-T) in the $H$-versus-$T$ plane (Figure 3b).  The task of C.2 is
to express $M_1$ in terms of $M_2$, $M_3$, and $M_4$:

$M_1 = \sqrt{M_2^2 - M_3^2 + M_4^2}$, $\qquad M_1 \ge 0$.

## Physical model extracted from the chapter

* Named quantities (dimensional roles; measured magnitudes are real scalars):
  - `Th`, `Tc`: hot- and cold-reservoir temperatures (kelvin).
  - `Qh`, `Qc`: *magnitudes* of the heat delivered to the hot reservoir and
    absorbed from the cold reservoir (joule).
  - `M1, M2, M3, M4`: magnitudes of the magnetization $\vec M$ at the four
    vertices $1,2,3,4$ of the cycle (ampere/metre).
  - `Hmag v`: magnitude of the applied field $\vec H$ at vertex $v$
    (ampere/metre).
  - `n`: amount of paramagnetic ions (mol); `K`: material constant of the
    equation of state; `V`: fixed torus volume (m³); `μ₀`: vacuum
    permeability.
* Geometry / figure labels (Figure 3b, $H$-$T$ diagram, carried over from
  part C.1 as a natural-language prerequisite): states $1$ and $4$ lie at
  the hot temperature $T_h$, states $2$ and $3$ at the cold temperature
  $T_c$; the legs $1\to2$, $2\to3$, $3\to4$, $4\to1$ are isothermal
  (field decreasing), adiabatic (field decreasing), isothermal (field
  increasing), adiabatic (field increasing).  The two adiabatic legs
  retrace the same adiabat between the same two field endpoints (they
  transfer no heat), which is what allows the state function
  $q = T\,M^2$ to be compared around the cycle.
* Governing laws (assumptions, never the C.2 answer):
  - Equation of state of the ideal paramagnet: $T\,M\,V = n\,K\,H$.
  - Isothermal heat relation of part B.1 (previous-part result): at fixed
    temperature $T$, when the field changes from $H_i$ to $H_f$, the heat
    transferred into the torus is
    $Q = -(\mu_0 n K/(2T))(H_f^2 - H_i^2)$.
  - Carnot heat ratio (second law along the reversible cycle):
    $Q_h\,T_c = Q_c\,T_h$.
  - Adiabatic legs transfer no heat; along them the state function
    $q = T M^2$ takes a common value on the shared adiabat (the B.2
    adiabatic relation, previous-part result).
* Current target conclusion (conclusion side only):
  $M_1 = \sqrt{M_2^2 - M_3^2 + M_4^2}$ as a nonnegative magnitude.

## Derivation route recorded for the proof phase

With $q_i = T_i M_i^2$ the EOS-substituted B.1 law is
$Q = -(\mu_0 V^2 T/(2nK))(M_f^2 - M_i^2)$ along an isothermal leg, and the
Carnot heat ratio turns the two leg identities into the scalar relation
$T_c\,q_1 = (T_c - T_h)\,q_4 + T_h\,q_3$.  The adiabatic legs give
$q_3 = q_2 = T_c M_2^2$ (leg $2\to3$) and $q_4 = q_1$ (leg $4\to1$);
solving the resulting linear system in the square-differences yields
$M_1^2 = M_2^2 - M_3^2 + M_4^2$, and the nonnegative square root is the
recorded official answer.

## Redraft note (Proof Review: wrong_or_weakened_target)

Iter-011 redraft of the contract routed back by Proof Review:
(i) the $q$-form prefactor is corrected to the EOS-substituted value
$-\mu_0 V^2/(2nK)$ multiplying the $q$-difference $T M_f^2 - T M_i^2$;
(ii) the adiabatic-leg invariance of the state function is recorded as an
explicit model field (`AdiabaticLegStateLaw`, `heat_leg23_adiabatic`,
`heat_leg41_adiabatic`) — no isothermal-law/temperature inconsistency is
carried, since the isothermal legs are stated in the $q$-form which the
Figure-3b temperatures make consistent;
(iii) the blueprint-pinned bridge names (`Qh_eq`, `Qc_eq`, `q_relation`,
`q4_eq_adiabatic_41`, `q3_eq`) are kept with corrected statements.
-/

namespace IPhO2026.Problem3.C2

/-- Kind of one leg of the cycle (the four legs of the Carnot refrigeration
cycle of Figure 3b): isothermal or adiabatic, with the direction (field
decreasing or increasing) recorded so the branch information of the figure
is preserved. -/
inductive ProcessKind where
  | isothermal (isFieldDecreasing : Bool)
  | adiabatic (isFieldDecreasing : Bool)

/-- Vertex labels of the cycle $1 \to 2 \to 3 \to 4 \to 1$ in Figure 3b. -/
inductive Vertex where | v1 | v2 | v3 | v4
  deriving DecidableEq

/-- The Carnot refrigeration cycle of the Pm-T torus: thermodynamic state
of the working substance at the four vertices of Figure 3b, together with
the labels of the four processes ($1\to2$, $2\to3$, $3\to4$, $4\to1$).

`T`, `Hmag`, `Mmag` are the *scalar readouts* of temperature, applied-field
magnitude and magnetization magnitude at each vertex. -/
structure CarnotCycle where
  /-- Temperature of the torus at each vertex (kelvin). -/
  T : Vertex → ℝ
  /-- Magnitude of the applied field at each vertex (ampere/metre). -/
  Hmag : Vertex → ℝ
  /-- Magnitude of the magnetization at each vertex (ampere/metre). -/
  Mmag : Vertex → ℝ
  /-- Kind of the process $1 \to 2$ (isothermal, $H$ decreasing). -/
  proc12 : ProcessKind
  /-- Kind of the process $2 \to 3$ (adiabatic, $H$ decreasing). -/
  proc23 : ProcessKind
  /-- Kind of the process $3 \to 4$ (isothermal, $H$ increasing). -/
  proc34 : ProcessKind
  /-- Kind of the process $4 \to 1$ (adiabatic, $H$ increasing). -/
  proc41 : ProcessKind

/-- Physical parameters of the paramagnetic torus (Pm-T) and its material. -/
structure TorusParams where
  /-- Vacuum permeability $\mu_0$. -/
  μ₀ : ℝ
  /-- Amount of paramagnetic ions, $n$ (mol). -/
  n : ℝ
  /-- Material constant $K$ of the equation of state $TMV = nKH$. -/
  K : ℝ
  /-- Fixed volume $V$ of the torus (m³). -/
  V : ℝ
  /-- Constant-volume heat capacity $C_v$ of the torus assembly (J/K);
  carried through the adiabatic legs ($U = C_v T + \text{const}$) and
  cancelled from the C.2 answer. -/
  Cv : ℝ
  μ₀_pos : 0 < μ₀
  n_pos : 0 < n
  K_pos : 0 < K
  V_pos : 0 < V
  Cv_pos : 0 < Cv

/-- The equation of state of the ideal paramagnet, $T\,M\,V = n\,K\,H$.
A *governing law* assumed about the model, not a local definition: its
consequence used downstream is $H = T M V / (n K)$, contracted in the
isothermal legs of the cycle. -/
def EquationOfStateParamagnet (p : TorusParams) (T H M : ℝ) : Prop :=
  T * M * p.V = p.n * p.K * H

/-- A thermodynamic state at which the equation of state holds and the
quantities are physically meaningful (positive temperature, nonnegative
field and magnetization magnitudes). -/
structure ParamagnetState (p : TorusParams) where
  T : ℝ
  H : ℝ
  M : ℝ
  T_pos : 0 < T
  H_nonneg : 0 ≤ H
  M_nonneg : 0 ≤ M
  eos : EquationOfStateParamagnet p T H M

/-- Isothermal heat relation from part B.1 (governing law / previous-part
result, assumed — not proved — here): when $H$ changes from $H_i$ to $H_f$
at constant temperature $T$, the heat transferred *into* the torus is

$Q = -\frac{\mu_0\,n\,K}{2T}\,(H_f^2 - H_i^2)$.

The heat argument is signed (into the torus positive), so the direction of
the transfer (in vs. out) is carried by the sign, not by the final answer. -/
def IsothermalHeatIntoTorus (p : TorusParams) (T Hi Hf Q : ℝ) : Prop :=
  Q = -(p.μ₀ * p.n * p.K / (2 * T)) * (Hf ^ 2 - Hi ^ 2)

/-- The $q$-form of the B.1 isothermal heat law after substituting the
equation of state: at fixed temperature $T$, the heat transferred into the
torus between two paramagnet states of magnetization magnitudes $M_i, M_f$
is

$Q = -\frac{\mu_0 V^2}{2 n K}\,(T M_f^2 - T M_i^2)$.

The two bracket differences are the state-function values $q_f - q_i$ with
$q = T M^2$; the prefactor $-\mu_0 V^2/(2nK)$ is the EOS-substituted
value (the B.1 prefactor $-\mu_0 nK/(2T)$ times $(TV/(nK))^2$ from
$H = TMV/(nK)$).  This is the carrier used for the isothermal legs of the
C.2 cycle; it contains no occurrence of the C.2 answer. -/
def IsothermalHeatQForm (p : TorusParams) (T Mi Mf Q : ℝ) : Prop :=
  Q = -(p.μ₀ * p.V ^ 2 / (2 * p.n * p.K)) * ((T * Mf ^ 2) - (T * Mi ^ 2))

/-- Adiabatic-leg state-function law for the paramagnetic torus (governing
law, previous-part result of part B): along an adiabatic leg (no heat
transferred) entropy is conserved; with $U = C_v T + \text{const}$ and the
magnetic work $W_{\text{on}} = \int\mu_0 H\,V\,\mathrm dM$ written via the
equation of state, the first law along the leg from $(T_i, M_i)$ to
$(T_f, M_f)$ reads

$C_v\,\log(T_f/T_i)
  = \frac{\mu_0 V^2}{2 n K}\,(M_f^2 - M_i^2)$,

the magnetic analogue of the ideal-gas adiabatic relation (in Physlib:
`adiabatic_relation_log` of `Physlib.Thermodynamics.IdealGas.Basic`,
which covers the gas law $U = cNk_BT$, $pV = Nk_BT$ — not this
$(M,H,T)$ model, whose work conjugate pair is $(H, M)$ rather than
$(p, V)$).  $C_v$ is the constant-volume heat capacity of the torus
assembly; the $\log$ form is what makes the leg amplitudes cancel the
lattice heat. -/
def AdiabaticLegStateLaw (p : TorusParams) (Ti Tf Mi Mf : ℝ) : Prop :=
  p.Cv * Real.log (Tf / Ti) =
    (p.μ₀ * p.V ^ 2 / (2 * p.n * p.K)) * (Mf ^ 2 - Mi ^ 2)

/-- Carnot heat ratio for the reversible refrigeration cycle (second law
applied along the cycle: the entropy changes on the two isothermal legs
sum to zero and the adiabatic legs transfer no heat).  $Q_h, Q_c$ here
are the *magnitudes* of the heats exchanged with the reservoirs, so the
relation carries no sign. -/
def CarnotHeatRatio (Th Tc Qh Qc : ℝ) : Prop :=
  Qh * Tc = Qc * Th

/-- The Figure-3b reading (part C.1 conclusion, natural-language
prerequisite): states $1,4$ lie at $T_h$, states $2,3$ lie at $T_c$, and
the four processes have the roles shown in the figure. -/
def Figure3bAssignment (cyc : CarnotCycle) (Th Tc : ℝ) : Prop :=
  cyc.T .v1 = Th ∧ cyc.T .v4 = Th ∧ cyc.T .v2 = Tc ∧ cyc.T .v3 = Tc ∧
  cyc.proc12 = .isothermal true ∧ cyc.proc23 = .adiabatic true ∧
  cyc.proc34 = .isothermal false ∧ cyc.proc41 = .adiabatic false

/-- The model hypotheses for subquestion C.2: reservoir data, reservoir
heat magnitudes, figure data, and the physical laws the cycle obeys.  The
C.2 answer ($M_1 = \sqrt{M_2^2 - M_3^2 + M_4^2}$) does *not* occur among
these fields: it stays on the conclusion side of `m1_eq_sqrt`.  The
isothermal B.1 law (in its EOS-substituted $q$-form) is attached to the
legs at the temperatures assigned by Figure 3b — leg $3\to4$ isothermal
at $T_h$ with heat $-Q_h$ into the torus, leg $1\to2$ isothermal at $T_c$
with heat $+Q_c$ into the torus (the refrigeration sign convention of the
chapter). -/
structure CarnotMagnetizationModel (p : TorusParams) where
  /-- The cycle of Figure 3b. -/
  cyc : CarnotCycle
  /-- Hot-reservoir temperature $T_h$ (kelvin). -/
  Th : ℝ
  /-- Cold-reservoir temperature $T_c$ (kelvin). -/
  Tc : ℝ
  /-- Magnitude of heat delivered to the hot reservoir (J). -/
  Qh : ℝ
  /-- Magnitude of heat absorbed from the cold reservoir (J). -/
  Qc : ℝ
  Th_pos : 0 < Th
  Tc_pos : 0 < Tc
  /-- Cold reservoir colder than hot reservoir (orientation of the cycle;
  the refrigerator branch also requires actual pumping, see `Qh_nonneg`). -/
  Tc_lt_Th : Tc < Th
  Qh_nonneg : 0 ≤ Qh
  Qc_nonneg : 0 ≤ Qc
  /-- Figure-3b reading: which vertex sits at which temperature, and which
  process is which. -/
  figure3b : Figure3bAssignment cyc Th Tc
  /-- Field and magnetization magnitudes are nonnegative at the vertices. -/
  H_nonneg : ∀ v, 0 ≤ cyc.Hmag v
  M_nonneg : ∀ v, 0 ≤ cyc.Mmag v
  /-- Equation of state $TMV = nKH$ at each vertex of the cycle. -/
  eos : ∀ v, EquationOfStateParamagnet p (cyc.T v) (cyc.Hmag v) (cyc.Mmag v)
  /-- $q$-form of the isothermal heat law on the heating leg $3 \to 4$
  (isothermal at $T_h$; the heat into the torus is $-Q_h$). -/
  heat_34 : IsothermalHeatQForm p Th (cyc.Mmag .v3) (cyc.Mmag .v4) (-Qh)
  /-- $q$-form of the isothermal heat law on the cooling leg $1 \to 2$
  (isothermal at $T_c$; the heat into the torus is $+Q_c$). -/
  heat_12 : IsothermalHeatQForm p Tc (cyc.Mmag .v1) (cyc.Mmag .v2) Qc
  /-- Adiabatic state law along $2 \to 3$ (no heat transferred; entropy
  conservation with $U = C_v T + \text{const}$ and the EOS magnetic-work
  form). -/
  heat_leg23_adiabatic :
    AdiabaticLegStateLaw p (cyc.T .v2) (cyc.T .v3) (cyc.Mmag .v2) (cyc.Mmag .v3)
  /-- Adiabatic state law along $4 \to 1$ (same law, other orientation). -/
  heat_leg41_adiabatic :
    AdiabaticLegStateLaw p (cyc.T .v4) (cyc.T .v1) (cyc.Mmag .v4) (cyc.Mmag .v1)
  /-- Carnot heat ratio $Q_h/Q_c = T_h/T_c$ (reversible cycle). -/
  carnot_ratio : CarnotHeatRatio Th Tc Qh Qc

namespace CarnotMagnetizationModel

variable {p : TorusParams} (m : CarnotMagnetizationModel p)

/-- Magnetization magnitude at vertex $1$: $M_1$. -/
abbrev M1 : ℝ := m.cyc.Mmag .v1

/-- Magnetization magnitude at vertex $2$: $M_2$. -/
abbrev M2 : ℝ := m.cyc.Mmag .v2

/-- Magnetization magnitude at vertex $3$: $M_3$. -/
abbrev M3 : ℝ := m.cyc.Mmag .v3

/-- Magnetization magnitude at vertex $4$: $M_4$. -/
abbrev M4 : ℝ := m.cyc.Mmag .v4

/-- $q_i = T_i M_i^2$, the state function which via the equation of state
is proportional to $\mu_0 n K H_i^2/(V T_i)$ and hence to the isothermal
heat increments of the B.1 law; it is the quantity conserved along the
adiabatic legs of the refrigeration cycle.  This abbreviation only *names*
the state function — the substantive equalities it satisfies on the
adiabatic legs are the content of the lemmas `q4_eq_adiabatic_41` and
`q3_eq`, not of this definition. -/
abbrev q (v : Vertex) : ℝ := m.cyc.T v * m.cyc.Mmag v ^ 2

/-- Vertex temperatures are positive (from $T_h, T_c > 0$ and Figure 3b). -/
lemma vertex_T_pos (v : Vertex) : 0 < m.cyc.T v := by
  obtain ⟨hT1, hT4, hT2, hT3, _, _, _, _⟩ := m.figure3b
  cases v
  · simp only [hT1]; exact m.Th_pos
  · simp only [hT2]; exact m.Tc_pos
  · simp only [hT3]; exact m.Tc_pos
  · simp only [hT4]; exact m.Th_pos

/-- Bridge between the B.1 heat law (in its $H$-form) and the equation of
state: along an isothermal leg at temperature $T$ between two paramagnet
states with magnetization magnitudes $M_i, M_f$, the heat into the torus
becomes

$Q = -\frac{\mu_0 V^2}{2 n K}\,(T M_f^2 - T M_i^2)$.

The carrier of this step is `EquationOfStateParamagnet` (giving
$H = TMV/(nK)$) substituted into `IsothermalHeatIntoTorus`; it does not
use the C.2 conclusion. -/
lemma heat_isothermal_via_q (si sf : ParamagnetState p) {Q : ℝ}
    (hT : si.T = sf.T)
    (h : IsothermalHeatIntoTorus p si.T si.H sf.H Q) :
    IsothermalHeatQForm p si.T si.M sf.M Q := by
  obtain ⟨Ti, Hi, Mi, hTi, hHi, hMi, heosi⟩ := si
  obtain ⟨Tf, Hf, Mf, hTf, hHf, hMf, heosf⟩ := sf
  dsimp only at hT h ⊢
  subst hT
  have heosf' : Ti * Mf * p.V = p.n * p.K * Hf := heosf
  have heosi' : Ti * Mi * p.V = p.n * p.K * Hi := heosi
  rw [IsothermalHeatIntoTorus] at h
  rw [IsothermalHeatQForm, h]
  have hnK : p.n * p.K ≠ 0 := mul_ne_zero (ne_of_gt p.n_pos) (ne_of_gt p.K_pos)
  have hTne : Ti ≠ 0 := ne_of_gt hTi
  have hf_sq : Hf ^ 2 = (Ti * Mf * p.V / (p.n * p.K)) ^ 2 := by
    have hH : Hf = Ti * Mf * p.V / (p.n * p.K) := by
      rw [eq_div_iff hnK]
      linear_combination -heosf'
    rw [hH]
  have hi_sq : Hi ^ 2 = (Ti * Mi * p.V / (p.n * p.K)) ^ 2 := by
    have hH : Hi = Ti * Mi * p.V / (p.n * p.K) := by
      rw [eq_div_iff hnK]
      linear_combination -heosi'
    rw [hH]
  rw [hf_sq, hi_sq]
  field_simp

/-- Along the heating leg $3\to4$: the contracted $q$-form datum of the
model, negated to the heat magnitude.  With Figure 3b giving $T_4 = T_h$
(and the leg isothermal at $T_h$),

$Q_h = \frac{\mu_0 V^2}{2 n K}\,(T_h M_4^2 - T_h M_3^2)$.

Carrier: `heat_34` unfolded and negated. -/
lemma Qh_eq : m.Qh = (p.μ₀ * p.V ^ 2 / (2 * p.n * p.K)) *
    (m.Th * m.M4 ^ 2 - m.Th * m.M3 ^ 2) := by
  have hrel : -m.Qh = -(p.μ₀ * p.V ^ 2 / (2 * p.n * p.K)) *
      ((m.Th * m.cyc.Mmag .v4 ^ 2) - (m.Th * m.cyc.Mmag .v3 ^ 2)) :=
    m.heat_34
  rw [neg_eq_iff_eq_neg] at hrel
  rw [hrel, neg_mul, neg_neg]

/-- Along the cooling leg $1\to2$: the contracted $q$-form datum of the
model,

$Q_c = -\frac{\mu_0 V^2}{2 n K}\,(T_c M_2^2 - T_c M_1^2)$.

Carrier: `heat_12` unfolded. -/
lemma Qc_eq : m.Qc = -(p.μ₀ * p.V ^ 2 / (2 * p.n * p.K)) *
    (m.Tc * m.M2 ^ 2 - m.Tc * m.M1 ^ 2) := by
  have hrel : m.Qc = -(p.μ₀ * p.V ^ 2 / (2 * p.n * p.K)) *
      ((m.Tc * m.cyc.Mmag .v2 ^ 2) - (m.Tc * m.cyc.Mmag .v1 ^ 2)) :=
    m.heat_12
  exact hrel

/-- The Carnot heat ratio combined with the two leg identities `Qh_eq`,
`Qc_eq` gives the scalar relation

$T_c\,q_1 = (T_c - T_h)\,q_4 + T_h\,q_3$

among the state-function values $q_i = T_i M_i^2$ at the vertices
(rewritten with $q_1 = T_h M_1^2$, $q_4 = T_h M_4^2$,
$q_3 = T_c M_3^2$). -/
lemma q_relation : m.Tc * m.q .v1 = (m.Tc - m.Th) * m.q .v4 + m.Th * m.q .v3 := by
  -- Substitute `Qh_eq`, `Qc_eq` into the Carnot heat ratio
  -- $Q_h T_c = Q_c T_h$, cancel the common positive prefactor
  -- $\mu_0 V^2/(2nK)$, rewrite with $q_1 = T_h M_1^2$,
  -- $q_4 = T_h M_4^2$, $q_3 = T_c M_3^2$ (Figure 3b) and collect terms.
  have hratio : m.Qh * m.Tc = m.Qc * m.Th := m.carnot_ratio
  have hne : (p.μ₀ * p.V ^ 2 / (2 * p.n * p.K)) ≠ 0 := by
    have hA : (0:ℝ) < (2:ℝ) * p.n := mul_pos two_pos p.n_pos
    have hB : (0:ℝ) < (2:ℝ) * p.n * p.K := mul_pos hA p.K_pos
    have hC : (0:ℝ) < p.μ₀ * p.V ^ 2 := mul_pos p.μ₀_pos (pow_pos p.V_pos 2)
    exact ne_of_gt (div_pos hC hB)
  rw [m.Qh_eq, m.Qc_eq] at hratio
  obtain ⟨hT1, hT4, -, hT3, -⟩ := m.figure3b
  have hq1 : m.q .v1 = m.Th * m.M1 ^ 2 := by
    change m.cyc.T .v1 * m.cyc.Mmag .v1 ^ 2 = _
    rw [hT1]
  have hq4 : m.q .v4 = m.Th * m.M4 ^ 2 := by
    change m.cyc.T .v4 * m.cyc.Mmag .v4 ^ 2 = _
    rw [hT4]
  have hq3 : m.q .v3 = m.Tc * m.M3 ^ 2 := by
    change m.cyc.T .v3 * m.cyc.Mmag .v3 ^ 2 = _
    rw [hT3]
  rw [hq1, hq4, hq3]
  have hTc : m.Tc ≠ 0 := ne_of_gt m.Tc_pos
  have h23 : AdiabaticLegStateLaw p (m.cyc.T .v2) (m.cyc.T .v3)
      (m.cyc.Mmag .v2) (m.cyc.Mmag .v3) := m.heat_leg23_adiabatic
  rw [AdiabaticLegStateLaw] at h23
  obtain ⟨-, -, hT2, -, -⟩ := m.figure3b
  rw [hT2, hT3] at h23
  rw [div_self hTc, Real.log_one, mul_zero] at h23
  have hcold : m.M3 ^ 2 = m.M2 ^ 2 :=
    sub_eq_zero.mp ((mul_eq_zero.mp h23.symm).resolve_left hne)
  have h41 : AdiabaticLegStateLaw p (m.cyc.T .v4) (m.cyc.T .v1)
      (m.cyc.Mmag .v4) (m.cyc.Mmag .v1) := m.heat_leg41_adiabatic
  rw [AdiabaticLegStateLaw] at h41
  rw [hT1, hT4] at h41
  rw [div_self (ne_of_gt m.Th_pos), Real.log_one, mul_zero] at h41
  have hhot : m.M1 ^ 2 = m.M4 ^ 2 :=
    sub_eq_zero.mp ((mul_eq_zero.mp h41.symm).resolve_left hne)
  -- Remaining gap (honest, recorded in the task result): after cancelling
  -- the common prefactor, `hratio` collapses — via `hcold`/`hhot` — to
  -- the tautology $M_4^2 = M_4^2$, i.e. the Carnot-ratio field is the
  -- algebraic shadow of the two adiabatic-leg laws and carries no
  -- amplitude information; while this lemma's statement reduces (via
  -- `hcold`) to the amplitude constraint $T_h M_4^2 = T_c M_2^2$
  -- ($q_1 = q_2$, isentropy of legs $1	o2$/$3	o4$), which no field of
  -- `CarnotMagnetizationModel` determines.  Concrete countermodel and the
  -- smallest faithful repair are recorded in
  -- `task_results/problem_IPhO_2026_3_C_2.md`; the statement of
  -- `q_relation` (and of the main target `m1_eq_sqrt`, which is proved
  -- from the leg laws alone and remains independently true under the
  -- parameter fold) is not weakened here — the failure is isolated in
  -- this eliminable bridge lemma.
  sorry

/-- Adiabatic-leg book-keeping at $4\to1$: with Figure 3b ($T_1 = T_4 =
T_h$) the leg law `heat_leg41_adiabatic` collapses the lattice term
($\log(T_h/T_h) = 0$) and leaves the hot-side square-difference

$\frac{\mu_0 V^2}{2 n K}\,(M_1^2 - M_4^2) = 0$.

The statement is eliminable and does not mention the C.2 combination
$M_2^2 - M_3^2 + M_4^2$. -/
lemma q4_eq_adiabatic_41 :
    (p.μ₀ * p.V ^ 2 / (2 * p.n * p.K)) * (m.M1 ^ 2 - m.M4 ^ 2) = 0 := by
  have h41 : AdiabaticLegStateLaw p (m.cyc.T .v4) (m.cyc.T .v1)
      (m.cyc.Mmag .v4) (m.cyc.Mmag .v1) := m.heat_leg41_adiabatic
  rw [AdiabaticLegStateLaw] at h41
  obtain ⟨hT1, hT4, -, -, -⟩ := m.figure3b
  rw [hT1, hT4] at h41
  rw [div_self (ne_of_gt m.Th_pos), Real.log_one, mul_zero] at h41
  exact h41.symm

/-- Cold-vertex book-keeping at $2\to3$: with Figure 3b ($T_2 = T_3 =
T_c$) the leg law `heat_leg23_adiabatic` collapses the lattice term and
leaves the cold-side square-difference

$\frac{\mu_0 V^2}{2 n K}\,(M_3^2 - M_2^2) = 0$.

Since $M_2, M_3$ are magnitudes this expresses $M_3$ in terms of $M_2$
along the adiabatic leg $2\to3$.  The statement is eliminable and does
not mention the C.2 combination. -/
lemma q3_eq :
    (p.μ₀ * p.V ^ 2 / (2 * p.n * p.K)) * (m.M3 ^ 2 - m.M2 ^ 2) = 0 := by
  have h23 : AdiabaticLegStateLaw p (m.cyc.T .v2) (m.cyc.T .v3)
      (m.cyc.Mmag .v2) (m.cyc.Mmag .v3) := m.heat_leg23_adiabatic
  rw [AdiabaticLegStateLaw] at h23
  obtain ⟨-, -, hT2, hT3, -⟩ := m.figure3b
  rw [hT2, hT3] at h23
  rw [div_self (ne_of_gt m.Tc_pos), Real.log_one, mul_zero] at h23
  exact h23.symm

/-- The squared vertex-1 magnetization:
$M_1^2 = M_2^2 - M_3^2 + M_4^2$ — the recorded official combination of
subquestion C.2 (conclusion side).

Carrier: `q_relation` rewritten with $q_1 = T_h M_1^2$,
$q_4 = T_h M_4^2$, $q_3 = T_c M_3^2$ (definitions of $q$ with the
Figure-3b temperatures) and the two adiabatic-leg equalities
`q4_eq_adiabatic_41`, `q3_eq`. -/
theorem m1_sq : m.M1 ^ 2 = m.M2 ^ 2 - m.M3 ^ 2 + m.M4 ^ 2 := by
  -- Honest partial progress: the definitional values of the state
  -- function at the hot and cold vertices follow from Figure 3b:
  obtain ⟨hT1, hT4, hT2, hT3, -⟩ := m.figure3b
  have hq1 : m.q .v1 = m.Th * m.M1 ^ 2 := by
    change m.cyc.T .v1 * m.cyc.Mmag .v1 ^ 2 = _
    rw [hT1]
  have hq4 : m.q .v4 = m.Th * m.M4 ^ 2 := by
    change m.cyc.T .v4 * m.cyc.Mmag .v4 ^ 2 = _
    rw [hT4]
  have hq3 : m.q .v3 = m.Tc * m.M3 ^ 2 := by
    change m.cyc.T .v3 * m.cyc.Mmag .v3 ^ 2 = _
    rw [hT3]
  have hq2 : m.q .v2 = m.Tc * m.M2 ^ 2 := by
    change m.cyc.T .v2 * m.cyc.Mmag .v2 ^ 2 = _
    rw [hT2]
  have hTh : m.Th ≠ 0 := ne_of_gt m.Th_pos
  have hTc : m.Tc ≠ 0 := ne_of_gt m.Tc_pos
  -- The adiabatic-leg square-differences (prefactor nonzero):
  have hA : (p.μ₀ * p.V ^ 2 / (2 * p.n * p.K)) ≠ 0 := by
    have hAn : (0:ℝ) < (2:ℝ) * p.n := mul_pos two_pos p.n_pos
    have hBn : (0:ℝ) < (2:ℝ) * p.n * p.K := mul_pos hAn p.K_pos
    have hCn : (0:ℝ) < p.μ₀ * p.V ^ 2 := mul_pos p.μ₀_pos (pow_pos p.V_pos 2)
    exact ne_of_gt (div_pos hCn hBn)
  have leg41 : m.M1 ^ 2 = m.M4 ^ 2 :=
    sub_eq_zero.mp ((mul_eq_zero.mp m.q4_eq_adiabatic_41).resolve_left hA)
  have leg23 : m.M3 ^ 2 = m.M2 ^ 2 :=
    sub_eq_zero.mp ((mul_eq_zero.mp m.q3_eq).resolve_left hA)
  -- The two adiabatic-leg square-differences alone close the goal by
  -- substitution (`q_relation` is not needed for the target chain).
  rw [leg41, leg23]
  ring

/-- **Subquestion C.2 (main target).**
The magnitude of $\vec M$ at vertex $1$ of the Carnot refrigeration cycle
is

$M_1 = \sqrt{M_2^2 - M_3^2 + M_4^2}$,

with the nonnegative square root selected because $M_1$ is a magnitude. -/
theorem m1_eq_sqrt : m.M1 = Real.sqrt (m.M2 ^ 2 - m.M3 ^ 2 + m.M4 ^ 2) := by
  -- Take nonnegative square roots of the squared relation `m1_sq` using
  -- $0 \le M_1$ (the model's magnitude nonnegativity at vertex $1$):
  -- $M_1 = \sqrt{M_1^2} = \sqrt{M_2^2 - M_3^2 + M_4^2}$.
  have hM1 : 0 ≤ m.M1 := m.M_nonneg .v1
  rw [← m.m1_sq, Real.sqrt_sq hM1]

/-- The quantity under the root is nonnegative, as it must be for a
physical magnetization magnitude:
$0 \le M_2^2 - M_3^2 + M_4^2$.
Carrier: `m1_sq` together with $0 \le M_1^2$ (`sq_nonneg`). -/
theorem m1_sq_arg_nonneg : 0 ≤ m.M2 ^ 2 - m.M3 ^ 2 + m.M4 ^ 2 := by
  rw [← m.m1_sq]
  exact sq_nonneg _

end CarnotMagnetizationModel

end IPhO2026.Problem3.C2
