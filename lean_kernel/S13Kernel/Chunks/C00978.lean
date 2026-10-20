import S13Kernel.Data.Keys

/-! Keys number 85736 to 85838. `data/c/c00978.txt` has sha256 8635fdd24eb22c7de33f7c28fc845472ba61efbc076b15a4caccb6257a68acac. -/

namespace S13K.Chunks.C00978

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00978.txt"

theorem chk : chkChunk S N 85736 103 ces = true := by decide +kernel

theorem ok : RangeOK S N 85736 85839 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00978
