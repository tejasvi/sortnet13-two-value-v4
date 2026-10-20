import S13Kernel.Load

/-! NEGATIVE CONTROL: entry (12, 11) of key number 0 (the start state) changed. `startK` must fail. -/

namespace S13K.NegE
open S13K
load_keys S from "negctl/data/keys_E.txt"
theorem start_ok : startK (getK S 0) = true := by decide +kernel
end S13K.NegE
