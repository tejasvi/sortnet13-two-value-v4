import S11Data
import S13.S11.Final
import S13.Main

/-!
# `S(11) ≥ 35` and the unconditional bound `S(13) ≥ 44`

`certOK_harder11` evaluates the check of Harder's certificate with `native_decide`;
`certOK_sound` and `sorts_bound_of_LB` (standard axioms only) turn it into `S(11) ≥ 35` for
`Network.Sorts`, which discharges the hypothesis of `main_theorem`.
-/

namespace Sortnet

open S11 S11Data

/-- The check of Harder's certificate for 11 channels and bound 35, evaluated natively. -/
theorem certOK_harder11 : certOK theCert certCount 2048 11 35 = true := by native_decide

/-- **`S(11) ≥ 35`**: every sorting network on 11 channels has at least 35 comparators. -/
theorem S11_ge_35 : ∀ net : Network 11, net.Sorts → 35 ≤ net.length :=
  sorts_bound_of_LB (certOK_sound certOK_harder11)

/-- **Sorting networks on 13 inputs need at least 44 comparators.** -/
theorem S13_ge_44 : ∀ net : Network 13, net.Sorts → 44 ≤ net.length :=
  main_theorem S11_ge_35

end Sortnet
