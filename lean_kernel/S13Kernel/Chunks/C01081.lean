import S13Kernel.Data.Keys

/-! Keys number 97168 to 97286. `data/c/c01081.txt` has sha256 8ab6617f0bd34f09a7a758328f9198acf0992bbcba340457781fef35f8f153d6. -/

namespace S13K.Chunks.C01081

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c01081.txt"

theorem chk : chkChunk S N 97168 119 ces = true := by decide +kernel

theorem ok : RangeOK S N 97168 97287 := rangeOK_of_chkChunk chk

end S13K.Chunks.C01081
