import S13Kernel.Data.Keys

/-! Keys number 20993 to 21066. `data/c/c00290.txt` has sha256 65b0a65c1ebe185447b91f1d71f08dce3ccc4f31236c0ca1450c31a4b63c986c. -/

namespace S13K.Chunks.C00290

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00290.txt"

theorem chk : chkChunk S N 20993 74 ces = true := by decide +kernel

theorem ok : RangeOK S N 20993 21067 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00290
