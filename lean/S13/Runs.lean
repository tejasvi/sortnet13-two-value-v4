import S13.CheckSound

/-!
# Runs, `W(x,y)` and f-states

In the run `(x, y)` the largest value `M` starts on input `x` and the second largest value `m` on
input `y`. Their positions follow the token dynamics `moveM`, `movem`, and the number of comparators
they meet is `costFrom` (`config_run`, `W_length`). The f-state `runF net (f0 n)` only contains
entries that come from runs (`Rep.run`), so a top-two correct network with all `|W(x,y)| ≤ L` makes
`f0 n` feasible (`good_of_top2`). Hence `¬ Feasible L (f0 n)` gives `P(2,n) ≥ L + 1`.
-/

namespace Sortnet

variable {n : ℕ}

/-! ## Token dynamics -/

/-- Position of the largest value after the comparator `c`, if it was on `pM`. -/
def GComparator.moveM (c : GComparator n) (pM : Fin n) : Fin n :=
  if pM = c.lo ∨ pM = c.hi then c.hi else pM

/-- Position of the second largest value after the comparator `c`, if it was on `pm` and the
largest value was on `pM`. -/
def GComparator.movem (c : GComparator n) (pM pm : Fin n) : Fin n :=
  if (pM = c.lo ∨ pM = c.hi) ∧ (pm = c.lo ∨ pm = c.hi) then c.lo
  else if pm = c.lo ∨ pm = c.hi then c.hi else pm

/-- The run with `M` on `pM` and `m` on `pm` meets the comparator `c`. -/
def GComparator.Touch (c : GComparator n) (pM pm : Fin n) : Prop :=
  pM = c.lo ∨ pM = c.hi ∨ pm = c.lo ∨ pm = c.hi

instance (c : GComparator n) (pM pm : Fin n) : Decidable (c.Touch pM pm) := by
  unfold GComparator.Touch; infer_instance

/-- A value vector with `M` on `pM`, `m < M` on `pm`, and all other values below `m`. -/
structure Config (M m : ℕ) (v : Fin n → ℕ) (pM pm : Fin n) : Prop where
  ne : pM ≠ pm
  hM : v pM = M
  hm : v pm = m
  lt : m < M
  others : ∀ z, z ≠ pM → z ≠ pm → v z < m

theorem Config.eq_pM {M m : ℕ} {v : Fin n → ℕ} {pM pm : Fin n} (h : Config M m v pM pm) {z : Fin n}
    (hz : M ≤ v z) : z = pM := by
  by_contra hne
  by_cases hzm : z = pm
  · rw [hzm, h.hm] at hz; exact absurd h.lt (by omega)
  · have := h.others z hne hzm; have := h.lt; omega

theorem Config.eq_pm {M m : ℕ} {v : Fin n → ℕ} {pM pm : Fin n} (h : Config M m v pM pm) {z : Fin n}
    (hz : v z = m) : z = pm := by
  by_contra hne
  by_cases hzM : z = pM
  · rw [hzM, h.hM] at hz; have := h.lt; omega
  · have := h.others z hzM hne; omega

theorem Config.le_iff {M m : ℕ} {v : Fin n → ℕ} {pM pm : Fin n} (h : Config M m v pM pm) (z : Fin n) :
    m ≤ v z ↔ z = pM ∨ z = pm := by
  constructor
  · intro hz
    by_contra hc
    push Not at hc
    have := h.others z hc.1 hc.2; omega
  · rintro (rfl | rfl)
    · rw [h.hM]; exact le_of_lt h.lt
    · rw [h.hm]

theorem Config.touch_iff {M m : ℕ} {v : Fin n → ℕ} {pM pm : Fin n} (h : Config M m v pM pm)
    (c : GComparator n) : (m ≤ v c.lo ∨ m ≤ v c.hi) ↔ c.Touch pM pm := by
  rw [h.le_iff, h.le_iff, GComparator.Touch]
  constructor
  · rintro ((h1 | h1) | (h1 | h1)) <;> simp [h1]
  · rintro (h1 | h1 | h1 | h1) <;> simp [h1]

theorem GComparator.apply_lo (c : GComparator n) (v : Fin n → ℕ) :
    c.apply v c.lo = min (v c.lo) (v c.hi) := by
  simp [GComparator.apply]

theorem GComparator.apply_hi (c : GComparator n) (v : Fin n → ℕ) :
    c.apply v c.hi = max (v c.lo) (v c.hi) := by
  simp [GComparator.apply, Ne.symm c.ne]

