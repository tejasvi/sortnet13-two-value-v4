import S13Kernel.Data.Keys

/-! Keys number 47861 to 47960. `data/c/c00590.txt` has sha256 1de70dba679b4420ff71f80c5d3756a1cb752d1d159122306aa87294419185c5. -/

namespace S13K.Chunks.C00590

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00590.txt"

theorem chk : chkChunk S N 47861 100 ces = true := by decide +kernel

theorem ok : RangeOK S N 47861 47961 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00590
