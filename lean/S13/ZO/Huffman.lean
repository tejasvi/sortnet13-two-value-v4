import Mathlib.Algebra.BigOperators.Group.Finset.Basic
import Mathlib.Algebra.Order.BigOperators.Group.Finset
import Mathlib.Order.Fin.Basic
import Mathlib.Data.Fin.SuccPred
import Mathlib.Logic.Equiv.Set
import Mathlib.Tactic.Ring
import Mathlib.Algebra.BigOperators.Ring.Finset
import Mathlib.Algebra.BigOperators.Fin
import S13.ZO.Basic

/-!
# The Huffman rule and the deletion of a constant channel

`LB.huffman`: let `E` be a set of channels `i` such that the vector with a single `true` at `i` lies in
`V`, and let `B i` be a bound for the vectors of `V` with `true` at `i`. Then every `b` with
`2 ^ b < 2 * ∑_{i ∈ E} 2 ^ (B i)` is a bound for `V`, i.e. `b ≤ ⌈log₂ ∑ 2 ^ (B i)⌉`. The proof is a
potential argument: after one comparator, the single `true` from `lo` and from `hi` both sit on `hi`,
the bound there is at least the larger of the two, the other bounds drop by at most one, and the sum of
`2 ^ bound` drops by at most half.

`LB.of_delete`: if channel `i` carries `true` in every vector of `S`, a bound for `S` with channel `i`
deleted is a bound for `S`. The certificate supplies its bounds for such deleted sets.

`LB.huffman_inv`, `LB.of_delete_false`: the same with `false` in place of `true`.
-/

namespace Sortnet.ZO

open Finset

variable {w : ℕ}

/-- The vector with a single `true`, at channel `i`. -/
def unit (i : Fin w) : Vec w := fun k => decide (k = i)

/-- The vectors of `V` with `true` at channel `i`. -/
def restrictT (V : Set (Vec w)) (i : Fin w) : Set (Vec w) := {v | v ∈ V ∧ v i = true}

/-- The vectors of `V` with `false` at channel `i`. -/
def restrictF (V : Set (Vec w)) (i : Fin w) : Set (Vec w) := {v | v ∈ V ∧ v i = false}

theorem LB.of_max {V : Set (Vec w)} {a b : ℕ} (ha : LB V a) (hb : LB V b) : LB V (max a b) :=
  fun cn hcn => max_le (ha cn hcn) (hb cn hcn)

theorem cmp_unit_other {lo hi i : Fin w} (hlo : i ≠ lo) (hhi : i ≠ hi) :
    cmp (lo, hi) (unit i) = unit i := by
  funext k
  simp only [cmp, unit]
  split_ifs with h1 h2
  · subst h1; simp [Ne.symm hlo, Ne.symm hhi]
  · subst h2; simp [Ne.symm hlo, Ne.symm hhi]
  · rfl

theorem cmp_unit_hi {lo hi : Fin w} (hne : lo ≠ hi) : cmp (lo, hi) (unit hi) = unit hi := by
  funext k
  simp only [cmp, unit]
  split_ifs with h1 h2
  · subst h1; simp [hne]
  · subst h2; simp
  · rfl

theorem cmp_unit_lo {lo hi : Fin w} (hne : lo ≠ hi) : cmp (lo, hi) (unit lo) = unit hi := by
  funext k
  simp only [cmp, unit]
  split_ifs with h1 h2
  · subst h1; simp [hne, Ne.symm hne]
  · subst h2; simp
  · simp [h1, h2]

/-- A comparator does not change a vector with `true` at its `hi` channel. -/
theorem cmp_of_hi_true {lo hi : Fin w} {v : Vec w} (h : v hi = true) : cmp (lo, hi) v = v := by
  funext k
  simp only [cmp]
  split_ifs with h1 h2
  · subst h1; simp [h]
  · subst h2; simp [h]
  · rfl