theorem GComparator.apply_other (c : GComparator n) (v : Fin n → ℕ) {z : Fin n} (h1 : z ≠ c.lo)
    (h2 : z ≠ c.hi) : c.apply v z = v z := by
  simp [GComparator.apply, h1, h2]

theorem Config.step {M m : ℕ} {v : Fin n → ℕ} {pM pm : Fin n} (h : Config M m v pM pm)
    (c : GComparator n) : Config M m (c.apply v) (c.moveM pM) (c.movem pM pm) := by
  obtain ⟨hne, hM, hm, hlt, hoth⟩ := h
  have hab := c.ne
  by_cases h1 : pM = c.lo ∨ pM = c.hi <;> by_cases h2 : pm = c.lo ∨ pm = c.hi
  · -- both values meet the comparator
    have e1 : c.moveM pM = c.hi := by simp [GComparator.moveM, h1]
    have e2 : c.movem pM pm = c.lo := by simp [GComparator.movem, h1, h2]
    have hv : max (v c.lo) (v c.hi) = M ∧ min (v c.lo) (v c.hi) = m := by
      rcases h1 with h1 | h1 <;> rcases h2 with h2 | h2
      · exact absurd (h1.trans h2.symm) hne
      · rw [← h1, ← h2, hM, hm]; omega
      · rw [← h1, ← h2, hM, hm]; omega
      · exact absurd (h1.trans h2.symm) hne
    rw [e1, e2]
    refine ⟨Ne.symm hab, by rw [c.apply_hi, hv.1], by rw [c.apply_lo, hv.2], hlt,
      fun z hz1 hz2 => ?_⟩
    rw [c.apply_other v hz2 hz1]
    apply hoth z
    · rintro rfl; rcases h1 with h1 | h1
      · exact hz2 h1
      · exact hz1 h1
    · rintro rfl; rcases h2 with h2 | h2
      · exact hz2 h2
      · exact hz1 h2
  · -- only the largest value meets the comparator
    push Not at h2
    have e1 : c.moveM pM = c.hi := by simp [GComparator.moveM, h1]
    have e2 : c.movem pM pm = pm := by simp [GComparator.movem, h2.1, h2.2]
    have hv : max (v c.lo) (v c.hi) = M ∧ min (v c.lo) (v c.hi) < m := by
      rcases h1 with h1 | h1
      · have : v c.hi < m := hoth c.hi (by rw [h1]; exact Ne.symm hab) (Ne.symm h2.2)
        rw [← h1, hM]; omega
      · have : v c.lo < m := hoth c.lo (by rw [h1]; exact hab) (Ne.symm h2.1)
        rw [← h1, hM]; omega
    rw [e1, e2]
    refine ⟨fun h => h2.2 h.symm, by rw [c.apply_hi, hv.1], by rw [c.apply_other v h2.1 h2.2, hm],
      hlt, fun z hz1 hz2 => ?_⟩
    by_cases hz : z = c.lo
    · rw [hz, c.apply_lo]; exact hv.2
    · rw [c.apply_other v hz hz1]
      apply hoth z _ hz2
      rintro rfl; rcases h1 with h1 | h1
      · exact hz h1
      · exact hz1 h1
  · -- only the second largest value meets the comparator
    push Not at h1
    have e1 : c.moveM pM = pM := by simp [GComparator.moveM, h1.1, h1.2]
    have e2 : c.movem pM pm = c.hi := by simp [GComparator.movem, h1.1, h1.2, h2]
    have hv : max (v c.lo) (v c.hi) = m ∧ min (v c.lo) (v c.hi) < m := by
      rcases h2 with h2 | h2
      · have : v c.hi < m := hoth c.hi (Ne.symm h1.2) (by rw [h2]; exact Ne.symm hab)
        rw [← h2, hm]; omega
      · have : v c.lo < m := hoth c.lo (Ne.symm h1.1) (by rw [h2]; exact hab)
        rw [← h2, hm]; omega
    rw [e1, e2]
    refine ⟨h1.2, by rw [c.apply_other v h1.1 h1.2, hM], by rw [c.apply_hi, hv.1], hlt,
      fun z hz1 hz2 => ?_⟩
    by_cases hz : z = c.lo
    · rw [hz, c.apply_lo]; exact hv.2
    · rw [c.apply_other v hz hz2]
      apply hoth z hz1
      rintro rfl; rcases h2 with h2 | h2
      · exact hz h2
      · exact hz2 h2
  · -- neither value meets the comparator
    push Not at h1 h2
    have e1 : c.moveM pM = pM := by simp [GComparator.moveM, h1.1, h1.2]
    have e2 : c.movem pM pm = pm := by simp [GComparator.movem, h2.1, h2.2]
    have hlo : v c.lo < m := hoth c.lo (Ne.symm h1.1) (Ne.symm h2.1)
    have hhi : v c.hi < m := hoth c.hi (Ne.symm h1.2) (Ne.symm h2.2)
    rw [e1, e2]
    refine ⟨hne, by rw [c.apply_other v h1.1 h1.2, hM], by rw [c.apply_other v h2.1 h2.2, hm], hlt,
      fun z hz1 hz2 => ?_⟩
    by_cases hz : z = c.lo
    · rw [hz, c.apply_lo]; omega
    · by_cases hz' : z = c.hi
      · rw [hz', c.apply_hi]; omega
      · rw [c.apply_other v hz hz']; exact hoth z hz1 hz2

/-- Positions of `M` and `m` after the network, starting from `pM` and `pm`. -/
def posFrom : GNetwork n → Fin n → Fin n → Fin n × Fin n
  | [], pM, pm => (pM, pm)
  | c :: C, pM, pm => posFrom C (c.moveM pM) (c.movem pM pm)

/-- Number of comparators met by `M` or `m`, starting from `pM` and `pm`. -/
def costFrom : GNetwork n → Fin n → Fin n → ℕ
  | [], _, _ => 0
  | c :: C, pM, pm => (if c.Touch pM pm then 1 else 0) + costFrom C (c.moveM pM) (c.movem pM pm)

theorem GNetwork.eval_cons (c : GComparator n) (C : GNetwork n) (v : Fin n → ℕ) :
    GNetwork.eval (c :: C) v = GNetwork.eval C (c.apply v) := rfl

theorem config_run {M m : ℕ} (C : GNetwork n) {v : Fin n → ℕ} {pM pm : Fin n}
    (h : Config M m v pM pm) :
    Config M m (C.eval v) (posFrom C pM pm).1 (posFrom C pM pm).2 ∧
      (C.touched v m).length = costFrom C pM pm := by
  induction C generalizing v pM pm with
  | nil => exact ⟨h, rfl⟩
  | cons c C ih =>
    obtain ⟨h1, h2⟩ := ih (h.step c)
    refine ⟨h1, ?_⟩
    simp only [GNetwork.touched, List.length_append, List.length_map, costFrom, ← h2]
    by_cases ht : c.Touch pM pm
    · rw [ite_eq_left ((h.touch_iff c).2 ht), ite_eq_left ht]; simp
    · rw [ite_eq_right (fun h' => ht ((h.touch_iff c).1 h')), ite_eq_right ht]; simp

theorem config_runInput {x y : Fin n} (hxy : x ≠ y) : Config (n + 1) n (runInput n x y) x y where
  ne := hxy
  hM := by simp [runInput]
  hm := by simp [runInput, Ne.symm hxy]
  lt := Nat.lt_succ_self n
  others := fun z hzx hzy => by simp [runInput, hzx, hzy, z.isLt]

theorem W_length (net : GNetwork n) {x y : Fin n} (hxy : x ≠ y) :
    (net.W x y).length = costFrom net x y :=
  (config_run net (config_runInput hxy)).2

/-! ## f-states represent runs -/

/-- One comparator applied to a run `(pM, pm, cost)`. -/
def stepRun (c : GComparator n) (r : Fin n × Fin n × ℕ) : Fin n × Fin n × ℕ :=
  (c.moveM r.1, c.movem r.1 r.2.1, r.2.2 + if c.Touch r.1 r.2.1 then 1 else 0)

/-- A network applied to a run `(pM, pm, cost)`. -/
def runFrom (C : GNetwork n) (r : Fin n × Fin n × ℕ) : Fin n × Fin n × ℕ :=
  ((posFrom C r.1 r.2.1).1, (posFrom C r.1 r.2.1).2, r.2.2 + costFrom C r.1 r.2.1)

/-- Every entry of the f-state comes from a run in `P`. -/
def Rep (f : FState n) (P : Fin n × Fin n × ℕ → Prop) : Prop :=
  ∀ p q k, f p q = some k → P (p, q, k)

theorem oinc_omax_eq_some {u v : Option ℕ} {k : ℕ} (h : oinc (omax u v) = some k) :
    ∃ j, k = j + 1 ∧ (u = some j ∨ v = some j) := by
  cases u <;> cases v <;> simp [oinc, omax] at h
  · exact ⟨_, h.symm, Or.inr rfl⟩
  · exact ⟨_, h.symm, Or.inl rfl⟩
  case some.some a b =>
    refine ⟨max a b, h.symm, ?_⟩
    rcases le_total a b with hab | hab
    · right; simp [max_eq_right hab]
    · left; simp [max_eq_left hab]

theorem Rep.step {f : FState n} {P : Fin n × Fin n × ℕ → Prop} (h : Rep f P) (c : GComparator n) :
    Rep (fstep c.lo c.hi f) (fun r' => ∃ r, P r ∧ stepRun c r = r') := by
  intro p q k hk
  have hab := c.ne
  simp only [fstep] at hk
  split_ifs at hk with h1 h2 h3 h4 h5 h6
  · obtain ⟨j, rfl, hj | hj⟩ := oinc_omax_eq_some hk
    · exact ⟨_, h _ _ _ hj, by simp [stepRun, GComparator.moveM, GComparator.movem,
        GComparator.Touch, h1, h2]⟩
    · exact ⟨_, h _ _ _ hj, by simp [stepRun, GComparator.moveM, GComparator.movem,
        GComparator.Touch, h1, h2]⟩
  · obtain ⟨j, rfl, hj | hj⟩ := oinc_omax_eq_some hk
    · exact ⟨_, h _ _ _ hj, by simp [stepRun, GComparator.moveM, GComparator.movem,
        GComparator.Touch, h1, h2, h3]⟩
    · exact ⟨_, h _ _ _ hj, by simp [stepRun, GComparator.moveM, GComparator.movem,
        GComparator.Touch, h1, h2, h3]⟩
  · obtain ⟨j, rfl, hj | hj⟩ := oinc_omax_eq_some hk
    · exact ⟨_, h _ _ _ hj, by simp [stepRun, GComparator.moveM, GComparator.movem,
        GComparator.Touch, h1, h4, h6]⟩
    · exact ⟨_, h _ _ _ hj, by simp [stepRun, GComparator.moveM, GComparator.movem,
        GComparator.Touch, h1, h4, h6]⟩
  · exact ⟨_, h _ _ _ hk, by simp [stepRun, GComparator.moveM, GComparator.movem,
      GComparator.Touch, h1, h4, h5, h6]⟩

theorem Rep.run {f : FState n} {P : Fin n × Fin n × ℕ → Prop} (h : Rep f P) (C : GNetwork n) :
    Rep (runF C f) (fun r' => ∃ r, P r ∧ runFrom C r = r') := by
  induction C generalizing f P with
  | nil =>
    intro p q k hk
    exact ⟨_, h _ _ _ hk, by simp [runFrom, posFrom, costFrom]⟩
  | cons c C ih =>
    intro p q k hk
    obtain ⟨r1, ⟨r, hr, rfl⟩, hr1⟩ := ih (h.step c) p q k hk
    refine ⟨r, hr, ?_⟩
    rw [← hr1]
    simp only [runFrom, stepRun, posFrom, costFrom]
    congr 2
    omega

theorem rep_f0 : Rep (f0 n) (fun r => r.1 ≠ r.2.1 ∧ r.2.2 = 0) := by
  intro p q k hk
  simp only [f0] at hk
  split_ifs at hk with hpq
  exact ⟨hpq, (Option.some.inj hk).symm⟩

/-- A top-two correct network with all `|W(x,y)| ≤ L` reaches a goal from `f0 n`. -/
theorem good_of_top2 {L : ℕ} (net : GNetwork n) (hT : net.Top2Correct)
    (hW : ∀ x y : Fin n, x ≠ y → (net.W x y).length ≤ L) : Good L (runF net (f0 n)) := by
  obtain ⟨oM, om, -, hT⟩ := hT
  refine ⟨oM, om, fun p q k hk => ?_⟩
  obtain ⟨⟨x, y, c0⟩, ⟨hxy, hc0⟩, hr⟩ := rep_f0.run net p q k hk
  simp only at hxy hc0
  subst hc0
  simp only [runFrom, Prod.mk.injEq, zero_add] at hr
  obtain ⟨hp, hq, hk'⟩ := hr
  have hc := (config_run net (config_runInput hxy)).1
  obtain ⟨hTM, hTm⟩ := hT x y hxy
  refine ⟨?_, ?_, ?_⟩
  · rw [← hp]; exact (hc.eq_pM (le_of_eq hTM.symm)).symm
  · rw [← hq]; exact (hc.eq_pm hTm).symm
  · rw [← hk', ← W_length net hxy]; exact hW x y hxy

/-- **From the computation to `P(2,n)`.** -/
theorem p2AtLeast_of_not_feasible {L : ℕ} (h : ¬ Feasible L (f0 n)) : P2AtLeast n (L + 1) := by
  intro net hT
  by_contra hcon
  push Not at hcon
  exact h ⟨net, good_of_top2 net hT fun x y hxy => Nat.lt_succ_iff.1 (hcon x y hxy)⟩

end Sortnet
