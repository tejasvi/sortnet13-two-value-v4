import S13Kernel.Load

/-! NEGATIVE CONTROL: entry (12, 11) of key number 56461 (the target of the first certificate entry of
chunk 500) changed. The chunk check must fail. -/

namespace S13K.NegD
open S13K
set_option Elab.async false
set_option maxRecDepth 100000
load_keys S from "negctl/data/keys_D.txt"
def N : Nat := 99736
load_certs ces from "data/c/c00500.txt"
theorem chk : chkChunk S N 39454 81 ces = true := by decide +kernel
end S13K.NegD
