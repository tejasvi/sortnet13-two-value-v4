import S13.FState

/-!
# Soundness of the concrete check

`den n s` is the f-state denoted by a concrete state `s`. The concrete operations of `S13.Comp`
compute the abstract ones (`den_stepC`, `den_pullC`, `phiC_eq`), and `checkAll_sound` turns a
successful `Comp.checkAll` into the hypotheses of `closure_sound`.
-/

namespace Sortnet

open _root_.Sortnet.Comp Finset

/-- Decode an entry: `0` means no run, `e + 1` means cost `e`. -/
def dec : ℕ → Option ℕ
  | 0 => none
  | e + 1 => some e

/-- The f-state denoted by a concrete state. -/
def den (n : ℕ) (s : CState) : FState n := fun p q => dec (get n s p q)

/-- The start f-state: one run at every pair of distinct channels, no comparator met yet. -/
def f0 (n : ℕ) : FState n := fun p q => if p = q then none else some 0

theorem getD_ofFn {α : Type*} {m : ℕ} (g : Fin m → α) (i : ℕ) (d : α) :
    (Array.ofFn g).getD i d = if h : i < m then g ⟨i, h⟩ else d := by
  unfold Array.getD
  split_ifs with h1 h2 h2
  · simp
  · simp at h1; omega
  · simp at h1; omega
  · rfl

theorem index_lt {n : ℕ} (p q : Fin n) : p.val * n + q.val < n * n := by
  have hp := p.isLt; have hq := q.isLt
  calc p.val * n + q.val < p.val * n + n := by omega
    _ = (p.val + 1) * n := by ring
    _ ≤ n * n := Nat.mul_le_mul_right _ hp

theorem index_div {n : ℕ} (p q : Fin n) : (p.val * n + q.val) / n = p.val := by
  have hq := q.isLt
  rw [Nat.add_comm, Nat.add_mul_div_right _ _ (by omega), Nat.div_eq_of_lt hq, zero_add]

theorem index_mod {n : ℕ} (p q : Fin n) : (p.val * n + q.val) % n = q.val := by
  rw [Nat.add_comm, Nat.add_mul_mod_self_right, Nat.mod_eq_of_lt q.isLt]

theorem get_ofFn {n : ℕ} (g : Fin (n * n) → ℕ) (p q : Fin n) :
    get n (Array.ofFn g) p q = g ⟨p.val * n + q.val, index_lt p q⟩ := by
  simp [Comp.get, index_lt p q]

theorem dec_cinc_max (e1 e2 : ℕ) : dec (cinc (max e1 e2)) = oinc (omax (dec e1) (dec e2)) := by
  rcases e1 with _ | e1 <;> rcases e2 with _ | e2 <;>
    simp [dec, cinc, oinc, omax, Nat.succ_max_succ]

theorem den_stepC (n : ℕ) (a b : Fin n) (s : CState) :
    den n (stepC n a.val b.val s) = fstep a b (den n s) := by
  funext p q
  simp only [den, stepC, get_ofFn, index_div, index_mod, entry, fstep, Fin.val_inj]
  split_ifs <;> first | rfl | exact dec_cinc_max _ _

/-- The relabeling named by an array whose first `n` entries are below `n`. -/
def permFun (n : ℕ) (σ : Array ℕ) (h : ∀ i < n, σ.getD i 0 < n) : Fin n → Fin n :=
  fun p => ⟨σ.getD p.val 0, h p.val p.isLt⟩

theorem den_pullC (n : ℕ) (σ : Array ℕ) (h : ∀ i < n, σ.getD i 0 < n) (s : CState) :
    den n (pullC n σ s) = pull (permFun n σ h) (den n s) := by
  funext p q
  simp only [den, pullC, get_ofFn, index_div, index_mod, pull, permFun]

theorem validPerm_sound {n : ℕ} {σ : Array ℕ} (hv : validPerm n σ = true) :
    ∃ h : ∀ i < n, σ.getD i 0 < n, Function.Injective (permFun n σ h) := by
  simp only [validPerm, Bool.and_eq_true, beq_iff_eq, List.all_eq_true, List.mem_range,
    decide_eq_true_eq, Bool.or_eq_true, bne_iff_ne, ne_eq] at hv
  obtain ⟨⟨-, hlt⟩, hinj⟩ := hv
  refine ⟨hlt, fun p q hpq => ?_⟩
  simp only [permFun, Fin.mk.injEq] at hpq
  rcases hinj p.val p.isLt q.val q.isLt with h | h
  · exact Fin.ext h
  · exact absurd hpq h

theorem sumTo_eq (g : ℕ → ℕ) (k : ℕ) : sumTo g k = ∑ i ∈ range k, g i := by
  induction k with
  | zero => rfl
  | succ k ih => rw [sumTo, ih, sum_range_succ]

theorem cwt_eq (e : ℕ) : cwt e = wt (dec e) := by
  rcases e with _ | e <;> simp [cwt, wt, dec]

