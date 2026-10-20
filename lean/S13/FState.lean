import Mathlib.Algebra.BigOperators.Fin
import Mathlib.Algebra.Order.BigOperators.Group.Finset
import Mathlib.Logic.Equiv.Fintype
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Positivity
import S13.Defs
import S13Comp

/-!
# f-states, the Kraft potential and the closure argument

An *f-state* records, for each pair of channels `(p, q)`, the largest number of comparators met so
far by a run that has the largest value `M` on channel `p` and the second largest value `m` on
channel `q` (`none` if no run is there). Runs at the same pair of channels behave identically from
then on, so the f-state determines everything that matters (`S13.Runs` makes this precise).

* `fstep a b f`: the f-state after the comparator `(lo, hi) = (a, b)`.
* `Feasible L f`: some continuation brings every run to one pair of outputs with at most `L`
  comparators met in total.
* `Phi`: the Kraft potential. It never decreases along a comparator and is at most `2 ^ L` at a goal.
* `pull σ f`: relabeling of the channels. Feasibility is invariant under it, and the two orientations
  of a comparator give f-states that differ by a transposition.
* `closure_sound`: a set of f-states that is closed in the sense checked by `Comp.checkAll` contains
  no feasible f-state.
-/

namespace Sortnet

open Finset

/-- An f-state on `n` channels. -/
abbrev FState (n : ℕ) := Fin n → Fin n → Option ℕ

/-- Maximum of two optional costs; `none` (no run) is the least element. -/
def omax : Option ℕ → Option ℕ → Option ℕ
  | none, o => o
  | some a, none => some a
  | some a, some b => some (max a b)

/-- One more comparator met. -/
def oinc (o : Option ℕ) : Option ℕ := o.map (· + 1)

theorem omax_comm (u v : Option ℕ) : omax u v = omax v u := by
  cases u <;> cases v <;> simp [omax, Nat.max_comm]

/-- The f-state after the comparator `(lo, hi) = (a, b)`, `a ≠ b`. A run with `M` on `a` or `b` meets
the comparator and `M` leaves on `b`; if `m` is on the other channel, `m` leaves on `a`. A run with only
`m` on `a` or `b` meets it and `m` leaves on `b`. Runs that meet the comparator gain one. -/
def fstep {n : ℕ} (a b : Fin n) (f : FState n) : FState n := fun p q =>
  if p = b then
    (if q = a then oinc (omax (f a b) (f b a))
     else if q = b then none else oinc (omax (f a q) (f b q)))
  else if p = a then none
  else if q = a then none
  else if q = b then oinc (omax (f p a) (f p b))
  else f p q

/-- The f-state after a generalized network. -/
def runF {n : ℕ} (C : List (GComparator n)) (f : FState n) : FState n :=
  C.foldl (fun g c => fstep c.lo c.hi g) f

@[simp] theorem runF_nil {n : ℕ} (f : FState n) : runF [] f = f := rfl

@[simp] theorem runF_cons {n : ℕ} (c : GComparator n) (C : List (GComparator n)) (f : FState n) :
    runF (c :: C) f = runF C (fstep c.lo c.hi f) := rfl

/-- A goal: all runs are at one pair of outputs `(oM, om)` and have met at most `L` comparators. -/
def Good {n : ℕ} (L : ℕ) (f : FState n) : Prop :=
  ∃ oM om : Fin n, ∀ p q c, f p q = some c → p = oM ∧ q = om ∧ c ≤ L

/-- Some continuation with at most `m` comparators reaches a goal. -/
def FeasIn {n : ℕ} (L m : ℕ) (f : FState n) : Prop :=
  ∃ C : List (GComparator n), C.length ≤ m ∧ Good L (runF C f)

/-- Some continuation reaches a goal. -/
def Feasible {n : ℕ} (L : ℕ) (f : FState n) : Prop :=
  ∃ C : List (GComparator n), Good L (runF C f)

theorem feasible_iff_exists_feasIn {n L : ℕ} {f : FState n} : Feasible L f ↔ ∃ m, FeasIn L m f := by
  constructor
  · rintro ⟨C, hC⟩; exact ⟨C.length, C, le_rfl, hC⟩
  · rintro ⟨m, C, -, hC⟩; exact ⟨C, hC⟩

/-! ## The Kraft potential -/

/-- `2 ^ cost`, and `0` for no run. -/
def wt : Option ℕ → ℕ
  | none => 0
  | some c => 2 ^ c

/-- `∑_{q ≠ p} 2 ^ f(p, q)`. -/
def rowSum {n : ℕ} (f : FState n) (p : Fin n) : ℕ := ∑ q, if q = p then 0 else wt (f p q)

