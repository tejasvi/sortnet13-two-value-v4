import S13.S11.Codes

/-!
# Soundness of the certificate checker

`Cert.Claim c s`: step `s` claims the bound `Bd s` for its set of vectors of width `W s`.
`Cert.claims_of_check`: if `checkStep` accepts every step `s < count`, every such claim holds.
-/

namespace Sortnet.S11

open ZO

/-! ## Rules in terms of codes -/

/-- The Huffman rule with the extremal channels and their bounds given as a list of pairs. -/
theorem LB.of_huffman_list {w : ℕ} {V : Set (Vec w)} (pol : Bool) (L : List (Fin w × ℕ))
    (hnd : (L.map Prod.fst).Nodup)
    (hL : ∀ p ∈ L, (if pol then inv (unit p.1) else unit p.1) ∈ V ∧
      LB (if pol then restrictF V p.1 else restrictT V p.1) p.2) {b : ℕ}
    (hb : 2 ^ b < 2 * (L.map fun p => 2 ^ p.2).sum) : LB V b := by
  classical
  set E : Finset (Fin w) := (L.map Prod.fst).toFinset with hE
  let B : Fin w → ℕ := fun i => ((L.find? fun p => p.1 = i).map Prod.snd).getD 0
  have hfind : ∀ (L : List (Fin w × ℕ)), (L.map Prod.fst).Nodup → ∀ p ∈ L,
      L.find? (fun q => q.1 = p.1) = some p := by
    intro L
    induction L with
    | nil => intro _ p hp; simp at hp
    | cons q L ih =>
      intro hnd p hp
      simp only [List.map_cons, List.nodup_cons, List.mem_map] at hnd
      rcases List.mem_cons.1 hp with rfl | hp'
      · simp
      · have hq : q.1 ≠ p.1 := fun h => hnd.1 ⟨p, hp', h.symm⟩
        simp only [List.find?_cons, hq, decide_false]
        exact ih hnd.2 p hp'
  have hB : ∀ p ∈ L, B p.1 = p.2 := by
    intro p hp
    simp [B, hfind L hnd p hp]
  have hsum : ∑ i ∈ E, 2 ^ B i = (L.map fun p => 2 ^ p.2).sum := by
    rw [hE, List.sum_toFinset _ hnd, List.map_map]
    congr 1
    apply List.map_congr_left
    intro p hp
    simp [hB p hp]
  have hmemE : ∀ i ∈ E, ∃ p ∈ L, p.1 = i := by
    intro i hi
    simp only [hE, List.mem_toFinset, List.mem_map] at hi
    exact hi
  cases pol with
  | false =>
    apply LB.of_huffman (E := E) (B := B) _ _ (by rwa [hsum])
    · intro i hi
      obtain ⟨p, hp, rfl⟩ := hmemE i hi
      simpa using (hL p hp).1
    · intro i hi
      obtain ⟨p, hp, rfl⟩ := hmemE i hi
      rw [hB p hp]; simpa using (hL p hp).2
  | true =>
    apply LB.of_huffman_inv (E := E) (B := B) _ _ (by rwa [hsum])
    · intro i hi
      obtain ⟨p, hp, rfl⟩ := hmemE i hi
      simpa using (hL p hp).1
    · intro i hi
      obtain ⟨p, hp, rfl⟩ := hmemE i hi
      rw [hB p hp]; simpa using (hL p hp).2

/-- A relabeling from a valid permutation array. -/
theorem exists_perm_of_validPerm {perm : Array ℕ} {n : ℕ} (h : validPerm perm n = true) :
    ∃ σ : Equiv.Perm (Fin n), ∀ k : Fin n, (σ k : ℕ) = perm.getD k 0 := by
  simp only [validPerm, Bool.and_eq_true, beq_iff_eq, allLt_iff, decide_eq_true_eq,
    Bool.or_eq_true, bne_iff_ne, ne_eq] at h
  obtain ⟨⟨-, hlt⟩, hinj⟩ := h
  let f : Fin n → Fin n := fun k => ⟨perm.getD k 0, hlt k k.isLt⟩
  have hf : Function.Injective f := by
    intro a b hab
    simp only [f, Fin.mk.injEq] at hab
    rcases hinj a a.isLt b b.isLt with h | h
    · exact Fin.ext h
    · exact absurd hab h
  exact ⟨Equiv.ofBijective f (Finite.injective_iff_bijective.1 hf), fun k => rfl⟩

