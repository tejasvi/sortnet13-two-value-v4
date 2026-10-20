import S13Kernel.Data.Keys

/-! Keys number 4785 to 4839. `data/c/c00081.txt` has sha256 87a444bd07d8cbc648bca1fff24a058eb522f03a4b06ff4b8c31d34f2cc80c26. -/

namespace S13K.Chunks.C00081

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00081.txt"

theorem chk : chkChunk S N 4785 55 ces = true := by decide +kernel

theorem ok : RangeOK S N 4785 4840 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00081
