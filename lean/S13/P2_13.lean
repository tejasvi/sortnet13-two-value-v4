import S13.Runs

/-!
# `P(2,13) ≥ 9`

`Comp.fullCheck 13 8` searches the f-states reachable through children that pass the Kraft test
(up to relabeling) and checks that the resulting set is closed and contains no goal. It is evaluated
by `native_decide`, which trusts the Lean compiler and the native code of `S13Comp`.
-/

namespace Sortnet

/-- The computation for `n = 13`, `L = 8`, evaluated natively. -/
theorem fullCheck_13_8 : Comp.fullCheck 13 8 = true := by native_decide

/-- **`P(2,13) ≥ 9`**: every top-two correct network on 13 channels has a run `(x, y)` in which the
two largest values meet at least 9 comparators. -/
theorem P2_13 : P2AtLeast 13 9 :=
  p2AtLeast_of_not_feasible (not_feasible_of_fullCheck fullCheck_13_8)

end Sortnet
