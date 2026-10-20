import S13Kernel.Data.Keys

/-! Keys number 52452 to 52552. `data/c/c00642.txt` has sha256 3454ad7425f5af20b51a28aea6917c1d5f5f5c1429d19fb25969b91a0f2283df. -/

namespace S13K.Chunks.C00642

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00642.txt"

theorem chk : chkChunk S N 52452 101 ces = true := by decide +kernel

theorem ok : RangeOK S N 52452 52553 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00642
