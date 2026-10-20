import S13Kernel.Data.Keys

/-! Keys number 73127 to 73218. `data/c/c00856.txt` has sha256 ad365d38e2c61bef58aae071c5c62add382459e69008392f4b2ac67d781ed97e. -/

namespace S13K.Chunks.C00856

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00856.txt"

theorem chk : chkChunk S N 73127 92 ces = true := by decide +kernel

theorem ok : RangeOK S N 73127 73219 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00856
