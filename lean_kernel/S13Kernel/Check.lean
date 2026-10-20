
/-!
# A kernel-friendly closure check (core Lean only)

This module is the computational half of the kernel-only proof of `P(2,13) ≥ 9`. It checks, by
evaluation in the Lean kernel (`decide +kernel`), that an explicit list of f-states on 13 channels
satisfies the hypotheses of `Sortnet.closure_sound` at level `L = 8`. The meaning of every function
is proved in `S13Kernel.Sound`.

Encoding. A state is a natural number `K` (its *key*). For channels `p, q < 13` the 4-bit field
`ent K p q` at bit `64 + 4 (13 p + q)` is `0` if no run has the largest value on `p` and the second
largest on `q`, and `1 +` the largest number of comparators met so far otherwise. The low 64 bits
carry a salt (a hash of the rest): the kernel hashes a numeral by its low 64 bits, and keys that
agree there would make its caches degenerate.

Kernel efficiency. All loops are explicit `Nat.rec`/`List.rec` recursions, tests are bare `Bool.rec`
on `Nat.beq`/`Nat.ble`, and arithmetic calls `Nat.add`, `Nat.mul`, ... directly; the kernel evaluates
these faster than compiled structural recursion, `if` on `Decidable` instances and the `HAdd`-style
instance chains. The definitions are `noncomputable`: only the kernel evaluates them.
-/

namespace S13K

/-- `if c then x else y` for natural numbers, as a bare recursor. -/
@[reducible] noncomputable def selN (c : Bool) (x y : Nat) : Nat := Bool.rec (motive := fun _ => Nat) y x c

/-- `c && d`, as a bare recursor. -/
@[reducible] noncomputable def andB (c d : Bool) : Bool := Bool.rec (motive := fun _ => Bool) false d c

/-- `c || d`, as a bare recursor. -/
@[reducible] noncomputable def orB (c d : Bool) : Bool := Bool.rec (motive := fun _ => Bool) d true c

/-- The field `(p, q)` of the key `K`. -/
noncomputable def ent (K p q : Nat) : Nat :=
  Nat.mod (Nat.shiftRight K (Nat.add 64 (Nat.mul 4 (Nat.add (Nat.mul 13 p) q)))) 16

/-- `Sortnet.Comp.cinc`: one more comparator met (`0`, no run, stays `0`). -/
noncomputable def cincB (e : Nat) : Nat := selN (Nat.beq e 0) 0 (Nat.succ e)

/-- `max`. -/
noncomputable def maxB (x y : Nat) : Nat := selN (Nat.ble x y) y x

/-- Entry `(p, q)` after the comparator `(lo, hi) = (a, b)`, for a state given by its entries `g`.
This is `Sortnet.Comp.entry` with the array lookup replaced by `g`. -/
noncomputable def entryF (g : Nat → Nat → Nat) (a b p q : Nat) : Nat :=
  selN (Nat.beq p b)
    (selN (Nat.beq q a) (cincB (maxB (g a b) (g b a)))
      (selN (Nat.beq q b) 0 (cincB (maxB (g a q) (g b q)))))
    (selN (Nat.beq p a) 0
      (selN (Nat.beq q a) 0
        (selN (Nat.beq q b) (cincB (maxB (g p a) (g p b))) (g p q))))

/-- `∀ i < k, P i`, as a Boolean loop. -/
noncomputable def allBelow (P : Nat → Bool) (k : Nat) : Bool :=
  Nat.rec (motive := fun _ => Bool) true (fun i acc => andB acc (P i)) k

/-- `∑_{i < k} g i`, as a loop. -/
noncomputable def sumBelow (g : Nat → Nat) (k : Nat) : Nat :=
  Nat.rec (motive := fun _ => Nat) 0 (fun i acc => Nat.add acc (g i)) k

/-- The least power of two `≥ s` for `s ≤ 256` (`0` for `s = 0`), and `512` above `256`. It is at most
`Sortnet.Comp.R s` for every `s` and avoids the kernel-unfriendly `Nat.log2`. -/
noncomputable def npow (s : Nat) : Nat :=
  selN (Nat.ble s 16)
    (selN (Nat.ble s 4) (selN (Nat.ble s 2) s 4) (selN (Nat.ble s 8) 8 16))
    (selN (Nat.ble s 64) (selN (Nat.ble s 32) 32 64)
      (selN (Nat.ble s 256) (selN (Nat.ble s 128) 128 256) 512))

/-- The Kraft weight `2 ^ cost` of entry `(p, q)` of the key `K` (`0` if no run is there). -/
noncomputable def wK (K p q : Nat) : Nat :=
  selN (Nat.beq (ent K p q) 0) 0 (Nat.pow 2 (Nat.sub (ent K p q) 1))

/-- `∑_{q < 13, q ≠ p} 2 ^ cost(p, q)` for the key `K`. -/
noncomputable def rsK (K p : Nat) : Nat := sumBelow (fun q => selN (Nat.beq q p) 0 (wK K p q)) 13

