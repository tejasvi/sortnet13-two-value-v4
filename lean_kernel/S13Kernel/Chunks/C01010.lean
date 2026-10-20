import S13Kernel.Data.Keys

/-! Keys number 89153 to 89264. `data/c/c01010.txt` has sha256 e39f2745a332e75f6e662a1f20f86c494e793f2cc2dadbadb1341dd217f806e4. -/

namespace S13K.Chunks.C01010

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c01010.txt"

theorem chk : chkChunk S N 89153 112 ces = true := by decide +kernel

theorem ok : RangeOK S N 89153 89265 := rangeOK_of_chkChunk chk

end S13K.Chunks.C01010
