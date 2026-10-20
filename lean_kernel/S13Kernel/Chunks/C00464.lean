import S13Kernel.Data.Keys

/-! Keys number 36122 to 36209. `data/c/c00464.txt` has sha256 84cd3ce00fbb6c8bc446d92a68904fb9914f321364856395958a8ee475178178. -/

namespace S13K.Chunks.C00464

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00464.txt"

theorem chk : chkChunk S N 36122 88 ces = true := by decide +kernel

theorem ok : RangeOK S N 36122 36210 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00464
