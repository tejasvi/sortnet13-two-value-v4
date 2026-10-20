import S13Kernel.Data.Keys

/-! Keys number 67707 to 67801. `data/c/c00801.txt` has sha256 9b973ffb186da040a204f524159bf83c3fbd9fc4b8bb4ad67ecdbe68c0321c2a. -/

namespace S13K.Chunks.C00801

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00801.txt"

theorem chk : chkChunk S N 67707 95 ces = true := by decide +kernel

theorem ok : RangeOK S N 67707 67802 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00801
