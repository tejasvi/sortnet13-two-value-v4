import S13Kernel.Data.Keys

/-! Keys number 62259 to 62371. `data/c/c00743.txt` has sha256 10dc68f607eb359cf23c45a636669ce4ea9b2220dea298fa84d6ea2270889ef5. -/

namespace S13K.Chunks.C00743

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00743.txt"

theorem chk : chkChunk S N 62259 113 ces = true := by decide +kernel

theorem ok : RangeOK S N 62259 62372 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00743
