import S13Kernel.Data.Keys

/-! Keys number 35737 to 35836. `data/c/c00460.txt` has sha256 319f9fd31e058a557b7c7e611d522f19063a51a4ca42aeb0da1bfbe498017bbe. -/

namespace S13K.Chunks.C00460

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00460.txt"

theorem chk : chkChunk S N 35737 100 ces = true := by decide +kernel

theorem ok : RangeOK S N 35737 35837 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00460