/-- Row `p ∉ {a, b}` of the child of `K` under the comparator `(a, b)`: the entries `(p, a)` and `(p, b)`
merge into `(p, b)`, one comparator more. Computed from the row sum of `K`. -/
noncomputable def rowOther (K a b p : Nat) : Nat :=
  Nat.sub (Nat.add (rsK K p) (Nat.mul 2 (maxB (wK K p a) (wK K p b)))) (Nat.add (wK K p a) (wK K p b))

/-- Row `b` of the child of `K` under the comparator `(a, b)`. -/
noncomputable def rowHi (K a b : Nat) : Nat :=
  Nat.add (Nat.mul 2 (maxB (wK K a b) (wK K b a)))
    (sumBelow (fun q => selN (Nat.beq q a) 0
      (selN (Nat.beq q b) 0 (Nat.mul 2 (maxB (wK K a q) (wK K b q))))) 13)

/-- A lower bound for the Kraft potential `Φ` of the child of `K` under the comparator `(a, b)`
(row `a` of the child is empty). -/
noncomputable def phiInc (K a b : Nat) : Nat :=
  sumBelow (fun p => npow (selN (Nat.beq p a) 0 (selN (Nat.beq p b) (rowHi K a b) (rowOther K a b p)))) 13

/-- Rows and columns `a` and `b` are empty, so the comparator `(a, b)` meets no run. -/
noncomputable def untK (g : Nat → Nat → Nat) (a b : Nat) : Bool :=
  allBelow (fun q => andB (andB (Nat.beq (g a q) 0) (Nat.beq (g b q) 0))
    (andB (Nat.beq (g q a) 0) (Nat.beq (g q b) 0))) 13

/-- The relabeling packed in `sg`: channel `p` goes to `sig sg p`. -/
noncomputable def sig (sg p : Nat) : Nat := Nat.mod (Nat.shiftRight sg (Nat.mul 4 p)) 16

/-- `sig sg` maps the channels below 13 into themselves, with left inverse `sig tg`. -/
noncomputable def validK (sg tg : Nat) : Bool :=
  allBelow (fun p => andB (Nat.blt (sig sg p) 13) (Nat.beq (sig tg (sig sg p)) p)) 13