namespace Cert

variable (c : Cert)

/-- The claim of step `s`. -/
def Claim (s : ℕ) : Prop := LB (setOf (c.W s) (c.mem s)) (c.Bd s)

theorem mem_elems {s x : ℕ} : x ∈ c.elems s ↔ x < 2 ^ c.W s ∧ c.mem s x = true :=
  mem_elemsOf _ _ _ _

/-- **A witness gives a valid bound.** -/
theorem witBound_sound {s j n : ℕ} {tmem : ℕ → Bool} {cands : Unit → List ℕ} {bw : ℕ}
    (hprev : ∀ t < s, c.Claim t) (h : c.witBound s j n tmem cands = some bw) :
    LB (setOf n tmem) bw := by
  unfold witBound at h
  simp only at h
  set v := readNum c.byte (c.witOff s j) 4
  set perm := lehmer n (readNum c.byte (c.witOff s j + 4) 4)
  by_cases h2 : v % 4 = 2
  · rw [if_pos (by simp [h2])] at h
    simp only [Option.some.injEq] at h
    subst h
    split_ifs with hc
    · exact LB_one_of_collision hc
    · exact LB.zero _
  · rw [if_neg (by simp [h2])] at h
    by_cases h3 : v % 4 = 3
    · rw [if_pos (by simp [h3])] at h; simp at h
    · rw [if_neg (by simp [h3])] at h
      by_cases hok : c.witOk s n (v % 4) (v / 4) perm tmem = true
      · rw [if_pos hok] at h
        simp only [Option.some.injEq] at h
        subst h
        unfold witOk at hok
        rw [Bool.and_eq_true, Bool.and_eq_true, Bool.and_eq_true] at hok
        obtain ⟨⟨⟨hid, hW⟩, hperm⟩, hall⟩ := hok
        rw [decide_eq_true_eq] at hid
        rw [beq_iff_eq] at hW
        rw [List.all_eq_true] at hall
        have hclaim := hprev _ hid
        unfold Claim at hclaim
        rw [hW] at hclaim
        obtain ⟨σ, hσ⟩ := exists_perm_of_validPerm hperm
        by_cases h1 : v % 4 = 1
        · apply (hclaim.map_inv.map_relabel σ).mono
          rintro _ ⟨_, ⟨u, hu, rfl⟩, rfl⟩
          simp only [setOf, Set.mem_ofPred_eq] at hu ⊢
          rw [toCode_relabel perm σ hσ, toCode_inv]
          have hx : toCode u ∈ c.elems (v / 4) :=
            (c.mem_elems).2 ⟨by rw [hW]; exact toCode_lt u, hu⟩
          have := hall _ hx
          simpa [witElem, h1] using this
        · apply (hclaim.map_relabel σ).mono
          rintro _ ⟨u, hu, rfl⟩
          simp only [setOf, Set.mem_ofPred_eq] at hu ⊢
          rw [toCode_relabel perm σ hσ]
          have hx : toCode u ∈ c.elems (v / 4) :=
            (c.mem_elems).2 ⟨by rw [hW]; exact toCode_lt u, hu⟩
          have := hall _ hx
          simpa [witElem, h1] using this
      · rw [if_neg hok] at h; simp at h

/-! ## Successor steps -/

theorem checkSuccWits_spec {s b : ℕ} {E : List ℕ} : ∀ (L : List (ℕ × ℕ)) (j0 : ℕ),
    c.checkSuccWits s b E L j0 = true → ∀ k (hk : k < L.length), ∃ bw,
      c.witBound s (j0 + k) (c.W s) (memCmp (c.mem s) L[k].1 L[k].2)
        (fun _ => E.map (cmpCode L[k].1 L[k].2)) = some bw ∧ b ≤ bw + 1
  | [], _, _, k, hk => by simp at hk
  | (lo, hi) :: L, j0, h, k, hk => by
    unfold checkSuccWits at h
    rw [Bool.and_eq_true] at h
    obtain ⟨h1, h2⟩ := h
    rcases k with _ | k
    · split at h1
      · rename_i bw hbw
        exact ⟨bw, by simpa using hbw, by simpa using h1⟩
      · simp at h1
    · obtain ⟨bw, hbw, hb⟩ := checkSuccWits_spec L (j0 + 1) h2 k (by simpa using hk)
      refine ⟨bw, ?_, hb⟩
      simpa [show j0 + (k + 1) = j0 + 1 + k by omega] using hbw

