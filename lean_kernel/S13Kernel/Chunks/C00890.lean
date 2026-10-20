import S13Kernel.Data.Keys

/-! Keys number 76622 to 76726. `data/c/c00890.txt` has sha256 12b248139ba78e8cdb67a697c465636bc3eedb27111ba0c78310070fe3cc9936. -/

namespace S13K.Chunks.C00890

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00890.txt"

theorem chk : chkChunk S N 76622 105 ces = true := by decide +kernel

theorem ok : RangeOK S N 76622 76727 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00890