/-- On a vector with `true` at `lo`, a comparator acts as the transposition of its channels. -/
theorem cmp_of_lo_true {lo hi : Fin w} {v : Vec w} (h : v lo = true) :
    cmp (lo, hi) v = relabel (Equiv.swap lo hi) v := by
  funext k
  simp only [cmp, relabel]
  by_cases h1 : k = lo
  · subst h1; simp [h, Equiv.swap_apply_left]
  · by_cases h2 : k = hi
    · subst h2; simp [h1, h, Equiv.swap_apply_right]
    · rw [Equiv.swap_apply_of_ne_of_ne h1 h2]; simp [h1, h2]

theorem cmp_apply_other {lo hi k : Fin w} (h1 : k ≠ lo) (h2 : k ≠ hi) (v : Vec w) :
    cmp (lo, hi) v k = v k := by
  simp [cmp, h1, h2]

theorem wt_unit (i : Fin w) : wt (unit i) = 1 := by
  unfold wt unit
  rw [Finset.card_eq_one]
  exact ⟨i, by ext k; simp⟩

theorem unit_injective : Function.Injective (unit : Fin w → Vec w) := by
  intro i j h
  have := congrFun h i
  simp [unit] at this
  exact this

/-- The potential inequality for one comparator. -/
theorem sum_le_two_mul_sum (E : Finset (Fin w)) (B : Fin w → ℕ) {lo hi : Fin w} (hne : lo ≠ hi) :
    let E' := ((E.erase lo).erase hi) ∪ (if lo ∈ E ∨ hi ∈ E then {hi} else ∅)
    let B' : Fin w → ℕ := fun k => if k = hi then
      max (if lo ∈ E then B lo else 0) (if hi ∈ E then B hi else 0) else B k - 1
    ∑ i ∈ E, 2 ^ B i ≤ 2 * ∑ i ∈ E', 2 ^ B' i := by
  intro E' B'
  set R := (E.erase lo).erase hi with hR
  have hhiR : hi ∉ R := by simp [hR]
  have hloR : lo ∉ R := by simp [hR]
  -- split the sum over `E`
  have hE : ∑ i ∈ E, 2 ^ B i = ∑ i ∈ R, 2 ^ B i + (if lo ∈ E then 2 ^ B lo else 0) +
      (if hi ∈ E then 2 ^ B hi else 0) := by
    have h1 : ∑ i ∈ E, 2 ^ B i = (if lo ∈ E then 2 ^ B lo else 0) + ∑ i ∈ E.erase lo, 2 ^ B i := by
      split_ifs with h
      · exact (Finset.add_sum_erase E (fun i => 2 ^ B i) h).symm
      · rw [Finset.erase_eq_of_notMem h, zero_add]
    have h2 : ∑ i ∈ E.erase lo, 2 ^ B i =
        (if hi ∈ E then 2 ^ B hi else 0) + ∑ i ∈ R, 2 ^ B i := by
      split_ifs with h
      · rw [hR]
        exact (Finset.add_sum_erase (E.erase lo) (fun i => 2 ^ B i)
          (Finset.mem_erase.2 ⟨Ne.symm hne, h⟩)).symm
      · rw [hR, Finset.erase_eq_of_notMem (fun hm => h (Finset.mem_of_mem_erase hm)), zero_add]
    rw [h1, h2]; ring
  -- the sum over `E'`
  have hR' : ∑ i ∈ R, 2 ^ B i ≤ 2 * ∑ i ∈ R, 2 ^ B' i := by
    rw [Finset.mul_sum]
    apply Finset.sum_le_sum
    intro i hi'
    have hih : i ≠ hi := fun h => hhiR (h ▸ hi')
    simp only [B', ite_eq_right hih]
    rcases Nat.eq_zero_or_pos (B i) with h0 | hpos
    · rw [h0]; simp
    · have : B i = (B i - 1) + 1 := by omega
      conv_lhs => rw [this, pow_succ]
      omega
  by_cases hboth : lo ∈ E ∨ hi ∈ E
  · have hE' : ∑ i ∈ E', 2 ^ B' i = ∑ i ∈ R, 2 ^ B' i + 2 ^ B' hi := by
      simp only [E', ite_eq_left hboth]
      rw [Finset.sum_union (by simp), Finset.sum_singleton]
    rw [hE, hE']
    have hmax : (if lo ∈ E then 2 ^ B lo else 0) + (if hi ∈ E then 2 ^ B hi else 0) ≤
        2 * 2 ^ B' hi := by
      have hB'hi : B' hi = max (if lo ∈ E then B lo else 0) (if hi ∈ E then B hi else 0) := by
        simp [B']
      rw [hB'hi]
      have h1 : (if lo ∈ E then 2 ^ B lo else 0) ≤ 2 ^ (if lo ∈ E then B lo else 0) := by
        by_cases h : lo ∈ E <;> simp [h]
      have h2 : (if hi ∈ E then 2 ^ B hi else 0) ≤ 2 ^ (if hi ∈ E then B hi else 0) := by
        by_cases h : hi ∈ E <;> simp [h]
      have h3 := Nat.pow_le_pow_right (show 0 < 2 by norm_num)
        (le_max_left (if lo ∈ E then B lo else 0) (if hi ∈ E then B hi else 0))
      have h4 := Nat.pow_le_pow_right (show 0 < 2 by norm_num)
        (le_max_right (if lo ∈ E then B lo else 0) (if hi ∈ E then B hi else 0))
      omega
    omega
  · have hE' : E' = R := by simp only [E', ite_eq_right hboth, Finset.union_empty]; rfl
    push Not at hboth
    rw [hE, hE', ite_eq_right hboth.1, ite_eq_right hboth.2]
    omega

/-- **Huffman rule** (single `true`). -/
theorem LB.huffman : ∀ (n : ℕ) (V : Set (Vec w)) (E : Finset (Fin w)) (B : Fin w → ℕ) (b : ℕ)
    (cn : List (Cmp w)), cn.length = n →
    (∀ i ∈ E, unit i ∈ V) → (∀ i ∈ E, LB (restrictT V i) (B i)) →
    2 ^ b < 2 * ∑ i ∈ E, 2 ^ B i → Works cn V → b ≤ n := by
  intro n
  induction n using Nat.strong_induction_on with
  | _ n ih =>
  intro V E B b cn hlen hunit hB hb hcn
  rcases cn with _ | ⟨c, cn⟩
  · -- the empty network: at most one unit vector, and its bound is 0
    simp only [List.length_nil] at hlen
    subst hlen
    have hcard : E.card ≤ 1 := by
      rw [Finset.card_le_one]
      intro i hi j hj
      have := hcn _ (hunit i hi) _ (hunit j hj) (by rw [run_nil, run_nil, wt_unit, wt_unit])
      exact unit_injective this
    rcases E.eq_empty_or_nonempty with h | ⟨i, hi⟩
    · rw [h] at hb; simp at hb
    · have h : E = {i} := Finset.eq_singleton_iff_unique_mem.2
        ⟨hi, fun j hj => Finset.card_le_one.1 hcard j hj i hi⟩
      rw [h] at hb hB
      simp only [Finset.sum_singleton] at hb
      have hb' : b ≤ B i := by
        by_contra hc
        push Not at hc
        have : 2 ^ (B i + 1) ≤ 2 ^ b := Nat.pow_le_pow_right (by norm_num) hc
        rw [pow_succ] at this
        omega
      have := hB i (by simp) [] (hcn.mono (fun v hv => hv.1))
      simp at this
      omega
  · simp only [List.length_cons] at hlen
    have hrest : Works cn (cmp c '' V) := works_cons.1 hcn
    obtain ⟨lo, hi⟩ := c
    rcases eq_or_ne lo hi with heq | hne
    · -- the identity comparator
      subst heq
      have : cmp (lo, lo) '' V = V := by
        ext v; simp [cmp_self]
      rw [this] at hrest
      have := ih cn.length (by omega) V E B b cn rfl hunit hB hb hrest
      omega
    · rcases Nat.eq_zero_or_pos b with hb0 | hbpos
      · omega
      set E' := ((E.erase lo).erase hi) ∪ (if lo ∈ E ∨ hi ∈ E then {hi} else ∅) with hE'
      set B' : Fin w → ℕ := fun k => if k = hi then
        max (if lo ∈ E then B lo else 0) (if hi ∈ E then B hi else 0) else B k - 1 with hB'
      have hpot : ∑ i ∈ E, 2 ^ B i ≤ 2 * ∑ i ∈ E', 2 ^ B' i := sum_le_two_mul_sum E B hne
      have hmem : ∀ i ∈ E', (i ≠ lo ∧ i ≠ hi ∧ i ∈ E) ∨ (i = hi ∧ (lo ∈ E ∨ hi ∈ E)) := by
        intro i hi'
        simp only [hE', Finset.mem_union, Finset.mem_erase] at hi'
        rcases hi' with ⟨h1, h2, h3⟩ | h
        · exact Or.inl ⟨h2, h1, h3⟩
        · split_ifs at h with hc
          · exact Or.inr ⟨Finset.mem_singleton.1 h, hc⟩
          · simp at h
      have hunit' : ∀ i ∈ E', unit i ∈ cmp (lo, hi) '' V := by
        intro i hi'
        rcases hmem i hi' with ⟨h1, h2, h3⟩ | ⟨rfl, h⟩
        · exact ⟨unit i, hunit i h3, cmp_unit_other h1 h2⟩
        · rcases h with h | h
          · exact ⟨unit lo, hunit lo h, cmp_unit_lo hne⟩
          · exact ⟨unit i, hunit i h, cmp_unit_hi hne⟩
      have hB'' : ∀ i ∈ E', LB (restrictT (cmp (lo, hi) '' V) i) (B' i) := by
        intro i hi'
        rcases hmem i hi' with ⟨h1, h2, h3⟩ | ⟨rfl, h⟩
        · -- a channel the comparator does not touch
          have hset : restrictT (cmp (lo, hi) '' V) i = cmp (lo, hi) '' restrictT V i := by
            ext v
            simp only [restrictT, Set.mem_image, Set.mem_ofPred_eq]
            constructor
            · rintro ⟨⟨u, hu, rfl⟩, hv⟩
              exact ⟨u, ⟨hu, by rwa [cmp_apply_other h1 h2] at hv⟩, rfl⟩
            · rintro ⟨u, ⟨hu, hui⟩, rfl⟩
              exact ⟨⟨u, hu, rfl⟩, by rw [cmp_apply_other h1 h2]; exact hui⟩
          rw [hset]
          simp only [hB', ite_eq_right h2]
          exact (hB i h3).cmp_image (lo, hi)
        · -- the channel `hi`, where the single `true` from `lo` and from `hi` end
          simp only [hB', ite_eq_left rfl]
          apply LB.of_max
          · split_ifs with hl
            · apply (((hB lo hl).map_relabel (Equiv.swap lo i))).mono
              rintro _ ⟨v, ⟨hv, hvl⟩, rfl⟩
              refine ⟨⟨v, hv, cmp_of_lo_true hvl⟩, ?_⟩
              simp [relabel, Equiv.swap_apply_right, hvl]
            · exact LB.zero _
          · split_ifs with hh
            · apply (hB i hh).mono
              rintro v ⟨hv, hvi⟩
              exact ⟨⟨v, hv, cmp_of_hi_true hvi⟩, hvi⟩
            · exact LB.zero _
      have hb' : 2 ^ (b - 1) < 2 * ∑ i ∈ E', 2 ^ B' i := by
        have : 2 ^ b = 2 * 2 ^ (b - 1) := by
          rw [← pow_succ']; congr 1; omega
        omega
      have := ih cn.length (by omega) _ E' B' (b - 1) cn rfl hunit' hB'' hb' hrest
      omega

/-- **Huffman rule**, as a bound. -/
theorem LB.of_huffman {V : Set (Vec w)} {E : Finset (Fin w)} {B : Fin w → ℕ} {b : ℕ}
    (hunit : ∀ i ∈ E, unit i ∈ V) (hB : ∀ i ∈ E, LB (restrictT V i) (B i))
    (hb : 2 ^ b < 2 * ∑ i ∈ E, 2 ^ B i) : LB V b :=
  fun cn hcn => LB.huffman cn.length V E B b cn rfl hunit hB hb hcn

theorem inv_unit_mem_iff {V : Set (Vec w)} {i : Fin w} : unit i ∈ inv '' V ↔ inv (unit i) ∈ V := by
  constructor
  · rintro ⟨u, hu, h⟩; rw [← h, inv_inv]; exact hu
  · intro h; exact ⟨inv (unit i), h, inv_inv _⟩

theorem restrictT_inv (V : Set (Vec w)) (i : Fin w) :
    restrictT (inv '' V) i = inv '' restrictF V i := by
  ext v
  simp only [restrictT, restrictF, Set.mem_image, Set.mem_ofPred_eq]
  constructor
  · rintro ⟨⟨u, hu, rfl⟩, hv⟩
    exact ⟨u, ⟨hu, by simpa [inv] using hv⟩, rfl⟩
  · rintro ⟨u, ⟨hu, hui⟩, rfl⟩
    exact ⟨⟨u, hu, rfl⟩, by simp [inv, hui]⟩

/-- **Huffman rule** (single `false`). -/
theorem LB.of_huffman_inv {V : Set (Vec w)} {E : Finset (Fin w)} {B : Fin w → ℕ} {b : ℕ}
    (hunit : ∀ i ∈ E, inv (unit i) ∈ V) (hB : ∀ i ∈ E, LB (restrictF V i) (B i))
    (hb : 2 ^ b < 2 * ∑ i ∈ E, 2 ^ B i) : LB V b := by
  rw [← LB.map_inv_iff]
  apply LB.of_huffman (E := E) (B := B) _ _ hb
  · intro i hi; exact inv_unit_mem_iff.2 (hunit i hi)
  · intro i hi; rw [restrictT_inv]; exact (hB i hi).map_inv

/-! ## Deleting a constant channel -/

/-- Delete channel `i`. -/
def del (i : Fin (w + 1)) (v : Vec (w + 1)) : Vec w := fun k => v (i.succAbove k)

theorem wt_del {i : Fin (w + 1)} {v : Vec (w + 1)} (h : v i = true) : wt v = wt (del i v) + 1 := by
  unfold wt del
  rw [Finset.card_filter, Finset.card_filter,
    Fin.sum_univ_succAbove (fun k => if v k = true then 1 else 0) i]
  simp [h, add_comm]

theorem del_injective_on {i : Fin (w + 1)} {u v : Vec (w + 1)} (hu : u i = true) (hv : v i = true)
    (h : del i u = del i v) : u = v := by
  funext k
  rcases Fin.eq_self_or_eq_succAbove i k with rfl | ⟨j, rfl⟩
  · rw [hu, hv]
  · exact congrFun h j

/-- Two injective maps `Fin w → Fin (w + 1)` with the same range differ by a permutation. -/
theorem exists_perm_of_range_eq {f g : Fin w → Fin (w + 1)} (hf : Function.Injective f)
    (hg : Function.Injective g) (hr : Set.range f = Set.range g) :
    ∃ ρ : Equiv.Perm (Fin w), ∀ k, f (ρ k) = g k := by
  refine ⟨(Equiv.ofInjective g hg).trans ((Set.equivOfEq hr.symm).trans (Equiv.ofInjective f hf).symm),
    fun k => ?_⟩
  simp only [Equiv.trans_apply]
  rw [Equiv.apply_ofInjective_symm hf]
  simp

/-- **Deleting a constant channel.** If channel `i` carries `true` in every vector of `S`, a bound for
`S` with channel `i` deleted is a bound for `S`. -/
theorem LB.of_delete : ∀ (n : ℕ) (S : Set (Vec (w + 1))) (i : Fin (w + 1)) (b : ℕ)
    (cn : List (Cmp (w + 1))), cn.length = n → (∀ v ∈ S, v i = true) → LB (del i '' S) b →
    Works cn S → b ≤ n := by
  intro n
  induction n using Nat.strong_induction_on with
  | _ n ih =>
  intro S i b cn hlen hS hb hcn
  rcases cn with _ | ⟨c, cn⟩
  · simp only [List.length_nil] at hlen
    subst hlen
    apply hb []
    rintro _ ⟨u, hu, rfl⟩ _ ⟨v, hv, rfl⟩ huv
    simp only [run_nil] at huv ⊢
    have := hcn u hu v hv (by rw [run_nil, run_nil, wt_del (hS u hu), wt_del (hS v hv), huv])
    simp only [run_nil] at this
    rw [this]
  · simp only [List.length_cons] at hlen
    have hrest : Works cn (cmp c '' S) := works_cons.1 hcn
    obtain ⟨lo, hi⟩ := c
    by_cases hhi : hi = i
    · -- the maximum goes to the constant channel: nothing changes
      subst hhi
      have : cmp (lo, hi) '' S = S := by
        ext v
        simp only [Set.mem_image]
        constructor
        · rintro ⟨u, hu, rfl⟩; rwa [cmp_of_hi_true (hS u hu)]
        · intro hv; exact ⟨v, hv, cmp_of_hi_true (hS v hv)⟩
      rw [this] at hrest
      have := ih cn.length (by omega) S hi b cn rfl hS hb hrest
      omega
    by_cases hlo : lo = i
    · -- the minimum goes to the constant channel: the constant moves to `hi`
      subst hlo
      have himg : cmp (lo, hi) '' S = relabel (Equiv.swap lo hi) '' S := by
        ext v
        simp only [Set.mem_image]
        constructor
        · rintro ⟨u, hu, rfl⟩; exact ⟨u, hu, (cmp_of_lo_true (hS u hu)).symm⟩
        · rintro ⟨u, hu, rfl⟩; exact ⟨u, hu, cmp_of_lo_true (hS u hu)⟩
      rw [himg] at hrest
      have hS' : ∀ v ∈ relabel (Equiv.swap lo hi) '' S, v hi = true := by
        rintro _ ⟨u, hu, rfl⟩
        simp [relabel, Equiv.swap_apply_right, hS u hu]
      -- deleting `hi` after the swap is deleting `lo` up to a relabeling
      have hrf : Set.range lo.succAbove = {lo}ᶜ := Fin.range_succAbove lo
      have hrg : Set.range (fun k => Equiv.swap lo hi (hi.succAbove k)) = {lo}ᶜ := by
        ext j
        simp only [Set.mem_range, Set.mem_compl_iff, Set.mem_singleton_iff]
        constructor
        · rintro ⟨m, rfl⟩ h
          have := congrArg (Equiv.swap lo hi) h
          rw [Equiv.swap_apply_self, Equiv.swap_apply_left] at this
          exact Fin.succAbove_ne hi m this
        · intro hj
          have hj' : Equiv.swap lo hi j ≠ hi := by
            intro h
            have := congrArg (Equiv.swap lo hi) h
            rw [Equiv.swap_apply_self, Equiv.swap_apply_right] at this
            exact hj this
          obtain ⟨m, hm⟩ := Fin.exists_succAbove_eq hj'
          exact ⟨m, by rw [hm, Equiv.swap_apply_self]⟩
      obtain ⟨ρ, hρ⟩ := exists_perm_of_range_eq (f := lo.succAbove)
        (g := fun k => Equiv.swap lo hi (hi.succAbove k)) Fin.succAbove_right_injective
        (fun a b h => Fin.succAbove_right_injective ((Equiv.swap lo hi).injective h))
        (hrf.trans hrg.symm)
      have hdel : del hi '' (relabel (Equiv.swap lo hi) '' S) = relabel ρ '' (del lo '' S) := by
        ext v
        simp only [Set.mem_image]
        constructor
        · rintro ⟨_, ⟨u, hu, rfl⟩, rfl⟩
          refine ⟨del lo u, ⟨u, hu, rfl⟩, ?_⟩
          funext k
          simp only [relabel, del]
          rw [hρ]
        · rintro ⟨_, ⟨u, hu, rfl⟩, rfl⟩
          refine ⟨relabel (Equiv.swap lo hi) u, ⟨u, hu, rfl⟩, ?_⟩
          funext k
          simp only [relabel, del]
          rw [hρ]
      have hb' : LB (del hi '' (relabel (Equiv.swap lo hi) '' S)) b := by
        rw [hdel]; exact hb.map_relabel ρ
      have := ih cn.length (by omega) _ hi b cn rfl hS' hb' hrest
      omega
    · -- the comparator avoids the constant channel
      obtain ⟨lo', hlo'⟩ := Fin.exists_succAbove_eq hlo
      obtain ⟨hi', hhi'⟩ := Fin.exists_succAbove_eq hhi
      have hcomm : ∀ v : Vec (w + 1), del i (cmp (lo, hi) v) = cmp (lo', hi') (del i v) := by
        intro v
        funext k
        simp only [del, cmp, ← hlo', ← hhi', Fin.succAbove_right_inj]
      have hS' : ∀ v ∈ cmp (lo, hi) '' S, v i = true := by
        rintro _ ⟨u, hu, rfl⟩
        rw [cmp_apply_other (Ne.symm hlo) (Ne.symm hhi)]
        exact hS u hu
      have hdel : del i '' (cmp (lo, hi) '' S) = cmp (lo', hi') '' (del i '' S) := by
        ext v
        simp only [Set.mem_image]
        constructor
        · rintro ⟨_, ⟨u, hu, rfl⟩, rfl⟩; exact ⟨del i u, ⟨u, hu, rfl⟩, (hcomm u).symm⟩
        · rintro ⟨_, ⟨u, hu, rfl⟩, rfl⟩; exact ⟨cmp (lo, hi) u, ⟨u, hu, rfl⟩, hcomm u⟩
      have hb' : LB (del i '' (cmp (lo, hi) '' S)) (b - 1) := by
        rw [hdel]; exact hb.cmp_image _
      have := ih cn.length (by omega) _ i (b - 1) cn rfl hS' hb' hrest
      omega

theorem LB.of_delete' {S : Set (Vec (w + 1))} {i : Fin (w + 1)} {b : ℕ} (hS : ∀ v ∈ S, v i = true)
    (hb : LB (del i '' S) b) : LB S b :=
  fun cn hcn => LB.of_delete cn.length S i b cn rfl hS hb hcn

theorem del_inv (i : Fin (w + 1)) (v : Vec (w + 1)) : del i (inv v) = inv (del i v) := rfl

/-- Deleting a channel that carries `false` in every vector. -/
theorem LB.of_delete_false {S : Set (Vec (w + 1))} {i : Fin (w + 1)} {b : ℕ}
    (hS : ∀ v ∈ S, v i = false) (hb : LB (del i '' S) b) : LB S b := by
  rw [← LB.map_inv_iff]
  apply LB.of_delete' (i := i)
  · rintro _ ⟨u, hu, rfl⟩; simp [inv, hS u hu]
  · have : del i '' (inv '' S) = inv '' (del i '' S) := by
      ext v
      simp only [Set.mem_image]
      constructor
      · rintro ⟨_, ⟨u, hu, rfl⟩, rfl⟩; exact ⟨del i u, ⟨u, hu, rfl⟩, rfl⟩
      · rintro ⟨_, ⟨u, hu, rfl⟩, rfl⟩; exact ⟨inv u, ⟨u, hu, rfl⟩, rfl⟩
    rw [this]; exact hb.map_inv

end Sortnet.ZO
