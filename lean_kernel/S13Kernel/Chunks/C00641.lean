import S13Kernel.Data.Keys

/-! Keys number 52350 to 52451. `data/c/c00641.txt` has sha256 5ba789bbb4d02088c223d4fce10e26256408203d4284adbc768ce09b1a9af120. -/

namespace S13K.Chunks.C00641

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00641.txt"

theorem chk : chkChunk S N 52350 102 ces = true := by decide +kernel

theorem ok : RangeOK S N 52350 52452 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00641
