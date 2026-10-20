import S13Kernel.Check
import S13.CheckSound

/-!
# Soundness of the kernel-friendly check

The functions of `S13Kernel.Check` compute the objects of `S13.FState`: `entryF` computes `fstep`,
`phiInc` is a lower bound for the Kraft potential `Phi` of a child, `isoK` decides an equality with a
relabeled state, and `cntK` excludes goals. `not_feasible_of_cover` turns a successful check of all
keys into `¬ Feasible 8 (f0 13)` through `Sortnet.closure_sound`.
-/

namespace S13K

open Sortnet Sortnet.Comp Finset

/-! ## The bare-recursor encodings -/

theorem cincB_eq (e : Nat) : cincB e = cinc e := by
  by_cases h : e = 0 <;> simp [cincB, cinc, selN_eq, Nat.beq_eq, h]

theorem maxB_eq (x y : Nat) : maxB x y = max x y := by
  simp only [maxB, selN_eq, Nat.ble_eq, Nat.max_def]

theorem entryF_eq (g : Nat → Nat → Nat) (a b p q : Nat) :
    entryF g a b p q =
      if p = b then
        (if q = a then cinc (max (g a b) (g b a))
         else if q = b then 0 else cinc (max (g a q) (g b q)))
      else if p = a then 0
      else if q = a then 0
      else if q = b then cinc (max (g p a) (g p b))
      else g p q := by
  simp only [entryF, selN_eq, Nat.beq_eq, cincB_eq, maxB_eq]

/-- The f-state on 13 channels with entries `g`. -/
def denF (g : Nat → Nat → Nat) : FState 13 := fun p q => dec (g p.val q.val)

/-- The f-state of a key. -/
noncomputable def den13 (K : Nat) : FState 13 := denF (ent K)

theorem denF_entryF (g : Nat → Nat → Nat) (a b : Fin 13) :
    denF (entryF g a.val b.val) = fstep a b (denF g) := by
  funext p q
  simp only [denF, entryF_eq, fstep, Fin.val_inj]
  split_ifs <;> first | rfl | exact dec_cinc_max _ _

/-! ## The Kraft potential -/

theorem sumBelow_eq (g : Nat → Nat) (k : Nat) : sumBelow g k = ∑ i ∈ range k, g i := by
  induction k with
  | zero => rfl
  | succ k ih => rw [sumBelow_succ, ih, sum_range_succ]

theorem wK_eq' (K p q : Nat) : wK K p q = cwt (ent K p q) := by
  simp only [wK, cwt, selN_eq, Nat.beq_eq, Nat.pow_eq, Nat.sub_eq]

