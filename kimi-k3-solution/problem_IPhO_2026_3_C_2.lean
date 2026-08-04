import Mathlib

/-!
# IPhO 2026, Problem 3 (Pm-T paramagnetic torus), Subquestion C.2

Carnot refrigeration cycle $1 \to 2 \to 3 \to 4 \to 1$ of the paramagnetic
torus (Pm-T) in the $H$-versus-$T$ plane (Figure 3b).  The task of C.2
(1.5 pts) is to express $M_1$ in terms of $M_2$, $M_3$, and $M_4$:

$M_1 = \sqrt{M_2^2 - M_3^2 + M_4^2}$, $\qquad M_1 \ge 0$.

## Official physics (T3 problem, solution and marking scheme)

Figure 3b plots $H$ vertically against $T$ horizontally.  The cycle data
(carried over from part C.1 as a natural-language prerequisite, and used
verbatim by the official C.2 solution) are:

* $T_c = T_2 = T_3$ and $T_h = T_4 = T_1$ — "the respective temperatures of
  the isothermal processes $2 \to 3$ and $4 \to 1$" (official solution);
* legs $1 \to 2$ and $3 \to 4$ are **adiabatic** (no heat transferred);
* leg $2 \to 3$ is **isothermal at $T_c$** with the field decreasing: the
  torus *absorbs* heat from the cold reservoir,
  $Q_c = |Q_{2\to3}| = Q_{2\to3}$ (heat into the torus is $+Q_c$);
* leg $4 \to 1$ is **isothermal at $T_h$** with the field increasing: the
  torus *delivers* heat to the hot reservoir,
  $Q_h = |Q_{4\to1}| = -Q_{4\to1}$ (heat into the torus is $-Q_h$).

Official derivation of C.2 (solution text): the B.1 isothermal heat law
$Q = -(\mu_0 n K/(2T))(H_f^2 - H_i^2)$ applied to the two isothermal legs
gives

$Q_c = \mu_0\,\dfrac{nK}{T_c}\,\dfrac{H_2^2 - H_3^2}{2}$, $\qquad$
$Q_h = \mu_0\,\dfrac{nK}{T_h}\,\dfrac{H_1^2 - H_4^2}{2}$;

substitution into the Carnot identity $Q_c/Q_h = T_c/T_h$ yields
$(H_2^2-H_3^2)/T_c^2 = (H_1^2-H_4^2)/T_h^2$, and the equation of state
$M = nKH/(TV)$ turns this into $M_2^2 - M_3^2 = M_1^2 - M_4^2$, hence

$M_1 = \sqrt{M_2^2 - M_3^2 + M_4^2}$.

The same route with the EOS substitution folded in first (the form used by
the proof below): with $A = \mu_0 V^2/(2nK) > 0$,

$Q_c = A\,T_c\,(M_2^2 - M_3^2)$ on $2\to3$, $\qquad$
$Q_h = A\,T_h\,(M_1^2 - M_4^2)$ on $4\to1$,

and the reversible Carnot magnitude relation $Q_h T_c = Q_c T_h$ collapses
to $M_2^2 - M_3^2 = M_1^2 - M_4^2$.

## Model content

* Named quantities (real scalars; dimensional roles):
  - `Th`, `Tc`: hot- and cold-reservoir temperatures (kelvin), $T_c<T_h$.
  - `Qh`, `Qc`: *magnitudes* of the heat delivered to the hot reservoir
    and absorbed from the cold reservoir (joule).
  - `Q12`, `Q34`: *signed* heats into the torus along the adiabatic legs
    $1\to2$, $3\to4$ (joule; zero by definition of adiabatic).
  - `M1`, `M2`, `M3`, `M4`: magnitudes of $\vec M$ at the four vertices
    (ampere/metre); `Hmag v`: applied-field magnitude at vertex $v$.
  - `n` (mol), `K` (material constant of the EOS), `V` (torus volume, m³),
    `μ₀` (vacuum permeability).
