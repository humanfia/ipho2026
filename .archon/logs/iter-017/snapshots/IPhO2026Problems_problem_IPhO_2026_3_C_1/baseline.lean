import Mathlib

/-!
# IPhO 2026, Problem 3 (Pm-T paramagnetic torus), Subquestion C.1

Carnot refrigeration cycle $1 \to 2 \to 3 \to 4 \to 1$ of the paramagnetic
torus (Pm-T) in the $H$-versus-$T$ plane (Figure 3b).  The task of C.1
(0.2 pts) is to mark $T_h$ and $T_c$ on the $T$ axis of the $H$-vs.-$T$
diagram and to identify the processes on which $Q_h$ (magnitude of the
heat delivered to the hot reservoir) and $Q_c$ (magnitude of the heat
absorbed from the cold reservoir) are transferred.

Official answer (T3 solution + marking scheme C.1: "correctly label
temperatures on graph" 0.1, "specify heat flow portions in diagram" 0.1):

* $T_c = T_2 = T_3$ and $T_h = T_4 = T_1$ — "the respective temperatures
  of the isothermal processes $2 \to 3$ and $4 \to 1$" (official solution
  text);
* $Q_c = |Q_{2\to3}| = Q_{2\to3}$ — heat is *absorbed* from the cold
  reservoir on the isothermal leg $2 \to 3$;
* $Q_h = |Q_{4\to1}| = -Q_{4\to1}$ — heat is *delivered* to the hot
  reservoir on the isothermal leg $4 \to 1$.

## Figure 3b geometry (official source page `T3_page-3.png`)

$H$ is plotted vertically against $T$ horizontally.  Vertices $2$ and $3$
share the left $T$-coordinate (leg $2\to3$ is vertical, hence isothermal);
vertices $1$ and $4$ share the right $T$-coordinate (leg $4\to1$ is
vertical, hence isothermal).  Legs $1\to2$ and $3\to4$ are the two curved
adiabats of the Carnot cycle.  The field magnitude decreases along
$1\to2$ and along $2\to3$ and increases along $3\to4$ and along $4\to1$;
on the $T$ axis the pair $\{2,3\}$ sits to the left of the pair $\{1,4\}$.

## Physical model extracted from the chapter

* Named quantities (dimensional roles; measured magnitudes are real
  scalars):
  - `Th`, `Tc`: hot- and cold-reservoir temperatures (kelvin), $T_c<T_h$.
  - `Qh`, `Qc`: *magnitudes* of the heat delivered to the hot reservoir
    and absorbed from the cold reservoir (joule).
  - `Q12`, `Q23`, `Q34`, `Q41`: *signed* heats transferred into the torus
    along the four legs (joule; into-the-torus positive).
  - `T v`, `Hmag v`, `Mmag v`: scalar readouts of temperature, applied
    field magnitude and magnetization magnitude at vertex $v$.
  - `n`: amount of paramagnetic ions (mol); `K`: material constant of the
    equation of state; `V`: fixed torus volume (m³); `μ₀`: vacuum
    permeability.
* Governing laws (assumptions, never the C.1 answer):
  - Equation of state of the ideal paramagnet: $T\,M\,V = n\,K\,H$
    (given in the problem context; part of the setup and of the later
    C.2 proof route, not needed for the C.1 signs themselves).
  - Isothermal heat relation of part B.1 (previous-part result): at fixed
    temperature $T$, when the field changes from $H_i$ to $H_f$ the heat
    transferred *into* the torus is
    $Q = -(\mu_0 n K/(2T))(H_f^2 - H_i^2)$ — its *sign* content is what
    selects the heat-flow directions below.
  - Adiabatic legs transfer no heat (definition of adiabatic).
  - Reversible two-reservoir Carnot structure: each isothermal leg
    exchanges heat with one of the two reservoirs at the reservoir's own
    temperature, with the refrigeration orientation (absorb $+Q_c$ from
    the cold reservoir, deliver $Q_h$ to the hot reservoir) — stated as a
    per-leg disjunction that does *not* decide which leg is cold.
