import S13Kernel.Data.Keys

/-! Keys number 96453 to 96580. `data/c/c01075.txt` has sha256 308205e90013aeba2e8e555e43a786046a2a5ca4ab2728c90c13212e7643f1bf. -/

namespace S13K.Chunks.C01075

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c01075.txt"

theorem chk : chkChunk S N 96453 128 ces = true := by decide +kernel

theorem ok : RangeOK S N 96453 96581 := rangeOK_of_chkChunk chk

end S13K.Chunks.C01075
