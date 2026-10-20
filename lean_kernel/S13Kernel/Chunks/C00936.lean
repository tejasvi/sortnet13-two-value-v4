import S13Kernel.Data.Keys

/-! Keys number 81329 to 81416. `data/c/c00936.txt` has sha256 5274ee1ef9ed494dd91b633ada8892e8f744881d19ee88ce02d48325343a6e27. -/

namespace S13K.Chunks.C00936

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00936.txt"

theorem chk : chkChunk S N 81329 88 ces = true := by decide +kernel

theorem ok : RangeOK S N 81329 81417 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00936
