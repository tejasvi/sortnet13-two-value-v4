import S13Kernel.Data.Keys

/-! Keys number 15987 to 16084. `data/c/c00229.txt` has sha256 d3d5c840a2a1fadabd6a21234d4b3d698f15871dcfa0709f1ea87dc3487d5bf3. -/

namespace S13K.Chunks.C00229

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00229.txt"

theorem chk : chkChunk S N 15987 98 ces = true := by decide +kernel

theorem ok : RangeOK S N 15987 16085 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00229
