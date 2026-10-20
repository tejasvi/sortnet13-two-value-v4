import S13Kernel.Data.Keys

/-! Keys number 16648 to 16744. `data/c/c00237.txt` has sha256 5b7b814f1912c23750f290ed08b5f22eb098b59302a579ae81c5ef66757de6e6. -/

namespace S13K.Chunks.C00237

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00237.txt"

theorem chk : chkChunk S N 16648 97 ces = true := by decide +kernel

theorem ok : RangeOK S N 16648 16745 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00237
