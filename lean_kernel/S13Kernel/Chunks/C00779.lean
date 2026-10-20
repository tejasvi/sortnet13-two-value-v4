import S13Kernel.Data.Keys

/-! Keys number 65722 to 65805. `data/c/c00779.txt` has sha256 60461a7b9e07e95027840f6b74c7c9f15e0df33d9601c37017fc1fb430eddaa6. -/

namespace S13K.Chunks.C00779

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00779.txt"

theorem chk : chkChunk S N 65722 84 ces = true := by decide +kernel

theorem ok : RangeOK S N 65722 65806 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00779