* Current target conclusions (conclusion side only):
  $T_1 = T_4 = T_h$, $T_2 = T_3 = T_c$; $Q_c$ is absorbed on $2\to3$
  ($Q_{2\to3} = +Q_c > 0$) and $Q_h$ is delivered on $4\to1$
  ($Q_{4\to1} = -Q_h < 0$); no heat is transferred on the adiabatic legs.

## Derivation route recorded for the proof phase

By the B.1 law on leg $2\to3$ with $H_3 < H_2$ (figure) the heat into the
torus is strictly positive (heat absorbed); by the reservoir-exchange
disjunction the leg can then only be the cold one:
$T_2 = T_3 = T_c$, $Q_{2\to3} = +Q_c$.  Symmetrically, on $4\to1$ the
field increases ($H_4 < H_1$), the B.1 heat is strictly negative (heat
delivered), so the leg is the hot one: $T_4 = T_1 = T_h$,
$Q_{4\to1} = -Q_h$.  An independent cross-check comes from the $T$-axis
readout $T_2 < T_1$ together with $T_c < T_h$.

## Sibling-file conflict (redraft flag for plan/review)

The existing file `problem_IPhO_2026_3_C_2.lean` (and its blueprint
chapter) formalizes Figure 3b with the *opposite* process-kind assignment:
`Figure3bAssignment` declares legs $1\to2$, $3\to4$ isothermal and
$2\to3$, $4\to1$ adiabatic, while its own C.1 prerequisite quote records
the official answer used here.  The official solution ("the isothermal
processes $2\to3$ and $4\to1$", with $T_c=T_2=T_3$, $T_h=T_4=T_1$) and
the Figure-3b page image (vertical legs $2\to3$, $4\to1$) agree with the
present file, so `3_C_2`'s figure assignment (and its per-leg heat /
adiabatic-law fields, which attach to the swapped legs) should be
redrafted against this C.1 contract.  Files do not import each other
(previous parts are natural-language prerequisites only), so there is no
compile-time dependency.
-/

namespace IPhO2026.Problem3.C1

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
  /-- Kind of the process $2 \to 3$ (isothermal, $H$ decreasing). -/
  proc23 : ProcessKind
  /-- Kind of the process $3 \to 4$ (adiabatic, $H$ increasing). -/
  proc34 : ProcessKind
  /-- Kind of the process $4 \to 1$ (isothermal, $H$ increasing). -/
  proc41 : ProcessKind

/-- Physical parameters of the paramagnetic torus (Pm-T) and its material
relevant to subquestion C.1.  (The constant-volume heat capacity $C_v$
carried by the sibling C.2 file is not part of the C.1 setup: the C.1
derivation uses only the *sign* of the B.1 isothermal heat law and the
zero-heat property of the adiabatic legs.) -/
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
A *governing law* assumed about the model, not a local definition: it
relates the three vertex readouts at every state of the cycle. -/
def EquationOfStateParamagnet (p : TorusParams) (T H M : ℝ) : Prop :=
  T * M * p.V = p.n * p.K * H

/-- Isothermal heat relation from part B.1 (governing law / previous-part
result, assumed — not proved — here): when $H$ changes from $H_i$ to $H_f$
at constant temperature $T$, the heat transferred *into* the torus is

$Q = -\frac{\mu_0\,n\,K}{2T}\,(H_f^2 - H_i^2)$.

The heat argument is signed (into the torus positive), so the direction of
the transfer (in vs. out) is carried by the sign: heat is absorbed when
the field decreases and released when it increases.  This sign content is
the physical input that identifies the heat-flow directions of C.1. -/
def IsothermalHeatIntoTorus (p : TorusParams) (T Hi Hf Q : ℝ) : Prop :=
  Q = -(p.μ₀ * p.n * p.K / (2 * T)) * (Hf ^ 2 - Hi ^ 2)

/-- Reversible two-reservoir heat exchange on an isothermal leg of the
Carnot refrigeration cycle (governing law of the model): a leg at
temperature `Tleg` along which the heat `Qleg` flows into the torus
exchanges heat with one of the two reservoirs *at the reservoir's own
temperature* (reversibility of the Carnot cycle), and the refrigeration
orientation fixes the sign — the torus *absorbs* $+Q_c$ from the cold
reservoir on a leg at $T_c$, or *delivers* $Q_h$ to the hot reservoir on a
leg at $T_h$ (heat into the torus $-Q_h$).

