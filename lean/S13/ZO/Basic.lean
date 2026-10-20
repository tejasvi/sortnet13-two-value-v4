import Mathlib.Data.Fintype.Card
import Mathlib.Data.Fintype.Pi
import Mathlib.Logic.Equiv.Fintype
import Mathlib.GroupTheory.Perm.Basic
import Mathlib.Order.Fin.Basic
import Mathlib.Tactic.NormNum

/-!
# Lower bounds for comparator networks on sets of 0-1 vectors

This is the proof system of Harder's certificates for `S(11) ≥ 35`. A comparator is any pair
`(lo, hi)` of channels; it puts the minimum (`&&`) of the two values on `lo` and the maximum (`||`)
on `hi` (so `lo = hi` is the identity, and both orientations occur). A network *works* on a set `V`
of 0-1 vectors if outputs of equal weight are equal; a sorting network works on every set, because
a sorted 0-1 vector is determined by its weight. `LB V b` says that every network that works on `V`
has at least `b` comparators.

The rules used by the certificate checker:
* `LB.mono`: a bound for a subset is a bound for the set;
* `LB.relabel_iff`, `LB.invert_iff`: invariance under relabeling the channels and under inverting all
  values;
* `LB.one_of_collision`: two different vectors of equal weight force a comparator;
* `LB.succ`: the successor rule (every first comparator either leaves the set unchanged up to a
  relabeling, or leads to a set with bound `b - 1`).
-/

namespace Sortnet.ZO

/-- A 0-1 vector on `w` channels (`true` is the larger value). -/
abbrev Vec (w : ℕ) := Fin w → Bool

/-- A comparator: the minimum goes to channel `c.1`, the maximum to channel `c.2`. -/
abbrev Cmp (w : ℕ) := Fin w × Fin w

variable {w : ℕ}

/-- Apply a comparator. -/
def cmp (c : Cmp w) (v : Vec w) : Vec w := fun k =>
  if k = c.1 then (v c.1 && v c.2) else if k = c.2 then (v c.1 || v c.2) else v k

/-- Apply a network (a list of comparators, from the head). -/
def run (cn : List (Cmp w)) (v : Vec w) : Vec w := cn.foldl (fun v c => cmp c v) v

@[simp] theorem run_nil (v : Vec w) : run [] v = v := rfl

@[simp] theorem run_cons (c : Cmp w) (cn : List (Cmp w)) (v : Vec w) :
    run (c :: cn) v = run cn (cmp c v) := rfl

/-- The weight of a vector: its number of `true` entries. -/
def wt (v : Vec w) : ℕ := (Finset.univ.filter fun k => v k = true).card

/-- The network `cn` works on `V`: outputs of equal weight are equal. -/
def Works (cn : List (Cmp w)) (V : Set (Vec w)) : Prop :=
  ∀ u ∈ V, ∀ v ∈ V, wt (run cn u) = wt (run cn v) → run cn u = run cn v

/-- Every network that works on `V` has at least `b` comparators. -/
def LB (V : Set (Vec w)) (b : ℕ) : Prop := ∀ cn : List (Cmp w), Works cn V → b ≤ cn.length

theorem works_cons {c : Cmp w} {cn : List (Cmp w)} {V : Set (Vec w)} :
    Works (c :: cn) V ↔ Works cn (cmp c '' V) := by
  constructor
  · rintro h _ ⟨u, hu, rfl⟩ _ ⟨v, hv, rfl⟩ huv
    exact h u hu v hv huv
  · intro h u hu v hv huv
    exact h _ ⟨u, hu, rfl⟩ _ ⟨v, hv, rfl⟩ huv

