import S13Kernel.Data.Keys

/-! Keys number 2377 to 2418. `data/c/c00045.txt` has sha256 1852466adb484d4c1c6870a8b7478d81588f5ff761a0f8477f96c1a4686469a0. -/

namespace S13K.Chunks.C00045

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00045.txt"

theorem chk : chkChunk S N 2377 42 ces = true := by decide +kernel

theorem ok : RangeOK S N 2377 2419 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00045
