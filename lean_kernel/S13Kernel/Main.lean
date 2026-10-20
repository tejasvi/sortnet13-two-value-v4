import S13Kernel.All
import S13Kernel.Sound
import S13.Reduction
import S13.ZeroOne

/-!
# `S(13) ≥ 44` with a kernel-checked computation

`S13K.main_theorem` proves `Sortnet.MainStatement` (defined in `S13.Defs`): if every sorting network
on 11 channels has at least 35 comparators (Harder's `S(11) ≥ 35`), then every sorting network on 13
channels has at least 44 comparators. The computational step `P(2,13) ≥ 9` is checked by the Lean
kernel (`decide +kernel` in `S13Kernel.Chunks.*`), so the proof uses only the axioms `propext`,
`Classical.choice` and `Quot.sound`.
-/

namespace S13K

open S13K.Data

/-- Key number `0` is the start state. -/
theorem start_ok : startK (getK S 0) = true := by decide +kernel

/-- The start state cannot be brought to a goal with every run meeting at most 8 comparators. -/
theorem not_feasible : ¬ Sortnet.Feasible 8 (Sortnet.f0 13) :=
  not_feasible_of_cover S N (by decide) all_ok start_ok

/-- `P(2,13) ≥ 9`. -/
theorem p2_13 : Sortnet.P2AtLeast 13 9 := Sortnet.p2AtLeast_of_not_feasible not_feasible

/-- **Main theorem.** `S(11) ≥ 35` implies `S(13) ≥ 44`. -/
theorem main_theorem : Sortnet.MainStatement := Sortnet.mainStatement_of_P2 p2_13

/-- The main theorem with sorting networks defined by their action on 0-1 inputs. -/
theorem main_theorem_01 (h11 : ∀ net : Sortnet.Network 11, net.Sorts01 → 35 ≤ net.length) :
    ∀ net : Sortnet.Network 13, net.Sorts01 → 44 ≤ net.length := fun net hs =>
  main_theorem (fun net' hs' => h11 net' ((Sortnet.Network.sorts_iff_sorts01 net').1 hs')) net
    ((Sortnet.Network.sorts_iff_sorts01 net).2 hs)

end S13K