theorem Works.mono {cn : List (Cmp w)} {V V' : Set (Vec w)} (h : Works cn V') (hV : V ⊆ V') :
    Works cn V := fun u hu v hv => h u (hV hu) v (hV hv)

theorem LB.mono {V V' : Set (Vec w)} {b : ℕ} (h : LB V b) (hV : V ⊆ V') : LB V' b :=
  fun cn hcn => h cn (hcn.mono hV)

theorem LB.zero (V : Set (Vec w)) : LB V 0 := fun _ _ => Nat.zero_le _

theorem LB.weaken {V : Set (Vec w)} {b b' : ℕ} (h : LB V b) (hb : b' ≤ b) : LB V b' :=
  fun cn hcn => le_trans hb (h cn hcn)

/-- Two different vectors of equal weight force at least one comparator. -/
theorem LB.one_of_collision {V : Set (Vec w)} {u v : Vec w} (hu : u ∈ V) (hv : v ∈ V) (huv : u ≠ v)
    (hwt : wt u = wt v) : LB V 1 := by
  intro cn hcn
  rcases cn with _ | ⟨c, cn⟩
  · exact absurd (hcn u hu v hv hwt) huv
  · simp

/-- One comparator lowers a bound by at most one. -/
theorem LB.cmp_image {V : Set (Vec w)} {b : ℕ} (h : LB V b) (c : Cmp w) : LB (cmp c '' V) (b - 1) := by
  intro cn hcn
  have := h (c :: cn) (works_cons.2 hcn)
  simp at this
  omega

/-! ## Relabeling the channels -/

/-- Relabel a vector: channel `k` of the result carries channel `σ k` of `v`. -/
def relabel (σ : Equiv.Perm (Fin w)) (v : Vec w) : Vec w := fun k => v (σ k)

@[simp] theorem relabel_one (v : Vec w) : relabel 1 v = v := rfl

theorem image_relabel_one (V : Set (Vec w)) : relabel 1 '' V = V := by
  ext v; simp

/-- The comparator that acts on relabeled vectors like `c` on the originals. -/
def relC (σ : Equiv.Perm (Fin w)) (c : Cmp w) : Cmp w := (σ.symm c.1, σ.symm c.2)

theorem cmp_rel (σ : Equiv.Perm (Fin w)) (c : Cmp w) (v : Vec w) :
    cmp (relC σ c) (relabel σ v) = relabel σ (cmp c v) := by
  funext k
  simp only [cmp, relabel, relC, Equiv.apply_symm_apply]
  have e1 : (k = σ.symm c.1) ↔ (σ k = c.1) := by
    constructor
    · rintro rfl; simp
    · intro h; rw [← h]; simp
  have e2 : (k = σ.symm c.2) ↔ (σ k = c.2) := by
    constructor
    · rintro rfl; simp
    · intro h; rw [← h]; simp
  by_cases h1 : σ k = c.1
  · rw [ite_eq_left (e1.2 h1), ite_eq_left h1]
  · rw [ite_eq_right (fun h => h1 (e1.1 h)), ite_eq_right h1]
    by_cases h2 : σ k = c.2
    · rw [ite_eq_left (e2.2 h2), ite_eq_left h2]
    · rw [ite_eq_right (fun h => h2 (e2.1 h)), ite_eq_right h2]

theorem run_rel (σ : Equiv.Perm (Fin w)) (cn : List (Cmp w)) (v : Vec w) :
    run (cn.map (relC σ)) (relabel σ v) = relabel σ (run cn v) := by
  induction cn generalizing v with
  | nil => rfl
  | cons c cn ih => simp only [List.map_cons, run_cons, cmp_rel, ih]

theorem wt_rel (σ : Equiv.Perm (Fin w)) (v : Vec w) : wt (relabel σ v) = wt v := by
  unfold wt relabel
  apply Finset.card_bij (fun k _ => σ k)
  · intro k hk; simpa using hk
  · intro a _ b _ h; exact σ.injective h
  · intro k hk
    refine ⟨σ.symm k, by simpa using hk, by simp⟩

theorem rel_injective (σ : Equiv.Perm (Fin w)) : Function.Injective (relabel σ) := by
  intro u v h
  funext k
  have := congrFun h (σ.symm k)
  simpa [relabel] using this

theorem rel_rel_symm (σ : Equiv.Perm (Fin w)) (v : Vec w) : relabel σ.symm (relabel σ v) = v := by
  funext k; simp [relabel]

theorem Works.map_relabel {cn : List (Cmp w)} {V : Set (Vec w)} (h : Works cn V) (σ : Equiv.Perm (Fin w)) :
    Works (cn.map (relC σ)) (relabel σ '' V) := by
  rintro _ ⟨u, hu, rfl⟩ _ ⟨v, hv, rfl⟩ huv
  rw [run_rel, run_rel, wt_rel, wt_rel] at huv
  rw [run_rel, run_rel, h u hu v hv huv]

theorem LB.map_relabel {V : Set (Vec w)} {b : ℕ} (h : LB V b) (σ : Equiv.Perm (Fin w)) : LB (relabel σ '' V) b := by
  intro cn hcn
  have h2 := hcn.map_relabel σ.symm
  have himg : relabel σ.symm '' (relabel σ '' V) = V := by
    ext v
    simp only [Set.mem_image]
    constructor
    · rintro ⟨_, ⟨u, hu, rfl⟩, rfl⟩; rwa [rel_rel_symm]
    · intro hv; exact ⟨relabel σ v, ⟨v, hv, rfl⟩, rel_rel_symm σ v⟩
  rw [himg] at h2
  have := h _ h2
  simpa using this

theorem LB.rel_iff {V : Set (Vec w)} {b : ℕ} (σ : Equiv.Perm (Fin w)) : LB (relabel σ '' V) b ↔ LB V b := by
  constructor
  · intro h
    have := h.map_relabel σ.symm
    have himg : relabel σ.symm '' (relabel σ '' V) = V := by
      ext v
      simp only [Set.mem_image]
      constructor
      · rintro ⟨_, ⟨u, hu, rfl⟩, rfl⟩; rwa [rel_rel_symm]
      · intro hv; exact ⟨relabel σ v, ⟨v, hv, rfl⟩, rel_rel_symm σ v⟩
    rwa [himg] at this
  · intro h; exact h.map_relabel σ

/-! ## Inverting all values -/

/-- Invert every value. -/
def inv (v : Vec w) : Vec w := fun k => !v k

/-- The comparator with its two channels exchanged. -/
def flipC (c : Cmp w) : Cmp w := (c.2, c.1)

theorem cmp_inv (c : Cmp w) (v : Vec w) : cmp (flipC c) (inv v) = inv (cmp c v) := by
  obtain ⟨a, b⟩ := c
  funext k
  simp only [cmp, inv, flipC]
  by_cases h1 : k = a
  · subst h1
    by_cases h2 : k = b
    · subst h2; simp
    · simp [h2, Bool.and_comm]
  · by_cases h2 : k = b
    · subst h2; simp [h1, Bool.and_comm]
    · simp [h1, h2]

theorem run_inv (cn : List (Cmp w)) (v : Vec w) : run (cn.map flipC) (inv v) = inv (run cn v) := by
  induction cn generalizing v with
  | nil => rfl
  | cons c cn ih => simp only [List.map_cons, run_cons, cmp_inv, ih]

theorem wt_inv (v : Vec w) : wt (inv v) = w - wt v := by
  unfold wt inv
  have h := Finset.card_filter_add_card_filter_not (s := (Finset.univ : Finset (Fin w)))
    (fun k => v k = true)
  simp only [Finset.card_univ, Fintype.card_fin] at h
  have : (Finset.univ.filter fun k => (!v k) = true) = Finset.univ.filter fun k => ¬ (v k = true) := by
    ext k; simp
  rw [this]
  omega

theorem wt_le (v : Vec w) : wt v ≤ w := by
  unfold wt
  calc _ ≤ (Finset.univ : Finset (Fin w)).card := Finset.card_filter_le _ _
    _ = w := by simp

theorem inv_inv (v : Vec w) : inv (inv v) = v := by funext k; simp [inv]

theorem Works.map_inv {cn : List (Cmp w)} {V : Set (Vec w)} (h : Works cn V) :
    Works (cn.map flipC) (inv '' V) := by
  rintro _ ⟨u, hu, rfl⟩ _ ⟨v, hv, rfl⟩ huv
  rw [run_inv, run_inv, wt_inv, wt_inv] at huv
  rw [run_inv, run_inv]
  have h1 := wt_le (run cn u)
  have h2 := wt_le (run cn v)
  rw [h u hu v hv (by omega)]

theorem inv_image_inv (V : Set (Vec w)) : inv '' (inv '' V) = V := by
  ext v
  simp only [Set.mem_image]
  constructor
  · rintro ⟨_, ⟨u, hu, rfl⟩, rfl⟩; rwa [inv_inv]
  · intro hv; exact ⟨inv v, ⟨v, hv, rfl⟩, inv_inv v⟩

theorem LB.map_inv {V : Set (Vec w)} {b : ℕ} (h : LB V b) : LB (inv '' V) b := by
  intro cn hcn
  have h2 := hcn.map_inv
  rw [inv_image_inv] at h2
  simpa using h _ h2

theorem LB.map_inv_iff {V : Set (Vec w)} {b : ℕ} : LB (inv '' V) b ↔ LB V b := by
  constructor
  · intro h; have := h.map_inv; rwa [inv_image_inv] at this
  · intro h; exact h.map_inv

/-! ## The successor rule -/

/-- The two orientations of a comparator differ by the transposition of its channels. -/
theorem cmp_flip (c : Cmp w) (v : Vec w) :
    cmp (flipC c) v = relabel (Equiv.swap c.1 c.2) (cmp c v) := by
  obtain ⟨a, b⟩ := c
  funext k
  simp only [cmp, flipC, relabel]
  by_cases h1 : k = a
  · subst h1
    by_cases h2 : k = b
    · subst h2; simp
    · simp [h2, Equiv.swap_apply_left, Bool.or_comm, Ne.symm h2]
  · by_cases h2 : k = b
    · subst h2; simp [Equiv.swap_apply_right, Bool.and_comm]
    · rw [Equiv.swap_apply_of_ne_of_ne h1 h2]; simp [h1, h2]

theorem cmp_self (i : Fin w) (v : Vec w) : cmp (i, i) v = v := by
  funext k; simp only [cmp]; split_ifs with h <;> simp [h]

/-- **Successor rule.** Suppose the empty network does not work on `V`, and every comparator
`(lo, hi)` with `lo < hi` either maps `V` to a relabeling of `V` (by the identity or by the
transposition of `lo` and `hi`), or maps it to a set with bound `b - 1`. Then `LB V b`. -/
theorem LB.succ {V : Set (Vec w)} {b : ℕ} (h0 : ¬ Works [] V)
    (hc : ∀ lo hi : Fin w, lo < hi →
      cmp (lo, hi) '' V = V ∨ cmp (lo, hi) '' V = relabel (Equiv.swap lo hi) '' V ∨
        LB (cmp (lo, hi) '' V) (b - 1)) :
    LB V b := by
  -- the same statement for every relabeling of `V`, by induction on the length of the network
  suffices H : ∀ n (σ : Equiv.Perm (Fin w)) (cn : List (Cmp w)), cn.length = n →
      Works cn (relabel σ '' V) → b ≤ n by
    intro cn hcn
    exact H _ 1 cn rfl (by rw [image_relabel_one]; exact hcn)
  intro n
  induction n using Nat.strong_induction_on with
  | _ n ih =>
  intro σ cn hlen hcn
  rcases cn with _ | ⟨c, cn⟩
  · exfalso
    apply h0
    have h2 := hcn.map_relabel σ.symm
    have himg : relabel σ.symm '' (relabel σ '' V) = V := by
      ext v
      simp only [Set.mem_image]
      constructor
      · rintro ⟨_, ⟨u, hu, rfl⟩, rfl⟩; rwa [rel_rel_symm]
      · intro hv; exact ⟨relabel σ v, ⟨v, hv, rfl⟩, rel_rel_symm σ v⟩
    simpa [himg] using h2
  · simp only [List.length_cons] at hlen
    have hrest : Works cn (cmp c '' (relabel σ '' V)) := works_cons.1 hcn
    -- move the first comparator back to the original labels
    set d : Cmp w := relC σ.symm c with hd
    have hcd : c = relC σ d := by
      simp [hd, relC]
    have himg : cmp c '' (relabel σ '' V) = relabel σ '' (cmp d '' V) := by
      ext v
      simp only [Set.mem_image]
      constructor
      · rintro ⟨_, ⟨u, hu, rfl⟩, rfl⟩
        exact ⟨cmp d u, ⟨u, hu, rfl⟩, by rw [hcd, cmp_rel]⟩
      · rintro ⟨_, ⟨u, hu, rfl⟩, rfl⟩
        exact ⟨relabel σ u, ⟨u, hu, rfl⟩, by rw [hcd, cmp_rel]⟩
    rw [himg] at hrest
    -- `cmp d '' V` up to relabeling is `cmp (lo, hi) '' V` with `lo < hi`, or `V` itself
    rcases eq_or_ne d.1 d.2 with hdd | hdd
    · -- the identity comparator
      have : cmp d '' V = V := by
        ext v
        simp only [Set.mem_image]
        have hdeq : d = (d.1, d.1) := by ext <;> simp [hdd]
        constructor
        · rintro ⟨u, hu, rfl⟩; rwa [hdeq, cmp_self]
        · intro hv; exact ⟨v, hv, by rw [hdeq, cmp_self]⟩
      rw [this] at hrest
      have := ih cn.length (by omega) σ cn rfl hrest
      omega
    · -- write `d` (or its flip) as `(lo, hi)` with `lo < hi`
      obtain ⟨lo, hi, hlh, τ, hτ⟩ : ∃ lo hi : Fin w, lo < hi ∧ ∃ τ : Equiv.Perm (Fin w),
          cmp d '' V = relabel τ '' (cmp (lo, hi) '' V) := by
        rcases lt_or_gt_of_ne hdd with hlt | hgt
        · refine ⟨d.1, d.2, hlt, 1, ?_⟩
          rw [image_relabel_one]
        · refine ⟨d.2, d.1, hgt, Equiv.swap d.2 d.1, ?_⟩
          have key : ∀ u, cmp d u = relabel (Equiv.swap d.2 d.1) (cmp (d.2, d.1) u) := by
            intro u
            have := cmp_flip (d.2, d.1) u
            simpa [flipC] using this
          ext v
          simp only [Set.mem_image]
          constructor
          · rintro ⟨u, hu, rfl⟩
            exact ⟨cmp (d.2, d.1) u, ⟨u, hu, rfl⟩, (key u).symm⟩
          · rintro ⟨_, ⟨u, hu, rfl⟩, rfl⟩
            exact ⟨u, hu, key u⟩
      rw [hτ] at hrest
      -- compose the relabelings
      have hcomp : ∀ (α β : Equiv.Perm (Fin w)) (S : Set (Vec w)),
          relabel α '' (relabel β '' S) = relabel (β * α) '' S := by
        intro α β S
        ext v
        simp only [Set.mem_image]
        constructor
        · rintro ⟨_, ⟨u, hu, rfl⟩, rfl⟩; exact ⟨u, hu, by funext k; simp [relabel]⟩
        · rintro ⟨u, hu, rfl⟩; exact ⟨relabel β u, ⟨u, hu, rfl⟩, by funext k; simp [relabel]⟩
      rw [hcomp] at hrest
      rcases hc lo hi hlh with hid | hsw | hlb
      · rw [hid] at hrest
        have := ih cn.length (by omega) _ cn rfl hrest
        omega
      · rw [hsw, hcomp] at hrest
        have := ih cn.length (by omega) _ cn rfl hrest
        omega
      · have := (hlb.map_relabel (τ * σ)) cn hrest
        omega

end Sortnet.ZO
