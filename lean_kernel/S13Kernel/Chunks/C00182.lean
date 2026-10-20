import S13Kernel.Data.Keys

/-! Keys number 12065 to 12128. `data/c/c00182.txt` has sha256 8390a6e6ed891ea31d91673bae6293185b6b60ddc3d3dd4fe1ba8dc62275f1a1. -/

namespace S13K.Chunks.C00182

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00182.txt"

theorem chk : chkChunk S N 12065 64 ces = true := by decide +kernel

theorem ok : RangeOK S N 12065 12129 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00182
