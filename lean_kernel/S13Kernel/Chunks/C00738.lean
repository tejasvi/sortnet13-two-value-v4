import S13Kernel.Data.Keys

/-! Keys number 61725 to 61827. `data/c/c00738.txt` has sha256 6245b0b1b85beffea9848a7fa3c8c8756ddd0471f4f6cdc24cddb634913e036e. -/

namespace S13K.Chunks.C00738

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00738.txt"

theorem chk : chkChunk S N 61725 103 ces = true := by decide +kernel

theorem ok : RangeOK S N 61725 61828 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00738
