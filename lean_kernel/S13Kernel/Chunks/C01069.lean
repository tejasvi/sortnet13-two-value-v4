import S13Kernel.Data.Keys

/-! Keys number 95730 to 95851. `data/c/c01069.txt` has sha256 f02fd6f95f3094a8374d0f9c32d496da49c5a12fd2cab756c5cd518a68fdc574. -/

namespace S13K.Chunks.C01069

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c01069.txt"

theorem chk : chkChunk S N 95730 122 ces = true := by decide +kernel

theorem ok : RangeOK S N 95730 95852 := rangeOK_of_chkChunk chk

end S13K.Chunks.C01069
