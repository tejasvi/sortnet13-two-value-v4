import S13Kernel.Data.Keys

/-! Keys number 2809 to 2879. `data/c/c00053.txt` has sha256 79862f138bba734241100c6ea6413594744a1de6d6d382e5fc83a15a1da68c0a. -/

namespace S13K.Chunks.C00053

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00053.txt"

theorem chk : chkChunk S N 2809 71 ces = true := by decide +kernel

theorem ok : RangeOK S N 2809 2880 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00053