* Governing laws (assumptions; the C.2 answer never appears among them):
  - Equation of state of the ideal paramagnet: $T\,M\,V = n\,K\,H$ at
    every vertex.
  - Isothermal heat relation of part B.1 (previous-part result) on the
    isothermal legs $2\to3$ (heat $+Q_c$ into the torus) and $4\to1$
    (heat $-Q_h$ into the torus).
  - Adiabatic legs $1\to2$, $3\to4$ transfer no heat.
  - Reversible Carnot heat ratio $Q_h\,T_c = Q_c\,T_h$ for the heat
    magnitudes.
* Conclusion side only: $M_1^2 = M_2^2 - M_3^2 + M_4^2$ and
  $M_1 = \sqrt{M_2^2 - M_3^2 + M_4^2}$ (nonnegative root, since $M_1$ is
  a magnitude).

## Redraft note (process-kind swap corrected)

The previous version of this file had the Figure-3b process kinds
*swapped*: it declared legs $1\to2$, $3\to4$ isothermal and $2\to3$,
$4\to1$ adiabatic, contradicting the official T3 solution, the Figure-3b
page image (vertical — hence isothermal — legs $2\to3$ and $4\to1$), and
this file's own quoted C.1 prerequisite.  The false assignment made the
"adiabatic" legs connect same-temperature states, which collapsed the
leg laws to $M_1 = M_4$ and $M_2 = M_3$ and left the Carnot-ratio bridge
unprovable.  The present file redrafts the assignment against the official
T3 solution and the proved sibling contract of
`problem_IPhO_2026_3_C_1.lean`: isothermal legs $2\to3$ at $T_c$ and
$4\to1$ at $T_h$, adiabatic legs $1\to2$, $3\to4$.  Under the corrected
assignment the official derivation closes by direct algebra; no
adiabatic-leg state law is needed, so the previous `AdiabaticLegStateLaw`
machinery (and the unused heat-capacity parameter $C_v$) is removed.
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
  /-- Kind of the process $1 \to 2$ (adiabatic, $H$ decreasing). -/
  proc12 : ProcessKind
  /-- Kind of the process $2 \to 3$ (isothermal at $T_c$, $H$
  decreasing). -/
  proc23 : ProcessKind
  /-- Kind of the process $3 \to 4$ (adiabatic, $H$ increasing). -/
  proc34 : ProcessKind
  /-- Kind of the process $4 \to 1$ (isothermal at $T_h$, $H$
  increasing). -/
  proc41 : ProcessKind

/-- Physical parameters of the paramagnetic torus (Pm-T) and its material
relevant to subquestion C.2.  (The constant-volume heat capacity $C_v$
carried by the previous version of this file is not part of the C.2
setup: the official derivation uses only the B.1 isothermal heat law on
the two isothermal legs, the equation of state, and the Carnot heat
ratio — the adiabatic legs enter only through their zero heat transfer.) -/
structure TorusParams where
  /-- Vacuum permeability $\mu_0$. -/
  μ₀ : ℝ
  /-- Amount of paramagnetic ions, $n$ (mol). -/
  n : ℝ
  /-- Material constant $K$ of the equation of state $TMV = nKH$. -/
  K : ℝ
  /-- Fixed volume $V$ of the torus (m³). -/
  V : ℝ
  μ₀_pos : 0 < μ₀
  n_pos : 0 < n
  K_pos : 0 < K
  V_pos : 0 < V

/-- The equation of state of the ideal paramagnet, $T\,M\,V = n\,K\,H$.
A *governing law* assumed about the model, not a local definition: its
consequence used downstream is $H = T M V / (n K)$, substituted into the
B.1 isothermal heat law on the isothermal legs of the cycle. -/
def EquationOfStateParamagnet (p : TorusParams) (T H M : ℝ) : Prop :=
  T * M * p.V = p.n * p.K * H

/-- Isothermal heat relation from part B.1 (governing law / previous-part
result, assumed — not proved — here): when $H$ changes from $H_i$ to $H_f$
at constant temperature $T$, the heat transferred *into* the torus is

$Q = -\frac{\mu_0\,n\,K}{2T}\,(H_f^2 - H_i^2)$.

The heat argument is signed (into the torus positive), so the direction of
the transfer (in vs. out) is carried by the sign, not by the final answer. -/
def IsothermalHeatIntoTorus (p : TorusParams) (T Hi Hf Q : ℝ) : Prop :=
  Q = -(p.μ₀ * p.n * p.K / (2 * T)) * (Hf ^ 2 - Hi ^ 2)

