import S13Kernel.Data.Keys

/-! Keys number 27256 to 27334. `data/c/c00363.txt` has sha256 02f03cadef64a5128dacf566d8010f607b527fd2bf278fec12210a18b51efa10. -/

namespace S13K.Chunks.C00363

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00363.txt"

theorem chk : chkChunk S N 27256 79 ces = true := by decide +kernel

theorem ok : RangeOK S N 27256 27335 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00363
