import S13Kernel.Data.Keys

/-! NEGATIVE CONTROL (claimed chunk length 82 instead of 81). Keys number 39454 to 39534. `negctl/data/NegG_len.txt` has sha256 c14dcf8410d60fa768461384e1cf2ef552145b4f4866779cafa2c645ddf7d6d9. -/

namespace S13K.Neg.NegG_len

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "negctl/data/NegG_len.txt"

theorem chk : chkChunk S N 39454 82 ces = true := by decide +kernel


end S13K.Neg.NegG_len