theorem rowSumC_eq (n : ℕ) (s : CState) (p : Fin n) : rowSumC n s p.val = rowSum (den n s) p := by
  rw [rowSumC, sumTo_eq, ← Fin.sum_univ_eq_sum_range]
  apply sum_congr rfl
  intro q _
  simp only [Fin.val_inj, cwt_eq, den]

theorem phiC_eq (n : ℕ) (s : CState) : phiC n s = Phi (den n s) := by
  rw [phiC, sumTo_eq, ← Fin.sum_univ_eq_sum_range (fun p => R (rowSumC n s p))]
  apply sum_congr rfl
  intro p _
  rw [rowSumC_eq]

theorem twoEntries_sound {n L : ℕ} {s : CState} (h : twoEntries n s = true) :
    ¬ Good L (den n s) := by
  simp only [twoEntries, List.any_eq_true, List.mem_range, Bool.and_eq_true, bne_iff_ne,
    ne_eq] at h
  obtain ⟨i, hi, hsi, j, hj, hsj⟩ := h
  rintro ⟨oM, om, hg⟩
  have hn : 0 < n := by
    rcases Nat.eq_zero_or_pos n with h0 | h0
    · simp [h0] at hi
    · exact h0
  have key : ∀ k, k < n * n → s.getD k 0 ≠ 0 → k / n = oM.val ∧ k % n = om.val := by
    intro k hk hsk
    have hdiv : k / n < n := (Nat.div_lt_iff_lt_mul hn).2 hk
    have hmod : k % n < n := Nat.mod_lt _ hn
    have hget : get n s (⟨k / n, hdiv⟩ : Fin n) (⟨k % n, hmod⟩ : Fin n) = s.getD k 0 := by
      simp only [Comp.get]; rw [Nat.div_add_mod']
    obtain ⟨e, he⟩ := Nat.exists_eq_succ_of_ne_zero hsk
    have hd : den n s ⟨k / n, hdiv⟩ ⟨k % n, hmod⟩ = some e := by
      simp only [den, hget, he, dec]
    obtain ⟨h1, h2, -⟩ := hg _ _ e hd
    exact ⟨congrArg Fin.val h1, congrArg Fin.val h2⟩
  obtain ⟨hi1, hi2⟩ := key i hi hsi
  obtain ⟨hj1, hj2⟩ := key j (by omega) hsj
  have : i = j := by
    rw [← Nat.div_add_mod i n, ← Nat.div_add_mod j n, hi1, hi2, hj1, hj2]
  omega

theorem allPairs_sound {n : ℕ} {g : ℕ → ℕ → Bool} (h : allPairs n g = true) (a b : Fin n)
    (hab : a < b) : g a.val b.val = true := by
  simp only [allPairs, List.all_eq_true, List.mem_range, Bool.or_eq_true, Bool.not_eq_true',
    decide_eq_false_iff_not] at h
  rcases h a.val a.isLt b.val b.isLt with h1 | h1
  · exact absurd hab h1
  · exact h1

/-- **Soundness of the check.** If `checkAll n L S` succeeds, no state of `S` is feasible. -/
theorem checkAll_sound (n L : ℕ) (S : Array CState) (h : checkAll n L S = true) :
    ∀ s ∈ S, ¬ Feasible L (den n s) := by
  intro s hs
  apply closure_sound L (fun k => ∃ s ∈ S, den n s = k) _ _ _ ⟨s, hs, rfl⟩
  · rintro k ⟨s, hs, rfl⟩
    simp only [checkAll, Array.all_eq_true_iff_forall_mem] at h
    have hc := h s hs
    simp only [checkState, Bool.and_eq_true] at hc
    exact twoEntries_sound hc.1
  · rintro k ⟨s, hs, rfl⟩ a b hab
    simp only [checkAll, Array.all_eq_true_iff_forall_mem] at h
    have hc := h s hs
    simp only [checkState, Bool.and_eq_true] at hc
    have hg := allPairs_sound hc.2 a b hab
    simp only [Bool.or_eq_true, beq_iff_eq, decide_eq_true_eq, Bool.and_eq_true] at hg
    rw [← den_stepC]
    rcases hg with (he | hphi) | ⟨hv, hmem⟩
    · left; rw [he]
    · right; left; rwa [← phiC_eq]
    · right; right
      obtain ⟨hlt, hinj⟩ := validPerm_sound hv
      refine ⟨permFun n _ hlt, hinj, _, ?_, (den_pullC n _ hlt _)⟩
      rw [Std.HashSet.contains_ofList, List.contains_iff_mem] at hmem
      exact Array.mem_toList_iff.1 hmem

theorem den_initC (n : ℕ) : den n (initC n) = f0 n := by
  funext p q
  simp only [den, initC, get_ofFn, index_div, index_mod, f0, Fin.val_inj]
  split_ifs <;> rfl

/-- **The computation decides `¬ Feasible`.** -/
theorem not_feasible_of_fullCheck {n L : ℕ} (h : fullCheck n L = true) : ¬ Feasible L (f0 n) := by
  simp only [fullCheck, Bool.and_eq_true, Array.contains_iff_mem] at h
  rw [← den_initC]
  exact checkAll_sound n L _ h.2 _ h.1

end Sortnet
