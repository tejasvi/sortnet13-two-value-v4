import S13Kernel.Data.Keys

/-! Keys number 24360 to 24444. `data/c/c00329.txt` has sha256 964951344aa3dd6ff862fb0b9a908b35e833460ed2d51ea03729b3dfda011675. -/

namespace S13K.Chunks.C00329

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00329.txt"

theorem chk : chkChunk S N 24360 85 ces = true := by decide +kernel

theorem ok : RangeOK S N 24360 24445 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00329
