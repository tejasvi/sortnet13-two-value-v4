import Mathlib.Data.Nat.Bitwise
import Mathlib.Algebra.BigOperators.Fin
import Mathlib.Data.Fin.Tuple.Basic
import S13.ZO.Huffman
import S11Comp

/-!
# Codes of 0-1 vectors

The checker represents a vector `v : Vec w` by its code `toCode v` (bit `k` = channel `k`). This file
relates the bit operations of the checker (`permCode`, `invCode`, `insBit`, `swapDown`, `memCmp`,
`popc`, `elemsOf`, `collision`) to operations on vectors.
-/

namespace Sortnet.S11

open ZO

/-- The code of a vector: bit `k` is channel `k`. -/
def toCode : {w : ℕ} → Vec w → ℕ
  | 0, _ => 0
  | _ + 1, v => (if v 0 then 1 else 0) + 2 * toCode (fun k => v k.succ)

/-- The vector with code `x` (bits `0, ..., w-1`). -/
def ofCode (w x : ℕ) : Vec w := fun k => x.testBit k

theorem testBit_toCode : ∀ {w : ℕ} (v : Vec w) (j : ℕ),
    (toCode v).testBit j = if h : j < w then v ⟨j, h⟩ else false
  | 0, v, j => by simp [toCode]
  | w + 1, v, j => by
    rcases j with _ | j
    · simp only [toCode, Nat.testBit_zero]
      cases h : v 0 <;> simp [h, Nat.add_mul_mod_self_left] <;> rfl
    · have hdiv : ((if v 0 then 1 else 0) + 2 * toCode (fun k : Fin w => v k.succ)) / 2 =
          toCode (fun k : Fin w => v k.succ) := by
        cases v 0 <;> simp <;> omega
      rw [toCode, Nat.testBit_succ, hdiv, testBit_toCode]
      by_cases hj : j < w
      · rw [dite_eq_left hj, dite_eq_left (by omega)]; rfl
      · rw [dite_eq_right hj, dite_eq_right (by omega)]

theorem toCode_apply {w : ℕ} (v : Vec w) (k : Fin w) : (toCode v).testBit k = v k := by
  simp [testBit_toCode, k.isLt]

theorem testBit_toCode_ge {w : ℕ} (v : Vec w) {j : ℕ} (hj : w ≤ j) : (toCode v).testBit j = false := by
  rw [testBit_toCode, dite_eq_right (by omega)]

theorem toCode_lt {w : ℕ} (v : Vec w) : toCode v < 2 ^ w :=
  Nat.lt_pow_two_of_testBit _ fun _ hi => testBit_toCode_ge v hi

theorem testBit_ge_of_lt {x w j : ℕ} (hx : x < 2 ^ w) (hj : w ≤ j) : x.testBit j = false :=
  Nat.testBit_lt_two_pow (lt_of_lt_of_le hx (Nat.pow_le_pow_right (by norm_num) hj))

/-- A code is determined by its bits. -/
theorem toCode_eq_of_testBit {w : ℕ} (v : Vec w) (x : ℕ) (h : ∀ j, x.testBit j =
    if h : j < w then v ⟨j, h⟩ else false) : toCode v = x := by
  apply Nat.eq_of_testBit_eq
  intro j
  rw [testBit_toCode, h]

theorem toCode_injective {w : ℕ} : Function.Injective (toCode : Vec w → ℕ) := by
  intro u v h
  funext k
  have := congrArg (fun x => x.testBit k) h
  simpa [toCode_apply] using this

theorem toCode_ofCode {w x : ℕ} (hx : x < 2 ^ w) : toCode (ofCode w x) = x := by
  apply toCode_eq_of_testBit
  intro j
  split_ifs with hj
  · rfl
  · exact testBit_ge_of_lt hx (by omega)

theorem ofCode_toCode {w : ℕ} (v : Vec w) : ofCode w (toCode v) = v := by
  funext k; simp [ofCode, toCode_apply]

/-! ## Loops -/

