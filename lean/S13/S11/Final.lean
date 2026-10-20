import S13.S11.Sound
import S13.Defs

/-!
# From a checked certificate to `S(11) ≥ 35`

`certOK_sound`: if `certOK c count chunk w b` holds, every network that works on all `2^w` vectors of
width `w` has at least `b` comparators. `sorts_bound_of_LB`: such a bound applies to every standard
sorting network (`Network.Sorts`, on inputs of natural numbers).
-/

namespace Sortnet.S11

open ZO

theorem rangeAll_spec (f : ℕ → Bool) (b : ℕ) : ∀ fuel a, rangeAll f b fuel a = true →
    ∀ i, a ≤ i → i < a + fuel → i < b → f i = true
  | 0, a, _, i, h1, h2, _ => by omega
  | fuel + 1, a, h, i, h1, h2, h3 => by
    unfold rangeAll at h
    split_ifs at h with hab
    · rw [Bool.and_eq_true] at h
      rcases Nat.eq_or_lt_of_le h1 with rfl | h1'
      · exact h.1
      · exact rangeAll_spec f b fuel (a + 1) h.2 i h1' (by omega) h3
    · omega

theorem parAll_spec {count chunk : ℕ} {f : ℕ → Bool} (h : parAll count chunk f = true) :
    ∀ i < count, f i = true := by
  intro i hi
  unfold parAll at h
  rw [List.all_map, List.all_eq_true] at h
  set ch := max chunk 1 with hch
  have hpos : 0 < ch := by omega
  have hcount : count ≤ (count + ch - 1) / ch * ch := by
    have h1 := Nat.div_add_mod (count + ch - 1) ch
    have h2 := Nat.mod_lt (count + ch - 1) hpos
    have h3 : ch * ((count + ch - 1) / ch) = (count + ch - 1) / ch * ch := Nat.mul_comm _ _
    omega
  have hk : i / ch < (count + ch - 1) / ch := (Nat.div_lt_iff_lt_mul hpos).2 (by omega)
  have hrange := h (i / ch) (List.mem_range.2 hk)
  simp only [Function.comp] at hrange
  have hdm := Nat.div_add_mod i ch
  have himod := Nat.mod_lt i hpos
  have hmul : i / ch * ch = ch * (i / ch) := Nat.mul_comm _ _
  exact rangeAll_spec f count ch (i / ch * ch) hrange i (by omega) (by omega) hi

/-- **A checked certificate gives a lower bound.** -/
theorem certOK_sound {c : Cert} {count chunk w b : ℕ} (h : certOK c count chunk w b = true) :
    LB (Set.univ : Set (Vec w)) b := by
  unfold certOK at h
  simp only [Bool.and_eq_true, decide_eq_true_eq, beq_iff_eq, allLt_iff] at h
  obtain ⟨⟨⟨⟨hcount, hW⟩, hB⟩, hall⟩, hpar⟩ := h
  have hclaim := c.claims_of_check (parAll_spec hpar) (count - 1) (by omega)
  unfold Cert.Claim at hclaim
  rw [hW, hB] at hclaim
  apply hclaim.mono
  exact Set.subset_univ _

/-! ## From 0-1 vectors to sorting networks -/

/-- The 0-1 vector as natural numbers. -/
def toNatVec {n : ℕ} (v : Vec n) : Fin n → ℕ := fun k => if v k then 1 else 0

theorem apply_toNatVec {n : ℕ} (c : Comparator n) (v : Vec n) :
    c.apply (toNatVec v) = toNatVec (ZO.cmp (c.i, c.j) v) := by
  funext k
  have hij : c.i ≠ c.j := Fin.ne_of_lt c.lt
  simp only [Comparator.apply, toNatVec, ZO.cmp]
  split_ifs with h1 h2 <;> first
    | (cases v c.i <;> cases v c.j <;> simp_all)
    | rfl

