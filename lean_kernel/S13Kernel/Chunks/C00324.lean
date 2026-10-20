import S13Kernel.Data.Keys

/-! Keys number 23895 to 24004. `data/c/c00324.txt` has sha256 eb1bcbdf15881c60af8687d6d5d4a81b898a43ae9436fc9738fcffec13d63589. -/

namespace S13K.Chunks.C00324

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00324.txt"

theorem chk : chkChunk S N 23895 110 ces = true := by decide +kernel

theorem ok : RangeOK S N 23895 24005 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00324