theorem allLt_iff (n : ℕ) (f : ℕ → Bool) : allLt n f = true ↔ ∀ i < n, f i = true := by
  induction n with
  | zero => simp [allLt]
  | succ n ih =>
    simp only [allLt, Bool.and_eq_true, ih]
    constructor
    · rintro ⟨h1, h2⟩ i hi
      rcases Nat.lt_succ_iff_lt_or_eq.1 hi with h | rfl
      · exact h1 i h
      · exact h2
    · intro h; exact ⟨fun i hi => h i (by omega), h n (by omega)⟩

theorem anyLt_iff (n : ℕ) (f : ℕ → Bool) : anyLt n f = true ↔ ∃ i < n, f i = true := by
  induction n with
  | zero => simp [anyLt]
  | succ n ih =>
    simp only [anyLt, Bool.or_eq_true, ih]
    constructor
    · rintro (⟨i, hi, h⟩ | h)
      · exact ⟨i, by omega, h⟩
      · exact ⟨n, by omega, h⟩
    · rintro ⟨i, hi, h⟩
      rcases Nat.lt_succ_iff_lt_or_eq.1 hi with h' | rfl
      · exact Or.inl ⟨i, h', h⟩
      · exact Or.inr h

theorem sumLt_eq (n : ℕ) (f : ℕ → ℕ) : sumLt n f = ∑ i ∈ Finset.range n, f i := by
  induction n with
  | zero => rfl
  | succ n ih => rw [sumLt, ih, Finset.sum_range_succ]

/-! ## Bit operations -/

