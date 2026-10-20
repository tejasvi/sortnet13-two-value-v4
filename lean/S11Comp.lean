/-!
# The certificate checker for `S(11) ≥ 35` (core Lean only)

A certificate is a string of 7-bit characters, given here as `byte : Nat → Nat` (the value of the
character at a position), together with the offsets `stepAt s` of its steps. Step `s` claims a lower
bound `Bd s` for the set of 0-1 vectors of width `W s` whose codes are marked in its bitmap (bit `x`
of the bitmap set iff the vector with code `x`, bit `k` = channel `k`, is in the set).

Layout of a step at offset `o`:
* `o`: width `w`; `o+1`: bound `b`; `o+2`: kind (`0`, `1`: Huffman step with polarity `false`, `true`;
  `2`: successor step); `o+3`: number of witnesses;
* `o+4 ..`: the bitmap, 7 bits per character, `⌈2^w/7⌉` characters;
* then 8 characters per witness: 4 characters (28 bits) holding `tag + 4 * id` (`tag` = 0 or 1: the
  witness set of step `id`, inverted if `tag = 1`; `tag` = 2: no witness), and 4 characters holding a
  permutation in the Lehmer code.

`checkStep` is the checked part. Its meaning is proved in `S13.S11.Sound`: if every step passes, every
step's claim holds. The offsets and the permutation decoding are not trusted: soundness holds for any
`stepAt`, and every decoded permutation is checked.

This module imports only core Lean, so it can be compiled to native code for `native_decide`.
-/

namespace Sortnet.S11

/-- `∀ i < n, f i`. -/
def allLt : Nat → (Nat → Bool) → Bool
  | 0, _ => true
  | n + 1, f => allLt n f && f n

/-- `∃ i < n, f i`. -/
def anyLt : Nat → (Nat → Bool) → Bool
  | 0, _ => false
  | n + 1, f => anyLt n f || f n

/-- `∑_{i < n} f i`. -/
def sumLt : Nat → (Nat → Nat) → Nat
  | 0, _ => 0
  | n + 1, f => sumLt n f + f n

/-- A number stored in `k` characters from position `p`, little endian, 7 bits per character. -/
def readNum (byte : Nat → Nat) (p : Nat) : Nat → Nat
  | 0 => 0
  | k + 1 => byte p % 128 + 128 * readNum byte (p + 1) k

/-- Bit `x` of a bitmap stored from position `off`. -/
@[inline] def memBit (byte : Nat → Nat) (off x : Nat) : Bool := (byte (off + x / 7)).testBit (x % 7)

/-- Number of characters of a bitmap of width `w`. -/
@[inline] def bmLen (w : Nat) : Nat := (2 ^ w + 6) / 7

/-- Prepend to `acc` the codes `base + i`, `i < j`, with bit `i` of `c` set and `base + i < lim`,
in increasing order. -/
def bitsInto (c base lim : Nat) : Nat → List Nat → List Nat
  | 0, acc => acc
  | j + 1, acc =>
    bitsInto c base lim j (if c.testBit j && decide (base + j < lim) then (base + j) :: acc else acc)

/-- Prepend to `acc` the marked codes in the characters `ci < k` of the bitmap at `off`. -/
def elemsLoop (byte : Nat → Nat) (off lim : Nat) : Nat → List Nat → List Nat
  | 0, acc => acc
  | ci + 1, acc =>
    let c := byte (off + ci)
    elemsLoop byte off lim ci (if c == 0 then acc else bitsInto c (7 * ci) lim 7 acc)

/-- The codes `x < 2^w` marked in the bitmap at `off`, in increasing order. -/
def elemsOf (byte : Nat → Nat) (off w : Nat) : List Nat := elemsLoop byte off (2 ^ w) (bmLen w) []

/-- `acc + ∑_{k ≤ i < n} (bit perm[i] of x) * 2^i`. -/
def permCodeAux (perm : Array Nat) (n x : Nat) : Nat → Nat → Nat → Nat
  | 0, _, acc => acc
  | fuel + 1, k, acc =>
    if k < n then
      permCodeAux perm n x fuel (k + 1) (if x.testBit (perm.getD k 0) then acc ||| (1 <<< k) else acc)
    else acc

/-- The code with bits `perm[0], ..., perm[n-1]` of `x` moved to positions `0, ..., n-1`. -/
@[inline] def permCode (perm : Array Nat) (n x : Nat) : Nat := permCodeAux perm n x n 0 0

/-- Invert the `n` low bits. -/
@[inline] def invCode (n x : Nat) : Nat := 2 ^ n - 1 - x

/-- Number of set bits among the `n` low bits. -/
def popc (n x : Nat) : Nat := sumLt n fun k => if x.testBit k then 1 else 0

/-- Insert bit `t` at position `a` (the bits from `a` on move up by one). -/
@[inline] def insBit (a : Nat) (t : Bool) (y : Nat) : Nat :=
  (y &&& (2 ^ a - 1)) ||| (if t then 1 <<< a else 0) ||| ((y >>> a) <<< (a + 1))

