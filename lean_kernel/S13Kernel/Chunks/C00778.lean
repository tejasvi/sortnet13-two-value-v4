import S13Kernel.Data.Keys

/-! Keys number 65640 to 65721. `data/c/c00778.txt` has sha256 b41a64f9f0845f3cdad2e7e4164fda4672bf8c1904fc19f2a8cede33d1e76d61. -/

namespace S13K.Chunks.C00778

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00778.txt"

theorem chk : chkChunk S N 65640 82 ces = true := by decide +kernel

theorem ok : RangeOK S N 65640 65722 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00778