theorem permCodeAux_spec (perm : Array ℕ) (n x : ℕ) :
    ∀ fuel k acc, k + fuel = n → (∀ j, k ≤ j → acc.testBit j = false) →
      ∀ j, (permCodeAux perm n x fuel k acc).testBit j =
        (acc.testBit j || (decide (k ≤ j) && decide (j < n) && x.testBit (perm.getD j 0)))
  | 0, k, acc, hk, hacc, j => by
    simp only [permCodeAux]
    by_cases h : k ≤ j
    · simp [h, show ¬ j < n by omega]
    · simp [h]
  | fuel + 1, k, acc, hk, hacc, j => by
    have hkn : k < n := by omega
    have hstep : permCodeAux perm n x (fuel + 1) k acc = permCodeAux perm n x fuel (k + 1)
        (if x.testBit (perm.getD k 0) then acc ||| (1 <<< k) else acc) := by
      simp [permCodeAux, hkn]
    have hacc' : ∀ j, k + 1 ≤ j →
        (if x.testBit (perm.getD k 0) then acc ||| (1 <<< k) else acc).testBit j = false := by
      intro j hj
      split_ifs
      · rw [Nat.testBit_or, Nat.one_shiftLeft, Nat.testBit_two_pow, hacc j (by omega)]
        simp; omega
      · exact hacc j (by omega)
    rw [hstep, permCodeAux_spec perm n x fuel (k + 1) _ (by omega) hacc' j]
    by_cases hjk : j = k
    · subst hjk
      have h0 := hacc j le_rfl
      cases hbv : x.testBit (perm.getD j 0)
      · simp [h0]
      · simp [Nat.testBit_or, Nat.one_shiftLeft, Nat.testBit_two_pow, h0, hkn]
    · have hdec : decide (k + 1 ≤ j) = decide (k ≤ j) := by
        congr 1; apply propext; omega
      rw [hdec]
      cases hbv : x.testBit (perm.getD k 0)
      · rfl
      · simp only [if_true]
        rw [Nat.testBit_or, Nat.one_shiftLeft, Nat.testBit_two_pow]
        simp [Ne.symm hjk]

theorem testBit_permCode (perm : Array ℕ) (n x j : ℕ) :
    (permCode perm n x).testBit j = (decide (j < n) && x.testBit (perm.getD j 0)) := by
  unfold permCode
  rw [permCodeAux_spec perm n x n 0 0 (by omega) (by simp)]
  simp

/-- The code of a relabeled vector. -/
theorem toCode_relabel {n : ℕ} (perm : Array ℕ) (σ : Equiv.Perm (Fin n))
    (hσ : ∀ k : Fin n, (σ k : ℕ) = perm.getD k 0) (v : Vec n) :
    toCode (relabel σ v) = permCode perm n (toCode v) := by
  apply toCode_eq_of_testBit
  intro j
  rw [testBit_permCode]
  split_ifs with hj
  · simp only [hj, decide_true, Bool.true_and, relabel]
    rw [← hσ ⟨j, hj⟩, toCode_apply]
  · simp [hj]

theorem toCode_add_toCode_inv : ∀ {w : ℕ} (v : Vec w), toCode v + toCode (inv v) = 2 ^ w - 1
  | 0, _ => by simp [toCode]
  | w + 1, v => by
    have ih : toCode (fun k : Fin w => v k.succ) + toCode (fun k : Fin w => !v k.succ) = 2 ^ w - 1 :=
      toCode_add_toCode_inv (fun k : Fin w => v k.succ)
    have hpos : 1 ≤ 2 ^ w := Nat.one_le_two_pow
    simp only [toCode, inv]
    rw [pow_succ]
    rcases Bool.eq_false_or_eq_true (v 0) with h | h <;> simp [h] <;> omega

/-- The code of an inverted vector. -/
theorem toCode_inv {w : ℕ} (v : Vec w) : toCode (inv v) = invCode w (toCode v) := by
  have := toCode_add_toCode_inv v
  unfold invCode
  omega

theorem popc_eq_wt (n x : ℕ) : popc n x = wt (ofCode n x) := by
  unfold popc wt ofCode
  rw [sumLt_eq, Finset.card_filter, ← Fin.sum_univ_eq_sum_range (fun i => if x.testBit i then 1 else 0)]

theorem testBit_insBit (a : ℕ) (t : Bool) (y j : ℕ) :
    (insBit a t y).testBit j =
      if j < a then y.testBit j else if j = a then t else y.testBit (j - 1) := by
  unfold insBit
  rw [Nat.testBit_or, Nat.testBit_or, Nat.testBit_and, Nat.testBit_two_pow_sub_one,
    Nat.testBit_shiftLeft, Nat.testBit_shiftRight]
  have hs : (if t = true then 1 <<< a else 0).testBit j = (t && decide (j = a)) := by
    split_ifs with ht
    · rw [Nat.one_shiftLeft, Nat.testBit_two_pow]; simp [ht, eq_comm]
    · simp [ht]
  rw [hs]
  by_cases h1 : j < a
  · simp [h1, show ¬ j ≥ a + 1 by omega, show j ≠ a by omega]
  · by_cases h2 : j = a
    · subst h2; simp
    · simp [h1, h2, show j ≥ a + 1 by omega, show a + (j - (a + 1)) = j - 1 by omega]

/-- The code of a vector with a value inserted at channel `i`. -/
theorem toCode_insertNth {n : ℕ} (i : Fin (n + 1)) (t : Bool) (y : Vec n) :
    toCode (Fin.insertNth i t y : Vec (n + 1)) = insBit i t (toCode y) := by
  apply toCode_eq_of_testBit
  intro j
  rw [testBit_insBit]
  split_ifs with h1 h2 h3 h4 h5
  · -- j < i
    have hjn : j < n := by have := i.isLt; omega
    have : (⟨j, h2⟩ : Fin (n + 1)) = i.succAbove ⟨j, hjn⟩ := by
      rw [Fin.succAbove_of_castSucc_lt]
      · rfl
      · simp [Fin.lt_def]; omega
    rw [this, Fin.insertNth_apply_succAbove]
    exact toCode_apply y ⟨j, hjn⟩
  · omega
  · -- j = i
    have : (⟨j, h4⟩ : Fin (n + 1)) = i := Fin.ext h3
    rw [this, Fin.insertNth_apply_same]
  · omega
  · -- j > i
    have hjn : j - 1 < n := by omega
    have : (⟨j, h5⟩ : Fin (n + 1)) = i.succAbove ⟨j - 1, hjn⟩ := by
      rw [Fin.succAbove_of_lt_succ]
      · ext; simp; omega
      · simp [Fin.lt_def]; omega
    rw [this, Fin.insertNth_apply_succAbove]
    exact toCode_apply y ⟨j - 1, hjn⟩
  · exact testBit_toCode_ge y (by omega)

/-- Exchanging two channels with different values flips both bits of the code. -/
theorem toCode_relabel_swap {w : ℕ} (v : Vec w) {lo hi : Fin w} (hne : lo ≠ hi)
    (hv : v lo ≠ v hi) : toCode (relabel (Equiv.swap lo hi) v) = swapDown lo hi (toCode v) := by
  apply toCode_eq_of_testBit
  intro j
  unfold swapDown
  rw [Nat.testBit_xor, Nat.testBit_or, Nat.one_shiftLeft, Nat.one_shiftLeft, Nat.testBit_two_pow,
    Nat.testBit_two_pow, testBit_toCode]
  split_ifs with hj
  · simp only [relabel]
    set k : Fin w := ⟨j, hj⟩ with hk
    by_cases h1 : k = lo
    · rw [h1, Equiv.swap_apply_left]
      have hjl : (lo : ℕ) = j := by rw [← h1]
      have hjh : (hi : ℕ) ≠ j := by
        intro h; apply hne; ext; omega
      simp only [hjl, decide_true, hjh, decide_false, Bool.or_false]
      cases h : v lo <;> cases h' : v hi <;> simp_all
    · by_cases h2 : k = hi
      · rw [h2, Equiv.swap_apply_right]
        have hjh : (hi : ℕ) = j := by rw [← h2]
        have hjl : (lo : ℕ) ≠ j := by
          intro h; apply hne; ext; omega
        simp only [hjh, decide_true, hjl, decide_false, Bool.false_or]
        cases h : v lo <;> cases h' : v hi <;> simp_all
      · rw [Equiv.swap_apply_of_ne_of_ne h1 h2]
        have hjl : (lo : ℕ) ≠ j := fun h => h1 (Fin.ext (by simp [hk, h]))
        have hjh : (hi : ℕ) ≠ j := fun h => h2 (Fin.ext (by simp [hk, h]))
        simp [hjl, hjh]
  · have hl : (lo : ℕ) ≠ j := by have := lo.isLt; omega
    have hh : (hi : ℕ) ≠ j := by have := hi.isLt; omega
    simp [hl, hh]

/-! ## Sets given by membership of codes -/

/-- The set of vectors whose codes satisfy `mem`. -/
def setOf (w : ℕ) (mem : ℕ → Bool) : Set (Vec w) := {v | mem (toCode v) = true}

/-- The image of a set under a comparator, in terms of codes. -/
theorem mem_cmp_image_iff {w : ℕ} (mem : ℕ → Bool) {lo hi : Fin w} (hne : lo ≠ hi) (v : Vec w) :
    v ∈ cmp (lo, hi) '' setOf w mem ↔ memCmp mem lo hi (toCode v) = true := by
  have hlo := toCode_apply v lo
  have hhi := toCode_apply v hi
  unfold memCmp
  simp only [hlo, hhi]
  constructor
  · rintro ⟨u, hu, rfl⟩
    simp only [setOf, Set.mem_ofPred_eq] at hu
    have e1 : ZO.cmp (lo, hi) u lo = (u lo && u hi) := by simp [ZO.cmp]
    have e2 : ZO.cmp (lo, hi) u hi = (u lo || u hi) := by simp [ZO.cmp, Ne.symm hne]
    rw [e1, e2]
    cases hul : u lo <;> cases huh : u hi
    · -- unchanged
      have : cmp (lo, hi) u = u := by
        funext k; simp only [ZO.cmp]; split_ifs with h1 h2
        · subst h1; simp [hul, huh]
        · subst h2; simp [hul, huh]
        · rfl
      simp [this, hu]
    · have : cmp (lo, hi) u = u := cmp_of_hi_true huh
      simp [this, hu]
    · -- swapped
      have hsw : cmp (lo, hi) u = relabel (Equiv.swap lo hi) u := cmp_of_lo_true hul
      have hback : relabel (Equiv.swap lo hi) (cmp (lo, hi) u) = u := by
        rw [hsw]; funext k; simp [relabel]
      have hne' : cmp (lo, hi) u lo ≠ cmp (lo, hi) u hi := by rw [e1, e2]; simp [hul, huh]
      have hcode := toCode_relabel_swap (cmp (lo, hi) u) hne hne'
      rw [hback] at hcode
      simp [← hcode, hu]
    · have : cmp (lo, hi) u = u := cmp_of_hi_true huh
      simp [this, hu]
  · intro h
    cases hvl : v lo <;> cases hvh : v hi <;> simp only [hvl, hvh] at h <;> simp at h
    · -- both false: unchanged
      refine ⟨v, h, ?_⟩
      funext k; simp only [ZO.cmp]; split_ifs with h1 h2
      · subst h1; simp [hvl, hvh]
      · subst h2; simp [hvl, hvh]
      · rfl
    · -- lo false, hi true
      rcases h with h | h
      · exact ⟨v, h, cmp_of_hi_true hvh⟩
      · refine ⟨relabel (Equiv.swap lo hi) v, ?_, ?_⟩
        · simp only [setOf, Set.mem_ofPred_eq]
          rw [toCode_relabel_swap v hne (by simp [hvl, hvh])]; exact h
        · have hu : relabel (Equiv.swap lo hi) v lo = true := by
            simp [relabel, Equiv.swap_apply_left, hvh]
          rw [cmp_of_lo_true hu]; funext k; simp [relabel]
    · -- both true: unchanged
      exact ⟨v, h, cmp_of_hi_true hvh⟩

/-- Deleting a channel after restricting it to the value `t`, in terms of codes. -/
theorem mem_del_restrict_iff {n : ℕ} (mem : ℕ → Bool) (i : Fin (n + 1)) (t : Bool) (y : Vec n) :
    y ∈ del i '' {v | v ∈ setOf (n + 1) mem ∧ v i = t} ↔ mem (insBit i t (toCode y)) = true := by
  rw [← toCode_insertNth]
  constructor
  · rintro ⟨v, ⟨hv, hvi⟩, rfl⟩
    have : (Fin.insertNth i t (del i v) : Vec (n + 1)) = v := by
      rw [← hvi]; exact Fin.insertNth_self_removeNth i v
    rw [this]; exact hv
  · intro h
    refine ⟨Fin.insertNth i t y, ⟨h, Fin.insertNth_apply_same (α := fun _ => Bool) i t y⟩, ?_⟩
    funext k; simp [del, Fin.insertNth_apply_succAbove]

/-! ## Enumerating a bitmap -/

theorem mem_bitsInto (c base lim : ℕ) : ∀ (j : ℕ) (acc : List ℕ) (x : ℕ),
    x ∈ bitsInto c base lim j acc ↔ x ∈ acc ∨ (∃ i < j, x = base + i ∧ c.testBit i = true ∧ x < lim)
  | 0, acc, x => by simp [bitsInto]
  | j + 1, acc, x => by
    rw [bitsInto, mem_bitsInto c base lim j]
    constructor
    · rintro (h | ⟨i, hi, rfl, hb, hl⟩)
      · split_ifs at h with hc
        · rcases List.mem_cons.1 h with rfl | h
          · simp only [Bool.and_eq_true, decide_eq_true_eq] at hc
            exact Or.inr ⟨j, by omega, rfl, hc.1, hc.2⟩
          · exact Or.inl h
        · exact Or.inl h
      · exact Or.inr ⟨i, by omega, rfl, hb, hl⟩
    · rintro (h | ⟨i, hi, rfl, hb, hl⟩)
      · left; split_ifs <;> simp [h]
      · rcases Nat.lt_succ_iff_lt_or_eq.1 hi with hi' | rfl
        · exact Or.inr ⟨i, hi', rfl, hb, hl⟩
        · left; simp [hb, hl]

theorem mem_elemsLoop (byte : ℕ → ℕ) (off lim : ℕ) : ∀ (k : ℕ) (acc : List ℕ) (x : ℕ),
    x ∈ elemsLoop byte off lim k acc ↔ x ∈ acc ∨ (x < 7 * k ∧ x < lim ∧ memBit byte off x = true)
  | 0, acc, x => by simp [elemsLoop]
  | k + 1, acc, x => by
    rw [elemsLoop, mem_elemsLoop byte off lim k]
    have hdm : ∀ ci i, i < 7 → (7 * ci + i) / 7 = ci ∧ (7 * ci + i) % 7 = i := by
      intro ci i hi; constructor <;> omega
    constructor
    · rintro (h | ⟨h1, h2, h3⟩)
      · split_ifs at h with hc
        · exact Or.inl h
        · rcases (mem_bitsInto _ _ _ 7 acc x).1 h with h | ⟨i, hi, rfl, hb, hl⟩
          · exact Or.inl h
          · right
            refine ⟨by omega, hl, ?_⟩
            unfold memBit
            rw [(hdm k i hi).1, (hdm k i hi).2]; exact hb
      · exact Or.inr ⟨by omega, h2, h3⟩
    · rintro (h | ⟨h1, h2, h3⟩)
      · left; split_ifs
        · exact h
        · exact (mem_bitsInto _ _ _ 7 acc x).2 (Or.inl h)
      · by_cases hx : x < 7 * k
        · exact Or.inr ⟨hx, h2, h3⟩
        · left
          have hq : x / 7 = k := by omega
          unfold memBit at h3
          rw [hq] at h3
          split_ifs with hc
          · simp only [beq_iff_eq] at hc; rw [hc] at h3; simp at h3
          · exact (mem_bitsInto _ _ _ 7 acc x).2
              (Or.inr ⟨x % 7, by omega, by omega, h3, h2⟩)

theorem mem_elemsOf (byte : ℕ → ℕ) (off w x : ℕ) :
    x ∈ elemsOf byte off w ↔ x < 2 ^ w ∧ memBit byte off x = true := by
  unfold elemsOf
  rw [mem_elemsLoop]
  simp only [List.not_mem_nil, false_or]
  constructor
  · rintro ⟨-, h2, h3⟩; exact ⟨h2, h3⟩
  · rintro ⟨h2, h3⟩; exact ⟨by unfold bmLen; omega, h2, h3⟩

/-! ## Collisions -/

theorem collision_sound {n : ℕ} {mem : ℕ → Bool} {cands : Unit → List ℕ}
    (h : collision n mem cands = true) :
    ∃ u v : Vec n, u ≠ v ∧ u ∈ setOf n mem ∧ v ∈ setOf n mem ∧ wt u = wt v := by
  unfold collision at h
  split at h
  · rename_i x y _
    simp only [Bool.and_eq_true, decide_eq_true_eq, bne_iff_ne, ne_eq, beq_iff_eq] at h
    obtain ⟨⟨⟨⟨⟨hx, hy⟩, hxy⟩, hmx⟩, hmy⟩, hp⟩ := h
    refine ⟨ofCode n x, ofCode n y, fun he => hxy ?_, ?_, ?_, ?_⟩
    · have := congrArg toCode he; rwa [toCode_ofCode hx, toCode_ofCode hy] at this
    · simp [setOf, toCode_ofCode hx, hmx]
    · simp [setOf, toCode_ofCode hy, hmy]
    · rw [← popc_eq_wt, ← popc_eq_wt, hp]
  · simp at h

theorem not_works_nil_of_collision {n : ℕ} {mem : ℕ → Bool} {cands : Unit → List ℕ}
    (h : collision n mem cands = true) : ¬ Works [] (setOf n mem) := by
  obtain ⟨u, v, huv, hu, hv, hwt⟩ := collision_sound h
  intro hw
  exact huv (by simpa using hw u hu v hv (by simpa using hwt))

theorem LB_one_of_collision {n : ℕ} {mem : ℕ → Bool} {cands : Unit → List ℕ}
    (h : collision n mem cands = true) : LB (setOf n mem) 1 := by
  obtain ⟨u, v, huv, hu, hv, hwt⟩ := collision_sound h
  exact LB.one_of_collision hu hv huv hwt

end Sortnet.S11
