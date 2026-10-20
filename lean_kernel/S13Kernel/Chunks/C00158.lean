import S13Kernel.Data.Keys

/-! Keys number 10453 to 10531. `data/c/c00158.txt` has sha256 d35e18a7f18b20bc8e7bbe080303f5912afe43c0e6e6d936b7baffcae6953d03. -/

namespace S13K.Chunks.C00158

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00158.txt"

theorem chk : chkChunk S N 10453 79 ces = true := by decide +kernel

theorem ok : RangeOK S N 10453 10532 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00158