theorem wK_eq (K : Nat) (p q : Fin 13) : wK K p q = wt (den13 K p q) := by
  simp only [wK_eq', den13, denF, cwt_eq]

theorem rsK_eq (K : Nat) (p : Fin 13) : rsK K p.val = rowSum (den13 K) p := by
  rw [rsK, sumBelow_eq,
    ← Fin.sum_univ_eq_sum_range (fun q => selN (Nat.beq q p.val) 0 (wK K p q))]
  apply sum_congr rfl
  intro q _
  simp only [selN_eq, Nat.beq_eq, Fin.val_inj, wK_eq]

/-- If `s` exceeds `2 ^ j`, then `R s` is at least `2 ^ (j + 1)`. -/
theorem pow_succ_le_R {s j : Nat} (h : 2 ^ j < s) : 2 ^ (j + 1) ≤ R s := by
  have hs : s ≠ 0 := Nat.ne_of_gt (lt_of_le_of_lt (Nat.zero_le _) h)
  have hR := R_of_ne_zero hs
  have hle := le_R s
  rw [hR] at hle ⊢
  apply Nat.pow_le_pow_right (by omega)
  by_contra hk
  have : 2 ^ Nat.log2 (2 * s - 1) ≤ 2 ^ j := Nat.pow_le_pow_right (by omega) (by omega)
  omega

theorem npow_le_R (s : Nat) : npow s ≤ R s := by
  simp only [npow, selN_eq, Nat.ble_eq]
  split_ifs
  · exact le_R s
  · exact pow_succ_le_R (j := 1) (by omega)
  · exact pow_succ_le_R (j := 2) (by omega)
  · exact pow_succ_le_R (j := 3) (by omega)
  · exact pow_succ_le_R (j := 4) (by omega)
  · exact pow_succ_le_R (j := 5) (by omega)
  · exact pow_succ_le_R (j := 6) (by omega)
  · exact pow_succ_le_R (j := 7) (by omega)
  · exact pow_succ_le_R (j := 8) (by omega)

/-- Row `p ∉ {a, b}` of a child: the entries `(p, a)` and `(p, b)` merge into `(p, b)`. -/
theorem rowSum_fstep_other_eq (f : FState 13) {a b p : Fin 13} (hab : a ≠ b) (hpa : p ≠ a)
    (hpb : p ≠ b) :
    rowSum (fstep a b f) p + (wt (f p a) + wt (f p b)) =
      rowSum f p + 2 * max (wt (f p a)) (wt (f p b)) := by
  unfold rowSum
  rw [sum_split_two (fun q => if q = p then 0 else wt (f p q)) hab,
    sum_split_two (fun q => if q = p then 0 else wt (fstep a b f p q)) hab]
  have e1 : (if a = p then 0 else wt (fstep a b f p a)) = 0 := by
    simp [fstep, hpa, hpb, wt]
  have e2 : (if b = p then 0 else wt (fstep a b f p b)) = 2 * max (wt (f p a)) (wt (f p b)) := by
    simp [fstep, hpa, hpb, hab.symm, Ne.symm hpb, wt_oinc_omax]
  have e3 : ∑ q ∈ (univ.erase a).erase b, (if q = p then 0 else wt (fstep a b f p q)) =
      ∑ q ∈ (univ.erase a).erase b, (if q = p then 0 else wt (f p q)) := by
    apply sum_congr rfl
    intro q hq
    obtain ⟨hqa, hqb⟩ := mem_rest hq
    by_cases hqp : q = p
    · simp [hqp]
    · simp [hqp, fstep, hpa, hpb, hqa, hqb]
  rw [e1, e2, e3, ite_eq_right (Ne.symm hpa), ite_eq_right (Ne.symm hpb)]
  omega

theorem rowHi_eq (K : Nat) {a b : Fin 13} (hab : a ≠ b) :
    rowHi K a.val b.val = rowSum (fstep a b (den13 K)) b := by
  rw [rowSum_fstep_hi _ hab, rowHi, Nat.add_eq, Nat.mul_eq, maxB_eq, wK_eq, wK_eq, sumBelow_eq,
    ← Fin.sum_univ_eq_sum_range (fun q => selN (Nat.beq q a.val) 0
      (selN (Nat.beq q b.val) 0 (Nat.mul 2 (maxB (wK K a q) (wK K b q)))))]
  congr 1
  rw [sum_split_two _ hab]
  simp only [selN_eq, Nat.beq_eq, Fin.val_inj, hab, Ne.symm hab, ite_true, ite_false, zero_add]
  apply sum_congr rfl
  intro q hq
  obtain ⟨hqa, hqb⟩ := mem_rest hq
  simp [hqa, hqb, wK_eq, maxB_eq]

theorem rowOther_eq (K : Nat) {a b p : Fin 13} (hab : a ≠ b) (hpa : p ≠ a) (hpb : p ≠ b) :
    rowOther K a.val b.val p.val = rowSum (fstep a b (den13 K)) p := by
  have h := rowSum_fstep_other_eq (den13 K) hab hpa hpb
  rw [rowOther, Nat.sub_eq, Nat.add_eq, Nat.add_eq, Nat.mul_eq, maxB_eq, wK_eq, wK_eq, rsK_eq]
  omega

theorem phiInc_le (K : Nat) {a b : Fin 13} (hab : a ≠ b) :
    phiInc K a.val b.val ≤ Phi (fstep a b (den13 K)) := by
  rw [phiInc, sumBelow_eq, ← Fin.sum_univ_eq_sum_range (fun p => npow (selN (Nat.beq p a.val) 0
    (selN (Nat.beq p b.val) (rowHi K a b) (rowOther K a b p))))]
  unfold Phi
  apply sum_le_sum
  intro p _
  have hx : selN (Nat.beq p.val a.val) 0 (selN (Nat.beq p.val b.val) (rowHi K a b)
      (rowOther K a b p)) = rowSum (fstep a b (den13 K)) p := by
    simp only [selN_eq, Nat.beq_eq, Fin.val_inj]
    by_cases hpa : p = a
    · subst hpa
      simp [rowSum_fstep_lo _ hab]
    · by_cases hpb : p = b
      · subst hpb
        simp [hpa, rowHi_eq K hab]
      · simp [hpa, hpb, rowOther_eq K hab hpa hpb]
  rw [hx]
  exact npow_le_R _

/-! ## Comparators that meet no run -/

theorem untK_sound (g : Nat → Nat → Nat) (a b : Fin 13) (h : untK g a.val b.val = true) :
    fstep a b (denF g) = denF g := by
  rw [untK, allBelow_iff] at h
  have h' : ∀ q : Fin 13, g a q = 0 ∧ g b q = 0 ∧ g q a = 0 ∧ g q b = 0 := fun q => by
    have := h q.val q.isLt
    simpa only [andB_eq, Bool.and_eq_true, Nat.beq_eq, and_assoc] using this
  funext p q
  simp only [fstep, denF]
  split_ifs <;> subst_vars <;>
    simp [(h' _).1, (h' _).2.1, (h' _).2.2.1, (h' _).2.2.2, dec, oinc, omax]

/-! ## Relabelings -/

theorem validK_sound {sg tg : Nat} (h : validK sg tg = true) :
    (∀ p, p < 13 → sig sg p < 13) ∧ ∀ p q, p < 13 → q < 13 → sig sg p = sig sg q → p = q := by
  rw [validK, allBelow_iff] at h
  have h' : ∀ p, p < 13 → sig sg p < 13 ∧ sig tg (sig sg p) = p := fun p hp => by
    have := h p hp
    simpa only [andB_eq, Bool.and_eq_true, Nat.blt_eq, Nat.beq_eq] using this
  refine ⟨fun p hp => (h' p hp).1, fun p q hp hq hpq => ?_⟩
  rw [← (h' p hp).2, ← (h' q hq).2, hpq]

/-- The relabeling named by `sg`. -/
noncomputable def sigF (sg tg : Nat) (hv : validK sg tg = true) : Fin 13 → Fin 13 :=
  fun p => ⟨sig sg p.val, (validK_sound hv).1 p.val p.isLt⟩

theorem sigF_injective (sg tg : Nat) (hv : validK sg tg = true) :
    Function.Injective (sigF sg tg hv) := by
  intro p q hpq
  simp only [sigF, Fin.mk.injEq] at hpq
  exact Fin.ext ((validK_sound hv).2 p.val q.val p.isLt q.isLt hpq)

theorem isoK_sound (K' : Nat) (t : Nat → Nat → Nat) (sg tg : Nat) (hv : validK sg tg = true)
    (h : isoK K' t sg = true) : den13 K' = pull (sigF sg tg hv) (denF t) := by
  rw [isoK, allBelow_iff] at h
  funext p q
  have h1 := h p.val p.isLt
  rw [allBelow_iff] at h1
  have h2 := h1 q.val q.isLt
  rw [Nat.beq_eq] at h2
  simp only [den13, denF, pull, sigF, h2]

/-! ## Goals -/

theorem cntK_sound {L K : Nat} (h : 2 ≤ cntK K) : ¬ Good L (den13 K) := by
  rintro ⟨oM, om, hg⟩
  have hz : ∀ p q : Fin 13, (p ≠ oM ∨ q ≠ om) → ent K p q = 0 := by
    intro p q hpq
    by_contra hne
    obtain ⟨e, he⟩ := Nat.exists_eq_succ_of_ne_zero hne
    have hd : den13 K p q = some e := by simp only [den13, denF, he, dec]
    obtain ⟨h1, h2, -⟩ := hg p q e hd
    rcases hpq with hpq | hpq
    · exact hpq h1
    · exact hpq h2
  have hrow : ∀ p : Fin 13, sumBelow (fun q => selN (Nat.beq (ent K p q) 0) 0 1) 13 ≤
      if p = oM then 1 else 0 := by
    intro p
    rw [sumBelow_eq,
      ← Fin.sum_univ_eq_sum_range (fun q => selN (Nat.beq (ent K p q) 0) 0 1)]
    split_ifs with hp
    · subst hp
      rw [sum_eq_single om]
      · simp only [selN_eq]; split_ifs <;> omega
      · intro q _ hq
        simp [hz p q (Or.inr hq)]
      · simp
    · apply le_of_eq
      apply sum_eq_zero
      intro q _
      simp [hz p q (Or.inl hp)]
  have hsum : cntK K ≤ 1 := by
    rw [cntK, sumBelow_eq, ← Fin.sum_univ_eq_sum_range
      (fun p => sumBelow (fun q => selN (Nat.beq (ent K p q) 0) 0 1) 13)]
    calc ∑ p : Fin 13, sumBelow (fun q => selN (Nat.beq (ent K p q) 0) 0 1) 13
        ≤ ∑ p : Fin 13, (if p = oM then 1 else 0) := sum_le_sum fun p _ => hrow p
      _ = 1 := by simp
  omega

/-! ## The start state -/

theorem startK_sound {K : Nat} (h : startK K = true) : den13 K = f0 13 := by
  rw [startK, allBelow_iff] at h
  funext p q
  have h1 := h p.val p.isLt
  rw [allBelow_iff] at h1
  have h2 := h1 q.val q.isLt
  rw [Nat.beq_eq] at h2
  simp only [den13, denF, f0, h2, selN_eq, Nat.beq_eq, Fin.val_inj]
  split_ifs <;> rfl

/-! ## One state -/

theorem chkState_sound (S : KT) (N K : Nat) (ce : CertList) (h : chkState S N K ce = true) :
    ¬ Good 8 (den13 K) ∧ ∀ a b : Fin 13, a < b →
      fstep a b (den13 K) = den13 K ∨ 2 ^ 8 < Phi (fstep a b (den13 K)) ∨
        ∃ σ : Fin 13 → Fin 13, Function.Injective σ ∧
          ∃ j, j < N ∧ den13 (getK S j) = pull σ (fstep a b (den13 K)) := by
  rw [chkState, andB_eq, Bool.and_eq_true, Nat.ble_eq] at h
  refine ⟨cntK_sound h.1, fun a b hab => ?_⟩
  have hab' : a.val < b.val := hab
  have hp := (allBelow_iff _ _).1 h.2 b.val b.isLt
  have hp2 := (allBelow_iff _ _).1 hp a.val hab'
  unfold chkPair at hp2
  revert hp2
  cases lookC (Nat.add (Nat.mul 16 a.val) b.val) ce with
  | none =>
    intro hp2
    change orB (untK (ent K) a b) (Nat.blt 256 (phiInc K a b)) = true at hp2
    rw [orB_eq, Bool.or_eq_true, Nat.blt_eq] at hp2
    rcases hp2 with hu | hk
    · left
      exact untK_sound (ent K) a b hu
    · right; left
      exact lt_of_lt_of_le hk (phiInc_le K (Fin.ne_of_lt hab))
  | some w =>
    intro hp2
    change andB (andB (validK w.1 w.2.1) (Nat.blt w.2.2 N))
      (isoK (getK S w.2.2) (entryF (ent K) a b) w.1) = true at hp2
    rw [andB_eq, andB_eq, Bool.and_eq_true, Bool.and_eq_true, Nat.blt_eq] at hp2
    obtain ⟨⟨hv, hj⟩, hi⟩ := hp2
    right; right
    refine ⟨sigF w.1 w.2.1 hv, sigF_injective w.1 w.2.1 hv, w.2.2, hj, ?_⟩
    rw [isoK_sound _ _ _ _ hv hi, den13, denF_entryF]

/-! ## All states -/

/-- **Soundness of the kernel check.** If every key with number below `N` passes `chkState` and key
number `0` is the start state, then the start state is not feasible at level 8. -/
theorem not_feasible_of_cover (S : KT) (N : Nat) (hN : 0 < N) (hcov : RangeOK S N 0 N)
    (h0 : startK (getK S 0) = true) : ¬ Feasible 8 (f0 13) := by
  have key : ∀ k : FState 13, (∃ j, j < N ∧ den13 (getK S j) = k) → ¬ Feasible 8 k := by
    apply closure_sound 8
    · rintro k ⟨j, hj, rfl⟩
      obtain ⟨ce, hce⟩ := hcov j (Nat.zero_le j) hj hj
      exact (chkState_sound S N _ ce hce).1
    · rintro k ⟨j, hj, rfl⟩ a b hab
      obtain ⟨ce, hce⟩ := hcov j (Nat.zero_le j) hj hj
      rcases (chkState_sound S N _ ce hce).2 a b hab with h | h | ⟨σ, hσ, j', hj', he⟩
      · exact Or.inl h
      · exact Or.inr (Or.inl h)
      · exact Or.inr (Or.inr ⟨σ, hσ, j', hj', he⟩)
  rw [← startK_sound h0]
  exact key _ ⟨0, hN, rfl⟩

end S13K
