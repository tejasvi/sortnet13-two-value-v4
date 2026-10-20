import S13.Runs
import S13.Untangle

/-!
# Two-value pruning

Let `net` be a standard sorting network on `n + 2` channels and `x ≠ y`. Delete the comparators met
by the largest value (from `x`) or the second largest value (from `y`); at a deleted comparator with one
special input, the other value continues on the output that the special value did not take. What is
left sorts the other `n` inputs (`prune`): it is a generalized network that sorts with respect to
fixed channel ranks, and untangling turns it into a standard sorting network of the same size.

Bookkeeping: a permutation `φ` of the `n + 2` channels sends the channels of the two special values
to `n + 1` and `n`, and the other channels to the `n` channels of the pruned network. A deleted
comparator either leaves all values in place or exchanges the values on its two channels (`tau`);
`φ` absorbs that exchange.
-/

namespace Sortnet

variable {n : ℕ}

/-- A standard comparator as a generalized one. -/
def Comparator.toG (c : Comparator n) : GComparator n := ⟨c.i, c.j, Fin.ne_of_lt c.lt⟩

theorem Network.toG_nil : Network.toG ([] : Network n) = [] := rfl

theorem Network.toG_cons (c : Comparator n) (net : Network n) :
    Network.toG (c :: net) = c.toG :: net.toG := rfl

theorem Comparator.toG_apply (c : Comparator n) (v : Fin n → ℕ) : c.toG.apply v = c.apply v := rfl

