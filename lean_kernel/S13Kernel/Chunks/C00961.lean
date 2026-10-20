import S13Kernel.Data.Keys

/-! Keys number 83933 to 84055. `data/c/c00961.txt` has sha256 764c1e0bbd0a2ceae2ad767336f0fc2ec9244423956d46e99eceda6bd8e2bdbe. -/

namespace S13K.Chunks.C00961

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00961.txt"

theorem chk : chkChunk S N 83933 123 ces = true := by decide +kernel

theorem ok : RangeOK S N 83933 84056 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00961
