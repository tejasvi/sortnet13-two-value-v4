import S13Kernel.Data.Keys

/-! Keys number 17990 to 18082. `data/c/c00252.txt` has sha256 21a403767b1bd36f7b4dfe5ea39c5a37de362d61ac597a67f432c1a349f120ab. -/

namespace S13K.Chunks.C00252

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00252.txt"

theorem chk : chkChunk S N 17990 93 ces = true := by decide +kernel

theorem ok : RangeOK S N 17990 18083 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00252