/-- Exchange the bits at positions `lo` and `hi` of a code in which they differ. -/
@[inline] def swapDown (lo hi y : Nat) : Nat := y ^^^ ((1 <<< lo) ||| (1 <<< hi))

/-- Membership in the image of a set under the comparator `(lo, hi)` (min to `lo`, max to `hi`). -/
@[inline] def memCmp (mem : Nat → Bool) (lo hi y : Nat) : Bool :=
  let a := y.testBit lo
  let b := y.testBit hi
  if a == b then mem y else if !a && b then (mem y || mem (swapDown lo hi y)) else false

/-- `n!`. -/
def fact : Nat → Nat
  | 0 => 1
  | n + 1 => (n + 1) * fact n

/-- Decode a permutation of `0, ..., n-1` from its Lehmer code (not trusted: the result is checked). -/
def lehmer (n c : Nat) : Array Nat := Id.run do
  let mut avail : Array Nat := Array.range n
  let mut out : Array Nat := #[]
  let mut c := c
  for k in [0:n] do
    let f := fact (n - 1 - k)
    let d := c / f
    c := c % f
    out := out.push (avail.getD d 0)
    avail := avail.eraseIdxIfInBounds d
  return out

/-- `perm` lists `n` distinct numbers below `n`. -/
def validPerm (perm : Array Nat) (n : Nat) : Bool :=
  perm.size == n && allLt n (fun i => decide (perm.getD i 0 < n)) &&
    allLt n fun i => allLt n fun j => i == j || perm.getD i 0 != perm.getD j 0

/-- Search a list of candidate codes for two different codes with the same number of set bits
(not trusted: the result is checked). -/
def findCollision (n : Nat) (cands : List Nat) : Option (Nat × Nat) := Id.run do
  let mut seen : Array (Option Nat) := Array.replicate (n + 1) none
  for x in cands do
    let p := popc n x
    match seen.getD p none with
    | some y => if y != x then return some (y, x) else pure ()
    | none => seen := seen.set! p (some x)
  return none

/-- Two different codes below `2^n` with the same weight, both in the set: no empty network works.
The candidates are not trusted. -/
def collision (n : Nat) (mem : Nat → Bool) (cands : Unit → List Nat) : Bool :=
  match findCollision n (cands ()) with
  | some (x, y) => decide (x < 2 ^ n) && decide (y < 2 ^ n) && x != y && mem x && mem y &&
      popc n x == popc n y
  | none => false

/-- The comparator `(lo, hi)` applied to a code. -/
@[inline] def cmpCode (lo hi x : Nat) : Nat :=
  if x.testBit lo && !x.testBit hi then x - 2 ^ lo + 2 ^ hi else x

/-- Delete bit `a` of a code. -/
@[inline] def delBit (a y : Nat) : Nat := y % 2 ^ a + y / 2 ^ (a + 1) * 2 ^ a

/-! ## Steps -/

/-- A certificate: character values and step offsets. -/
structure Cert where
  byte : Nat → Nat
  stepAt : Nat → Nat

namespace Cert
variable (c : Cert)

@[inline] def W (s : Nat) : Nat := c.byte (c.stepAt s)
@[inline] def Bd (s : Nat) : Nat := c.byte (c.stepAt s + 1)
@[inline] def kind (s : Nat) : Nat := c.byte (c.stepAt s + 2)
@[inline] def nw (s : Nat) : Nat := c.byte (c.stepAt s + 3)
@[inline] def bmOff (s : Nat) : Nat := c.stepAt s + 4
/-- Membership in the set of step `s`. -/
@[inline] def mem (s x : Nat) : Bool := memBit c.byte (c.bmOff s) x
@[inline] def witOff (s j : Nat) : Nat := c.stepAt s + 4 + bmLen (c.W s) + 8 * j
/-- The codes in the set of step `s`. -/
@[inline] def elems (s : Nat) : List Nat := elemsOf c.byte (c.bmOff s) (c.W s)

/-- Check one code of a witness set: its image (inverted if `tag = 1`, then permuted) is in the
target set. -/
@[inline] def witElem (perm : Array Nat) (n tag : Nat) (tmem : Nat → Bool) (x : Nat) : Bool :=
  tmem (permCode perm n (if tag == 1 then invCode n x else x))

/-- The conditions on a witness: an earlier step of the right width, a valid permutation, and
every code of its set maps into the target set. -/
def witOk (s n tag id : Nat) (perm : Array Nat) (tmem : Nat → Bool) : Bool :=
  decide (id < s) && c.W id == n && validPerm perm n && (c.elems id).all (witElem perm n tag tmem)

