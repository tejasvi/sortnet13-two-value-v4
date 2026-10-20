import S13Kernel.Data.Keys

/-! Keys number 72939 to 73037. `data/c/c00854.txt` has sha256 86307d5fe51c3e9652ad0a53c6bb40703c17efa38b8e7d606e42cf02898c3760. -/

namespace S13K.Chunks.C00854

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00854.txt"

theorem chk : chkChunk S N 72939 99 ces = true := by decide +kernel

theorem ok : RangeOK S N 72939 73038 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00854
