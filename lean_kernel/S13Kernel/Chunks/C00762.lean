import S13Kernel.Data.Keys

/-! Keys number 64081 to 64171. `data/c/c00762.txt` has sha256 57971d926f4f3fff54dc731f3c9d162de2623010e03f8ac81277b861eecc3b20. -/

namespace S13K.Chunks.C00762

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00762.txt"

theorem chk : chkChunk S N 64081 91 ces = true := by decide +kernel

theorem ok : RangeOK S N 64081 64172 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00762
