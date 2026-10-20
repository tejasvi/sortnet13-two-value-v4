import Mathlib.Logic.Equiv.Basic
import Mathlib.GroupTheory.Perm.Basic
import Mathlib.Order.Basic
import Mathlib.Order.Fin.Basic
import S13.Defs

/-!
# Untangling generalized networks

A generalized network can be rewritten as a standard network with the same number of comparators,
followed by a relabeling of the channels (Knuth, TAOCP vol. 3, Exercise 5.3.4–16): whenever a
comparator has its `hi` channel below its `lo` channel, exchange the two channels in the rest of the
network (`untangle`).

`GNetwork.SortsBy G ψ` says that the outputs of `G` are ordered like the ranks `ψ` of the channels,
on every input. A generalized network that sorts by some ranks untangles into a standard sorting
network of the same size (`exists_sorts_of_sortsBy`).
-/

namespace Sortnet

variable {n : ℕ}

/-- `G` sorts every input with respect to the ranks `ψ` of its output channels. -/
def GNetwork.SortsBy (G : GNetwork n) (ψ : Fin n → ℕ) : Prop :=
  ∀ v : Fin n → ℕ, ∀ i j : Fin n, ψ i ≤ ψ j → G.eval v i ≤ G.eval v j

theorem Network.eval_cons (c : Comparator n) (S : Network n) (v : Fin n → ℕ) :
    Network.eval (c :: S) v = Network.eval S (c.apply v) := rfl

theorem GNetwork.eval_cons' (c : GComparator n) (G : GNetwork n) (v : Fin n → ℕ) :
    GNetwork.eval (c :: G) v = GNetwork.eval G (c.apply v) := rfl

/-- One step of untangling: the standard comparator on the channels `ρ0 lo`, `ρ0 hi`, and the
relabeling after it. -/
theorem untangle_step (c : GComparator n) (ρ0 : Equiv.Perm (Fin n)) :
    ∃ (c' : Comparator n) (ρ1 : Equiv.Perm (Fin n)),
      ∀ w : Fin n → ℕ, ∀ k, c'.apply w (ρ1 k) = c.apply (w ∘ ρ0) k := by
  have hne : ρ0 c.lo ≠ ρ0 c.hi := fun h => c.ne (ρ0.injective h)
  rcases lt_or_gt_of_ne hne with hlt | hgt
  · refine ⟨⟨ρ0 c.lo, ρ0 c.hi, hlt⟩, ρ0, fun w k => ?_⟩
    simp only [Comparator.apply, GComparator.apply, Function.comp, ρ0.injective.eq_iff]
  · refine ⟨⟨ρ0 c.hi, ρ0 c.lo, hgt⟩, (Equiv.swap c.lo c.hi).trans ρ0, fun w k => ?_⟩
    simp only [Comparator.apply, GComparator.apply, Function.comp, Equiv.trans_apply,
      ρ0.injective.eq_iff]
    by_cases h1 : k = c.lo
    · subst h1
      simp [Equiv.swap_apply_left, min_comm]
    · by_cases h2 : k = c.hi
      · subst h2
        simp [Equiv.swap_apply_right, max_comm, c.ne, Ne.symm c.ne]
      · rw [Equiv.swap_apply_of_ne_of_ne h1 h2]
        simp [h1, h2]

/-- **Untangling.** For every generalized network `G` and relabeling `ρ0` there are a standard
network `S` of the same length and a relabeling `ρ` with `S(w) ∘ ρ = G(w ∘ ρ0)` for all `w`. -/
theorem untangle (G : GNetwork n) (ρ0 : Equiv.Perm (Fin n)) :
    ∃ (S : Network n) (ρ : Equiv.Perm (Fin n)), S.length = G.length ∧
      ∀ w : Fin n → ℕ, ∀ k, S.eval w (ρ k) = G.eval (w ∘ ρ0) k := by
  induction G generalizing ρ0 with
  | nil => exact ⟨[], ρ0, rfl, fun w k => rfl⟩
  | cons c G ih =>
    obtain ⟨c', ρ1, hc⟩ := untangle_step c ρ0
    obtain ⟨S, ρ, hlen, hS⟩ := ih ρ1
    refine ⟨c' :: S, ρ, by simp [hlen], fun w k => ?_⟩
    rw [Network.eval_cons, hS, GNetwork.eval_cons']
    congr 1
    funext k'
    exact hc w k'

/-- A standard network leaves a strictly increasing input unchanged. -/
theorem Network.eval_val (S : Network n) : S.eval (fun k : Fin n => (k : ℕ)) = fun k : Fin n => (k : ℕ) := by
  induction S with
  | nil => rfl
  | cons c S ih =>
    rw [Network.eval_cons]
    have : c.apply (fun k : Fin n => (k : ℕ)) = fun k : Fin n => (k : ℕ) := by
      funext k
      have hlt : (c.i : ℕ) < c.j := c.lt
      simp only [Comparator.apply]
      split_ifs with h1 h2
      · subst h1; exact min_eq_left (le_of_lt hlt)
      · subst h2; exact max_eq_right (le_of_lt hlt)
      · rfl
    rw [this, ih]

/-- A generalized network that sorts with respect to some channel ranks untangles into a standard
sorting network with the same number of comparators. -/
theorem exists_sorts_of_sortsBy (G : GNetwork n) (ψ : Fin n → ℕ) (hG : G.SortsBy ψ) :
    ∃ S : Network n, S.length = G.length ∧ S.Sorts := by
  obtain ⟨S, ρ, hlen, hS⟩ := untangle G 1
  refine ⟨S, hlen, ?_⟩
  have hS' : ∀ w a, S.eval w a = G.eval w (ρ.symm a) := by
    intro w a
    have := hS w (ρ.symm a)
    rw [Equiv.apply_symm_apply] at this
    rw [this]; rfl
  -- ranks of the output channels of `S`
  let π : Fin n → ℕ := fun a => ψ (ρ.symm a)
  have hA : ∀ w a b, π a ≤ π b → S.eval w a ≤ S.eval w b := by
    intro w a b hab
    rw [hS', hS']
    exact hG w _ _ hab
  have hB : ∀ a b, π a ≤ π b → a ≤ b := by
    intro a b hab
    have := hA (fun k : Fin n => (k : ℕ)) a b hab
    rw [Network.eval_val] at this
    exact this
  intro w a b hab
  apply hA
  by_contra h
  push Not at h
  have := le_antisymm hab (hB b a (le_of_lt h))
  subst this
  exact lt_irrefl _ h

end Sortnet
