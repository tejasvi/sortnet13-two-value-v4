import S13Kernel.Data.Keys

/-! Keys number 82129 to 82234. `data/c/c00944.txt` has sha256 654f298bd43136a044ec620dacb34fb03ca3355bd61641a8ec9f88340078b139. -/

namespace S13K.Chunks.C00944

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00944.txt"

theorem chk : chkChunk S N 82129 106 ces = true := by decide +kernel

theorem ok : RangeOK S N 82129 82235 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00944