/-- The Kraft potential `Φ(f) = ∑_p R(∑_{q ≠ p} 2 ^ f(p, q))`. -/
def Phi {n : ℕ} (f : FState n) : ℕ := ∑ p, Comp.R (rowSum f p)

namespace Comp

theorem R_zero : R 0 = 0 := rfl

theorem R_of_ne_zero {s : ℕ} (hs : s ≠ 0) : R s = 2 ^ Nat.log2 (2 * s - 1) := by
  simp [R, hs]

/-- `R s` is the least power of two that is `≥ s`. -/
theorem R_le_pow_iff {s : ℕ} (hs : s ≠ 0) (j : ℕ) : R s ≤ 2 ^ j ↔ s ≤ 2 ^ j := by
  rw [R_of_ne_zero hs, Nat.pow_le_pow_iff_right (by norm_num), ← Nat.lt_succ_iff,
    Nat.log2_lt (by omega), Nat.pow_succ]
  omega

theorem le_R (s : ℕ) : s ≤ R s := by
  by_cases hs : s = 0
  · simp [hs, R]
  · have h := (R_le_pow_iff hs (Nat.log2 (2 * s - 1))).1 (by rw [R_of_ne_zero hs])
    rwa [← R_of_ne_zero hs] at h

theorem R_mono {s t : ℕ} (h : s ≤ t) : R s ≤ R t := by
  by_cases hs : s = 0
  · simp [hs, R]
  · have ht : t ≠ 0 := by omega
    have h1 : t ≤ 2 ^ Nat.log2 (2 * t - 1) := by
      have := le_R t; rwa [R_of_ne_zero ht] at this
    rw [R_of_ne_zero ht]
    exact (R_le_pow_iff hs _).2 (le_trans h h1)

theorem R_pow (c : ℕ) : R (2 ^ c) = 2 ^ c :=
  le_antisymm ((R_le_pow_iff (by positivity) c).2 le_rfl) (le_R _)

theorem R_le_of_le_pow {s j : ℕ} (h : s ≤ 2 ^ j) : R s ≤ 2 ^ j := by
  by_cases hs : s = 0
  · simp [hs, R]
  · exact (R_le_pow_iff hs j).2 h

theorem R_two_mul (s : ℕ) : R (2 * s) = 2 * R s := by
  by_cases hs : s = 0
  · simp [hs, R]
  · have h2 : 2 * s ≠ 0 := by omega
    rw [R_of_ne_zero hs, R_of_ne_zero h2]
    set k := Nat.log2 (2 * s - 1) with hk
    have hlo : 2 ^ k ≤ 2 * s - 1 := (Nat.le_log2 (by omega)).1 le_rfl
    have hhi : 2 * s - 1 < 2 ^ (k + 1) := (Nat.log2_lt (by omega)).1 (Nat.lt_succ_self k)
    have : Nat.log2 (2 * (2 * s) - 1) = k + 1 := by
      apply le_antisymm
      · rw [← Nat.lt_succ_iff, Nat.log2_lt (by omega)]
        rw [Nat.pow_succ, Nat.pow_succ] at *; omega
      · rw [Nat.le_log2 (by omega)]
        rw [Nat.pow_succ] at *; omega
    rw [this, Nat.pow_succ]; ring

theorem R_max (s t : ℕ) : R (max s t) = max (R s) (R t) := by
  rcases le_total s t with h | h
  · rw [max_eq_right h, max_eq_right (R_mono h)]
  · rw [max_eq_left h, max_eq_left (R_mono h)]

end Comp

theorem wt_oinc_omax (u v : Option ℕ) : wt (oinc (omax u v)) = 2 * max (wt u) (wt v) := by
  cases u <;> cases v <;> simp [wt, oinc, omax, Nat.pow_succ, Nat.mul_comm]
  case some.some a b =>
    rcases le_total a b with h | h
    · rw [max_eq_right h, max_eq_right (Nat.pow_le_pow_right (by norm_num) h)]
    · rw [max_eq_left h, max_eq_left (Nat.pow_le_pow_right (by norm_num) h)]

theorem sum_split_two {M : Type*} [AddCommMonoid M] {n : ℕ} (g : Fin n → M) {a b : Fin n}
    (hab : a ≠ b) : ∑ q, g q = g a + g b + ∑ q ∈ (univ.erase a).erase b, g q := by
  rw [← add_sum_erase univ g (mem_univ a),
    ← add_sum_erase (univ.erase a) g (mem_erase.2 ⟨hab.symm, mem_univ b⟩), add_assoc]

