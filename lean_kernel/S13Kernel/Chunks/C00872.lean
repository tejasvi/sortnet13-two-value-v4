import S13Kernel.Data.Keys

/-! Keys number 74669 to 74767. `data/c/c00872.txt` has sha256 4a7db9fc561df7f9745bccbbd320872183b655b82318b996728962283bc9e841. -/

namespace S13K.Chunks.C00872

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00872.txt"

theorem chk : chkChunk S N 74669 99 ces = true := by decide +kernel

theorem ok : RangeOK S N 74669 74768 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00872
