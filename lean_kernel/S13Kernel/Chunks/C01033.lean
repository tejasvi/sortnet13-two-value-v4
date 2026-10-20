import S13Kernel.Data.Keys

/-! Keys number 91701 to 91802. `data/c/c01033.txt` has sha256 e25a56eb612ca63654ae11bd21f3da920e8742277a95c796340fb860b1322938. -/

namespace S13K.Chunks.C01033

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c01033.txt"

theorem chk : chkChunk S N 91701 102 ces = true := by decide +kernel

theorem ok : RangeOK S N 91701 91803 := rangeOK_of_chkChunk chk

end S13K.Chunks.C01033