theorem eval_toNatVec {n : ℕ} (net : Network n) (v : Vec n) :
    net.eval (toNatVec v) = toNatVec (run (net.map fun c => (c.i, c.j)) v) := by
  induction net generalizing v with
  | nil => rfl
  | cons c net ih =>
    show Network.eval net (c.apply (toNatVec v)) = _
    rw [apply_toNatVec, ih]
    rfl

/-- Two nondecreasing 0-1 vectors with the same weight are equal. -/
theorem eq_of_mono_of_wt {n : ℕ} {x y : Vec n} (hx : ∀ a b : Fin n, a ≤ b → x a = true → x b = true)
    (hy : ∀ a b : Fin n, a ≤ b → y a = true → y b = true) (hw : wt x = wt y) : x = y := by
  by_contra hne
  obtain ⟨k, hk⟩ : ∃ k, x k ≠ y k := by
    by_contra h; push Not at h; exact hne (funext h)
  -- the vector that is `true` at `k` has more `true` entries
  have key : ∀ u v : Vec n, (∀ a b : Fin n, a ≤ b → u a = true → u b = true) →
      (∀ a b : Fin n, a ≤ b → v a = true → v b = true) → u k = true → v k = false → wt v < wt u := by
    intro u v hu hv huk hvk
    unfold wt
    have h1 : (Finset.univ.filter fun j => v j = true) ⊆ Finset.univ.filter fun j => k < j := by
      intro j hj
      simp only [Finset.mem_filter, Finset.mem_univ, true_and] at hj ⊢
      by_contra hjk; push Not at hjk
      have := hv j k hjk hj
      rw [hvk] at this; exact Bool.false_ne_true this
    have h2 : (Finset.univ.filter fun j => k ≤ j) ⊆ Finset.univ.filter fun j => u j = true := by
      intro j hj
      simp only [Finset.mem_filter, Finset.mem_univ, true_and] at hj ⊢
      exact hu k j hj huk
    have h3 : (Finset.univ.filter fun j : Fin n => k ≤ j) =
        insert k (Finset.univ.filter fun j => k < j) := by
      ext j; simp only [Finset.mem_filter, Finset.mem_univ, true_and, Finset.mem_insert]
      constructor
      · intro h; rcases eq_or_lt_of_le h with h | h
        · left; exact h.symm
        · right; exact h
      · rintro (rfl | h); exact le_refl _; exact le_of_lt h
    have h4 : (Finset.univ.filter fun j : Fin n => k ≤ j).card =
        (Finset.univ.filter fun j => k < j).card + 1 := by
      rw [h3, Finset.card_insert_of_notMem]; simp
    have := Finset.card_le_card h1
    have := Finset.card_le_card h2
    omega
  cases hxk : x k <;> cases hyk : y k <;> simp_all
  · have := key y x hy hx hyk hxk; omega
  · have := key x y hx hy hxk hyk; omega

/-- **From the 0-1 bound to sorting networks.** -/
theorem sorts_bound_of_LB {n b : ℕ} (h : LB (Set.univ : Set (Vec n)) b) :
    ∀ net : Network n, net.Sorts → b ≤ net.length := by
  intro net hs
  have hw : Works (net.map fun c => (c.i, c.j)) Set.univ := by
    intro u _ v _ huv
    have hmono : ∀ x : Vec n, ∀ a b : Fin n, a ≤ b →
        run (net.map fun c => (c.i, c.j)) x a = true → run (net.map fun c => (c.i, c.j)) x b = true := by
      intro x a b hab hxa
      have := hs (toNatVec x) a b hab
      rw [eval_toNatVec] at this
      simp only [toNatVec, hxa, if_true] at this
      by_contra hxb
      simp only [Bool.not_eq_true] at hxb
      simp [hxb] at this
    exact eq_of_mono_of_wt (hmono u) (hmono v) huv
  simpa using h _ hw

end Sortnet.S11