theorem Network.eval_toG (net : Network n) (v : Fin n → ℕ) : net.toG.eval v = net.eval v := by
  induction net generalizing v with
  | nil => rfl
  | cons c net ih =>
    rw [Network.toG_cons, GNetwork.eval_cons', Comparator.toG_apply, ih]; rfl

/-! ## A deleted comparator permutes the values -/

/-- In the run with `M` on `pM` and `m` on `pm`, the comparator exchanges the values on its two
channels. -/
def Comparator.Swaps (c : Comparator n) (pM pm : Fin n) : Prop := pM = c.i ∨ (pm = c.i ∧ pM ≠ c.j)

instance (c : Comparator n) (pM pm : Fin n) : Decidable (c.Swaps pM pm) := by
  unfold Comparator.Swaps; infer_instance

/-- The permutation of the channels performed by the comparator in that run. -/
def Comparator.tau (c : Comparator n) (pM pm : Fin n) : Equiv.Perm (Fin n) :=
  if c.Swaps pM pm then Equiv.swap c.i c.j else 1

theorem Comparator.tau_tau (c : Comparator n) (pM pm x : Fin n) :
    c.tau pM pm (c.tau pM pm x) = x := by
  unfold Comparator.tau; split_ifs <;> simp

theorem Comparator.touch_spec (c : Comparator n) {M m : ℕ} {v : Fin n → ℕ} {pM pm : Fin n}
    (hv : Config M m v pM pm) (ht : c.toG.Touch pM pm) :
    c.toG.moveM pM = c.tau pM pm pM ∧ c.toG.movem pM pm = c.tau pM pm pm ∧
      ∀ z, c.apply v z = v (c.tau pM pm z) := by
  obtain ⟨hne, hM, hm, hlt, hoth⟩ := hv
  have hij : c.i ≠ c.j := Fin.ne_of_lt c.lt
  simp only [GComparator.Touch, GComparator.moveM, GComparator.movem, Comparator.toG] at ht ⊢
  by_cases hs : c.Swaps pM pm
  · rw [Comparator.tau, ite_eq_left hs]
    rcases hs with h | ⟨h1, h2⟩
    · subst h
      have hvj : c.apply v c.j = v c.i ∧ c.apply v c.i = v c.j := by
        have : v c.j < M := by
          by_cases hj : c.j = pm
          · rw [hj, hm]; exact hlt
          · have := hoth c.j (Ne.symm hij) hj; omega
        simp only [Comparator.apply, ite_eq_right (Ne.symm hij)]
        constructor <;> simp <;> omega
      refine ⟨by simp, ?_, ?_⟩
      · by_cases hpj : pm = c.j
        · subst hpj; simp
        · have hpi : pm ≠ c.i := Ne.symm hne
          simp [hpj, hpi, Equiv.swap_apply_of_ne_of_ne hpi hpj]
      · intro z
        by_cases hzi : z = c.i
        · subst hzi; simp [hvj.2]
        · by_cases hzj : z = c.j
          · subst hzj; simp [hvj.1]
          · rw [Equiv.swap_apply_of_ne_of_ne hzi hzj]
            simp [Comparator.apply, hzi, hzj]
    · subst h1
      have hpMi : pM ≠ c.i := hne
      have hvj : v c.j < m := hoth c.j (Ne.symm h2) (Ne.symm hij)
      refine ⟨by simp [hpMi, h2, Equiv.swap_apply_of_ne_of_ne hpMi h2], by simp [hpMi, h2], ?_⟩
      intro z
      by_cases hzi : z = c.i
      · subst hzi; simp [Comparator.apply]; omega
      · by_cases hzj : z = c.j
        · subst hzj; simp [Comparator.apply, Ne.symm hij]; omega
        · rw [Equiv.swap_apply_of_ne_of_ne hzi hzj]
          simp [Comparator.apply, hzi, hzj]
  · rw [Comparator.tau, ite_eq_right hs]
    simp only [Comparator.Swaps, not_or, not_and, not_not] at hs
    obtain ⟨hpMi, hs2⟩ := hs
    have hfix : ∀ z, c.apply v z = v z := by
      have hle : v c.i ≤ v c.j := by
        by_cases hpMj : pM = c.j
        · rw [← hpMj, hM]
          by_cases hi : c.i = pm
          · rw [hi, hm]; exact le_of_lt hlt
          · have := hoth c.i (Ne.symm hpMi) hi; omega
        · have hpmi : pm ≠ c.i := fun h => hpMj (hs2 h)
          have hpmj : pm = c.j := by
            rcases ht with h | h | h | h
            · exact absurd h hpMi
            · exact absurd h hpMj
            · exact absurd h hpmi
            · exact h
          rw [← hpmj, hm]
          exact le_of_lt (hoth c.i (Ne.symm hpMi) (Ne.symm hpmi))
      intro z
      simp only [Comparator.apply]
      split_ifs with h1 h2
      · subst h1; exact min_eq_left hle
      · subst h2; exact max_eq_right hle
      · rfl
    refine ⟨?_, ?_, fun z => by simp [hfix z]⟩
    · by_cases hpMj : pM = c.j
      · simp [hpMj]
      · simp [hpMi, hpMj]
    · by_cases hpMj : pM = c.j
      · by_cases hpmi : pm = c.i
        · simp [hpMj, hpmi]
        · have hpmj : pm ≠ c.j := fun h => hne (hpMj.trans h.symm)
          simp [hpMj, hpmi, hpmj]
      · have hpmi : pm ≠ c.i := fun h => hpMj (hs2 h)
        have hpmj : pm = c.j := by
          rcases ht with h | h | h | h
          · exact absurd h hpMi
          · exact absurd h hpMj
          · exact absurd h hpmi
          · exact h
        simp [hpMi, hpMj, hpmj]

theorem Comparator.notouch_spec (c : Comparator n) {pM pm : Fin n} (ht : ¬ c.toG.Touch pM pm) :
    c.toG.moveM pM = pM ∧ c.toG.movem pM pm = pm := by
  simp only [GComparator.Touch, not_or] at ht
  obtain ⟨h1, h2, h3, h4⟩ := ht
  simp [GComparator.moveM, GComparator.movem, h1, h2, h3, h4]

/-! ## The pruned network -/

/-- The first `n` of the `n + 2` channels. -/
def emb : Fin n → Fin (n + 2) := Fin.castLE (Nat.le_add_right n 2)

theorem emb_val (k : Fin n) : (emb k).val = k.val := rfl

/-- A kept comparator, moved to the channels `φ i`, `φ j` of the pruned network. -/
def keptC (φ : Equiv.Perm (Fin (n + 2))) (c : Comparator (n + 2)) (h1 : (φ c.i).val < n)
    (h2 : (φ c.j).val < n) : GComparator n :=
  ⟨⟨(φ c.i).val, h1⟩, ⟨(φ c.j).val, h2⟩, fun e => by
    have h : (φ c.i).val = (φ c.j).val := Fin.mk.inj e
    exact Fin.ne_of_lt c.lt (φ.injective (Fin.ext h))⟩

/-- The comparators of `net` that the two largest values (now on `pM` and `pm`) do not meet,
relabeled by `φ`. -/
def pruneFrom : Network (n + 2) → Equiv.Perm (Fin (n + 2)) → Fin (n + 2) → Fin (n + 2) → GNetwork n
  | [], _, _, _ => []
  | c :: net, φ, pM, pm =>
    if c.toG.Touch pM pm then
      pruneFrom net (φ * c.tau pM pm) (c.toG.moveM pM) (c.toG.movem pM pm)
    else if h : (φ c.i).val < n ∧ (φ c.j).val < n then
      keptC φ c h.1 h.2 :: pruneFrom net φ pM pm
    else pruneFrom net φ pM pm

/-- The relabeling at the end of the network. -/
def finalPerm : Network (n + 2) → Equiv.Perm (Fin (n + 2)) → Fin (n + 2) → Fin (n + 2) →
    Equiv.Perm (Fin (n + 2))
  | [], φ, _, _ => φ
  | c :: net, φ, pM, pm =>
    if c.toG.Touch pM pm then
      finalPerm net (φ * c.tau pM pm) (c.toG.moveM pM) (c.toG.movem pM pm)
    else finalPerm net φ pM pm

theorem val_lt_of_ne {φ : Equiv.Perm (Fin (n + 2))} {pM pm z : Fin (n + 2)}
    (hφ : φ pM = Fin.last (n + 1) ∧ φ pm = (Fin.last n).castSucc) (h1 : z ≠ pM) (h2 : z ≠ pm) :
    (φ z).val < n := by
  have a1 : φ z ≠ Fin.last (n + 1) := fun h => h1 (φ.injective (h.trans hφ.1.symm))
  have a2 : φ z ≠ (Fin.last n).castSucc := fun h => h2 (φ.injective (h.trans hφ.2.symm))
  have b1 : (φ z).val ≠ n + 1 := fun h => a1 (Fin.ext (by simp [h]))
  have b2 : (φ z).val ≠ n := fun h => a2 (Fin.ext (by simp [h]))
  have := (φ z).isLt
  omega

theorem pruneFrom_spec (net : Network (n + 2)) :
    ∀ (φ : Equiv.Perm (Fin (n + 2))) (pM pm : Fin (n + 2)),
      (φ pM = Fin.last (n + 1) ∧ φ pm = (Fin.last n).castSucc) →
      ∀ {M m : ℕ} (v : Fin (n + 2) → ℕ), Config M m v pM pm →
      ∀ (u : Fin n → ℕ), (∀ k, u k = v (φ.symm (emb k))) →
      (pruneFrom net φ pM pm).length + costFrom net.toG pM pm = net.length ∧
        ∀ k, (pruneFrom net φ pM pm).eval u k = net.eval v ((finalPerm net φ pM pm).symm (emb k)) := by
  induction net with
  | nil =>
    intro φ pM pm _ M m v _ u hu
    exact ⟨rfl, fun k => hu k⟩
  | cons c net ih =>
    intro φ pM pm hφ M m v hv u hu
    by_cases ht : c.toG.Touch pM pm
    · obtain ⟨e1, e2, e3⟩ := c.touch_spec hv ht
      have hφ' : (φ * c.tau pM pm) (c.toG.moveM pM) = Fin.last (n + 1) ∧
          (φ * c.tau pM pm) (c.toG.movem pM pm) = (Fin.last n).castSucc := by
        rw [Equiv.Perm.mul_apply, Equiv.Perm.mul_apply, e1, e2, c.tau_tau, c.tau_tau]
        exact hφ
      have hv' : Config M m (c.apply v) (c.toG.moveM pM) (c.toG.movem pM pm) := hv.step c.toG
      have hu' : ∀ k, u k = c.apply v ((φ * c.tau pM pm).symm (emb k)) := by
        intro k
        rw [e3, Equiv.Perm.mul_def, Equiv.symm_trans_apply, Equiv.apply_symm_apply, hu k]
      obtain ⟨hlen, heval⟩ := ih _ _ _ hφ' (c.apply v) hv' u hu'
      simp only [pruneFrom, finalPerm, ite_eq_left ht, Network.toG_cons, costFrom, List.length_cons]
      refine ⟨by omega, fun k => ?_⟩
      rw [heval k, Network.eval_cons]
    · obtain ⟨e1, e2⟩ := c.notouch_spec ht
      have ht' := ht
      simp only [GComparator.Touch, Comparator.toG, not_or] at ht'
      obtain ⟨n1, n2, n3, n4⟩ := ht'
      have h1 : (φ c.i).val < n := val_lt_of_ne hφ (Ne.symm n1) (Ne.symm n3)
      have h2 : (φ c.j).val < n := val_lt_of_ne hφ (Ne.symm n2) (Ne.symm n4)
      have hv' : Config M m (c.apply v) pM pm := by
        have := hv.step c.toG; rwa [e1, e2] at this
      have key : ∀ (x : Fin (n + 2)) (hx : (φ x).val < n) (k : Fin n),
          φ.symm (emb k) = x ↔ k = ⟨(φ x).val, hx⟩ := by
        intro x hx k
        rw [Equiv.symm_apply_eq, Fin.ext_iff, Fin.ext_iff, emb_val]
      have hu' : ∀ k, (keptC φ c h1 h2).apply u k = c.apply v (φ.symm (emb k)) := by
        intro k
        have ui : u ⟨(φ c.i).val, h1⟩ = v c.i := by
          rw [hu]; congr 1; rw [Equiv.symm_apply_eq]; exact Fin.ext rfl
        have uj : u ⟨(φ c.j).val, h2⟩ = v c.j := by
          rw [hu]; congr 1; rw [Equiv.symm_apply_eq]; exact Fin.ext rfl
        simp only [GComparator.apply, keptC, Comparator.apply, key c.i h1, key c.j h2, ui, uj]
        split_ifs <;> first | rfl | exact hu k
      obtain ⟨hlen, heval⟩ := ih φ pM pm hφ (c.apply v) hv' _ hu'
      simp only [pruneFrom, finalPerm, ite_eq_right ht, dite_eq_left (And.intro h1 h2), Network.toG_cons,
        costFrom, List.length_cons, e1, e2]
      refine ⟨by omega, fun k => ?_⟩
      rw [GNetwork.eval_cons', heval k, Network.eval_cons]

/-- A permutation sending `x` to `n + 1` and `y` to `n`. -/
theorem exists_perm_two {x y : Fin (n + 2)} (hxy : x ≠ y) :
    ∃ φ : Equiv.Perm (Fin (n + 2)), φ x = Fin.last (n + 1) ∧ φ y = (Fin.last n).castSucc := by
  let σ1 := Equiv.swap x (Fin.last (n + 1))
  let y1 := σ1 y
  have hy1 : y1 ≠ Fin.last (n + 1) := by
    intro h
    have : y = σ1 (Fin.last (n + 1)) := by rw [← h]; simp [y1, σ1]
    rw [this] at hxy
    simp [σ1] at hxy
  have hl : (Fin.last n).castSucc ≠ Fin.last (n + 1) := by
    intro h; have := congrArg Fin.val h; simp at this
  refine ⟨σ1.trans (Equiv.swap y1 (Fin.last n).castSucc), ?_, ?_⟩
  · simp only [Equiv.trans_apply, σ1, Equiv.swap_apply_left]
    exact Equiv.swap_apply_of_ne_of_ne (Ne.symm hy1) (Ne.symm hl)
  · simp only [Equiv.trans_apply]
    exact Equiv.swap_apply_left _ _

/-- **Two-value pruning.** Deleting the comparators met by the two largest values in the run `(x, y)`
from a sorting network on `n + 2` channels leaves (after untangling) a sorting network on `n` channels:
`|net| = |net'| + |W(x,y)|`. -/
theorem prune (net : Network (n + 2)) (hs : net.Sorts) {x y : Fin (n + 2)} (hxy : x ≠ y) :
    ∃ net' : Network n, net'.Sorts ∧ net'.length + (net.toG.W x y).length = net.length := by
  obtain ⟨φ0, hφ0⟩ := exists_perm_two hxy
  -- the input of the big network for a given input `z` of the pruned one
  let inp : (Fin n → ℕ) → Fin (n + 2) → ℕ := fun z w =>
    if w = x then (∑ k, z k) + 2 else if w = y then (∑ k, z k) + 1 else
      if h : (φ0 w).val < n then z ⟨(φ0 w).val, h⟩ else 0
  have hcfg : ∀ z, Config ((∑ k, z k) + 2) ((∑ k, z k) + 1) (inp z) x y := by
    intro z
    refine ⟨hxy, by simp [inp], by simp [inp, Ne.symm hxy], by omega, fun w hwx hwy => ?_⟩
    simp only [inp, ite_eq_right hwx, ite_eq_right hwy]
    split_ifs with h
    · have := Finset.single_le_sum (f := z) (fun _ _ => Nat.zero_le _)
        (Finset.mem_univ (⟨(φ0 w).val, h⟩ : Fin n))
      omega
    · omega
  have hinp : ∀ z k, z k = inp z (φ0.symm (emb k)) := by
    intro z k
    have hw : φ0 (φ0.symm (emb k)) = emb k := Equiv.apply_symm_apply _ _
    have hwx : φ0.symm (emb k) ≠ x := by
      intro h; rw [h, hφ0.1] at hw; have := congrArg Fin.val hw; simp [emb_val] at this; omega
    have hwy : φ0.symm (emb k) ≠ y := by
      intro h; rw [h, hφ0.2] at hw; have := congrArg Fin.val hw; simp [emb_val] at this; omega
    simp only [inp, ite_eq_right hwx, ite_eq_right hwy, hw, emb_val, k.isLt, dite_eq_left]
  let G := pruneFrom net φ0 x y
  let ψ : Fin n → ℕ := fun k => ((finalPerm net φ0 x y).symm (emb k)).val
  have hG : G.SortsBy ψ := by
    intro z i j hij
    obtain ⟨-, heval⟩ := pruneFrom_spec net φ0 x y hφ0 (inp z) (hcfg z) z (hinp z)
    rw [heval i, heval j]
    exact hs _ _ _ hij
  obtain ⟨S, hlen, hS⟩ := exists_sorts_of_sortsBy G ψ hG
  obtain ⟨hlenG, -⟩ := pruneFrom_spec net φ0 x y hφ0 (inp (fun _ => 0)) (hcfg _) _ (hinp _)
  refine ⟨S, hS, ?_⟩
  rw [hlen, W_length _ hxy]
  exact hlenG

end Sortnet