/-- The bound given by witness `j` of step `s` for the set of width `n` with membership `tmem`, if
the witness is valid. `cands` lists candidate codes for a collision (used only without a witness). -/
def witBound (s j n : Nat) (tmem : Nat → Bool) (cands : Unit → List Nat) : Option Nat :=
  let v := readNum c.byte (c.witOff s j) 4
  if v % 4 == 2 then some (if collision n tmem cands then 1 else 0)
  else if v % 4 == 3 then none
  else if c.witOk s n (v % 4) (v / 4) (lehmer n (readNum c.byte (c.witOff s j + 4) 4)) tmem
  then some (c.Bd (v / 4)) else none

/-- The comparator `(lo, hi)` changes some code of `E` and does not merely relabel the set. -/
def irredundant (E : List Nat) (lo hi : Nat) : Bool :=
  (E.any fun x => x.testBit lo && !x.testBit hi) && (E.any fun x => !x.testBit lo && x.testBit hi)

/-- The comparators `(lo, hi)`, `lo < hi < w`, ordered by `hi` and then by `lo`. -/
def cmpList (w : Nat) : List (Nat × Nat) :=
  (List.range w).flatMap fun hi => (List.range hi).map fun lo => (lo, hi)

/-- Check the witnesses `j₀, j₀+1, ...` against a list of comparators. -/
def checkSuccWits (s b : Nat) (E : List Nat) : List (Nat × Nat) → Nat → Bool
  | [], _ => true
  | (lo, hi) :: rest, j =>
    (match c.witBound s j (c.W s) (memCmp (c.mem s) lo hi) (fun _ => E.map (cmpCode lo hi)) with
      | some bw => decide (b ≤ bw + 1)
      | none => false) && checkSuccWits s b E rest (j + 1)

/-- A successor step. -/
def checkSucc (s : Nat) : Bool :=
  let w := c.W s
  let E := c.elems s
  let irr := (cmpList w).filter fun lh => irredundant E lh.1 lh.2
  collision w (c.mem s) (fun _ => E) && irr.length == c.nw s && c.checkSuccWits s (c.Bd s) E irr 0

/-- The extremal code for channel `i`: a single `true` (polarity `false`) or a single `false`. -/
@[inline] def extCode (pol : Bool) (w i : Nat) : Nat := if pol then 2 ^ w - 1 - 2 ^ i else 2 ^ i

/-- The bounds given by the witnesses `j₀, j₀+1, ...` for a list of extremal channels. -/
def huffBounds (s : Nat) (pol : Bool) (E : List Nat) : List Nat → Nat → Option (List Nat)
  | [], _ => some []
  | i :: rest, j =>
    match c.witBound s j (c.W s - 1) (fun y => c.mem s (insBit i (!pol) y))
        (fun _ => E.filterMap fun x => if x.testBit i == !pol then some (delBit i x) else none),
        huffBounds s pol E rest (j + 1) with
    | some bi, some bs => some (bi :: bs)
    | _, _ => none

/-- A Huffman step. -/
def checkHuff (s : Nat) (pol : Bool) : Bool :=
  let w := c.W s
  let ext := (List.range w).filter fun i => c.mem s (extCode pol w i)
  decide (1 ≤ w) && ext.length == c.nw s &&
    match c.huffBounds s pol (c.elems s) ext 0 with
    | some bs => decide (2 ^ c.Bd s < 2 * (bs.map (2 ^ ·)).sum)
    | none => false

/-- Check step `s`. -/
def checkStep (s : Nat) : Bool :=
  if c.kind s == 2 then c.checkSucc s
  else if c.kind s == 0 then c.checkHuff s false
  else if c.kind s == 1 then c.checkHuff s true
  else false

end Cert

/-! ## The whole certificate -/

/-- `∀ i ∈ [a, a + fuel)` with `i < b`, `f i`. -/
def rangeAll (f : Nat → Bool) (b : Nat) : Nat → Nat → Bool
  | 0, _ => true
  | fuel + 1, a => if a < b then f a && rangeAll f b fuel (a + 1) else true

/-- `∀ i < count, f i`, checked in parallel chunks of `chunk` indices (one task per chunk). -/
def parAll (count chunk : Nat) (f : Nat → Bool) : Bool :=
  let chunk := max chunk 1
  let tasks := (List.range ((count + chunk - 1) / chunk)).map fun k =>
    Task.spawn fun _ => rangeAll f count chunk (k * chunk)
  tasks.all fun t => t.get

/-- Step offsets, by a scan over the step headers (not trusted). -/
def offsets (byte : Nat → Nat) (count : Nat) : Array Nat := Id.run do
  let mut a : Array Nat := Array.mkEmpty count
  let mut o := 4
  for _ in [0:count] do
    a := a.push o
    o := o + 4 + bmLen (byte o) + 8 * byte (o + 3)
  return a

/-- The certificate check: every step passes, and the last step claims the bound `b` for all
`2^w` vectors of width `w`. -/
def certOK (c : Cert) (count chunk w b : Nat) : Bool :=
  decide (0 < count) && c.W (count - 1) == w && c.Bd (count - 1) == b &&
    allLt (2 ^ w) (fun x => c.mem (count - 1) x) && parAll count chunk c.checkStep

end Sortnet.S11
