# Deterministic Review Candidate Pack

Iteration: 008
Exact review target count: 1

Review only these targets. Direct Lean compilation was already run in
parallel by the orchestrator; use the recorded result instead of rerunning it.

## 1. `IPhO2026Problems/problem_IPhO_2026_3_C_1.lean`

- Compile status: passed
- Open sorries: 2
- Direct-check seconds: 4.626
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_3_C_1.tex`
- Reports: (none)

### Lean excerpt
```lean
e reservoir ∧
          (cycle.state leg.final).temperature =
            cycle.reservoirTemperature reservoir
  /-- Refrigerator operation fixes the heat direction at either reservoir. -/
  heat_transfer_at_reservoir :
    ∀ (leg : CycleLeg) (reservoir : Reservoir),
      cycle.reservoirContact leg = some reservoir →
        cycle.heatTransfer leg =
          match reservoir with
          | .cold => .absorbedFromCold cycle.heatAbsorbedFromCold
          | .hot => .deliveredToHot cycle.heatDeliveredToHot
  /-- The qualitative transfer record agrees with signed heat into the torus. -/
  signed_heat_agrees_with_transfer : ∀ leg : CycleLeg,
    match cycle.heatTransfer leg with
    | .none => heatInJoules (cycle.signedHeatEntering leg) = 0
    | .absorbedFromCold magnitude =>
        heatInJoules (cycle.signedHeatEntering leg) =
          heatInJoules magnitude
    | .deliveredToHot magnitude =>
        heatInJoules (cycle.signedHeatEntering leg) =
          -heatInJoules magnitude

/-! ## Derived identification requested in C.1 -/

/--
The lower-temperature isothermal leg must contact the cold reservoir, while
the higher-temperature isothermal leg must contact the hot reservoir.
-/
theorem identify_isothermal_reservoir_contacts
    (cycle : Figure3bCarnotCycle)
    (figure : Figure3bGeometry cycle)
    (laws : SatisfiesCarnotRefrigeratorLaws cycle) :
    cycle.reservoirContact .twoToThree = some .cold ∧
      cycle.reservoirContact .fourToOne = some .hot := by
  sorry

/--
**IPhO 2026 Problem 3 C.1.**

States `1` and `4` are at `T_h`, states `2` and `3` are at `T_c`,
`Q_c` is absorbed on `2 → 3`, and `Q_h` is delivered on `4 → 1`.
-/
theorem identify_temperature_labels_and_heat_processes
    (cycle : Figure3bCarnotCycle)
    (figure : Figure3bGeometry cycle)
    (laws : SatisfiesCarnotRefrigeratorLaws cycle)
    (_equationOfState : SatisfiesParamagneticEquationOfState cycle)
    (_isothermalHeatRelation : SatisfiesIsothermalHeatRelation cycle) :
    ((cycle.state .one).temperature = cycle.hotReservoirTemperature ∧
      (cycle.state .four).temperature = cycle.hotReservoirTemperature) ∧
    ((cycle.state .two).temperature = cycle.coldReservoirTemperature ∧
      (cycle.state .three).temperature = cycle.coldReservoirTemperature) ∧
    (cycle.heatTransfer .twoToThree =
      .absorbedFromCold cycle.heatAbsorbedFromCold) ∧
    (cycle.heatTransfer .fourToOne =
      .deliveredToHot cycle.heatDeliveredToHot) ∧
    cycle.heatTransfer .oneToTwo = .none ∧
    cycle.heatTransfer .threeToFour = .none := by
  sorry

end

end ProblemIPhO2026_3_C_1
end IPhO2026Problems
... [leading content omitted]
```

### Blueprint excerpt
```tex
ne.  T\_h and T\_c
are the hot- and cold-reservoir temperatures; Q\_h is the magnitude of heat
delivered to the hot reservoir and Q\_c is the magnitude absorbed from the cold
reservoir.  The equation of state is T*M*V = n*K*H and the isothermal heat
relation from part B may be reused.

Current subquestion:
Label T\_h and T\_c on Figure 3b and identify the processes on which Q\_h and Q\_c are transferred.

\paragraph{Current subquestion.}
Label T\_h and T\_c on Figure 3b and identify the processes on which Q\_h and Q\_c are transferred.

\paragraph{Recorded answer/context.}
States 1 and 4 lie at T\_h; states 2 and 3 lie at T\_c. Q\_c is absorbed on 2->3, and Q\_h is delivered on 4->1.

\paragraph{Figure/image path.}
/root/proposal\_for\_physic/science-mango/ipho\_2026\_source/image/T3\_page-3.png

\paragraph{Formalization target.}
create a compiling Lean file with sorry bodies at `IPhO2026Problems/problem\_IPhO\_2026\_3\_C\_1.lean`.
The Lean declarations must preserve the physical quantities, dimensions or dimensional roles, figure labels, governing-law hypotheses, and final relation expressed by this problem.
Use Mathlib/Physlib names found through LeanExplore where available. If a domain API is missing, introduce faithful local abstractions rather than scalar placeholder aliases.

\begin{theorem}[Physics formalization target]
\label{thm:physics:IPhO_2026_3_C_1:target}
The assigned autoformalize agent should translate this physics problem into Lean declarations in the covered file, with theorem and lemma proof bodies written as `by sorry`.
\end{theorem}
\begin{proof}
This is an autoformalization task, not a proof task. Produce faithful statements that can later be proved without weakening the source contract.
\end{proof}
% --- Archon physics formalization source end ---
... [leading content omitted]
```
