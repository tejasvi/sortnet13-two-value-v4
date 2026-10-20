import Mathlib.Order.Monotone.Basic
import Mathlib.Order.Fin.Basic
import S13.Defs

/-!
# The 0-1 principle

`Network.Sorts` asks a network to sort every input vector of natural numbers. By the 0-1 principle
this is the same as sorting every input vector with entries `0` and `1`.
-/

namespace Sortnet

variable {n : ℕ}

/-- `net` sorts every input vector with entries in `{0, 1}`. -/
def Network.Sorts01 (net : Network n) : Prop :=
  ∀ v : Fin n → ℕ, (∀ k, v k ≤ 1) → ∀ a b : Fin n, a ≤ b → net.eval v a ≤ net.eval v b

theorem Comparator.apply_comp {f : ℕ → ℕ} (hf : Monotone f) (c : Comparator n) (v : Fin n → ℕ) :
    c.apply (f ∘ v) = f ∘ c.apply v := by
  funext k
  simp only [Comparator.apply, Function.comp]
  split_ifs
  · rcases le_total (v c.i) (v c.j) with h | h
    · rw [min_eq_left h, min_eq_left (hf h)]
    · rw [min_eq_right h, min_eq_right (hf h)]
  · rcases le_total (v c.i) (v c.j) with h | h
    · rw [max_eq_right h, max_eq_right (hf h)]
    · rw [max_eq_left h, max_eq_left (hf h)]
  · rfl

theorem Network.eval_comp {f : ℕ → ℕ} (hf : Monotone f) (net : Network n) (v : Fin n → ℕ) :
    net.eval (f ∘ v) = f ∘ net.eval v := by
  induction net generalizing v with
  | nil => rfl
  | cons c net ih =>
    show Network.eval net (c.apply (f ∘ v)) = f ∘ Network.eval net (c.apply v)
    rw [c.apply_comp hf, ih]

/-- **The 0-1 principle.** A network sorts every input iff it sorts every 0-1 input. -/
theorem Network.sorts_iff_sorts01 (net : Network n) : net.Sorts ↔ net.Sorts01 := by
  constructor
  · intro h v _ a b hab; exact h v a b hab
  · intro h v a b hab
    by_contra hlt
    push Not at hlt
    let t := net.eval v a
    let f : ℕ → ℕ := fun x => if t ≤ x then 1 else 0
    have hf : Monotone f := by
      intro x y hxy
      simp only [f]
      split_ifs <;> omega
    have h01 : ∀ k, (f ∘ v) k ≤ 1 := by
      intro k; simp only [Function.comp, f]; split_ifs <;> omega
    have := h (f ∘ v) h01 a b hab
    rw [Network.eval_comp hf] at this
    simp only [Function.comp, f, t, le_refl, ite_true] at this
    split_ifs at this with h1
    · omega
    · omega

end Sortnet
