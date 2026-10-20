import S13Kernel.Data.Keys

/-! Keys number 67425 to 67506. `data/c/c00798.txt` has sha256 0afb0986f737013e827261958c54c93769f303292417088e85a026169c5b5d10. -/

namespace S13K.Chunks.C00798

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00798.txt"

theorem chk : chkChunk S N 67425 82 ces = true := by decide +kernel

theorem ok : RangeOK S N 67425 67507 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00798
