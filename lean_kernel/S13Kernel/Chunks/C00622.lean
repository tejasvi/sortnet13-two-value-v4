import S13Kernel.Data.Keys

/-! Keys number 50631 to 50713. `data/c/c00622.txt` has sha256 d057e5fae1f18f29882b65c1a004e358c435e7c4bb7bf82c7fc43fac773e5f0a. -/

namespace S13K.Chunks.C00622

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00622.txt"

theorem chk : chkChunk S N 50631 83 ces = true := by decide +kernel

theorem ok : RangeOK S N 50631 50714 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00622
