import S13Kernel.Data.Keys

/-! Keys number 38080 to 38196. `data/c/c00485.txt` has sha256 f03bc779517f8b19d2b56581dd7a017d1be75f22ba3003ac70e9a21207c8a3d4. -/

namespace S13K.Chunks.C00485

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00485.txt"

theorem chk : chkChunk S N 38080 117 ces = true := by decide +kernel

theorem ok : RangeOK S N 38080 38197 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00485