theorem mem_rest {n : ℕ} {a b q : Fin n} (h : q ∈ (univ.erase a).erase b) : q ≠ a ∧ q ≠ b := by
  simp only [mem_erase, mem_univ, and_true] at h
  exact ⟨h.2, h.1⟩

section step
variable {n : ℕ} {a b : Fin n} (f : FState n)

theorem rowSum_fstep_lo (hab : a ≠ b) : rowSum (fstep a b f) a = 0 := by
  unfold rowSum
  apply sum_eq_zero
  intro q _
  simp [fstep, hab, wt]

theorem rowSum_fstep_hi (hab : a ≠ b) :
    rowSum (fstep a b f) b = 2 * max (wt (f a b)) (wt (f b a)) +
      ∑ q ∈ (univ.erase a).erase b, 2 * max (wt (f a q)) (wt (f b q)) := by
  unfold rowSum
  rw [sum_split_two _ hab]
  have e1 : (if a = b then 0 else wt (fstep a b f b a)) = 2 * max (wt (f a b)) (wt (f b a)) := by
    simp [hab, fstep, wt_oinc_omax]
  rw [e1, ite_eq_left rfl, add_zero]
  congr 1
  apply sum_congr rfl
  intro q hq
  obtain ⟨hqa, hqb⟩ := mem_rest hq
  simp [hqa, hqb, fstep, wt_oinc_omax]

theorem rowSum_lo_split (hab : a ≠ b) :
    rowSum f a = wt (f a b) + ∑ q ∈ (univ.erase a).erase b, wt (f a q) := by
  unfold rowSum
  rw [sum_split_two _ hab, ite_eq_left rfl, zero_add, ite_eq_right hab.symm]
  congr 1
  apply sum_congr rfl
  intro q hq
  simp [(mem_rest hq).1]

theorem rowSum_hi_split (hab : a ≠ b) :
    rowSum f b = wt (f b a) + ∑ q ∈ (univ.erase a).erase b, wt (f b q) := by
  unfold rowSum
  rw [sum_split_two _ hab, ite_eq_left rfl, add_zero, ite_eq_right hab]
  congr 1
  apply sum_congr rfl
  intro q hq
  simp [(mem_rest hq).2]

theorem rowSum_fstep_hi_ge (hab : a ≠ b) :
    2 * max (rowSum f a) (rowSum f b) ≤ rowSum (fstep a b f) b := by
  rw [rowSum_fstep_hi f hab, rowSum_lo_split f hab, rowSum_hi_split f hab, ← mul_sum, ← mul_add]
  apply Nat.mul_le_mul_left
  apply max_le
  · apply add_le_add (le_max_left _ _)
    exact sum_le_sum fun q _ => le_max_left _ _
  · apply add_le_add (le_max_right _ _)
    exact sum_le_sum fun q _ => le_max_right _ _

theorem rowSum_fstep_other (hab : a ≠ b) {p : Fin n} (hpa : p ≠ a) (hpb : p ≠ b) :
    rowSum f p ≤ rowSum (fstep a b f) p := by
  unfold rowSum
  rw [sum_split_two _ hab, sum_split_two (fun q => if q = p then 0 else wt (fstep a b f p q)) hab]
  have e1 : (if a = p then 0 else wt (fstep a b f p a)) = 0 := by
    simp [fstep, hpa, hpb, wt]
  have e2 : (if b = p then 0 else wt (fstep a b f p b)) = 2 * max (wt (f p a)) (wt (f p b)) := by
    simp [fstep, hpa, hpb, hab.symm, Ne.symm hpb, wt_oinc_omax]
  rw [e1, e2, ite_eq_right (Ne.symm hpa), ite_eq_right (Ne.symm hpb), zero_add]
  apply add_le_add
  · omega
  · apply le_of_eq
    apply sum_congr rfl
    intro q hq
    obtain ⟨hqa, hqb⟩ := mem_rest hq
    by_cases hqp : q = p
    · simp [hqp]
    · simp [hqp, fstep, hpa, hpb, hqa, hqb]