The disjunction is the law; it is stated for *any* isothermal leg and does
not assert which leg of Figure 3b sits at which reservoir temperature —
that identification is the content of subquestion C.1. -/
def ReservoirExchange (Tc Th Qc Qh Tleg Qleg : ℝ) : Prop :=
  (Tleg = Tc ∧ Qleg = Qc) ∨ (Tleg = Th ∧ Qleg = -Qh)

/-- The model hypotheses for subquestion C.1: reservoir data, the heats
along the four legs, the Figure-3b readouts, and the physical laws the
cycle obeys.  The C.1 answers ($T_1=T_4=T_h$, $T_2=T_3=T_c$; $Q_c$
absorbed on $2\to3$, $Q_h$ delivered on $4\to1$) do *not* occur among
these fields: the reservoir-exchange law enters only as an unresolved
per-leg disjunction, and the figure readouts record only axis geometry
(shared/ordered coordinates) and field directions, never the reservoir
identification itself. -/
structure CarnotRefrigeratorModel (p : TorusParams) where
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
  /-- Signed heat into the torus along leg $1\to2$ (J). -/
  Q12 : ℝ
  /-- Signed heat into the torus along leg $2\to3$ (J). -/
  Q23 : ℝ
  /-- Signed heat into the torus along leg $3\to4$ (J). -/
  Q34 : ℝ
  /-- Signed heat into the torus along leg $4\to1$ (J). -/
  Q41 : ℝ
  Th_pos : 0 < Th
  Tc_pos : 0 < Tc
  /-- Cold reservoir colder than hot reservoir (orientation datum of the
  refrigeration cycle). -/
  Tc_lt_Th : Tc < Th
  Qh_nonneg : 0 ≤ Qh
  Qc_nonneg : 0 ≤ Qc
  /-- Figure-3b readout: leg $1\to2$ is an adiabat with the field
  decreasing. -/
  proc12_fig : cyc.proc12 = .adiabatic true
  /-- Figure-3b readout: leg $2\to3$ is vertical in the $H$-$T$ plane,
  hence isothermal, with the field decreasing. -/
  proc23_fig : cyc.proc23 = .isothermal true
  /-- Figure-3b readout: leg $3\to4$ is an adiabat with the field
  increasing. -/
  proc34_fig : cyc.proc34 = .adiabatic false
  /-- Figure-3b readout: leg $4\to1$ is vertical in the $H$-$T$ plane,
  hence isothermal, with the field increasing. -/
  proc41_fig : cyc.proc41 = .isothermal false
  /-- Figure-3b readout: vertices $2$ and $3$ share one $T$-coordinate
  (the vertical leg $2\to3$). -/
  T2_eq_T3 : cyc.T .v2 = cyc.T .v3
  /-- Figure-3b readout: vertices $1$ and $4$ share one $T$-coordinate
  (the vertical leg $4\to1$). -/
  T1_eq_T4 : cyc.T .v1 = cyc.T .v4
  /-- Figure-3b readout: the pair $\{2,3\}$ sits to the *left* of the
  pair $\{1,4\}$ on the $T$ axis. -/
  T23_lt_T14 : cyc.T .v2 < cyc.T .v1
  /-- Figure-3b readout: the field decreases along leg $1\to2$. -/
  H2_lt_H1 : cyc.Hmag .v2 < cyc.Hmag .v1
  /-- Figure-3b readout: the field decreases along leg $2\to3$. -/
  H3_lt_H2 : cyc.Hmag .v3 < cyc.Hmag .v2
  /-- Figure-3b readout: the field increases along leg $3\to4$. -/
  H3_lt_H4 : cyc.Hmag .v3 < cyc.Hmag .v4
  /-- Figure-3b readout: the field increases along leg $4\to1$. -/
  H4_lt_H1 : cyc.Hmag .v4 < cyc.Hmag .v1
  /-- Temperatures are positive at every vertex (kelvin scale). -/
  T_pos : ∀ v, 0 < cyc.T v
  /-- Field and magnetization magnitudes are nonnegative at the
  vertices. -/
  H_nonneg : ∀ v, 0 ≤ cyc.Hmag v
  M_nonneg : ∀ v, 0 ≤ cyc.Mmag v
  /-- Equation of state $TMV = nKH$ at each vertex of the cycle. -/
  eos : ∀ v, EquationOfStateParamagnet p (cyc.T v) (cyc.Hmag v) (cyc.Mmag v)
  /-- B.1 isothermal heat law on leg $2\to3$ (at the leg temperature
  $T_2 = T_3$). -/
  heat23 : IsothermalHeatIntoTorus p (cyc.T .v2) (cyc.Hmag .v2) (cyc.Hmag .v3) Q23
  /-- B.1 isothermal heat law on leg $4\to1$ (at the leg temperature
  $T_4 = T_1$). -/
  heat41 : IsothermalHeatIntoTorus p (cyc.T .v4) (cyc.Hmag .v4) (cyc.Hmag .v1) Q41
  /-- The adiabatic leg $1\to2$ transfers no heat. -/
  heat12_zero : Q12 = 0
  /-- The adiabatic leg $3\to4$ transfers no heat. -/
  heat34_zero : Q34 = 0
  /-- Carnot reservoir exchange on the isothermal leg $2\to3$: the leg
  sits at one of the two reservoir temperatures with the correspondingly
  signed reservoir heat — the law does not decide which. -/
  leg23_exchange : ReservoirExchange Tc Th Qc Qh (cyc.T .v2) Q23
  /-- Carnot reservoir exchange on the isothermal leg $4\to1$: same law,
  other leg. -/
  leg41_exchange : ReservoirExchange Tc Th Qc Qh (cyc.T .v4) Q41