/-- Entry `(p, q)` of the key `K'` is entry `(σ p, σ q)` of `t`, for all `p, q < 13`. -/
noncomputable def isoK (K' : Nat) (t : Nat → Nat → Nat) (sg : Nat) : Bool :=
  allBelow (fun p => allBelow (fun q => Nat.beq (ent K' p q) (t (sig sg p) (sig sg q))) 13) 13

/-- The number of nonempty entries. -/
noncomputable def cntK (K : Nat) : Nat :=
  sumBelow (fun p => sumBelow (fun q => selN (Nat.beq (ent K p q) 0) 0 1) 13) 13

/-! ## The list of keys -/

/-- A binary trie of keys addressed by 17-bit indices, most significant bit first. -/
inductive KT where
  | em : KT
  | lf : Nat → KT
  | nd : KT → KT → KT

/-- Key number `j` of the trie (`0` if absent). -/
noncomputable def getK (S : KT) (j : Nat) : Nat :=
  (Nat.rec (motive := fun _ => KT → Nat)
    (fun t => KT.casesOn (motive := fun _ => Nat) t 0 (fun k => k) (fun _ _ => 0))
    (fun d ih t => KT.casesOn (motive := fun _ => Nat) t 0 (fun k => k)
      (fun l r => selN (Nat.beq (Nat.mod (Nat.shiftRight j d) 2) 0) (ih l) (ih r))) 17) S

/-! ## The check at one state -/

/-- A certificate entry `(ci, sg, tg, j)`: the child of the comparator `(a, b)` with
`ci = 16 a + b` is relabeled by `sig sg` (left inverse `sig tg`) into key number `j`. -/
abbrev CertList := List (Nat × Nat × Nat × Nat)

/-- The certificate entry for the comparator number `ci`. -/
noncomputable def lookC (ci : Nat) (ce : CertList) : Option (Nat × Nat × Nat) :=
  List.rec (motive := fun _ => Option (Nat × Nat × Nat)) none
    (fun hd _ ih => Bool.rec (motive := fun _ => Option (Nat × Nat × Nat)) ih (some hd.2)
      (Nat.beq hd.1 ci)) ce

/-- The closure condition for the comparator `(a, b)` at the state `K`. -/
noncomputable def chkPair (S : KT) (N K : Nat) (ce : CertList) (a b : Nat) : Bool :=
  Option.casesOn (motive := fun _ => Bool) (lookC (Nat.add (Nat.mul 16 a) b) ce)
    (orB (untK (ent K) a b) (Nat.blt 256 (phiInc K a b)))
    (fun w => andB (andB (validK w.1 w.2.1) (Nat.blt w.2.2 N))
      (isoK (getK S w.2.2) (entryF (ent K) a b) w.1))

/-- The closure condition at the state `K` for all comparators `(a, b)` with `a < b < 13`. -/
noncomputable def chkState (S : KT) (N K : Nat) (ce : CertList) : Bool :=
  andB (Nat.ble 2 (cntK K)) (allBelow (fun b => allBelow (fun a => chkPair S N K ce a b) b) 13)

/-- `chkState` at the keys number `base, base + 1, …`, one certificate list each. -/
noncomputable def chkRange (S : KT) (N : Nat) (ces : List CertList) (base : Nat) : Bool :=
  (List.rec (motive := fun _ => Nat → Bool) (fun _ => true)
    (fun ce _ ih i => andB (chkState S N (getK S i) ce) (ih (Nat.succ i))) ces) base

/-- The check of one chunk of keys. -/
noncomputable def chkChunk (S : KT) (N base len : Nat) (ces : List CertList) : Bool :=
  andB (Nat.beq ces.length len) (chkRange S N ces base)

/-- Every key with number in `[lo, hi)` and below `N` passes `chkState` with some certificate. -/
def RangeOK (S : KT) (N lo hi : Nat) : Prop :=
  ∀ j, lo ≤ j → j < hi → j < N → ∃ ce, chkState S N (getK S j) ce = true

/-- The start state: entry `(p, q)` is `1` (no comparator met) for `p ≠ q`, and `0` for `p = q`. -/
noncomputable def startK (K : Nat) : Bool :=
  allBelow (fun p => allBelow (fun q => Nat.beq (ent K p q) (selN (Nat.beq p q) 0 1)) 13) 13

/-! ## Loop lemmas (core Lean) -/

theorem selN_eq (c : Bool) (x y : Nat) : selN c x y = if c = true then x else y := by
  cases c <;> rfl

theorem andB_eq (c d : Bool) : andB c d = (c && d) := by cases c <;> rfl

theorem orB_eq (c d : Bool) : orB c d = (c || d) := by cases c <;> rfl

theorem allBelow_succ (P : Nat → Bool) (k : Nat) :
    allBelow P (k + 1) = (allBelow P k && P k) := andB_eq _ _

theorem allBelow_iff (P : Nat → Bool) (k : Nat) : allBelow P k = true ↔ ∀ i < k, P i = true := by
  induction k with
  | zero => exact ⟨fun _ i hi => absurd hi (Nat.not_lt_zero i), fun _ => rfl⟩
  | succ k ih =>
    rw [allBelow_succ, Bool.and_eq_true, ih]
    constructor
    · rintro ⟨h1, h2⟩ i hi
      rcases Nat.lt_succ_iff_lt_or_eq.1 hi with h | h
      · exact h1 i h
      · exact h ▸ h2
    · intro h
      exact ⟨fun i hi => h i (Nat.lt_succ_of_lt hi), h k (Nat.lt_succ_self k)⟩

theorem sumBelow_succ (g : Nat → Nat) (k : Nat) : sumBelow g (k + 1) = sumBelow g k + g k := rfl

theorem sumBelow_zero (g : Nat → Nat) : sumBelow g 0 = 0 := rfl

theorem chkRange_cons (S : KT) (N : Nat) (ce : CertList) (ces : List CertList) (i : Nat) :
    chkRange S N (ce :: ces) i = (chkState S N (getK S i) ce && chkRange S N ces (i + 1)) :=
  andB_eq _ _

theorem chkRange_sound (S : KT) (N : Nat) (ces : List CertList) (base : Nat)
    (h : chkRange S N ces base = true) :
    ∀ t, t < ces.length → ∃ ce, chkState S N (getK S (base + t)) ce = true := by
  induction ces generalizing base with
  | nil => intro t ht; simp at ht
  | cons ce ces ih =>
    rw [chkRange_cons, Bool.and_eq_true] at h
    intro t ht
    cases t with
    | zero => exact ⟨ce, by simpa using h.1⟩
    | succ t =>
      obtain ⟨ce', hce'⟩ := ih (base + 1) h.2 t (by simpa using ht)
      exact ⟨ce', by rw [show base + (t + 1) = base + 1 + t by omega]; exact hce'⟩

theorem rangeOK_of_chkChunk {S : KT} {N base len : Nat} {ces : List CertList}
    (h : chkChunk S N base len ces = true) : RangeOK S N base (base + len) := by
  unfold chkChunk at h
  rw [andB_eq, Bool.and_eq_true, Nat.beq_eq] at h
  intro j hlo hhi _
  obtain ⟨ce, hce⟩ := chkRange_sound S N ces base h.2 (j - base) (by omega)
  exact ⟨ce, by rw [show base + (j - base) = j by omega] at hce; exact hce⟩

theorem RangeOK.append {S : KT} {N lo mid hi : Nat} (h1 : RangeOK S N lo mid)
    (h2 : RangeOK S N mid hi) : RangeOK S N lo hi := by
  intro j hlo hhi hN
  by_cases hj : j < mid
  · exact h1 j hlo hj hN
  · exact h2 j (by omega) hhi hN

end S13K
