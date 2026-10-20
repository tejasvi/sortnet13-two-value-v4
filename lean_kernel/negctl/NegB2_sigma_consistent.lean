import S13Kernel.Data.Keys

/-! NEGATIVE CONTROL (sigma composed with the transposition (0 2), inverse updated; (0 1) is an automorphism of this target). Keys number 39454 to 39534. `negctl/data/NegB2_sigma_consistent.txt` has sha256 c14dcf8410d60fa768461384e1cf2ef552145b4f4866779cafa2c645ddf7d6d9. -/

namespace S13K.Neg.NegB2_sigma_consistent

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "negctl/data/NegB2_sigma_consistent.txt"

theorem chk : chkChunk S N 39454 81 ces = true := by decide +kernel


end S13K.Neg.NegB2_sigma_consistent
