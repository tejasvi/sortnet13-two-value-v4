import Std.Data.HashSet

/-!
# The computation behind `P(2,n) > L` (core Lean only)

Concrete f-states and the closure check. An f-state on `n` channels is an array of `n * n` naturals;
entry `p * n + q` is `0` if no run has the largest value on channel `p` and the second largest on
channel `q`, and otherwise `1 +` the largest number of comparators met so far by such a run.

* `stepC`, `pullC`, `phiC`, `twoEntries`, `validPerm`, `checkAll`: the checked part. Their meaning is
  proved in `S13.CheckSound`.
* `canonPerm`, `search`: an untrusted search that proposes the set of states. Nothing about them is
  proved; the check verifies whatever they return.

This module imports only core Lean, so that it can be compiled to native code and loaded by
`native_decide`.
-/

namespace Sortnet.Comp

/-- A concrete f-state (see the module docstring). -/
abbrev CState := Array Nat

/-- The entry for the pair of channels `(p, q)`. -/
@[inline] def get (n : Nat) (s : CState) (p q : Nat) : Nat := s.getD (p * n + q) 0

/-- One more comparator met: `0` (no run) stays `0`. -/
@[inline] def cinc (e : Nat) : Nat := if e = 0 then 0 else e + 1

/-- Entry `(p, q)` after the comparator `(lo, hi) = (a, b)`. -/
@[inline] def entry (n a b : Nat) (s : CState) (p q : Nat) : Nat :=
  if p = b then
    (if q = a then cinc (max (get n s a b) (get n s b a))
     else if q = b then 0 else cinc (max (get n s a q) (get n s b q)))
  else if p = a then 0
  else if q = a then 0
  else if q = b then cinc (max (get n s p a) (get n s p b))
  else get n s p q

/-- The f-state after the comparator `(lo, hi) = (a, b)`. -/
def stepC (n a b : Nat) (s : CState) : CState :=
  Array.ofFn (n := n * n) fun i => entry n a b s (i.val / n) (i.val % n)

/-- Relabel the channels: entry `(p, q)` of the result is entry `(σ p, σ q)` of `s`. -/
def pullC (n : Nat) (σ : Array Nat) (s : CState) : CState :=
  Array.ofFn (n := n * n) fun i => get n s (σ.getD (i.val / n) 0) (σ.getD (i.val % n) 0)

/-- `∑_{i < k} g i`. -/
def sumTo (g : Nat → Nat) : Nat → Nat
  | 0 => 0
  | k + 1 => sumTo g k + g k

/-- The Kraft weight `2 ^ cost` of an entry (`0` if no run is there). -/
@[inline] def cwt (e : Nat) : Nat := if e = 0 then 0 else 2 ^ (e - 1)

/-- The least power of two that is `≥ s` (and `0` for `s = 0`). -/
def R (s : Nat) : Nat := if s = 0 then 0 else 2 ^ Nat.log2 (2 * s - 1)

/-- `∑_{q ≠ p} 2 ^ f(p, q)`. -/
def rowSumC (n : Nat) (s : CState) (p : Nat) : Nat :=
  sumTo (fun q => if q = p then 0 else cwt (get n s p q)) n

/-- The Kraft potential `Φ(f) = ∑_p R(∑_{q ≠ p} 2 ^ f(p, q))`. -/
def phiC (n : Nat) (s : CState) : Nat := sumTo (fun p => R (rowSumC n s p)) n

/-- Two different nonzero entries among the first `n * n`, so that the state is not a goal. -/
def twoEntries (n : Nat) (s : CState) : Bool :=
  (List.range (n * n)).any fun i => s.getD i 0 != 0 && (List.range i).any fun j => s.getD j 0 != 0

/-- `σ` lists `n` distinct channels below `n`. -/
def validPerm (n : Nat) (σ : Array Nat) : Bool :=
  σ.size == n && (List.range n).all (fun i => decide (σ.getD i 0 < n)) &&
    (List.range n).all fun i => (List.range n).all fun j => i == j || σ.getD i 0 != σ.getD j 0

