import S13Kernel.Data.Keys

/-! Keys number 714 to 770. `data/c/c00016.txt` has sha256 bde205a43e7570b7ba7f46cad6c7503f99dabdeb799e67f7d0b10b0d4259a0e7. -/

namespace S13K.Chunks.C00016

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00016.txt"

theorem chk : chkChunk S N 714 57 ces = true := by decide +kernel

theorem ok : RangeOK S N 714 771 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00016
