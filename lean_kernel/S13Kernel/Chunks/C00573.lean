import S13Kernel.Data.Keys

/-! Keys number 46300 to 46390. `data/c/c00573.txt` has sha256 7d9291467e2d637b258e8322d437b98a2f9b99a745608a8d429bdc83471da52b. -/

namespace S13K.Chunks.C00573

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00573.txt"

theorem chk : chkChunk S N 46300 91 ces = true := by decide +kernel

theorem ok : RangeOK S N 46300 46391 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00573