/-- `g a b` for all channels `a < b < n`. -/
def allPairs (n : Nat) (g : Nat → Nat → Bool) : Bool :=
  (List.range n).all fun a => (List.range n).all fun b => !decide (a < b) || g a b

/-! ## Untrusted: canonical relabeling by colour refinement -/

@[inline] def mix (h : UInt64) : UInt64 :=
  let h := (h ^^^ (h >>> 30)) * 0xbf58476d1ce4e5b9
  let h := (h ^^^ (h >>> 27)) * 0x94d049bb133111eb
  h ^^^ (h >>> 31)

/-- One round of colour refinement of the channels. -/
def refine (n : Nat) (s : CState) (col : Array UInt64) : Array UInt64 :=
  Array.ofFn (n := n) fun p => Id.run do
    let pv := p.val
    let mut acc : UInt64 := 0
    for q in [0:n] do
      if q != pv then
        let cq := col.getD q 0
        acc := acc + mix ((get n s pv q).toUInt64 * 0x9E3779B97F4A7C15 + cq)
          + mix ((get n s q pv).toUInt64 * 0xC2B2AE3D27D4EB4F + cq * 31 + 7)
    return mix (col.getD pv 0 * 0x100000001B3 + acc)

/-- Number of distinct colours. -/
def numColours (col : Array UInt64) : Nat := Id.run do
  let c := col.qsort (· < ·)
  let mut k := 0
  for i in [0:c.size] do
    if i == 0 || c[i]! != c[i-1]! then k := k + 1
  return k

/-- A channel order by refined colour, ties broken by index: position `i` gets channel `σ[i]`. -/
def canonPerm (n : Nat) (s : CState) : Array Nat := Id.run do
  let mut col : Array UInt64 := Array.replicate n 0
  let mut k := 1
  for _ in [0:n] do
    let col' := refine n s col
    let k' := numColours col'
    col := col'
    if k' == k then break
    k := k'
  return (Array.range n).qsort fun i j =>
    col.getD i 0 < col.getD j 0 || (col.getD i 0 == col.getD j 0 && i < j)

/-! ## Untrusted: breadth-first search over canonical states -/

/-- The start state: one run at every pair `(p, q)` with `p ≠ q`, none met a comparator yet. -/
def initC (n : Nat) : CState := Array.ofFn (n := n * n) fun i => if i.val / n = i.val % n then 0 else 1

/-- All states reachable from `initC n` through children that pass the Kraft test, up to relabeling
by `canonPerm`; `initC n` comes first. `fuel` bounds the number of expanded states. -/
def search (n L : Nat) (fuel : Nat := 100000000) : Array CState := Id.run do
  let s0 := initC n
  let mut all : Array CState := #[s0]
  let mut seen : Std.HashSet CState := (∅ : Std.HashSet CState).insert s0
  let mut head := 0
  for _ in [0:fuel] do
    if h : head < all.size then
      let k := all[head]
      head := head + 1
      for a in [0:n] do
        for b in [a+1:n] do
          let t := stepC n a b k
          if t != k && phiC n t ≤ 2 ^ L then
            let k' := pullC n (canonPerm n t) t
            if !seen.contains k' then
              seen := seen.insert k'
              all := all.push k'
    else break
  return all

/-! ## The check -/

/-- The closure condition at one state `k` of the proposed set `H`. -/
def checkState (n L : Nat) (H : Std.HashSet CState) (k : CState) : Bool :=
  twoEntries n k && allPairs n fun a b =>
    let t := stepC n a b k
    t == k || decide (2 ^ L < phiC n t) ||
      (let σ := canonPerm n t; validPerm n σ && H.contains (pullC n σ t))

/-- Every state of `S` satisfies the closure condition with respect to the set of states of `S`. -/
def checkAll (n L : Nat) (S : Array CState) : Bool :=
  let H := Std.HashSet.ofList S.toList
  S.all (checkState n L H)

/-- The whole computation: search, then check. `fullCheck n L = true` implies `P(2,n) ≥ L + 1`. -/
def fullCheck (n L : Nat) : Bool :=
  let S := search n L
  S.contains (initC n) && checkAll n L S

end Sortnet.Comp
