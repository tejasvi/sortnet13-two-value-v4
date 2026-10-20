import S13Kernel.Data.Keys

/-! Keys number 34430 to 34486. `data/c/c00444.txt` has sha256 839d8a72c364171ecc4a30135450b335f72f7db65114688b15c772681d203516. -/

namespace S13K.Chunks.C00444

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00444.txt"

theorem chk : chkChunk S N 34430 57 ces = true := by decide +kernel

theorem ok : RangeOK S N 34430 34487 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00444
