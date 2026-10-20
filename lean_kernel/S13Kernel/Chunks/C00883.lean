import S13Kernel.Data.Keys

/-! Keys number 75867 to 75990. `data/c/c00883.txt` has sha256 88a38fd31148b99c31bbf3114465c32a4baf45c7f70b33326f49aadb7b34e2e1. -/

namespace S13K.Chunks.C00883

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00883.txt"

theorem chk : chkChunk S N 75867 124 ces = true := by decide +kernel

theorem ok : RangeOK S N 75867 75991 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00883