/-- **The Kraft potential never decreases along a comparator.** -/
theorem phi_le_phi_fstep (hab : a ≠ b) : Phi f ≤ Phi (fstep a b f) := by
  unfold Phi
  rw [sum_split_two _ hab, sum_split_two (fun p => Comp.R (rowSum (fstep a b f) p)) hab,
    rowSum_fstep_lo f hab, Comp.R_zero, zero_add]
  apply add_le_add
  · calc Comp.R (rowSum f a) + Comp.R (rowSum f b)
        ≤ 2 * max (Comp.R (rowSum f a)) (Comp.R (rowSum f b)) := by omega
      _ = Comp.R (2 * max (rowSum f a) (rowSum f b)) := by rw [Comp.R_two_mul, Comp.R_max]
      _ ≤ Comp.R (rowSum (fstep a b f) b) := Comp.R_mono (rowSum_fstep_hi_ge f hab)
  · apply sum_le_sum
    intro p hp
    obtain ⟨hpa, hpb⟩ := mem_rest hp
    exact Comp.R_mono (rowSum_fstep_other f hab hpa hpb)

end step

theorem phi_le_phi_runF {n : ℕ} (C : List (GComparator n)) (f : FState n) :
    Phi f ≤ Phi (runF C f) := by
  induction C generalizing f with
  | nil => exact le_rfl
  | cons c C ih => exact le_trans (phi_le_phi_fstep f c.ne) (ih _)

theorem phi_le_of_good {n L : ℕ} {f : FState n} (h : Good L f) : Phi f ≤ 2 ^ L := by
  obtain ⟨oM, om, hg⟩ := h
  have hrow : ∀ p, p ≠ oM → rowSum f p = 0 := by
    intro p hp
    apply sum_eq_zero
    intro q _
    split_ifs with hq
    · rfl
    · cases hf : f p q with
      | none => rfl
      | some c => exact absurd (hg p q c hf).1 hp
  unfold Phi
  rw [sum_eq_single oM (fun p _ hp => by rw [hrow p hp, Comp.R_zero]) (by simp)]
  apply Comp.R_le_of_le_pow
  unfold rowSum
  rw [sum_eq_single om]
  · split_ifs
    · exact Nat.zero_le _
    · cases hf : f oM om with
      | none => exact Nat.zero_le _
      | some c => exact Nat.pow_le_pow_right (by norm_num) (hg oM om c hf).2.2
  · intro q _ hq
    split_ifs
    · rfl
    · cases hf : f oM q with
      | none => rfl
      | some c => exact absurd (hg oM q c hf).2.1 hq
  · simp

/-- A state whose potential exceeds `2 ^ L` is not feasible. -/
theorem not_feasible_of_phi {n L : ℕ} {f : FState n} (h : 2 ^ L < Phi f) : ¬ Feasible L f := by
  rintro ⟨C, hC⟩
  have := le_trans (phi_le_phi_runF C f) (phi_le_of_good hC)
  omega

/-! ## Relabeling the channels -/

/-- Relabeling: entry `(p, q)` of `pull σ f` is entry `(σ p, σ q)` of `f`. -/
def pull {n : ℕ} (σ : Fin n → Fin n) (f : FState n) : FState n := fun p q => f (σ p) (σ q)

/-- The image of a comparator under an injective relabeling. -/
def mapC {n : ℕ} (τ : Fin n → Fin n) (hτ : Function.Injective τ) (c : GComparator n) :
    GComparator n :=
  ⟨τ c.lo, τ c.hi, fun h => c.ne (hτ h)⟩

section pull
variable {n : ℕ} (σ τ : Fin n → Fin n) (hσ : Function.Injective σ) (hστ : ∀ x, σ (τ x) = x)
include hσ hστ

theorem eq_iff_of_inv (x y : Fin n) : x = τ y ↔ σ x = y :=
  ⟨fun h => h ▸ hστ y, fun h => hσ (by rw [h, hστ])⟩

theorem fstep_pull (a b : Fin n) (f : FState n) :
    fstep (τ a) (τ b) (pull σ f) = pull σ (fstep a b f) := by
  funext p q
  simp only [fstep, pull, eq_iff_of_inv σ τ hσ hστ, hστ]

omit hσ in
theorem injective_of_inv : Function.Injective τ := fun x y h => by
  rw [← hστ x, ← hστ y, h]

theorem runF_pull (C : List (GComparator n)) (f : FState n) :
    runF (C.map (mapC τ (injective_of_inv σ τ hστ))) (pull σ f) = pull σ (runF C f) := by
  induction C generalizing f with
  | nil => rfl
  | cons c C ih =>
    simp only [List.map_cons, runF_cons, mapC]
    rw [fstep_pull σ τ hσ hστ, ih]

theorem good_pull {L : ℕ} {f : FState n} (h : Good L f) : Good L (pull σ f) := by
  obtain ⟨oM, om, hg⟩ := h
  refine ⟨τ oM, τ om, fun p q c hc => ?_⟩
  obtain ⟨h1, h2, h3⟩ := hg _ _ c hc
  exact ⟨(eq_iff_of_inv σ τ hσ hστ _ _).2 h1, (eq_iff_of_inv σ τ hσ hστ _ _).2 h2, h3⟩