namespace CarnotRefrigeratorModel

variable {p : TorusParams} (m : CarnotRefrigeratorModel p)

/-- Sign bridge on leg $2\to3$: the heat into the torus is strictly
positive — heat is *absorbed* along $2\to3$.

Carrier: `heat23` (the B.1 law) unfolded; the prefactor
$\mu_0 n K/(2T_2)$ is positive by `p.μ₀_pos`, `p.n_pos`, `p.K_pos` and
`m.T_pos .v2`, and $H_3^2 - H_2^2 < 0$ follows from `m.H3_lt_H2` with
`m.H_nonneg` (square comparison `sq_lt_sq₀`), so the negated product is
positive. -/
lemma Q23_pos : 0 < m.Q23 := by
  sorry

/-- Sign bridge on leg $4\to1$: the heat into the torus is strictly
negative — heat is *delivered* along $4\to1$.

Carrier: `heat41` (the B.1 law) unfolded; the prefactor
$\mu_0 n K/(2T_4)$ is positive and $H_1^2 - H_4^2 > 0$ follows from
`m.H4_lt_H1` with `m.H_nonneg`, so the negated product is negative. -/
lemma Q41_neg : m.Q41 < 0 := by
  sorry

/-- Cold-leg identification: the isothermal leg $2\to3$ sits at the cold
reservoir temperature and carries the heat absorbed from it,
$T_2 = T_c$ and $Q_{2\to3} = +Q_c$.

Carrier: the disjunction `leg23_exchange`; its hot alternative would give
$Q_{2\to3} = -Q_h \le 0$ (by `Qh_nonneg`), contradicting `Q23_pos`. -/
theorem leg23_cold : m.cyc.T .v2 = m.Tc ∧ m.Q23 = m.Qc := by
  sorry

/-- Hot-leg identification: the isothermal leg $4\to1$ sits at the hot
reservoir temperature and carries the heat delivered to it,
$T_4 = T_h$ and $Q_{4\to1} = -Q_h$.

Carrier: the disjunction `leg41_exchange`; its cold alternative would give
$Q_{4\to1} = Q_c \ge 0$ (by `Qc_nonneg`), contradicting `Q41_neg`. -/
theorem leg41_hot : m.cyc.T .v4 = m.Th ∧ m.Q41 = -m.Qh := by
  sorry

