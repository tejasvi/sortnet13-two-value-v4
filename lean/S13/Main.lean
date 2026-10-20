import S13.P2_13
import S13.Reduction
import S13.ZeroOne

/-!
# Sorting networks on 13 inputs need at least 44 comparators

`main_theorem` proves `MainStatement` (defined in `S13.Defs`): with Harder's bound `S(11) ≥ 35` as an
explicit hypothesis, every sorting network on 13 channels has at least 44 comparators.

The proof combines
* `prune` (`S13.Prune`): `|net| = |net'| + |W(x,y)|` for a sorting network `net'` on 11 channels;
* `P2_13` (`S13.P2_13`): `P(2,13) ≥ 9`, from a computation evaluated by `native_decide`.

`main_theorem_01` is the same statement with sorting defined on 0-1 inputs (the 0-1 principle).
-/

namespace Sortnet

/-- **Main theorem.** If every sorting network on 11 channels has at least 35 comparators (Harder),
then every sorting network on 13 channels has at least 44 comparators. -/
theorem main_theorem : MainStatement := mainStatement_of_P2 P2_13

/-- The main theorem with sorting networks defined by their action on 0-1 inputs. -/
theorem main_theorem_01 (h11 : ∀ net : Network 11, net.Sorts01 → 35 ≤ net.length) :
    ∀ net : Network 13, net.Sorts01 → 44 ≤ net.length := fun net hs =>
  main_theorem (fun net' hs' => h11 net' ((Network.sorts_iff_sorts01 net').1 hs')) net
    ((Network.sorts_iff_sorts01 net).2 hs)

end Sortnet