/-- **EOS-substituted form of the B.1 law** — the algebra at the heart of
the official C.2 derivation.  Along an isothermal leg at temperature $T$
between two states satisfying the equation of state, the heat into the
torus becomes, with $A = \mu_0 V^2/(2nK)$,

$Q = A\,T\,(M_i^2 - M_f^2)$.

Carrier: `IsothermalHeatIntoTorus` with $H = T M V/(nK)$ substituted at
both endpoints; the prefactor identity is
$\frac{\mu_0 n K}{2T}\left(\frac{TV}{nK}\right)^2 =
\frac{\mu_0 V^2}{2nK}\,T$.  The statement mentions neither the vertex data
of the cycle nor the C.2 answer. -/
lemma IsothermalHeatIntoTorus.magnetization_form {p : TorusParams}
    {T Mi Mf Hi Hf Q : ℝ} (hT : T ≠ 0)
    (heosi : EquationOfStateParamagnet p T Hi Mi)
    (heosf : EquationOfStateParamagnet p T Hf Mf)
    (h : IsothermalHeatIntoTorus p T Hi Hf Q) :
    Q = (p.μ₀ * p.V ^ 2 / (2 * p.n * p.K)) * T * (Mi ^ 2 - Mf ^ 2) := by
  have hn : p.n ≠ 0 := ne_of_gt p.n_pos
  have hK : p.K ≠ 0 := ne_of_gt p.K_pos
  have hnK : p.n * p.K ≠ 0 := mul_ne_zero hn hK
  have heosi' : T * Mi * p.V = p.n * p.K * Hi := heosi
  have heosf' : T * Mf * p.V = p.n * p.K * Hf := heosf
  have hHi : Hi = T * Mi * p.V / (p.n * p.K) := by
    rw [eq_div_iff hnK]
    linear_combination -heosi'
  have hHf : Hf = T * Mf * p.V / (p.n * p.K) := by
    rw [eq_div_iff hnK]
    linear_combination -heosf'
  have hQ : Q = -(p.μ₀ * p.n * p.K / (2 * T)) * (Hf ^ 2 - Hi ^ 2) := h
  rw [hQ, hHi, hHf]
  field_simp [hn, hK, hT]
  ring

/-- Carnot heat ratio for the reversible refrigeration cycle (second law
applied along the cycle: the entropy changes on the two isothermal legs
sum to zero and the adiabatic legs transfer no heat).  $Q_h, Q_c$ here
are the *magnitudes* of the heats exchanged with the reservoirs, so the
relation carries no sign. -/
def CarnotHeatRatio (Th Tc Qh Qc : ℝ) : Prop :=
  Qh * Tc = Qc * Th

/-- The Figure-3b reading (part C.1 conclusion, natural-language
prerequisite; agrees with the official T3 solution and with the page
image, where the legs $2\to3$ and $4\to1$ are vertical in the $H$-$T$
plane): states $1,4$ lie at $T_h$, states $2,3$ lie at $T_c$; the legs
$1\to2$ (field decreasing) and $3\to4$ (field increasing) are adiabatic,
and the legs $2\to3$ (at $T_c$, field decreasing) and $4\to1$ (at $T_h$,
field increasing) are isothermal. -/
def Figure3bAssignment (cyc : CarnotCycle) (Th Tc : ℝ) : Prop :=
  cyc.T .v1 = Th ∧ cyc.T .v4 = Th ∧ cyc.T .v2 = Tc ∧ cyc.T .v3 = Tc ∧
  cyc.proc12 = .adiabatic true ∧ cyc.proc23 = .isothermal true ∧
  cyc.proc34 = .adiabatic false ∧ cyc.proc41 = .isothermal false

