import S13Kernel.Data.Keys

/-! Keys number 68087 to 68194. `data/c/c00805.txt` has sha256 412369af5d3f9eb881d4972f56fbc3a512c810d998ebd895fe1e8e64ab70a3dc. -/

namespace S13K.Chunks.C00805

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00805.txt"

theorem chk : chkChunk S N 68087 108 ces = true := by decide +kernel

theorem ok : RangeOK S N 68087 68195 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00805
