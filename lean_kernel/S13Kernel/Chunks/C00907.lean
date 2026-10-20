import S13Kernel.Data.Keys

/-! Keys number 78393 to 78491. `data/c/c00907.txt` has sha256 8dabc58dff8b730d1fac9cbd26926cd0902e0d48d767d519262ebda4b2b40ee4. -/

namespace S13K.Chunks.C00907

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00907.txt"

theorem chk : chkChunk S N 78393 99 ces = true := by decide +kernel

theorem ok : RangeOK S N 78393 78492 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00907
