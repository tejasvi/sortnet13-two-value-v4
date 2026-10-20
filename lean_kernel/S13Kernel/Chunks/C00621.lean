import S13Kernel.Data.Keys

/-! Keys number 50541 to 50630. `data/c/c00621.txt` has sha256 4a8e02ff7e01ce66f393be4a7dff9e49aee73d62d97713846142f12e1ef0266a. -/

namespace S13K.Chunks.C00621

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00621.txt"

theorem chk : chkChunk S N 50541 90 ces = true := by decide +kernel

theorem ok : RangeOK S N 50541 50631 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00621
