import S13Kernel.Data.Keys

/-! Keys number 43916 to 44018. `data/c/c00548.txt` has sha256 0fcf1f24f98e3ef9b43e6d925621c4b0a6b5052c1804c06539a6f9fde4429e56. -/

namespace S13K.Chunks.C00548

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00548.txt"

theorem chk : chkChunk S N 43916 103 ces = true := by decide +kernel

theorem ok : RangeOK S N 43916 44019 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00548