/-- The model hypotheses for subquestion C.2: reservoir data, reservoir
heat magnitudes, figure data, and the physical laws the cycle obeys.  The
C.2 answer ($M_1 = \sqrt{M_2^2 - M_3^2 + M_4^2}$) does *not* occur among
these fields: it stays on the conclusion side of `m1_eq_sqrt`.  The B.1
isothermal law is attached to the two isothermal legs at the temperatures
assigned by Figure 3b — leg $2\to3$ isothermal at $T_c$ with heat $+Q_c$
into the torus (heat absorbed from the cold reservoir), leg $4\to1$
isothermal at $T_h$ with heat $-Q_h$ into the torus (heat delivered to
the hot reservoir) — and the adiabatic legs $1\to2$, $3\to4$ transfer no
heat. -/
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
  /-- Signed heat into the torus along the adiabatic leg $1\to2$ (J). -/
  Q12 : ℝ
  /-- Signed heat into the torus along the adiabatic leg $3\to4$ (J). -/
  Q34 : ℝ
  Th_pos : 0 < Th
  Tc_pos : 0 < Tc
  /-- Cold reservoir colder than hot reservoir (orientation datum of the
  refrigeration cycle). -/
  Tc_lt_Th : Tc < Th
  Qh_nonneg : 0 ≤ Qh
  Qc_nonneg : 0 ≤ Qc
  /-- Figure-3b reading: which vertex sits at which temperature, and which
  process is which. -/
  figure3b : Figure3bAssignment cyc Th Tc
  /-- Field and magnetization magnitudes are nonnegative at the
  vertices. -/
  H_nonneg : ∀ v, 0 ≤ cyc.Hmag v
  M_nonneg : ∀ v, 0 ≤ cyc.Mmag v
  /-- Equation of state $TMV = nKH$ at each vertex of the cycle. -/
  eos : ∀ v, EquationOfStateParamagnet p (cyc.T v) (cyc.Hmag v) (cyc.Mmag v)
  /-- B.1 isothermal heat law on leg $2 \to 3$ (isothermal at
  $T_c = T_2 = T_3$; the heat into the torus is $+Q_c$, absorbed from the
  cold reservoir). -/
  heat_23 : IsothermalHeatIntoTorus p Tc (cyc.Hmag .v2) (cyc.Hmag .v3) Qc
  /-- B.1 isothermal heat law on leg $4 \to 1$ (isothermal at
  $T_h = T_4 = T_1$; the heat into the torus is $-Q_h$, the negative of
  the magnitude delivered to the hot reservoir). -/
  heat_41 : IsothermalHeatIntoTorus p Th (cyc.Hmag .v4) (cyc.Hmag .v1) (-Qh)
  /-- The adiabatic leg $1 \to 2$ transfers no heat. -/
  heat_12_zero : Q12 = 0
  /-- The adiabatic leg $3 \to 4$ transfers no heat. -/
  heat_34_zero : Q34 = 0
  /-- Carnot heat ratio $Q_h T_c = Q_c T_h$ (reversible cycle). -/
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

/-- Vertex temperatures are positive (from $T_h, T_c > 0$ and Figure 3b). -/
lemma vertex_T_pos (v : Vertex) : 0 < m.cyc.T v := by
  obtain ⟨hT1, hT4, hT2, hT3, -⟩ := m.figure3b
  cases v
  · simp only [hT1]; exact m.Th_pos
  · simp only [hT2]; exact m.Tc_pos
  · simp only [hT3]; exact m.Tc_pos
  · simp only [hT4]; exact m.Th_pos

/-- Cold-leg heat in magnetization form (official C.2 route): on the
isothermal leg $2 \to 3$ at $T_c$, the B.1 law with the equation of state
substituted gives, with $A = \mu_0 V^2/(2nK)$,

$Q_c = A\,T_c\,(M_2^2 - M_3^2)$.

Carrier: `heat_23` via `IsothermalHeatIntoTorus.magnetization_form`, with
the Figure-3b temperatures $T_2 = T_3 = T_c$ rewriting the equation of
state at the two endpoints. -/
lemma Qc_eq : m.Qc = (p.μ₀ * p.V ^ 2 / (2 * p.n * p.K)) * m.Tc *
    (m.M2 ^ 2 - m.M3 ^ 2) := by
  obtain ⟨-, -, hT2, hT3, -⟩ := m.figure3b
  have heos2 : EquationOfStateParamagnet p m.Tc (m.cyc.Hmag .v2) (m.cyc.Mmag .v2) := by
    have h := m.eos .v2
    rw [hT2] at h
    exact h
  have heos3 : EquationOfStateParamagnet p m.Tc (m.cyc.Hmag .v3) (m.cyc.Mmag .v3) := by
    have h := m.eos .v3
    rw [hT3] at h
    exact h
  exact IsothermalHeatIntoTorus.magnetization_form (ne_of_gt m.Tc_pos) heos2 heos3 m.heat_23

