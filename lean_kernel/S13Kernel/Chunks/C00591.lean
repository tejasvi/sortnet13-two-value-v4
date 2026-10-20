import S13Kernel.Data.Keys

/-! Keys number 47961 to 48061. `data/c/c00591.txt` has sha256 ce7018eeec4b72a6d5cd14916269fd1fa7c151e372db7f52fd39e17050380947. -/

namespace S13K.Chunks.C00591

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00591.txt"

theorem chk : chkChunk S N 47961 101 ces = true := by decide +kernel

theorem ok : RangeOK S N 47961 48062 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00591
