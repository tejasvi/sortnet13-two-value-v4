import S13Kernel.Data.Keys

/-! Keys number 27844 to 27951. `data/c/c00369.txt` has sha256 ce1ce0a30ddf595e6c6b83333aa99b5c29b30c6dcfa943bc26c36f575c6df9c2. -/

namespace S13K.Chunks.C00369

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00369.txt"

theorem chk : chkChunk S N 27844 108 ces = true := by decide +kernel

theorem ok : RangeOK S N 27844 27952 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00369
