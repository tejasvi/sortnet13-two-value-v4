import S13Kernel.Data.Keys

/-! Keys number 28593 to 28670. `data/c/c00377.txt` has sha256 f64ac463ce781ea461bd630c44f022ce3072100029e4e4686e7e9fe57b399d55. -/

namespace S13K.Chunks.C00377

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00377.txt"

theorem chk : chkChunk S N 28593 78 ces = true := by decide +kernel

theorem ok : RangeOK S N 28593 28671 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00377