/-- Hot-leg heat in magnetization form (official C.2 route): on the
isothermal leg $4 \to 1$ at $T_h$, the B.1 law with the equation of state
substituted gives, with $A = \mu_0 V^2/(2nK)$,

$Q_h = A\,T_h\,(M_1^2 - M_4^2)$

(equivalently the heat into the torus is $-Q_h = A\,T_h\,(M_4^2-M_1^2)$).

Carrier: `heat_41` via `IsothermalHeatIntoTorus.magnetization_form`, with
the Figure-3b temperatures $T_4 = T_1 = T_h$ rewriting the equation of
state at the two endpoints. -/
lemma Qh_eq : m.Qh = (p.μ₀ * p.V ^ 2 / (2 * p.n * p.K)) * m.Th *
    (m.M1 ^ 2 - m.M4 ^ 2) := by
  obtain ⟨hT1, hT4, -⟩ := m.figure3b
  have heos4 : EquationOfStateParamagnet p m.Th (m.cyc.Hmag .v4) (m.cyc.Mmag .v4) := by
    have h := m.eos .v4
    rw [hT4] at h
    exact h
  have heos1 : EquationOfStateParamagnet p m.Th (m.cyc.Hmag .v1) (m.cyc.Mmag .v1) := by
    have h := m.eos .v1
    rw [hT1] at h
    exact h
  have h := IsothermalHeatIntoTorus.magnetization_form (ne_of_gt m.Th_pos) heos4 heos1 m.heat_41
  linear_combination -h

/-- The square-difference identity at the heart of the official C.2
solution: $M_2^2 - M_3^2 = M_1^2 - M_4^2$.

Carrier: the Carnot heat ratio `carnot_ratio` with the two leg identities
`Qh_eq`, `Qc_eq` substituted; the common positive factor
$A\,T_h\,T_c$ (with $A = \mu_0 V^2/(2nK)$) cancels. -/
theorem sq_diff_eq : m.M2 ^ 2 - m.M3 ^ 2 = m.M1 ^ 2 - m.M4 ^ 2 := by
  have hratio : m.Qh * m.Tc = m.Qc * m.Th := m.carnot_ratio
  rw [m.Qh_eq, m.Qc_eq] at hratio
  have hA : (p.μ₀ * p.V ^ 2 / (2 * p.n * p.K)) ≠ 0 := by
    have hAn : (0:ℝ) < (2:ℝ) * p.n := mul_pos two_pos p.n_pos
    have hBn : (0:ℝ) < (2:ℝ) * p.n * p.K := mul_pos hAn p.K_pos
    have hCn : (0:ℝ) < p.μ₀ * p.V ^ 2 := mul_pos p.μ₀_pos (pow_pos p.V_pos 2)
    exact ne_of_gt (div_pos hCn hBn)
  have hTh : m.Th ≠ 0 := ne_of_gt m.Th_pos
  have hTc : m.Tc ≠ 0 := ne_of_gt m.Tc_pos
  have hlin : (p.μ₀ * p.V ^ 2 / (2 * p.n * p.K)) * (m.Th * m.Tc) * (m.M2 ^ 2 - m.M3 ^ 2) =
      (p.μ₀ * p.V ^ 2 / (2 * p.n * p.K)) * (m.Th * m.Tc) * (m.M1 ^ 2 - m.M4 ^ 2) := by
    linear_combination -hratio
  exact mul_left_cancel₀ (mul_ne_zero hA (mul_ne_zero hTh hTc)) hlin

/-- The squared vertex-$1$ magnetization:
$M_1^2 = M_2^2 - M_3^2 + M_4^2$ — the recorded official combination of
subquestion C.2 (conclusion side).

Carrier: `sq_diff_eq` rearranged. -/
theorem m1_sq : m.M1 ^ 2 = m.M2 ^ 2 - m.M3 ^ 2 + m.M4 ^ 2 := by
  have h := m.sq_diff_eq
  linear_combination -h

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
