import S13.Prune

/-!
# From `P(2,13) ≥ 9` and `S(11) ≥ 35` to `S(13) ≥ 44`

`top2_of_sorts`: a sorting network is top-two correct (outputs `n + 1` and `n`).
`mainStatement_of_P2`: the two-value bound `S(13) ≥ S(11) + P(2,13)` with `S(11) ≥ 35` as a hypothesis.
-/

namespace Sortnet

/-- A sorting network on `n + 2` channels is top-two correct: the largest value ends on the last
channel and the second largest on the channel below it. -/
theorem top2_of_sorts {n : ℕ} (net : Network (n + 2)) (hs : net.Sorts) : net.toG.Top2Correct := by
  have hl : (Fin.last n).castSucc ≠ Fin.last (n + 1) := by
    intro h; have := congrArg Fin.val h; simp at this
  refine ⟨Fin.last (n + 1), (Fin.last n).castSucc, Ne.symm hl, fun x y hxy => ?_⟩
  have hc := (config_run net.toG (config_runInput hxy)).1
  rw [Network.eval_toG] at hc ⊢
  set v := net.eval (runInput (n + 2) x y) with hv
  set pM := (posFrom net.toG x y).1
  set pm := (posFrom net.toG x y).2
  have hlast : Fin.last (n + 1) = pM := by
    apply hc.eq_pM
    rw [← hc.hM]
    exact hs _ _ _ (Fin.le_last _)
  have hpm : pm ≤ (Fin.last n).castSucc := by
    have hne : pm ≠ Fin.last (n + 1) := fun h => hc.ne (hlast.symm.trans h.symm)
    rw [Fin.le_def]
    have h1 := pm.isLt
    have h2 : pm.val ≠ n + 1 := fun h => hne (Fin.ext (by simp [h]))
    simp only [Fin.val_castSucc, Fin.val_last]
    omega
  have h2 : n + 2 ≤ v (Fin.last n).castSucc := by
    rw [← hc.hm]; exact hs _ _ _ hpm
  rcases (hc.le_iff _).1 h2 with h | h
  · exact absurd (h.trans hlast.symm) hl
  · refine ⟨?_, ?_⟩
    · rw [hlast]; exact hc.hM
    · rw [h]; exact hc.hm

/-- **The reduction.** `P(2,13) ≥ 9` implies the main statement: with Harder's `S(11) ≥ 35` as the
hypothesis, every sorting network on 13 channels has at least 44 comparators. -/
theorem mainStatement_of_P2 (hP : P2AtLeast 13 9) : MainStatement := by
  intro h11 net hs
  obtain ⟨x, y, hxy, hW⟩ := hP net.toG (top2_of_sorts (n := 11) net hs)
  obtain ⟨net', hs', hlen⟩ := prune (n := 11) net hs hxy
  have := h11 net' hs'
  omega

end Sortnet
