import S13Kernel.Data.Keys

/-! Keys number 21696 to 21769. `data/c/c00299.txt` has sha256 84a177178c1ec2a776a09266311e37803f5565f11029b487f95fe7f1cb86b34b. -/

namespace S13K.Chunks.C00299

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00299.txt"

theorem chk : chkChunk S N 21696 74 ces = true := by decide +kernel

theorem ok : RangeOK S N 21696 21770 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00299
