import S13Kernel.Data.Keys

/-! Keys number 87676 to 87778. `data/c/c00997.txt` has sha256 00ab47aef7b3e4d6aa8e2fc1b7a1690005246e9ed439e32359ae0276dadd3d3e. -/

namespace S13K.Chunks.C00997

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00997.txt"

theorem chk : chkChunk S N 87676 103 ces = true := by decide +kernel

theorem ok : RangeOK S N 87676 87779 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00997
