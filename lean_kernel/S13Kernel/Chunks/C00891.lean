import S13Kernel.Data.Keys

/-! Keys number 76727 to 76820. `data/c/c00891.txt` has sha256 3c5a914966dfb66a2bcd3f5273ff66e5102e12989cb04a4706682449f5f75a68. -/

namespace S13K.Chunks.C00891

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00891.txt"

theorem chk : chkChunk S N 76727 94 ces = true := by decide +kernel

theorem ok : RangeOK S N 76727 76821 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00891
