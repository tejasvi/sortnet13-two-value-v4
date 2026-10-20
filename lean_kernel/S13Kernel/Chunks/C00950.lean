import S13Kernel.Data.Keys

/-! Keys number 82735 to 82833. `data/c/c00950.txt` has sha256 49fef22f78a251f8e7878d344c97f6ba3421004357daf17a33927c26f1dc52da. -/

namespace S13K.Chunks.C00950

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00950.txt"

theorem chk : chkChunk S N 82735 99 ces = true := by decide +kernel

theorem ok : RangeOK S N 82735 82834 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00950