/-- **Subquestion C.1 (main target, temperature labels).**
States $1$ and $4$ lie at the hot-reservoir temperature and states $2$
and $3$ at the cold-reservoir temperature:

$T_1 = T_4 = T_h$, $\qquad T_2 = T_3 = T_c$.

Carrier: `leg23_cold.1` for $T_2 = T_c$, extended to $T_3$ by the figure
readout `T2_eq_T3`; `leg41_hot.1` for $T_4 = T_h$, extended to $T_1$ by
`T1_eq_T4`.  (Independent cross-check, not needed for the proof: the
$T$-axis readout `T23_lt_T14` with `Tc_lt_Th` excludes the swapped
labeling directly.) -/
theorem temperature_labels :
    m.cyc.T .v1 = m.Th ∧ m.cyc.T .v4 = m.Th ∧
    m.cyc.T .v2 = m.Tc ∧ m.cyc.T .v3 = m.Tc := by
  sorry

/-- **Subquestion C.1 (main target, cold-side heat).**
$Q_c$ is absorbed from the cold reservoir on process $2\to3$: the heat
into the torus along $2\to3$ equals $+Q_c$ and is strictly positive
($Q_c = |Q_{2\to3}| = Q_{2\to3}$ in the official notation).

Carrier: `leg23_cold.2` and `Q23_pos`. -/
theorem Qc_absorbed_on_23 : m.Q23 = m.Qc ∧ 0 < m.Q23 := by
  sorry

/-- **Subquestion C.1 (main target, hot-side heat).**
$Q_h$ is delivered to the hot reservoir on process $4\to1$: the heat into
the torus along $4\to1$ equals $-Q_h$ and is strictly negative
($Q_h = |Q_{4\to1}| = -Q_{4\to1}$ in the official notation).

Carrier: `leg41_hot.2` and `Q41_neg`. -/
theorem Qh_delivered_on_41 : m.Q41 = -m.Qh ∧ m.Q41 < 0 := by
  sorry

/-- The adiabatic legs transfer no heat, so $Q_h$ and $Q_c$ are exchanged
on the isothermal legs $2\to3$ and $4\to1$ only.

Carrier: the model fields `heat12_zero`, `heat34_zero` (the definition of
an adiabatic process). -/
theorem adiabatic_legs_transfer_no_heat : m.Q12 = 0 ∧ m.Q34 = 0 := by
  sorry

/-- Magnitude form of the official answer: the reservoir heat magnitudes
are the absolute values of the signed leg heats,
$|Q_{2\to3}| = Q_c$ and $|Q_{4\to1}| = Q_h$.

Carrier: `Qc_absorbed_on_23` / `Qh_delivered_on_41` with
`abs_of_nonneg` / `abs_of_neg`. -/
theorem reservoir_heat_magnitudes : |m.Q23| = m.Qc ∧ |m.Q41| = m.Qh := by
  sorry

/-- **Subquestion C.1 (combined target).**
The Figure-3b labeling in one statement: states $1,4$ lie at $T_h$,
states $2,3$ lie at $T_c$; $Q_c$ is absorbed on $2\to3$ and $Q_h$ is
delivered on $4\to1$ (the heats into the torus being $+Q_c > 0$ and
$-Q_h < 0$ respectively), with no heat transferred on the adiabatic legs
$1\to2$, $3\to4$.

Carrier: `temperature_labels`, `Qc_absorbed_on_23`, `Qh_delivered_on_41`,
`adiabatic_legs_transfer_no_heat`. -/
theorem figure3b_labeling :
    (m.cyc.T .v1 = m.Th ∧ m.cyc.T .v4 = m.Th ∧
      m.cyc.T .v2 = m.Tc ∧ m.cyc.T .v3 = m.Tc) ∧
    (m.Q23 = m.Qc ∧ 0 < m.Q23) ∧
    (m.Q41 = -m.Qh ∧ m.Q41 < 0) ∧
    (m.Q12 = 0 ∧ m.Q34 = 0) := by
  sorry

end CarnotRefrigeratorModel

end IPhO2026.Problem3.C1