theorem mem_cmpList {w lo hi : ℕ} : (lo, hi) ∈ cmpList w ↔ lo < hi ∧ hi < w := by
  unfold cmpList
  rw [List.mem_flatMap]
  constructor
  · rintro ⟨h, hh, hm⟩
    rw [List.mem_map] at hm
    obtain ⟨l, hl, he⟩ := hm
    simp only [Prod.mk.injEq] at he
    obtain ⟨rfl, rfl⟩ := he
    exact ⟨List.mem_range.1 hl, List.mem_range.1 hh⟩
  · rintro ⟨h1, h2⟩
    exact ⟨hi, List.mem_range.2 h2, List.mem_map.2 ⟨lo, List.mem_range.2 h1, rfl⟩⟩

theorem cmp_eq_self_of_not {w : ℕ} {lo hi : Fin w} {v : Vec w} (h : ¬ (v lo = true ∧ v hi = false)) :
    ZO.cmp (lo, hi) v = v := by
  cases hh : v hi
  · have hl : v lo = false := by
      cases hl : v lo
      · rfl
      · exact absurd ⟨hl, hh⟩ h
    funext k; simp only [ZO.cmp]; split_ifs with h1 h2
    · subst h1; simp [hl, hh]
    · subst h2; simp [hl, hh]
    · rfl
  · exact cmp_of_hi_true hh

theorem checkSucc_sound {s : ℕ} (hprev : ∀ t < s, c.Claim t) (h : c.checkSucc s = true) :
    c.Claim s := by
  unfold checkSucc at h
  simp only [Bool.and_eq_true, beq_iff_eq] at h
  obtain ⟨⟨hcoll, -⟩, hwits⟩ := h
  unfold Claim
  set S := setOf (c.W s) (c.mem s) with hS
  have hE : ∀ v ∈ S, toCode v ∈ c.elems s := fun v hv => (c.mem_elems).2 ⟨toCode_lt v, hv⟩
  apply LB.succ (not_works_nil_of_collision hcoll)
  intro lo hi hlh
  by_cases hirr : irredundant (c.elems s) lo hi = true
  · right; right
    have hmem : ((lo : ℕ), (hi : ℕ)) ∈ (cmpList (c.W s)).filter
        (fun lh => irredundant (c.elems s) lh.1 lh.2) :=
      List.mem_filter.2 ⟨mem_cmpList.2 ⟨hlh, hi.isLt⟩, hirr⟩
    obtain ⟨k, hk, hkeq⟩ := List.mem_iff_getElem.1 hmem
    obtain ⟨bw, hbw, hb⟩ := c.checkSuccWits_spec _ 0 hwits k hk
    rw [hkeq] at hbw
    have hlb := c.witBound_sound hprev hbw
    have hset : setOf (c.W s) (memCmp (c.mem s) lo hi) = ZO.cmp (lo, hi) '' S := by
      ext v; exact (mem_cmp_image_iff _ (ne_of_lt hlh) v).symm
    rw [hset] at hlb
    exact hlb.weaken (by omega)
  · unfold irredundant at hirr
    simp only [Bool.and_eq_true, not_and] at hirr
    by_cases hA : ((c.elems s).any fun x => x.testBit lo && !x.testBit hi) = true
    · -- no vector with `lo` false and `hi` true: the comparator relabels the set
      have hB := hirr hA
      right; left
      have key : ∀ v ∈ S, ZO.cmp (lo, hi) v = relabel (Equiv.swap lo hi) v := by
        intro v hv
        cases hl : v lo
        · have hh : v hi = false := by
            cases hh : v hi
            · rfl
            · exfalso; apply hB
              rw [List.any_eq_true]
              exact ⟨toCode v, hE v hv, by simp [toCode_apply, hl, hh]⟩
          rw [cmp_eq_self_of_not (by simp [hl])]
          funext k
          simp only [relabel]
          by_cases h1 : k = lo
          · subst h1; simp [Equiv.swap_apply_left, hl, hh]
          · by_cases h2 : k = hi
            · subst h2; simp [Equiv.swap_apply_right, hl, hh]
            · rw [Equiv.swap_apply_of_ne_of_ne h1 h2]
        · exact cmp_of_lo_true hl
      ext v
      simp only [Set.mem_image]
      constructor
      · rintro ⟨u, hu, rfl⟩; exact ⟨u, hu, (key u hu).symm⟩
      · rintro ⟨u, hu, rfl⟩; exact ⟨u, hu, key u hu⟩
    · -- no vector with `lo` true and `hi` false: nothing changes
      left
      have key : ∀ v ∈ S, ZO.cmp (lo, hi) v = v := by
        intro v hv
        apply cmp_eq_self_of_not
        rintro ⟨hl, hh⟩
        apply hA
        rw [List.any_eq_true]
        exact ⟨toCode v, hE v hv, by simp [toCode_apply, hl, hh]⟩
      ext v
      simp only [Set.mem_image]
      constructor
      · rintro ⟨u, hu, rfl⟩; rwa [key u hu]
      · intro hv; exact ⟨v, hv, key v hv⟩

