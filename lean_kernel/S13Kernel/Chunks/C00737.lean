import S13Kernel.Data.Keys

/-! Keys number 61621 to 61724. `data/c/c00737.txt` has sha256 afe1ef5e983691e0288eb3c896f6ffbc40444eea374fcce315942b6261084cd9. -/

namespace S13K.Chunks.C00737

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00737.txt"

theorem chk : chkChunk S N 61621 104 ces = true := by decide +kernel

theorem ok : RangeOK S N 61621 61725 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00737