end pull

/-- Feasibility within `m` comparators is invariant under injective relabelings. -/
theorem feasIn_pull {n L m : ℕ} {σ : Fin n → Fin n} (hσ : Function.Injective σ) {f : FState n}
    (h : FeasIn L m f) : FeasIn L m (pull σ f) := by
  have hsurj : Function.Surjective σ := Finite.injective_iff_surjective.1 hσ
  let τ := Function.surjInv hsurj
  have hστ : ∀ x, σ (τ x) = x := Function.surjInv_eq hsurj
  obtain ⟨C, hC, hg⟩ := h
  refine ⟨C.map (mapC τ (injective_of_inv σ τ hστ)), by simpa using hC, ?_⟩
  rw [runF_pull σ τ hσ hστ]
  exact good_pull σ τ hσ hστ hg

/-- The two orientations of a comparator give states that differ by the transposition. -/
theorem fstep_swap {n : ℕ} {a b : Fin n} (hab : a ≠ b) (f : FState n) :
    fstep b a f = pull (Equiv.swap a b) (fstep a b f) := by
  funext p q
  simp only [pull, fstep]
  by_cases hpa : p = a <;> by_cases hpb : p = b <;> by_cases hqa : q = a <;> by_cases hqb : q = b <;>
    subst_vars <;>
    simp_all [Equiv.swap_apply_of_ne_of_ne, omax_comm, Ne.symm hab]

/-- A comparator in either orientation can be replaced by the one with `lo < hi`. -/
theorem feasIn_oriented {n L m : ℕ} {f : FState n} (c : GComparator n)
    (h : FeasIn L m (fstep c.lo c.hi f)) :
    ∃ a b : Fin n, a < b ∧ FeasIn L m (fstep a b f) := by
  rcases lt_or_gt_of_ne c.ne with hlt | hgt
  · exact ⟨c.lo, c.hi, hlt, h⟩
  · refine ⟨c.hi, c.lo, hgt, ?_⟩
    rw [fstep_swap (Ne.symm c.ne) f] at h
    have h2 := feasIn_pull (Equiv.swap c.hi c.lo).injective h
    have hinv : pull (Equiv.swap c.hi c.lo) (pull (Equiv.swap c.hi c.lo) (fstep c.hi c.lo f)) =
        fstep c.hi c.lo f := by
      funext p q; simp [pull]
    rwa [hinv] at h2

/-! ## The closure argument -/

/-- **Closure argument.** Let `H` be a set of f-states that contains no goal, such that for every
state in `H` and every comparator `(a, b)` with `a < b` the next state is the same state, or has
potential above `2 ^ L`, or has an injective relabeling in `H`. Then no state of `H` is feasible. -/
theorem closure_sound {n : ℕ} (L : ℕ) (H : FState n → Prop)
    (h1 : ∀ k, H k → ¬ Good L k)
    (h2 : ∀ k, H k → ∀ a b : Fin n, a < b →
      fstep a b k = k ∨ 2 ^ L < Phi (fstep a b k) ∨
        ∃ σ : Fin n → Fin n, Function.Injective σ ∧ H (pull σ (fstep a b k))) :
    ∀ k, H k → ¬ Feasible L k := by
  suffices hm : ∀ m k, H k → ¬ FeasIn L m k by
    intro k hk hf
    obtain ⟨m, hm'⟩ := feasible_iff_exists_feasIn.1 hf
    exact hm m k hk hm'
  intro m
  induction m with
  | zero =>
    rintro k hk ⟨C, hC, hg⟩
    rw [List.length_eq_zero_iff.1 (Nat.le_zero.1 hC)] at hg
    exact h1 k hk hg
  | succ m ih =>
    rintro k hk ⟨C, hC, hg⟩
    cases C with
    | nil => exact h1 k hk hg
    | cons c C =>
      have hc : FeasIn L m (fstep c.lo c.hi k) :=
        ⟨C, by simp at hC; omega, by simpa using hg⟩
      obtain ⟨a, b, hab, hf⟩ := feasIn_oriented c hc
      rcases h2 k hk a b hab with he | hphi | ⟨σ, hσ, hH⟩
      · rw [he] at hf
        exact ih k hk hf
      · obtain ⟨C', -, hg'⟩ := hf
        exact not_feasible_of_phi hphi ⟨C', hg'⟩
      · exact ih _ hH (feasIn_pull hσ hf)

end Sortnet