/-! ## Huffman steps -/

theorem huffBounds_spec {s : ℕ} {pol : Bool} {E : List ℕ} : ∀ (L : List ℕ) (j0 : ℕ) (bs : List ℕ),
    c.huffBounds s pol E L j0 = some bs → bs.length = L.length ∧ ∀ k (hk : k < L.length)
      (hk' : k < bs.length), c.witBound s (j0 + k) (c.W s - 1)
        (fun y => c.mem s (insBit L[k] (!pol) y))
        (fun _ => E.filterMap fun x => if x.testBit L[k] == !pol then some (delBit L[k] x) else none) =
          some bs[k]
  | [], _, bs, h => by
    simp only [huffBounds, Option.some.injEq] at h
    subst h; simp
  | i :: L, j0, bs, h => by
    unfold huffBounds at h
    split at h
    · rename_i bi bs' h1 h2
      simp only [Option.some.injEq] at h
      subst h
      obtain ⟨hlen, hk⟩ := huffBounds_spec L (j0 + 1) bs' h2
      refine ⟨by simp [hlen], ?_⟩
      intro k hk1 hk2
      rcases k with _ | k
      · simpa using h1
      · have := hk k (by simpa using hk1) (by simpa using hk2)
        simpa [show j0 + (k + 1) = j0 + 1 + k by omega] using this
    · simp at h

theorem toCode_unit {w : ℕ} (i : Fin w) : toCode (unit i) = 2 ^ (i : ℕ) := by
  apply toCode_eq_of_testBit
  intro j
  rw [Nat.testBit_two_pow]
  split_ifs with hj
  · simp only [unit, Fin.ext_iff, decide_eq_decide]; exact eq_comm
  · simp; omega

theorem huff_core {w : ℕ} (hw : 1 ≤ w) (mem : ℕ → Bool) (pol : Bool) (bs : List ℕ)
    (hlen : bs.length = ((List.range w).filter fun i => mem (extCode pol w i)).length)
    (hwit : ∀ k (hk : k < ((List.range w).filter fun i => mem (extCode pol w i)).length)
      (hk' : k < bs.length), LB (setOf (w - 1) fun y =>
        mem (insBit ((List.range w).filter fun i => mem (extCode pol w i))[k] (!pol) y)) bs[k])
    {b : ℕ} (hb : 2 ^ b < 2 * (bs.map (2 ^ ·)).sum) : LB (setOf w mem) b := by
  obtain ⟨n, rfl⟩ : ∃ n, w = n + 1 := ⟨w - 1, by omega⟩
  try simp only [Nat.add_sub_cancel] at hwit
  set ext := (List.range (n + 1)).filter fun i => mem (extCode pol (n + 1) i) with hext
  set extF := (List.finRange (n + 1)).filter fun i : Fin (n + 1) => mem (extCode pol (n + 1) i)
    with hextF
  have hextF_val : extF.map Fin.val = ext := by
    rw [hextF, hext, ← List.map_coe_finRange_eq_range, List.filter_map]
    rfl
  have hlenF : extF.length = ext.length := by rw [← hextF_val, List.length_map]
  set L := extF.zip bs with hL
  have hLfst : L.map Prod.fst = extF := by
    rw [hL, List.map_fst_zip]; omega
  have hLsnd : L.map Prod.snd = bs := by
    rw [hL, List.map_snd_zip]; omega
  apply LB.of_huffman_list pol L
  · rw [hLfst]; exact (List.nodup_finRange _).filter _
  · intro p hp
    obtain ⟨k, hk, rfl⟩ := List.mem_iff_getElem.1 hp
    have hkL : k < extF.length := by
      have := hk; rw [hL, List.length_zip] at this; omega
    have hkb : k < bs.length := by
      have := hk; rw [hL, List.length_zip] at this; omega
    have hfst : L[k].1 = extF[k] := by simp [hL]
    have hsnd : L[k].2 = bs[k] := by simp [hL]
    rw [hfst, hsnd]
    have hmemF : extF[k] ∈ extF := List.getElem_mem _
    have hsel : mem (extCode pol (n + 1) extF[k]) = true := (List.mem_filter.1 hmemF).2
    have hval : ext[k]'(by omega) = (extF[k] : ℕ) := by
      simp only [← hextF_val, List.getElem_map]
    constructor
    · cases pol
      · simpa [setOf, toCode_unit, extCode] using hsel
      · simp only [setOf, Set.mem_ofPred_eq, if_true]
        rw [toCode_inv, toCode_unit]
        simpa [extCode, invCode] using hsel
    · have hw' : LB (setOf n fun y => mem (insBit ext[k] (!pol) y)) bs[k] := hwit k (by omega) hkb
      rw [hval] at hw'
      have hset : setOf n (fun y => mem (insBit (extF[k] : ℕ) (!pol) y)) =
          del extF[k] '' {v | v ∈ setOf (n + 1) mem ∧ v extF[k] = !pol} := by
        ext y
        rw [mem_del_restrict_iff]
        rfl
      rw [hset] at hw'
      cases pol
      · simp only [Bool.false_eq_true, ↓reduceIte]
        exact LB.of_delete' (fun v hv => hv.2) hw'
      · simp only [↓reduceIte]
        exact LB.of_delete_false (fun v hv => hv.2) hw'
  · have hm : (L.map fun p => 2 ^ p.2) = bs.map (fun x => 2 ^ x) := by
      rw [← hLsnd, List.map_map]; rfl
    rw [hm]; exact hb

theorem checkHuff_sound {s : ℕ} {pol : Bool} (hprev : ∀ t < s, c.Claim t)
    (h : c.checkHuff s pol = true) : c.Claim s := by
  unfold checkHuff at h
  simp only [Bool.and_eq_true, decide_eq_true_eq, beq_iff_eq] at h
  obtain ⟨⟨hw, -⟩, hm⟩ := h
  split at hm
  · rename_i bs hbs
    rw [decide_eq_true_eq] at hm
    obtain ⟨hlen, hk⟩ := c.huffBounds_spec _ 0 bs hbs
    exact huff_core hw (c.mem s) pol bs hlen
      (fun k hk1 hk2 => c.witBound_sound hprev (by simpa using hk k hk1 hk2)) hm
  · simp at hm

/-! ## All steps -/

theorem checkStep_sound {s : ℕ} (hprev : ∀ t < s, c.Claim t) (h : c.checkStep s = true) :
    c.Claim s := by
  unfold checkStep at h
  split_ifs at h with h2 h0 h1
  · exact c.checkSucc_sound hprev h
  · exact c.checkHuff_sound hprev h
  · exact c.checkHuff_sound hprev h

/-- **Soundness of the checker.** If every step `s < count` passes, every step's claim holds. -/
theorem claims_of_check {count : ℕ} (h : ∀ s < count, c.checkStep s = true) :
    ∀ s < count, c.Claim s := by
  intro s
  induction s using Nat.strong_induction_on with
  | _ s ih =>
    intro hs
    exact c.checkStep_sound (fun t ht => ih t ht (by omega)) (h s hs)

end Cert

end Sortnet.S11
