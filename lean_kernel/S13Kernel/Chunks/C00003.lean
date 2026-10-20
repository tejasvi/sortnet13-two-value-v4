import S13Kernel.Data.Keys

/-! Keys number 109 to 141. `data/c/c00003.txt` has sha256 4eb15d905b45e3afc4060628d030e7f2dbd0921c12f454fd7b2ca4d45624b331. -/

namespace S13K.Chunks.C00003

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00003.txt"

theorem chk : chkChunk S N 109 33 ces = true := by decide +kernel

theorem ok : RangeOK S N 109 142 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00003
