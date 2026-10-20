import S13Kernel.Data.Keys

/-! Keys number 70042 to 70139. `data/c/c00824.txt` has sha256 2bdda809be2a997696317046d031b49a43106caf086b87be53f491e9982ab623. -/

namespace S13K.Chunks.C00824

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00824.txt"

theorem chk : chkChunk S N 70042 98 ces = true := by decide +kernel

theorem ok : RangeOK S N 70042 70140 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00824
