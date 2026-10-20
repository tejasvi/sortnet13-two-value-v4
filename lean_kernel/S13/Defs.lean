/-!
# Comparator networks: the definitions behind the main theorem

This file uses core Lean only. It fixes the objects that the main theorem talks about, so that every
formalization that imports it proves the literally identical proposition `Sortnet.MainStatement`.

* `Comparator n`, `Network n`: standard comparator networks on `n` channels (Knuth's model). A
  comparator `(i, j)` has `i < j`; it puts the minimum of its two values on channel `i` and the
  maximum on channel `j`.
* `Network.Sorts`: the network sorts every input vector of natural numbers. (By the 0-1 principle,
  proved in `S13.Network`, this is equivalent to sorting every 0-1 input.)
* `GComparator n`, `GNetwork n`: generalized comparators `(lo, hi)` with `lo ≠ hi` in either order.
  They model the acyclic circuits of the paper; the quantities `W(x,y)` and `P(2,n)` are defined for
  them.
-/

namespace Sortnet

/-! ## Standard networks and sorting -/

/-- A standard comparator on `n` channels: channels `i < j`. It puts the minimum of the two values on
channel `i` and the maximum on channel `j`. -/
structure Comparator (n : Nat) where
  i : Fin n
  j : Fin n
  lt : i < j
  deriving DecidableEq

/-- Apply a standard comparator to a vector of values. -/
def Comparator.apply {n : Nat} (c : Comparator n) (v : Fin n → Nat) : Fin n → Nat :=
  fun k => if k = c.i then min (v c.i) (v c.j) else if k = c.j then max (v c.i) (v c.j) else v k

/-- A standard comparator network on `n` channels; the comparators act from the head of the list. -/
abbrev Network (n : Nat) := List (Comparator n)

/-- The output of a network on the input vector `v`. -/
def Network.eval {n : Nat} (net : Network n) (v : Fin n → Nat) : Fin n → Nat :=
  net.foldl (fun w c => c.apply w) v

/-- `net` is a sorting network: on every input its output is nondecreasing along the channels. -/
def Network.Sorts {n : Nat} (net : Network n) : Prop :=
  ∀ v : Fin n → Nat, ∀ a b : Fin n, a ≤ b → net.eval v a ≤ net.eval v b

/-- **Main theorem (statement).** If every sorting network on 11 channels has at least 35
comparators (Harder's bound `S(11) ≥ 35`), then every sorting network on 13 channels has at least
44 comparators. -/
def MainStatement : Prop :=
  (∀ net : Network 11, net.Sorts → 35 ≤ net.length) →
    ∀ net : Network 13, net.Sorts → 44 ≤ net.length

/-! ## Generalized networks, runs, `W(x,y)` and `P(2,n)` -/

/-- A generalized comparator on `n` channels: it puts the minimum of the values on channels `lo` and
`hi` on channel `lo` and the maximum on channel `hi`. Either order of `lo` and `hi` is allowed. -/
structure GComparator (n : Nat) where
  lo : Fin n
  hi : Fin n
  ne : lo ≠ hi
  deriving DecidableEq

/-- Apply a generalized comparator to a vector of values. -/
def GComparator.apply {n : Nat} (c : GComparator n) (v : Fin n → Nat) : Fin n → Nat :=
  fun k => if k = c.lo then min (v c.lo) (v c.hi) else if k = c.hi then max (v c.lo) (v c.hi) else v k

/-- A generalized comparator network; the comparators act from the head of the list. -/
abbrev GNetwork (n : Nat) := List (GComparator n)

/-- The output of a generalized network on the input vector `v`. -/
def GNetwork.eval {n : Nat} (net : GNetwork n) (v : Fin n → Nat) : Fin n → Nat :=
  net.foldl (fun w c => c.apply w) v

/-- A standard network read as a generalized one. -/
def Network.toG {n : Nat} (net : Network n) : GNetwork n :=
  net.map fun c => ⟨c.i, c.j, Fin.ne_of_lt c.lt⟩

/-- The input of the run `(x, y)`: the largest value `M = n + 1` on input `x`, the second largest
value `m = n` on input `y`, and the distinct smaller values `z < n` on the other inputs `z`. -/
def runInput (n : Nat) (x y : Fin n) : Fin n → Nat :=
  fun z => if z = x then n + 1 else if z = y then n else z.val

/-- The positions (counted from `0`) of the comparators of `net` that have a value `≥ t` on one of
their two input leads, when `net` runs on the input `v`. -/
def GNetwork.touched {n : Nat} : GNetwork n → (Fin n → Nat) → Nat → List Nat
  | [], _, _ => []
  | c :: net, v, t =>
      (if t ≤ v c.lo ∨ t ≤ v c.hi then [0] else []) ++ (touched net (c.apply v) t).map (· + 1)

/-- `W(x,y)`: the comparators (as positions in `net`) with the largest value `M` or the second
largest value `m` on an input lead in the run `(x, y)`. -/
def GNetwork.W {n : Nat} (net : GNetwork n) (x y : Fin n) : List Nat :=
  net.touched (runInput n x y) n

/-- Top-two correct: there are outputs `oM ≠ om` such that in every run `(x, y)` the largest value
ends on `oM` and the second largest on `om`. -/
def GNetwork.Top2Correct {n : Nat} (net : GNetwork n) : Prop :=
  ∃ oM om : Fin n, oM ≠ om ∧ ∀ x y : Fin n, x ≠ y →
    net.eval (runInput n x y) oM = n + 1 ∧ net.eval (runInput n x y) om = n

/-- `P(2,n) ≥ L`: every top-two correct network on `n` channels has a run `(x, y)` with
`|W(x,y)| ≥ L`. -/
def P2AtLeast (n L : Nat) : Prop :=
  ∀ net : GNetwork n, net.Top2Correct → ∃ x y : Fin n, x ≠ y ∧ L ≤ (net.W x y).length

end Sortnet
