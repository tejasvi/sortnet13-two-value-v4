import S13Kernel.Data.Keys

/-! Keys number 26466 to 26567. `data/c/c00354.txt` has sha256 fb25532c7f1c1c884ed4cc098fd18492379e6d94872953c7711cfd0eb12e40a4. -/

namespace S13K.Chunks.C00354

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00354.txt"

theorem chk : chkChunk S N 26466 102 ces = true := by decide +kernel

theorem ok : RangeOK S N 26466 26568 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00354
