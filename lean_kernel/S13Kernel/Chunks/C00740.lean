import S13Kernel.Data.Keys

/-! Keys number 61931 to 62036. `data/c/c00740.txt` has sha256 7fb210934df81bb0bcc6edd7945c9930a5f6b5c3465193ef38cc15f73c527af9. -/

namespace S13K.Chunks.C00740

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00740.txt"

theorem chk : chkChunk S N 61931 106 ces = true := by decide +kernel

theorem ok : RangeOK S N 61931 62037 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00740
