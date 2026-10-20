import S13Kernel.Data.Keys

/-! Keys number 51867 to 51955. `data/c/c00636.txt` has sha256 bc9e2127833f46b6856d2117e2aee9d6c886dcabc2eef1b0975f64717bf389b6. -/

namespace S13K.Chunks.C00636

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00636.txt"

theorem chk : chkChunk S N 51867 89 ces = true := by decide +kernel

theorem ok : RangeOK S N 51867 51956 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00636
