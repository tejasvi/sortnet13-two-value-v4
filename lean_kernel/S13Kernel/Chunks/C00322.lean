import S13Kernel.Data.Keys

/-! Keys number 23682 to 23787. `data/c/c00322.txt` has sha256 7c6e2d339190efff03e9667be00fdb9feb378743c30ec5f814028441c3b79222. -/

namespace S13K.Chunks.C00322

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00322.txt"

theorem chk : chkChunk S N 23682 106 ces = true := by decide +kernel

theorem ok : RangeOK S N 23682 23788 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00322
