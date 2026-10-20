import S13Kernel.Data.Keys

/-! Keys number 10933 to 11003. `data/c/c00165.txt` has sha256 6c2458aff900a0dd4b5c0fbf3b3f5e2b3e46351ffd97c649a36693a7e37c5cfa. -/

namespace S13K.Chunks.C00165

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00165.txt"

theorem chk : chkChunk S N 10933 71 ces = true := by decide +kernel

theorem ok : RangeOK S N 10933 11004 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00165
