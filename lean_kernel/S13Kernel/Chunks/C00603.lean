import S13Kernel.Data.Keys

/-! Keys number 49031 to 49113. `data/c/c00603.txt` has sha256 d530acf99b26836d29da7a68fef4e34938a22aa861a843131381d74433484c05. -/

namespace S13K.Chunks.C00603

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00603.txt"

theorem chk : chkChunk S N 49031 83 ces = true := by decide +kernel

theorem ok : RangeOK S N 49031 49114 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00603
